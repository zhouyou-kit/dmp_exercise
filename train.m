trajData = processTrajectory(trajectory);

rbf_num = 100;
dc = 1 / (rbf_num -1 );
centers = 1:-dc:0;
paras.kernelfcn = createKernelFcn(centers, 1);
paras.D = 100;
paras.K = paras.D^2/4;
paras.tau = 1;
paras.ax = -1;
paras.original_scaling = trajData(end,2:end) - trajData(1,2:end);
Ws = dmptrain(trajData,paras);


f2 = figure;