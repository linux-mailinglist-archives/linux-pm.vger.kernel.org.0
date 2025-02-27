Return-Path: <linux-pm+bounces-23081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF7AA4823B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B827A3666
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0870025F7A7;
	Thu, 27 Feb 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfldS48T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB225F79E
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668386; cv=none; b=Qt1TLbJQOnSJX9FpTLBJ0LVE5yjytJ1phI5yCdDUq1+m1YdpcsJ8DuWgfn48TLEBCI8p+wA+zzf2vZV/CSo1VFH7uugSvLBd6wN3GWR1gI9PAE0UnsSebtwAa/JxmjhxIVkn9F7MhzYn0JIGJFTNd/HmVqUE9gkR6b3gS+hAWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668386; c=relaxed/simple;
	bh=hu6PCPNxWYe6TO8BfZheoDp55jzoBSnRVokC6usg7ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk6sgP1wTgThaKeKYwi1Ffl/eWJLd/OnMCdlb7BozWEWNgTZMduKOsHye+gYqUn3uyhTg+C1qM80dOWe7aasqKhVrvUGrWhPQqbeXRkDnUOD10SM8YPjyjvpf6KzD1ngySYrf2m38JdQ6PPo97kK2UIjYspVhSgdgCq7LCA3Utg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AfldS48T; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso1131447e87.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740668383; x=1741273183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxB5rk2wDXT4mhpMg1e6s6YmU8Yw2zzZEzuHwWlfNNo=;
        b=AfldS48T1/rwytxb9wmamNPxAPPI2BcaAiaKOinOE1bO3lUq2v5j+3sovxDhPiAcNe
         4KUWviLJGomylajmkA3PhacnarzVlCxpWn2vLSGWwwm5jTJxTMe7Q2QvP9hm2KdhNgzj
         xIr8nX1XXoivZExFiS+AqhQOz4BieN23jfs3QQ3Zu2KgI//5ZURdUiuMMfAUl8hW0N06
         owjPCXKOSVWbu1Ur7J6c1l0e9rnJ+AU5MO667nmd7d2bHyOaLeg10D110f26ZkzMMRG/
         Od8j3USNqBJT/SFfZW+cH3FKlIXNPA+B4h60c+6p5LfarweH6gzBh75988a8IrPGPskT
         +nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740668383; x=1741273183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxB5rk2wDXT4mhpMg1e6s6YmU8Yw2zzZEzuHwWlfNNo=;
        b=R4V/3VhcYNRfZcPXB2nZO1ScIvKGgomHVwo5O0/Ll4EQe6tese21w2s4/TX1xlX8C5
         7uPXbsUF5L838/rmKIVWzK9zSVSnDxzEJr1iV56UELOYKQLU0ul50AF2g84TZwaCRLyw
         ma1tfZxjEYAXLOwlbrDpFxLcYYqWI47jLQJQo0DnRoVaGEdm0k1lDO3hNYnSByQocrNY
         7wMGfDzYDhCNyrPVueQl0cK9NfQgFW/35y8jDheLZ2wPJvpZ+f7I8u8BRPtUP2W4hbQJ
         SS+YqAq6cgTeZMIljVj6YR155LubMB8zQC1ix/YC5vNCIABaG5IoL3xCks358q3clka7
         bp7w==
X-Forwarded-Encrypted: i=1; AJvYcCVCibhO+ru6PcZka3UMxrwoVf+Krq16fW+lU7gcix5ScmEkcfgFXco9R33/cL1gHUcOfVRruxBolA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHf6Y7HDt8x7GaogOoJ3RO+J0XVRWkJ04T3gs5UJAipra/QMpj
	7c3H30QExwG2W5WFmgG9sZnXkRQbkoB3fjJwgiIHUoXGC0FQauo2yaJE3/jnNo4=
X-Gm-Gg: ASbGnct6HCZpEE1btt8mSVJV8c6ejy1zTlGpecxIR4TNeMUxYyulTsCqy/m5OXWlr2O
	XNp6cNTBXnfn6vzFj73qTIUUIkrUeSorm0ESbatqeDEUBk3d0ckLeNFcF013O2cp6VjQB1Ml8cX
	RD5CDMtT/HyFEdrJI2r94Sy3hsSi7c996cKWv6aMC0NmrfTy3iX2/1jn6t3uXuluefaRfT+NPZC
	MgHwkY+Sb1+SwT0Pnwp26DsgJVqyP1CkuW4sYdqVkQKRuxyPFcB/IM+N4wRNvVAqIIgOXrAbj53
	49dGwzYk/PRrqJ65yGdnuMcyHUbEmRsjzVJ1VifP1U6UOaq7oIVUYM7BzQRBNavt8yBWiZiyyI+
	VjiwG0Q==
X-Google-Smtp-Source: AGHT+IGKmniXL4M4wb/RJwLSpFqcjFFTAbzhghjbQyHbEKnMjC2+uC8jzBm13hyn17/VFvjsBLyeGA==
X-Received: by 2002:a05:6512:110d:b0:545:62c:4b13 with SMTP id 2adb3069b0e04-54838f4c9efmr11981358e87.40.1740668381655;
        Thu, 27 Feb 2025 06:59:41 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443be6a0sm187706e87.193.2025.02.27.06.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:59:41 -0800 (PST)
Date: Thu, 27 Feb 2025 16:59:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org, 
	thara.gopinath@gmail.com, robh@kernel.org, krzk+dt@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v8 3/5] thermal: qcom: tsens: add support for tsens v1
 without RPM
Message-ID: <eafirt5dg4vmafmu2wph47zrrzyqrz65z5ypqrl7fhr77qckfi@dgqwkkhnz4ge>
References: <20250227110423.8418-1-george.moussalem@outlook.com>
 <DS7PR19MB888322C58FC555299256E8D99DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR19MB888322C58FC555299256E8D99DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>

On Thu, Feb 27, 2025 at 02:56:41PM +0400, George Moussalem wrote:
> Adding generic support for SoCs with tsens v1.0 IP with no RPM.
> Due to lack of RPM, tsens has to be reset and enabled in the driver
> init.
> 
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 48 +++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    | 24 ++++++++++-------
>  drivers/thermal/qcom/tsens.h    |  1 +
>  3 files changed, 64 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 1a7874676f68..877b27274fd2 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -79,6 +79,17 @@ static struct tsens_features tsens_v1_feat = {
>  	.trip_max_temp	= 120000,
>  };
>  
> +static struct tsens_features tsens_v1_no_rpm_feat = {
> +	.ver_major	= VER_1_X_NO_RPM,
> +	.crit_int	= 0,
> +	.combo_int	= 0,
> +	.adc		= 1,
> +	.srot_split	= 1,
> +	.max_sensors	= 11,
> +	.trip_min_temp	= -40000,
> +	.trip_max_temp	= 120000,
> +};
> +
>  static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>  	/* ----- SROT ------ */
>  	/* VERSION */
> @@ -150,6 +161,43 @@ static int __init init_8956(struct tsens_priv *priv) {
>  	return init_common(priv);
>  }
>  
> +static int __init init_tsens_v1_no_rpm(struct tsens_priv *priv)
> +{
> +	int i, ret;
> +	u32 mask = 0;
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
> +	for (i = 0; i < priv->num_sensors; i++)
> +		mask |= BIT(priv->sensor[i].hw_id);
> +
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
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 1f5d4de017d9..f860ea86d130 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -447,7 +447,7 @@ static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
>  	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
>  		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
>  		enable ? "en" : "dis");
> -	if (tsens_version(priv) > VER_1_X)
> +	if (tsens_version(priv) > VER_1_X_NO_RPM)

I'd suggest to replace these checks with >= VER_2_X. This saves us from
all the troubles if there is another 1.x 'modification' later on.

>  		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
>  	else
>  		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
> @@ -499,7 +499,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
>  	ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
>  	if (ret)
>  		return ret;
> -	if (tsens_version(priv) > VER_1_X) {
> +	if (tsens_version(priv) > VER_1_X_NO_RPM) {
>  		ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
>  		if (ret)
>  			return ret;
> @@ -543,7 +543,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
>  
>  static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
>  {
> -	if (ver > VER_1_X)
> +	if (ver > VER_1_X_NO_RPM)
>  		return mask & (1 << hw_id);
>  
>  	/* v1, v0.1 don't have a irq mask register */
> @@ -733,7 +733,7 @@ static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
>  static int tsens_enable_irq(struct tsens_priv *priv)
>  {
>  	int ret;
> -	int val = tsens_version(priv) > VER_1_X ? 7 : 1;
> +	int val = tsens_version(priv) > VER_1_X_NO_RPM ? 7 : 1;
>  
>  	ret = regmap_field_write(priv->rf[INT_EN], val);
>  	if (ret < 0)
> @@ -975,10 +975,16 @@ int __init init_common(struct tsens_priv *priv)
>  	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>  	if (ret)
>  		goto err_put_device;
> -	if (!enabled && (tsens_version(priv) != VER_2_X_NO_RPM)) {
> -		dev_err(dev, "%s: device not enabled\n", __func__);
> -		ret = -ENODEV;
> -		goto err_put_device;
> +	if (!enabled) {
> +		switch (tsens_version(priv)) {
> +		case VER_1_X_NO_RPM:
> +		case VER_2_X_NO_RPM:
> +			break;
> +		default:
> +			dev_err(dev, "%s: device not enabled\n", __func__);
> +			ret = -ENODEV;
> +			goto err_put_device;
> +		}
>  	}
>  
>  	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
> @@ -1040,7 +1046,7 @@ int __init init_common(struct tsens_priv *priv)
>  		}
>  	}
>  
> -	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
> +	if (tsens_version(priv) > VER_1_X_NO_RPM &&  ver_minor > 2) {
>  		/* Watchdog is present only on v2.3+ */
>  		priv->feat->has_watchdog = 1;
>  		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 336bc868fd7c..e3cb611426c4 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -34,6 +34,7 @@ enum tsens_ver {
>  	VER_0 = 0,
>  	VER_0_1,
>  	VER_1_X,
> +	VER_1_X_NO_RPM,
>  	VER_2_X,
>  	VER_2_X_NO_RPM,
>  };
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry

