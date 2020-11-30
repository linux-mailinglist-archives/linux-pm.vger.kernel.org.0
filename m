Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2353F2C837E
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgK3LuB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 06:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgK3LuB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 06:50:01 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC5C0617A6
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 03:49:20 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so21009006lfd.9
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 03:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QZL455zZgR9IkoFVhLEukf9RpsG8Se+X81g4rybPkT8=;
        b=Ayicjb9Mkw9ERGA8iTvkAQvSzwJS+USZ+z0hP6QoSmKhTNEmQp71MdhlidkFT5JYjl
         /ARgviVo7Vfx6C7ALErqyg0YordrgIHewfuuOCkRIqVWwRZlq3GUJ5bhHFcK60k73k3K
         isyJ+PNYE0nNqRtieHKPRM+v9GYpFglnQ2rDs+SEzWEaQPqITRKKgA1FvtJFHH3DBzLp
         yJeCVlo30rT1lVaRFxeyBQJccg0w9o/KiDcUAXICcEslXrxw1/H+/4+M7iAFvyw/UkRa
         hwXhPmSqRw5RH9Uu9tU11EnCoeDU9OwtFqH7HEgmri3QlvCTnJvuU3+j+tzYttZu+rP5
         vRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QZL455zZgR9IkoFVhLEukf9RpsG8Se+X81g4rybPkT8=;
        b=aUViB5nexVXx1w7R47L/xhdsMolRcEoZk3/gMcCTUaiEBf/ivgdNWdNlT7KFDu+Aad
         p0QVDOF+Fvl9CbP9i20dApuDyMLU7KA8Gumro9HANVRpLffG+t6ol/3baFJrNPer8SKV
         q0SlcMetLno4xU/bqNsSkxWmfXleS/9+0U4wClrVel2rALWKHCHY7MCkFrXxwxwJzI5t
         R5eA3MJlqDm0VKNg7jmoYkbnmiTaEj/jTqbhKOc2qaeuWw8i2vTyxZoIQ3KiQpF9qXcG
         pzCaRE6xgBsgmj859TMShBwWP5XGVpDbrL97pSq9p4Gd4/L80dOaG78vvWazgN6kSCDi
         xOZg==
X-Gm-Message-State: AOAM530nAc2ZFQi9COh/b6WxY4dbGUWiriWkpuLyWZGK1tj5j1DtytgK
        +RJFaeu7EMDXDFzeF234JgURCxus0ZAByA==
X-Google-Smtp-Source: ABdhPJwxa1OA4eJT4ImQb4R1N9sYGnzaAlWUsaoxSbdxoFFh09Nv22IHk+NDvXiDjhIZHDTR9jho0w==
X-Received: by 2002:a05:6512:20cd:: with SMTP id u13mr9241673lfr.373.1606736959296;
        Mon, 30 Nov 2020 03:49:19 -0800 (PST)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id 18sm2146175ljj.13.2020.11.30.03.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 03:49:18 -0800 (PST)
Date:   Mon, 30 Nov 2020 12:49:17 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Do not use interrupts for
 normal operation
Message-ID: <20201130114917.GE3323880@oden.dyn.berto.se>
References: <20201126220923.3107213-1-niklas.soderlund+renesas@ragnatech.se>
 <601e00a8-12ba-da54-224f-89c448d755dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <601e00a8-12ba-da54-224f-89c448d755dc@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Thanks for your comments.

On 2020-11-30 09:15:00 +0100, Daniel Lezcano wrote:
> On 26/11/2020 23:09, Niklas Söderlund wrote:
> > Remove the usage of interrupts for the normal temperature operation and
> > depend on the polling performed by the thermal core. This is done to
> > prepare to use the interrupts as they are intended to trigger once
> > specific trip points are passed and not to react to temperature changes
> > in the normal operational range.
> 
> I'm not sure to understand the change. Is it not more interesting to
> have the polling mode disabled for PM reasons and let the interrupt to
> fire at the first trip point so the mitigation happens then with the
> polling passive ?

I agree and this is one of two goals I have with this change, in the 
long run. The other is to be able support SoC models where the 
interrupts may not be accessible.

The change in this patch is to stop using the interrupts to fire as soon 
as the temp moves +/- 1 degree C, see rcar_gen3_thermal_update_range().  
When I wrote that code I had misunderstood how things should be done and 
thought I should use the interrupts as a substitute to the polling done 
by the core and generate a THERMAL_EVENT_UNSPECIFIED as soon as the temp 
changed, see rcar_gen3_thermal_irq().

The way I understand it today is that I should instead setup the 
interrupts to fire if the temp moves over a trip point, in my case 
described in DT to allow the system to be informed of this as you 
describe above.

In this firs change I'm simply removing my incorrect usage of interrupts 
that I in future changes will add back in an correct usage pattern while 
at the same time making interrupts optional to support SoCs where the 
may not be available.

Does this make sens or have I got the idea wrong?

> 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> >  drivers/thermal/rcar_gen3_thermal.c | 108 +---------------------------
> >  1 file changed, 2 insertions(+), 106 deletions(-)
> > 
> > diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> > index 0dd47dca3e771256..94f2c133a47f66b6 100644
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -188,70 +188,10 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
> >  	return 0;
> >  }
> >  
> > -static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
> > -					      int mcelsius)
> > -{
> > -	int celsius, val;
> > -
> > -	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
> > -	if (celsius <= INT_FIXPT(tsc->tj_t))
> > -		val = celsius * tsc->coef.a1 + tsc->coef.b1;
> > -	else
> > -		val = celsius * tsc->coef.a2 + tsc->coef.b2;
> > -
> > -	return INT_FIXPT(val);
> > -}
> > -
> > -static int rcar_gen3_thermal_update_range(struct rcar_gen3_thermal_tsc *tsc)
> > -{
> > -	int temperature, low, high;
> > -
> > -	rcar_gen3_thermal_get_temp(tsc, &temperature);
> > -
> > -	low = temperature - MCELSIUS(1);
> > -	high = temperature + MCELSIUS(1);
> > -
> > -	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
> > -				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
> > -
> > -	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
> > -				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
> > -
> > -	return 0;
> > -}
> > -
> >  static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
> >  	.get_temp	= rcar_gen3_thermal_get_temp,
> >  };
> >  
> > -static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
> > -{
> > -	unsigned int i;
> > -	u32 val = on ? IRQ_TEMPD1 | IRQ_TEMP2 : 0;
> > -
> > -	for (i = 0; i < priv->num_tscs; i++)
> > -		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, val);
> > -}
> > -
> > -static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
> > -{
> > -	struct rcar_gen3_thermal_priv *priv = data;
> > -	u32 status;
> > -	int i;
> > -
> > -	for (i = 0; i < priv->num_tscs; i++) {
> > -		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
> > -		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
> > -		if (status) {
> > -			rcar_gen3_thermal_update_range(priv->tscs[i]);
> > -			thermal_zone_device_update(priv->tscs[i]->zone,
> > -						   THERMAL_EVENT_UNSPECIFIED);
> > -		}
> > -	}
> > -
> > -	return IRQ_HANDLED;
> > -}
> > -
> >  static const struct soc_device_attribute r8a7795es1[] = {
> >  	{ .soc_id = "r8a7795", .revision = "ES1.*" },
> >  	{ /* sentinel */ }
> > @@ -268,7 +208,6 @@ static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_tsc *tsc)
> >  
> >  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
> >  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> > -	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
> >  
> >  	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
> >  				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
> > @@ -294,7 +233,6 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> >  
> >  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
> >  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
> > -	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
> >  
> >  	reg_val = rcar_gen3_thermal_read(tsc, REG_GEN3_THCTR);
> >  	reg_val |= THCTR_THSST;
> > @@ -345,9 +283,6 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
> >  static int rcar_gen3_thermal_remove(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
> > -
> > -	rcar_thermal_irq_set(priv, false);
> >  
> >  	pm_runtime_put(dev);
> >  	pm_runtime_disable(dev);
> > @@ -369,8 +304,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >  	const int *rcar_gen3_ths_tj_1 = of_device_get_match_data(dev);
> >  	struct resource *res;
> >  	struct thermal_zone_device *zone;
> > -	int ret, irq, i;
> > -	char *irqname;
> > +	int ret, i;
> >  
> >  	/* default values if FUSEs are missing */
> >  	/* TODO: Read values from hardware on supported platforms */
> > @@ -386,28 +320,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, priv);
> >  
> > -	/*
> > -	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
> > -	 * to trigger on the low and high trip points of the current
> > -	 * temp window at this point.
> > -	 */
> > -	for (i = 0; i < 2; i++) {
> > -		irq = platform_get_irq(pdev, i);
> > -		if (irq < 0)
> > -			return irq;
> > -
> > -		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
> > -					 dev_name(dev), i);
> > -		if (!irqname)
> > -			return -ENOMEM;
> > -
> > -		ret = devm_request_threaded_irq(dev, irq, NULL,
> > -						rcar_gen3_thermal_irq,
> > -						IRQF_ONESHOT, irqname, priv);
> > -		if (ret)
> > -			return ret;
> > -	}
> > -
> >  	pm_runtime_enable(dev);
> >  	pm_runtime_get_sync(dev);
> >  
> > @@ -459,8 +371,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >  		if (ret < 0)
> >  			goto error_unregister;
> >  
> > -		rcar_gen3_thermal_update_range(tsc);
> > -
> >  		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
> >  	}
> >  
> > @@ -471,8 +381,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >  		goto error_unregister;
> >  	}
> >  
> > -	rcar_thermal_irq_set(priv, true);
> > -
> >  	return 0;
> >  
> >  error_unregister:
> > @@ -481,15 +389,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> >  	return ret;
> >  }
> >  
> > -static int __maybe_unused rcar_gen3_thermal_suspend(struct device *dev)
> > -{
> > -	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
> > -
> > -	rcar_thermal_irq_set(priv, false);
> > -
> > -	return 0;
> > -}
> > -
> >  static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
> >  {
> >  	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
> > @@ -499,15 +398,12 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
> >  		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
> >  
> >  		priv->thermal_init(tsc);
> > -		rcar_gen3_thermal_update_range(tsc);
> >  	}
> >  
> > -	rcar_thermal_irq_set(priv, true);
> > -
> >  	return 0;
> >  }
> >  
> > -static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, rcar_gen3_thermal_suspend,
> > +static SIMPLE_DEV_PM_OPS(rcar_gen3_thermal_pm_ops, NULL,
> >  			 rcar_gen3_thermal_resume);
> >  
> >  static struct platform_driver rcar_gen3_thermal_driver = {
> > 
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

-- 
Regards,
Niklas Söderlund
