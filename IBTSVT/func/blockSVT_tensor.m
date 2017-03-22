function Z = blockSVT_tensor( Z, block_size, lambda )
% Block-wise singular value thresholding
% 
% Inputs:
% Z          -    input tensor
% lambda     -    threshold
%

blockSVT_tensorfun = @ (X) SVT_tensor( X, lambda );

Z = blkproc_tensor( Z, block_size, blockSVT_tensorfun);
% blkproc not recommended in Matlab, but way faster than blockproc...
