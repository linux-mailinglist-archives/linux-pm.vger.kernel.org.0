Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 090741259C4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 04:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLSDAE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 18 Dec 2019 22:00:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33828 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSDAE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 22:00:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id l8so3416569edw.1;
        Wed, 18 Dec 2019 19:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g1k0BfhD91RWdaRPR5uZq9FkzKab5ZId9wcg8EwMfWw=;
        b=uQeck9UNa+wscfergSST6J8GX+OoiCm8RRW+ysCIEFejoGWP020UHQ+MYFaSUQkBpc
         BNP/T5iX7BQKsbziNrxF3rX+D4ygqcwiCyyNp11iFKSKGiJLGd+87SdGV+zsqzTHigVE
         d9lOlyvBs3MhDaqC/TAMj/zxrrf2pf3/DdB6y533OlBq8As7S9tZKRTuuQjAfE1VSpQY
         oHBIvulf+myE8yvCXlN2TTwaaA2cSUI5mrDqVWV6wgVOfCBPJvUXYKddy0EsTlW3UjtG
         DxxDA2WbGqjg0Jo5ZRbo2VyE+CRo6Z2yiaaOG86XzKW1JDx+y0Xg83N0Ygk9f4C+jw+U
         g0rg==
X-Gm-Message-State: APjAAAUUH32JcJZK4rc7rqF+tJzOklCW8ibnqnKqJXwwHF37P2EVq/1J
        0S1blLkwvvq7MVVCdgjVi5caYUUSyJE=
X-Google-Smtp-Source: APXvYqxOrTmUmUDUDSgWAjMFlQI5wFXuqR+FgD5Yg60DEqnuoIp3UMBBtxs7GboUu8tl0QN5er1ZHA==
X-Received: by 2002:aa7:d04f:: with SMTP id n15mr6546789edo.76.1576724401088;
        Wed, 18 Dec 2019 19:00:01 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id w2sm140588eja.49.2019.12.18.19.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 19:00:00 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id p9so3913657wmc.2;
        Wed, 18 Dec 2019 19:00:00 -0800 (PST)
X-Received: by 2002:a1c:3c45:: with SMTP id j66mr6922931wma.2.1576724400195;
 Wed, 18 Dec 2019 19:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20191218042121.1471954-1-anarsoul@gmail.com> <20191218042121.1471954-7-anarsoul@gmail.com>
 <CAGb2v65Qv6_KQ_MPg0u37P+o5gnnQWhbifOrY6g5FiWvnadmiw@mail.gmail.com>
 <CA+E=qVdKwkUSsG9WA_4x5QntaOxQqfH1eZQ7TEeUrM_3W5mqTg@mail.gmail.com>
 <20191219010321.kri5e7knjhc5d6ts@core.my.home> <CA+E=qVf0LT26AoPtooTFcvZR_OGXbFVkMfXJuuoXvPvTSQMLBQ@mail.gmail.com>
In-Reply-To: <CA+E=qVf0LT26AoPtooTFcvZR_OGXbFVkMfXJuuoXvPvTSQMLBQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 19 Dec 2019 10:59:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v64iF+vZN3A9PfuV0NHmL9_M_bANueZDUnxZbZm8Sk2Uzw@mail.gmail.com>
Message-ID: <CAGb2v64iF+vZN3A9PfuV0NHmL9_M_bANueZDUnxZbZm8Sk2Uzw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] arm64: dts: allwinner: h6: Add thermal sensor and
 thermal zones
To:     Vasily Khoruzhick <anarsoul@gmail.com>
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
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 19, 2019 at 9:42 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Wed, Dec 18, 2019 at 5:03 PM Ondřej Jirman <megous@megous.com> wrote:
> >
> > On Wed, Dec 18, 2019 at 03:18:51PM -0800, Vasily Khoruzhick wrote:
> > > On Tue, Dec 17, 2019 at 8:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > >
> > > > On Wed, Dec 18, 2019 at 12:22 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > > > >
> > > > > From: Ondrej Jirman <megous@megous.com>
> > > > >
> > > > > There are two sensors, one for CPU, one for GPU.
> > > > >
> > > > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
> > > > >  1 file changed, 33 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > index 29824081b43b..cdcb1a36301a 100644
> > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > @@ -11,6 +11,7 @@
> > > > >  #include <dt-bindings/reset/sun50i-h6-ccu.h>
> > > > >  #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > > > >  #include <dt-bindings/reset/sun8i-de2.h>
> > > > > +#include <dt-bindings/thermal/thermal.h>
> > > > >
> > > > >  / {
> > > > >         interrupt-parent = <&gic>;
> > > > > @@ -233,6 +234,12 @@ dma: dma-controller@3002000 {
> > > > >                 sid: efuse@3006000 {
> > > > >                         compatible = "allwinner,sun50i-h6-sid";
> > > > >                         reg = <0x03006000 0x400>;
> > > > > +                       #address-cells = <1>;
> > > > > +                       #size-cells = <1>;
> > > > > +
> > > > > +                       ths_calibration: thermal-sensor-calibration@14 {
> > > > > +                               reg = <0x14 0x6>;
> > > >
> > > > Nit: my preference is to use words as the smallest increment, so this
> > > > would have a size of 8 instead of 6. Same goes for the A64 dts.
> > > >
> > > > AFAICT this doesn't impact the driver in any way.
> > >
> > > H6 has only 2 sensors, so it should be 4. That's my overlook, I'll
> > > change it to 4 for H6 and to 8 for A64.
> >
> > No it's correct. There's 2 bytes reference temperature and 2x 2 byte
> > values for individual sensor calibration constants.
>
> So it should be 8 if we round it up to word boundary?

That is correct.

> > regards,
> >         o.
> >
> > > >
> > > > ChenYu
> > > >
> > > >
> > > > > +                       };
> > > > >                 };
> > > > >
> > > > >                 watchdog: watchdog@30090a0 {
> > > > > @@ -856,5 +863,31 @@ r_i2c: i2c@7081400 {
> > > > >                         #address-cells = <1>;
> > > > >                         #size-cells = <0>;
> > > > >                 };
> > > > > +
> > > > > +               ths: thermal-sensor@5070400 {
> > > > > +                       compatible = "allwinner,sun50i-h6-ths";
> > > > > +                       reg = <0x05070400 0x100>;
> > > > > +                       interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +                       clocks = <&ccu CLK_BUS_THS>;
> > > > > +                       clock-names = "bus";
> > > > > +                       resets = <&ccu RST_BUS_THS>;
> > > > > +                       nvmem-cells = <&ths_calibration>;
> > > > > +                       nvmem-cell-names = "calibration";
> > > > > +                       #thermal-sensor-cells = <1>;
> > > > > +               };
> > > > > +       };
> > > > > +
> > > > > +       thermal-zones {
> > > > > +               cpu-thermal {
> > > > > +                       polling-delay-passive = <0>;
> > > > > +                       polling-delay = <0>;
> > > > > +                       thermal-sensors = <&ths 0>;
> > > > > +               };
> > > > > +
> > > > > +               gpu-thermal {
> > > > > +                       polling-delay-passive = <0>;
> > > > > +                       polling-delay = <0>;
> > > > > +                       thermal-sensors = <&ths 1>;
> > > > > +               };
> > > > >         };
> > > > >  };
> > > > > --
> > > > > 2.24.1
> > > > >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
