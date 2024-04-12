![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg)

# SPDIF to I2S - from blinky light to sweet audio

- Take single input serial bitstream SPDIF audio source and convert to standard I2S audion interface. 
Modern Auido chips uses I2S interface for input and output. It is inteted as a serial sink/source audio interconnect in complex systems like HIFI,TV and computers. It is a 3 wire bus: clk, left/right synk and data. 

Most digital audio amps with digital input uses I2S as input. I spend a signifient part of my life designing said class audio amplifierer and this project will be used to link digital audio to one of my little babies. 

## Why is this taped out on Tiny Tapeout?

During 2023 and 2024 I did a couple of TinyTapeout workshop with at Bornhack and IDA Embedded. This project is my pipe cleaner and am super excited on how Matt and his team has taken this new platform. 
IDA embedded plan to do 2 yearly Tinytape workshops. Next one will be TT08 in September. 
 
## Project setup 

Project source code is located in `src` directory with a mixture of systemverilog and verilog files in seperated in logical seperated components folders. 
A make file generates a list of source files relative to `src` that get passed to the `source_files` in the [info.yaml](info.yaml) file 

A testbench has been added to `test` folder. For now it has limited coverage. See [test/README.md](test/README.md) for more information.

The GitHub action will automatically build the ASIC files using [OpenLane](https://www.zerotoasiccourse.com/terminology/openlane/).

I have a local build flow in the making support local developemnt 

## Enable GitHub actions to build the results page

- [Enabling GitHub Pages](https://tinytapeout.com/faq/#my-github-action-is-failing-on-the-pages-part)

## Resources

- [FAQ](https://tinytapeout.com/faq/)
- [Digital design lessons](https://tinytapeout.com/digital_design/)
- [Learn how semiconductors work](https://tinytapeout.com/siliwiz/)
- [Join the community](https://tinytapeout.com/discord)
- [Build your design locally](https://docs.google.com/document/d/1aUUZ1jthRpg4QURIIyzlOaPWlmQzr-jBn3wZipVUPt4)

## What next?

- [Submit your design to the next shuttle](https://app.tinytapeout.com/).
- Edit [this README](README.md) and explain your design, how it works, and how to test it.
- Share your project on your social network of choice:
  - LinkedIn [#tinytapeout](https://www.linkedin.com/search/results/content/?keywords=%23tinytapeout) [@TinyTapeout](https://www.linkedin.com/company/100708654/)
  - Mastodon [#tinytapeout](https://chaos.social/tags/tinytapeout) [@matthewvenn](https://chaos.social/@matthewvenn)
  - X (formerly Twitter) [#tinytapeout](https://twitter.com/hashtag/tinytapeout) [@matthewvenn](https://twitter.com/matthewvenn)
