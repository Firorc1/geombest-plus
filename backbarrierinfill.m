function [dunevol,tempgrid,ii] = backbarrierinfill (tempgrid,t,j,icrest,shorewidth)

% Backbarrierinfill --
% 1) Infills the backbarrier via overwash, riverine input, and marsh accretion
% 2) Updates tempgrid

% Dr David Stolper dstolper@usgs.gov

% Version of 02-Jan-2003 10:47
% Updated    08-Apr-2003 4:47
% Updated DW - 22-Jun-2012

global TP;
global SL;
global stormcount;

% Build the back-half of the dune up to the equilibrium morphology
[dunevol,tempgrid] = dunebuild (tempgrid,icrest,t,j,shorewidth);

if t==1
    SLT0 = 0;
    SLT = SL(t);
else
    SLT0 = SL(t-1);
    SLT  = SL(t);
end

% Calculation of the characteristic erosion time
[bayerosion] = getbayerosion(t,j); % Maximum rate erosion for the bay
[resuspensionelevation] = getresuspensionelevation(t,j); % The depth below which the esuary can no longer be eroded
terode = resuspensionelevation / bayerosion * 1000; % Critical time for erosion, in years

if bayerosion > 0
    dn = ceil(TP(t)*5 / terode); % Time step should be 5 times smaller than the critical time
else
    dn = 10;
end

for tt = 1:dn % Run smaller loop
    dTP(t) = TP(t) / dn;
%     [t tt]

    SL(t) = SLT0 + (SLT - SLT0)*tt/dn;
    
    % Update the bay surface and calculate volume of sediment eroded
    [tempgrid,marshvol] = bayevolution(icrest,tempgrid,t,j,dTP);
    
    % Grow the marsh at the left and right boundaries of the bay
    [tempgrid] = growmarsh (tempgrid,marshvol,t,j,tt);
end

%%%%%%Commented code below used for stochastic variability in overwash
%%%%%%events, representing storms of different sizes and probabilities
% Read in the parameter for overwash volume (m^3/m)
% [q_ow] = getoverwashflux(t,j); % Volume of sand to be deposited as overwash
    
% Initiate variable to hold the number of each level of storm
stormcount = zeros(1,5);

% if q_ow < 2    
%     % Generate storms for the given timestep
%     [q_ow,overwashlength,overwashthickness,stormcount] = stormgen(TP,q_ow,stormcount,t,j);
% 
%     % Deposit overwash flats over bay/marsh
%     [tempgrid,ii] = stormdeposit(tempgrid,j,t,q_ow,overwashlength,overwashthickness); %overwash(tempgrid,j,t);
% else
    [tempgrid,ii] = overwash(tempgrid,j,t);
% end
