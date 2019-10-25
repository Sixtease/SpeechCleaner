import tensorflow as tf
import numpy as np
from scipy.fftpack import rfft, irfft
from tensorflow.audio import decode_wav
import os

'''
curr_batch - The current batch of the training data we are looking at.songs_per_batch - How songs we want to load in per batchsess - Our TensorFlow session object
'''

SAMPLES_CNT = 5292000

def get_next_batch(curr_batch, songs_per_batch, sess):
  wav_arr_ch1 = []
  wav_arr_ch2 = []
  if (curr_batch) >= (len(file_arr)):
    curr_batch = 0
  start_position = curr_batch * songs_per_batch
  end_position = start_position + songs_per_batch
  for idx in range(start_position, end_position):
    os.system('bash mktrainwav.sh %d trainsample.wav' % idx)
    audio_binary = tf.read_file('trainsample.wav')
    os.remove('trainsample.wav')
    wav_decoder = decode_wav(
      audio_binary, desired_channels=1
    )
    sample_rate, audio = sess.run([
      wav_decoder.sample_rate, 
      wav_decoder.audio
    ])
    audio = np.array(audio)    # We want to ensure that every song we look at has the same number of samples!
    if len(audio[:, 0]) != SAMPLES_CNT: 
      continue
    wav_arr.append(rfft(audio[:,0]))
  print("Returning File: " + file_arr[idx])
  return wav_arr, sample_rate

inputs = 12348
hidden_1_size = 8400
hidden_2_size = 3440
hidden_3_size = 2800

batch_size = 50

lr = 0.0001
l2 = 0.0001

def next_batch(c_batch, batch_size, sess):
  ch_arr = []
  wav_arr, sample_rate = get_next_batch(c_batch, batch_size, sess)

  for sub_arr in wav_arr:
    batch_size = math.floor(len(sub_arr)/inputs)
    sub_arr = sub_arr[:(batch_size*inputs)]
    ch_arr.append(np.array(sub_arr).reshape(
                                     batch_size, inputs))
  # Carry through sample_rate for reconstructing the WAV file
  return np.array(ch_arr), sample_rate

epochs = 10000
batches = 50

with tf.Session() as sess:
 init.run()
 song, sample_rate = next_batch(0, batch_size, sess)
 for epoch in range(epochs):
  epoch_loss = []
  print("Epoch: " + str(epoch))
  for i in range(batches):
   total_songs = np.hstack([ch1_song])
   batch_loss = []

     for j in range(len(total_songs)):
        x_batch = total_songs[j]

        _, l = sess.run([training_op, loss], 
                          feed_dict = {X:x_batch})

        batch_loss.append(l)
        print("Song loss: " + str(l))
        print("Curr Epoch: " + str(epoch) + 
                " Curr Batch: " + str(i) + "/"+ str(batches))

     print("Batch Loss: " + str(np.mean(batch_loss)))
     epoch_loss.append(np.mean(batch_loss))

  print("Epoch Avg Loss: " + str(np.mean(epoch_loss)))
