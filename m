Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52C9341E23
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 14:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCSN2d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 09:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhCSN2L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 09:28:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FD8C06174A;
        Fri, 19 Mar 2021 06:28:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jy13so9696895ejc.2;
        Fri, 19 Mar 2021 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rz4javqIhPARBGO3fxYJeV7awumWYMML8YY2O7D8vh0=;
        b=hZcZsnvDCC5N47GB1Rf55munLCK0g6EA/T3VUPkNjF9Pt1eGVHlud2ax9zEgj/dp2c
         jMvQW5r239QOmbhneONNC02whOzOqOntM2UHwpIplfIuYlC1oU7PKOrGFMY98QCOYZfU
         51sa2UsFg3+2Om5DzW/yDRKJAAqSU5V9LAY4dQEM1w66oxh0fXTpIClBR5rkZE1QXdDV
         S1PJmEU5/JiO2WVzGWuPFU4gUVcNw73imz7aXJSlFbizEoVwwrUA9dvrFbBj4rYtefyC
         c507zEffNTbfVepz8nPkTW2UCZCVT458qrwLct1nRhgtnieVsk7igLf9GK4FWzD8ZBen
         aIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rz4javqIhPARBGO3fxYJeV7awumWYMML8YY2O7D8vh0=;
        b=S1ZnkxQJsZu0gFskakzth7ieBpXvr6timLBcJGWmYtO5s6LUnwXxej34Nts78VXcKE
         W7ABf5H9KSNeE5+Gr8h4xNbX9LaUKcVIpTxqHC4791htBQmgkqptcq6xxgbBCjhBeN77
         pbr44El06RuiwJUdMZXT07vzIV8c6IPItLhvIzXFOPg9TDFtfymRXIH71VRs8wVMdtPQ
         359RFOnlz2hl1G9FxX6ZaSli+veiVT84nqZa6Xmt950KiIpQ8L7Ld7kK8CzX2a3wKC39
         jbTx1aEz/nDPBEOB0vblEcO3jqUnkbN9u3NuEi10jIUWixNQ8R4aW0+0h95fkeTug9W+
         wKLA==
X-Gm-Message-State: AOAM533LRZwg/PoCXUqjvMhHzbB+tACqLEAKYFpAiOHXjMFoTBDkSc9J
        5SmPo6LKsxFR27FN81Zy6Oc=
X-Google-Smtp-Source: ABdhPJysnPAiCZdTy9nzn2dt1N0bp0Iv528ispsW19RF7dYJ3W5PKGgtS7K6xaQhZDWfE1BZFBI3gg==
X-Received: by 2002:a17:906:311a:: with SMTP id 26mr4246354ejx.395.1616160489141;
        Fri, 19 Mar 2021 06:28:09 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.gmail.com with ESMTPSA id a12sm4004619edx.91.2021.03.19.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 06:28:08 -0700 (PDT)
Date:   Fri, 19 Mar 2021 14:28:06 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/9] drivers: thermal: tsens: Add VER_0 tsens version
Message-ID: <YFSm5rz3ivnzxoJ4@Ansuel-xps.localdomain>
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
 <20210319005228.1250-2-ansuelsmth@gmail.com>
 <7c38ea02-d957-6f63-ccce-1c35dd5d04de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c38ea02-d957-6f63-ccce-1c35dd5d04de@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 19, 2021 at 09:11:38AM -0400, Thara Gopinath wrote:
> 
> 
> On 3/18/21 8:52 PM, Ansuel Smith wrote:
> > VER_0 is used to describe device based on tsens version before v0.1.
> > These device are devices based on msm8960 for example apq8064 or
> > ipq806x.
> 
> Hi Ansuel,
> 
> There are still checkpatch check warnings in this patch. Please run
> checkpatch.pl --strict and fix them. Once that is done, you can add
> 
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> 
> Warm Regards
> Thara
>

Hi,
thanks a lot for the review. The only warning I have is a line ending
with ( that i think I can't fix or I will go over the max char for line.
Do you have something more?

> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >   drivers/thermal/qcom/tsens.c | 141 ++++++++++++++++++++++++++++-------
> >   drivers/thermal/qcom/tsens.h |   4 +-
> >   2 files changed, 116 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index d8ce3a687b80..277d9b17e949 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/of.h>
> >   #include <linux/of_address.h>
> >   #include <linux/of_platform.h>
> > +#include <linux/mfd/syscon.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/pm.h>
> >   #include <linux/regmap.h>
> > @@ -515,6 +516,15 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
> >   			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> >   				hw_id, __func__, temp);
> >   		}
> > +
> > +		if (tsens_version(priv) < VER_0_1) {
> > +			/* Constraint: There is only 1 interrupt control register for all
> > +			 * 11 temperature sensor. So monitoring more than 1 sensor based
> > +			 * on interrupts will yield inconsistent result. To overcome this
> > +			 * issue we will monitor only sensor 0 which is the master sensor.
> > +			 */
> > +			break;
> > +		}
> >   	}
> >   	return IRQ_HANDLED;
> > @@ -530,6 +540,13 @@ static int tsens_set_trips(void *_sensor, int low, int high)
> >   	int high_val, low_val, cl_high, cl_low;
> >   	u32 hw_id = s->hw_id;
> > +	if (tsens_version(priv) < VER_0_1) {
> > +		/* Pre v0.1 IP had a single register for each type of interrupt
> > +		 * and thresholds
> > +		 */
> > +		hw_id = 0;
> > +	}
> > +
> >   	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
> >   		hw_id, __func__, low, high);
> > @@ -584,18 +601,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
> >   	u32 valid;
> >   	int ret;
> > -	ret = regmap_field_read(priv->rf[valid_idx], &valid);
> > -	if (ret)
> > -		return ret;
> > -	while (!valid) {
> > -		/* Valid bit is 0 for 6 AHB clock cycles.
> > -		 * At 19.2MHz, 1 AHB clock is ~60ns.
> > -		 * We should enter this loop very, very rarely.
> > -		 */
> > -		ndelay(400);
> > +	/* VER_0 doesn't have VALID bit */
> > +	if (tsens_version(priv) >= VER_0_1) {
> >   		ret = regmap_field_read(priv->rf[valid_idx], &valid);
> >   		if (ret)
> >   			return ret;
> > +		while (!valid) {
> > +			/* Valid bit is 0 for 6 AHB clock cycles.
> > +			 * At 19.2MHz, 1 AHB clock is ~60ns.
> > +			 * We should enter this loop very, very rarely.
> > +			 */
> > +			ndelay(400);
> > +			ret = regmap_field_read(priv->rf[valid_idx], &valid);
> > +			if (ret)
> > +				return ret;
> > +		}
> >   	}
> >   	/* Valid bit is set, OK to read the temperature */
> > @@ -608,15 +628,29 @@ int get_temp_common(const struct tsens_sensor *s, int *temp)
> >   {
> >   	struct tsens_priv *priv = s->priv;
> >   	int hw_id = s->hw_id;
> > -	int last_temp = 0, ret;
> > +	int last_temp = 0, ret, trdy;
> > +	unsigned long timeout;
> > -	ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
> > -	if (ret)
> > -		return ret;
> > +	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
> > +	do {
> > +		if (tsens_version(priv) == VER_0) {
> > +			ret = regmap_field_read(priv->rf[TRDY], &trdy);
> > +			if (ret)
> > +				return ret;
> > +			if (!trdy)
> > +				continue;
> > +		}
> > -	*temp = code_to_degc(last_temp, s) * 1000;
> > +		ret = regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
> > +		if (ret)
> > +			return ret;
> > -	return 0;
> > +		*temp = code_to_degc(last_temp, s) * 1000;
> > +
> > +		return 0;
> > +	} while (time_before(jiffies, timeout));
> > +
> > +	return -ETIMEDOUT;
> >   }
> >   #ifdef CONFIG_DEBUG_FS
> > @@ -738,19 +772,31 @@ int __init init_common(struct tsens_priv *priv)
> >   		priv->tm_offset = 0x1000;
> >   	}
> > -	res = platform_get_resource(op, IORESOURCE_MEM, 0);
> > -	tm_base = devm_ioremap_resource(dev, res);
> > -	if (IS_ERR(tm_base)) {
> > -		ret = PTR_ERR(tm_base);
> > -		goto err_put_device;
> > +	if (tsens_version(priv) >= VER_0_1) {
> > +		res = platform_get_resource(op, IORESOURCE_MEM, 0);
> > +		tm_base = devm_ioremap_resource(dev, res);
> > +		if (IS_ERR(tm_base)) {
> > +			ret = PTR_ERR(tm_base);
> > +			goto err_put_device;
> > +		}
> > +
> > +		priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
> > +	} else { /* VER_0 share the same gcc regs using a syscon */
> > +		struct device *parent = priv->dev->parent;
> > +
> > +		if (parent)
> > +			priv->tm_map = syscon_node_to_regmap(parent->of_node);
> >   	}
> > -	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
> > -	if (IS_ERR(priv->tm_map)) {
> > +	if (IS_ERR_OR_NULL(priv->tm_map)) {
> >   		ret = PTR_ERR(priv->tm_map);
> >   		goto err_put_device;
> >   	}
> > +	/* VER_0 have only tm_map */
> > +	if (!priv->srot_map)
> > +		priv->srot_map = priv->tm_map;
> > +
> >   	if (tsens_version(priv) > VER_0_1) {
> >   		for (i = VER_MAJOR; i <= VER_STEP; i++) {
> >   			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
> > @@ -769,6 +815,10 @@ int __init init_common(struct tsens_priv *priv)
> >   		ret = PTR_ERR(priv->rf[TSENS_EN]);
> >   		goto err_put_device;
> >   	}
> > +	/* in VER_0 TSENS need to be explicitly enabled */
> > +	if (tsens_version(priv) == VER_0)
> > +		regmap_field_write(priv->rf[TSENS_EN], 1);
> > +
> >   	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
> >   	if (ret)
> >   		goto err_put_device;
> > @@ -791,6 +841,20 @@ int __init init_common(struct tsens_priv *priv)
> >   		goto err_put_device;
> >   	}
> > +	priv->rf[TSENS_SW_RST] = devm_regmap_field_alloc(
> > +		dev, priv->srot_map, priv->fields[TSENS_SW_RST]);
> > +	if (IS_ERR(priv->rf[TSENS_SW_RST])) {
> > +		ret = PTR_ERR(priv->rf[TSENS_SW_RST]);
> > +		goto err_put_device;
> > +	}
> > +
> > +	priv->rf[TRDY] =
> > +		devm_regmap_field_alloc(dev, priv->tm_map, priv->fields[TRDY]);
> > +	if (IS_ERR(priv->rf[TRDY])) {
> > +		ret = PTR_ERR(priv->rf[TRDY]);
> > +		goto err_put_device;
> > +	}
> > +
> >   	/* This loop might need changes if enum regfield_ids is reordered */
> >   	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
> >   		for (i = 0; i < priv->feat->max_sensors; i++) {
> > @@ -806,7 +870,7 @@ int __init init_common(struct tsens_priv *priv)
> >   		}
> >   	}
> > -	if (priv->feat->crit_int) {
> > +	if (priv->feat->crit_int || tsens_version(priv) < VER_0_1) {
> >   		/* Loop might need changes if enum regfield_ids is reordered */
> >   		for (j = CRITICAL_STATUS_0; j <= CRIT_THRESH_15; j += 16) {
> >   			for (i = 0; i < priv->feat->max_sensors; i++) {
> > @@ -844,7 +908,11 @@ int __init init_common(struct tsens_priv *priv)
> >   	}
> >   	spin_lock_init(&priv->ul_lock);
> > -	tsens_enable_irq(priv);
> > +
> > +	/* VER_0 interrupt doesn't need to be enabled */
> > +	if (tsens_version(priv) >= VER_0_1)
> > +		tsens_enable_irq(priv);
> > +
> >   	tsens_debug_init(op);
> >   err_put_device:
> > @@ -943,10 +1011,14 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
> >   		if (irq == -ENXIO)
> >   			ret = 0;
> >   	} else {
> > -		ret = devm_request_threaded_irq(&pdev->dev, irq,
> > -						NULL, thread_fn,
> > -						IRQF_ONESHOT,
> > -						dev_name(&pdev->dev), priv);
> > +		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
> > +		ret = devm_request_threaded_irq(
> > +			&pdev->dev, irq,
> > +			tsens_version(priv) == VER_0 ? thread_fn : NULL,
> > +			tsens_version(priv) == VER_0 ? NULL : thread_fn,
> > +			tsens_version(priv) == VER_0 ? IRQF_TRIGGER_RISING :
> > +							     IRQF_ONESHOT,
> > +			dev_name(&pdev->dev), priv);
> >   		if (ret)
> >   			dev_err(&pdev->dev, "%s: failed to get irq\n",
> >   				__func__);
> > @@ -975,6 +1047,19 @@ static int tsens_register(struct tsens_priv *priv)
> >   			priv->ops->enable(priv, i);
> >   	}
> > +	/* VER_0 require to set MIN and MAX THRESH
> > +	 * These 2 regs are set using the:
> > +	 * - CRIT_THRESH_0 for MAX THRESH hardcoded to 120°C
> > +	 * - CRIT_THRESH_1 for MIN THRESH hardcoded to   0°C
> > +	 */
> > +	if (tsens_version(priv) < VER_0_1) {
> > +		regmap_field_write(priv->rf[CRIT_THRESH_0],
> > +				   tsens_mC_to_hw(priv->sensor, 120000));
> > +
> > +		regmap_field_write(priv->rf[CRIT_THRESH_1],
> > +				   tsens_mC_to_hw(priv->sensor, 0));
> > +	}
> > +
> >   	ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
> >   	if (ret < 0)
> >   		return ret;
> > diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> > index f40b625f897e..8e6c1fd3ccf5 100644
> > --- a/drivers/thermal/qcom/tsens.h
> > +++ b/drivers/thermal/qcom/tsens.h
> > @@ -13,6 +13,7 @@
> >   #define CAL_DEGC_PT2		120
> >   #define SLOPE_FACTOR		1000
> >   #define SLOPE_DEFAULT		3200
> > +#define TIMEOUT_US		100
> >   #define THRESHOLD_MAX_ADC_CODE	0x3ff
> >   #define THRESHOLD_MIN_ADC_CODE	0x0
> > @@ -25,7 +26,8 @@ struct tsens_priv;
> >   /* IP version numbers in ascending order */
> >   enum tsens_ver {
> > -	VER_0_1 = 0,
> > +	VER_0 = 0,
> > +	VER_0_1,
> >   	VER_1_X,
> >   	VER_2_X,
> >   };
> > 
