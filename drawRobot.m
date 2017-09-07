sample_Step = 10;

mdl_twolink;
q = [0,0];
M = [1,0,1,0,0,0];
qtraj = [];
for i = 1 : sample_Step : size(testTraj,1)
    goal_transform = transl(testTraj(i,2), 0, testTraj(i,3)) * trotx(pi);
    q = twolink.ikine(goal_transform,q,M);
    qtraj = [qtraj;q];
end


figure;
hold off;
twolink.plot(qtraj, 'jointdiam', 0.5, 'scale', 1,'view', 'x', 'noname', 'noshading', 'noshadow', 'nobase','nowrist','notiles','trail','r-');
disp('finished')
