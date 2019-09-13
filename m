Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C31FB1927
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2019 09:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfIMHrx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Sep 2019 03:47:53 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46361 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfIMHrw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2019 03:47:52 -0400
Received: by mail-ua1-f67.google.com with SMTP id k12so8864557uan.13
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2019 00:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BY3Xdm/EuEh+5xQuU5r1eTj+ek/4Ndp2HWrdgEDsjzc=;
        b=WJkm19FFgfc2GD6vL1mFJQN6LlvObf/GmbYBDNtuIIzm2tqbA9cMbf4vr4LQorJO/Q
         EZiMU05SVRjKv3jYbT3b9WhN25IIYPTSxoS56bRuaTpAtWiEVtIc8Spxw+BM5TKvPPeU
         XppVfL9AmQttSDSycCqcd77+sVw9EdQ15SSXzrczsbZ5qZzO7AFNaZQEvPf1JBPFT8e4
         GTU3DlXxwGRmMsGsbLyQcyiYxxNaSE2cXKAKyuMoOF2GBTfsW1RiO+xBKkVKEQJUFvfk
         RwLopqoFtujhyyjh23scuKoskkK/GRlHujIsHBn4bsklMNzeE2Pg1ac6lzQLkVZXLVXG
         SoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BY3Xdm/EuEh+5xQuU5r1eTj+ek/4Ndp2HWrdgEDsjzc=;
        b=mFXeN3tugykLM8vbqHA2f1CTVpPTLdVmzTrcrQOy1+7mN+ANfcOtPRPvBV9uakC39k
         H/zX0bqWZhKoWvIljA7gNRdmCSr5+eeaDKwRXo2t7OT9xv+SobZV7ofd7TOCMe5eMNSs
         AK9bGb99oZFthnwG3hzat/q3u1m3gwfILVA9nk5Qi/Qs9PK7BfQEQ6ud4QT4+OaLfyVs
         7EZPxWURdhoWyLG5dPnzNsggwryrdlZnjp7mBF3zI8cLqR0DaTVdN3CAzRNT3Z9/Xc5B
         ecvV5hS0uYQhYo+mmbzPGeuoH3rOOXhUFnVYQu8kCMdEja9ycJRLw5NJ95hYLTrnJMlt
         fbMg==
X-Gm-Message-State: APjAAAUDbrCiK0anOaAvk6kDmpaLoELIk+I7WNbEgkpTyEEAeWbS3nf7
        YXl82bBEagJtCy3JtSdWoVKQk5rUZHO073VW4j21R0o2jms=
X-Google-Smtp-Source: APXvYqw+RuXy2zCguY4C1QAkE27a8kK5UVarVaOFgDQP/kO/+YACn54gFQCdTxOviAuCW1sKD8pQvibhMSHWBtF6fqA=
X-Received: by 2002:ab0:2855:: with SMTP id c21mr23850232uaq.67.1568360870892;
 Fri, 13 Sep 2019 00:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190821222421.30242-1-glaroque@baylibre.com> <20190821222421.30242-5-glaroque@baylibre.com>
 <7hsgpu5c7j.fsf@baylibre.com>
In-Reply-To: <7hsgpu5c7j.fsf@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 13 Sep 2019 13:17:39 +0530
Message-ID: <CAHLCerPtDH2VLGBgETJkqkLQZ=8T5C=8VY-=SLKAAEpx5nZf5A@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: meson: sei510: Add minimal thermal zone
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 22, 2019 at 4:59 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Guillaume La Roque <glaroque@baylibre.com> writes:
>
> > Add minimal thermal zone for two temperature sensor
> > One is located close to the DDR and the other one is
> > located close to the PLLs (between the CPU and GPU)
> >
> > Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  .../boot/dts/amlogic/meson-g12a-sei510.dts    | 70 +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> > index c9fa23a56562..35d2ebbd6d4e 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> > @@ -10,6 +10,7 @@
> >  #include <dt-bindings/input/input.h>
> >  #include <dt-bindings/gpio/meson-g12a-gpio.h>
> >  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >       compatible = "seirobotics,sei510", "amlogic,g12a";
> > @@ -33,6 +34,67 @@
> >               ethernet0 = &ethmac;
> >       };
> >
> > +     thermal-zones {
> > +             cpu-thermal {
> > +                     polling-delay = <1000>;
> > +                     polling-delay-passive = <100>;
> > +                     thermal-sensors = <&cpu_temp>;
> > +
> > +                     trips {
> > +                             cpu_hot: cpu-hot {
> > +                                     temperature = <85000>; /* millicelsius */
> > +                                     hysteresis = <2000>; /* millicelsius */
> > +                                     type = "hot";
> > +                             };

No passive trip point? That is where the cooling-maps are really useful.

> > +
> > +                             cpu_critical: cpu-critical {
> > +                                     temperature = <110000>; /* millicelsius */
> > +                                     hysteresis = <2000>; /* millicelsius */
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +

I think, what you really want is to change your hot trip point above
to passive. And if you need another trip before that (to send
notification to userspace, for example), just add another hot trip
point at a lower temperature.

> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip = <&cpu_hot>;
> > +                                     cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +
> > +                             map1 {
> > +                                     trip = <&cpu_critical>;
> > +                                     cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };

The cooling-map associated with a critical trip point is of no use in
my experience because the device is already on its way to shutting
down then.

> > +                     };
> > +             };
> > +
> > +             ddr-thermal {
> > +                     polling-delay = <1000>;
> > +                     polling-delay-passive = <100>;
> > +                     thermal-sensors = <&ddr_temp>;
> > +
> > +                     trips {
> > +                             ddr_critical: ddr-critical {
> > +                                     temperature = <110000>; /* millicelsius */
> > +                                     hysteresis = <2000>; /* millicelsius */
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +
> > +                     cooling-maps {
> > +                             map {
> > +                                     trip = <&ddr_critical>;
> > +                                     cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

Same here. The cooling-map makes more sense against a passive trip type.

> > +                             };
> > +                     };
> > +             };
> > +     };
> > +
> >       mono_dac: audio-codec-0 {
> >               compatible = "maxim,max98357a";
> >               #sound-dai-cells = <0>;
> > @@ -321,6 +383,7 @@
> >       operating-points-v2 = <&cpu_opp_table>;
> >       clocks = <&clkc CLKID_CPU_CLK>;
> >       clock-latency = <50000>;
> > +     #cooling-cells = <2>;
> >  };
> >
> >  &cpu1 {
> > @@ -328,6 +391,7 @@
> >       operating-points-v2 = <&cpu_opp_table>;
> >       clocks = <&clkc CLKID_CPU_CLK>;
> >       clock-latency = <50000>;
> > +     #cooling-cells = <2>;
> >  };
> >
> >  &cpu2 {
> > @@ -335,6 +399,7 @@
> >       operating-points-v2 = <&cpu_opp_table>;
> >       clocks = <&clkc CLKID_CPU_CLK>;
> >       clock-latency = <50000>;
> > +     #cooling-cells = <2>;
> >  };
> >
> >  &cpu3 {
> > @@ -342,6 +407,7 @@
> >       operating-points-v2 = <&cpu_opp_table>;
> >       clocks = <&clkc CLKID_CPU_CLK>;
> >       clock-latency = <50000>;
> > +     #cooling-cells = <2>;
> >  };
> >
> >  &cvbs_vdac_port {
> > @@ -368,6 +434,10 @@
> >       status = "okay";
> >  };
> >
> > +&mali {
> > +     #cooling-cells = <2>;
> > +};
> > +
>
> Is there a reason these #cooling-cells properties belong in the SoC
> .dtsi and not the board .dts.  Seems like you'll have to repeat this in
> every board .dts which doesn't seem necessary.
>
> Same comment for patch 5/6

Agreed. Even the thermal zones belong in the SoC .dtsi. You can always
override the trip-points in a board .dts if required if you have a
board designed in a different form-factor or with active cooling.

/Amit
