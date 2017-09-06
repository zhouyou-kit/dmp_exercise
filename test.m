global exercise_id

testparas = paras;
testparas.dt = 0.001;

% play with the parameters
start_offset = [0,0];
goal_offset = [0,0];
speed = 1;
external_force = [0,0,0,0];
alpha_phaseStop = 20;


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

if ~isempty(f1)
    f1 = figure;
    axis([-2 2 -2 2]);
    hold on;
    plot(trajData(:,2), trajData(:,3), 'b-');
end
figure(f1)
hold on;
plot(testTraj(:,2), testTraj(:,3), 'r--');


