Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9258BCF7
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfHMP0C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 11:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbfHMP0B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Aug 2019 11:26:01 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC942184B;
        Tue, 13 Aug 2019 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565709960;
        bh=HmV3d0tX/vIGU4K6vVAo5cUg5Z8uSssDtsYqHJAG5bg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oXTK/Z2XPavPmmocWCTzqLAhdopHEqr0+WhpFAK86e901QMUz2hwOJ782cXRzWt6O
         dd73osGsviYHzdVpTeZ7PctENRLocN/S6i3IIyyXpit2zvkMSpRGWyOpqenE2s4clG
         NWV+sTZ4ZhnFbgA7AijE2ghB1sb8nDYpGJvZVppw=
Received: by mail-qk1-f176.google.com with SMTP id 201so79889272qkm.9;
        Tue, 13 Aug 2019 08:26:00 -0700 (PDT)
X-Gm-Message-State: APjAAAWLC6YJdMtPlS/iI+m/2q69RnrRQJSKhRbSsao4/flCJw99Muwd
        V/7qONQvMCUEJMCrEzeSciYqz86Z16DgmEP+nQ==
X-Google-Smtp-Source: APXvYqwu0CBqLROjtaQy/EXgqwp575KsDNniswfKsW6qsOEg0w760DgeRdr91KRxD6alIStviaHUoqrBGdSw3n2c0Xw=
X-Received: by 2002:a37:6944:: with SMTP id e65mr31723600qkc.119.1565709959793;
 Tue, 13 Aug 2019 08:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190812121511.4169-1-frank-w@public-files.de> <20190812121511.4169-2-frank-w@public-files.de>
In-Reply-To: <20190812121511.4169-2-frank-w@public-files.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 09:25:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+fW=x8MoL3GMj6+ZKC3fd6F6+8Rtx=j5R9vEuL9UHCuQ@mail.gmail.com>
Message-ID: <CAL_Jsq+fW=x8MoL3GMj6+ZKC3fd6F6+8Rtx=j5R9vEuL9UHCuQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] dt-bindings: add powercontroller
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 6:24 AM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> From: Josef Friedl <josef.friedl@speed.at>
>
> add mt6323-rtc and mt6323-pwrc to mt6397 mfd DT bindings
> an example is shown in mt6323-poweroff.txt

How does this get to v5 with such a terrible subject? At least give
some indication this is for some Mediatek chip.

The recipient list needs some work too. Don't Cc git committers that
get_maintainers.pl lists.

>
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> changes since v4: use relative path
> changes since v3: none
> changes since v2: separated rtc-mt6397.txt to part 2
> ---
>  .../devicetree/bindings/mfd/mt6397.txt        | 20 +++++++++++++------
>  .../bindings/power/reset/mt6323-poweroff.txt  | 20 +++++++++++++++++++
>  2 files changed, 34 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
>
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 0ebd08af777d..063f5fe1cace 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -8,11 +8,12 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
>  - Clock
>  - LED
>  - Keys
> +- Power controller
>
>  It is interfaced to host controller using SPI interface by a proprietary hardware
>  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
>  See the following for pwarp node definitions:
> -Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +../../bindings/soc/mediatek/pwrap.txt

Unrelated change to what the subject says. Clean-ups and new things in
separate patches please.

>
>  This document describes the binding for MFD device and its sub module.
>
> @@ -22,14 +23,16 @@ compatible: "mediatek,mt6397" or "mediatek,mt6323"
>  Optional subnodes:
>
>  - rtc
> -       Required properties:
> +       Required properties: Should be one of follows
> +               - compatible: "mediatek,mt6323-rtc"

How is this related to 'powercontroller'?

>                 - compatible: "mediatek,mt6397-rtc"
> +       For details, see ../../bindings/rtc/rtc-mt6397.txt
>  - regulators
>         Required properties:
>                 - compatible: "mediatek,mt6397-regulator"
> -       see Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
> +       see ../../bindings/regulator/mt6397-regulator.txt
>                 - compatible: "mediatek,mt6323-regulator"
> -       see Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> +       see ../../bindings/regulator/mt6323-regulator.txt
>  - codec
>         Required properties:
>                 - compatible: "mediatek,mt6397-codec"
> @@ -39,12 +42,17 @@ Optional subnodes:
>  - led
>         Required properties:
>                 - compatible: "mediatek,mt6323-led"
> -       see Documentation/devicetree/bindings/leds/leds-mt6323.txt
> +       see ../../bindings/leds/leds-mt6323.txt
>
>  - keys
>         Required properties:
>                 - compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
> -       see Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> +       see ../../bindings/input/mtk-pmic-keys.txt
> +
> +- power-controller
> +       Required properties:
> +               - compatible: "mediatek,mt6323-pwrc"
> +       For details, see ../../bindings/power/reset/mt6323-poweroff.txt
>
>  Example:
>         pwrap: pwrap@1000f000 {
> diff --git a/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> new file mode 100644
> index 000000000000..933f0c48e887
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> @@ -0,0 +1,20 @@
> +Device Tree Bindings for Power Controller on MediaTek PMIC
> +
> +The power controller which could be found on PMIC is responsible for externally
> +powering off or on the remote MediaTek SoC through the circuit BBPU.
> +
> +Required properties:
> +- compatible: Should be one of follows
> +       "mediatek,mt6323-pwrc": for MT6323 PMIC
> +
> +Example:
> +
> +       pmic {
> +               compatible = "mediatek,mt6323";
> +
> +               ...
> +
> +               power-controller {
> +                       compatible = "mediatek,mt6323-pwrc";
> +               };
> +       }
> --
> 2.17.1
>
