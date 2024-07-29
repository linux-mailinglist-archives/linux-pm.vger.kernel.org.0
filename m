Return-Path: <linux-pm+bounces-11614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3489401C5
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 01:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D96B21463
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15718F2DC;
	Mon, 29 Jul 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtSV3pmO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A518D4CA
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296356; cv=none; b=Mo7p8Lk7chVXFsFAy7zgDTWwRWhSS3+EiH1s5GXiEvAm1c9utLEBKHGaXCSg6Hno6FKSXpx99Oqo2Mxa3DrChjr8+bDuTLQgb4jUuwLBjYloq3v/dDxfJhahDRIIM7UxK3IQmKcC5B1JlvSwHHOCNKbYAsVf72JpkQAlqOQDdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296356; c=relaxed/simple;
	bh=Z/qYg5geWHFYXWacWooahW94iKZ3GqH4MYLN4CRPPsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMSOSbo+ci0sejiA3bSh1fAocjGENylLq0dsPJblt8JjtUuhPe3GyU/Y0jcX5MC2dKgdKSKLWgPUP5trFMDN4BahOSCE/UXbTFVJNvcCcWNzjsDyUkB9TBCO9J8taACRDTxA3IcyzW3om2h1gzszSiG/jGEG18Nj1CvLVntHmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AtSV3pmO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so47615061fa.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722296352; x=1722901152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ+5jJwz1GItlEJ4uF49j4Wqp0aV1o2OFMU19Rkln1A=;
        b=AtSV3pmODf7M74D07mlx53SkYXoBkf5dLUbZVAFCiHeqpygmI64afHhan+7LL2uDFm
         USjR3rTDSSXlxyJqpBvXrf4aP6c+DNURYEuDm9UKxKZ752ADgS+Cc4/r7onfQ/AU46iT
         kAXdKsVJ9qNbAx9ulmEY52gkbxMk+ayzQbHPnn7IvSAyf9q4VnxjfX8J/YrM0sSRXp4g
         4cm7biXTIYp7w03GVGzH/10YaptIsqbLF900KpjmyFKHWsA3FntSlNE7AZHIqbaZ6dNn
         jSwgWsGP6biccRRralVtG02dl3ZwcGmKjRB3E2gSRYHrVbPE4Rr8xYPpypCGrIRFj8tz
         RYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722296352; x=1722901152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ+5jJwz1GItlEJ4uF49j4Wqp0aV1o2OFMU19Rkln1A=;
        b=OFuz9Yr8HONsCaF5PFNO6f4wjGtZXEQCKM9KEUcBL9bZbyP+EPr7jIoUTFPWgjYWOf
         CzXxtHVy0v7uqmWt4dB5gxvrLXyTW8Empj7W/aH1erq7iipl5jrr8T9+6b/vvUg0itEh
         jbAp4ORVlETlqbeIGC/c8KkppuS5vthXxn/ZyBpQIJUcV7N9Vfs9JE7LP37OS9sScRsM
         qNyWuv1aRWLexouppgje6lzzinC/8DxqXKIijFzeN4ua9aKEoqPr5K0+MEDcxio//0cP
         YlJGg+RxTt1p4k85fKLnvU/QV30OeATJDJ5du0LJvYvRtFwAYLEJeDM2vI+iVZ8+KOXP
         uSZw==
X-Forwarded-Encrypted: i=1; AJvYcCUPYjY0Lwe7S/3Y+5IAId5Ou2v/44mjra7V0mHcs06+AZUIXC0578YdmVjfoGy9YVedPEIE5zEMSf6Q+WrlqYXOzbg/jypcZvE=
X-Gm-Message-State: AOJu0Yzg9q3/6qike+Rpegv+IHQ3Ni/m+o6Q9y6KMlsVRpHozeLuXlyZ
	79AJXQMmazrHZ7zy3UeMxz9kIw+ICKxgQHajm2uBrFDOvqGyk2KMQ5NnYgPMKvA=
X-Google-Smtp-Source: AGHT+IHm6u2V0FI1Cdg05g8yw1b7p4C0R/76aPnJv1xQaVOoP6+9stttZj3CqYqpdVkh8/zOf575qQ==
X-Received: by 2002:a2e:3a19:0:b0:2ee:4c2e:3d3b with SMTP id 38308e7fff4ca-2f12ee02fa2mr60204081fa.4.1722296351880;
        Mon, 29 Jul 2024 16:39:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf0f950sm14937121fa.23.2024.07.29.16.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 16:39:11 -0700 (PDT)
Date: Tue, 30 Jul 2024 02:39:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anjelique Melendez <quic_amelende@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	amitk@kernel.org, thara.gopinath@gmail.com, andersson@kernel.org, 
	quic_collinsd@quicinc.com, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] thermal: qcom-spmi-temp-alarm: add support for LITE
 PMIC peripherals
Message-ID: <ttswrupepg5yvxyzai2w7muam2rbpv6nh3y4klv6kd7jiztm7y@n3775q6qtaqt>
References: <20240729231259.2122976-1-quic_amelende@quicinc.com>
 <20240729231259.2122976-6-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729231259.2122976-6-quic_amelende@quicinc.com>

On Mon, Jul 29, 2024 at 04:12:59PM GMT, Anjelique Melendez wrote:
> Add support for TEMP_ALARM LITE PMIC peripherals.  This subtype
> utilizes a pair of registers to configure a warning interrupt
> threshold temperature and an automatic hardware shutdown
> threshold temperature.
> 
> Co-developed-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 208 +++++++++++++++++++-
>  1 file changed, 202 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index 1f56acd8f637..e50ce66ec096 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -22,21 +23,28 @@
>  #define QPNP_TM_REG_TYPE		0x04
>  #define QPNP_TM_REG_SUBTYPE		0x05
>  #define QPNP_TM_REG_STATUS		0x08
> +#define QPNP_TM_REG_IRQ_STATUS		0x10
>  #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
>  #define QPNP_TM_REG_ALARM_CTRL		0x46
>  /* TEMP_DAC_* registers are only present for TEMP_GEN2 v2.0 */
>  #define QPNP_TM_REG_TEMP_DAC_STG1	0x47
>  #define QPNP_TM_REG_TEMP_DAC_STG2	0x48
>  #define QPNP_TM_REG_TEMP_DAC_STG3	0x49
> +#define QPNP_TM_REG_LITE_TEMP_CFG1	0x50
> +#define QPNP_TM_REG_LITE_TEMP_CFG2	0x51
>  
>  #define QPNP_TM_TYPE			0x09
>  #define QPNP_TM_SUBTYPE_GEN1		0x08
>  #define QPNP_TM_SUBTYPE_GEN2		0x09
> +#define QPNP_TM_SUBTYPE_LITE		0xC0
>  
>  #define STATUS_GEN1_STAGE_MASK		GENMASK(1, 0)
>  #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
>  #define STATUS_GEN2_STATE_SHIFT		4
>  
> +/* IRQ status only needed for TEMP_ALARM_LITE */
> +#define IRQ_STATUS_MASK			BIT(0)
> +
>  #define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
>  #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
>  
> @@ -44,6 +52,8 @@
>  
>  #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
>  
> +#define LITE_TEMP_CFG_THRESHOLD_MASK	GENMASK(3, 2)
> +
>  #define THRESH_COUNT			4
>  #define STAGE_COUNT			3
>  
> @@ -88,6 +98,19 @@ static const long temp_dac_max[STAGE_COUNT] = {
>  	119375, 159375, 159375
>  };
>  
> +/*
> + * TEMP_ALARM_LITE has two stages: warning and shutdown with independently
> + * configured threshold temperatures.
> + */
> +
> +static const long temp_map_lite_warning[THRESH_COUNT] = {
> +	115000, 125000, 135000, 145000
> +};
> +
> +static const long temp_map_lite_shutdown[THRESH_COUNT] = {
> +	135000, 145000, 160000, 175000
> +};
> +
>  /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
>  #define DEFAULT_TEMP			37000
>  
> @@ -171,19 +194,26 @@ static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
>   * qpnp_tm_get_temp_stage() - return over-temperature stage
>   * @chip:		Pointer to the qpnp_tm chip
>   *
> - * Return: stage (GEN1) or state (GEN2) on success, or errno on failure.
> + * Return: stage (GEN1), state (GEN2), or alarm interrupt state (LITE) on
> + *	   success; or errno on failure.
>   */
>  static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
>  {
>  	int ret;
> +	u16 addr = QPNP_TM_REG_STATUS;
>  	u8 reg = 0;
>  
> -	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> +	if (chip->subtype == QPNP_TM_SUBTYPE_LITE)
> +		addr = QPNP_TM_REG_IRQ_STATUS;
> +
> +	ret = qpnp_tm_read(chip, addr, &reg);
>  	if (ret < 0)
>  		return ret;
>  
>  	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
>  		ret = reg & STATUS_GEN1_STAGE_MASK;
> +	else if (chip->subtype == QPNP_TM_SUBTYPE_LITE)
> +		ret = reg & IRQ_STATUS_MASK;
>  	else
>  		ret = (reg & STATUS_GEN2_STATE_MASK) >> STATUS_GEN2_STATE_SHIFT;
>  
> @@ -206,7 +236,8 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
>  		return ret;
>  	stage = ret;
>  
> -	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1) {
> +	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1
> +	    || chip->subtype == QPNP_TM_SUBTYPE_LITE) {
>  		stage_new = stage;
>  		stage_old = chip->stage;
>  	} else {
> @@ -289,6 +320,78 @@ static int qpnp_tm_gen2_rev2_set_temp_thresh(struct qpnp_tm_chip *chip, int trip
>  	return 0;
>  }
>  
> +static int qpnp_tm_lite_set_temp_thresh(struct qpnp_tm_chip *chip, int trip,
> +				       int temp)
> +{
> +	int ret, temp_cfg, i;
> +	const long *temp_map;
> +	u16 addr;
> +	u8 reg, thresh;
> +
> +	if (trip < 0 || trip >= STAGE_COUNT) {
> +		dev_err(chip->dev, "invalid TEMP_LITE trip = %d\n", trip);
> +		return -EINVAL;
> +	}
> +
> +	switch (trip) {
> +	case 0:
> +		temp_map = temp_map_lite_warning;
> +		addr = QPNP_TM_REG_LITE_TEMP_CFG1;
> +		break;
> +	case 1:
> +		/*
> +		 * The second trip point is purely in software to facilitate
> +		 * a controlled shutdown after the warning threshold is crossed
> +		 * but before the automatic hardware shutdown threshold is
> +		 * crossed.
> +		 */
> +		return 0;
> +	case 2:
> +		temp_map = temp_map_lite_shutdown;
> +		addr = QPNP_TM_REG_LITE_TEMP_CFG2;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (temp < temp_map[THRESH_MIN] || temp > temp_map[THRESH_MAX]) {
> +		dev_err(chip->dev, "invalid TEMP_LITE temp = %d\n", temp);
> +		return -EINVAL;
> +	}
> +
> +	thresh = 0;
> +	temp_cfg = temp_map[thresh];
> +	for (i = THRESH_MAX; i >= THRESH_MIN; i--) {
> +		if (temp >= temp_map[i]) {
> +			thresh = i;
> +			temp_cfg = temp_map[i];
> +			break;
> +		}
> +	}
> +
> +	if (temp_cfg == chip->temp_dac_map[trip])
> +		return 0;
> +
> +	ret = qpnp_tm_read(chip, addr, &reg);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "LITE_TEMP_CFG read failed, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	reg &= ~LITE_TEMP_CFG_THRESHOLD_MASK;
> +	reg |= FIELD_PREP(LITE_TEMP_CFG_THRESHOLD_MASK, thresh);
> +
> +	ret = qpnp_tm_write(chip, addr, reg);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "LITE_TEMP_CFG write failed, ret=%d\n", ret);
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
> @@ -374,6 +477,24 @@ static const struct thermal_zone_device_ops qpnp_tm_gen2_rev2_sensor_ops = {
>  	.set_trip_temp = qpnp_tm_gen2_rev2_set_trip_temp,
>  };
>  
> +static int qpnp_tm_lite_set_trip_temp(struct thermal_zone_device *tz,
> +					   int trip, int temp)
> +{
> +	struct qpnp_tm_chip *chip = tz->devdata;
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +	ret = qpnp_tm_lite_set_temp_thresh(chip, trip, temp);
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_device_ops qpnp_tm_lite_sensor_ops = {
> +	.get_temp = qpnp_tm_get_temp,
> +	.set_trip_temp = qpnp_tm_lite_set_trip_temp,
> +};
> +
>  static irqreturn_t qpnp_tm_isr(int irq, void *data)
>  {
>  	struct qpnp_tm_chip *chip = data;
> @@ -452,6 +573,68 @@ static int qpnp_tm_gen2_rev2_init(struct qpnp_tm_chip *chip)
>  	return 0;
>  }
>  
> +/* Configure TEMP_LITE registers based on DT thermal_zone trips */
> +static int qpnp_tm_lite_update_trip_temps(struct qpnp_tm_chip *chip)
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
> +		ret = qpnp_tm_lite_set_temp_thresh(chip, i, trip.temperature);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Verify that trips are strictly increasing. */

Again, this looks like artificial limitations.

> +	if (chip->temp_dac_map[2] <= chip->temp_dac_map[0]) {
> +		dev_err(chip->dev, "Threshold 2=%ld <= threshold 0=%ld\n",
> +			chip->temp_dac_map[2], chip->temp_dac_map[0]);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Read the hardware default TEMP_LITE stage threshold temperatures */
> +static int qpnp_tm_lite_init(struct qpnp_tm_chip *chip)
> +{
> +	int ret, thresh;
> +	u8 reg = 0;
> +
> +	/*
> +	 * Store the warning trip temp in temp_dac_map[0] and the shutdown trip
> +	 * temp in temp_dac_map[2].  The second trip point is purely in software
> +	 * to facilitate a controlled shutdown after the warning threshold is
> +	 * crossed but before the automatic hardware shutdown threshold is
> +	 * crossed.  Thus, there is no register to read for the second trip
> +	 * point.
> +	 */

What if the DT define 4 trip points? Or two?

> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG1, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
> +	chip->temp_dac_map[0] = temp_map_lite_warning[thresh];
> +
> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG2, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
> +	chip->temp_dac_map[2] = temp_map_lite_shutdown[thresh];
> +
> +	return 0;
> +}
> +
>  static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
>  	.ops = &qpnp_tm_sensor_ops,
>  	.has_temp_dac = false,
> @@ -466,6 +649,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
>  	.update_trip_temps = qpnp_tm_gen2_rev2_update_trip_temps,
>  };
>  
> +static const struct spmi_temp_alarm_data spmi_temp_alarm_lite_data = {
> +	.ops = &qpnp_tm_lite_sensor_ops,
> +	.has_temp_dac = true,
> +	.setup = qpnp_tm_lite_init,
> +	.update_trip_temps = qpnp_tm_lite_update_trip_temps,
> +};
> +
>  /*
>   * This function initializes the internal temp value based on only the
>   * current thermal stage and threshold. Setup threshold control and
> @@ -492,8 +682,9 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
>  		goto out;
>  	chip->stage = ret;
>  
> -	stage = (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
> -		? chip->stage : alarm_state_map[chip->stage];
> +	stage = (chip->subtype == QPNP_TM_SUBTYPE_GEN1
> +		 || chip->subtype == QPNP_TM_SUBTYPE_LITE)
> +			? chip->stage : alarm_state_map[chip->stage];

Even more play with revisions. Please replace this with match data.

>  
>  	if (stage)
>  		chip->temp = qpnp_tm_decode_temp(chip, stage);
> @@ -611,7 +802,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  	}
>  
>  	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
> -				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
> +				     && subtype != QPNP_TM_SUBTYPE_GEN2
> +				     && subtype != QPNP_TM_SUBTYPE_LITE)) {
>  		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
>  			type, subtype);
>  		return -ENODEV;
> @@ -662,6 +854,10 @@ static const struct of_device_id qpnp_tm_match_table[] = {
>  		.compatible = "qcom,spmi-temp-alarm-gen2-rev2",
>  		.data = &spmi_temp_alarm_gen2_rev2_data,
>  	},
> +	{
> +		.compatible = "qcom,spmi-temp-alarm-lite",
> +		.data = &spmi_temp_alarm_lite_data,
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

