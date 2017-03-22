function Z = SVT_tensor(A, lambda )
A=fft(A,[],3);
L=size(A,3);
for i=1:L
    [U,S,V]=svd(A(:,:,i));
    S=diag(SoftThresh(diag(S),lambda));
    [l,m]=size(S);
    l=min(l,m);
    u(:,:,i)=U(:,1:length(S(:,l)));s(:,:,i)=S;v(:,:,i)=V(:,1:length(S(l,:))); 
end 
U=ifft(u,[],3);S=ifft(s,[],3);V=ifft(v,[],3);
Z=tprod(tprod(U,S),tran(V));
