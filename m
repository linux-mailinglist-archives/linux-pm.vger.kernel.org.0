Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC64E1548C8
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 17:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBFQFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 11:05:45 -0500
Received: from vps.xff.cz ([195.181.215.36]:39630 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbgBFQFp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Feb 2020 11:05:45 -0500
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 11:05:44 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1581004623; bh=Haoacbj1oR8jAZ/+z1mMEH6C0wNO66P8twZW4816v38=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=SmyZvJrvntWZ9bg2ivEI9G8FdrqYkMwCdVplGX9cdlFGyBFEYe7Babbv6FSFyp4mA
         OOMKGASHg+sg5L6nP6hU7A2jcRM8CZJuHneiLn3DBqzQoRM2LmTusOqG2mF9j2ZglU
         1OwCIBmNyEYhTjoLwPqYohjmiLBWdWlj54jW1j88=
Date:   Thu, 6 Feb 2020 16:57:03 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
Message-ID: <20200206155703.fyry7nh473mc7pqy@core.my.home>
Mail-Followup-To: Amit Kucheria <amit.kucheria@verdurent.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
 <CAHLCerPWEDqEE8LRUiO5GpeP+BfnestocndBQq6oXAxVN=+3ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerPWEDqEE8LRUiO5GpeP+BfnestocndBQq6oXAxVN=+3ow@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Amit,

On Thu, Feb 06, 2020 at 07:43:59PM +0530, Amit Kucheria wrote:
> Hi Vasily,
> 
> For this entire series, the DTS files don't contain any trip points.
> Did I miss some other series?
> 
> At a minimum, you should add some "hot" or "critical" trip points
> since then don't require a cooling-map with throttling actions. If you
> have "passive" trip points, then you need to provide cooling-maps.
> 
> Since this series has been merged, could you please follow up with a
> fixup series to add the trip points?

I don't think lack of trip points causes runtime issues. Or does it? I planned
to send update with some trip points and cooling maps for 5.7 merge window.
Is this acceptable?

If not, I can send a patch that adds:

+ trips {
+         cpu-very-hot {
+                 temperature = <100000>;
+                 hysteresis = <0>;
+                 type = "critical";
+         };
+ };

and 

+ trips {
+         gpu-very-hot {
+                 temperature = <100000>;
+                 hysteresis = <0>;
+                 type = "critical";
+         };
+ };

everywhere where appropriate. Though that will make rebase of out of
tree patches that already have a more complicated setup to be sent for the next
merge window a bit tedious.

thank you,
	Ondrej

> Regards,
> Amit
> p.s. We should catch all this automatically, I'll send out yaml
> bindings for the thermal framework soon that should catch this stuff.
> 
> On Thu, Dec 19, 2019 at 10:58 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> > H6 and R40 SoCs.
> >
> > v8:
> >         - [vasily] Address more Maxime's comments for dt-schema
> >         - [vasily] Add myself to MAINTAINERS for the driver and schema
> >         - [vasily] Round calibration data size to word boundary for H6 and A64
> >         - [vasily] Change offset for A64 since it reports too low temp otherwise.
> >                    Likely conversion formula in user manual is not correct.
> >
> > v7:
> >         - [vasily] Address Maxime's comments for dt-schema
> >         - [vasily] Move common part of H3 and H5 dts into sunxi-h3-h5.dtsi
> >         - [vasily] Add Maxime's a-b to the driver patch
> >
> > v6:
> >         - [ondrej, vasily] Squash all driver related changes into a
> >                            single patch
> >         - [ondrej] Rename calib -> calibration
> >         - [ondrej] Fix thermal zone registration check
> >         - [ondrej] Lower rate of sensor data interrupts to 4/sec/sensor
> >         - [ondrej] Rework scale/offset values, H6 calibration
> >         - [ondrej] Explicitly set mod clock to 24 MHz
> >         - [ondrej] Set undocumented bits in CTRL0 for H6
> >         - [ondrej] Add support for A83T
> >         - [ondrej] Add dts changes for A83T, H3, H5, H6
> >         - [vasily] Add dts changes for A64
> >         - [vasily] Address Maxime's comments for YAML scheme
> >         - [vasily] Make .calc_temp callback mandatory
> >         - [vasily] Set .max_register in regmap config, so regs can be
> >                    inspected using debugfs
> >
> > Ondrej Jirman (4):
> >   ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
> >   ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
> >   arm64: dts: allwinner: h5: Add thermal sensor and thermal zones
> >   arm64: dts: allwinner: h6: Add thermal sensor and thermal zones
> >
> > Vasily Khoruzhick (1):
> >   arm64: dts: allwinner: a64: Add thermal sensors and thermal zones
> >
> > Yangtao Li (2):
> >   thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
> >   dt-bindings: thermal: add YAML schema for sun8i-thermal driver
> >     bindings
> >
> >  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 160 +++++
> >  MAINTAINERS                                   |   8 +
> >  arch/arm/boot/dts/sun8i-a83t.dtsi             |  36 +
> >  arch/arm/boot/dts/sun8i-h3.dtsi               |  20 +
> >  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |   6 +
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  42 ++
> >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  26 +
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 +
> >  drivers/thermal/Kconfig                       |  14 +
> >  drivers/thermal/Makefile                      |   1 +
> >  drivers/thermal/sun8i_thermal.c               | 639 ++++++++++++++++++
> >  11 files changed, 985 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> >  create mode 100644 drivers/thermal/sun8i_thermal.c
> >
> > --
> > 2.24.1
> >
