function [D,H,utest,b] = modelDiscrInputDesign_assigment(i)
%modelDiscrInputDesign_assigment Summary of this function goes here
%   [D,H,utest,b] = modelDiscrInputDesign_assigment(i)  vrati prarametry
%   pro zadání 'i'. D(:,:,1), D(:,:,2), H(:,:,1) a H(:,:,2) jsou matice
%   popisující dva modely systému. utest(:,1) a utest(:,2) jsou dva
%   testovací vstupy. b(:,1) až b(:,end) jsou vrcholy mnohoúhelníku
switch i
    case 1
        D(:,:,1) = [1 2;3 4];
        D(:,:,2) = [1 2.1;3.2 4.1];
        
        phi = pi/3;
        tmp = [cos(phi) -sin(phi)
            sin(phi) cos(phi)];

        H(:,:,1) = tmp*diag([1,1.6])*tmp';
        
        phi = pi/4;
        tmp = [cos(phi) -sin(phi)
            sin(phi) cos(phi)];
        H(:,:,2) = tmp*diag([1,0.6])*tmp';
        
        utest = [2 6
            3 8];
        
        b = [10 15 12
            -5 -3 5];
    case 2
        D(:,:,1) = [2 1;2 4];
        D(:,:,2) = [2 1.3;2.1 4.1];
        
        phi = pi/3;
        tmp = [cos(phi) -sin(phi)
            sin(phi) cos(phi)];

        H(:,:,1) = tmp*diag([1,1.6])*tmp';
        
        phi = 2*pi/3;
        tmp = [cos(phi) -sin(phi)
            sin(phi) cos(phi)];
        H(:,:,2) = tmp*diag([1,0.6])*tmp';
        
        utest = [3 3
            1 6];
        
        b = [-5 -10 -5 -2
            0 -10 -13 -2];
    otherwise
        error('Zadani cislo %i neexistuje',i)
end
    

end

