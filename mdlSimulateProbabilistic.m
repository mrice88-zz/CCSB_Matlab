function path = mdlSimulateProbabilistic(pathlength,start)
% mdlSimulate is a function that takes a model, an integer pathlength "i.e. 20"  
% and probability matrix, and startstate, RETURNS a path matrix.
    
    %Number of steps to evolve
    pathlen = pathlength;
    
    % Startstate
    startstate = start;
    
    % preallocate path for speed
    path = zeros(size(startstate,1),pathlength+1);
    
    % start with the path containing startstate, apply rules to find
    % image vector of state, then pick random async. change. Repeat n
    % number of times, based on path length provided.
    path(:,1) = startstate;
    currentstate = startstate;
    
    for i=1:pathlen
        imagevector = mdlApplyRules(currentstate);
        currentstate = mdlFindTargetProbabilistic(currentstate, imagevector);

         path(:,i+1) = currentstate;      
    end    
end

