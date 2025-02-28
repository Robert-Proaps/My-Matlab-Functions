%Clean up the workspace
clear all;
clc;

disp('Performing Scaled Gaussian Elemination on the Provided Matrix.')
A = [-1 2 3 1 3;2 -4 1 2 -1;-3 8 4 -1 6;1 4 7 -2 -4];
disp(A)

disp('Matrix A has been Scaled into matrix ScaledA')
%Input Matrix Scaling
%Create a vector containing the maximum absolute value from each row.
maxRowVals = max(abs(A), [], 2);

%Divide the first entry of each row by the maximum value of each row and store it to a new column vector.
scaledCol = A(:,1) ./ maxRowVals;

%Append the original row idices to the scaledCol vector to create an Mx2 matrix
rowOrder = [scaledCol, linspace(1,height(A), height(A))'];

%Sort the rows in the Row Order matrix by descending value on the first column.
rowOrder = sortrows(rowOrder, 1, "descend");

%Pivot the rows of the original matrix based on their occurance in the row order matrix
scaledA = nan(height(A),width(A)); %This preallocates the size of scaledA
for i = 1:height(A)
    scaledA(i,:) = A(rowOrder(i,2),:);
end

disp(scaledA)

%Clean Up Temporary Variables
clear i, clear rowOrder, clear scaledCol, clear maxRowVals

%At this point the original matrix should now be scaled.

%Gaussian Elemination
disp('Beginning Elemination Procedures')
AOut = scaledA; %A Out is used to show completed row operations and is the program output.
for j = (1):width(A)-1 %Active Column
    for i = j+1:height(A) %Row undergoing elemination
        eleminationFactor = scaledA(i,j) ./ scaledA(i - 1, j); %Factor to be used when eleminating a row.
        AOut(i,j:width(A)) = scaledA(i,j:width(A)) - eleminationFactor .* scaledA(i-1, j:width(A)); %Row Elemination.
    end
    disp(AOut);
end

clear eleminationFactor;

%Back Substitution and solution.

%First isolate the coeffecient matrix.
U = AOut(:,1:(width(AOut)-1));

%Isolate the constant vector.
b = AOut(:,end);

%Create an empty solution vector.
x = zeros(height(U),1);

%Perform Back Substitution.
for i = height(U):-1:1
    x(i) = (b(i) -U(i,i+1:height(U)) * x(i+1:height(U))) / U(i,i);
end

disp('The solution vector has been found to be...')
disp(x)
%Answer Verification
disp('The Sum of the element-wise product of the solution vector and the first row of the coeffecient matrix is... ')
disp(sum(U(1,:) .* x'))
disp('The expecteed value from the constants vector was... ')
disp(b(1,1));
disp('The percent error is...')
disp(((sum(U(1,:) .* x')-b(1,1))/b(1,1))*100)
