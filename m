Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2511BDC96B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501986AbfJRPmf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 11:42:35 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39843 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439662AbfJRPme (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 11:42:34 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MkHIV-1hauA20lSb-00kdie; Fri, 18 Oct 2019 17:41:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 00/46] ARM: pxa: towards multiplatform support
Date:   Fri, 18 Oct 2019 17:40:52 +0200
Message-Id: <20191018154052.1276506-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EHc7oEzoVA7wFO+Bch6RyP3Dmkh5AMRq/Ay6Si14JV6lk4ud9hG
 Rebu5BXDtymt2IyLQOTjtdgK6YNR3mzeiU1Iz44weETYwhNUZA3lhMBHpYk8vX3QhGhyK94
 kCllRns/Nt5rZvsPJrwJWc/6hwei4WDR7zussy/AAIDLcsRES0ddHF6Kcf9khiXYHAVoAUG
 rup34Bo4MqFMDTnIgjfNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dxE2RJNuqeQ=:Erdj2DVtSPYWczY3oZZ9HJ
 dqPVJK56NENsV8jgemKgYOlgILekiFj7Wr1UYeO83MkuYh1EIquVzzslvtlinPjaswpZsm7RP
 6rH8MHndTNGZ3qvBg72nxKSTvqop19eMZva5iz/t1KDIcL6Y50UwD4VWs+e+cvNnZy7BrR5Xc
 4QTLrPjG2movX1Mv1sII87WLSFb6tdQfRrR8RBLnkZvQ6qwI3UqWeNUTCvtDJgzb8lnXsNwBf
 s9pYhaccSH5GDqTtHOFdHbqT4Mv2triKsDy7hDw2acs2Ea0fqkQiRSURv0wjK21BIJyQAXCxc
 u+G5rU0bAVe8sN6Kmf0/e7IpupEAneezN/rGH3CBTFZLlUejYYPGoW3mSwLXBLTqKqPQ8otE4
 NNdYvXYhFoTMFfaaIsA87aGQTK8MQpf/ojfjSdYVmGOnHi5Yl4p884AJfwMCsYD3TZ/4JCLEZ
 Zqkmb3hIUmilROzsQt2pfH9fzbT0mnZd6CulD1MoscYfuSPafAB3BYirZxtQJhoZCij8z9GjD
 FkrfWjOCgvDievzI7GtYWHSeLrjpu8QtdLD8C6QL86Zhd2A3JBNgM1uJGbRk0K8y1fkcLRaYO
 8p0WEk59xAtIANUijr6ZjHKuol9ADJp1S3i8wu0k3aiFW/Dzj0yMEAgFsN0RB+Kgqtq4405u5
 c3wsDLdrAtFa16SX0pBzKqELCia9Q/1KXIGidCYq/FI3ujnsyIr6TVNTcpeZqPFPkR3cEMAhE
 tCl52psfDTr+zs5tcElDnPWOTJZXOVqtdlNAlGD38iQrKCGryYVt1QdAuGIHEK4uhCSlISyQ6
 IIF3IT2mmzyqMw9F2CreKbmLybsolksnpbtKhHjqahUfNg5mSoO80LJTUen7lqoJyCEsyHQoP
 w5Jy020MzrnM+X6ufotQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi PXA maintainers,

I'm in the process of getting the old ARM platforms to all build
in a single kernel. The largest part of that work is changing all
the device drivers to no longer require mach/*.h header files.

This series does it for arch/pxa/.

As with the omap1 and s3c24xx series I sent before, I don't
expect this all to be correct in the first version, though
a lot of the patches are fairly simple and I did exhaustive
compile-time testing on them.

Please test if you have the hardware, or review!

     Arnd

Bcc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Bcc: alsa-devel@alsa-project.org
Bcc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Bcc: Brian Norris <computersforpeace@gmail.com>
Bcc: Daniel Thompson <daniel.thompson@linaro.org>
Bcc: David Woodhouse <dwmw2@infradead.org>
Bcc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Bcc: Dominik Brodowski <linux@dominikbrodowski.net>
Bcc: dri-devel@lists.freedesktop.org
Bcc: Felipe Balbi <balbi@kernel.org>
Bcc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Bcc: Guenter Roeck <linux@roeck-us.net>
Bcc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Bcc: Jens Axboe <axboe@kernel.dk>
Bcc: Jingoo Han <jingoohan1@gmail.com>
Bcc: Jonathan Cameron <jic23@cam.ac.uk>
Bcc: Lee Jones <lee.jones@linaro.org>
Bcc: Lubomir Rintel <lkundrak@v3.sk>
Bcc: Marek Vasut <marek.vasut@gmail.com>
Bcc: Mark Brown <broonie@kernel.org>
Bcc: Michael Turquette <mturquette@baylibre.com>
Bcc: Miquel Raynal <miquel.raynal@bootlin.com>
Bcc: Paul Parsons <lost.distance@yahoo.com>
Bcc: Pavel Machek <pavel@ucw.cz>
Bcc: Philipp Zabel <philipp.zabel@gmail.com>
Bcc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Bcc: Richard Weinberger <richard@nod.at>
Bcc: Russell King <linux@armlinux.org.uk>
Bcc: Sebastian Reichel <sre@kernel.org>
Bcc: Sergey Lapin <slapin@ossfans.org>
Bcc: Stephen Boyd <sboyd@kernel.org>
Bcc: Tomas Cech <sleep_walker@suse.com>
Bcc: Ulf Hansson <ulf.hansson@linaro.org>
Bcc: Vignesh Raghavendra <vigneshr@ti.com>
Bcc: Viresh Kumar <viresh.kumar@linaro.org>
Bcc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: linux-leds@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: linux-pm@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org

Arnd Bergmann (46):
  ARM: pxa: split mach/generic.h
  ARM: pxa: make mainstone.h private
  ARM: pxa: make mach/regs-uart.h private
  ARM: pxa: remove mach/dma.h
  ARM: pxa: split up mach/hardware.h
  ARM: pxa: stop using mach/bitfield.h
  ARM: pxa: move mach/sound.h to linux/platform_data/
  ARM: pxa: move regs-lcd.h into driver
  watchdog: sa1100: use platform device registration
  ARM: pxa: pxa2xx-ac97-lib: use IRQ resource
  ARM: pxa: cmx270: use platform device for nand
  ARM: pxa: make addr-map.h header local
  ARM: pxa: move pcmcia board data into mach-pxa
  ARM: pxa: use pdev resource for palmld mmio
  ARM: pxa: maybe fix gpio lookup tables
  ARM: pxa: tosa: use gpio descriptor for audio
  ARM: pxa: poodle: use platform data for poodle asoc driver
  ARM: pxa: corgi: use gpio descriptors for audio
  ARM: pxa: hx4700: use gpio descriptors for audio
  ARM: pxa: lubbock: pass udc irqs as resource
  ARM: pxa: spitz: use gpio descriptors for audio
  ARM: pxa: eseries: use gpio lookup for audio
  ARM: pxa: z2: use gpio lookup for audio device
  ARM: pxa: magician: use platform driver for audio
  ARM: pxa: mainstone-wm97xx: use gpio lookup table
  ARM: pxa: zylonite: use gpio lookup instead mfp header
  input: touchscreen: mainstone: fix pxa2xx+pxa3xx configuration
  input: touchscreen: mainstone: sync with zylonite driver
  Input: touchscreen: use wrapper for pxa2xx ac97 registers
  SoC: pxa: use pdev resource for FIFO regs
  ASoC: pxa: ac97: use normal MMIO accessors
  ASoC: pxa: i2s: use normal MMIO accessors
  ARM: pxa: pcmcia: move smemc configuration back to arch
  ARM: pxa: remove get_clk_frequency_khz()
  cpufreq: pxa3: move clk register access to clk driver
  ARM: pxa: move smemc register access from clk to platform
  ARM: pxa: move clk register definitions to driver
  video: backlight: tosa: use gpio lookup table
  power: tosa: simplify probe function
  ARM: pxa: tosa: use gpio lookup for battery
  ARM: pxa: move it8152 PCI support into machine
  ARM: pxa: remove unused mach/bitfield.h
  ARM: pxa: pci-it8152: add platform checks
  ARM: mmp: remove tavorevb board support
  ARM: mmp: rename pxa_register_device
  ARM: pxa: move plat-pxa to drivers/soc/

 arch/arm/Kconfig                              |   9 -
 arch/arm/Makefile                             |   1 -
 arch/arm/common/Makefile                      |   1 -
 arch/arm/common/locomo.c                      |   1 -
 arch/arm/common/sa1111.c                      |   5 +-
 arch/arm/include/asm/hardware/sa1111.h        |   2 -
 arch/arm/mach-mmp/Kconfig                     |  10 +-
 arch/arm/mach-mmp/Makefile                    |   1 -
 arch/arm/mach-mmp/devices.c                   |   2 +-
 arch/arm/mach-mmp/devices.h                   |  10 +-
 arch/arm/mach-mmp/mfp.h                       |   2 +-
 arch/arm/mach-mmp/mmp2.h                      |  48 ++---
 arch/arm/mach-mmp/pxa168.h                    |  60 +++---
 arch/arm/mach-mmp/pxa910.h                    |  38 ++--
 arch/arm/mach-mmp/tavorevb.c                  | 113 -----------
 arch/arm/mach-mmp/ttc_dkb.c                   |   6 +-
 arch/arm/mach-pxa/Kconfig                     |   8 +-
 arch/arm/mach-pxa/Makefile                    |  22 +-
 .../mach-pxa/{include/mach => }/addr-map.h    |   0
 .../arm/mach-pxa/balloon3-pcmcia.c            |   4 +-
 arch/arm/mach-pxa/balloon3.c                  |   4 +-
 .../mach-pxa/{include/mach => }/balloon3.h    |   2 +-
 arch/arm/mach-pxa/cm-x270.c                   |  25 +++
 arch/arm/mach-pxa/cm-x2xx-pci.c               |   2 +-
 arch/arm/mach-pxa/cm-x2xx.c                   |   7 +-
 arch/arm/mach-pxa/cm-x300.c                   |  12 +-
 .../arm/mach-pxa/cm_x255-pcmcia.c             |   2 +-
 .../arm/mach-pxa/cm_x270-pcmcia.c             |   2 +-
 .../arm/mach-pxa/cm_x2xx-pcmcia.c             |   2 +-
 arch/arm/mach-pxa/colibri-evalboard.c         |   1 -
 .../arm/mach-pxa/colibri-pcmcia.c             |   2 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c     |   1 -
 arch/arm/mach-pxa/colibri-pxa270.c            |   2 +-
 arch/arm/mach-pxa/colibri-pxa300.c            |   3 +-
 arch/arm/mach-pxa/colibri-pxa320.c            |   2 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c            |   1 -
 arch/arm/mach-pxa/corgi.c                     |  23 ++-
 arch/arm/mach-pxa/{include/mach => }/corgi.h  |   2 +-
 arch/arm/mach-pxa/corgi_pm.c                  |   3 +-
 arch/arm/mach-pxa/csb726.c                    |   3 +-
 arch/arm/mach-pxa/devices.c                   |  15 +-
 .../arm/mach-pxa/e740-pcmcia.c                |   2 +-
 arch/arm/mach-pxa/em-x270.c                   |   2 +-
 arch/arm/mach-pxa/eseries.c                   |  34 +++-
 arch/arm/mach-pxa/ezx.c                       |   1 -
 arch/arm/mach-pxa/generic.c                   |  78 ++++++--
 arch/arm/mach-pxa/generic.h                   |   9 -
 arch/arm/mach-pxa/gumstix.c                   |   1 -
 .../arm/mach-pxa/hx4700-pcmcia.c              |   4 +-
 arch/arm/mach-pxa/hx4700.c                    |  18 +-
 arch/arm/mach-pxa/{include/mach => }/hx4700.h |   2 +-
 arch/arm/mach-pxa/idp.c                       |   2 -
 arch/arm/mach-pxa/include/mach/bitfield.h     | 114 -----------
 arch/arm/mach-pxa/include/mach/dma.h          |  17 --
 arch/arm/mach-pxa/include/mach/generic.h      |   1 -
 arch/arm/mach-pxa/include/mach/mfp.h          |   2 +-
 arch/arm/mach-pxa/include/mach/pxa-regs.h     |  52 +++++
 arch/arm/mach-pxa/include/mach/pxa2xx-regs.h  |  47 +----
 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h  |  71 +------
 arch/arm/mach-pxa/include/mach/regs-ost.h     |   4 +-
 arch/arm/mach-pxa/include/mach/reset.h        |   2 +-
 arch/arm/mach-pxa/include/mach/tosa.h         |  15 --
 arch/arm/mach-pxa/irq.c                       |   3 +-
 arch/arm/mach-pxa/littleton.c                 |   1 -
 arch/arm/mach-pxa/lpd270.c                    |   4 +-
 arch/arm/mach-pxa/lubbock.c                   |  15 +-
 .../arm/mach-pxa/{include/mach => }/lubbock.h |   2 -
 arch/arm/mach-pxa/magician.c                  |  54 ++++-
 arch/arm/mach-pxa/mainstone.c                 |  15 +-
 .../mach-pxa/{include/mach => }/mainstone.h   |   2 -
 arch/arm/mach-pxa/mfp-pxa2xx.c                |   1 +
 arch/arm/mach-pxa/mfp-pxa2xx.h                |   2 +-
 arch/arm/mach-pxa/mfp-pxa3xx.c                |   1 -
 arch/arm/mach-pxa/mfp-pxa3xx.h                |   2 +-
 arch/arm/mach-pxa/mioa701.c                   |   2 +-
 arch/arm/mach-pxa/mxm8x10.c                   |   8 +-
 arch/arm/mach-pxa/palm27x.c                   |   2 +-
 .../arm/mach-pxa/palmld-pcmcia.c              |   5 +-
 arch/arm/mach-pxa/palmld.c                    |  23 ++-
 arch/arm/mach-pxa/{include/mach => }/palmld.h |   2 +-
 arch/arm/mach-pxa/palmt5.c                    |  11 +-
 .../arm/mach-pxa/palmtc-pcmcia.c              |   4 +-
 arch/arm/mach-pxa/palmtc.c                    |   4 +-
 arch/arm/mach-pxa/{include/mach => }/palmtc.h |   2 +-
 arch/arm/mach-pxa/palmte2.c                   |   2 +-
 arch/arm/mach-pxa/palmtreo.c                  |   2 +-
 .../arm/mach-pxa/palmtx-pcmcia.c              |   4 +-
 arch/arm/mach-pxa/palmtx.c                    |  13 +-
 arch/arm/mach-pxa/{include/mach => }/palmtx.h |   2 +-
 arch/arm/mach-pxa/palmz72.c                   |   2 +-
 .../it8152.c => mach-pxa/pci-it8152.c}        |  25 ++-
 .../it8152.h => mach-pxa/pci-it8152.h}        |   2 -
 arch/arm/mach-pxa/pcm990-baseboard.c          |   2 +-
 arch/arm/mach-pxa/poodle.c                    |  31 ++-
 arch/arm/mach-pxa/{include/mach => }/poodle.h |   4 +-
 arch/arm/mach-pxa/pxa-regs.h                  |   1 +
 arch/arm/mach-pxa/pxa25x.c                    |   6 +-
 arch/arm/mach-pxa/pxa25x.h                    |   2 +-
 arch/arm/mach-pxa/pxa27x-udc.h                |   2 +
 arch/arm/mach-pxa/pxa27x.c                    |   6 +-
 arch/arm/mach-pxa/pxa27x.h                    |   2 +-
 arch/arm/mach-pxa/pxa2xx.c                    |   1 -
 arch/arm/mach-pxa/pxa300.c                    |   1 +
 arch/arm/mach-pxa/pxa320.c                    |   1 +
 arch/arm/mach-pxa/pxa3xx-ulpi.c               |   2 +-
 arch/arm/mach-pxa/pxa3xx.c                    |  11 +-
 arch/arm/mach-pxa/pxa3xx.h                    |   2 +-
 arch/arm/mach-pxa/pxa930.c                    |   1 +
 arch/arm/mach-pxa/regs-rtc.h                  |   2 +-
 arch/arm/mach-pxa/regs-u2d.h                  |   2 -
 .../mach-pxa/{include/mach => }/regs-uart.h   |   2 +
 arch/arm/mach-pxa/reset.c                     |   3 -
 arch/arm/mach-pxa/sleep.S                     |   5 +-
 arch/arm/mach-pxa/smemc.c                     |  11 +-
 arch/arm/mach-pxa/spitz.c                     |  33 ++-
 arch/arm/mach-pxa/{include/mach => }/spitz.h  |   2 +-
 arch/arm/mach-pxa/spitz_pm.c                  |   3 +-
 arch/arm/mach-pxa/standby.S                   |   1 -
 .../arm/mach-pxa/stargate2-pcmcia.c           |   2 +-
 arch/arm/mach-pxa/tosa.c                      |  63 +++++-
 .../arm/mach-pxa/trizeps4-pcmcia.c            |   4 +-
 arch/arm/mach-pxa/trizeps4.c                  |   4 +-
 .../mach-pxa/{include/mach => }/trizeps4.h    |   3 +-
 .../arm/mach-pxa/viper-pcmcia.c               |   6 +-
 .../arm/mach-pxa/viper-pcmcia.h               |   0
 arch/arm/mach-pxa/viper.c                     |   8 +-
 .../arm/mach-pxa/vpac270-pcmcia.c             |   4 +-
 arch/arm/mach-pxa/vpac270.c                   |   4 +-
 .../arm/mach-pxa/{include/mach => }/vpac270.h |   0
 arch/arm/mach-pxa/xcep.c                      |   2 +-
 arch/arm/mach-pxa/z2.c                        |  11 +
 arch/arm/mach-pxa/zeus.c                      |   6 +-
 arch/arm/mach-pxa/zylonite.c                  |  34 +++-
 arch/arm/mach-pxa/zylonite.h                  |   2 +
 arch/arm/mach-pxa/zylonite_pxa300.c           |   1 +
 arch/arm/mach-pxa/zylonite_pxa320.c           |   1 +
 arch/arm/mach-sa1100/generic.c                |   6 +-
 arch/arm/mach-sa1100/include/mach/reset.h     |   1 -
 drivers/ata/pata_palmld.c                     |   3 +-
 drivers/clk/pxa/clk-pxa.c                     |   8 +-
 drivers/clk/pxa/clk-pxa.h                     |   9 +-
 drivers/clk/pxa/clk-pxa25x.c                  |  46 ++---
 drivers/clk/pxa/clk-pxa27x.c                  |  68 +++----
 drivers/clk/pxa/clk-pxa3xx.c                  | 139 +++++++++++--
 drivers/cpufreq/pxa2xx-cpufreq.c              |   6 +-
 drivers/cpufreq/pxa3xx-cpufreq.c              |  65 +++---
 drivers/input/mouse/pxa930_trkball.c          |   1 -
 drivers/input/touchscreen/Kconfig             |   2 +
 drivers/input/touchscreen/mainstone-wm97xx.c  | 123 ++++++------
 drivers/input/touchscreen/zylonite-wm97xx.c   |  34 ++--
 drivers/leds/leds-locomo.c                    |   1 -
 drivers/mmc/host/pxamci.c                     |   2 +-
 drivers/mtd/maps/pxa2xx-flash.c               |   2 -
 drivers/mtd/nand/raw/cmx270_nand.c            |  89 +++------
 drivers/pcmcia/Makefile                       |  16 --
 drivers/pcmcia/pxa2xx_base.c                  |  48 ++---
 drivers/pcmcia/pxa2xx_sharpsl.c               |   3 +-
 drivers/pcmcia/sa1111_generic.c               |   1 -
 drivers/pcmcia/sa1111_lubbock.c               |   1 -
 drivers/pcmcia/soc_common.c                   |   2 -
 drivers/pcmcia/soc_common.h                   | 120 +----------
 drivers/power/supply/tosa_battery.c           | 189 ++++++++++--------
 drivers/rtc/rtc-pxa.c                         |   2 -
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 .../arm/plat-pxa => drivers/soc/pxa}/Kconfig  |   5 +-
 .../arm/plat-pxa => drivers/soc/pxa}/Makefile |   4 -
 {arch/arm/plat-pxa => drivers/soc/pxa}/mfp.c  |   2 +-
 {arch/arm/plat-pxa => drivers/soc/pxa}/ssp.c  |   0
 drivers/usb/gadget/udc/pxa25x_udc.c           |  37 ++--
 drivers/usb/gadget/udc/pxa25x_udc.h           |   7 +-
 drivers/usb/host/ohci-pxa27x.c                |   3 +-
 drivers/video/backlight/tosa_bl.c             |  10 +-
 drivers/video/backlight/tosa_bl.h             |   8 +
 drivers/video/backlight/tosa_lcd.c            |  28 ++-
 .../video/fbdev/pxa3xx-regs.h                 |  24 +--
 drivers/video/fbdev/pxafb.c                   |   4 +-
 drivers/watchdog/sa1100_wdt.c                 |  88 +++++---
 include/linux/clk/pxa.h                       |  16 ++
 include/linux/platform_data/asoc-poodle.h     |  16 ++
 .../linux/platform_data/asoc-pxa.h            |   4 +-
 include/linux/platform_data/video-pxafb.h     |  22 +-
 .../hardware.h => include/linux/soc/pxa/cpu.h |  61 +-----
 .../plat => include/linux/soc/pxa}/mfp.h      |   6 +-
 include/linux/soc/pxa/smemc.h                 |  13 ++
 include/pcmcia/soc_common.h                   | 125 ++++++++++++
 include/sound/pxa2xx-lib.h                    |   4 +
 sound/arm/pxa2xx-ac97-lib.c                   | 145 +++++++++-----
 .../arm/pxa2xx-ac97-regs.h                    |  42 ++--
 sound/arm/pxa2xx-ac97.c                       |   3 +-
 sound/soc/pxa/corgi.c                         |  42 ++--
 sound/soc/pxa/e740_wm9705.c                   |  37 ++--
 sound/soc/pxa/e750_wm9705.c                   |  33 ++-
 sound/soc/pxa/e800_wm9712.c                   |  33 ++-
 sound/soc/pxa/em-x270.c                       |   2 +-
 sound/soc/pxa/hx4700.c                        |  34 ++--
 sound/soc/pxa/magician.c                      | 141 ++++---------
 sound/soc/pxa/mioa701_wm9713.c                |   2 +-
 sound/soc/pxa/palm27x.c                       |   2 +-
 sound/soc/pxa/poodle.c                        |  51 ++---
 sound/soc/pxa/pxa2xx-ac97.c                   |  24 ++-
 sound/soc/pxa/pxa2xx-i2s.c                    | 112 ++++++-----
 sound/soc/pxa/spitz.c                         |  58 +++---
 sound/soc/pxa/tosa.c                          |  18 +-
 sound/soc/pxa/z2.c                            |   8 +-
 205 files changed, 1916 insertions(+), 1795 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/tavorevb.c
 rename arch/arm/mach-pxa/{include/mach => }/addr-map.h (100%)
 rename drivers/pcmcia/pxa2xx_balloon3.c => arch/arm/mach-pxa/balloon3-pcmcia.c (98%)
 rename arch/arm/mach-pxa/{include/mach => }/balloon3.h (99%)
 rename drivers/pcmcia/pxa2xx_cm_x255.c => arch/arm/mach-pxa/cm_x255-pcmcia.c (98%)
 rename drivers/pcmcia/pxa2xx_cm_x270.c => arch/arm/mach-pxa/cm_x270-pcmcia.c (98%)
 rename drivers/pcmcia/pxa2xx_cm_x2xx.c => arch/arm/mach-pxa/cm_x2xx-pcmcia.c (96%)
 rename drivers/pcmcia/pxa2xx_colibri.c => arch/arm/mach-pxa/colibri-pcmcia.c (99%)
 rename arch/arm/mach-pxa/{include/mach => }/corgi.h (98%)
 rename drivers/pcmcia/pxa2xx_e740.c => arch/arm/mach-pxa/e740-pcmcia.c (98%)
 rename drivers/pcmcia/pxa2xx_hx4700.c => arch/arm/mach-pxa/hx4700-pcmcia.c (98%)
 rename arch/arm/mach-pxa/{include/mach => }/hx4700.h (99%)
 delete mode 100644 arch/arm/mach-pxa/include/mach/bitfield.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/dma.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/generic.h
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa-regs.h
 rename arch/arm/mach-pxa/{include/mach => }/lubbock.h (97%)
 rename arch/arm/mach-pxa/{include/mach => }/mainstone.h (99%)
 rename drivers/pcmcia/pxa2xx_palmld.c => arch/arm/mach-pxa/palmld-pcmcia.c (98%)
 rename arch/arm/mach-pxa/{include/mach => }/palmld.h (98%)
 rename drivers/pcmcia/pxa2xx_palmtc.c => arch/arm/mach-pxa/palmtc-pcmcia.c (98%)
 rename arch/arm/mach-pxa/{include/mach => }/palmtc.h (98%)
 rename drivers/pcmcia/pxa2xx_palmtx.c => arch/arm/mach-pxa/palmtx-pcmcia.c (98%)
 rename arch/arm/mach-pxa/{include/mach => }/palmtx.h (98%)
 rename arch/arm/{common/it8152.c => mach-pxa/pci-it8152.c} (95%)
 rename arch/arm/{include/asm/hardware/it8152.h => mach-pxa/pci-it8152.h} (98%)
 rename arch/arm/mach-pxa/{include/mach => }/poodle.h (97%)
 create mode 100644 arch/arm/mach-pxa/pxa-regs.h
 rename arch/arm/mach-pxa/{include/mach => }/regs-uart.h (99%)
 rename arch/arm/mach-pxa/{include/mach => }/spitz.h (99%)
 rename drivers/pcmcia/pxa2xx_stargate2.c => arch/arm/mach-pxa/stargate2-pcmcia.c (99%)
 rename drivers/pcmcia/pxa2xx_trizeps4.c => arch/arm/mach-pxa/trizeps4-pcmcia.c (98%)
 rename arch/arm/mach-pxa/{include/mach => }/trizeps4.h (98%)
 rename drivers/pcmcia/pxa2xx_viper.c => arch/arm/mach-pxa/viper-pcmcia.c (97%)
 rename include/linux/platform_data/pcmcia-pxa2xx_viper.h => arch/arm/mach-pxa/viper-pcmcia.h (100%)
 rename drivers/pcmcia/pxa2xx_vpac270.c => arch/arm/mach-pxa/vpac270-pcmcia.c (98%)
 rename arch/arm/mach-pxa/{include/mach => }/vpac270.h (100%)
 rename {arch/arm/plat-pxa => drivers/soc/pxa}/Kconfig (83%)
 rename {arch/arm/plat-pxa => drivers/soc/pxa}/Makefile (51%)
 rename {arch/arm/plat-pxa => drivers/soc/pxa}/mfp.c (99%)
 rename {arch/arm/plat-pxa => drivers/soc/pxa}/ssp.c (100%)
 create mode 100644 drivers/video/backlight/tosa_bl.h
 rename arch/arm/mach-pxa/include/mach/regs-lcd.h => drivers/video/fbdev/pxa3xx-regs.h (90%)
 create mode 100644 include/linux/clk/pxa.h
 create mode 100644 include/linux/platform_data/asoc-poodle.h
 rename arch/arm/mach-pxa/include/mach/audio.h => include/linux/platform_data/asoc-pxa.h (93%)
 rename arch/arm/mach-pxa/include/mach/hardware.h => include/linux/soc/pxa/cpu.h (75%)
 rename {arch/arm/plat-pxa/include/plat => include/linux/soc/pxa}/mfp.h (98%)
 create mode 100644 include/linux/soc/pxa/smemc.h
 create mode 100644 include/pcmcia/soc_common.h
 rename arch/arm/mach-pxa/include/mach/regs-ac97.h => sound/arm/pxa2xx-ac97-regs.h (71%)

-- 
2.20.0

