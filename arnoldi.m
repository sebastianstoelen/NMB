function [H, Q, E] = arnoldi(A, b, maxit)

% function [H, Q] = arnoldi(A, b, maxit)
%
% Arnoldi iteratie
% 
% invoer:
% A     - ijle matrix
% b     - startvector
% maxit - aantal iteraties
%
% uitvoer:
% H     - Hessenberg matrix
% Q     - orthogonale matrix
z= 0;
E = [];
W = sortrows(abs(real(eigs(A,6,'lr'))));
Q(:,1) = b/norm(b);
for n=1:maxit
  v = A*Q(:,n);
  for j = 1:n
    H(j,n) = Q(:,j)'*v;
    v = v - H(j,n)*Q(:,j);
  end
  k=n;
  if k>6
      k=6;
  end
  L = abs(real(eigs(H,k,'lr')));
  if real(L(1)) ~= 0
    L= sortrows(L);
    if size(W) == size(L)
        z = 1;
    end
    if z == 1
      L = L-W;
      E = [E L];
    end
  end
  H(n+1,n) = norm(v);
  if H(n+1,n) <= 0, 
      break;
  end
  Q(:,n+1) = v/H(n+1,n);
end;

