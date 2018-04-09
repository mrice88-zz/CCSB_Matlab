function imagevector = mdlApplyRules(startstate)
% mdlApplyRules is a function that takes a model and a starting state, and
% applies ternary logic rules, and returns its image vector.
    global mdl_HPA_HPG_2_8;
    global tern_hi_lo_pass;
    global tern_not;
    global tern_or;
    
    names = fieldnames(mdl_HPA_HPG_2_8);
    imagevector = zeros(size(startstate)) + 2;
    
    for i=1:(size(names)-1)
        promoters = mdl_HPA_HPG_2_8.(names{i})(1,:);
        inhibiters = mdl_HPA_HPG_2_8.(names{i})(2,:);
        
        % If image vector node is neutral
        if  isnan(promoters(1)) == 1 && isnan(inhibiters(1)) == 1
            
        % Node only has promoters, eq 3
        elseif isnan(promoters(1)) == 0 && isnan(inhibiters(1)) == 1        
            hi = 1;
        
            for j=1:sum(~isnan(promoters))
                hi = tern_or(startstate(promoters(j)),hi);
            end
            imagevector(i) = hi;
        
        % Node only has inhibiters, eq4
        elseif isnan(promoters(1)) == 1 && isnan(inhibiters(1)) == 0
        
            % OR all inhibitors
            lo = 1;
            for j=1:sum(~isnan(inhibiters))
                lo = tern_or(startstate(inhibiters(j)),lo);
            end
            
            % NOT'd value of OR'd inhibitors
            imagevector(i) = tern_not(lo);
        
        % equation 2 - node has both promoters and inhibitor    
        elseif isnan(promoters(1)) == 0 && isnan(inhibiters(1)) == 0
            
            % OR all the promotors
            hi = 1;
            for j=1:sum(~isnan(promoters))
               temp = startstate(promoters(j));
               hi = tern_or(temp,hi); 
            end
            
            % OR all inhibitors
            lo = 1;
            for j=1:sum(~isnan(inhibiters))
                lo = tern_or(startstate(inhibiters(j)),lo);
            end
            
            % hi/lo pass of OR'd promoters and OR'd inhibitors
            imagevector(i) = tern_hi_lo_pass(hi,lo);
            
        end
    end
end
