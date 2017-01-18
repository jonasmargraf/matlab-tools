# matlab-tools
A grabbag of utility functions for audio signal processing using MATLAB.

## Included functions
* `get_BR.m`
Calculates the bass ratio based on RT for frequencies T125Hz, T250Hz, T500Hz, T1000Hz.

* `get_C80.m`
Calculates C80, a measure for acoustic clarity in a room.

* `get_IACC.m`
Calculates interaural cross-correlation coefficients for frequencies T125Hz, T250Hz, T500Hz, T1000Hz. Requires binaural input signal.

* `get_RT60.m`
Calculates RT 60, based on 60db, 20dB and 30db decrease.

* `get_SoundPressureLevel.m`
Calculates sound pressure level for different positions in a room and displays them in a plot.

* `hfc.m`
Calculates the high frequency content of a given spectrum X.

* `sfm.m`
Calculates the sepctral flatness of a given spectrum X.

* `spr.m`
Calculates the spectral spread of a given spectrum X.

* `synthesizeAudioFrame.m`
This function takes two frames of amplitude and frequency data for twenty partials, interpolates linearly between them and synthesizes an audio signal.

* `synthesizeAudioFrameVibrato.m`
This function takes two frames of amplitude and frequency data for twenty partials, interpolates linearly between them and synthesizes an audio signal (with additional vibrato).
