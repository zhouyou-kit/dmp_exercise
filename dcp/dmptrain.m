function w = dmptrain( trajData ,paras)
global exercise_id


kernelfcn = paras.kernelfcn;
K = paras.K;
D = paras.D;
tau = paras.tau;
ax = paras.ax;

timestamp = trajData(:,1);
dt = timestamp(2) - timestamp(1);

%% canonical system
x = zeros(1,size(trajData,1));
x(1) = 1;
% 1: Euler solution to exponential decreased canonical system
for i = 2 : length(x)
   x(i) = x(i-1) + 1/tau * ax * x(i-1) * dt; 
end

%% calculate weights directly
phi = kernelfcn(x);
w = zeros(size(phi,1), size(trajData,2)-1);
deno = sum(phi,2);

Y = trajData(:,2:end);
goals = Y(end,:)';
Yd = [zeros(1,size(Y,2));diff(Y)/dt];
Ydd = [zeros(1,size(Yd,2));diff(Yd)/dt];

for i = 2 : size(trajData,2)   
   switch exercise_id
       case 1
           y = -K * (goals(i-1) - Y(:,i-1)) + D * Yd(:,i-1) + tau * Ydd(:,i-1);  
       case {2,3}
           y = (tau * Ydd(:,i-1) + D * Yd(:,i-1))/K - (goals(i-1) - Y(:,i-1)) + (goals(i-1) - Y(1,i-1)) * x';
   end
   
   y = y./(x');
   nume = phi * y;
   wi = nume ./ (deno + 1e-6);
   w(:,i-1) = wi;
end

end

