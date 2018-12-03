global exercise_id

testparas = paras;
testparas.dt = 0.001;

%% play with the parameters
% start_offset: [dx, dy] changes the start point relative to the training 
% trajectory
start_offset = [0,0];
% goal offset: [dx, dy] changes the goal point relative to the training
% trajectory
goal_offset = [0,0];
speed = 1;
% external_force: [t0, t1, force_x, force_y] exert force on the TCP of the 
% robot in time period [t0, t1]
external_force = [0,0,0,0]; 


%% set test parameters
alpha_phaseStop = 10;
testparas.y0 = trajData(1,2:end) + start_offset;
testparas.dy = [0,0];
testparas.goals = trajData(end,2:end) + goal_offset;
testparas.tau = 1/speed;
testparas.ac = alpha_phaseStop;

if exercise_id == 3
    testparas.extForce = external_force;
else
    testparas.extForce = [0,0,0,0];
end


testTraj = dmptest(Ws, testparas);

figure
axis([-2 2 -2 2]);
hold on;
tr = plot(trajData(:,2), trajData(:,3), 'b-', 'LineWidth', 2);
te = plot(testTraj(:,2), testTraj(:,3), 'r-.', 'LineWidth', 2);
legend([tr, te], {'Training Trajectory', 'Test Trajectory'})

figure
axis([0 1 -2 2]);
hold on
xp = plot(testTraj(:,1), testTraj(:,2), 'g-', 'LineWidth', 2);
yp = plot(testTraj(:,1), testTraj(:,3), 'm-', 'LineWidth', 2);
legend([xp,yp], {'x-axis', 'y-axis'})
