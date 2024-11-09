Return-Path: <linux-pm+bounces-17244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A869C28C6
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 01:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E3BB21E81
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 00:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31AC4437;
	Sat,  9 Nov 2024 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psn2xyuq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003248BE5
	for <linux-pm@vger.kernel.org>; Sat,  9 Nov 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111832; cv=none; b=gfHvGj627AVKHWR1hohnppe/0Xe/RuogKVfWv46LeEaWuWBnf2MGhc4W+i5c85XDt2ftGhV4O8qyORrCXSgoTTc2o7M5GaVuO8JJeHCrzWizLMlUcwB0+bLgMWfqoyFCowa7W+yLTNDxHBkqydn3xNzrXB9zPH7t6uLaODWII4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111832; c=relaxed/simple;
	bh=m5snUBzSF9Zk9uwVyfFeARa+ZNDvJoKukKw2KaQMHHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9o0TQM2c1nI0MI29V9znvasu1EMh3Jozz3lwNJVvW3uxV6hk333JDBvotBVnsmix9Ta37KI6xmbX5JGptX4iTkkk0um9LpJ+Wua4+7rxSGM0io/LnZy99giEuI0xPbDop9jkj5TKVUvfVmrzK2do4AoE2OWKH8FqGAdHIzq0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psn2xyuq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so22591121fa.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2024 16:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731111829; x=1731716629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCUSp8vZt+etdZ/oJELhkYG4M5ycIKVOibuDoFx6fIU=;
        b=psn2xyuqZjkVKoauKQImB1HSMc00iEKaUAmLhVY6xKLiqSMNcgxTNVg7eKDu7e5o3t
         Z5QN8EOHSdmRfzR9kU6cllF2CfdmaKB4UO6W66ZmYIBuHZy7fv20iF28JYyi9DPaGgK5
         j1EWKXmLwx/IWQv6jzDDX8h24ROC40ZWnwuNMc5nrpzskM9tNXuztr6r541ZfOdUhVLL
         64Y4S/ZyTEC0IOZeRZ7Grre4yUB7eMhky4B2uB591rVVe5GkVk7Gbs4Rw8PM/3qMagor
         SlJTD1de+DtwTEhO+snMgvMIbuI4fpwX2QM5FWmlyeXgGnPWU3H5Fxzh6X25BrrwZ98y
         Vcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111829; x=1731716629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCUSp8vZt+etdZ/oJELhkYG4M5ycIKVOibuDoFx6fIU=;
        b=Do54T9P7jbvVuCdTJBen+VF23z6bO1yb8L6QET67NnNnHalFhNOVH3vDPLWzOvhY9x
         +OpuYdKbXSi/lxP29b2q+mS4J4D+e96WFLnx1UnsbOBX5QjizNE8dyLXEZCliy5dLHqv
         whVl/Wald6Acama2ofPV2wbsIXBvmJYnSmTG9SNXjV4fu4gZu0XRD6dAKW2e8K/nA63C
         ffEOez6Kzko6z7jtEYkGmS5gfVs4tccmqs4QAAQgcKcIhIHEUumrmlUpvV7f65Fay8E3
         x9Eb3DyqyK6m8SVeKmxtXqk4k2XUwg67x/KEDgosM2u+aejBJPXVEInOVhyWin3cw14K
         kTpw==
X-Forwarded-Encrypted: i=1; AJvYcCUUtAc2fDYYkRDCN6P404C6ZfTAh414P7hzmsmgkkw8JL9xQ826Vx5+17QaU9Hvw0ydoRpAC9cGjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKiJzb3luZInjn9ZCv+9OpIraaM1j+l4pBoYAPRG7c/Po30oc
	zlX0EAP18zYPm0Tuz2RSFRJkd8mJwY5NmvMX8xgygNe1ImJAz24ZrCuBa+24Q+Q=
X-Google-Smtp-Source: AGHT+IFRWk001tkq1A4/3uIoY4IY1UFsTqMCK1GVPAMXfalK9z2bqEPusxsZuSeSFQxPzDkOgwfPkQ==
X-Received: by 2002:a05:651c:549:b0:2fa:dadf:aad5 with SMTP id 38308e7fff4ca-2ff202683eamr27805411fa.28.1731111829101;
        Fri, 08 Nov 2024 16:23:49 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17910e1csm8492181fa.68.2024.11.08.16.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:23:47 -0800 (PST)
Date: Sat, 9 Nov 2024 02:23:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH v7 3/7] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
Message-ID: <z24xwwdtd6rytktxtuagiwbiukwd5tvfhotbbydizwsjtlnaob@q3ujwf2eiwds>
References: <20241107140550.3260859-1-quic_mmanikan@quicinc.com>
 <20241107140550.3260859-4-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107140550.3260859-4-quic_mmanikan@quicinc.com>

On Thu, Nov 07, 2024 at 07:35:46PM +0530, Manikanta Mylavarapu wrote:
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
> Changes in V7:
> 	- Move val calculation out of switch-case and assign default
> 	  values to shift, slope and czero and then change them under
> 	  switch-case in tsens_v2_calibrate_sensor().
> 
>  drivers/thermal/qcom/tsens-v2.c | 176 ++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    |   8 +-
>  drivers/thermal/qcom/tsens.h    |   4 +-
>  3 files changed, 186 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 0cb7301eca6e..6d2783577139 100644
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
> @@ -59,6 +89,10 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	/* CTRL_OFF */
>  	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
>  	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
> +	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
> +	[CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
> +
> +	[MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
>  
>  	/* ----- TM ------ */
>  	/* INTERRUPT ENABLE */
> @@ -104,6 +138,126 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> +static int tsens_v2_calibrate_sensor(struct device *dev, struct tsens_sensor *sensor,
> +				     struct regmap *map,  u32 mode, u32 base0, u32 base1)
> +{
> +	u32 shift = V2_SHIFT_DEFAULT;
> +	u32 slope = V2_SLOPE_DEFAULT, czero = V2_CZERO_DEFAULT, val;
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
> +		fallthrough;
> +	case ONE_PT_CALIB2:
> +		czero = base0 + sensor->offset - ONE_PT_CZERO_CONST;

THis will override czero calculation from TWO_PT_CALIB case.

> +
> +		slope = ONE_PT_SLOPE;
> +
> +		break;
> +	default:
> +		dev_dbg(dev, "calibrationless mode\n");
> +	}
> +
> +	val =	FIELD_PREP(CONVERSION_SHIFT_MASK, shift) |
> +		FIELD_PREP(CONVERSION_SLOPE_MASK, slope) |
> +		FIELD_PREP(CONVERSION_CZERO_MASK, czero);
> +
> +	regmap_write(map, SENSOR_CONVERSION(sensor->hw_id), val);
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry

