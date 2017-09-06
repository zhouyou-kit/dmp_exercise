testparas = paras;
testparas.dt = 0.001;
testparas.y0 = trajData(1,2:end);
testparas.dy = [0,0];
testparas.goals = trajData(end,2:end);
testparas.scaling = (testparas.goals - testparas.y0) ./ paras.original_scaling;
testparas.tau = 1;

testparas.extForce = [0.2,0.01,0,0];


testTraj = dmptest(Ws, testparas);

mdl_twolink;
q = [0,0];
M = [1,0,1,0,0,0];
qtraj = [];
for i = 1 : 20 : size(testTraj,1)
    goal_transform = transl(testTraj(i,2), 0, testTraj(i,3)) * trotx(pi);
    q = twolink.ikine(goal_transform,q,M);
    qtraj = [qtraj;q];
end

if ~isempty(f1)
    f1 = figure;
    axis([-2 2 -2 2]);
    hold on;
    plot(trajData(:,2), trajData(:,3), 'b-');
end
figure(f1)
hold on;
plot(testTraj(:,2), testTraj(:,3), 'r--');

if ~isempty(f2)
    f2 = figure;
end

figure(f2);
hold off;
twolink.plot(qtraj, 'jointdiam', 0.5, 'scale', 1,'view', 'x', 'noname', 'noshading', 'noshadow', 'nobase','nowrist','notiles','trail','r-');
disp('finished')
