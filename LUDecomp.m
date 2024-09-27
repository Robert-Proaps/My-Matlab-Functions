function [L,U] = LUDecomp(A)
%Usage: Pass the function a matrix A.
%Returns: A in terms of a Lower Triangular Matrix, and an Upper Triangular
%Matrix.
L = eye(size(A,1));
U = A;

for k = 1:size(A,1)-1
    for i = k+1:size(A,1)
        L(i, k) = U(i, k) / U(k, k);
        U(i, k:size(A,1)) = U(i, k:size(A,1)) - L(i, k) * U(k, k:size(A,1));
    end
end
end
