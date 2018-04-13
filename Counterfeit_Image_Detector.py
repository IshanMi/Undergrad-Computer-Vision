import sys
import numpy
import scipy
import PIL
 
 
## Attempt to quantify the difference between two images
 
#Things to check:
#- Images of the same size and dimension
#- Alignment
#- Exposure and contrast of the images
#- Colour Information
#    - Is RGB a necessity, or will greyscale work?
#- Likeliness of the edges moving
#    - Can apply some kind of Edge Detection Algorithm, using Prewitt Transform
#- Noise
#- What kind of difference we're considering:
#    - Manhattan Norm (sum of absolute values) will tell how much the image is off.
#    - Zero norm (the number of elements not equal to 0) will tell how many pixels differ.
 
 
def compare_images(img1, img2):
    # Exposure difference could result in problems
    # Normalize first
    img1 = normalize(img1)
    img2 = normalize(img2)
    # Calculate the difference and its normalization
    diff = img1 - img2 # Element by element iteration
    m_norm = sum(abs(diff))
    z_norm = numpy.linalg.norm(diff.ravel(), 0)
    return (m_norm, z_norm)
 
 
def to_grayscale(arr):
    if len(arr.shape) == 3:
        return numpy.average(arr, -1) #average over the last color  channel axis
    else:
        return arr
 
 
def normalize(arr):
    rng = arr.max()-arr.min()
    amin = arr.min()
    return (arr-amin)*255/rng
 
 
if __name__ == "__main__":
    main()
     
def main(file1, file2):
    file1= file2 = sys.argv[1:1+2]
    # Use equivalent of MATLAB's imread function
    img1 = to_grayscale(scipy.misc.imread(file1).astype(float))
    img2 = to_grayscale(scipy.misc.imread(file2).astype(float))
 
    # Compare both images
    manhattan_norm, zero_norm = compare_images(img1, img2)
    print("Manhattan norm:", manhattan_norm, "/ per pixel: ", manhattan_norm/img1.size)
    print("Zero norm:", zero_norm, "/ per pixel: ", zero_norm/img1.size )
