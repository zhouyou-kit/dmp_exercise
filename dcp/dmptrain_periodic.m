function w = dmptrain_periodic(  trajData ,paras )

kernelfcn = paras.kernelfcn;
K = paras.K;
D = paras.D;
tau = paras.tau;
ax = paras.ax;
centers = paras.centers;

timestamp = trajData(:,1);
dt = timestamp(2) - timestamp(1);

%% canonical system
x = zeros(1,size(trajData,1));
x(1) = 0;
% 1: Eular solution to exponential decreased canonical system
for i = 2 : length(x)
   x(i) = x(i-1) + 1/tau * ax * dt; 
end

u = mod(x,2*pi);
%% calculate weights directly
phi = kernelfcn(u);
w = zeros(size(phi,1), size(trajData,2)-1);
deno = sum(phi,2);

Y = trajData(:,2:end);
Yd = [zeros(1,size(Y,2));diff(Y)/dt];
Ydd = [zeros(1,size(Yd,2));diff(Yd)/dt];

for i = 2 : size(trajData,2)
   y = -K * (centers(i-1) - Y(:,i-1)) + D * Yd(:,i-1) + tau * Ydd(:,i-1);
   nume = phi * y;
   wi = nume ./ (deno + 1e-5);
   w(:,i-1) = wi;
end


% plot(timestamp,y)
end


