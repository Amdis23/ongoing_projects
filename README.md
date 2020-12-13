# ongoing_projects
Minor projects which could lead to research paper


#smart_building
Summary of the project:
1.	The microgrid (MG) is connected to the power utility and is also equipped with a PV panel and battery energy storage system.
2.	Load in the microgrid (MG) can be classified into critical, deferrable and controllable loads. Critical loads will be lights and fans. Deferrable loads will be washing machines, motors used for water pumping system, refrigerator etc. In addition, we will have controllable loads like air-conditioners.
3.	It is assumed that time of use tariff (TOU) is in place. 
4.	Loads will be connected to the control room of the microgrid (MG) energy system via smart sensors, e.g., temperature sensor will be sensing the temperature of the room and sending the signal to the central energy management system (EMS) software. For water pumping system, level of water will be assessed by level sensors and sent to the EMS.
5.	In the proposed scheme, the microgrid (MG) consumer will try to minimize energy use in the time interval when the load/demand on the main grid/utility is high (i.e., high electricity price). 
6.	Power consumption of deferrable loads will be shifted to off-peak periods to the extent possible for achieving peak shaving and valley filling. This relieves the grid from being overstressed and also helps in reducing the electricity bill of the consumer.
7.	The above objective will be achieved by designing and implementing an automatic control scheme based on a supervisory control and data acquisition (SCADA) system. 
8.	This will be achieved in following steps:
A.	The deferrable loads will be switched on/off and controlled automatically using the SCADA system so as to achieve peak shaving and load shifting
B.	Controllable loads like AC will be controlled, e.g. temperature setting of the AC will be controlled so as to simultaneously achieve user comfort and minimize electricity consumption under peak loads.
C.	BESS will be scheduled (i.e., charging and discharging pattern will be determined) to achieve maximum arbitrage benefit, e.g., during off peak hours or during periods of higher solar generation, battery will charge. The battery will discharge to reduce power consumption from the grid during peak hours (i.e., when electricity price is high).
9.	Deferrable loads will feed the following information to the energy management system:
A.	Time slot between which a particular activity is to be finished, e.g., washing needs to be finished between 11 am to 4 pm. 
B.	Time duration of the activity, e.g., The washing process takes 90 minutes 
10.	The energy management system will also collect information regarding the present and future electricity tariffs.
11.	Temperature and level sensors will provide information regarding the ambient temperature and the water level in the tank.
12.	Based on inputs received from steps 9, 10, and 11, EMS will optimize the energy consumption of each of the deferrable loads, e.g., the washing process will start from 2 pm and end at 0330 pm when the electricity price is high. In addition, battery charging schedule and temperature setting of ACs will also be set to achieve the desired objective.
13.	Based on the result of the optimization process, ON/OFF signals will be sent to each deferrable load. For loads like AC, the optimum temperature setting will also be calculated for user comfort and the signal sent to the AC for implementation. Battery will also charge according to the optimum schedule.
14.	In the first step, simulation studies will be done followed by hardware implementation of the entire system.


