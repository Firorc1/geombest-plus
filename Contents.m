% PROGRAM
%
% Files
%   GreaterOrEqual               - approx -- Tests whether x is greater than or equal to y, with  
%   MakeQTMovie                  - function MakeQTMovie(cmd, arg, arg2)
%   OWstring                     - Run mainstring for a range of Overwash values (m3/yr) from OW1 to OW2, and
%   Overwash                     - Overwash -- Infills the backbarrier via overwash and tidal inlet
%   RIstring                     - Run mainstring for a range of RivInput and RSLR values, initially varying
%   Sweepshoreface               - Sweepshoreface -- Scans the shoreface section of tempgrid to find cells
%   accrete                      - accrete -- accretes a single cell(x) within tempgrid. 
%   backbarrierinfill            - Backbarrierinfill --
%   buildgrid                    - buildgrid -- populates gridstrat (2,x,y,z,s) where 2 is the
%   buildmat                     - Builds a matrix of marsh and shoreline migration rates for a variable set
%   calc_barriervolume_km        - Function to calculate and print to screen the barrier volume/m from the 
%   calc_barriervolume_m         - Function to calculate and print to screen the barrier volume/m from the 
%   calc_barriervolume_m_initial - Function to calculate and print to screen the barrier volume/m from the 
%   calc_bbwidth                 - marsh_width = zeros(1,4);
%   createlegend                 - (AXES1)
%   customplot                   - plotblackwhite -- plots a raster representation of the tract, superimposed with a surface line,for 
%   deposition                   - Accrete using estuary sediment
%   dunebuild                    - Dunebuild -- Infills the backbarrier via dunebuilding
%   email                        - Define these variables appropriately:
%   erode                        - erode -- erodes a single cell(x) within gridstrat. Erosion depth is limited
%   erosion                      - 
%   estaccrete                   - Accrete the estuary
%   esterode                     - Erode the estuary (everything below MSL)
%   estuaryevolution             - ACCRETION
%   findmarshboundary            - Determines the x location of the marsh boundary of each tract at each time step (t)
%   findshoreline                - 
%   getbbvol                     - getbbvol -- reads runfiles and returns the backbarrier volume
%   getbbwidth                   - getbbwidth -- reads runfiles and returns the backbarrier width
%   getesterosion                - getesterosion -- reads runfiles and returns the estuarine erosion rate range entry appropriate for the timestep (t). 
%   getestrate                   - getestrate -- reads runfiles and returns the estuarine
%   getestvol                    - getestvol -- reads runfiles and returns the estuarine
%   getexovol                    - getexovol -- reads runfiles and returns the exovol entry 
%   gethighwater                 - gethighwater -- reads runfiles and returns the highwater tide range entry appropriate for the timestep (t). 
%   getoverwashrate              - getoverwashrate -- reads runfiles and returns the backbarrier overwash volume for the timestep (t). 
%   getoverwashvol               - getoverwashvol -- reads runfiles and returns the backbarrier overwash volume for the timestep (t). 
%   getresuspensionelevation     - getresuspensionelevation -- reads runfiles and returns the 
%   getrivinput                  - getrivinput -- reads runfiles and returns the input of riverine sediment 
%   growmarsh                    - Growmarsh -- fills the left and right-most shallow cells in the estuary
%   initcrest                    - initcrest -- 
%   loadrate                     - loadrate -- reads an excel files containing the depth-dependant response rate 
%   loadrate1                    - loadrate -- reads an excel files containing the depth-dependant response rate 
%   loadrunfiles                 - loadrunfiles -- reads data from the run# excel files
%   loadrunfiles1                - loadrunfiles -- reads data from the run# excel files
%   loadstrat                    - loadstrat -- reads data tract# excel files and populates the strat
%   loadstrat1                   - loadstrat -- reads data tract# excel files and populates the strat
%   main                         - [equil surface] = main(filethread) 
%   main2                        - [equil surface] = main(filethread) 
%   mainRIstring                 - Run mainstring for a range of RivInput values, initially varying
%   mainstring                   - For running multiple input files in a row, from the first input file you
%   makeframes                   - makeframes -- Creates matlab figures from GEOMBEST timesteps
%   makeframesnorthcarolina      - makeframes -- Creates matlab figures from GEOMBEST timesteps
%   makeframesnorthcarolina2     - makeframes -- Creates matlab figures from GEOMBEST timesteps
%   makeframeswashington         - makeframes -- Creates matlab figures from GEOMBEST timesteps
%   marshrun                     - Save the failed runs to the failed runs file
%   migratevs                    - Plots migration rate for marsh and shoreline together for comparison
%   modernrerun                  - Re-running simulations for first two Overwash values, for no marsh
%   modernrun                    - Run main program for range of RivInput, Overwash, RSLR, and initial
%   overwash1                    - Overwash1 -- Spreads a fixed volume of sand over the backbarrier, from
%   phaseSLvsOW                  - Plot a phase diagram showing whether marsh progradation is less than,
%   phaseSLvsRI                  - Plot a phase diagram showing whether marsh progradation is less than,
%   plotMARSHtract               - Performs plottractcolour for a simulation run with a given Riverine Input
%   plotMODtract                 - Performs plottractcolour for a simulation run with a given Overwash (OW), Riverine Input
%   plotOWshore                  - Function to create, plot and output an array of time step and shoreline
%   plotOWtract                  - Performs plottractcolour for a simulation run with a given Overwash
%   plotRItract                  - Performs plottractcolour for a simulation run with a given Riverine Input
%   plotRItractmov               - Performs plottractmov for a simulation run with a given Riverine Input
%   plotblackwhite               - plottract -- plots a raster representation of the tract, superimposed with a surface line  
%   plotblackwhite2              - plotblackwhite -- plots a raster representation of the tract, superimposed with a surface line,for 
%   plotcrosssteps               - plottract -- plots a raster representation of the tract, superimposed with a surface line  
%   plotcrossstepsback           - plottract -- plots a raster representation of the tract, superimposed with a surface line  
%   plotlmarshedge               - Function to create, plot and output an array of time step and marsh edge
%   plotlmarshratevsRSLR         - Plot the progradation rate of the left marsh boundary as a function of
%   plotmarshedge                - Function to create, plot and output an array of time step and marsh edge
%   plotmarshvs                  - Function to compare marsh progradation rates rates from multiple runs
%   plotmarshvsRSLR_RI           - Function to compare marsh progradation rates from runs varied for RSLR and RI
%   plotratevsSLR                - Plots migration rate for marsh and shoreline together for comparison
%   plotshore                    - Function to create, plot and output an array of time step and shoreline
%   plotshoreevs                 - Function to compare shoreline migration rates from multiple runs
%   plotshorevs                  - Function to compare shoreline migration rates from multiple runs
%   plotsurface                  - Function to create, plot and output (eps and jpg) the surface at the first 
%   plottempgrid                 - plottract -- plots a raster representation of the tempgrid, superimposed with a surface line  
%   plottractcolour              - plottract -- plots a raster representation of the tract, superimposed with a surface line  
%   plottractmov                 - If the movie has already been made, play it
%   poptop                       - poptop -- populates cells within the grid which are intersected by the stratigraphic horizons 
%   rename                       - deletes the files of failed runs in 0modern
%   renamed                      - function to rename a large group of files in a given directory
%   saveblock                    - filethread = filethread % outputs filethread to base workspace
%   savedata                     - savedata -- saves shorelines and the global variables required for
%   savepartialrun               - Running this file before closing the workspace after a GEOMBEST run that 
%   savetimestep                 - savetimestep -- saves a file called step_'t' which is the stratigraphic data 
%   setcrest                     - setcrest -- updates equil by shifting the x values by the distance
%   shorefacedisequilibrium      - shorefacedisequilibrium -- calculates the volume that the shoreface is out of equilibrium
%   shoreplot                    - Function to create, plot and output an array of time step and shoreline
%   solvecross                   - solvecross -- searches for the location of the shoreface profile that satisfies all paramater values 
%   stormdeposit                 - Overwash1 -- Spreads a fixed volume of sand over the backbarrier, from
%   stormgen                     - StormGen stochastically generates storm deposits for a given time step
%   stormplot                    - Plots the frequency distribution of different storms
%   strattally                   - strattally -- tallys the sediment volumes for each stratigraphic unit 
%   xlrewrite                    - Takes a matrix from one excel spreadsheet (filethread1) and copies it into a string of
%   xlrewrite_5_15               - x(:,:) = 0/0;
