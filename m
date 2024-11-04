Return-Path: <linux-pm+bounces-17004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B999BBE2C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 20:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FDF1F229E4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5781CCB23;
	Mon,  4 Nov 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCcTqf8N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC11CBA1A
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749329; cv=none; b=k/Xtt+InlJxslNW4epgsrlsAS4f0RHVeuMGkOrdwnLqAQPPOutNyPtarigmojkBbklAe/I5SkLoRLIMrTUbeFv4MdSGGah+KTCY2nCRgTvMoBhCl3w+w57GIeIVL0tlh3cOJmxtAAM+tuHdFRSVs2YsI+tDtoh5kz3fZ8rs84Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749329; c=relaxed/simple;
	bh=5Y74et1ql/8Jw8zTv0qiN7DDf0eF2dkOTvJIWRRbC5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3qAFO0vROfCbVO+1DApGvu9OmrZ/2OTx/TOLI1NM8AkdYQo5yy9MtTaQiAQ/Y/viGP7j1FmGiEeCQ2ZPNCshKi+MEcMPHbdlfThA/XMJdfDpG+brXqvprAEwKUmI4RUWOIfolv2FPl4DMCvYt+xaXcGYJvAXhBQpsk83Jlu3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tCcTqf8N; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so4428846e87.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 11:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730749325; x=1731354125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=da8kP4Y0Tj3RdilEo6nWy9ivPeJ/O0CrXWCrXlrxn/g=;
        b=tCcTqf8NvPdiYC+Kug7QmsOPD5sB4cpXC9KkNJRgzCYAzoY5xgWu2UndcZjCIKc5Ht
         E7c8RhtFH74MAEmmyq7TIFYHcPgo/ZVmBgAtSKREwqM/0MQX+lM7AFkG66NebTzM6rdE
         Vo5IXluth0zwEcQTCf/nDOdCt+4obfNRzYIrEvOggDFZbYT/RI+rECRJ9ipABWEV2Kt+
         ZN9Qj9giuTnC69vUxnY9G/tZEhfjeRww30/dUeTmyjYlisrEPBs/BJTg4Ra+Hhry/+/h
         eLePPgudjKzqfUF4UoM3VuG7bwtISLNjkt9Fbh3G+4qTBIxRZeNyU4zBK8rrWk7anZ80
         IdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730749325; x=1731354125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da8kP4Y0Tj3RdilEo6nWy9ivPeJ/O0CrXWCrXlrxn/g=;
        b=ofvuubP1n+eov9uWY3yw5XLtxpxQriUMgr6kHnse9dyhi55yMeKcscopCMkFyTckPj
         lUVUR+oJrK1/z7Vu1pulSH3/HSN3bKXjjG40TJJNHokKqXttkJ/b90V0yRijLU3D4Rqx
         czEH/Spg1DPU4oHn1hyI6swmNZIilwTcApFXBqygdbzQzF/CIgw48t0h6nzT3CB1z5UZ
         tJmLho0uAF91uPailggLCkdW4r4RFD2F7G6FLfPFzBjDhDEQazR88XvbxlRfF2W1fufH
         +4j1FJF9RGK9GeoSH084F5GD9N1xDu2UQm9KO038Pp17BbTRw/au1RpCFkohjTxNzvw8
         7hMg==
X-Forwarded-Encrypted: i=1; AJvYcCVNSblJ7DF2bBvcz1hvyhLGPBMhRLAmNE0LYTT5es+gI0Ab2YfRg2frIUtYldTEecDBDU+CsZyZ4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMl3ZmPuyH3yCum4tClpudb70KWxoTman9/GBhW3trR2dP4ERh
	C97HErseKjY7lc98UWgKSw6JZUHg5fsov9cIqmIHjPvEo9yofztx92eW89vIl4A=
X-Google-Smtp-Source: AGHT+IGWkrh3QWlpix1oTb5fNB8D/4Bz4upHqzeRKocnDS2P6lmceeDXoRHO8iPRtNOSPUL2TG3uRg==
X-Received: by 2002:a05:6512:ad6:b0:539:fb6f:cb8d with SMTP id 2adb3069b0e04-53b348e1452mr17059499e87.27.1730749324729;
        Mon, 04 Nov 2024 11:42:04 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce3cesm1846277e87.178.2024.11.04.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:42:02 -0800 (PST)
Date: Mon, 4 Nov 2024 21:42:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH v6 3/7] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
Message-ID: <ni4y5yf5uymum4rinlr35tnko6bgxscmchw236h2c7dxxojxci@upzwx4xvh2st>
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-4-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104124413.2012794-4-quic_mmanikan@quicinc.com>

On Mon, Nov 04, 2024 at 06:14:09PM +0530, Manikanta Mylavarapu wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> SoCs without RPM need to enable sensors and calibrate them from the kernel.
> The IPQ5332 and IPQ5424 use the tsens v2.3.3 IP and do not have RPM.
> Therefore, add a new calibration function for V2, as the tsens.c calib
> function only supports V1. Also add new feature_config, ops and data for
> IPQ5332, IPQ5424.
> 
> Although the TSENS IP supports 16 sensors, not all are used. The hw_id
> is used to enable the relevant sensors.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V6:
> 	- Add IPQ5424 support
> 	- Patch #1 and Patch #5 from V5 have been merged and
> 	  incorporated into Patch #3 in V6 to resolve below
> 	  compilation warnings.
> drivers/thermal/qcom/tsens-v2.c:216:19: warning: ‘init_tsens_v2_no_rpm’
> defined but not used [-Wunused-function]
>  static int __init init_tsens_v2_no_rpm(struct tsens_priv *priv)
> drivers/thermal/qcom/tsens-v2.c:180:12: warning: ‘tsens_v2_calibration’
> defined but not used [-Wunused-function]
>  static int tsens_v2_calibration(struct tsens_priv *priv)
> 
>  drivers/thermal/qcom/tsens-v2.c | 182 ++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    |   8 +-
>  drivers/thermal/qcom/tsens.h    |   4 +-
>  3 files changed, 192 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 0cb7301eca6e..90b6915607ea 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -4,13 +4,32 @@
>   * Copyright (c) 2018, Linaro Limited
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/regmap.h>
> +#include <linux/nvmem-consumer.h>
>  #include "tsens.h"
>  
>  /* ----- SROT ------ */
>  #define SROT_HW_VER_OFF	0x0000
>  #define SROT_CTRL_OFF		0x0004
> +#define SROT_MEASURE_PERIOD	0x0008
> +#define SROT_Sn_CONVERSION	0x0060
> +#define V2_SHIFT_DEFAULT	0x0003
> +#define V2_SLOPE_DEFAULT	0x0cd0
> +#define V2_CZERO_DEFAULT	0x016a
> +#define ONE_PT_SLOPE		0x0cd0
> +#define TWO_PT_SHIFTED_GAIN	921600
> +#define ONE_PT_CZERO_CONST	94
> +#define SW_RST_DEASSERT		0x0
> +#define SW_RST_ASSERT		0x1
> +#define MEASURE_PERIOD_2mSEC	0x1
> +#define RSEULT_FORMAT_TEMP	0x1
> +#define TSENS_ENABLE		0x1
> +#define SENSOR_CONVERSION(n)	(((n) * 4) + SROT_Sn_CONVERSION)
> +#define CONVERSION_SHIFT_MASK	GENMASK(24, 23)
> +#define CONVERSION_SLOPE_MASK	GENMASK(22, 10)
> +#define CONVERSION_CZERO_MASK	GENMASK(9, 0)
>  
>  /* ----- TM ------ */
>  #define TM_INT_EN_OFF			0x0004
> @@ -50,6 +69,17 @@ static struct tsens_features ipq8074_feat = {
>  	.trip_max_temp	= 204000,
>  };
>  
> +static struct tsens_features ipq5332_feat = {
> +	.ver_major	= VER_2_X_NO_RPM,
> +	.crit_int	= 1,
> +	.combo_int	= 1,
> +	.adc		= 0,
> +	.srot_split	= 1,
> +	.max_sensors	= 16,
> +	.trip_min_temp	= 0,
> +	.trip_max_temp	= 204000,
> +};
> +
>  static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	/* ----- SROT ------ */
>  	/* VERSION */
> @@ -59,6 +89,11 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	/* CTRL_OFF */
>  	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
>  	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
> +	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
> +	[CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
> +
> +	/* MAIN_MEASURE_PERIOD */
> +	[MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
>  
>  	/* ----- TM ------ */
>  	/* INTERRUPT ENABLE */
> @@ -104,6 +139,131 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> +static int tsens_v2_calibrate_sensor(struct device *dev, struct tsens_sensor *sensor,
> +				     struct regmap *map,  u32 mode, u32 base0, u32 base1)
> +{
> +	u32 slope, czero, val;
> +	char name[8];
> +	int ret;
> +
> +	/* Read offset value */
> +	ret = snprintf(name, sizeof(name), "s%d", sensor->hw_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = nvmem_cell_read_variable_le_u32(dev, name, &sensor->offset);
> +	if (ret)
> +		return ret;
> +
> +	/* Based on calib mode, program SHIFT, SLOPE and CZERO */
> +	switch (mode) {
> +	case TWO_PT_CALIB:
> +		slope = (TWO_PT_SHIFTED_GAIN / (base1 - base0));
> +
> +		czero = (base0 + sensor->offset - ((base1 - base0) / 3));
> +
> +		val = FIELD_PREP(CONVERSION_SHIFT_MASK, V2_SHIFT_DEFAULT) |
> +		      FIELD_PREP(CONVERSION_SLOPE_MASK, slope) |
> +		      FIELD_PREP(CONVERSION_CZERO_MASK, czero);
> +
> +		fallthrough;
> +	case ONE_PT_CALIB2:
> +		czero = base0 + sensor->offset - ONE_PT_CZERO_CONST;
> +
> +		val = FIELD_PREP(CONVERSION_SHIFT_MASK, V2_SHIFT_DEFAULT) |
> +		      FIELD_PREP(CONVERSION_SLOPE_MASK, ONE_PT_SLOPE) |
> +		      FIELD_PREP(CONVERSION_CZERO_MASK, czero);
> +
> +		break;
> +	default:
> +		dev_dbg(dev, "calibrationless mode\n");
> +
> +		val = FIELD_PREP(CONVERSION_SHIFT_MASK, V2_SHIFT_DEFAULT) |
> +		      FIELD_PREP(CONVERSION_SLOPE_MASK, V2_SLOPE_DEFAULT) |
> +		      FIELD_PREP(CONVERSION_CZERO_MASK, V2_CZERO_DEFAULT);

Move val calculation out of switch-case, assign default values to shift,
slope and czero and then change them under switch-case.

> +	}
> +
> +	regmap_write(map, SENSOR_CONVERSION(sensor->hw_id), val);
> +
> +	return 0;
> +}
> +
> +static int tsens_v2_calibration(struct tsens_priv *priv)
> +{
> +	struct device *dev = priv->dev;
> +	u32 mode, base0, base1;
> +	int i, ret;
> +
> +	if (priv->num_sensors > MAX_SENSORS)
> +		return -EINVAL;
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
> +	if (ret == -ENOENT)
> +		dev_warn(priv->dev, "Calibration data not present in DT\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base0", &base0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);

Is this actually base0 / base1 or rather base1 / base2 as used by the
tsens v0.1 / v1 ?

> +	if (ret < 0)
> +		return ret;
> +
> +	/* Calibrate each sensor */
> +	for (i = 0; i < priv->num_sensors; i++) {
> +		ret = tsens_v2_calibrate_sensor(dev, &priv->sensor[i], priv->srot_map,
> +						mode, base0, base1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init init_tsens_v2_no_rpm(struct tsens_priv *priv)
> +{
> +	struct device *dev = priv->dev;
> +	int i, ret;
> +	u32 val = 0;
> +
> +	ret = init_common(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->rf[CODE_OR_TEMP] = devm_regmap_field_alloc(dev, priv->srot_map,
> +							 priv->fields[CODE_OR_TEMP]);
> +	if (IS_ERR(priv->rf[CODE_OR_TEMP]))
> +		return PTR_ERR(priv->rf[CODE_OR_TEMP]);
> +
> +	priv->rf[MAIN_MEASURE_PERIOD] = devm_regmap_field_alloc(dev, priv->srot_map,
> +								priv->fields[MAIN_MEASURE_PERIOD]);
> +	if (IS_ERR(priv->rf[MAIN_MEASURE_PERIOD]))
> +		return PTR_ERR(priv->rf[MAIN_MEASURE_PERIOD]);
> +
> +	regmap_field_write(priv->rf[TSENS_SW_RST], SW_RST_ASSERT);
> +
> +	regmap_field_write(priv->rf[MAIN_MEASURE_PERIOD], MEASURE_PERIOD_2mSEC);
> +
> +	/* Enable available sensors */
> +	for (i = 0; i < priv->num_sensors; i++)
> +		val |= 1 << priv->sensor[i].hw_id;
> +
> +	regmap_field_write(priv->rf[SENSOR_EN], val);
> +
> +	/* Select temperature format, unit is deci-Celsius */
> +	regmap_field_write(priv->rf[CODE_OR_TEMP], RSEULT_FORMAT_TEMP);
> +
> +	regmap_field_write(priv->rf[TSENS_SW_RST], SW_RST_DEASSERT);
> +
> +	regmap_field_write(priv->rf[TSENS_EN], TSENS_ENABLE);
> +
> +	return 0;
> +}
> +
>  static const struct tsens_ops ops_generic_v2 = {
>  	.init		= init_common,
>  	.get_temp	= get_temp_tsens_valid,
> @@ -122,6 +282,28 @@ struct tsens_plat_data data_ipq8074 = {
>  	.fields	= tsens_v2_regfields,
>  };
>  
> +static const struct tsens_ops ops_ipq5332 = {
> +	.init		= init_tsens_v2_no_rpm,
> +	.get_temp	= get_temp_tsens_valid,
> +	.calibrate	= tsens_v2_calibration,
> +};
> +
> +struct tsens_plat_data data_ipq5332 = {
> +	.num_sensors	= 5,
> +	.ops		= &ops_ipq5332,
> +	.hw_ids		= (unsigned int []){11, 12, 13, 14, 15},
> +	.feat		= &ipq5332_feat,
> +	.fields		= tsens_v2_regfields,
> +};
> +
> +struct tsens_plat_data data_ipq5424 = {
> +	.num_sensors	= 7,
> +	.ops		= &ops_ipq5332,
> +	.hw_ids		= (unsigned int []){9, 10, 11, 12, 13, 14, 15},
> +	.feat		= &ipq5332_feat,
> +	.fields		= tsens_v2_regfields,
> +};
> +
>  /* Kept around for backward compatibility with old msm8996.dtsi */
>  struct tsens_plat_data data_8996 = {
>  	.num_sensors	= 13,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 0b4421bf4785..c5409225756f 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -975,7 +975,7 @@ int __init init_common(struct tsens_priv *priv)
>  	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>  	if (ret)
>  		goto err_put_device;
> -	if (!enabled) {
> +	if (!enabled && (tsens_version(priv) != VER_2_X_NO_RPM)) {
>  		dev_err(dev, "%s: device not enabled\n", __func__);
>  		ret = -ENODEV;
>  		goto err_put_device;
> @@ -1102,6 +1102,12 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
>  
>  static const struct of_device_id tsens_table[] = {
>  	{
> +		.compatible = "qcom,ipq5332-tsens",
> +		.data = &data_ipq5332,
> +	}, {
> +		.compatible = "qcom,ipq5424-tsens",
> +		.data = &data_ipq5424,
> +	}, {
>  		.compatible = "qcom,ipq8064-tsens",
>  		.data = &data_8960,
>  	}, {
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index cab39de045b1..ac5358e48f74 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -35,6 +35,7 @@ enum tsens_ver {
>  	VER_0_1,
>  	VER_1_X,
>  	VER_2_X,
> +	VER_2_X_NO_RPM,
>  };
>  
>  enum tsens_irq_type {
> @@ -168,6 +169,7 @@ enum regfield_ids {
>  	TSENS_SW_RST,
>  	SENSOR_EN,
>  	CODE_OR_TEMP,
> +	MAIN_MEASURE_PERIOD,
>  
>  	/* ----- TM ------ */
>  	/* TRDY */
> @@ -650,6 +652,6 @@ extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8
>  extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
>  
>  /* TSENS v2 targets */
> -extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
> +extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332, data_ipq5424, data_tsens_v2;
>  
>  #endif /* __QCOM_TSENS_H__ */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

