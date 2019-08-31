import cv2
import pytesseract
import tensorflow as tf
import sys
import keras


print("[INFO] python=" + sys.version)
print("[INFO] cv2=" + str(cv2.__version__))
print("[INFO] tensorflow=" + str(tf.__version__))
print("[INFO] keras=" + str(keras.__version__))
print("[INFO] tesseract=" + str(pytesseract.get_tesseract_version()))