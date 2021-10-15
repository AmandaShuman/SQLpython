# %%
import numpy as np
import matplotlib.pyplot as plt
# rest part of of core python distribution
import wave  # for working with audio files type .wav
import glob  # help import sound files
import os.path  # help import sound files
import random  # generate random color values for waveform plots
# %%
# pathname and r short for read
soundfile_1 = wave.open('snds/1_george_12.wav', 'r')
print(soundfile_1)
# %%
# gets back all the frames
buf = soundfile_1.readframes(-1)
# %%
# returns an array of the data
data_1 = np.frombuffer(buf, 'int16')
# %%
# gives frame rate
rate_1 = soundfile_1.getframerate()
# %%
# use info to generate a timeline
xValues_1 = np.linspace(start=0, 
                        stop=len(data_1)/rate_1, 
                        num=len(data_1))

# %%
# plot this x-axis=timeline, y-axis=data_1
plt.plot(xValues_1, data_1, label='0')
plt.title('one sound file')
plt.xlabel('time')
plt.ylabel('amp')
# %%
# see a spectrogram of the sound
plt.specgram(data_1, Fs=rate_1)
# %%
# function that imports all sound data
# It takes in some soundfile data, reads the frames, stores the data in a buffer, gets a frame rate, and creates the timescale
def getSoundData(sf):
    data = sf.readframes(-1)
    data = np.frombuffer(data, 'int16')
    rate = sf.getframerate()
    timescale = np.linspace(start=0, 
                            stop=len(data)/rate,
                            num=len(data))
    # returns a tuple that stores timescale & data
    return (timescale, data)

# %%
# a python list to store our collection of sound file data
sound_files_datas = []
# use glob to import all sounds from snds folder
# loop over each sound & add data to list
for file in glob.glob('snds/*.wav'):
    soundfile = wave.open(file, 'r')
    sound_files_datas.append(getSoundData(soundfile))

print(len(sound_files_datas))
# %%
# divides plot into subplots for all 15 sounds as waveforms
rows, cols = 3, 5
# fig is overall plot
# ax is one frame of overall plot - accessed using []
fig, ax = plt.subplots(rows, cols, sharex='col', sharey='row')

rowCount = 0
colCount = 0

for sf_data in sound_files_datas:
    # unpack the tuple
    timescale, data = sf_data

    ax[rowCount, colCount].plot(timescale, data, c=(
        random.random(), 
        random.random(), 
        random.random()
    ))
    if colCount < 4:
        colCount += 1
    else:
        rowCount += 1
        colCount = 0
# %%
# plots specgram of each of 15 waveforms
rows, cols = 3, 5
# fig is overall plot
# ax is one frame of overall plot - accessed using []
fig, ax = plt.subplots(rows, cols, sharex='col', sharey='row')

rowCount = 0
colCount = 0

for sf_data in sound_files_datas:
    # unpack the tuple
    timescale, data = sf_data

    ax[rowCount, colCount].specgram(data)
    if colCount < 4:
        colCount += 1
    else:
        rowCount += 1
        colCount = 0

# %%
