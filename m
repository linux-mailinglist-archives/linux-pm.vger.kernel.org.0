Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743631296F
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfECIEL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 04:04:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40458 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfECIEL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 04:04:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id k24so1925817qtq.7
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2019 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyYnh8hGNxo4y79JyoBAvnyJOsqV/eKCHgC2055Dj70=;
        b=TFsaDfJktcepJhaSVkSy9jmcH5WklitGZ2BBIrKTkDmfye484EI32NBvqAF18RhDM4
         icz2jBCDxSTj6qmQVp0LN0YlkJPVgxnXUunfIEesZ1FOAC5727DnzDgNJ++yI7ZM9nil
         K47/JWKZTYl0cyTlCD15zHWhm1WvSpjJECOdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyYnh8hGNxo4y79JyoBAvnyJOsqV/eKCHgC2055Dj70=;
        b=g/bxmcZMthtqTvJbaJZFEzVpNsGcpvvRhLo9yvOTjS2u8Q5vRszikddWPDh+AEA/er
         tTz5nS4WOjDnIWICIG3upAWoaAQUBTzNcC1rowWhCrYBEpHjyXCAYtwQ01lq2HFvC6xZ
         bfDSvEdj8VR8MNtMh21D+oZud9nzD1UA4iF9uKPI0/QxwX9HuGAI7KYQkj/unOqJC6mt
         +JsphYCwMAG8IBXh6Qf1j7E3xZfFfkACKXjsbd9/0oCAkELtxrcVWOjhyiwDDJoxMZ+e
         M8DjtZSRtsrUd4/17dV3ypbIF6lvvMnArHw2fqxBmq+Tc58jzrNNN2ymT1G07Clq/FHt
         fNOQ==
X-Gm-Message-State: APjAAAWmqqwoWQC2Wb0kE41whH1Z/L+8wK/Br1sTlH4FTDrpemMBFvd9
        D4wGBNqMNqj5vsPm6BzMoCpVammC0bvgCY5UkAIO0w==
X-Google-Smtp-Source: APXvYqwK9NYfQA/9uIkz+E3ZSXoSVmvGacXxJP1bm9lZj8RtDGEHaMjRHL1WIrVFMhk5ZLbA20X7lzzIyVAj/Hr6Db0=
X-Received: by 2002:ac8:3822:: with SMTP id q31mr7331051qtb.0.1556870649914;
 Fri, 03 May 2019 01:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com> <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 3 May 2019 16:03:58 +0800
Message-ID: <CAJMQK-isJf6f+OubbCdoXs8L2cup=rm3Z8Mr7Q26QshMP-0wxA@mail.gmail.com>
Subject: Re: [PATCH 1/8] arm64: dts: mt8183: add thermal zone node
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     fan.chen@mediatek.com, jamesjj.liao@mediatek.com,
        dawei.chien@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
>
> Add thermal zone node to Mediatek MT8183 dts file.
>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 ++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 926df75..b92116f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -334,6 +334,67 @@
>                         status = "disabled";
>                 };
>
> +               thermal: thermal@1100b000 {
> +                       #thermal-sensor-cells = <1>;
> +                       compatible = "mediatek,mt8183-thermal";
> +                       reg = <0 0x1100b000 0 0x1000>;
> +                       interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_THERM>,
> +                                <&infracfg CLK_INFRA_AUXADC>;
> +                       clock-names = "therm", "auxadc";
> +                       resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
> +                       mediatek,auxadc = <&auxadc>;
> +                       mediatek,apmixedsys = <&apmixedsys>;
> +                       mediatek,hw-reset-temp = <117000>;
> +                       nvmem-cells = <&thermal_calibration>;
> +                       nvmem-cell-names = "calibration-data";
> +               };
> +
> +               thermal-zones {
> +                       cpu_thermal: cpu_thermal {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +
> +                               thermal-sensors = <&thermal 0>;
> +                               sustainable-power = <1500>;
> +                       };
> +
> +                       tzts1: tzts1 {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 1>;
Is sustainable-power required for tzts? Though it's an optional
property, kernel would have warning:
[    0.631556] thermal thermal_zone1: power_allocator:
sustainable_power will be estimated
[    0.639586] thermal thermal_zone2: power_allocator:
sustainable_power will be estimated
[    0.647611] thermal thermal_zone3: power_allocator:
sustainable_power will be estimated
[    0.655635] thermal thermal_zone4: power_allocator:
sustainable_power will be estimated
[    0.663658] thermal thermal_zone5: power_allocator:
sustainable_power will be estimated
if no sustainable-power assigned.

> +                       };
> +
> +                       tzts2: tzts2 {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 2>;
> +                       };
> +
> +                       tzts3: tzts3 {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 3>;
> +                       };
> +
> +                       tzts4: tzts4 {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 4>;
> +                       };
> +
> +                       tzts5: tzts5 {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 5>;
> +                       };
> +
> +                       tztsABB: tztsABB {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 6>;
> +                       };
> +               };
>                 audiosys: syscon@11220000 {
>                         compatible = "mediatek,mt8183-audiosys", "syscon";
>                         reg = <0 0x11220000 0 0x1000>;
> @@ -368,6 +429,9 @@
>                         compatible = "mediatek,mt8183-efuse",
>                                      "mediatek,efuse";
>                         reg = <0 0x11f10000 0 0x1000>;
> +                       thermal_calibration: calib@180 {
> +                               reg = <0x180 0xc>;
> +                       };
>                 };
>
>                 mfgcfg: syscon@13000000 {
