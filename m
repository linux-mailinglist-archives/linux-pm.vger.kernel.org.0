Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914EB80789
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2019 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfHCRwj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Aug 2019 13:52:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34702 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfHCRwi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Aug 2019 13:52:38 -0400
Received: by mail-oi1-f196.google.com with SMTP id l12so59250628oil.1;
        Sat, 03 Aug 2019 10:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giFFxAwzHVZcTDv5cDCIurtf5E8rD1w0AM4tyzYzsnQ=;
        b=AqJbCsXDWob/b1bzOngByMcRxPfvkbkLz4G34Vbw2MZRlyroyApUC5Yw87zvK1Fur+
         ApIUWtaYUtyP4jsJhLc+gdiuuNvpHs9jHIzxCAp91ZlfGebQMuEfPKgOhEWoSqbDqinM
         3YB973dJ2gsupR7H4uAehDFoKZ1fLBkDf88snzFgsNMMy7LP8S6V1Su/qea2eX6LY5Bt
         Mc6LCYXIshNWNXUKtet/Mh2yuJdoqwCUDVkt+1FRiqqMLXrb6YtQA9OZYz3dM3MX/M9n
         vQ3zQo6Y/m6jnWotG6iMVH6ooG0O9XcBCoDO1up9zhMyWlMXB4Fb3B3GP4rc4bjb0ox3
         3rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giFFxAwzHVZcTDv5cDCIurtf5E8rD1w0AM4tyzYzsnQ=;
        b=FpbYxujpCJTsMzFZAPUjNAMswInY0YLzPMevTlgUq3jU9T+PUY0WFTZ9BHmLr3o4aj
         d2GpInraScqm5qqoKHlwrqTqAra6pZ5h8hc10GMhmBJJd10rflOKzaLLkzzVBdjTNFfl
         VpWfbbYV08jZzgmUeJjiegoak3e/MWWyeJlsc8h2ORfA+tPfMYRfwXMKjeX5P86EYnGa
         +O7HHp3HUHfNy4HFejhzw6FWOTkdcwCQndSttA3WwQfG2XTetrZrf5o7FVHFR4I8+goC
         i7m0RCK0lHrxmTn0tlDgfetAi6hxXW40HufDLYASaVtSf7R5hF23PtJY9ZjPyMTQJ5/G
         yUNg==
X-Gm-Message-State: APjAAAWsX83Um/775s0DJSl2ws8qkGD4rA2kAIEOmw/kAXKaPwchJteh
        nU60tCspBoQvuxnStpPS0qxPD35TLX8fIMqU+pxaTdBP
X-Google-Smtp-Source: APXvYqxqdM5pIwO1f3rZx14fWOmsfcgj0wzLh+wItwhmdI2TFmrHh+uLmQVwCG+sWXsST/bisXbSaeQf/oOwXtq+xYQ=
X-Received: by 2002:a05:6808:3d6:: with SMTP id o22mr6383634oie.140.1564854757760;
 Sat, 03 Aug 2019 10:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153529.30159-1-glaroque@baylibre.com> <20190731153529.30159-4-glaroque@baylibre.com>
In-Reply-To: <20190731153529.30159-4-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 3 Aug 2019 19:52:26 +0200
Message-ID: <CAFBinCBYPiLgmTNk+7Db3EPSPePwbnAshCbomYPXWdse8i0oJw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: amlogic: g12: add temperature sensor
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
> Add cpu and ddr temperature sensors for G12 Socs
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
with the nit-pick below addressed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 06e186ca41e3..7f862a3490fb 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -1353,6 +1353,28 @@
>                                 };
>                         };
>
> +                       cpu_temp: temperature-sensor@34800 {
> +                               compatible = "amlogic,g12-cpu-thermal",
> +                                            "amlogic,g12-thermal";
> +                               reg = <0x0 0x34800 0x0 0x50>;
> +                               interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +                               clocks = <&clkc CLKID_TS>;
> +                               status = "okay";
I believe nodes are enabled automatically if they don't have a status property

> +                               #thermal-sensor-cells = <0>;
> +                               amlogic,ao-secure = <&sec_AO>;
> +                       };
> +
> +                       ddr_temp: temperature-sensor@34c00 {
> +                               compatible = "amlogic,g12-ddr-thermal",
> +                                            "amlogic,g12-thermal";
> +                               reg = <0x0 0x34c00 0x0 0x50>;
> +                               interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
> +                               clocks = <&clkc CLKID_TS>;
> +                               status = "okay";
same here


Martin
