Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C7B2C1FC6
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 09:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgKXIVA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 03:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgKXIU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 03:20:59 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BC2C0617A6
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 00:20:59 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so21007411ioo.7
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 00:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/x0LTb4J+x0tLkU4UfWhgC2IEt8b2Ne7z/1P9Z0zjA=;
        b=WgmWs9slVGpefYI3u0JHnro604o3Rsq37SkQhMRrVMYlX/I0yTj+7o3zmxiXFzt/tf
         bhnMMfKan6dMtMuDpoPKwLz+aQ/FMx/7F1N/6iAKe7b/qxjzVUSItHnJlVrjmryJ7Jax
         zBBhZWT4nMXkonUV58hrO/c24uCLaMdPZheAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/x0LTb4J+x0tLkU4UfWhgC2IEt8b2Ne7z/1P9Z0zjA=;
        b=DLhkOzjSkQ4yE3ZtiFZ2QDYTRooqmpRs+X6BbwSYRGOvuI7+rZJ7Ng0RD8uUbcL6SP
         aTB4VHpplh/rXk687gXTyatIUW/ggJXBuC47XTt4u2T/f8kfulqvFV4OgYUzB+73+Y3v
         rORvOjZbdpauxOl+5fl1LxNIyMRhYrEJwZTMFhH78s6kDehFf+gGs6svGX0gGJnnoRv5
         JL0LRSEkFSdSShlrZQCJkv2LLst6k4lqLrqmqpwWyLMJ60rECf2LmmqKllXA4WcMVzI4
         MF/IgQ3lNvgz+rU0pBgwT87OYqkAQQ/gs7pOD715cuovM7YArN/NLb9SUXsH89DEpE+n
         gebQ==
X-Gm-Message-State: AOAM532F4M8utzlEq5fC9h+JsnBYKnKuh4t7PhEpWhTPb1y1+QeJAa7m
        sAL+Epi9cdR8xcpaFfGoQ2n5CNH5l7/KxhvZWZz2Bw==
X-Google-Smtp-Source: ABdhPJwDD+cQREmdCGOOrIMuL9X8U9Zd3cwX9xY7MHPd1cZdR0F/0sSKV86O9Bh13f2qdJctm1O4CME4HC/nfxZd+EI=
X-Received: by 2002:a05:6638:3f1:: with SMTP id s17mr3341338jaq.102.1606206059023;
 Tue, 24 Nov 2020 00:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20201013102358.22588-1-michael.kao@mediatek.com> <20201013102358.22588-2-michael.kao@mediatek.com>
In-Reply-To: <20201013102358.22588-2-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 24 Nov 2020 16:20:33 +0800
Message-ID: <CAJMQK-hCDH_-JZG6uBrTmbCf-HG0J4GxGj2kyeh5sgjJs5Et1g@mail.gmail.com>
Subject: Re: [v5 1/3] arm64: dts: mt8183: add thermal zone node
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
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
        <linux-mediatek@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 6:24 PM Michael Kao <michael.kao@mediatek.com> wrote:
>
> From: "Michael.Kao" <michael.kao@mediatek.com>
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
> index 8fed72bb35d7..1cd093cf33f3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -430,6 +430,86 @@
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

According to binding document[1], interrupts is required.
interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;

[1] https://elixir.bootlin.com/linux/v5.10-rc3/source/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt#L18

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
>                 i2c3: i2c@1100f000 {
>                         compatible = "mediatek,mt8183-i2c";
>                         reg = <0 0x1100f000 0 0x1000>,
> @@ -675,6 +755,10 @@
>                         compatible = "mediatek,mt8183-efuse",
>                                      "mediatek,efuse";
>                         reg = <0 0x11f10000 0 0x1000>;
> +
> +                       thermal_calibration: calib@180 {
> +                               reg = <0x180 0xc>;
> +                       };
>                 };
>
>                 u3phy: usb-phy@11f40000 {
> --
> 2.18.0
