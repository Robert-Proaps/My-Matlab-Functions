function [rightEigVect, leftEigVect, eigValue, orthogonality] = powerIteration(A, numIterations)
    %Usage: Takes in a matrix and a number of times to iterate.
    %Returns: The Left and Right Eigenvectors of the matrix, the Eigenvalues of the matrix, and whether the left and right eigenvectors are orthogonal.
    
    %Define orthogonality to be false.
    orthogonality = false;
    %Initialize a guess eigen vector.
    guess = rand(size(A,1),1);

    %Initialize an array to store all the eigen values as they are
    %iterated.

    eigenValues = zeros(1,numIterations);

    for k = 1:numIterations
        %Calculate the matrix vector product.
        guess1 = A * guess;

        %Normalize the vector and update the guess.
        guess = guess1 / norm(guess1);

        %Note the current eigenvalue;
        eigenValues(1,k) = guess' * A * guess;
    end

    rightEigVect = guess;
    eigValue = eigenValues;
    %Now solve for the left eigenvector.
    %Make a guess vector for the left eigenvector.
    leftGuess = rand(size(A,1),1);

    for k=1:numIterations
        guess1 = A' \ leftGuess;
        leftGuess = guess1 / norm(guess1);
    end

    leftEigVect = leftGuess;

    %Check if the eigenvectors are orthogonal.
    if dot(leftEigVect, rightEigVect) <= 1.5e-16 %Because we are approximating the vectors we must use a threshold close to zero instead of zero.
        orthogonality = true;
    end
end
