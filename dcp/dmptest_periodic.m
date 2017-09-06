function traj = dmptest_periodic(w, paras)

kernelfcn = paras.kernelfcn;
centers = paras.centers;
tau = paras.tau;
dt = paras.dt;
K = paras.K;
D = paras.D;
ax = paras.ax;
% y0 = paras.y0;

u = 0;
y = paras.y0;
yd = 0;
id = 1;    

Y(id,:) = y;
timestamps(id) = 0;

if ~isfield(paras,'scaling')
    scaling = 1;
else
    scaling = paras.scaling;
end

if ~isfield(paras, 'extForce')
    extForce = 0;
else
    extForce = paras.extForce;
end

while u <= paras.endCanVal
    
    kf = kernelfcn(mod(u,2*pi));
    forces = w' * kf / sum(kf);
    
    %% Eular method
    yd = yd + dt * (K * (centers - y) - D * yd + scaling * forces + extForce);
    y = y + yd * dt/tau;
   
    id = id + 1;
    timestamps(id) = timestamps(id-1) + dt;
    Y(id,:) = y;
%     if timestamps(id) >= 1
%         break;
%     end
    %% canonical system
    u = u + 1/tau * ax  * dt; 
end

traj = [timestamps',Y];
end

