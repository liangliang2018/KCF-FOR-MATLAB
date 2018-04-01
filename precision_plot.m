function precisions = precision_plot(positions, ground_truth, title, show)
%PRECISION_PLOT
%   Calculates precision for a series of distance thresholds (percentage of计算一系列距离阈值的精度
%   frames where the distance to the ground truth is within the threshold).（与ground truth的距离在阈值内的帧的百分比）。
%   The results are shown in a new figure if SHOW is true.                 如果SHOW为真，结果将以新图形显示。
%
%   Accepts positions and ground truth as Nx2 matrices (for N frames), and 接受位置和ground truth作为N×2矩阵（对于N个帧）和一个标题字符串。
%   a title string.
%
%   Joao F. Henriques, 2014
%   http://www.isr.uc.pt/~henriques/

	
	max_threshold = 50;  %used for graphs in the paper                     用于论文中的图表
	
	
	precisions = zeros(max_threshold, 1);
	
	if size(positions,1) ~= size(ground_truth,1),
% 		fprintf('%12s - Number of ground truth frames does not match number of tracked frames.\n', title)
		
		%just ignore any extra frames, in either results orground truth    只要忽略任何额外的帧，无论是结果还是ground truth
		n = min(size(positions,1), size(ground_truth,1));
		positions(n+1:end,:) = [];
		ground_truth(n+1:end,:) = [];
	end
	
	%calculate distances to ground truth over all frames                   在所有帧上计算距离ground truth的距离
	distances = sqrt((positions(:,1) - ground_truth(:,1)).^2 + ...
				 	 (positions(:,2) - ground_truth(:,2)).^2);
	distances(isnan(distances)) = [];

	%compute precisions                                                    计算精度
	for p = 1:max_threshold,
		precisions(p) = nnz(distances <= p) / numel(distances);
	end
	
	%plot the precisions                                                   绘制精度图
	if show == 1,
		figure('Number','off', 'Name',['Precisions - ' title])
		plot(precisions, 'k-', 'LineWidth',2)
		xlabel('Threshold'), ylabel('Precision')
	end
	
end

