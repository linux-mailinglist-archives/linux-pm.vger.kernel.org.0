Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E13125902
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLSBDZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:03:25 -0500
Received: from vps.xff.cz ([195.181.215.36]:41788 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfLSBDY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 20:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1576717401; bh=hTtYEKPfKcEQF9zxM3iLzPQCOmc0v1ZBKSXbqSJHaxk=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=U716KQDW0NA1TYZk7/LCB8IjiqPyVfh9ZWp0+sI9GXC506EcUxTq1F+OZsKQRtAu/
         Yajp1L7cH5MqaUqoqofwt4pNzAdsOS9z3h8zPpFu6tlAYgFipDLkk7z6riPtwr9VNd
         zTYBOItSg+xmlAc37i9nGe0+tpt1nuvwHkQ2C2Iw=
Date:   Thu, 19 Dec 2019 02:03:21 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] arm64: dts: allwinner: h6: Add thermal sensor and
 thermal zones
Message-ID: <20191219010321.kri5e7knjhc5d6ts@core.my.home>
Mail-Followup-To: Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20191218042121.1471954-1-anarsoul@gmail.com>
 <20191218042121.1471954-7-anarsoul@gmail.com>
 <CAGb2v65Qv6_KQ_MPg0u37P+o5gnnQWhbifOrY6g5FiWvnadmiw@mail.gmail.com>
 <CA+E=qVdKwkUSsG9WA_4x5QntaOxQqfH1eZQ7TEeUrM_3W5mqTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E=qVdKwkUSsG9WA_4x5QntaOxQqfH1eZQ7TEeUrM_3W5mqTg@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 18, 2019 at 03:18:51PM -0800, Vasily Khoruzhick wrote:
> On Tue, Dec 17, 2019 at 8:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Wed, Dec 18, 2019 at 12:22 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > >
> > > From: Ondrej Jirman <megous@megous.com>
> > >
> > > There are two sensors, one for CPU, one for GPU.
> > >
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > index 29824081b43b..cdcb1a36301a 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -11,6 +11,7 @@
> > >  #include <dt-bindings/reset/sun50i-h6-ccu.h>
> > >  #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > >  #include <dt-bindings/reset/sun8i-de2.h>
> > > +#include <dt-bindings/thermal/thermal.h>
> > >
> > >  / {
> > >         interrupt-parent = <&gic>;
> > > @@ -233,6 +234,12 @@ dma: dma-controller@3002000 {
> > >                 sid: efuse@3006000 {
> > >                         compatible = "allwinner,sun50i-h6-sid";
> > >                         reg = <0x03006000 0x400>;
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <1>;
> > > +
> > > +                       ths_calibration: thermal-sensor-calibration@14 {
> > > +                               reg = <0x14 0x6>;
> >
> > Nit: my preference is to use words as the smallest increment, so this
> > would have a size of 8 instead of 6. Same goes for the A64 dts.
> >
> > AFAICT this doesn't impact the driver in any way.
> 
> H6 has only 2 sensors, so it should be 4. That's my overlook, I'll
> change it to 4 for H6 and to 8 for A64.

No it's correct. There's 2 bytes reference temperature and 2x 2 byte
values for individual sensor calibration constants.

regards,
	o.

> >
> > ChenYu
> >
> >
> > > +                       };
> > >                 };
> > >
> > >                 watchdog: watchdog@30090a0 {
> > > @@ -856,5 +863,31 @@ r_i2c: i2c@7081400 {
> > >                         #address-cells = <1>;
> > >                         #size-cells = <0>;
> > >                 };
> > > +
> > > +               ths: thermal-sensor@5070400 {
> > > +                       compatible = "allwinner,sun50i-h6-ths";
> > > +                       reg = <0x05070400 0x100>;
> > > +                       interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> > > +                       clocks = <&ccu CLK_BUS_THS>;
> > > +                       clock-names = "bus";
> > > +                       resets = <&ccu RST_BUS_THS>;
> > > +                       nvmem-cells = <&ths_calibration>;
> > > +                       nvmem-cell-names = "calibration";
> > > +                       #thermal-sensor-cells = <1>;
> > > +               };
> > > +       };
> > > +
> > > +       thermal-zones {
> > > +               cpu-thermal {
> > > +                       polling-delay-passive = <0>;
> > > +                       polling-delay = <0>;
> > > +                       thermal-sensors = <&ths 0>;
> > > +               };
> > > +
> > > +               gpu-thermal {
> > > +                       polling-delay-passive = <0>;
> > > +                       polling-delay = <0>;
> > > +                       thermal-sensors = <&ths 1>;
> > > +               };
> > >         };
> > >  };
> > > --
> > > 2.24.1
> > >
