Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256FA19E52D
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 15:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDDNZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 09:25:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35163 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgDDNZi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 09:25:38 -0400
Received: by mail-il1-f196.google.com with SMTP id 7so10221354ill.2;
        Sat, 04 Apr 2020 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScNwQlaT6PVi5sYfWnDXWuHcgtCKis/6yURrV47X/cw=;
        b=KhHDddTVPCEDtxdQUJfKSnbB9NWNom/HqErDavx0IaUhRhdpx8p7eRolCvpreprFX+
         bG0ts4onYD8+DdHJeAv4kcsjWFfqNFmy5dnffK5cQWyIL7BeoCKNAZdTJ0wCrOGTIXJU
         GxFJYX4eLBWo5BFiMBaHxN3LTv3LmLNLCLWeDF5VFlIGrAsSu1qF5tONkYyuHRaRwVC6
         oskhir3uLQZfptJIT5XeNYtQffa8kN7NYmCN+kZKERvMaW1AFGXGFjASeLS0U61etPc0
         UHlbEIr6Fr51DTIo0qddYuYHxefIOvCnbrgfStN/khTJUK5HkQoNvB6CYoP8wXCkRi6A
         ZiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScNwQlaT6PVi5sYfWnDXWuHcgtCKis/6yURrV47X/cw=;
        b=EOjbxmd/TyXUjwssTfmDn+Wno9b2tSo4rQDw0Nqua0w8NNkWJMwTQaY1OaJSbt91N3
         honKnha4nXtLgmAnxo7WU8TJr3JdlTP9Wzaoa/zpxswRF+9M7s07KWl7eqIapJdGenem
         nLY0JAAl33u19XfXGlF2DXawOR+4qGdnBHuPU9tYLaGXp8Trdbec9ZyEOPPS77DLHZAw
         N8JJ/cQpnN55+3KOHW2+TNEl/h1HXZqfFgn/9j1U3E1GFCGvCK7gnT0BVKchNI2pYFTU
         gltuihQ82NE1RwI5Mkw6yxxN1ouKYUUYuILEHpyUNi3VSRM92BTrJVOUAIR3iqzyXcUq
         L/9g==
X-Gm-Message-State: AGi0PuZZab/Vn4OM7bFwrva84wD5sdpiHtZKZnU81raUQHKpT7hwFxGU
        GmOQJiDT8BgilSDUIo4YDuiooumytl16uKvMj3s=
X-Google-Smtp-Source: APiQypK3XiIUkQMbXIv7kgzxvm2CyJbazGkPtKRTHWEaSDKDC9suPX8g16lHi4ncEU9Lqs/8MRVkjMMs1CkPfI8XepQ=
X-Received: by 2002:a92:4896:: with SMTP id j22mr12637650ilg.158.1586006736069;
 Sat, 04 Apr 2020 06:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585751281.git.leonard.crestez@nxp.com> <c167baa48d6830cf32b9ac51968eeadd684ebf2d.1585751281.git.leonard.crestez@nxp.com>
In-Reply-To: <c167baa48d6830cf32b9ac51968eeadd684ebf2d.1585751281.git.leonard.crestez@nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 4 Apr 2020 08:25:24 -0500
Message-ID: <CAHCN7xKpwex8MQbTFAYKjGPQbQ1uOe7EywASmcakg8F_2w-iuA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] arm64: dts: imx8m: Add NOC nodes
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 1, 2020 at 9:35 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> Add nodes for the main interconnect of the imx8m series chips.
>
> These nodes are bound to by devfreq and interconnect drivers.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 24 +++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 24 +++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 +++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 175c28ae10cf..41047b6709b6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -6,10 +6,11 @@
>  #include <dt-bindings/clock/imx8mm-clock.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mm.h>
>
>  #include "imx8mm-pinfunc.h"
>
>  / {
>         interrupt-parent = <&gic>;
> @@ -860,10 +861,33 @@
>                                 status = "disabled";
>                         };
>
>                 };
>
> +               noc: interconnect@32700000 {
> +                       compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
> +                       reg = <0x32700000 0x100000>;
> +                       clocks = <&clk IMX8MM_CLK_NOC>;
> +                       fsl,ddrc = <&ddrc>;
> +                       #interconnect-cells = <1>;
> +                       operating-points-v2 = <&noc_opp_table>;
> +
> +                       noc_opp_table: opp-table {
> +                               compatible = "operating-points-v2";
> +
> +                               opp-150M {
> +                                       opp-hz = /bits/ 64 <150000000>;
> +                               };
> +                               opp-375M {
> +                                       opp-hz = /bits/ 64 <375000000>;
> +                               };
> +                               opp-750M {
> +                                       opp-hz = /bits/ 64 <750000000>;

Out of curiosity, the 8M Mini runs up to 750M, and  the 8M Nano and
8MQ run up to 800.  The 8MQ had a patch to increase the assigned clock
speed for the NOC to 800MHz

See: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/arch/arm64/boot/dts/freescale?id=912b9dacf3f0ffad55e1a1b3c5af0e433ebdb5dd)

The 8M Mini and 8M Nano appear to be setting the default speed to 0.

Should the 8M Mini or 8M Nano do something similar to what the 8MQ
did, or does this series negate the need for such a patch?

thanks

adam

> +                               };
> +                       };
> +               };
> +
>                 aips4: bus@32c00000 {
>                         compatible = "fsl,aips-bus", "simple-bus";
>                         reg = <0x32df0000 0x10000>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 88e7d74e077f..e8a55956813f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -6,10 +6,11 @@
>  #include <dt-bindings/clock/imx8mn-clock.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mn.h>
>
>  #include "imx8mn-pinfunc.h"
>
>  / {
>         interrupt-parent = <&gic>;
> @@ -751,10 +752,33 @@
>                                 status = "disabled";
>                         };
>
>                 };
>
> +               noc: interconnect@32700000 {
> +                       compatible = "fsl,imx8mn-noc", "fsl,imx8m-noc";
> +                       reg = <0x32700000 0x100000>;
> +                       clocks = <&clk IMX8MN_CLK_NOC>;
> +                       fsl,ddrc = <&ddrc>;
> +                       #interconnect-cells = <1>;
> +                       operating-points-v2 = <&noc_opp_table>;
> +
> +                       noc_opp_table: opp-table {
> +                               compatible = "operating-points-v2";
> +
> +                               opp-100M {
> +                                       opp-hz = /bits/ 64 <100000000>;
> +                               };
> +                               opp-600M {
> +                                       opp-hz = /bits/ 64 <600000000>;
> +                               };
> +                               opp-800M {
> +                                       opp-hz = /bits/ 64 <800000000>;
> +                               };
> +                       };
> +               };
> +
>                 aips4: bus@32c00000 {
>                         compatible = "fsl,aips-bus", "simple-bus";
>                         reg = <0x32df0000 0x10000>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index ea93bc4b7d7e..3a208feec74c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -9,10 +9,11 @@
>  #include <dt-bindings/reset/imx8mq-reset.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include "dt-bindings/input/input.h"
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mq.h>
>  #include "imx8mq-pinfunc.h"
>
>  / {
>         interrupt-parent = <&gpc>;
>
> @@ -1026,10 +1027,33 @@
>                                 fsl,num-rx-queues = <3>;
>                                 status = "disabled";
>                         };
>                 };
>
> +               noc: interconnect@32700000 {
> +                       compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
> +                       reg = <0x32700000 0x100000>;
> +                       clocks = <&clk IMX8MQ_CLK_NOC>;
> +                       fsl,ddrc = <&ddrc>;
> +                       #interconnect-cells = <1>;
> +                       operating-points-v2 = <&noc_opp_table>;
> +
> +                       noc_opp_table: opp-table {
> +                               compatible = "operating-points-v2";
> +
> +                               opp-133M {
> +                                       opp-hz = /bits/ 64 <133333333>;
> +                               };
> +                               opp-400M {
> +                                       opp-hz = /bits/ 64 <400000000>;
> +                               };
> +                               opp-800M {
> +                                       opp-hz = /bits/ 64 <800000000>;
> +                               };
> +                       };
> +               };
> +
>                 bus@32c00000 { /* AIPS4 */
>                         compatible = "fsl,aips-bus", "simple-bus";
>                         reg = <0x32df0000 0x10000>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
