Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72D73C6D18
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 11:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhGMJUz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 05:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhGMJUz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 05:20:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F50C0613EE
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 02:18:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so24266332wro.9
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ewEO5MHGcmAYvogawgNCpQFpb7n+ZIMY7fSG23QfRTM=;
        b=IPBbiZ2JbktF+haUg2zYgBjGTi9+Mdvb5IEohZtSNIOMef+cZvCtpNlH72FG7q7UCs
         ibHJFhOu8yjCK7DBREPzXjTAshbnjRkbEzpgm05Mh502bISWJBVIpyd7Y2WgmhE6/B4D
         dvF6WluGEWJcksqoDZKIKpErB0bqbQ7SusaxDRAZ2I9tfl9b2m0NkJJQooOZj8dX7JM6
         U9sEse5FpSAs/N4zrmUGPZuJNRGGgsdXRIryt+MDy1N7X2PY0eZHsO3Co4VQ+lHrn0bw
         wtndCWrMH84W4mzZ5X7c6IMtitYUTYk6rJkdTeO1XAZlarTqnB0DvVgkOZkH2aQRPOhv
         YgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ewEO5MHGcmAYvogawgNCpQFpb7n+ZIMY7fSG23QfRTM=;
        b=O0V6Be85nC1DLiZO1yzHQqQ9MxXRt1ENaUX1bpduZAO/AFwZIO2Z0hg/z9N5uWwiuX
         Q2jOyPK5/mN9+dWQzWWfDD2Xq913Vf3pgC5d3azWJNj+T1LwcHwG5c2BrkiSQ2NoJLLA
         5JcZayS8eZKAdTQwXKprlcjIU5r57TK0hwX9T96ZKsKW0lJxcftau6d2mS5+5hZii94G
         DSFpKJyFFr2df6EJGA7DcreQXGQHs0MkmdwHa7BMp8QGn4mTsE7VPtMyeGv9EMuNZzx8
         K+MZf+VVgpKoJpd65KRcTIKpxuvpNKuy9gMX3S+rPYkgfqS9Y1nqBn+DP6O4p7kLzWVi
         5TuA==
X-Gm-Message-State: AOAM5304DfhxEr2DV4dEOvHj31dJm681v58JBbFgfCC7PX2F2sjwN+Zw
        sLBcY+YL7PnTJpvNJxVQT8Y70A==
X-Google-Smtp-Source: ABdhPJxk+wHbMBSyJZq1DnAP6a6eJsWWNd4mXYLV79Ryi/iwYbkATYfbBhs56+4Bzqmr4OxnR8T23g==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr4323761wrw.163.1626167884123;
        Tue, 13 Jul 2021 02:18:04 -0700 (PDT)
Received: from google.com ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id o3sm17061852wrw.56.2021.07.13.02.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:18:03 -0700 (PDT)
Date:   Tue, 13 Jul 2021 10:18:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
Message-ID: <YO1aSSSankv+cAru@google.com>
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

What is still useful?

The GPIO and Regulator drivers?

> for the other functionality it provides.
> 
> [1] https://github.com/beagleboard/beaglev-starlight
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
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

I can't say that I've been keeping up with the latest DT binding
changes, but shouldn't these lines be relocated into some kind of
optional listing?

Or are optional properties omitted from documentation?

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

Are you sure that the 0th line is not a valid IRQ?

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
