%captures a pic from webcam and stores it as e.jpg .place our number near the camera before calling this


pkg load image-acquisition;
obj = videoinput("v4l2", "/dev/video1");
get(obj);
set(obj, "VideoFormat", "RGB3");
set(obj, "VideoResolution", [320 240]);
start(obj, 2);
img = getsnapshot(obj);
%image(img);
imwrite(img, "e.jpg");