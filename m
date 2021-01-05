Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64A52EA8A2
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbhAEK2H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 5 Jan 2021 05:28:07 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41340 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbhAEK2H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 05:28:07 -0500
Received: by mail-ot1-f41.google.com with SMTP id x13so28788627oto.8;
        Tue, 05 Jan 2021 02:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PmiKbSPT7SMid5h27DytWQnhKllxdBmyV/3B1JSoclU=;
        b=e9I15tGd0/IdywFf0So4fhN2lPpSNqfHC3zP8Tag7FCcxnKtWl9CfhWuBz74y+b2Aj
         Ab+9do5FMEbv/99V0FxDlk0uQaeBHMEMKdM6cKZZV7N/n44O2+1pmn68NGtg7L2ezYPf
         BnFQH3aXZAzIxix8SEG/MCTcW8GeyaMsPFopdPA1qgR0G6LrkL0zF0N1z1RF7GbG2opZ
         N4IufYAQHpACO+iU++TFHr9NSWv5bJu/lcIiSyvWmc8UxBk/BDTF8Bn0G2oodkx9bAby
         uxtNYsYDgQIomOkTaTpAy8eGShiDN2OccBjYUh68YHbtgRsWYKvwSL4KNCprPSAUVouF
         eDhg==
X-Gm-Message-State: AOAM532SCC0eqirwp67cC3mXSOCDECjH4a4AMv8R/PmjLHUZCRe5fWwz
        2+AMidZKPvAqk+koVp18FQA8AeqoEyVmVwxE/eMrAqnQ
X-Google-Smtp-Source: ABdhPJz+RNY7JNuJ8BDud0xIAalpOZVqhXvyHXZNAS8hPYmuGcQkH2WXMf07G86NdmuknRZkQsjZhqBv8odQnaZDAAU=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr55654130otc.145.1609842446721;
 Tue, 05 Jan 2021 02:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20201126223028.3119044-1-niklas.soderlund+renesas@ragnatech.se> <20201126223028.3119044-3-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20201126223028.3119044-3-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Jan 2021 11:27:15 +0100
Message-ID: <CAMuHMdW=9gDi-D7htccg6mF+FV-B8AfLnrvyNkyEPe=EoNYKYg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a779a0: Add thermal support
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Thu, Nov 26, 2020 at 11:30 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Add support for thermal.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> @@ -91,6 +91,18 @@ sysc: system-controller@e6180000 {
>                         #power-domain-cells = <1>;
>                 };
>
> +               tsc: thermal@e6190000 {
> +                       compatible = "renesas,r8a779a0-thermal";
> +                       reg = <0 0xe6190000 0 0x100>,
> +                             <0 0xe6198000 0 0x100>,
> +                             <0 0xe61a0000 0 0x100>,
> +                             <0 0xe61a8000 0 0x100>;

The fifth region at 0x161b0000 is missing.

> +                       clocks = <&cpg CPG_MOD 919>;
> +                       power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
> +                       resets = <&cpg 919>;
> +                       #thermal-sensor-cells = <1>;
> +               };
> +
>                 scif0: serial@e6e60000 {
>                         compatible = "renesas,scif-r8a779a0",
>                                      "renesas,rcar-gen3-scif", "renesas,scif";
> @@ -123,6 +135,64 @@ prr: chipid@fff00044 {
>                 };
>         };
>
> +       thermal-zones {
> +               sensor_thermal1: sensor-thermal1 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +                       thermal-sensors = <&tsc 0>;
> +
> +                       trips {
> +                               sensor1_crit: sensor1-crit {
> +                                       temperature = <120000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               sensor_thermal2: sensor-thermal2 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +                       thermal-sensors = <&tsc 1>;
> +
> +                       trips {
> +                               sensor2_crit: sensor2-crit {
> +                                       temperature = <120000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               sensor_thermal3: sensor-thermal3 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +                       thermal-sensors = <&tsc 2>;
> +
> +                       trips {
> +                               sensor3_crit: sensor3-crit {
> +                                       temperature = <120000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               sensor_thermal4: sensor-thermal4 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +                       thermal-sensors = <&tsc 3>;
> +
> +                       trips {
> +                               sensor4_crit: sensor4-crit {
> +                                       temperature = <120000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };

Missing fifth entry.

> +       };
> +
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
