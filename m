Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D58C1E4D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfI3Jj1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 05:39:27 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40601 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbfI3Jj0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 05:39:26 -0400
Received: by mail-vs1-f68.google.com with SMTP id v10so6291571vsc.7
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cxq2bHjW+AlD4mf7jruqGrWE0fprB7ccNLUpIWh7TxQ=;
        b=ezaO9zszxJd+4Paz2hLVlDZc0d6U3pC4lCfi0hx3DLO+w5QuhSGeHUVHnB1NsO87YU
         /hKG68czBD7AnAolLrFBmu/xnQhcuDjd7HywSkHZaKPG4IrnGsro8QpWqisGbzZCMhK4
         fezjraSoXEiZbu8t5OWLAa62APj89GVmbo3sB8C6T4LL5PNtgGyRmBjhloSD9y42790/
         ZCeVZDcrRMTwJ4fQm7Jmx9rXCm7VmTJZot1YSFSD92VbD0LsQgyLKH6/JsDLHB9NgJvn
         DsC7BP3BZj8eCYngdpQGJJpalLx5oRJo0qgn+6E13Ez66aVjncVI36aajxbrpr1AOB+/
         2uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cxq2bHjW+AlD4mf7jruqGrWE0fprB7ccNLUpIWh7TxQ=;
        b=JlPrkhMXQ5CWsjsFHC4z4mfJ7ErsoFYt8qy9oqSQw5J+IVOI19oJgCUivioizcemWF
         XtyOyZ6OiLAugA2Gsoab0Ib4cr3gDhj0Qjk8RPC/7WIopwazDtdKA1+5vqgcfwFNTA6R
         VVpVE/M8YHvkMMPRXF+SASZdpeiMFnSsYznKOfR2jpeef6XPQDzz34PWhz6kx07gt+XW
         hIDMjsQK0pt9KsdG+LHPxJr3B+53ijy2KuZ6mySA8rI17CPW5xP1B+mctbuj3/HGzQBG
         UApocgV32jYCqtf8ipJZV3RTPDJdZ+NCavgy4+LlB0IhT8WS+b8Emv9w0vFEfSiicE85
         opVg==
X-Gm-Message-State: APjAAAVqPsywtWQzO0kUSmpIyaFgDkG3XtiHgSF1LJj5OAklB9qtGk0c
        eqdRraj1E3AenMjPKCGlZ9wzE2c+QJm761yqXC+E9g==
X-Google-Smtp-Source: APXvYqwypOTWZbzuX6iCn3PcY5YBeeHcL68LEGV3573E+3R3Wicv0r3ZFov2Xry98RLO/sXnr4hY51+x2ckMi5V8fnk=
X-Received: by 2002:a67:842:: with SMTP id 63mr9032821vsi.9.1569836364416;
 Mon, 30 Sep 2019 02:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190927184352.28759-1-glaroque@baylibre.com> <20190927184352.28759-4-glaroque@baylibre.com>
In-Reply-To: <20190927184352.28759-4-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 30 Sep 2019 15:09:13 +0530
Message-ID: <CAHLCerPQ4Uzoo2F-fNxZNV0_uZZnLwNenDYZTzgj7pfOiwPtGg@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] arm64: dts: amlogic: g12: add temperature sensor
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
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

On Sat, Sep 28, 2019 at 12:14 AM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Add cpu and ddr temperature sensors for G12 Socs
>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>


Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 38d70ce1cfc7..0660d9ef6a86 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -1353,6 +1353,26 @@
>                                 };
>                         };
>
> +                       cpu_temp: temperature-sensor@34800 {
> +                               compatible = "amlogic,g12a-cpu-thermal",
> +                                            "amlogic,g12a-thermal";
> +                               reg = <0x0 0x34800 0x0 0x50>;
> +                               interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +                               clocks = <&clkc CLKID_TS>;
> +                               #thermal-sensor-cells = <0>;
> +                               amlogic,ao-secure = <&sec_AO>;
> +                       };
> +
> +                       ddr_temp: temperature-sensor@34c00 {
> +                               compatible = "amlogic,g12a-ddr-thermal",
> +                                            "amlogic,g12a-thermal";
> +                               reg = <0x0 0x34c00 0x0 0x50>;
> +                               interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
> +                               clocks = <&clkc CLKID_TS>;
> +                               #thermal-sensor-cells = <0>;
> +                               amlogic,ao-secure = <&sec_AO>;
> +                       };
> +
>                         usb2_phy0: phy@36000 {
>                                 compatible = "amlogic,g12a-usb2-phy";
>                                 reg = <0x0 0x36000 0x0 0x2000>;
> --
> 2.17.1
>
