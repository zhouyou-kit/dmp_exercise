function traj = dmptest(w, paras)
global exercise_id
global alpha_phaseStop

kernelfcn = paras.kernelfcn;
goals = paras.goals;
tau = paras.tau;
dt = paras.dt;
K = paras.K;
D = paras.D;
y = paras.y0;
dy = paras.dy;

if ~isfield(paras, 'extForce')
    extForce = [0,0,0,0];
    isDisturbance = true;
else
    extForce = paras.extForce;
    isDisturbance = false;
end

u = 1;
ax = paras.ax;

id = 1;
yreal = y;
dyreal = dy;
Y(id,:) = yreal;
timestamps(id) = 0;
t = 0;
while u > 1e-3
    id = id + 1;
    kf = kernelfcn(u);
    forces = w' * kf / sum(kf);
    
    switch exercise_id
        case 1
            scaling = (goals - paras.y0)./paras.original_scaling;
            ddy = K * (goals - y) - D * dy + scaling.* forces' * u;
        case {2,3}
            scaling = goals - paras.y0;
            ddy = K * (goals - y) - D * dy - K * scaling * u + K * forces' * u;
    end
    
    %% Euler Method
    dy = dy + dt * ddy/tau;
    y = y + dy * dt/tau;
    
    switch exercise_id
        case {1,2}
            Y(id,:) = y;
        case 3
            Ky = 300;
            Dy = sqrt(4*Ky);
            ddyreal = Ky * (y - yreal) - Dy * dyreal;
            if timestamps(id-1) >= extForce(1) && timestamps(id-1) < extForce(1) + extForce(2)
                extForce(3:end)
                ddyreal = ddyreal + extForce(3:end)
            end
            dyreal = dyreal + ddyreal * dt;
            yreal = yreal + dyreal * dt;
            Y(id,:) = yreal;
    end
    
    
    %% canonical system
    switch exercise_id
        case {1,2}
            u = u + 1/tau * ax * u * dt;
        case 3
            phasestop = 1 + paras.ac * sqrt(sum((yreal - y).^2));
            u = u + 1/tau * ax * u * dt / phasestop;
    end
    
    t = t + dt;
    timestamps(id) = t;
    
end

traj = [timestamps',Y];
end

