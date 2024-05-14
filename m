Return-Path: <linux-pm+bounces-7847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78728C571D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 15:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5F11F21EDB
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13471448CB;
	Tue, 14 May 2024 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MKInXMmc"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329ED12B72;
	Tue, 14 May 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692813; cv=none; b=ZPMpCT5G+RWrODwRMEs/LvEBoN2JMF+TLggDaRghsVSeFL3vNDY65nMQXOpWYQKOzxqc0yKM3PN24aVVIW28TP1At7QZfBHtQS9ir7JynCUmRrkqPCSV4ACaWPcAXZ9KhlPr05oGcx7wMaNs9BxXrHzW34QJWzeBRr9Wc/9OgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692813; c=relaxed/simple;
	bh=hvvQETWMetj+N3pO8WbrIS73ipYxo50gX7RfK7LF3vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwYlZ61Z6ZfVCvpTwY5UGTiCkiwdWGbe29GXlMjt9Uz8r4WAYoS0Oe/qWLu9WJLs0gpN37ZS0GZ43rplbV5/pgb66hB0y8fy7EeLhD2ahtavZ7zNdNQz55Ms14OJtnXKisncrh8Td86u/PO3Nv94jWbP0Rsiped+pKveAYpWetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MKInXMmc; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D08881BF205;
	Tue, 14 May 2024 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715692809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phG0rMRQAjMUN9aqigoztyM2/6+7Kcz69rOYfUkJiXY=;
	b=MKInXMmcdSdJliN4APfC/oUDPXGJberVCUaE02yktzmhCDG9/8qhtWIpDQoA17ATvSfLiZ
	iH6CsbjZTST3e0KHOAQFn4pbUDYlh2btXsg+Hume3aB3Ed3eqbZKlyuLKK5LsadZaaTgrw
	cxFuJcb7wYqfPn3DPgdbQCkrQDc5XfANcVDXRqKtimHsolbLmuaL1a9uKq0p+I9Nu8uMue
	es6abvJeDzfP+rvg2Zf5MUEGQPmcGL5IPp+/xFyOMTzW1VHB9Y1ooGWmi2THQy9P22oLLL
	yUQhz1lJ9MTyzDbDw9Kobj0iR78NNLlhRvfmSBihaaKEaSxeqi0ycctM3Kvdiw==
Message-ID: <9ba0e257-91fa-485f-b903-04ef08307970@bootlin.com>
Date: Tue, 14 May 2024 15:20:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
To: rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com, u-kumar1@ti.com,
 j-keerthy@ti.com
References: <20240425153238.498750-1-thomas.richard@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20240425153238.498750-1-thomas.richard@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 4/25/24 17:32, Thomas Richard wrote:
> From: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> This add suspend-to-ram support.

Gentle ping.
Do you have any comments for this v4 ?

Best Regards,

Thomas

> 
> The derived_table is kept-as is, so the resume is only about
> pm_runtime_* calls and restoring the same registers as the probe.
> 
> Extract the hardware initialization procedure to a function called at
> both probe-time & resume-time.
> 
> The probe-time loop is split in two to ensure doing the hardware
> initialization before registering thermal zones. That ensures our
> callbacks cannot be called while in bad state.
> 
> The 100ms delay in the hardware initialization sequence was removed.
> It was initially added to be sure the thresholds are programmed before
> enabling the interrupt, but in fact it's not needed (tested on J7200
> platform).
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Acked-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> 
> v4:
>  - Remove the 100ms delay in the hardware initialization sequence
> v3:
>  - Remove __maybe_unused attributes and use the magic of PTR_IF()
> v2:
>  - Fix warnings/errors reported by kernel test robot
> 
>  drivers/thermal/k3_j72xx_bandgap.c | 111 ++++++++++++++++++++---------
>  1 file changed, 78 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> index c74094a86982..9bc279ac131a 100644
> --- a/drivers/thermal/k3_j72xx_bandgap.c
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -178,6 +178,7 @@ struct k3_j72xx_bandgap {
>  	void __iomem *base;
>  	void __iomem *cfg2_base;
>  	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];
> +	int cnt;
>  };
>  
>  /* common data structures */
> @@ -338,24 +339,52 @@ static void print_look_up_table(struct device *dev, int *ref_table)
>  		dev_dbg(dev, "%d       %d %d\n", i, derived_table[i], ref_table[i]);
>  }
>  
> +static void k3_j72xx_bandgap_init_hw(struct k3_j72xx_bandgap *bgp)
> +{
> +	struct k3_thermal_data *data;
> +	int id, high_max, low_temp;
> +	u32 val;
> +
> +	for (id = 0; id < bgp->cnt; id++) {
> +		data = bgp->ts_data[id];
> +		val = readl(bgp->cfg2_base + data->ctrl_offset);
> +		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
> +			K3_VTM_TMPSENS_CTRL_SOC |
> +			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
> +		writel(val, bgp->cfg2_base + data->ctrl_offset);
> +	}
> +
> +	/*
> +	 * Program TSHUT thresholds
> +	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
> +	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
> +	 *         This is already taken care as per of init
> +	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
> +	 */
> +	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
> +	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
> +
> +	writel((low_temp << 16) | high_max, bgp->cfg2_base + K3_VTM_MISC_CTRL2_OFFSET);
> +	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, bgp->cfg2_base + K3_VTM_MISC_CTRL_OFFSET);
> +}
> +
>  struct k3_j72xx_bandgap_data {
>  	const bool has_errata_i2128;
>  };
>  
>  static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>  {
> -	int ret = 0, cnt, val, id;
> -	int high_max, low_temp;
> -	struct resource *res;
> +	const struct k3_j72xx_bandgap_data *driver_data;
> +	struct thermal_zone_device *ti_thermal;
>  	struct device *dev = &pdev->dev;
> +	bool workaround_needed = false;
>  	struct k3_j72xx_bandgap *bgp;
>  	struct k3_thermal_data *data;
> -	bool workaround_needed = false;
> -	const struct k3_j72xx_bandgap_data *driver_data;
> -	struct thermal_zone_device *ti_thermal;
> -	int *ref_table;
>  	struct err_values err_vals;
>  	void __iomem *fuse_base;
> +	int ret = 0, val, id;
> +	struct resource *res;
> +	int *ref_table;
>  
>  	const s64 golden_factors[] = {
>  		-490019999999999936,
> @@ -422,10 +451,10 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>  
>  	/* Get the sensor count in the VTM */
>  	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
> -	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
> -	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
> +	bgp->cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
> +	bgp->cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
>  
> -	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
> +	data = devm_kcalloc(bgp->dev, bgp->cnt, sizeof(*data), GFP_KERNEL);
>  	if (!data) {
>  		ret = -ENOMEM;
>  		goto err_alloc;
> @@ -449,8 +478,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>  	else
>  		init_table(3, ref_table, pvt_wa_factors);
>  
> -	/* Register the thermal sensors */
> -	for (id = 0; id < cnt; id++) {
> +	/* Precompute the derived table & fill each thermal sensor struct */
> +	for (id = 0; id < bgp->cnt; id++) {
>  		data[id].bgp = bgp;
>  		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
>  		data[id].stat_offset = data[id].ctrl_offset +
> @@ -470,13 +499,13 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>  		else if (id == 0 && !workaround_needed)
>  			memcpy(derived_table, ref_table, TABLE_SIZE * 4);
>  
> -		val = readl(data[id].bgp->cfg2_base + data[id].ctrl_offset);
> -		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
> -			K3_VTM_TMPSENS_CTRL_SOC |
> -			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
> -		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
> -
>  		bgp->ts_data[id] = &data[id];
> +	}
> +
> +	k3_j72xx_bandgap_init_hw(bgp);
> +
> +	/* Register the thermal sensors */
> +	for (id = 0; id < bgp->cnt; id++) {
>  		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
>  							   &k3_of_thermal_ops);
>  		if (IS_ERR(ti_thermal)) {
> @@ -486,21 +515,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	/*
> -	 * Program TSHUT thresholds
> -	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
> -	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
> -	 *         This is already taken care as per of init
> -	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
> -	 */
> -	high_max = k3_j72xx_bandgap_temp_to_adc_code(MAX_TEMP);
> -	low_temp = k3_j72xx_bandgap_temp_to_adc_code(COOL_DOWN_TEMP);
> -
> -	writel((low_temp << 16) | high_max, data[0].bgp->cfg2_base +
> -	       K3_VTM_MISC_CTRL2_OFFSET);
> -	mdelay(100);
> -	writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
> -	       K3_VTM_MISC_CTRL_OFFSET);
> +	platform_set_drvdata(pdev, bgp);
>  
>  	print_look_up_table(dev, ref_table);
>  	/*
> @@ -527,6 +542,35 @@ static void k3_j72xx_bandgap_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
>  
> +static int k3_j72xx_bandgap_suspend(struct device *dev)
> +{
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	return 0;
> +}
> +
> +static int k3_j72xx_bandgap_resume(struct device *dev)
> +{
> +	struct k3_j72xx_bandgap *bgp = dev_get_drvdata(dev);
> +	int ret;
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		pm_runtime_disable(dev);
> +		return ret;
> +	}
> +
> +	k3_j72xx_bandgap_init_hw(bgp);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(k3_j72xx_bandgap_pm_ops,
> +				k3_j72xx_bandgap_suspend,
> +				k3_j72xx_bandgap_resume);
> +
>  static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
>  	.has_errata_i2128 = true,
>  };
> @@ -554,6 +598,7 @@ static struct platform_driver k3_j72xx_bandgap_sensor_driver = {
>  	.driver = {
>  		.name = "k3-j72xx-soc-thermal",
>  		.of_match_table	= of_k3_j72xx_bandgap_match,
> +		.pm = pm_sleep_ptr(&k3_j72xx_bandgap_pm_ops),
>  	},
>  };
>  
-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


