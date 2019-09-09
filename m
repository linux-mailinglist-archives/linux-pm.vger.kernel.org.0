Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C5ADA30
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 15:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfIINn1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 09:43:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38182 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbfIINn0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 09:43:26 -0400
Received: by mail-io1-f66.google.com with SMTP id k5so3432464iol.5;
        Mon, 09 Sep 2019 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uj8cYXkJhMazfj5NVd7OEEcgf5lel1QFfUYYz9PuuUg=;
        b=UqN2xHEmmSJ1Tbexwa/6YF0SY6Z9ftkKgsluGYRUfEyaZqnL/bopjFCtdThnhz94wb
         DLnryRY7NutxIOR/1GcLArrU6bmd+HGgbRmoM3KqNSIM9agjAL8Aeru4AkTIb+rrz3v6
         W8bjrNNMgdCn6XSulgErtfETBqXJH/O05uU7OYWzd/j8ubB0w/M/7CLBwmIukwTyVaRk
         Tir3dBK+aqja3hUpyX/IWVMVkRSGIxJ9iHqyKMvCk51Z4EVY8Hi4m0SnEYzVlHV9W4vM
         tnDKLv7EkZLrXKBDsaqBOvsYgiVgwM+AP8dF7rjf+eASRy9Fa9OJobz7Jx4LfjDLnBI/
         00aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uj8cYXkJhMazfj5NVd7OEEcgf5lel1QFfUYYz9PuuUg=;
        b=Qe+81O0wlsze5tQjJI9UXtv+K9AOISEyr0Hcazo4KZekPTwpiVmzJ/AObqaI6YpjB9
         jazEaJG3Wyp0ZA1GSjgmUEZHJ2Rq/dlw9r979HMM8NQ6soPEbaaccwYo9krZaKdTzb77
         w/kgA5WyizD4aTQ0RR1aaU0yDDQ+OZJyy1PTqOr24kM1K5X9oTVbQtcuJQaj12SAYKs5
         HWRtJoFhG6xae59mR6FF4MeKtSR0z1gTWuhToMf0YatS81829LGrYFoFVo+pXA/ejZnY
         HU+E2GN/2UYroovXbP200iHrz2Cq6D6hh8B7wxmMwlBvuzobf6p+KM8Cnk0L2a76zkSn
         1iJQ==
X-Gm-Message-State: APjAAAU2n0AhUBoDLpHf3IeTliisxOE485lx2/KwxgUo1/YE7xXCayl+
        iSzFOB1YSRtAWjYHunL/o+zWIITaYH9u9beQzcA=
X-Google-Smtp-Source: APXvYqy1FVHSsfxS0gbdJaZ5R+pfPURTnvUsc65w9GB7f807rv62m+M+MNCwIT3h/4mgCrzpftjHKSoawakRZLLsqqo=
X-Received: by 2002:a05:6638:627:: with SMTP id h7mr26456899jar.33.1568036604928;
 Mon, 09 Sep 2019 06:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567878413.git.hns@goldelico.com> <784d0d08ee585fc436f15de4edb58b394d0f4452.1567878413.git.hns@goldelico.com>
In-Reply-To: <784d0d08ee585fc436f15de4edb58b394d0f4452.1567878413.git.hns@goldelico.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 9 Sep 2019 08:43:13 -0500
Message-ID: <CAHCN7xJU2oW3QggNtcY0qTMTH058EJxKZBC6tRign=kX2Jtg2g@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: dts: replace opp-v1 tables by opp-v2 for
 omap34xx and omap36xx
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Sep 7, 2019 at 12:47 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> In addition, move omap3 from whitelist to blacklist in cpufreq-dt-platdev
> in the same patch, because doing either first breaks operation and
> may make trouble in bisect.
>
> We also can remove opp-v1 table for omap3-n950-n9 since it is now
> automatically detected.
>
> We also fix a wrong OPP4 voltage for omap3430 which must be
> 0.6V + 54*12.5mV = 1275mV. Otherwise the twl4030 driver will reject
> this OPP.
>
thank you for your work on this.  I tested it on a a Logit PD DM3730
Torpedo + Wireless kit, and appears to operate normally, but i have
not tested it at temperature.

Tested-by: Adam Ford <aford173@gmail.com>

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap3-n950-n9.dtsi |  7 ---
>  arch/arm/boot/dts/omap34xx.dtsi      | 65 ++++++++++++++++++++++++----
>  arch/arm/boot/dts/omap36xx.dtsi      | 53 +++++++++++++++++++----
>  drivers/cpufreq/cpufreq-dt-platdev.c |  2 +-
>  4 files changed, 102 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> index 5441e9ffdbb4..e98b0c615f19 100644
> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> @@ -11,13 +11,6 @@
>         cpus {
>                 cpu@0 {
>                         cpu0-supply = <&vcc>;
> -                       operating-points = <
> -                               /* kHz    uV */
> -                               300000  1012500
> -                               600000  1200000
> -                               800000  1325000
> -                               1000000 1375000
> -                       >;
>                 };
>         };
>
> diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
> index f572a477f74c..91154829f86a 100644
> --- a/arch/arm/boot/dts/omap34xx.dtsi
> +++ b/arch/arm/boot/dts/omap34xx.dtsi
> @@ -16,19 +16,66 @@
>  / {
>         cpus {
>                 cpu: cpu@0 {
> -                       /* OMAP343x/OMAP35xx variants OPP1-5 */
> -                       operating-points = <
> -                               /* kHz    uV */
> -                               125000   975000
> -                               250000  1075000
> -                               500000  1200000
> -                               550000  1270000
> -                               600000  1350000
> -                       >;
> +                       /* OMAP343x/OMAP35xx variants OPP1-6 */
> +                       operating-points-v2 = <&cpu0_opp_table>;
> +
>                         clock-latency = <300000>; /* From legacy driver */
>                 };
>         };
>
> +       /* see Documentation/devicetree/bindings/opp/opp.txt */
> +       cpu0_opp_table: opp-table {
> +               compatible = "operating-points-v2-ti-cpu";
> +               syscon = <&scm_conf>;
> +
> +               opp1-125000000 {
> +                       opp-hz = /bits/ 64 <125000000>;
> +                       /*
> +                        * we currently only select the max voltage from table
> +                        * Table 3-3 of the omap3530 Data sheet (SPRS507F).
> +                        * Format is: <target min max>
> +                        */
> +                       opp-microvolt = <975000 975000 975000>;
> +                       /*
> +                        * first value is silicon revision bit mask
> +                        * second one 720MHz Device Identification bit mask
> +                        */
> +                       opp-supported-hw = <0xffffffff 3>;
> +               };
> +
> +               opp2-250000000 {
> +                       opp-hz = /bits/ 64 <250000000>;
> +                       opp-microvolt = <1075000 1075000 1075000>;
> +                       opp-supported-hw = <0xffffffff 3>;
> +                       opp-suspend;
> +               };
> +
> +               opp3-500000000 {
> +                       opp-hz = /bits/ 64 <500000000>;
> +                       opp-microvolt = <1200000 1200000 1200000>;
> +                       opp-supported-hw = <0xffffffff 3>;
> +               };
> +
> +               opp4-550000000 {
> +                       opp-hz = /bits/ 64 <550000000>;
> +                       opp-microvolt = <1275000 1275000 1275000>;
> +                       opp-supported-hw = <0xffffffff 3>;
> +               };
> +
> +               opp5-600000000 {
> +                       opp-hz = /bits/ 64 <600000000>;
> +                       opp-microvolt = <1350000 1350000 1350000>;
> +                       opp-supported-hw = <0xffffffff 3>;
> +               };
> +
> +               opp6-720000000 {
> +                       opp-hz = /bits/ 64 <720000000>;
> +                       opp-microvolt = <1350000 1350000 1350000>;
> +                       /* only high-speed grade omap3530 devices */
> +                       opp-supported-hw = <0xffffffff 2>;
> +               };
> +       };
> +
>         ocp@68000000 {
>                 omap3_pmx_core2: pinmux@480025d8 {
>                         compatible = "ti,omap3-padconf", "pinctrl-single";
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> index 6fb23ada1f64..44f25b0eb45b 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -19,15 +19,52 @@
>         };
>
>         cpus {
> -               /* OMAP3630/OMAP37xx 'standard device' variants OPP50 to OPP130 */
> +               /* OMAP3630/OMAP37xx variants OPP50 to OPP130 and OPP1G */
>                 cpu: cpu@0 {
> -                       operating-points = <
> -                               /* kHz    uV */
> -                               300000  1012500
> -                               600000  1200000
> -                               800000  1325000
> -                       >;
> -                       clock-latency = <300000>; /* From legacy driver */
> +                       operating-points-v2 = <&cpu0_opp_table>;
> +
> +                       clock-latency = <300000>; /* From omap-cpufreq driver */
> +               };
> +       };
> +
> +       /* see Documentation/devicetree/bindings/opp/opp.txt */
> +       cpu0_opp_table: opp-table {
> +               compatible = "operating-points-v2-ti-cpu";
> +               syscon = <&scm_conf>;
> +
> +               opp50-300000000 {
> +                       opp-hz = /bits/ 64 <300000000>;
> +                       /*
> +                        * we currently only select the max voltage from table
> +                        * Table 4-19 of the DM3730 Data sheet (SPRS685B)
> +                        * Format is: <target min max>
> +                        */
> +                       opp-microvolt = <1012500 1012500 1012500>;
> +                       /*
> +                        * first value is silicon revision bit mask
> +                        * second one is "speed binned" bit mask
> +                        */
> +                       opp-supported-hw = <0xffffffff 3>;
> +                       opp-suspend;
> +               };
> +
> +               opp100-600000000 {
> +                       opp-hz = /bits/ 64 <600000000>;
> +                       opp-microvolt = <1200000 1200000 1200000>;
> +                       opp-supported-hw = <0xffffffff 3>;
> +               };
> +
> +               opp130-800000000 {
> +                       opp-hz = /bits/ 64 <800000000>;
> +                       opp-microvolt = <1325000 1325000 1325000>;
> +                       opp-supported-hw = <0xffffffff 3>;
> +               };
> +
> +               opp1g-1000000000 {
> +                       opp-hz = /bits/ 64 <1000000000>;
> +                       opp-microvolt = <1375000 1375000 1375000>;
> +                       /* only on am/dm37x with speed-binned bit set */
> +                       opp-supported-hw = <0xffffffff 2>;
>                 };
>         };
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 03dc4244ab00..68b7fc4225f8 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -86,7 +86,6 @@ static const struct of_device_id whitelist[] __initconst = {
>         { .compatible = "st-ericsson,u9540", },
>
>         { .compatible = "ti,omap2", },
> -       { .compatible = "ti,omap3", },
>         { .compatible = "ti,omap4", },
>         { .compatible = "ti,omap5", },
>
> @@ -132,6 +131,7 @@ static const struct of_device_id blacklist[] __initconst = {
>         { .compatible = "ti,am33xx", },
>         { .compatible = "ti,am43", },
>         { .compatible = "ti,dra7", },
> +       { .compatible = "ti,omap3", },
>
>         { }
>  };
> --
> 2.19.1
>
