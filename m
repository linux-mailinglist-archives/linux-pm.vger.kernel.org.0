Return-Path: <linux-pm+bounces-10531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BC925A3B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 12:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A141C25DDA
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 10:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF57185E58;
	Wed,  3 Jul 2024 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bv+mtDSc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C11850BB
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003621; cv=none; b=a9edo2Pr5ifbGYxs3PDrdj8+3u+v2N9hWkSo5H/Iji8dSXIsdKlgFlf/Gutay/4vWLRK9hU8E7ZCB8qmwi+mh0uOOvHGKPKBxBCAda0LEHeAIGtbvfLfl+hIYJil+Cgs32om2ghH9OgrFmsnQQnOC4elrSaPi8hXn3i7x7ApB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003621; c=relaxed/simple;
	bh=foPMIvvTPseXesFoCi3Y6Msx3NpMb+EdXsD3e3zHHT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxGwsAERaepDofX8WD93bGpo1RxF8wsosnMRCxIUqEVscwJibtXiFZVWX8yczfOgDL9Vnn3/Z+XoosCCV9fqVu3nIbBDHM1nVzPhBNxEjvfCVBfFXJjwptP8VEcIGLZGABRY6vwm23Owa0JNcPoFPMMUOK4pKl40qctQENYCMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bv+mtDSc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52db11b1d31so7300668e87.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 03:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720003618; x=1720608418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6RqGX8VTMC710d07ZkPLdr6JCBvXddZZa+hWl6qD7c=;
        b=Bv+mtDSc4VpJyl9o7hOA8LPvSe6ExZzmRTBwgM+K5p17KkSLGR7Xu2EnogWzZmxnjJ
         SeSuN8ib18XT508IFxgEDgLdqHRTbCgt+h14MR0u8bvGVfrhVsHup1QTytsViZ4a4g9A
         B7Vd7WcDZtfIxEWZ+8uOnXej6MxTJkXpcvEwKIEEfDXMl/DHekHAV76bIjoZ7PjwNqyh
         PtV1M/Brnq7cUHOPflAfrUkppolTA2lwxslsR1PJqB2hlSnHpZhyjeet2CVAkKt2r4QW
         tCOR9nddCLRIqQF5RUnhmvCPk0tz5Geor3AGQls+Sz1BUembO8Gu8RVbp9Vx7kdBhCld
         MLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720003618; x=1720608418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6RqGX8VTMC710d07ZkPLdr6JCBvXddZZa+hWl6qD7c=;
        b=p58vGHRcazM36AAdlg/ph0HRrPayxWzJYwIbikgzOLdOLXZ80h8F/8FK87qkj96eox
         6GAEmUR53OuLb5SoC05VjrErTFVgQrebmuRJxa2LY0mVfD0dcibK4Idp6cDTtzMPYr8o
         lfycYxFRxmDieL7WBUYDxGkQTRT8a8ERpfdxjGqRi+nZ24Hoh2jtsGOf3heZLZWJyc1d
         ejYWhFwlo45mo04EX9woXJx9Ib15N6eJnXEmjmu6AxuNpFcbj4cdd+4jpns2aPAU6EQc
         6E7d2oBlM7j56G4tRRiZbmLuUvWjo8H/gqnUQSCTqUtYHGLSb7SC5/RBNiC2llvl6m4u
         nkFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4xVKoJiuE+bG4yZhXIgFgzCVb9JmdizC4J8A34JkEnlc2uLLthniSEUfPJOwHM4succmhg97RhzE4fMPLwk2eB6bau9FYq20=
X-Gm-Message-State: AOJu0Yxava1wLTAJ9KaNWPAZtqgmq/AdtwcVgXYZP6Ld9lnaTqydgBQu
	yjCSjXStbuGgyGpoqKVt3YnBmu1ICNvABl4XFGb8sAtZgzcGJZuBb5tJDICUeC8=
X-Google-Smtp-Source: AGHT+IEP56pHbP4DCZFL0TzwnwRKdgriFsrjpsNp9TvUXF81k3NcrKi5DJQNSBnNphOP/g4IRsep+w==
X-Received: by 2002:a05:6512:6d2:b0:52c:84d1:180e with SMTP id 2adb3069b0e04-52e827344e4mr7597722e87.67.1720003616744;
        Wed, 03 Jul 2024 03:46:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b263sm2093468e87.268.2024.07.03.03.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:46:56 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:46:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, angelogioacchino.delregno@collabora.com, 
	andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	ilia.lin@kernel.org, rafael@kernel.org, ulf.hansson@linaro.org, 
	quic_sibis@quicinc.com, quic_rjendra@quicinc.com, quic_rohiagar@quicinc.com, 
	abel.vesa@linaro.org, otto.pflueger@abscue.de, danila@jiaxyga.com, 
	quic_ipkumar@quicinc.com, luca@z3ntu.xyz, stephan.gerhold@kernkonzept.com, nks@flawful.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 01/10] soc: qcom: cpr3: Fix 'acc_desc' usage
Message-ID: <u4hzxnecdyow6h4vhddcp53tuxrqhbqu6cv4cznytihsyshzy4@lqxhsn3qvjbz>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703091651.2820236-2-quic_varada@quicinc.com>

On Wed, Jul 03, 2024 at 02:46:42PM GMT, Varadarajan Narayanan wrote:
> cpr3 code assumes that 'acc_desc' is available for SoCs
> implementing CPR version 4 or less. However, IPQ9574 SoC
> implements CPRv4 without ACC. This causes NULL pointer accesses
> resulting in crashes. Hence, check if 'acc_desc' is populated
> before using it.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Undo the acc_desc validation in probe function as that could
>     affect other SoC.
> ---
>  drivers/pmdomain/qcom/cpr3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
> index c7790a71e74f..6ceb7605f84d 100644
> --- a/drivers/pmdomain/qcom/cpr3.c
> +++ b/drivers/pmdomain/qcom/cpr3.c
> @@ -2399,12 +2399,12 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
>  		if (ret)
>  			goto exit;
>  
> -		if (acc_desc->config)
> +		if (acc_desc && acc_desc->config)
>  			regmap_multi_reg_write(drv->tcsr, acc_desc->config,
>  					       acc_desc->num_regs_per_fuse);
>  
>  		/* Enable ACC if required */
> -		if (acc_desc->enable_mask)
> +		if (acc_desc && acc_desc->enable_mask)
>  			regmap_update_bits(drv->tcsr, acc_desc->enable_reg,
>  					   acc_desc->enable_mask,
>  					   acc_desc->enable_mask);

Should the same fix be applied to other places which access acc_desc?
For example cpr_pre_voltage() and cpr_post_voltage() which call
cpr_set_acc()?

-- 
With best wishes
Dmitry

