function target = mdlFindTargetProbabilistic(startstate, imagevector)
% mdlFindTarget is a function that takes a startstate and imagevector
% then choses a random asyncrhonous evolution.
    target = startstate;
    diff = startstate == imagevector;
    indDiff = find(diff(:)==0);
    
    global mdl_prob_mat_HPA_HPG_2_8;
    
    if isempty(indDiff)
        return
    end
    
    indRand = ceil(rand * size(indDiff,1));
    changeInd = indDiff(indRand);
    
    didwork = mdl_prob_mat_HPA_HPG_2_8(changeInd)>rand(1);
    
    if startstate(changeInd) < imagevector(changeInd) && didwork
        target(changeInd) = target(changeInd) + 1;
    elseif startstate(changeInd) > imagevector(changeInd) && didwork
        target(changeInd) = target(changeInd) - 1;
    end
end