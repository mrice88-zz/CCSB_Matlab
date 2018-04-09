function pathl = mdlTreamentSimulation(startstate,treatmentvector,numtreatments,delaysteps,naturalevolutionsteps)

%global mdl_HPA_HPG_2_8;
treatvec = treatmentvector;
ss = startstate;
tempss = ss;
numtreat = numtreatments;
delay = delaysteps;
naturalevo = naturalevolutionsteps;
pathl = ss;

% Loop the number of treatments
for i=1:numtreat
    % Apply all of the treatments in vector
    for j=1:size(treatvec,1)
        %If it calls to increase at index in j, 
        if(treatvec(j,2) == 2)
            % Validate that it isnt already maxed out
            if(tempss(treatvec(j)) ~= 3)
                tempss(treatvec(j)) = tempss(treatvec(j)) + 1;
            end
        %If it calls to decrease at index in j, decrease  
        elseif(treatvec(j,2) == 1)
            % Validate that it isnt already minimum.
            if(tempss(treatvec(j)) ~= 1)
                tempss(treatvec(j)) = tempss(treatvec(j)) - 1;
            end
        end
    end
    
    %Find a better solution.
    tpath = mdlSimulateProbabilistic(delay,tempss);
    pathl = [pathl tpath(:,2:end)];
    
    %set tempss to last element of path
    tempss = pathl(:,end);
end

%Finish with natural evolution
tpath = mdlSimulateProbabilistic(naturalevo,tempss);
pathl = [pathl tpath(:,2:end)];

end