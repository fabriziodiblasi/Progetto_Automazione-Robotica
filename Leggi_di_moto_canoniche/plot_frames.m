function plot_frames(frames)

    frames(2:size(frames,2)+1) = frames;
    frames{1} = eye(4);
    x_v = [];
    y_v = [];
    z_v = [];
    
    for i = 1:size(frames,2)
        x_v = [x_v, frames{i}(1,4)];
        y_v = [y_v, frames{i}(2,4)];
        z_v = [z_v, frames{i}(3,4)];
    end
   
    xmax = max(x_v) + 1.0;  xmin = min(x_v) - 1.0;
    ymax = max(y_v) + 1.0;  ymin = min(y_v) - 1.0;
    zmax = max(z_v) + 1.0;  zmin = min(z_v) - 1.0;
    
    figure('Name','Traiettoria nello spazio operativo'), daspect([1 1 1]), axis([xmin, xmax, ymin, ymax, zmin , zmax])
    hold on, grid on
    xlabel('X[m]');
    ylabel('Y[m]');
    zlabel('Z[m]');
    trplot(frames{1}, 'frame', 'O', 'color', 'k')
    for i = 2:size(frames,2)
        trplot(frames{i}, 'frame', num2str(i-1))
    end