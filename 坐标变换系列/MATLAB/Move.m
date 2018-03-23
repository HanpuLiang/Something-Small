function [X2, Y2, Z2] = Move(a, x, X1, Y1, Z1)

if a == 1
    move = [x; 0; 0];
else if a == 2
        move = [0; x; 0];
    else if a == 3
            move = [0; 0; x];
        end
    end
end

l = size(X1);
X2 = zeros(size(X1));
Y2 = zeros(size(Y1));
Z2 = zeros(size(Z1));

for i = 1:l(1)
    temp = [X1(i,:); Y1(i,:); Z1(i,:)] + move*ones(1, l(2));
    X2(i,:) = temp(1,:);
    Y2(i,:) = temp(2,:);
    Z2(i,:) = temp(3,:);
end

end