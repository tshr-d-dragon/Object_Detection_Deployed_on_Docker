# Object_Detection_Deployed_on_Docker

Train and predict the object detection model on docker using tensorflow object detection 2.0

Steps to follow:
1. To build image, update the root directory of tensorflow and the name of the image in the `Build.bat` file. 
2. Copy the Dockerfile from this repository to `.\research\object_detection\dockerfiles\tf2\Dockerfile` location.
3. Run the `Build.bat` file.
4. Clone this repo and create a folder name images and paste there all the training images along with annotations (xml) files. 
5. Update the path of this repository directory in `Run.bat` file and confirm the ports as per the availability.
6. Run the `Run.bat` file to run docker image.
7. Follow the `Final_OD_pothole.ipynb` file to train and predict the object detection model.
