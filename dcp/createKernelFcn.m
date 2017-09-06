function y = createKernelFcn(centers, dd)
    
    function res = Kernel(q)
        D = sum((diff(centers,1,2)*0.55).^2,1);
        D = 1./[D,D(end)];
        D = D * dd;
        
        res = zeros(size(centers,2),size(q,2));
        for i = 1 : size(q,2)
            qq = repmat(q(:,i),1,size(centers,2));            
            res(:,i) = exp(-0.5*sum((qq-centers).^2,1).*D);          
        end
    end
    y = @Kernel;

end

