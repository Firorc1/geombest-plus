function [bayerosion] = getbayerosion(t,j)

% getbayerosion -- reads runfiles and returns the bay erosion rate range entry appropriate for the timestep (t). 
% This function is necessary beacuse runfiles considers only 
% whole steps while t is comprised of wholesteps(entered by the user)
% and a number of substeps specified by the user 

% Dr David Stolper dstolper@usgs.gov

% Version of 30-Jan-2003 17:03
% Updated    30-Jan-2003 17:03
% DW - Updated 22-Jun-2012



global T;
global runfiles;

substeps = T ./ size(runfiles(j).bayerosion,2);

for a = 1:T ./ substeps    
    if t <= a .* substeps
        bayerosion = runfiles(j).bayerosion(a);
        break;
    end    
end