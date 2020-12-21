Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750282DFCC2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 15:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgLUOYH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 09:24:07 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38645 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgLUOYH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 09:24:07 -0500
Received: by mail-wm1-f50.google.com with SMTP id g185so11086548wmf.3;
        Mon, 21 Dec 2020 06:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t92iU2s6tie/otzdcUrjmsNAfZxVxfg7pY63xjxoqR0=;
        b=J/HROd+z0t942Hu5enguHoPMdFtajdIqK3eTDQhVqdsnENye/eFlo2KpFcsll56WNB
         O1GEtZnyOIee627js04uiecP6mrkvlUlBx+mjAFKVNAleimtPZD7yWvXdh0H93p4lWrt
         068h/CKO1fd8UJkPc5SL36EJJiKJ8zZ7QzKskDWeEmdi8dIOJ9rBav8NqwzzOALAaAes
         ExYBUKZELcBlYj5tAkq8ebnXCPMDI6RsXF8baQLE8Uiw2Lu7SNX8ceDhVeRzxkM4j8wq
         kJoZtGcWl9kK71laTe8UbI7Wdjnb9kBwV7uhQUgNWg3ow22R48XaxEBYeuX/BqX+oZRf
         3pug==
X-Gm-Message-State: AOAM533yERmcTUGirr1AfMuV5b2oEwEQiLejekYKunm3APK2cW5JaPKt
        NI2+Bs19yrLQNH8XGgfl8K4=
X-Google-Smtp-Source: ABdhPJydHMJbjUHhJ6XejcwGmjRgE3+AwUk9spdEBcvmCbwYVI0W9dTUWUeG2jHzkMrCpRq4wEDJAQ==
X-Received: by 2002:a1c:6144:: with SMTP id v65mr16759171wmb.125.1608560604690;
        Mon, 21 Dec 2020 06:23:24 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h29sm29546011wrc.68.2020.12.21.06.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 06:23:23 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:23:22 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 5/6] ARM: dts: exynos: Added top-off charging
 regulator node for i9100
Message-ID: <20201221142322.GE33797@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201221095001.595366-1-timon.baetz@protonmail.com>
 <20201221095001.595366-5-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221095001.595366-5-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 09:53:35AM +0000, Timon Baetz wrote:
> Value taken from Galaxy S2 vendor kernel [0] which always sets 200mA.

Subject: "Add", not "Added", as in Linux coding style.

> 
> Also rearrange regulators based on definition in max8997.h.
> 
> [0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic-4g-touch-sph-d710-exynos4210-dump/drivers/power/sec_battery_u1.c#L1525
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  arch/arm/boot/dts/exynos4210-i9100.dts | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
> index 586d801af0b5..fec6da64f7c1 100644
> --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> @@ -560,6 +560,16 @@ safe2_sreg: ESAFEOUT2 {
>  				regulator-boot-on;
>  			};
>  
> +			EN32KHZ_AP {
> +				regulator-name = "EN32KHZ_AP";
> +				regulator-always-on;
> +			};
> +
> +			EN32KHZ_CP {
> +				regulator-name = "EN32KHZ_CP";
> +				regulator-always-on;
> +			};
> +
>  			charger_reg: CHARGER {
>  				regulator-name = "CHARGER";
>  				regulator-min-microamp = <200000>;
> @@ -573,13 +583,10 @@ chargercv_reg: CHARGER_CV {
>  				regulator-always-on;
>  			};
>  
> -			EN32KHZ_AP {
> -				regulator-name = "EN32KHZ_AP";
> -				regulator-always-on;
> -			};
> -
> -			EN32KHZ_CP {
> -				regulator-name = "EN32KHZ_CP";
> +			chargertopoff_reg: CHARGER_TOPOFF {

No need for label "chargertopoff_reg".

Best regards,
Krzysztof
