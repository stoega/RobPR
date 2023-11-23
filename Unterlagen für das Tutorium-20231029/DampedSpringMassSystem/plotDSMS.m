function plotDSMS(x)

% cart dimensions
width  = 1;
height = 0.75;
r_wheel = 0.25*width;

% spring dimensions
L = 2;
l1 = 0.3;
n = 5;

for k = 1:size(x,1)
    
    % cart position
    x_cart = x(k,1);

    % positions
    y_cart = r_wheel/2 + height/2;
    x_wheel_1 = x_cart - .9*width/2;
    y_wheel_1 = 0;
    x_wheel_2 = x_cart + .9*width/2 - r_wheel;
    y_wheel_2 = 0;
    
    % plot ground
    plot([-L, L],[0 0],'k','LineWidth',2)
    
    % plot cart
    hold on
    rectangle('Position',[x_cart-width/2,y_cart-height/2,width,height],'Curvature',.2,'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0 0 0])
    rectangle('Position',[x_wheel_1,y_wheel_1,r_wheel,r_wheel],'Curvature',1,'FaceColor',[1 1 1],'EdgeColor',[0 0 0])
    rectangle('Position',[x_wheel_2,y_wheel_2,r_wheel,r_wheel],'Curvature',1,'FaceColor',[1 1 1],'EdgeColor',[0 0 0])
    
    % plot spring
    l2 = L - width/2 + x_cart - 2*l1;
    l3 = l2/(2*n+1);
    y0s = 3/4*height+r_wheel/2;
    x_spring = [-L, -L+l1, -L+l1+(1:2*n+1)*l3, x_cart-width/2];
    y_spring = [y0s, y0s, y0s + 0.1.*repmat([1,-1],1,n), y0s, y0s];
    plot(x_spring, y_spring, 'k', 'LineWidth', 2)
    
    % plot damper    
    y0d = 1/4*height+r_wheel/2;
    l4 = L - width/2 - 2*l1;
    l5 = 1;
    plot([-L, -L+l1], [y0d, y0d], 'k', 'LineWidth', 2)
    plot([-L+l1+l4, -L+l1, -L+l1, -L+l1+l4], [y0d + 0.1.*[-1 -1 1 1]], 'k', 'LineWidth', 2)
    plot([x_cart-width/2-l5, x_cart-width/2], [y0d, y0d], 'k', 'LineWidth', 2)
    plot([x_cart-width/2-l5, x_cart-width/2-l5], [y0d-0.1, y0d+0.1], 'k', 'LineWidth', 2)
    
    axis equal
    xlim([-L, L])
    ylim([0 round(height+r_wheel)])
    hold off
    grid on
    xlabel('q')
    set(gca, 'FontSize', 16)
    
    drawnow
end

end