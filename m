Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3631257A3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 00:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLRXSt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 18:18:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40853 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRXSt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 18:18:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id c17so3083507qkg.7;
        Wed, 18 Dec 2019 15:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuyhYd8ECto87m9FuniOXYcBUixqQrUKuyD3AyEWA+A=;
        b=QEJ84Ho9x2u+RDV0L3fVLJ/07KGc8v4ji6189tqfgBzY4T9Zch4GF0ICOVmQiedFkK
         gO4tHFmI5AKY1yHkS5HmwQYH5w099hrSeCmDSLxdHK49ZwJao7LsADt7eFeAk/l3l3Lx
         vhmh1Z55xZ84AoRvPI0kPvYKhWj8/DEvynF8GDGjLZ28A7MxDzE5QZqE8bB348T9Imec
         VnKMOX6inmmxlz1s98+0hVZIcvQEJGNBImQ2V453cN632C6Nk8Vlvesscm4QA8Qmo1aG
         s935HuQHKFwUR6y/qra3A6ib1CF+reB133B+j1W732GGg527pTNwiD0EPZtT4A/ENTwb
         HI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuyhYd8ECto87m9FuniOXYcBUixqQrUKuyD3AyEWA+A=;
        b=AdbTIV/My4gq9e6F6I+H3/AK4Ibxnw9ITKL/pBYe+shdJV5b4/8GqWvVp90vRgNXHi
         RZ5A5oZ77y6Kkk2o71jos+SJhomS89dMPyKt6LJMET2S0l3eqcLuQZXauVRdplrKgKPq
         a1llnLSM5Sts8KgfKzb+vWBV5tAZ5Jc2k9bN+aa4BM/pgykzP+AqotlRXWvfklnBGRNB
         7tB9ebXgcVorsNOIFWhC0LVRqLFjNwwcOzSUwDLjSLBov10Jd+rIE/Y1kswxVqG4QVX3
         w9D4wslkO5QnJwfMsBL//PfFBM48XaWW+o+sJOFdzPLmYs+vcjnUpJp0Mmm9HqSgJVD+
         epdg==
X-Gm-Message-State: APjAAAXb+m//97Z1QyMra/nVsovHQNu91tak3TeMs4obMPoEf1pMJ2PS
        iYeCQd3nNWRChlunPDpgHch34WklXSjHc8kXX38=
X-Google-Smtp-Source: APXvYqxmCgCcV71Y46Kd1h7x1kMPtfJ8a/HJjus1Y1SOXueUfBb+NFUsWJq8OEdBjSxCnnR0qVG1fuTHKRUTczc2+cE=
X-Received: by 2002:a37:5d0:: with SMTP id 199mr5281279qkf.131.1576711128403;
 Wed, 18 Dec 2019 15:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20191218042121.1471954-1-anarsoul@gmail.com> <20191218042121.1471954-7-anarsoul@gmail.com>
 <CAGb2v65Qv6_KQ_MPg0u37P+o5gnnQWhbifOrY6g5FiWvnadmiw@mail.gmail.com>
In-Reply-To: <CAGb2v65Qv6_KQ_MPg0u37P+o5gnnQWhbifOrY6g5FiWvnadmiw@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 18 Dec 2019 15:18:51 -0800
Message-ID: <CA+E=qVdKwkUSsG9WA_4x5QntaOxQqfH1eZQ7TEeUrM_3W5mqTg@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] arm64: dts: allwinner: h6: Add thermal sensor and
 thermal zones
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
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
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 17, 2019 at 8:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Dec 18, 2019 at 12:22 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > From: Ondrej Jirman <megous@megous.com>
> >
> > There are two sensors, one for CPU, one for GPU.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > index 29824081b43b..cdcb1a36301a 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -11,6 +11,7 @@
> >  #include <dt-bindings/reset/sun50i-h6-ccu.h>
> >  #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> >  #include <dt-bindings/reset/sun8i-de2.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >         interrupt-parent = <&gic>;
> > @@ -233,6 +234,12 @@ dma: dma-controller@3002000 {
> >                 sid: efuse@3006000 {
> >                         compatible = "allwinner,sun50i-h6-sid";
> >                         reg = <0x03006000 0x400>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +
> > +                       ths_calibration: thermal-sensor-calibration@14 {
> > +                               reg = <0x14 0x6>;
>
> Nit: my preference is to use words as the smallest increment, so this
> would have a size of 8 instead of 6. Same goes for the A64 dts.
>
> AFAICT this doesn't impact the driver in any way.

H6 has only 2 sensors, so it should be 4. That's my overlook, I'll
change it to 4 for H6 and to 8 for A64.

>
> ChenYu
>
>
> > +                       };
> >                 };
> >
> >                 watchdog: watchdog@30090a0 {
> > @@ -856,5 +863,31 @@ r_i2c: i2c@7081400 {
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >                 };
> > +
> > +               ths: thermal-sensor@5070400 {
> > +                       compatible = "allwinner,sun50i-h6-ths";
> > +                       reg = <0x05070400 0x100>;
> > +                       interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&ccu CLK_BUS_THS>;
> > +                       clock-names = "bus";
> > +                       resets = <&ccu RST_BUS_THS>;
> > +                       nvmem-cells = <&ths_calibration>;
> > +                       nvmem-cell-names = "calibration";
> > +                       #thermal-sensor-cells = <1>;
> > +               };
> > +       };
> > +
> > +       thermal-zones {
> > +               cpu-thermal {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&ths 0>;
> > +               };
> > +
> > +               gpu-thermal {
> > +                       polling-delay-passive = <0>;
> > +                       polling-delay = <0>;
> > +                       thermal-sensors = <&ths 1>;
> > +               };
> >         };
> >  };
> > --
> > 2.24.1
> >
