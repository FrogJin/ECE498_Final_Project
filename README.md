# ECE498_Final_Project
Contributors: Tim Jin, Junnun Safoan <br />
<br />
This is the Final Group Project of ECE/CS 498 [Mobile Computing and Applications (Sp 2018)], which tracks the walking distance of the device carrier. <br />
<br />
Accelerometer, Gyroscope and Magnetic Field data are colleted from the phone carried by user who walked randomly.
The code will first find out and remove the bias from the data. Then it will use the gravity and the gyroscope data to
compute the rotational matrix at each timestamp. Finally, the local accelerometer data will be projected into a global
framework, which is used to calculate the final distance walked. <br />
![](https://github.com/FrogJin/ECE498_Final_Project/blob/master/Ex_4.5m_8Steps/4.5m_8steps.jpg)
