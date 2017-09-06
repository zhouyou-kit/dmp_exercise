global exercise_id;
% 1: general dmp formulation
% 2: new dmp formulation with goal change
% 3: add tracking system and phase stopping

exercise_id = 3;

trajData = processTrajectory(trajectory);

rbf_num = 500;
dc = 1 / (rbf_num -1 );
centers = 1:-dc:0;
paras.kernelfcn = createKernelFcn(centers, 1);
paras.D = 200;
paras.K = paras.D^2/4;
paras.tau = 1;
paras.ax = -3;
paras.original_scaling = trajData(end,2:end) - trajData(1,2:end) + 1e-5;
Ws = dmptrain(trajData,paras);

