function [tempgrid,marshvol] = bayevolution(icrest,tempgrid,t,j,TP)

global celldim;
global SL;
global zcentroids;
global L;

%%% ACCRETION
% Accrete the bay
[q_b] = getbaysedflux(t,j); % Volume of sediment added to the bay from bay sed flux
mwl = SL(t,j); % Mean Water Level - the minimum depth at which the marsh will grow
tempvol = q_b * TP(t); 
baycell = 0; % Initiate estcell to count the number of bay cells to be accreted onto

for ii = icrest : L
    % Find all topcells underneath Sea Level
    realratio = sum(tempgrid(ii,:,:),3); % the fraction of sediment in each cell of the column at the limit of the dune
    topcell = find(realratio == 1); % find the first full cell
    topcell = topcell(1) - 1; % the boundary cell that is partially filled or empty

    k=topcell;
    cellfill = sum(tempgrid(ii,k,:),3); % fraction of sediment in the topcell
    H =(zcentroids(k) - celldim(3,j)./ 2) + cellfill*celldim(3,j); % height to the topcell
        
    if H <= mwl
        baycell = baycell + 1; % Count the number of bay cells below sea level
    end  
    ii = ii + 1;
end

% Calculation of accretion height
targvol = tempvol / baycell; % Distribute the riverine input of sediment over each baycell
estrate = targvol / celldim(1,j); % Height to which each baycell can be accreted

%%% EROSION
% Erode the bay (everything below MSL)
[bayerosion] = getbayerosion(t,j); % Maximum rate erosion for the bay
tE = bayerosion*TP(t)/1000; % Maximum depth to which a surface can be eroded during a single time step
actualerosion = 0; % Initialize actual erosion, for the actual volume of material that is eroded
[resuspensionelevation] = getresuspensionelevation(t,j); % The depth below which the bay can no longer be eroded

for ii = icrest :L
    % Find the top horizon of the bay
    realratio = sum(tempgrid(ii,:,:),3); % The amount of sediment in a cell
    topcell = find(realratio == 0, 1, 'last' ); 
    topcell = topcell + 1; % The first cell with sediment

    k = topcell;
    realratio = sum(tempgrid(ii,k,:),3); % The amount of sediment in the topcell
    
    H =(zcentroids(k) - celldim(3,j) ./ 2) + realratio*celldim(3,j);
    depth = SL(t,j)-H; % Depth to the surface of the bay

    % Calculation of erosion height
    toperosion = tE * (resuspensionelevation - depth)/resuspensionelevation; % Amount of erosion weighted by depth
    
    % Find the uppermost layer of pure sand
    realsandratio = tempgrid(ii,:,1); % The amount of sand in a cell
    topsandcell = find(realsandratio ~= 0, 1, 'last' );
    topsandcell = topsandcell - 1;
      
    ksand = topsandcell;
    realsandratio = tempgrid(ii,ksand,1); % The amount of sand in the topcell
    
    Hsand =((zcentroids(ksand) - celldim(3,j)) ./ 2) + realsandratio*celldim(3,j);
    depthsand = SL(t,j)-Hsand; % Depth to the surface of the sand horizon

    if toperosion > depthsand - depth
        toperosion = depthsand - depth;
    end
    

    if depth > resuspensionelevation % If the the bay is already deeper than resuspension depth, there is no erosion
        toperosion = 0;
    elseif depth + toperosion > resuspensionelevation  % If erosion over the time step is too large, set depth equal to resuspention depth
        toperosion = resuspensionelevation - depth;
    end

    temperosion = toperosion;
    
    % Calculation of effective height change
    
    dheight = estrate - toperosion;
    if dheight > 0
        tempgrid = deposition(tempgrid,t,ii,j,dheight);
    end
    
    if depth >= 0 & depth < resuspensionelevation
        [actualerosion,tempgrid] = erosion(actualerosion,tempgrid,t,ii,j,k,dheight,temperosion);
    end
end

marshvol = actualerosion / 2;

if baycell <= 2
    marshvol = tempvol/2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%