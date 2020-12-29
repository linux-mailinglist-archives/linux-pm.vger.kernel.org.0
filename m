Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0312E71EA
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 16:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgL2Pn5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 10:43:57 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43805 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgL2Pn5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 10:43:57 -0500
Received: by mail-wr1-f43.google.com with SMTP id y17so14976762wrr.10;
        Tue, 29 Dec 2020 07:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHLH9BKjnkBNG0P79WleVTRBo+h2LPhEpaoEfJZBQX0=;
        b=fvvKJkx+bbu40JUu/eyHW7ntULVo1+iDzVlCe5TqxfLbfT3XXddKB7LQJE2Fxt5G+7
         kLnLYovOjoP2iP91zo6kdQfRoikZvWaLxaeGlAwcggYSj2ua4Ofrmvv62yj8bkYZbNg3
         sqrMdko1WpElQ+R4xc4VQlChJwpfMKBvWVuZAfwBSu7xcNVyGGPjcPS4a9aU/Kcm4g8C
         /Rex1LTggH6vrEPzh/QFD965Znom8vYEps2vAzivcKF/PvjWrEpITqB0j/Im1qn1AZCK
         OlNRpLUCWgfrFzVzSY3R+J0bXtBdEjO/jR6CMm0clwfn2CnTegrwJuig8It+rbYq9f1e
         QhSw==
X-Gm-Message-State: AOAM533JRJaA6ingCQWMQvHIux0VdrKqqT5arJHa68t794pic8HYht3a
        Y93baLNxXC8Qe72/i8t0DKY=
X-Google-Smtp-Source: ABdhPJweM3e8AyF0aMzlpIqprrmb9hNyDdmwFBlBcfGIFYXxNSXRerv5RsLaIqFHnlbwj+F37pb3hg==
X-Received: by 2002:adf:a2ca:: with SMTP id t10mr29441011wra.370.1609256594329;
        Tue, 29 Dec 2020 07:43:14 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u205sm4101750wme.42.2020.12.29.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 07:43:13 -0800 (PST)
Date:   Tue, 29 Dec 2020 16:43:11 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Angus Ainslie <angus@akkea.ca>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 03/18] ARM: dts: exynos: correct fuel gauge interrupt
 trigger level on Midas family
Message-ID: <20201229154311.GA13025@kozik-lap>
References: <20201210212534.216197-1-krzk@kernel.org>
 <20201210212534.216197-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210212534.216197-3-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 10, 2020 at 10:25:19PM +0100, Krzysztof Kozlowski wrote:
> The Maxim fuel gauge datasheets describe the interrupt line as active
> low with a requirement of acknowledge from the CPU.  The falling edge
> interrupt will mostly work but it's not correct.
> 
> Fixes: e8614292cd41 ("ARM: dts: Add Maxim 77693 fuel gauge node for exynos4412-trats2")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Marek,

I remember you were reporting that on Trats2 you see fuel gauge
interrupt storm with this patchset. Is it correct? Shall I wait with
applying this?

Best regards,
Krzysztof

> diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
> index 111c32bae02c..b8b75dc81aa1 100644
> --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
> @@ -221,7 +221,7 @@ i2c_max77693_fuel: i2c-gpio-3 {
>  		fuel-gauge@36 {
>  			compatible = "maxim,max17047";
>  			interrupt-parent = <&gpx2>;
> -			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> +			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&max77693_fuel_irq>;
>  			reg = <0x36>;
> -- 
> 2.25.1
> 
