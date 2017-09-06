function traj = dmptest(w, paras)

kernelfcn = paras.kernelfcn;
goals = paras.goals;
tau = paras.tau;
dt = paras.dt;
K = paras.K;
D = paras.D;
y = paras.y0;
dy = paras.dy;

if ~isfield(paras,'scaling')
    scaling = 1;
else
    scaling = paras.scaling;
end

if ~isfield(paras, 'extForce')
    extForce = [0,0,0,0];
    isDisturbance = true;
else
    extForce = paras.extForce;
    isDisturbance = false;
end

u = 1;

id = 1;    
yreal = y;
dyreal = dy;
Y(id,:) = yreal;
timestamps(id) = 0;
t = 0;
while u > 2e-1        
    id = id + 1;
    kf = kernelfcn(u);
    forces = w' * kf / sum(kf);

    %% Eular method
    dy = dy + dt * (K * (goals - y) - D * dy + scaling .* forces' * u)/tau;
    y = y + dy * dt/tau;
    Y(id,:) = y;
    
    %% tracking
%     Ky = 100;
%     Dy = sqrt(4*Ky);
%     ddyreal = Ky * (y - yreal) - Dy * dyreal;
%     if timestamps(id-1) >= extForce(1) && timestamps(id-1) < extForce(1) + extForce(2)
%         ddyreal = ddyreal + extForce(3:end);
%     end
%     dyreal = dyreal + ddyreal * dt;
%     yreal = yreal + dyreal * dt;
%     Y(id,:) = yreal;
    
    timestamps(id) = timestamps(id-1) + dt;
   
    %% canonical system
    % canonical system
    ax = -1;
    u = u + 1/tau * ax * u * dt;
    
    % canonical system with phase stop
%     ax = -1;
%     ac = 10;
%     phasestop = 1 + ac * sqrt(sum((yreal - y).^2));
%     u = u + 1/tau * ax * u * dt / phasestop; 
end

traj = [timestamps',Y];
end

