Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7A22C7F8D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 09:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgK3IPz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 03:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3IPz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 03:15:55 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB65C0613D2
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 00:15:09 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e25so4462406wme.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 00:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q1vs0sV3cZPp2QqcUi0eLSimO9mR0ljchwGD+OrpRB4=;
        b=dRSj4HXe4vcj2Z58jxrAKWfIXbuGl9PxLkCsbtLRCv5KNlUkDaDidrpTI/+LBthbcW
         pEKhOiVPk8u4a8lmdd/xWeLcOMF1nqrCXJ+0iAt+xAnbNsV+AfjzvcaJr47Y0O7zAjyd
         +13RawA5Uy1PE7wnn4TOJk6lgU0aqrkVBjDinL3mnA+e7bqHxK2ZwyhquvpbWViVNEkW
         nPdSxOXhJ9y5a8vgucEtDF9ysGf8Yn+mzgO5CMpTOchTqAQ/Vam2hTJ639Mh/rmYyXTr
         XBs9s2l5TliOJIszIiAGmWQOIxzAIkP6F6Il3uBFLLbiIWerZSyRtVjczcB6DA5GSNpx
         jHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q1vs0sV3cZPp2QqcUi0eLSimO9mR0ljchwGD+OrpRB4=;
        b=FmvUO+aV5OabrnYmLwMqufwpn6w3TVLxslXCB50vaa8qauWGeEs5JlBROJNhJY2zfY
         JMx2eOKTTQgV9D1ioZyyXENo6cZGyBJu2KcOJiTHRUK2kI/ZBPuYXRpJhMs4skvfbg60
         H2ipdKxYUBnC7MrTzrGlK7zGs9S8DwuSVq+P+qz9R+bxoqZipQELFCwqzjxnvmKCNqQu
         azvAzFS/AuJVWZKs404jfXa3oNr99qgT1x4XvKiKI+mrO+v8qbflJTxgxKuMo8oZsyIQ
         04NDWXkUBZ6DFkiXZ5gzs++xcQ6Q9YjMr2My52lBSEDo/A5Fb8qSXSsZTINV+/6jRduj
         dgIQ==
X-Gm-Message-State: AOAM531JK7klZ0VstOP5vog/qyuQCc6NW8ucJjki9cVNj7i7w6DP4T8p
        x8tvcqJXKxgP4Mlu/hY9ThXrag==
X-Google-Smtp-Source: ABdhPJysI7NRahJ9sF5Oq5ojz55osPly3MjAwFO3rML10/jfVxqrG1KC9UBOOh2hr4voNMxLw4J+Zw==
X-Received: by 2002:a1c:220b:: with SMTP id i11mr444264wmi.8.1606724101765;
        Mon, 30 Nov 2020 00:15:01 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:a9e1:bc04:469:f21b? ([2a01:e34:ed2f:f020:a9e1:bc04:469:f21b])
        by smtp.googlemail.com with ESMTPSA id g11sm27752897wrq.7.2020.11.30.00.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 00:15:01 -0800 (PST)
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Do not use interrupts for
 normal operation
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20201126220923.3107213-1-niklas.soderlund+renesas@ragnatech.se>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <601e00a8-12ba-da54-224f-89c448d755dc@linaro.org>
Date:   Mon, 30 Nov 2020 09:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126220923.3107213-1-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/11/2020 23:09, Niklas Söderlund wrote:
> Remove the usage of interrupts for the normal temperature operation and
> depend on the polling performed by the thermal core. This is done to
> prepare to use the interrupts as they are intended to trigger once
> specific trip points are passed and not to react to temperature changes
> in the normal operational range.

I'm not sure to understand the change. Is it not more interesting to
have the polling mode disabled for PM reasons and let the interrupt to
fire at the first trip point so the mitigation happens then with the
polling passive ?

> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 108 +---------------------------
>  1 file changed, 2 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 0dd47dca3e771256..94f2c133a47f66b6 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -188,70 +188,10 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
>  	return 0;
>  }
>  
> -static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
> -					      int mcelsius)
> -{
> -	int celsius, val;
> -
> -	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
> -	if (celsius <= INT_FIXPT(tsc->tj_t))
> -		val = celsius * tsc->coef.a1 + tsc->coef.b1;
> -	else
> -		val = celsius * tsc->coef.a2 + tsc->coef.b2;
> -
> -	return INT_FIXPT(val);
> -}
> -
> -static int rcar_gen3_thermal_update_range(struct rcar_gen3_thermal_tsc *tsc)
> -{
> -	int temperature, low, high;
> -
> -	rcar_gen3_thermal_get_temp(tsc, &temperature);
> -
> -	low = temperature - MCELSIUS(1);
> -	high = temperature + MCELSIUS(1);
> -
> -	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
> -				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
> -
> -	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
> -				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
> -
> -	return 0;
> -}
> -
>  static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
>  	.get_temp	= rcar_gen3_thermal_get_temp,
>  };
>  
> -static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
> -{
> -	unsigned int i;
> -	u32 val = on ? IRQ_TEMPD1 | IRQ_TEMP2 : 0;
> -
> -	for (i = 0; i < priv->num_tscs; i++)
> -		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, val);
> -}
> -
> -static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
> -{
> -	struct rcar_gen3_thermal_priv *priv = data;
> -	u32 status;
> -	int i;
> -
> -	for (i = 0; i < priv->num_tscs; i++) {
> -		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
> -		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
> -		if (status) {
> -			rcar_gen3_thermal_update_range(priv->tscs[i]);
> -			thermal_zone_device_update(priv->tscs[i]->zone,
> -						   THERMAL_EVENT_UNSPECIFIED);
> -		}
> -	}
> -
> -	return IRQ_HANDLED;
> -}
> -
>  static const struct soc_device_attribute r8a7795es1[] = {
>  	{ .soc_id = "r8a7795", .revision = "ES1.*" },
>  	{ /* sentinel */ }
> @@ -268,7 +208,6 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
>  
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> -	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
>  
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
>  				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
> @@ -294,7 +233,6 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
>  
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> -	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
>  
>  	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
>  	reg_val |= THCTR_THSST;
> @@ -345,9 +283,6 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
>  static int rcar_gen3_thermal_remove(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
> -
> -	rcar_thermal_irq_set(priv, false);
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> @@ -369,8 +304,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  	const int *rcar_gen3_ths_tj_1 = of_device_get_match_data(dev);
>  	struct resource *res;
>  	struct thermal_zone_device *zone;
> -	int ret, irq, i;
> -	char *irqname;
> +	int ret, i;
>  
>  	/* default values if FUSEs are missing */
>  	/* TODO: Read values from hardware on supported platforms */
> @@ -386,28 +320,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -	/*
> -	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
> -	 * to trigger on the low and high trip points of the current
> -	 * temp window at this point.
> -	 */
> -	for (i = 0; i < 2; i++) {
> -		irq = platform_get_irq(pdev, i);
> -		if (irq < 0)
> -			return irq;
> -
> -		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
> -					 dev_name(dev), i);
> -		if (!irqname)
> -			return -ENOMEM;
> -
> -		ret = devm_request_threaded_irq(dev, irq, NULL,
> -						rcar_gen3_thermal_irq,
> -						IRQF_ONESHOT, irqname, priv);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> @@ -459,8 +371,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto error_unregister;
>  
> -		rcar_gen3_thermal_update_range(tsc);
> -
>  		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
>  	}
>  
> @@ -471,8 +381,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		goto error_unregister;
>  	}
>  
> -	rcar_thermal_irq_set(priv, true);
> -
>  	return 0;
>  
>  error_unregister:
> @@ -481,15 +389,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int __maybe_unused rcar_gen3_thermal_suspend(struct device *dev)
> -{
> -	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
> -
> -	rcar_thermal_irq_set(priv, false);
> -
> -	return 0;
> -}
> -
>  static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
>  {
>  	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
> @@ -499,15 +398,12 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
>  		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
>  
>  		priv->thermal_init(tsc);
> -		rcar_gen3_thermal_update_range(tsc);
>  	}
>  
> -	rcar_thermal_irq_set(priv, true);
> -
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, rcar_gen3_thermal_suspend,
> +static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, NULL,
>  			 rcar_gen3_thermal_resume);
>  
>  static struct platform_driver rcar_gen3_thermal_driver = {
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
