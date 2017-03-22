clc;clear;
% load data
load video.mat
X_size=size(X);
% initialize the parameters
k = 0;
K = 1;
rho=1;
rho_k = rho;
nIter=10;
eplison = 1e-2;
% set block sizes
block_sizes = [2,2,20];
disp('block_sizes:');disp(block_sizes);

levels = size(block_sizes,1);
ms = block_sizes(:,1);
ns = block_sizes(:,2);
vs = block_sizes(:,3);

N1 = max(ms,ns);
lambdas = 10./sqrt(N1*vs);
% show the original videos
figure(1);imshow3(X,[],[1,20]);
L = X; LU = X;

for it = 1:nIter
    L = blockSVT_tensor( L, block_sizes, lambdas / rho_k);  
    % update rho_k
    k = k + 1;
    if (k == K)
        rho_k = rho_k * 2;
        K = K * 2;
        k = 0;
    end
    
    E=X-L;
    figure(2);imshow3(L,[],[levels,20]);
    titlef(it);
    drawnow
    
    figure(3);imshow3(E,[],[levels,20]);
    titlef(it);
    drawnow
    
    ERROR = LU-L;
    error = norm(ERROR(:),'fro')./norm(X(:),'fro');
    LU = L;
    if (error < eplison)
        break;
    end
end
