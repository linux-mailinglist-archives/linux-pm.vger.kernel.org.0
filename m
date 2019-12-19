Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C42125953
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfLSBmC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:42:02 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33522 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLSBmC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 20:42:02 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so1603903qvn.0;
        Wed, 18 Dec 2019 17:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=D1ScOYStObfmPbVDJyqsfUmkQ2IK/fidlRYIBW1UfQY=;
        b=gShePne+AEO4R0o3VNf1cFLkPq1a2z0lcAucGtxBocqP4GCy9eiFtsHCRKBMf2a6HI
         nlxW/cAKTbfKmGAKJTjPtjURZ7CvjgxndjYb4OFMADa8MUHHsH50dMhFWxDqRb7wStNT
         6PhCIkk0+XwodhPlII6xgsiduSZWZaO3rT0OVKP64TUi1GrOL2WKQfJ29AxQ7kymx2d4
         eqPRBmmn0qq7Ap32/qlzW8u7YaJuUO+I6/kY9mJJTi81glPH8TSw25cGlmdklL6LBmym
         WOURxQ1+rFt2+PmOFEId7FslK97/a6OicHNqXo6VuvzMkefEVRjDDjbhTVhbimmie8+1
         3/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=D1ScOYStObfmPbVDJyqsfUmkQ2IK/fidlRYIBW1UfQY=;
        b=SxIlYAM9iLQsiE35ZM5lWw8qlCUr3PsdgsunzgYy/yRoHFA/XbsZzdtIcpiHnknaSn
         KuV0ZWYTIgWmopQoJdcdUqVjFEIxVf81mdIIVYYB8QOQ9t3mAET+/zogLue3KD9gjMAj
         HqvTRMlOjWheYH4u1veDHOlRQjN+Qulve4z9RMw6satrr0b621kwdL/5wKm8BJErKo7x
         2pxaNYYOfBsnGTWfr3M0RltAfw4DQ/dZ519Gv2OknOXPv+uoWvV32MPZN13EvNv/oRzk
         b+BzfN3X5NwV6vZXTSY6T+GL9E2tRu6jEpLkycWN6u23qbkytAdxxEFfYvbum7o3CM38
         PNzg==
X-Gm-Message-State: APjAAAURLkxUdBFNrD2OIdjAxZyWFURSIwDguL5tJkKE0Z9NMs0w9Ktr
        GsGBB/cFLqPv87sImwXdIC/IFgjAHNmIC+8qQUI=
X-Google-Smtp-Source: APXvYqwgqn0PnKRJqdqnF7brQozZS6zrtCeZ44pP6vH0guHfNRj2RhFzj4THnWnIueakbno9qkmyPV40x60b6TWc/jg=
X-Received: by 2002:a0c:d223:: with SMTP id m32mr5411888qvh.36.1576719720517;
 Wed, 18 Dec 2019 17:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20191218042121.1471954-1-anarsoul@gmail.com> <20191218042121.1471954-7-anarsoul@gmail.com>
 <CAGb2v65Qv6_KQ_MPg0u37P+o5gnnQWhbifOrY6g5FiWvnadmiw@mail.gmail.com>
 <CA+E=qVdKwkUSsG9WA_4x5QntaOxQqfH1eZQ7TEeUrM_3W5mqTg@mail.gmail.com> <20191219010321.kri5e7knjhc5d6ts@core.my.home>
In-Reply-To: <20191219010321.kri5e7knjhc5d6ts@core.my.home>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 18 Dec 2019 17:42:03 -0800
Message-ID: <CA+E=qVf0LT26AoPtooTFcvZR_OGXbFVkMfXJuuoXvPvTSQMLBQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] arm64: dts: allwinner: h6: Add thermal sensor and
 thermal zones
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 18, 2019 at 5:03 PM Ond=C5=99ej Jirman <megous@megous.com> wrot=
e:
>
> On Wed, Dec 18, 2019 at 03:18:51PM -0800, Vasily Khoruzhick wrote:
> > On Tue, Dec 17, 2019 at 8:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Wed, Dec 18, 2019 at 12:22 PM Vasily Khoruzhick <anarsoul@gmail.co=
m> wrote:
> > > >
> > > > From: Ondrej Jirman <megous@megous.com>
> > > >
> > > > There are two sensors, one for CPU, one for GPU.
> > > >
> > > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++=
++++
> > > >  1 file changed, 33 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/ar=
m64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > index 29824081b43b..cdcb1a36301a 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > @@ -11,6 +11,7 @@
> > > >  #include <dt-bindings/reset/sun50i-h6-ccu.h>
> > > >  #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > > >  #include <dt-bindings/reset/sun8i-de2.h>
> > > > +#include <dt-bindings/thermal/thermal.h>
> > > >
> > > >  / {
> > > >         interrupt-parent =3D <&gic>;
> > > > @@ -233,6 +234,12 @@ dma: dma-controller@3002000 {
> > > >                 sid: efuse@3006000 {
> > > >                         compatible =3D "allwinner,sun50i-h6-sid";
> > > >                         reg =3D <0x03006000 0x400>;
> > > > +                       #address-cells =3D <1>;
> > > > +                       #size-cells =3D <1>;
> > > > +
> > > > +                       ths_calibration: thermal-sensor-calibration=
@14 {
> > > > +                               reg =3D <0x14 0x6>;
> > >
> > > Nit: my preference is to use words as the smallest increment, so this
> > > would have a size of 8 instead of 6. Same goes for the A64 dts.
> > >
> > > AFAICT this doesn't impact the driver in any way.
> >
> > H6 has only 2 sensors, so it should be 4. That's my overlook, I'll
> > change it to 4 for H6 and to 8 for A64.
>
> No it's correct. There's 2 bytes reference temperature and 2x 2 byte
> values for individual sensor calibration constants.

So it should be 8 if we round it up to word boundary?

> regards,
>         o.
>
> > >
> > > ChenYu
> > >
> > >
> > > > +                       };
> > > >                 };
> > > >
> > > >                 watchdog: watchdog@30090a0 {
> > > > @@ -856,5 +863,31 @@ r_i2c: i2c@7081400 {
> > > >                         #address-cells =3D <1>;
> > > >                         #size-cells =3D <0>;
> > > >                 };
> > > > +
> > > > +               ths: thermal-sensor@5070400 {
> > > > +                       compatible =3D "allwinner,sun50i-h6-ths";
> > > > +                       reg =3D <0x05070400 0x100>;
> > > > +                       interrupts =3D <GIC_SPI 15 IRQ_TYPE_LEVEL_H=
IGH>;
> > > > +                       clocks =3D <&ccu CLK_BUS_THS>;
> > > > +                       clock-names =3D "bus";
> > > > +                       resets =3D <&ccu RST_BUS_THS>;
> > > > +                       nvmem-cells =3D <&ths_calibration>;
> > > > +                       nvmem-cell-names =3D "calibration";
> > > > +                       #thermal-sensor-cells =3D <1>;
> > > > +               };
> > > > +       };
> > > > +
> > > > +       thermal-zones {
> > > > +               cpu-thermal {
> > > > +                       polling-delay-passive =3D <0>;
> > > > +                       polling-delay =3D <0>;
> > > > +                       thermal-sensors =3D <&ths 0>;
> > > > +               };
> > > > +
> > > > +               gpu-thermal {
> > > > +                       polling-delay-passive =3D <0>;
> > > > +                       polling-delay =3D <0>;
> > > > +                       thermal-sensors =3D <&ths 1>;
> > > > +               };
> > > >         };
> > > >  };
> > > > --
> > > > 2.24.1
> > > >
