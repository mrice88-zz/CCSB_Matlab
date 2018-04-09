function f=ss_sq_err_sim(meas_data)

% Run simulaitons using the p_params

% make start random for now - CHANGE THIS
start=ceil(rand(15,1).*3);

pathlength=size(meas_data,2)-1;

path = mdlSimulateProbabilistic(pathlength, start);

% Compare simulation path to actual path in meas_data
sse = sum((path-meas_data).^2,2);
f=sqrt(max(sse));


