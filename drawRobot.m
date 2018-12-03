fps = 400;

mdl_twolink;
q = [0,0];
M = [1,0,1,0,0,0];
qtraj = [];
t = 0;
dt = 0.001;

idxs = 1 : size(testTraj,1);
while t < testTraj(end, 1)
    ids = testTraj(:,1) > t;
    ids = abs(diff(ids)) == 1;
    idx = idxs(ids);
    goal_transform = transl(testTraj(idx,2), 0, testTraj(idx,3)) * trotx(pi);
    q = twolink.ikine(goal_transform,q,M);
    qtraj = [qtraj;q];
    t = t + dt;
end

figure;
hold off;
twolink.plot(qtraj, 'jointdiam', 0.5, 'scale', 1,'view', 'x', 'noname', 'noshading', 'noshadow', 'nobase','nowrist','notiles','trail','r-','fps', fps);
disp('finished')
