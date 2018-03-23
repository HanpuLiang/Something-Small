function [X2, Y2, Z2] = Rotate(a, theta, X1, Y1, Z1)

if a == 1
    rotate = [1 0 0; 0 cos(theta) sin(theta); 0 -sin(theta) cos(theta)];
else if a == 2
        rotate = [cos(theta) 0 -sin(theta); 0 1 0; sin(theta) 0 cos(theta)];
    else if a == 3
            rotate = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
        end
    end
end  

l = size(X1);
X2 = zeros(size(X1));
Y2 = zeros(size(Y1));
Z2 = zeros(size(Z1));
for i = 1:l(1)
    temp = rotate*[X1(i,:); Y1(i,:); Z1(i,:)];
    X2(i,:) = temp(1,:);
    Y2(i,:) = temp(2,:);
    Z2(i,:) = temp(3,:);
end

end