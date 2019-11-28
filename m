Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C6A10CA82
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfK1Ond (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:43:33 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45316 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfK1Ond (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:43:33 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so18300589ioi.12;
        Thu, 28 Nov 2019 06:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4OMB9FrnRPZRUHwvOwqK6rgFmvyxzvzmzgSErk1FuA=;
        b=GVR7QBA5LCthVUe8s3WHX6R1zzLV1oBi3txKCgqCMuk/fePCuPFPSkNWB917B0Ee8f
         fDwIiyF834JV7NaHFEZtEhwKcotP2gKhli9D9WqhfjjD2d9pZ+VCGKYxXI9TldFa0DDf
         kdZ/Vn4ql/t/W0h9xPh8zBg1fSig/B7KlQ+SOLwshC4KLnqO8/9rENX+6AaxVWShl77s
         vsslrAsMvZ24MU8nGRZJj03MF0XDdDJt7QH798QU7t10PDqynLWFNPTVz/0abfgi15tJ
         Jo6RdDOJYgRrRS3TADPYrmVWHSxRZ3DWDyY7jL7F+67QnwpKknF2jp4ekX5C8L+OQeOo
         62KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4OMB9FrnRPZRUHwvOwqK6rgFmvyxzvzmzgSErk1FuA=;
        b=F5TLlXMRICcHjgUS0hmV/IBta8Q6qNOR/Ozlq9GPCfZf/UftFJSQ6T+KaCh3aSG8bW
         bB+5pWhoJucF8yUyX5X1lQi//dNHeo3kniXiUkOH00zZwAYUeE16jKgMLqVIb4mo2vyR
         J42tIJf95XEoT9YFW/oSuXPIIDEkDeqnID7HI0zfy6U6jBBEDkUJFNTASgqFdFxDX4fs
         wfpeaF5c+Jx9UwN6u4I1ki3q7Hxg4DouusnSfcOHk36bWGWVINb0Dq7qzLdgd5pqFjtJ
         Yt3tNEv3SY0SJcj/PZdhemRj8dYnXVWwxpxIu8vxyL3+NlVadSS/R2Uw4krE104OVXJk
         vw8Q==
X-Gm-Message-State: APjAAAUYxlJ0aTyiKb1Nyc6DBh2KQTHScJNSX78T3IqP5Rir75GeOYF4
        rA73BLM/rIiz78viAp5P1bLBxpJSWQRy3xErn08=
X-Google-Smtp-Source: APXvYqxmYtcweNZvmQamB+3MqsYEvLc6Vlj1zSMxlf9AdoyRV0M1IpinPiPVlm6ML7fvBE97Hbo1OQQuaabfzT2qJ1I=
X-Received: by 2002:a02:a0cf:: with SMTP id i15mr10296595jah.95.1574952211778;
 Thu, 28 Nov 2019 06:43:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574458460.git.leonard.crestez@nxp.com> <23e46c12c98947315229c20dea6784ad40d294c4.1574458460.git.leonard.crestez@nxp.com>
In-Reply-To: <23e46c12c98947315229c20dea6784ad40d294c4.1574458460.git.leonard.crestez@nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 28 Nov 2019 08:43:20 -0600
Message-ID: <CAHCN7xK_w9m7sZOJtGFVtpeu1BHN_H6eyeYCOgZQS67t1SvmRQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] arm64: dts: imx8m: Add ddr controller nodes
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        Alexandre Bailon <abailon@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 22, 2019 at 3:46 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> This is used by the imx-ddrc devfreq driver to implement dynamic
> frequency scaling of DRAM.
>
> Support for proactive scaling via interconnect will come later. The
> high-performance bus masters which need that (display, vpu, gpu) are
> mostly not yet enabled in upstream anyway.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 18 ++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 10 ++++++++
>  .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 18 ++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 10 ++++++++
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 24 +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 10 ++++++++
>  6 files changed, 90 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index 28ab17a277bb..ecf0d385c164 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -75,10 +75,28 @@
>
>  &A53_0 {
>         cpu-supply = <&buck2_reg>;
>  };
>
> +&ddrc {
> +       operating-points-v2 = <&ddrc_opp_table>;
> +
> +       ddrc_opp_table: opp-table {
> +               compatible = "operating-points-v2";
> +
> +               opp-25M {
> +                       opp-hz = /bits/ 64 <25000000>;
> +               };
> +               opp-100M {
> +                       opp-hz = /bits/ 64 <100000000>;
> +               };
> +               opp-750M {
> +                       opp-hz = /bits/ 64 <750000000>;
> +               };
> +       };
> +};

The SoC's device tree has the opp for the SoC.  Since the SoC also has
the DDR controller, why not put the opp for the DDR into the SoC's
device tree set for its maximum rates.  If the individual boards need
to change them, they can do it on a case-by-case basis.

As more and more people add devices based on imx8m q/m/n, I can
imaging a lot of these entries will be duplicated if they base their
design on the reference evk for their respective SoC.

> +
>  &fec1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_fec1>;
>         phy-mode = "rgmii-id";
>         phy-handle = <&ethphy0>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 6edbdfe2d0d7..3d4802375715 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -856,10 +856,20 @@
>                         #interrupt-cells = <3>;
>                         interrupt-controller;
>                         interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
> +               ddrc: memory-controller@3d400000 {
> +                       compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
> +                       reg = <0x3d400000 0x400000>;
> +                       clock-names = "core", "pll", "alt", "apb";
> +                       clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
> +                                <&clk IMX8MM_DRAM_PLL>,
> +                                <&clk IMX8MM_CLK_DRAM_ALT>,
> +                                <&clk IMX8MM_CLK_DRAM_APB>;
> +               };
> +
>                 ddr-pmu@3d800000 {
>                         compatible = "fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";
>                         reg = <0x3d800000 0x400000>;
>                         interrupt-parent = <&gic>;
>                         interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> index 071949412caf..b051c927c11e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> @@ -15,10 +15,28 @@
>
>  &A53_0 {
>         cpu-supply = <&buck2_reg>;
>  };
>
> +&ddrc {
> +       operating-points-v2 = <&ddrc_opp_table>;
> +
> +       ddrc_opp_table: opp-table {
> +               compatible = "operating-points-v2";
> +
> +               opp-25M {
> +                       opp-hz = /bits/ 64 <25000000>;
> +               };
> +               opp-100M {
> +                       opp-hz = /bits/ 64 <100000000>;
> +               };
> +               opp-600M {
> +                       opp-hz = /bits/ 64 <600000000>;
> +               };
> +       };
> +};
> +
>  &i2c1 {
>         pmic@4b {
>                 compatible = "rohm,bd71847";
>                 reg = <0x4b>;
>                 pinctrl-0 = <&pinctrl_pmic>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index e91625063f8e..3a79fdddc72b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -757,10 +757,20 @@
>                         #interrupt-cells = <3>;
>                         interrupt-controller;
>                         interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
> +               ddrc: memory-controller@3d400000 {
> +                       compatible = "fsl,imx8mn-ddrc", "fsl,imx8m-ddrc";
> +                       reg = <0x3d400000 0x400000>;
> +                       clock-names = "core", "pll", "alt", "apb";
> +                       clocks = <&clk IMX8MN_CLK_DRAM_CORE>,
> +                                <&clk IMX8MN_DRAM_PLL>,
> +                                <&clk IMX8MN_CLK_DRAM_ALT>,
> +                                <&clk IMX8MN_CLK_DRAM_APB>;
> +               };
> +
>                 ddr-pmu@3d800000 {
>                         compatible = "fsl,imx8mn-ddr-pmu", "fsl,imx8m-ddr-pmu";
>                         reg = <0x3d800000 0x400000>;
>                         interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>                 };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index c36685916683..ee6dc5f07622 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -103,10 +103,34 @@
>
>  &A53_3 {
>         cpu-supply = <&buck2_reg>;
>  };
>
> +&ddrc {
> +       operating-points-v2 = <&ddrc_opp_table>;
> +
> +       ddrc_opp_table: opp-table {
> +               compatible = "operating-points-v2";
> +
> +               opp-25M {
> +                       opp-hz = /bits/ 64 <25000000>;
> +               };
> +               opp-100M {
> +                       opp-hz = /bits/ 64 <100000000>;
> +               };
> +               /*
> +                * On imx8mq B0 PLL can't be bypassed so low bus is 166M
> +                */
> +               opp-166M {
> +                       opp-hz = /bits/ 64 <166935483>;
> +               };
> +               opp-800M {
> +                       opp-hz = /bits/ 64 <800000000>;
> +               };
> +       };
> +};
> +
>  &fec1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_fec1>;
>         phy-mode = "rgmii-id";
>         phy-handle = <&ethphy0>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 7f9319452b58..d1fcf9887f8b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1111,10 +1111,20 @@
>                         interrupt-controller;
>                         interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-parent = <&gic>;
>                 };
>
> +               ddrc: memory-controller@3d400000 {
> +                       compatible = "fsl,imx8mq-ddrc", "fsl,imx8m-ddrc";
> +                       reg = <0x3d400000 0x400000>;
> +                       clock-names = "core", "pll", "alt", "apb";
> +                       clocks = <&clk IMX8MQ_CLK_DRAM_CORE>,
> +                                <&clk IMX8MQ_DRAM_PLL_OUT>,
> +                                <&clk IMX8MQ_CLK_DRAM_ALT>,
> +                                <&clk IMX8MQ_CLK_DRAM_APB>;
> +               };
> +
>                 ddr-pmu@3d800000 {
>                         compatible = "fsl,imx8mq-ddr-pmu", "fsl,imx8m-ddr-pmu";
>                         reg = <0x3d800000 0x400000>;
>                         interrupt-parent = <&gic>;
>                         interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
