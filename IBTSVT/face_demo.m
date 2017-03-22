clc;clear;
% load the data
load face.mat
X = Y(:,:,:);
X_size = size(X); 
% initialize the parameters
rho = 1;
nIter = 10; 
eplison = 6e-2;
error = 0;
% set block sizes
block_sizes = [2,2,64];
disp('block_sizes:');disp(block_sizes);

levels = size(block_sizes,1);
ms = block_sizes(:,1);
ns = block_sizes(:,2);
vs = block_sizes(:,3);
N1 = max(ms,ns);
lambdas = 26./sqrt(N1*vs);
% show the original images
figure(1);imshow3(X,[],[2,32]);
L = X; LU = X;
for it = 1:nIter
    % compute the low rank component
    L = blockSVT_tensor( L, block_sizes, lambdas / rho);  
    E = X - L;
    figure(2);imshow3(L,[],[levels*2,32]);
    titlef(it);
    drawnow
    figure(3);imshow3(E,[],[levels*2,32]);
    titlef(it);
    drawnow
    
    ERROR = LU-L;
    error = norm(ERROR(:),'fro')./norm(X(:),'fro');
    LU = L;
    if (eplison > error)
        break;
    end
end
