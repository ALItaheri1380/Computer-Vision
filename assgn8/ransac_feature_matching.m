close all, clear, clc

run('../vlfeat-0.9.20/toolbox/vl_setup');

box_img = imread('box.pgm');
scene_img = imread('scene.pgm');

[matched_box, matched_scene] = find_matching_points(single(box_img), single(scene_img));

figure(1)
subplot(3, 1, 1)
showMatchedFeatures(box_img, scene_img, matched_box, matched_scene, 'montage');
title('All Matched Features')

subplot(3, 1, 2)
[H, matched_box, matched_scene] = RANSAC(matched_box, matched_scene, 5, 25, 20000);
showMatchedFeatures(box_img, scene_img, matched_box, matched_scene, 'montage');
title('Consensus Features')

subplot(3, 1, 3)
transform = projective2d(H');
scene_warped = imwarp(scene_img, transform, 'OutputView', imref2d(size(scene_img)));

showMatchedFeatures(box_img, scene_warped, matched_box, matched_scene, 'montage');
title('Warped Image')