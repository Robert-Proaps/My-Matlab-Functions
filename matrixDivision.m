function [quotient] = matrixDivision(A,B)
%Usage: Accepts two matrices, (A, B) and divides A by B.
%Returns: The quotient of A / B.

if width(A) ~= height(B) %Check if A and B are compatible.
    quotient = nan;
    error('Incompatible matrix dimensions.')
end

if width(A) ~= height(A) || width(B) ~= height(B) %Check if A and B are square.
    quotient = nan;
    error('One or Both of the matrices are not square');
end

if det(A) == 0 || det(B) == 0 %Check if A or B have a determinate equal to 0.
    quotient = nan;
    error('One or both matrices have a 0 determinate.')
end

invB = inv(B);

quotient = zeros(size(A));
for i = 1:height(A)
    for j = 1:width(B)
        for k =1:width(A)
          quotient(i,j) = quotient(i,j) + A(i,k) * invB(k,j);
        end
    end
end
end
