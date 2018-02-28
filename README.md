# aFlowOCT
calculate absolute cerebral blood flow from Doppler OCT measurements
This GUI is used to calculate the blood flow based on axial velocity obtained with Doppler OCT/DLSOCT. 
Step1 is to select and load the Vz data, and provide the ROI (in um)
Step2 is to select the en face (xy) plane by setting startZ and stackZ values (if stackZ>0, the en face image will be an MIP)
Step3 is to plot the selected en face Vz map.
Step 4 is to select the vessel cross section by selecting 12 points around the vessel wall. 
Then the selected vessel cross section and calculated flow and average axial velocity will be ploted in a poped figure. 
