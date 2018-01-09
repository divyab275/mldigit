i = 0;
while (i<10)
  getpicture
  t = imageTo20x20Gray('e.jpg');
  predict(Theta1,Theta2,t)
  pause(0.05);
  endwhile