function [product] = matrixProduct(A,B)
%Usage: Multiplies two matrices together, pass the matrices as (A,B)
%Result: A matrix of height A and width B. If the matrices are of
%       incompatible size an error will be thrown and product will be equal
%       to nan.

if width(A) ~= height(B)
    product = nan;
    error('Incompatible matrix dimensions.');
end

product = zeros(height(A),width(B));

for i = 1:height(A)
    for j = 1:width(B)
        for k =1:width(A)
          product(i,j) = product(i,j) + A(i,k) * B(k,j);
        end
    end
end
end
