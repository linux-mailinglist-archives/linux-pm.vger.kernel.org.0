Return-Path: <linux-pm+bounces-23131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA97A4887A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 20:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9350E7A3861
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9261EFF88;
	Thu, 27 Feb 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9qMKKL3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748741ABEAC
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682964; cv=none; b=HFmf8b/oU66vUvdi1eStTaOg9e2Cw6olPqJF94v3nhV+rHYPSTPx9h00ORG0JugNZwKg/3fWrW46zTI8Xczh9zzRTz0SOir77101VSKCpV3qAGQZXLc2RZZ2zgJvK04XPaf96ZFnFSTmCbzFu1X7I6j9/+kDcfQMKuB0+bm6uP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682964; c=relaxed/simple;
	bh=BuRTevzALKItQZ428xQb6alv2AlOwzdRzrIVuA9l5lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKR3O6TuM9fFORAKhJJiypkeAcAdWu6t9Cr3wPunwXRGolCCGZnlACklpmzzaNJWraSgjX8oX13TmoDCG37VgqXQKpjD0WsJgpphJscmSYRApfGL/Ibpzd/vZtwzaydW4+FpPmxgtwKVZqoQaElBU/7dtUl3u67PcY18Fk9Gzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9qMKKL3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5494bc4d796so278541e87.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740682960; x=1741287760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRlHVq/fhYckH/apG8DI4lghb+1AD7fw2kBANnribBo=;
        b=H9qMKKL35VarGsBGXNCl+/oELISY6bvK2qXa9tTalQhF0Tv2rnz/8s3Tz8iDP8kbO3
         CZdFryyEadmpeJachd4w17fuZ+o+f0EuQMp/m51AH4H8mHWoTKdFy9FPJL5f1BmOwWiN
         X/IEAB8WZBmF7F5ks1JmpPZBrNPZfXCGLr2ZD3DepZ8018esrzu5qI48+C2+V6UnfbBJ
         +r+zcaUGMYodf2Ij+/+36N3YcCoGKf1d+Vov5ChHVdrhrtN5DeH/7PVzLtd2/uX5ktZw
         IX5/qIl2EwkXPeXCOSht2WGn0cn6d6+/iOn65NPTELMXqM9gdvTtQKU5lK0h1eaOM0bl
         //Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682960; x=1741287760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRlHVq/fhYckH/apG8DI4lghb+1AD7fw2kBANnribBo=;
        b=okUZB8PQP8QEv2I4+20ips07kxqh3352Mc96wh2IhTDjZskVBB8mFGhmmIV4fS8NyH
         KjbXzXlEH7YU6fGyC45KI3M0PFdi2PnfKk8MWvfMomWEqOzPr8tMRL6A7WeBHYsJtHUW
         7NC0kwImP+TpohvuxODhDyxIsGr1MRnJ9S23IV5hhHNLyxkEFKOvxQJwU8/DRv9BtyID
         vSqfhuz4uffjcuvzXCuBdEJzVePMwpeg+5jj31zVa52yQgtApIsU8ueefcQpkeJOYhZO
         3A0kp8Wg6F4A/lTZYdmmAsUyCJTTAuUZPIRmCIYpz41xlFXdCxD1uQrz4nu4fUPC+q2W
         eUnw==
X-Forwarded-Encrypted: i=1; AJvYcCXqbKpWI8lArsaKer4vddf4JTZC+tcro7d4g5cHkdkapY3RGvOCo7deqmodgPtq8/GNGvxNaWUDJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDkrk3Y7nr4DeiWurRqu3Eu1RNwi27iVq2XqqNFKYoy+NhP6/l
	ZTYU13rKUTp+4PUxn/4gxAhIlzpI8sNiDYVwLYqG3C7w3bqA2wU+b79DBf9KnuY=
X-Gm-Gg: ASbGnctXe/MVDkvNk6ZzimsoC2aUThtXA2n/f+bsL/rvLkCaeSZjhiehbFvRW31xhky
	dQaRVZWm4S6AxnDvkb3tKARAtq+oNfgM9Nqkg+9MkcQHpiVavvz1XJoh7ORwAvMHTywU8z+8M3D
	okkc1KyWVxiQqLRk0v2ct6nMPUYaJ3WWaT/Yo070FyKTFRDX5po08xvBZZYxkk40OsCNmd94SY5
	xCu8HEuH9Trmyp0wZRuUJVkpsfFfgxG1zOqi52Rp0IYjBOx9aJDpX8GIV5Zvv+lKwuax46jY+eq
	WOxooKQXYXSqVLhRYXyMOOrVnIpyZN1+Y1BmvfYmSGfvSPCpW+Dv530xY0WJiF4lZCfC5FtODu8
	KfM50tA==
X-Google-Smtp-Source: AGHT+IEp+Zq10szXRG2lH2uoKic4S9ViqPTrcBL1J0yzeLJRfwMYDIrB8jNjP79DfJiBuDuA6G4xvg==
X-Received: by 2002:a05:6512:128e:b0:545:e2e:843a with SMTP id 2adb3069b0e04-5494c37d9d5mr240100e87.38.1740682960314;
        Thu, 27 Feb 2025 11:02:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417446fsm236096e87.31.2025.02.27.11.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 11:02:38 -0800 (PST)
Date: Thu, 27 Feb 2025 21:02:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org, 
	thara.gopinath@gmail.com, robh@kernel.org, krzk+dt@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v8 3/5] thermal: qcom: tsens: add support for tsens v1
 without RPM
Message-ID: <xv3c2ube7the3gat7ustws4ok6t26c33fyywqi6x3utx52qtzb@owyidrxeprcp>
References: <20250227110423.8418-1-george.moussalem@outlook.com>
 <DS7PR19MB888322C58FC555299256E8D99DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <eafirt5dg4vmafmu2wph47zrrzyqrz65z5ypqrl7fhr77qckfi@dgqwkkhnz4ge>
 <DS7PR19MB888363A4FF954A6275E81B4B9DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR19MB888363A4FF954A6275E81B4B9DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>

On Thu, Feb 27, 2025 at 09:25:05PM +0400, George Moussalem wrote:
> 
> On 2/27/25 18:59, Dmitry Baryshkov wrote:
> 
> > On Thu, Feb 27, 2025 at 02:56:41PM +0400, George Moussalem wrote:
> >> Adding generic support for SoCs with tsens v1.0 IP with no RPM.
> >> Due to lack of RPM, tsens has to be reset and enabled in the driver
> >> init.
> >>
> >> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> >> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> >> ---
> >>  drivers/thermal/qcom/tsens-v1.c | 48 +++++++++++++++++++++++++++++++++
> >>  drivers/thermal/qcom/tsens.c    | 24 ++++++++++-------
> >>  drivers/thermal/qcom/tsens.h    |  1 +
> >>  3 files changed, 64 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> >> index 1a7874676f68..877b27274fd2 100644
> >> --- a/drivers/thermal/qcom/tsens-v1.c
> >> +++ b/drivers/thermal/qcom/tsens-v1.c
> >> @@ -79,6 +79,17 @@ static struct tsens_features tsens_v1_feat = {
> >>  	.trip_max_temp	= 120000,
> >>  };
> >>  
> >> +static struct tsens_features tsens_v1_no_rpm_feat = {
> >> +	.ver_major	= VER_1_X_NO_RPM,
> >> +	.crit_int	= 0,
> >> +	.combo_int	= 0,
> >> +	.adc		= 1,
> >> +	.srot_split	= 1,
> >> +	.max_sensors	= 11,
> >> +	.trip_min_temp	= -40000,
> >> +	.trip_max_temp	= 120000,
> >> +};
> >> +
> >>  static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
> >>  	/* ----- SROT ------ */
> >>  	/* VERSION */
> >> @@ -150,6 +161,43 @@ static int __init init_8956(struct tsens_priv *priv) {
> >>  	return init_common(priv);
> >>  }
> >>  
> >> +static int __init init_tsens_v1_no_rpm(struct tsens_priv *priv)
> >> +{
> >> +	int i, ret;
> >> +	u32 mask = 0;
> >> +
> >> +	ret = init_common(priv);
> >> +	if (ret < 0) {
> >> +		dev_err(priv->dev, "Init common failed %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 1);
> >> +	if (ret) {
> >> +		dev_err(priv->dev, "Reset failed\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	for (i = 0; i < priv->num_sensors; i++)
> >> +		mask |= BIT(priv->sensor[i].hw_id);
> >> +
> >> +	ret = regmap_field_update_bits(priv->rf[SENSOR_EN], mask, mask);
> >> +	if (ret) {
> >> +		dev_err(priv->dev, "Sensor Enable failed\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = regmap_field_write(priv->rf[TSENS_EN], 1);
> >> +	if (ret) {
> >> +		dev_err(priv->dev, "Enable failed\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 0);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  static const struct tsens_ops ops_generic_v1 = {
> >>  	.init		= init_common,
> >>  	.calibrate	= calibrate_v1,
> >> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> >> index 1f5d4de017d9..f860ea86d130 100644
> >> --- a/drivers/thermal/qcom/tsens.c
> >> +++ b/drivers/thermal/qcom/tsens.c
> >> @@ -447,7 +447,7 @@ static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
> >>  	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
> >>  		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
> >>  		enable ? "en" : "dis");
> >> -	if (tsens_version(priv) > VER_1_X)
> >> +	if (tsens_version(priv) > VER_1_X_NO_RPM)
> > I'd suggest to replace these checks with >= VER_2_X. This saves us from
> > all the troubles if there is another 1.x 'modification' later on.
> 
> makes sense, will change to >= VER_2_X. Thanks for the feedback.

THanks! It also makes sense to split this into two patches then: one
which changes the condition all over the place and the other one which
adds VER_1_X_NO_RPM.

> 
> >
> >>  		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
> >>  	else
> >>  		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);

-- 
With best wishes
Dmitry

