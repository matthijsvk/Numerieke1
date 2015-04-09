% Dit bestand analyseert de convergentie van de arnoldi methode
clc;clear;close all
m = 100;
maxit = 50;

A = 10^10*sprand(m,m,0.05);
Lambda = eigs(A);
b = rand(m,1);

res = rand(1,1);

Q(:,1) = b/norm(b);
for n=1:maxit
  v = A*Q(:,n);
  for j = 1:n
    H(j,n) = Q(:,j)'*v;
    v = v - H(j,n)*Q(:,j);
  end
  H(n+1,n) = norm(v);
  if H(n+1,n) <= 0, 
      break;
  end
  Q(:,n+1) = v/H(n+1,n);
  ritz = (eigs(H(1:size(H,1)-1,:)));
  if size(ritz,1) < size(Lambda,1)
      ritz = [ritz ; zeros(size(Lambda,1)-size(ritz,1),1)];
  end
  res(n) = norm(abs(real(ritz(1:size(Lambda,1))))-abs(real(Lambda)))/norm(abs(real(Lambda)));
end;

Lambda
semilogy(res,'-o')

[H, Q] = arnoldi(A, b, maxit);
LambdaArnoldi = (eigs(H(1:size(H,1)-1,:)))