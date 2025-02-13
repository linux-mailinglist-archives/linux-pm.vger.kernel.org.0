Return-Path: <linux-pm+bounces-22047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473F1A350EA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 23:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BF516CE61
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417DF269815;
	Thu, 13 Feb 2025 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXUA2vlV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E701714B7
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484388; cv=none; b=tRwqFgeb5PYC2WbOigBvnTQUIJz3vw4keUEakyFIWMbxXFprkwedhh8cjSBEatVbSgQ30iQyekpsgqRBO7uAOzJlpLNBy9KR2kCgKNXRy+/TM7ZHSOsuwNq9kvAnN/6tSFB6UCGCrL/yKsKMnxbrbttg9qyqD825WG/L/d+nY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484388; c=relaxed/simple;
	bh=QgWauNEM6UChiF2hW2FQsCjcZMFqp8dWkRmKJhmndjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7zsebUR0qDRadhDn9BMJc4HJwTbzt4mL1STk1B7U/QNL8MvcLXEgyF0sUDmomk3U/RzcYsUgsIJaSGdLPZC9JnR2kU+x7mBUUzZ+QuuGKOJyf5CKOgJbk6tQX/njnEliwHomx/Ez0E1kAi3OfI1GYkYdOFsYnVF4Og3JQPBmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iXUA2vlV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-308e9ff235bso12165611fa.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 14:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739484383; x=1740089183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0qlRazb6ocQz7umyRulN57yH+ZOew3i+7PgD6ClWrb4=;
        b=iXUA2vlVRNLQaNU5W7fYRG1X0wQovV1jb8ZnqNKacXPIbhINllHtmsBYhb7sJXT2lj
         8qB0TzEiE92rRE5QZN3g16b+qiSqD8X0oOqOChtKbPqJDjz2oP9+zpGWeenE2iB6Ua8T
         ZW7lueI8LT2F4p6Cw/C1efSs0amr0wbE1Iw5t1hrfdMrksmGHvsq8oy7N9+52AUuggYF
         wbctdIR7++sm06LMKpNXVjF9dI2CW8K2agjr9WdvYrjJPKuxtni6v3oMQnGtCRIRj9fP
         edRzeMIZ7o7tjEYwHBbZTIYoV0nLL5q7AD+CCkGyeZs5q1gtuKS2XiChzANdn6JsZxzV
         qu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484383; x=1740089183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qlRazb6ocQz7umyRulN57yH+ZOew3i+7PgD6ClWrb4=;
        b=gb6PJjgqY8DCowMKJPcYtIzWDool8m5vRDx+zy1zuADM7jpIGm3Oj2nfSUP51OeUjh
         g/sDbFjL19axGbdi/Ur6va69wJK1JxB1jp3syTwEah7u/Gp714QkGlS/zy03BDU+3uNH
         jI7KIm1wC4OJhr/zl83EyKul+kZA+eY0lNK2XW+xyzJCp1NkL77s2EJWWaj6vNx5CzgQ
         9ZwhjLSvrWnq6qkHC8xtVI/StIENi5ggTB2IcBaTgFWYUVOhKToTsWRj1Vq2aOJQ/TnC
         o7eR6ihXI12o+vbXZiDhcRqcqPcBPOoHXr/v7BJt76NfSPsSvwjB5S/0GOa05xFIEYAA
         +OTg==
X-Forwarded-Encrypted: i=1; AJvYcCU5bjaP4RdbxZT2tuVfGa/fpSxzIyD7NWlD35Hj0WV3XlPnz/udUeRC7riDmoPAXSugNA/F7lr2Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPg1wRGcHINger2k/Cej/xBplinKhYZYg4zEdHaPzdNmxtUtQ
	xcXT2cOTxtcNqA1V54cwQVbz0ND7w6NoYKBUjhOaAq6tf62XjK1Mbj2v8c2L41o=
X-Gm-Gg: ASbGncu32Wxte8n/0ATCI1kTRel+Jx2PgL01E5JIQwsEf8kS8rswJ75ynmI/ciAxCMY
	xl6PRyPLdAFtpamGNmGSoRbPW4myIQiHplR1cQcZ8mBx9AiLRv9zMoVYtDQd8+fRR4N9PrgSejt
	/cWuJRLwI7nDeyV8BgHuwSa8PzQ9GBSPEt1PN/DEhebuQrn0swmLfnIb0wnWoI/Zi4uj0Vo3wAt
	o9hezHZA7SyKwq2HwMbHklZonE7zaRJ5WGtgLVVF5o09ODSCvKD/RVwhJaqXt1113pq/H/8MYWj
	TeoavZF/tHA1wUbPMNHdFlAOWBo1kOXta/iKDnaj1Waj48hfdkRjX0bBL6GWhcF+xGDf5qQ=
X-Google-Smtp-Source: AGHT+IGFdAPX0TuKH51GN0WgXQlA1GYV+eaaYHnYbmvkLSzL2/W7gj+s0MWz0QbrQTXEEAgNOhW9Gw==
X-Received: by 2002:a2e:bc16:0:b0:300:2a29:d47c with SMTP id 38308e7fff4ca-309036d731bmr35324221fa.24.1739484382886;
        Thu, 13 Feb 2025 14:06:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30910276839sm3248521fa.87.2025.02.13.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:06:21 -0800 (PST)
Date: Fri, 14 Feb 2025 00:06:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	david.collins@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] thermal: qcom-spmi-temp-alarm: add support for GEN2
 rev 2 PMIC peripherals
Message-ID: <3cwfckzxe32amd24b2mv72vuo63kra52dcjqksm4hux3vm3ckr@ym2ieq7w2ssq>
References: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
 <20250213210403.3396392-4-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213210403.3396392-4-anjelique.melendez@oss.qualcomm.com>

On Thu, Feb 13, 2025 at 01:04:02PM -0800, Anjelique Melendez wrote:
> Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
> revision 2.  This revision utilizes individual temp DAC registers
> to set the threshold temperature for over-temperature stages 1,
> 2, and 3 instead of a single register to specify a set of
> thresholds.
> 
> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 136 ++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index af71d4238340..a10f368f2039 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -25,6 +25,11 @@
>  #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
>  #define QPNP_TM_REG_ALARM_CTRL		0x46
>  
> +/* TEMP_DAC_STGx registers are only present for TEMP_GEN2 v2.0 */
> +#define QPNP_TM_REG_TEMP_DAC_STG1	0x47
> +#define QPNP_TM_REG_TEMP_DAC_STG2	0x48
> +#define QPNP_TM_REG_TEMP_DAC_STG3	0x49
> +
>  #define QPNP_TM_TYPE			0x09
>  #define QPNP_TM_SUBTYPE_GEN1		0x08
>  #define QPNP_TM_SUBTYPE_GEN2		0x09
> @@ -64,6 +69,25 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
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
> @@ -72,6 +96,7 @@ struct qpnp_tm_chip;
>  struct spmi_temp_alarm_data {
>  	const struct thermal_zone_device_ops *ops;
>  	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
> +	int (*setup)(struct qpnp_tm_chip *chip);
>  	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
>  	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
>  };
> @@ -87,6 +112,7 @@ struct qpnp_tm_chip {
>  	unsigned int			thresh;
>  	unsigned int			stage;
>  	unsigned int			base;
> +	unsigned int			ntrips;
>  	/* protects .thresh, .stage and chip registers */
>  	struct mutex			lock;
>  	bool				initialized;
> @@ -304,6 +330,52 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
>  	.set_trip_temp = qpnp_tm_set_trip_temp,
>  };
>  
> +static int qpnp_tm_gen2_rev2_set_temp_thresh(struct qpnp_tm_chip *chip, int trip, int temp)
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
> +	chip->temp_thresh_map[trip] = temp_cfg;
> +
> +	return 0;
> +}
> +
> +static int qpnp_tm_gen2_rev2_set_trip_temp(struct thermal_zone_device *tz,
> +					   const struct thermal_trip *trip, int temp)
> +{
> +	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
> +	struct qpnp_tm_chip *chip = thermal_zone_device_priv(tz);
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, trip_index, temp);
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
> @@ -328,6 +400,58 @@ static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
>  	return qpnp_tm_update_critical_trip_temp(chip, crit_temp);
>  }
>  
> +/* Configure TEMP_DAC registers based on DT thermal_zone trips */
> +static int qpnp_tm_gen2_rev2_configure_trip_temps_cb(struct thermal_trip *trip, void *data)
> +{
> +	struct qpnp_tm_chip *chip = data;
> +	int ret;
> +
> +	trip->priv = THERMAL_INT_TO_TRIP_PRIV(chip->ntrips);
> +	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, chip->ntrips, trip->temperature);
> +	chip->ntrips++;
> +
> +	return ret;
> +}
> +
> +static int qpnp_tm_gen2_rev2_configure_trip_temps(struct qpnp_tm_chip *chip)
> +{
> +	int ret, i;
> +
> +	ret = thermal_zone_for_each_trip(chip->tz_dev,
> +					 qpnp_tm_gen2_rev2_configure_trip_temps_cb, chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Verify that trips are strictly increasing. */
> +	for (i = 1; i < STAGE_COUNT; i++) {
> +		if (chip->temp_thresh_map[i] <= chip->temp_thresh_map[i - 1]) {
> +			dev_err(chip->dev, "Threshold %d=%ld <= threshold %d=%ld\n",
> +				i, chip->temp_thresh_map[i], i - 1,
> +				chip->temp_thresh_map[i - 1]);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* Read the hardware default TEMP_DAC stage threshold temperatures */
> +static int qpnp_tm_gen2_rev2_init(struct qpnp_tm_chip *chip)

qpnp_tm_gen2_rev2_setup() (or rename the field to .init)

> +{
> +	int ret, i;
> +	u8 reg = 0;
> +
> +	for (i = 0; i < STAGE_COUNT; i++) {
> +		ret = qpnp_tm_read(chip, QPNP_TM_REG_TEMP_DAC_STG1 + i, &reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		chip->temp_thresh_map[i] = TEMP_DAC_REG_TO_TEMP(reg);
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
>  	.ops = &qpnp_tm_sensor_ops,
>  	.temp_map = &temp_map_gen1,
> @@ -349,6 +473,13 @@ static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
>  	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
>  };
>  
> +static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev2_data = {
> +	.ops = &qpnp_tm_gen2_rev2_sensor_ops,
> +	.setup = qpnp_tm_gen2_rev2_init,
> +	.configure_trip_temps = qpnp_tm_gen2_rev2_configure_trip_temps,
> +	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
> +};
> +
>  /*
>   * This function initializes the internal temp value based on only the
>   * current thermal stage and threshold. Setup threshold control and
> @@ -484,6 +615,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  
>  	if (subtype == QPNP_TM_SUBTYPE_GEN1)
>  		chip->data = &spmi_temp_alarm_data;
> +	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 2)
> +		chip->data = &spmi_temp_alarm_gen2_rev2_data;
>  	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
>  		chip->data = &spmi_temp_alarm_gen2_rev1_data;
>  	else if (subtype == QPNP_TM_SUBTYPE_GEN2)
> @@ -491,6 +624,9 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  	else
>  		return -ENODEV;
>  
> +	if (chip->data->setup)
> +		chip->data->setup(chip);
> +
>  	/*
>  	 * Register the sensor before initializing the hardware to be able to
>  	 * read the trip points. get_temp() returns the default temperature
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

