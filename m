Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE58E30D35E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 07:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhBCG2Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 01:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhBCG2P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 01:28:15 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A87C06174A
        for <linux-pm@vger.kernel.org>; Tue,  2 Feb 2021 22:27:34 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id g9so3270880ilc.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2021 22:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5H7u6zfULjhTslVinp72inAV8tftlmzyLj44kPZOIo=;
        b=ATr9kJuhoM7hsEPMLnjZO+qm6UV1LVj8rzqxjUU8jx4jPJAuLYrR7/ZJvq/6fqdSZQ
         YKZmkGo8OmonC93l2P0UjhAlLyQpvI2y4QXQZzaehVss6Kyw5UiKDYw4hb2oGnyYq+ja
         E5b+ocFQF8WGclyVsu0U5ahnR/jWsjkBBHlbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5H7u6zfULjhTslVinp72inAV8tftlmzyLj44kPZOIo=;
        b=JAU6DDa4yLpuC9hxnRR/uSUNXCGh59oh4MyvySURekA+8M+wxdoHBuObdKTRYr4/G/
         sNFBgVpOkk4q34PhakrA7rtrHjbljwQyzPGkYS0LCDNrm2RRix07GemgaLeulXFxkMIa
         Dq2/vkeH/zDC6JDVCZJlFvzg8SOgVMmQGewddkZAT1IAyMv5WcS64ewVtdg8SEklq7YL
         mrsIoeLZxHzl6vTnBpNiUG6V1MrLeVyUqW79/WNaiMOno7ccS9UVUqVq7HoKsvf6pux0
         EWJ3Dcram+AfOB5J3tks5ivbTS7zTCCde2y/OYWd6A3L38n2W66uC1Ge63rSRA/xNI81
         hwEw==
X-Gm-Message-State: AOAM530jVJ/64nr+V5v015E0AJhW6hQVOJeqhZ1UvOApxDOGfr1Jdz/8
        OD229aV/vZFCqA8IBkLaZf1Dd6ZE3K0Kvu5XTdXr1A==
X-Google-Smtp-Source: ABdhPJxejwYn2puVey+RwiCn1hqYG5601tBESzbm/PelZLqN5flyaRACJ3sbmOAAzVTl66bgVRKcsUxC399ATAVUfXY=
X-Received: by 2002:a92:cc4d:: with SMTP id t13mr370408ilq.150.1612333654249;
 Tue, 02 Feb 2021 22:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20210129101012.25180-1-michael.kao@mediatek.com> <20210129101012.25180-2-michael.kao@mediatek.com>
In-Reply-To: <20210129101012.25180-2-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 3 Feb 2021 14:27:08 +0800
Message-ID: <CAJMQK-iYYGQ3N08PnkDzwSOc22ydEeekp_e1bXrm9Eas9xJQrA@mail.gmail.com>
Subject: Re: [v6,1/3] arm64: dts: mt8183: add thermal zone node
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     fan.chen@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        srv_heupstream@mediatek.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 29, 2021 at 6:10 PM Michael Kao <michael.kao@mediatek.com> wrote:
>
> From: "michael.kao" <michael.kao@mediatek.com>
>
> Add thermal zone node to Mediatek MT8183 dts file.
>
> Evaluate the thermal zone every 500ms while not cooling
> and every 100ms when passive cooling is performed.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 84 ++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5b782a4769e7..0aa31d338fb0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -657,6 +657,87 @@
>                         status = "disabled";
>                 };
>
> +               thermal: thermal@1100b000 {
> +                       #thermal-sensor-cells = <1>;
> +                       compatible = "mediatek,mt8183-thermal";
> +                       reg = <0 0x1100b000 0 0x1000>;
> +                       clocks = <&infracfg CLK_INFRA_THERM>,
> +                                <&infracfg CLK_INFRA_AUXADC>;
> +                       clock-names = "therm", "auxadc";
> +                       resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
> +                       interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
> +                       mediatek,auxadc = <&auxadc>;
> +                       mediatek,apmixedsys = <&apmixedsys>;
> +                       nvmem-cells = <&thermal_calibration>;
> +                       nvmem-cell-names = "calibration-data";
> +               };
> +
> +               thermal-zones {
> +                       cpu_thermal: cpu_thermal {
> +                               polling-delay-passive = <100>;
> +                               polling-delay = <500>;
> +                               thermal-sensors = <&thermal 0>;
> +                               sustainable-power = <5000>;
> +                       };
> +
> +                       /* The tzts1 ~ tzts6 don't need to polling */
> +                       /* The tzts1 ~ tzts6 don't need to thermal throttle */
> +
> +                       tzts1: tzts1 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 1>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
> +                       tzts2: tzts2 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 2>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
> +                       tzts3: tzts3 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 3>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
> +                       tzts4: tzts4 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 4>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
> +                       tzts5: tzts5 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 5>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
> +                       tztsABB: tztsABB {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 6>;
> +                               sustainable-power = <5000>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +               };
> +
>                 pwm0: pwm@1100e000 {
>                         compatible = "mediatek,mt8183-disp-pwm";
>                         reg = <0 0x1100e000 0 0x1000>;
> @@ -926,6 +1007,9 @@
>                         reg = <0 0x11f10000 0 0x1000>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> +                       thermal_calibration: calib@180 {
> +                               reg = <0x180 0xc>;
> +
missing };

>                         mipi_tx_calibration: calib@190 {
>                                 reg = <0x190 0xc>;
>                         };
> --
> 2.18.0
>
