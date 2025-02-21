Return-Path: <linux-pm+bounces-22651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717FA3F69A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 14:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB0E174DDF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157020D4E4;
	Fri, 21 Feb 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwEiZFH0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4E20B7E0
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146378; cv=none; b=s3rLPPV06F8McHk6/t0dFqVnc50uEvS8FnAwVODRt9glGkuYJf39QQNQQWJ6zgV7usSyJOcVIKLe6/ZnUQMxuz3Rjnet8jBOSLI+Szp1jrqgZi+nRIOih10kSnGh6Utl8wMSOLCi7epZOGq1ECw2n/TDod5yw0tu9gzJ+0CJ/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146378; c=relaxed/simple;
	bh=CbxAJQT3KnJjiwPB/Rc1ytu55iSPfTpU8eUVc7UEzqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAt3kRh+o/LCeIGBiJ1ZuvelFwcd3avlpb+JmPIF/kAnkBsT+VS7PF3lTHnI4bzWyLG8i0TLlEoNWllOMd2Y/zwY81N66kI6prRZ5ZtipmlNJgv+zSKf2CdY3qhhKU1GBipOwr/kJjmhpsDdgyMYPBmG7yrvNCzEf3j/FWctFVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JwEiZFH0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-545316f80beso1963856e87.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740146374; x=1740751174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zYl4L9cR43dlWu0AvSnmoEUXilsvHz4aPwBMTecENo=;
        b=JwEiZFH0sCyQlkXWPegQw5ZOVXQUJxVe3IlZiS32RMNudvk2ud3S7iLbn05/AEATSY
         vh2t2cN3ZBVCGWpiTslQtGbuZRyUI5tPniq9Mk50LRhqPiq+03HWoDIBgbrz/+8UgIea
         YE1Mn8qrRLL2DdcseyP2UxnZ1jNAigHnnAP4narVJWiYJTQkB/qgGiuqAFcUomp5dGsv
         MUTeKW8k4YQNfSPdZhakH5N6VfslSJu88hkMxivr3WkcT9QVxsGPwjw8qd4aYfFoOgOC
         rvqt2fs9OcjZKP42AZFxp5j5BnDygAdj7t+GO4Ovh7QqYICGgzdxE92V2OPiLsdlhFr6
         Y/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740146374; x=1740751174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zYl4L9cR43dlWu0AvSnmoEUXilsvHz4aPwBMTecENo=;
        b=Yt1P6jEGEtGePqL6O5lDPy7CSdNgg7JpgvZ8nQihjMXsCTj6P7zM3kwgxZTNnMZgDm
         r5oZsHQi46xw3GKZnEGeiYYUbOcFuD2jf2q6o/hjTmDy0UzGZqYvji1sxmllgEQ6mMPs
         NVXyEpAqU7K3E95TW8NfuJkCEQyk18ektokYG0Vh1ADRkOFCbaSny0E9Cu/t5C3cUCQf
         vR4b1ksb7xM6BhbVHv3VQXnfru6eAVqxmVsID7ygP/ut+VcJ/smy8qu7SPyVzZv5SPf9
         5gHfW7ejYRtEA9raKI2zOYCOdsMyMhxzr8JkW/u2aYAv8MJonkFCyalxSTneVlX7xqPi
         1Jkg==
X-Forwarded-Encrypted: i=1; AJvYcCX26cbzW0xecsK1D+SzRncGg1IM1AdwGk0d1akjizIZ/mesB7dynUkcKrZVkrz5hmHpObAOGe0gDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0uvJ8iHxREQvlHaYkO1vKQKaZVukEG/IpsJGxPwVWepso/t9
	EBoQE+gMP+/af6mQ7gsNlNlwkj86VzfZS30ICaUCG2RyIFgeauX+W4woP/x1tNBSaXiKyi77VPL
	x
X-Gm-Gg: ASbGncsSfmuUnz+pZmSyQsdkqYLCse8TYBXim67iW2o2jN2hzoj9TZA56t7pHUuoSpE
	JDnN9AmdgP4Vr3Up6s+8hMAPrVhFJ9HA3OyNXUFcC7ayxfto8LcSEgMY+e/TTeeH7e0myjduw0J
	tOg5IsKQ+gs5DvchT7kKZQV+DJmisFolvf067CCLvu8tuTZ8yQW42ahcSH/D299f1LqGzQexAWx
	vv47T6m4KQ4HPfMZGOIQM3JyGB3yZTlipQeroPCguaf0DLm4C+nVSDykBR4frqSagabQM+vddhT
	8cK+3Y0HWORRbvCEhQA5mgfz5DtKlnIR6Kpe0jj7TdOI1d1yvo8QqWZ1AIRBzqI+EJXn4tZetlW
	QQ5qfQg==
X-Google-Smtp-Source: AGHT+IH1adyJodZuxejqxdNY7+1MgnBwNtjWHQ8rUzYhMFZCIdPs+a2+d5mwFLrhDrfQsO0ptGItPA==
X-Received: by 2002:a05:6512:ad2:b0:545:191:81db with SMTP id 2adb3069b0e04-54838f5e248mr1022548e87.50.1740146374490;
        Fri, 21 Feb 2025 05:59:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54531b8ac1dsm1994118e87.75.2025.02.21.05.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:59:33 -0800 (PST)
Date: Fri, 21 Feb 2025 15:59:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v4 4/5] thermal: qcom: tsens: Add support for IPQ5018
 tsens
Message-ID: <zesif5ehsoho3725k4xjqhb3tizj6fj6ufocdlzd3facj5hrrt@r4t5hthvyp2p>
References: <20250221065219.17036-1-george.moussalem@outlook.com>
 <DS7PR19MB8883A75912761EB89C9A1B409DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR19MB8883A75912761EB89C9A1B409DC72@DS7PR19MB8883.namprd19.prod.outlook.com>

On Fri, Feb 21, 2025 at 10:52:18AM +0400, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
> The soc does not have a RPM, hence tsens has to be reset and
> enabled in the driver init. Adding the driver support for same.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  [v4] Added Dmitry's Reviewed-by tag
>       Fixed modpost warning: added __init to init_common
> 
>  drivers/thermal/qcom/tsens-v1.c | 60 +++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    |  3 ++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 1a7874676f68..1f955acbc2cf 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -79,6 +79,18 @@ static struct tsens_features tsens_v1_feat = {
>  	.trip_max_temp	= 120000,
>  };
>  
> +static struct tsens_features tsens_v1_ipq5018_feat = {
> +	.ver_major	= VER_1_X,
> +	.crit_int	= 0,
> +	.combo_int	= 0,
> +	.adc		= 1,
> +	.srot_split	= 1,
> +	.max_sensors	= 11,
> +	.trip_min_temp	= -40000,
> +	.trip_max_temp	= 120000,
> +	.ignore_enable	= 1,
> +};
> +
>  static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>  	/* ----- SROT ------ */
>  	/* VERSION */
> @@ -150,6 +162,41 @@ static int __init init_8956(struct tsens_priv *priv) {
>  	return init_common(priv);
>  }
>  
> +static int __init init_ipq5018(struct tsens_priv *priv)
> +{
> +	int ret;
> +	u32 mask;
> +
> +	ret = init_common(priv);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "Init common failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 1);
> +	if (ret) {
> +		dev_err(priv->dev, "Reset failed\n");
> +		return ret;
> +	}
> +
> +	mask = GENMASK(priv->num_sensors, 0);
> +	ret = regmap_field_update_bits(priv->rf[SENSOR_EN], mask, mask);
> +	if (ret) {
> +		dev_err(priv->dev, "Sensor Enable failed\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_field_write(priv->rf[TSENS_EN], 1);
> +	if (ret) {
> +		dev_err(priv->dev, "Enable failed\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 0);
> +
> +	return ret;
> +}
> +
>  static const struct tsens_ops ops_generic_v1 = {
>  	.init		= init_common,
>  	.calibrate	= calibrate_v1,
> @@ -194,3 +241,16 @@ struct tsens_plat_data data_8976 = {
>  	.feat		= &tsens_v1_feat,
>  	.fields		= tsens_v1_regfields,
>  };
> +
> +const struct tsens_ops ops_ipq5018 = {
> +	.init		= init_ipq5018,
> +	.calibrate	= tsens_calibrate_common,
> +	.get_temp	= get_temp_tsens_valid,
> +};
> +
> +struct tsens_plat_data data_ipq5018 = {
> +	.num_sensors	= 5,

Commit message suggests that this should be '4'.

> +	.ops		= &ops_ipq5018,
> +	.feat		= &tsens_v1_ipq5018_feat,
> +	.fields		= tsens_v1_regfields,
> +};

-- 
With best wishes
Dmitry

