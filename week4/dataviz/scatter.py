# %%
import numpy as np
import matplotlib.pyplot as plt
# %%
num = 20
# two-dimensional data array, but could be n-dimensional array
data = np.random.rand(4, num)
# prints 4 arrays with num numbers in it
print(data) 
# %%
# first 2 arrays are passed in for x and y values
# 3rd array for color values using c=
# 4th array for scale values (mult by 1000 for better visibility)
# aplha is for opacity
# cmap is a color palette
plt.scatter(data[0], data[1], c=data[2], s=data[3]*1000, alpha=0.3, cmap='viridis')
plt.colorbar()  # show color scale
# %%
num = 500
# 500 dimensional array of 500 numbers each
data = np.random.rand(num, num)
plt.imshow(data, cmap='binary')
plt.colorbar()
# %%
