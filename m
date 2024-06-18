Return-Path: <linux-pm+bounces-9500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E8490DBF2
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 20:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23A0B215F3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F3D15ECD1;
	Tue, 18 Jun 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXqAQtuz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA715E5CA
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736912; cv=none; b=g3q9gt3wsyAjk0/ZgP2s/yay8dbC8zLf2o9gF9fPietlSu881IuqqvNxYeLI8MaHQVQEG51fnEeZT7zMOY5BmrNh9k7eb/D+aq/aKNAtZHjjCkDft+eXzjXtC60WS3aKIsqY0XN/FBs+b0JRKA9JeZwCPhiSys0vCdBCK6iGe54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736912; c=relaxed/simple;
	bh=UNFVAPuelWNv7Oeq53TScOsxnOnzZlhh3VXd9HNUGyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJMJ9fXK5JEAQlpUwL3c8RhEtETojg7qC52D1QGiPr0UA0VrJ22W93uZwCKc+o9LaFW1gxAmi/THZloqnz0Q60TYNO3ylddl/U9z/GUZbfaiuFlLXX2/AnzVS+oG8yuUCR2qpFaq739doNaNodNXnDLPbfLttM3NemCHMODL3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HXqAQtuz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c84a21c62so6344021e87.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718736909; x=1719341709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27ULhBa6NF2Bs7Hi7tIhonbGGD8DbNJDz+k7oeA0y6Q=;
        b=HXqAQtuzqclHE1Tfkp579HcGaaZZgFwRzxX+H9pRdanvcbtAIVifU2Z88Rq+hwsvjV
         +GibgBYgwYPW1fvdh9GjD4GWidl4cRK7Xf4wf8TVPUcvTAUZNMNBkEshb0uwMPnZc1Tt
         g9m9xEfSYyqKv4GseAvLWWCiSPcsi75nl8zXWzolwuxVJc+q0GO7z6VNC31hz8GAmO4t
         GomLe0Pf8GKPRLmPLKfmEWX7a2uWcKL9UgoQuFyoH2DWDD2e9XgawG163+urz7T4s2Jk
         qcfuQNmSjyqyyUXvuW1aPYe5hDdGCwsy03JN4keGE7liR/FfmE6DwidjlRuUgs8pM6jr
         ABpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718736909; x=1719341709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27ULhBa6NF2Bs7Hi7tIhonbGGD8DbNJDz+k7oeA0y6Q=;
        b=nHay/OCbQEXZbHzNagGzYKuZKZkjrx1dLUhs7yAB7GUzRIgx5jZJNb1ww0W3Q9heoJ
         J7zX9+Z6atAp6bA17rS7Lxo052HwHQJlokXE50CRPEoAfCO9ffyM1Bdu2yW4dV/w/Zhs
         RLCAVFjrC/ZZlPYmx4vG0kkq+9n67BnRRZ/bHO8sEt5PVKdzwHPqjvG0ZYl5nJAl6nEO
         iVC54/Ap9I4+EO0QMOdkvU4ly+xCeN3XZCnJ/i3Tz/0r3V0S9kZL1m3AM9kMlrf1qV79
         xQ69Ham0BbLfueP/xj0/7Zdh5V3P7kwfAGlzPpBmnKDue9BjIMtmaqN9f0Gw9bSxTqkA
         I/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXRwfVi/tyVK9pJkYTZPvMNQq206kslqg0ClsK0Pnl5K3DG1e67GgEPdze5murmUZqq+A1LQYB/Rrg8he3StZ+AXoEVuI29XPI=
X-Gm-Message-State: AOJu0YzNSwDCq/i16ygZK8yRhXbjt48+0BRwzhphCn2mWs2HwxEw/U/t
	TjoOI26KNbfd9XMrSXg/ikEw3ECtkMoDSbvu+CYQp/WinY4vABQu+C+KZlf0Fms=
X-Google-Smtp-Source: AGHT+IF2Xuc+j5GQniwyckTVq0FVa/bh12Lgiw0qNMq3HIEExse2nNOx3fGWmOmKvYSecoALF0y/9Q==
X-Received: by 2002:ac2:5974:0:b0:52c:8009:e0cb with SMTP id 2adb3069b0e04-52ccaa62705mr256788e87.41.1718736908660;
        Tue, 18 Jun 2024 11:55:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f1dbsm1578550e87.110.2024.06.18.11.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 11:55:08 -0700 (PDT)
Date: Tue, 18 Jun 2024 21:55:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, quic_rgottimu@quicinc.com, 
	quic_kshivnan@quicinc.com, conor+dt@kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH V2 2/3] soc: qcom: icc-bwmon: Allow for interrupts to be
 shared across instances
Message-ID: <d4f3rlk3jgqegxvto2b6vyemspommtsbs3ixqgan2rmknet3je@ohonicqa2iqy>
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
 <20240618154306.279637-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618154306.279637-3-quic_sibis@quicinc.com>

On Tue, Jun 18, 2024 at 09:13:05PM GMT, Sibi Sankar wrote:
> The multiple BWMONv4 instances available on the X1E80100 SoC use the
> same interrupt number. Mark them are shared to allow for re-use across
> instances. Handle the ensuing race introduced by relying on bwmon_disable
> to disable the interrupt and coupled with explicit request/free irqs.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v2:
> * Use explicit request/free irq and add comments regarding the race
>   introduced when adding the IRQF_SHARED flag. [Krzysztof/Dmitry]
> 
>  drivers/soc/qcom/icc-bwmon.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index fb323b3364db..4a4e28b41509 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -781,9 +781,10 @@ static int bwmon_probe(struct platform_device *pdev)
>  	bwmon->dev = dev;
>  
>  	bwmon_disable(bwmon);
> -	ret = devm_request_threaded_irq(dev, bwmon->irq, bwmon_intr,
> -					bwmon_intr_thread,
> -					IRQF_ONESHOT, dev_name(dev), bwmon);
> +
> +	/* SoCs with multiple cpu-bwmon instances can end up using a shared interrupt line */

... using devm_ here might result in the IRQ handler being executed
after bwmon_disable in bwmon_remove()

> +	ret = request_threaded_irq(bwmon->irq, bwmon_intr, bwmon_intr_thread,
> +				   IRQF_ONESHOT | IRQF_SHARED, dev_name(dev), bwmon);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to request IRQ\n");
>  
> @@ -798,6 +799,13 @@ static void bwmon_remove(struct platform_device *pdev)
>  	struct icc_bwmon *bwmon = platform_get_drvdata(pdev);
>  
>  	bwmon_disable(bwmon);
> +
> +	/*
> +	 * Handle the race introduced, when dealing with multiple bwmon instances
> +	 * using a shared interrupt line, by relying on bwmon_disable to disable
> +	 * the interrupt and followed by an explicit free.
> +	 */

This sounds more like a part of the commit message. The comment before
request_threaded_irq() should be enough.

> +	free_irq(bwmon->irq, bwmon);
>  }
>  
>  static const struct icc_bwmon_data msm8998_bwmon_data = {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

