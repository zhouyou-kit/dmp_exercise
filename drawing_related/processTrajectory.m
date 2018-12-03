function trajData = processTrajectory( trajectory , endTime, timeStep)

if nargin < 2
    endTime = 1.0;
    timeStep = 0.001;
end

trajectory = [trajectory; repmat(trajectory(end,:),20,1)];

dt = timeStep;
trajData(:,1) = [0:timeStep:endTime]';
for ID = 1 : size(trajectory,2)
    traj = trajectory(:,ID);
    nsample = 0 : dt : length(traj) * dt - dt;
    nnsample = 0 : (length(traj) * dt - dt) / (1/dt) : length(traj) * dt - dt;
    trajData(:,ID+1) = interp1(nsample, traj, nnsample)';
end

end

