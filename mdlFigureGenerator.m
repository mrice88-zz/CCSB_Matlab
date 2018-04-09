global mdl_HPA_HPG_2_8;
mdlNames = fieldnames(mdl_HPA_HPG_2_8);

figure
subplot(3,1,1);
plot(treatsim(1:6,:)')
title('Stress Response Axis')
legend(mdlNames(1:6))
axis([1 size(treatsim,2) 0 4])
subplot(3,1,2);
plot(treatsim(7:12,:)')
legend(mdlNames(7:12))
axis([1 size(treatsim,2) 0 4])
title('Immune Response Axis')
subplot(3,1,3);
plot(treatsim(13:15,:)')
legend(mdlNames(13:15))
axis([1 size(treatsim,2) 0 4])
title('Sex Hormone Response Axis')