Return-Path: <linux-pm+bounces-11613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92E19401BD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 01:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D50B20A15
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 23:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350ED18EFC6;
	Mon, 29 Jul 2024 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMfEcFak"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D67E1
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296194; cv=none; b=cTJpXiPXoqM7Za5BFeIsOMCYXEvVKtFwhDksZtIM/NQWYhi2y0QW8c7VjifPaRAYiBnPeGYh3Tgt0WacMdSeyQSZa3XQKL1vTD1oXt7c1NrymDkkdlpglQrX5BK5xn6pH3yyQXZNa2kM0tXPQMjZhq4gTdTeGNDc5HGfChhwg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296194; c=relaxed/simple;
	bh=p6r8SDH35lnxs835Er5sKqnfimxogyd5FdiD6CH3RVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI0/kkCRj6zlNLB2kC4C99IHrY8U9Uqb7HC6u8mAFVUaD2BFYCdKJ61xvZenj3GGnp2rnk+GsOIjCWDiMPsP2gNQ+gLQvzAt1eff7R9D/2biqg+3bPcu6Bo3p4S3EZlPRFt6GAjRphUCZ9M2crBUby9NStr+U9Cp13FL6QR75Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMfEcFak; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efbb55d24so5888865e87.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 16:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722296190; x=1722900990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcvl82LB092Tjqk3oiMh8TxYXHmA+g3xZAbts2M6cts=;
        b=aMfEcFakP5FbJzpy24BJmvx9vQx+CEpb9VOteKeWC7k1udWuAtW8raLz+d0UwkL4hz
         SEtOBx727VjzIEp5lc4wMQiJHYn6YweTWFJYXw+fAuPONbzmfJfXT5ghYNbPgEJCWTVE
         Q2eBEQ4Laf4NZG4TKFr0T7B91kfIkQ2qXxIvQnQHiNHJhOED6ztD7TpX9AEmcX4kEU+S
         4uzE7LmOdShWGcSdrZRfXTR5OJPHH8pyMaswKB7vKcv2ricYlamtyxyilK6hc6NevBd7
         rK45/wtlryaznZwsmRo62kx8BIQpxzcFnQClLWn8H/D+md78wDmTj62ZWCdz4mCj2Xe9
         pMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722296190; x=1722900990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcvl82LB092Tjqk3oiMh8TxYXHmA+g3xZAbts2M6cts=;
        b=d1ro/rJD2L2/GTQeJ5+vdhSv4Bv506bhXpQaY0en3XmI1y7lPJqof9IzJUDa3dpgj6
         iYVThQYr9SCbu5nDe8jRFhkSDw0Zhjo4Waz6jQUavj9KNRvtNn6vyQ/7whFCcFH1C0La
         u4F0A61YZ7ynYzdNo1WlKRZfcQDoGczPZLg1ddv+t9D97y8uVtCwr3GecE+FuGjttDoB
         DUmFBqcvEcggoT2OkSGuwTq/jicb5DAybEnvog2sRizkUNZ7SE1/LMXA5XcECTE/4PJu
         7ZmU/XM/71O7HNlnMRg8QFBBASQQ/5rlITxwv2VhMgvslrjUFH8sisP4zfu9nRQYr+ZT
         JWKw==
X-Forwarded-Encrypted: i=1; AJvYcCUY/dc5vAXIxt8tiXqXxcJUiytSiYDiiXbQty9Y2RFrUyTSSkk+RWN+0LtAUUVgq+OZV7k75n78LGbcWTsPmclVYcDMuyiCq4w=
X-Gm-Message-State: AOJu0YygfsD8tSlz89VSe2ADN6oLetONBDbKU04TRs9tD40SJ0H25F7G
	xzcokgcCszdQ6r10Nl1STyCQ5Kq0UgVUW/JNMoyGZDAjuIkWc9uVtyTILMDiEHA=
X-Google-Smtp-Source: AGHT+IEFRgCWVcl1eXgl2GfzpGn7qgrksZApopvJuD2vkH9gybsjIsLCuzcFJv2kvctMibMwCZ+5vw==
X-Received: by 2002:ac2:5a01:0:b0:52c:df8e:a367 with SMTP id 2adb3069b0e04-5309b2d8497mr7095928e87.53.1722296189821;
        Mon, 29 Jul 2024 16:36:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd0a4bsm1662287e87.68.2024.07.29.16.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 16:36:29 -0700 (PDT)
Date: Tue, 30 Jul 2024 02:36:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anjelique Melendez <quic_amelende@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	amitk@kernel.org, thara.gopinath@gmail.com, andersson@kernel.org, 
	quic_collinsd@quicinc.com, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] thermal: qcom-spmi-temp-alarm: add support for GEN2
 rev 2 PMIC peripherals
Message-ID: <pzu2ijzkofzxpehpc4yphj5567ijdrxngqrepaq54njdagjenh@3vxmezjoepqg>
References: <20240729231259.2122976-1-quic_amelende@quicinc.com>
 <20240729231259.2122976-5-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729231259.2122976-5-quic_amelende@quicinc.com>

On Mon, Jul 29, 2024 at 04:12:58PM GMT, Anjelique Melendez wrote:
> Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
> revision 2.  This revision utilizes individual temp DAC registers
> to set the threshold temperature for over-temperature stages 1,
> 2, and 3 instead of a single register to specify a set of
> thresholds.
> 
> Co-developed-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 195 ++++++++++++++++++--
>  1 file changed, 184 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index de4a2d99f0d5..1f56acd8f637 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -24,6 +24,10 @@
>  #define QPNP_TM_REG_STATUS		0x08
>  #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
>  #define QPNP_TM_REG_ALARM_CTRL		0x46
> +/* TEMP_DAC_* registers are only present for TEMP_GEN2 v2.0 */
> +#define QPNP_TM_REG_TEMP_DAC_STG1	0x47
> +#define QPNP_TM_REG_TEMP_DAC_STG2	0x48
> +#define QPNP_TM_REG_TEMP_DAC_STG3	0x49
>  
>  #define QPNP_TM_TYPE			0x09
>  #define QPNP_TM_SUBTYPE_GEN1		0x08
> @@ -65,13 +69,42 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
>  
>  #define TEMP_STAGE_HYSTERESIS		2000
>  
> +/*
> + * For TEMP_GEN2 v2.0, TEMP_DAC_STG1/2/3 registers are used to set the threshold
> + * for each stage independently.
> + * TEMP_DAC_STG* = 0 --> 80 C
> + * Each 8 step increase in TEMP_DAC_STG* value corresponds to 5 C (5000 mC).
> + */
> +#define TEMP_DAC_MIN			80000
> +#define TEMP_DAC_SCALE_NUM		8
> +#define TEMP_DAC_SCALE_DEN		5000
> +
> +#define TEMP_DAC_TEMP_TO_REG(temp) \
> +	(((temp) - TEMP_DAC_MIN) * TEMP_DAC_SCALE_NUM / TEMP_DAC_SCALE_DEN)
> +#define TEMP_DAC_REG_TO_TEMP(reg) \
> +	(TEMP_DAC_MIN + (reg) * TEMP_DAC_SCALE_DEN / TEMP_DAC_SCALE_NUM)
> +
> +static const long temp_dac_max[STAGE_COUNT] = {
> +	119375, 159375, 159375
> +};
> +
>  /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
>  #define DEFAULT_TEMP			37000
>  
> +struct qpnp_tm_chip;
> +
> +struct spmi_temp_alarm_data {
> +	const struct thermal_zone_device_ops *ops;
> +	bool				has_temp_dac;
> +	int (*setup)(struct qpnp_tm_chip *chip);
> +	int (*update_trip_temps)(struct qpnp_tm_chip *chip);
> +};
> +
>  struct qpnp_tm_chip {
>  	struct regmap			*map;
>  	struct device			*dev;
>  	struct thermal_zone_device	*tz_dev;
> +	const struct spmi_temp_alarm_data *data;
>  	unsigned int			subtype;
>  	unsigned int			dig_revision;
>  	long				temp;
> @@ -85,6 +118,8 @@ struct qpnp_tm_chip {
>  
>  	struct iio_channel		*adc;
>  	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
> +
> +	long				temp_dac_map[STAGE_COUNT];
>  };
>  
>  /* This array maps from GEN2 alarm state to GEN1 alarm stage */
> @@ -118,6 +153,13 @@ static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
>   */
>  static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
>  {
> +	if (chip->data->has_temp_dac) {
> +		if (stage == 0 || stage > STAGE_COUNT)
> +			return 0;
> +
> +		return chip->temp_dac_map[stage - 1];
> +	}
> +
>  	if (!chip->temp_map || chip->thresh >= THRESH_COUNT || stage == 0 ||
>  	    stage > STAGE_COUNT)
>  		return 0;
> @@ -219,6 +261,34 @@ static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
>  	return 0;
>  }
>  
> +static int qpnp_tm_gen2_rev2_set_temp_thresh(struct qpnp_tm_chip *chip, int trip,
> +				       int temp)
> +{
> +	int ret, temp_cfg;
> +	u8 reg;
> +
> +	if (trip < 0 || trip >= STAGE_COUNT) {
> +		dev_err(chip->dev, "invalid TEMP_DAC trip = %d\n", trip);
> +		return -EINVAL;
> +	} else if (temp < TEMP_DAC_MIN || temp > temp_dac_max[trip]) {
> +		dev_err(chip->dev, "invalid TEMP_DAC temp = %d\n", temp);
> +		return -EINVAL;
> +	}
> +
> +	reg = TEMP_DAC_TEMP_TO_REG(temp);
> +	temp_cfg = TEMP_DAC_REG_TO_TEMP(reg);
> +
> +	ret = qpnp_tm_write(chip, QPNP_TM_REG_TEMP_DAC_STG1 + trip, reg);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "TEMP_DAC_STG write failed, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	chip->temp_dac_map[trip] = temp_cfg;
> +
> +	return 0;
> +}
> +
>  static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
>  					     int temp)
>  {
> @@ -286,6 +356,24 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
>  	.set_trip_temp = qpnp_tm_set_trip_temp,
>  };
>  
> +static int qpnp_tm_gen2_rev2_set_trip_temp(struct thermal_zone_device *tz,
> +					  int trip, int temp)
> +{
> +	struct qpnp_tm_chip *chip = tz->devdata;
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, trip, temp);
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
> +	.get_temp = qpnp_tm_get_temp,
> +	.set_trip_temp = qpnp_tm_gen2_rev2_set_trip_temp,
> +};
> +
>  static irqreturn_t qpnp_tm_isr(int irq, void *data)
>  {
>  	struct qpnp_tm_chip *chip = data;
> @@ -313,6 +401,71 @@ static int qpnp_tm_get_critical_trip_temp(struct qpnp_tm_chip *chip)
>  	return THERMAL_TEMP_INVALID;
>  }
>  
> +/* Configure TEMP_DAC registers based on DT thermal_zone trips */
> +static int qpnp_tm_gen2_rev2_update_trip_temps(struct qpnp_tm_chip *chip)
> +{
> +	struct thermal_trip trip = {0};
> +	int ret, ntrips, i;
> +
> +	ntrips = thermal_zone_get_num_trips(chip->tz_dev);
> +	/* Keep hardware defaults if no DT trips are defined. */
> +	if (ntrips <= 0)
> +		return 0;
> +
> +	for (i = 0; i < ntrips; i++) {
> +		ret = thermal_zone_get_trip(chip->tz_dev, i, &trip);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, i, trip.temperature);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Verify that trips are strictly increasing. */

There is no such requirement in the DT bindings. Please don't invent
artificial restrictions, especially if they are undocumented.

> +	for (i = 1; i < STAGE_COUNT; i++) {
> +		if (chip->temp_dac_map[i] <= chip->temp_dac_map[i - 1]) {
> +			dev_err(chip->dev, "Threshold %d=%ld <= threshold %d=%ld\n",
> +				i, chip->temp_dac_map[i], i - 1,
> +				chip->temp_dac_map[i - 1]);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* Read the hardware default TEMP_DAC stage threshold temperatures */
> +static int qpnp_tm_gen2_rev2_init(struct qpnp_tm_chip *chip)
> +{
> +	int ret, i;
> +	u8 reg = 0;
> +
> +	for (i = 0; i < STAGE_COUNT; i++) {
> +		ret = qpnp_tm_read(chip, QPNP_TM_REG_TEMP_DAC_STG1 + i, &reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		chip->temp_dac_map[i] = TEMP_DAC_REG_TO_TEMP(reg);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
> +	.ops = &qpnp_tm_sensor_ops,
> +	.has_temp_dac = false,
> +	.setup = NULL,
> +	.update_trip_temps = NULL,

No need to init to NULL, that's the default (and false too).

> +};
> +
> +static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
> +	.ops = &qpnp_tm_gen2_rev2_sensor_ops,
> +	.has_temp_dac = true,
> +	.setup = qpnp_tm_gen2_rev2_init,
> +	.update_trip_temps = qpnp_tm_gen2_rev2_update_trip_temps,
> +};
> +
>  /*
>   * This function initializes the internal temp value based on only the
>   * current thermal stage and threshold. Setup threshold control and
> @@ -339,21 +492,27 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
>  		goto out;
>  	chip->stage = ret;
>  
> -	stage = chip->subtype == QPNP_TM_SUBTYPE_GEN1
> +	stage = (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
>  		? chip->stage : alarm_state_map[chip->stage];
>  
>  	if (stage)
>  		chip->temp = qpnp_tm_decode_temp(chip, stage);
>  
> -	mutex_unlock(&chip->lock);
> +	if (chip->data->update_trip_temps) {
> +		ret = chip->data->update_trip_temps(chip);
> +		if (ret < 0)
> +			goto out;
> +	} else {
> +		mutex_unlock(&chip->lock);
>  
> -	crit_temp = qpnp_tm_get_critical_trip_temp(chip);
> +		crit_temp = qpnp_tm_get_critical_trip_temp(chip);
>  
> -	mutex_lock(&chip->lock);
> +		mutex_lock(&chip->lock);
>  
> -	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
> -	if (ret < 0)
> -		goto out;
> +		ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
> +		if (ret < 0)
> +			goto out;

Can you move this to the update_trip_temps() callback? Then there is no
need to have ifs here.

> +	}
>  
>  	/* Enable the thermal alarm PMIC module in always-on mode. */
>  	reg = ALARM_CTRL_FORCE_ENABLE;
> @@ -380,6 +539,10 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  	if (!chip)
>  		return -ENOMEM;
>  
> +	chip->data = of_device_get_match_data(&pdev->dev);
> +	if (!chip->data)
> +		return -EINVAL;
> +
>  	dev_set_drvdata(&pdev->dev, chip);
>  	chip->dev = &pdev->dev;
>  
> @@ -455,18 +618,21 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  	}
>  
>  	chip->subtype = subtype;
> -	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
> +	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major == 1)
>  		chip->temp_map = &temp_map_gen2_v1;
> -	else
> +	else if (subtype == QPNP_TM_SUBTYPE_GEN1)
>  		chip->temp_map = &temp_map_gen1;

If you already have per-compatible match data, why do you need to have
check revisions? Please be consistent.

>  
> +	if (chip->data->setup)
> +		chip->data->setup(chip);
> +
>  	/*
>  	 * Register the sensor before initializing the hardware to be able to
>  	 * read the trip points. get_temp() returns the default temperature
>  	 * before the hardware initialization is completed.
>  	 */
>  	chip->tz_dev = devm_thermal_of_zone_register(
> -		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
> +		&pdev->dev, 0, chip, chip->data->ops);
>  	if (IS_ERR(chip->tz_dev))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(chip->tz_dev),
>  				     "failed to register sensor\n");
> @@ -488,7 +654,14 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qpnp_tm_match_table[] = {
> -	{ .compatible = "qcom,spmi-temp-alarm" },
> +	{
> +		.compatible = "qcom,spmi-temp-alarm",
> +		.data = &spmi_temp_alarm_data,
> +	},
> +	{
> +		.compatible = "qcom,spmi-temp-alarm-gen2-rev2",
> +		.data = &spmi_temp_alarm_gen2_rev2_data,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qpnp_tm_match_table);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

