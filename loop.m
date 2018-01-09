i = 0;
while (i!=11)
  getpicture
  t = imageTo20x20Gray('e.jpg',0,0,Theta1,Theta2);
  i = predict(Theta1,Theta2,t)
  pause(0.5);
  %title(gca,num2str (i));
  endwhile