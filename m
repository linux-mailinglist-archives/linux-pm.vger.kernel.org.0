Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9DC807B8
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2019 20:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfHCS3X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Aug 2019 14:29:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44281 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfHCS3X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Aug 2019 14:29:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id e189so59131610oib.11;
        Sat, 03 Aug 2019 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmwQzZFWN1VH43yyrewfQCrNQzkLp/L4+LR2NbHJc20=;
        b=PvBvg4hunsTs0giKyiL15cDxqpUWZJJxBgAjtmY8q1EH6FPxs1nx8kirnGu9sEPZUN
         75hgG7VfyjDLpXEvGHkxVqQs9zoZRNlMRUykM50jFIEucPSSSZ4q3V0USvdDbIwc3LWc
         HLSRMU/zaU4p8RdS39kddAqUBXtmsqp3r+XHRijt2RiABnuM3hcZF85C//2UY9Xv6swM
         Ga2ItWR4PddVdwlcCACr358tayUXsZDUT/Z07QWU2Uk3McQt8TcDYBUy627Wm9Rhj/+6
         zd5pPteLyTRm8jvU0qHe4W5qPUsOht+JJQtwKBLq5F0PTSSGYbl/hX1cNsTWMPfZKsWF
         rNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmwQzZFWN1VH43yyrewfQCrNQzkLp/L4+LR2NbHJc20=;
        b=rZvkPfWm82gIS9c+gju5mugdyay/EiLHnTmbWhOuBMvlS40IKNogllN13GRUo+C1qs
         vcbyly5qmmebbcZBNKE9TKzRjgBDbPpQpmeG+YWUwiF1pEUvcLtbtLTG6ilO7PrqJjpc
         T1crAFw+1yKPONPFq4KkLWPhp1CTs9yRPQpAgfy4Oghg6cD73xcsLUz7B8VOVhNH3Hvk
         UuLeU9P6PvfVqPkZWcQhDNtuTvBFqGAAG79nGthGXFA5aX/zWpUiyw2JVce2B0EPaCoL
         7WYZ++j7mUOW+oZVkLCe6TUNsaIAz1ZLN1CfoiqgzJJU1Ve0iy41B042i1yNyBWX4ggH
         nUZQ==
X-Gm-Message-State: APjAAAWyl1TKIR1pbLNgOnp3ryEkwXZhMublLnPqJSM7JmEEM9A/7Hqy
        phfnruEOHpD7v1eDmmrDwzMMr1yaGRDk3/0ot2o=
X-Google-Smtp-Source: APXvYqwJbx+70CCBTietpO39u7K1TgLKPTpN4Bi1Ow630XW6U1gtXiCVC87cK74QbovUvi45FqC4+cT21hLCfvd82L4=
X-Received: by 2002:a05:6808:3d6:: with SMTP id o22mr6459987oie.140.1564856961731;
 Sat, 03 Aug 2019 11:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153529.30159-1-glaroque@baylibre.com> <20190731153529.30159-5-glaroque@baylibre.com>
In-Reply-To: <20190731153529.30159-5-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 3 Aug 2019 20:29:10 +0200
Message-ID: <CAFBinCD-DUEjPgfUEJmHpPjw1ShZy7nemaFBKANmM5M42XBG4Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] arm64: dts: meson: sei510: Add minimal thermal zone
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Guillaume,

On Wed, Jul 31, 2019 at 5:36 PM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Add minimal thermal zone for DDR and CPU sensor
so high DDR (controller?) temperatures will throttle Mali and high PLL
temperatures will throttle the CPU?
to get things started I'm fine with this, but I think it should be
mentioned here

> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-g12a-sei510.dts    | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> index 979449968a5f..2c16a2cba0a3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/meson-g12a-gpio.h>
>  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         compatible = "seirobotics,sei510", "amlogic,g12a";
> @@ -33,6 +34,53 @@
>                 ethernet0 = &ethmac;
>         };
>
> +       thermal-zones {
> +               cpu-thermal {
> +                       polling-delay = <1000>;
> +                       polling-delay-passive = <100>;
> +                       thermal-sensors = <&cpu_temp>;
> +
> +                       trips {
> +                               cpu_critical: cpu-critical {
> +                                       temperature = <110000>; /* millicelsius */
> +                                       hysteresis = <2000>; /* millicelsius */
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map {
> +                                       trip = <&cpu_critical>;
> +                                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               ddr-thermal {
> +                       polling-delay = <1000>;
> +                       polling-delay-passive = <100>;
> +                       thermal-sensors = <&ddr_temp>;
> +
> +                       trips {
> +                               ddr_critical: ddr-critical {
> +                                       temperature = <110000>; /* millicelsius */
> +                                       hysteresis = <2000>; /* millicelsius */
> +                                       type = "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map {
> +                                       trip = <&ddr_critical>;
> +                                       cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +       };
> +
>         mono_dac: audio-codec-0 {
>                 compatible = "maxim,max98357a";
>                 #sound-dai-cells = <0>;
> @@ -321,6 +369,7 @@
>         operating-points-v2 = <&cpu_opp_table>;
>         clocks = <&clkc CLKID_CPU_CLK>;
>         clock-latency = <50000>;
> +       #cooling-cells = <2>;
>  };
>
>  &cpu1 {
> @@ -328,6 +377,7 @@
>         operating-points-v2 = <&cpu_opp_table>;
>         clocks = <&clkc CLKID_CPU_CLK>;
>         clock-latency = <50000>;
> +       #cooling-cells = <2>;
>  };
>
>  &cpu2 {
> @@ -335,6 +385,7 @@
>         operating-points-v2 = <&cpu_opp_table>;
>         clocks = <&clkc CLKID_CPU_CLK>;
>         clock-latency = <50000>;
> +       #cooling-cells = <2>;
>  };
>
>  &cpu3 {
> @@ -342,6 +393,7 @@
>         operating-points-v2 = <&cpu_opp_table>;
>         clocks = <&clkc CLKID_CPU_CLK>;
>         clock-latency = <50000>;
> +       #cooling-cells = <2>;
>  };
>
>  &cvbs_vdac_port {
> @@ -368,6 +420,10 @@
>         status = "okay";
>  };
>
> +&mali {
> +       #cooling-cells = <2>;
> +};
is there something device-specific in this patch? I'm wondering
whether we can move all of this go g12a.dtsi to simplify maintenance
in the future


Martin
