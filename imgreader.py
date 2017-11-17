import PIL;
from PIL import Image;
import pytesseract;
import sys;
from PIL import ImageFilter;
image_path = "\\test.png";
pytesseract.pytesseract.tesseract_cmd = "C:\\Users\\Dipesh Nihalani\\Tesseract-OCR\\tesseract";
tessdata_dir_config = '--tessdata-dir "C:\\Users\\Dipesh Nihalani\\Tesseract-OCR\\tessdata"'
image = Image.open(image_path).convert('L');
old_width = image.size[0];
new_width = int(old_width*1.5);
hsize = int((float(image.size[1])*1.5));
image = image.resize((new_width,hsize), PIL.Image.ANTIALIAS);
image = image.filter(ImageFilter.UnsharpMask(radius=6.8,percent=269,threshold=0));
output = pytesseract.image_to_string(image,lang='eng',config=tessdata_dir_config);                                                                                                                 
text_file = open("Output.txt", "w");
text_file.write(output);
text_file.close();