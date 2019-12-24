Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB412A25C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2019 15:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfLXOg0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Dec 2019 09:36:26 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44618 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLXOgZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Dec 2019 09:36:25 -0500
Received: by mail-il1-f196.google.com with SMTP id z12so16670606iln.11;
        Tue, 24 Dec 2019 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9zkxlG0xGgO+RRXE1qCUqKdI6X1YDvo84gC40D1YMA=;
        b=UENJhR05eMmRMNkdU0xPT2lQ/MGiaGVITW2wEVcWT6xP2cqYXBd21PJhRVC920AKui
         la7e9Rbd+AfDd4SZoUH84TqdjqDPvRRMkYrkv7tFNQ8XGe9rHSDuyWhs6MK5iSVg9U48
         E+zo3OfxE/aZLdAmkAoXF9lHEFGfUw1IDWAmjEiHRMtL12Z64BzbYacl8cOXf3+45rxM
         d/0cKP7ASJBLO6vWHdaqomKHvQ//Ky+qhfbT1LjXuJ/BaTyeqVOSNREBybSbNeB3YfNp
         0W+/QEW1BOW0GzCqgcp1MFbhlPpxXBdxr4EjyiBxplu8yhKY93f6gPA8bRE3FCQcfWPp
         588w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9zkxlG0xGgO+RRXE1qCUqKdI6X1YDvo84gC40D1YMA=;
        b=f6ov9Enz63COcAeZQ3ryU2TiJYCIx/l9Me88mLln3yP9R1ieH6JYLZ1MVogKqqoFNp
         zzLTMj6JLyHVtqG/qnHmCzb43PUU2LCDdGkCHHJhgSLmQUiZQ+3XNUXA/qlYKRzjEUlo
         MqknOL4VFKE9bdDH3td77+IVafWHLLQ2ZwXxIxlPjfxUagCdYEijmDkiJjD0fGpj9dih
         TxrGU5sOK53j5lhdYPeqWXSoFjdw0espSQZDiCeo+7Mk7KMSNk8bJpUM5TdZ5+Jrre4t
         QV3OtnUOUATAwDpjuZLM1GlNASjlQa+7Fn3hj7zkjen9DyWznGBodXM20iN7W3qzYSnO
         03Cg==
X-Gm-Message-State: APjAAAVuOdePSmLI+Hmf9PP+z9MIwtcM4BBfJNB3yquW68Jxjbcwgpcn
        ggmY69kh1erXUUKvVHRrKEiHwAPUaSNDiZoOTbg=
X-Google-Smtp-Source: APXvYqxG8pDiLHd5VSObHKHTgDMwnSvIsqwUj8mvUXwF+9cHnHTohFIFhPuHUPAw+Ib0CQ5GMcRS40lNr5fQh583H3g=
X-Received: by 2002:a92:1a0a:: with SMTP id a10mr30442586ila.295.1577198184778;
 Tue, 24 Dec 2019 06:36:24 -0800 (PST)
MIME-Version: 1.0
References: <20191219172823.1652600-1-anarsoul@gmail.com> <20191224131155.GA17359@Red>
In-Reply-To: <20191224131155.GA17359@Red>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 24 Dec 2019 22:36:13 +0800
Message-ID: <CAEExFWsN5-YNG0KQ7aZH8AUWpVudqkSx1G9dmaa7jnEp08K1hQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 24, 2019 at 9:11 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> On Thu, Dec 19, 2019 at 09:28:16AM -0800, Vasily Khoruzhick wrote:
> > This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> > H6 and R40 SoCs.
> >
> > v8:
> >       - [vasily] Address more Maxime's comments for dt-schema
> >       - [vasily] Add myself to MAINTAINERS for the driver and schema
> >       - [vasily] Round calibration data size to word boundary for H6 and A64
> >       - [vasily] Change offset for A64 since it reports too low temp otherwise.
> >                  Likely conversion formula in user manual is not correct.
> >
> > v7:
> >       - [vasily] Address Maxime's comments for dt-schema
> >       - [vasily] Move common part of H3 and H5 dts into sunxi-h3-h5.dtsi
> >       - [vasily] Add Maxime's a-b to the driver patch
> >
> > v6:
> >       - [ondrej, vasily] Squash all driver related changes into a
> >                          single patch
> >       - [ondrej] Rename calib -> calibration
> >       - [ondrej] Fix thermal zone registration check
> >       - [ondrej] Lower rate of sensor data interrupts to 4/sec/sensor
> >       - [ondrej] Rework scale/offset values, H6 calibration
> >       - [ondrej] Explicitly set mod clock to 24 MHz
> >       - [ondrej] Set undocumented bits in CTRL0 for H6
> >       - [ondrej] Add support for A83T
> >       - [ondrej] Add dts changes for A83T, H3, H5, H6
> >       - [vasily] Add dts changes for A64
> >       - [vasily] Address Maxime's comments for YAML scheme
> >       - [vasily] Make .calc_temp callback mandatory
> >       - [vasily] Set .max_register in regmap config, so regs can be
> >                  inspected using debugfs
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
>
> Hello
>
> Thanks for your work.
>
> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Tested-on: sun50i-h6-pine-h64-model-b
> Tested-on: sun50i-h6-pine-h64
> Tested-on: sun8i-a83t-bananapi-m3
> Tested-on: sun8i-h2-plus-orangepi-zero
> Tested-on: sun8i-h2-plus-orangepi-r1
> Tested-on: sun8i-h2-plus-libretech-all-h3-cc
> Tested-on: sun8i-h3-libretech-all-h3-cc
> Tested-on: sun50i-h5-libretech-all-h3-cc
> Tested-on: sun50i-a64-pine64-plus
>
> Note that your patch serie support R40 but you do not have any R40 DT patch.
> If you need testing, do not hesitate to ask.

How about this?  No one has yet added the R40's SID, and I'm not sure about
the available size of the sid. So the current therm sensor is not calibrated,
hope this is available.

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 421dfbbfd7ee..8ccda5cb873f 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -46,6 +46,7 @@
 #include <dt-bindings/clock/sun8i-r40-ccu.h>
 #include <dt-bindings/reset/sun8i-r40-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
+#include <dt-bindings/thermal/thermal.h>

 / {
        #address-cells = <1>;
@@ -109,6 +110,22 @@
                status = "disabled";
        };

+       thermal-zones {
+               cpu_thermal: cpu0-thermal {
+                       /* milliseconds */
+                       polling-delay-passive = <0>;
+                       polling-delay = <0>;
+                       thermal-sensors = <&ths 0>;
+               };
+
+               gpu_thermal: gpu-thermal {
+                       /* milliseconds */
+                       polling-delay-passive = <0>;
+                       polling-delay = <0>;
+                       thermal-sensors = <&ths 1>;
+               };
+       };
+
        soc {
                compatible = "simple-bus";
                #address-cells = <1>;
@@ -421,6 +438,17 @@
                        clocks = <&osc24M>;
                };

+               ths: thermal-sensor@1c24c00 {
+                       compatible = "allwinner,sun8i-r40-ths";
+                       reg = <0x01c24c00 0x100>;
+                       clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+                       clock-names = "bus", "mod";
+                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+                       resets = <&ccu RST_BUS_THS>;
+                       /* TODO: add nvmem-cells for calibration */
+                       #thermal-sensor-cells = <1>;
+               };
+
                uart0: serial@1c28000 {
                        compatible = "snps,dw-apb-uart";
                        reg = <0x01c28000 0x400>;
diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 23a5f4aa4be4..c5661d7c3e20 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -565,7 +565,7 @@ static const struct ths_thermal_chip sun8i_h3_ths = {
 };

 static const struct ths_thermal_chip sun8i_r40_ths = {
-       .sensor_num = 3,
+       .sensor_num = 2,
        .offset = 251086,
        .scale = 1130,
        .has_mod_clk = true,

MBR,
Yangtao

>
> Regards
