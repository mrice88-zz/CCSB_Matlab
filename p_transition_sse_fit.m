function [est_params, fval, best_path,meas_data] = p_transition_sse_fit(meas_data, p_params_0)

global mdl_prob_mat_HPA_HPG_2_8;

% First guess for params
if isempty(p_params_0)
    p_params_0 = rand(15,1);
end


if isempty(meas_data)
    meas_data=[];
    num_nodes=15;
    t=1:300;
    
    for i=1:num_nodes
        meas_data_k=exp(((-(t-100.*rand).^2)./(rand.*30).^2));
        meas_data = [meas_data; meas_data_k.*2+1];
    end
    
end

% call optimality fitness fucntion (sum squared error fit to data)
f = @(p_params)ss_sq_err_sim(p_params,meas_data);

% A)  Constrained gradient
%    x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)

options = optimset('Algorithm','interior-point ','MaxIter',1000, 'TolFun',10);

% Upper bounds
ub  = ones(1,num_nodes);
% Lower bounds
lb = zeros(1,num_nodes); % 

A=[]; b=[];

[est_params,fval] = fmincon(f,p_params_0,A,b,[],[],lb,ub,[],options);
    
%Set Global variable to estimated params.
mdl_prob_mat_HPA_HPG_2_8 = est_params;

%Determine pathlength and 
pathlength=size(meas_data,2)-1;
start=ceil(rand(15,1).*3);

best_path = mdlSimulateProbabilistic(pathlength,start);



