Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FBD3CFD24
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 17:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhGTOcP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbhGTO0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 10:26:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCA5C061766
        for <linux-pm@vger.kernel.org>; Tue, 20 Jul 2021 08:07:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so2249906wmc.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Jul 2021 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZchSkqqeZHzePVYsbmpNPWMr8AHwfOK/Nimhsgdw20k=;
        b=wceYh3thBth6Xa62fuP1K5Ul4BsCMcJuj9jMyeBMI6EHhauuhkeYgIbSNH2GW+adn6
         h1QXKDD3eaiBN2uG2HgonalMI1tAPXtvf8XvdcGNz+kHmAE0myT8VjKY1qNxXTKovdig
         CSs7hHT9M+/UaDqrofrtU+uxzOaqaiA+t/rTOr3v+wcxs9IKFEuJUAdiNSbbIX8Z5JQI
         Gp3LOOxJ1N5MkQmFkogou6Bk06IHNXmqqcnzbS4xL5oNc4ZBBps0exNOWkVVdjGyLvob
         cUBIVOi1M3MTj5fMeS6Xc/DrirM0Wm9dwbUl1D5DH8Mciyy5ALWoTqZaZ7q0CV3e4ExP
         Lm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZchSkqqeZHzePVYsbmpNPWMr8AHwfOK/Nimhsgdw20k=;
        b=Q/IbP6Dr0w8LcaLWbC3JNErfiQIhY6KrzdGmG3ydI1M1NLVm2Z5251Fz7QrniHyVaK
         uXbnU107OD2rfThRL2Cd+sZAUL36MAeWvdFPQrfo2y3FdbRiayfTKUBVjpxh3sWl9sAP
         Zis+XEKj0ytsG4POIelkRk0VXSo3252pryfjUKhyOPwynCyPH1BqmA1carPRP+lAZkgK
         Nu9KhQn0W7G2JN0sojbkYxmubFS335fUA7UNarKOqk3UjvBRlVlsXEbK6DOtiiyItOWc
         8khXDHB0tjW0bsg49d/AYL0zqLlKBU+oiyZCbK0ZKpnJLkVhaQOgAFVCwGTbTpwY0ox2
         4Spg==
X-Gm-Message-State: AOAM530Ek/aCfRVTF5PmSGiwiMOqq37ryiEYO2Ji8xWUNQebKgoev9nw
        9PY5GXGhhxK9B9+gypnwSWpT0Q==
X-Google-Smtp-Source: ABdhPJz4swRydDEinMuj8EVyfy7S6E0iFeWjbsF6RSRqUQMZ4nsjJslx2T3fEkUS2AtZ6FigTFlw/Q==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr32300209wmh.186.1626793629290;
        Tue, 20 Jul 2021 08:07:09 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id b12sm24216314wro.1.2021.07.20.08.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 08:07:08 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:07:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
Message-ID: <YPbmmqfOuE5w6EgW@google.com>
References: <20210625224744.1020108-1-kernel@esmil.dk>
 <20210625224744.1020108-3-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625224744.1020108-3-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 26 Jun 2021, Emil Renner Berthing wrote:

> The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
> the SoC, but it is still useful to be able to reach the PMIC over I2C
> for the other functionality it provides.
> 
> [1] https://github.com/beagleboard/beaglev-starlight
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---

This is not present in my current tree.

Looks like it's still *.txt.

Am I missing a patch?

>  drivers/mfd/tps65086.c                        | 21 ++++++++++---------
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> index ba638bd10a58..4b629fcc0df9 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> @@ -87,9 +87,6 @@ additionalProperties: false
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-controller
> -  - '#interrupt-cells'
>    - gpio-controller
>    - '#gpio-cells'
>    - regulators
> diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
> index 341466ef20cc..cc3478ee9a64 100644
> --- a/drivers/mfd/tps65086.c
> +++ b/drivers/mfd/tps65086.c
> @@ -100,29 +100,30 @@ static int tps65086_probe(struct i2c_client *client,
>  		 (char)((version & TPS65086_DEVICEID_OTP_MASK) >> 4) + 'A',
>  		 (version & TPS65086_DEVICEID_REV_MASK) >> 6);
>  
> -	ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
> -				  &tps65086_irq_chip, &tps->irq_data);
> -	if (ret) {
> -		dev_err(tps->dev, "Failed to register IRQ chip\n");
> -		return ret;
> +	if (tps->irq > 0) {
> +		ret = regmap_add_irq_chip(tps->regmap, tps->irq, IRQF_ONESHOT, 0,
> +					  &tps65086_irq_chip, &tps->irq_data);
> +		if (ret) {
> +			dev_err(tps->dev, "Failed to register IRQ chip\n");
> +			return ret;
> +		}
>  	}
>  
>  	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65086_cells,
>  			      ARRAY_SIZE(tps65086_cells), NULL, 0,
>  			      regmap_irq_get_domain(tps->irq_data));
> -	if (ret) {
> +	if (ret && tps->irq > 0)
>  		regmap_del_irq_chip(tps->irq, tps->irq_data);
> -		return ret;
> -	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int tps65086_remove(struct i2c_client *client)
>  {
>  	struct tps65086 *tps = i2c_get_clientdata(client);
>  
> -	regmap_del_irq_chip(tps->irq, tps->irq_data);
> +	if (tps->irq > 0)
> +		regmap_del_irq_chip(tps->irq, tps->irq_data);
>  
>  	return 0;
>  }

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
