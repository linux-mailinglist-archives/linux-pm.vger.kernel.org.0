Return-Path: <linux-pm+bounces-9727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E13911A91
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 07:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F961F2563B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 05:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F301422D6;
	Fri, 21 Jun 2024 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FByPLpwk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952912C7F9;
	Fri, 21 Jun 2024 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948717; cv=none; b=ezE5f7XtlpbLsJwLZvBA1Kdb2lNQzB0UtQJd3Xs6dRV61bputtLaxELaNe3uo5xazIGtVMnnCPRmYqtZauivdRHikuKwBELVzibYg3cEzSHMVPBtOMD78LF4r3euaINrQCKwUTwvBALH2ywy2zzAyupl5gyeX2Iy98XiNzC/o/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948717; c=relaxed/simple;
	bh=h5D18kB/jJ92V9TMO/5fhp21VV4JzGcvLvRCpsgdkQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZzaISNXkiFwOKMIKpKZTQLhzWFkWZIByDcC4yZX5xEUerq1PmSRobOhw3QqLYSDyG3BOU70yocfCuotLHZwexMwXIaHilH+mIm3d7O5JJUEmPR62NW2BcLTpgkb/duOeji+fAQqXmG63qzni5f1PbZL984EvQWoTPYo9QTE3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FByPLpwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271C8C2BBFC;
	Fri, 21 Jun 2024 05:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948717;
	bh=h5D18kB/jJ92V9TMO/5fhp21VV4JzGcvLvRCpsgdkQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FByPLpwkqnhIX2qh0PzKcNtRAh7HHeQhNhg5LjlvwtVeQypznKWAn9A93W7c3oQc5
	 /Z9AicwJAVWHuuXljtbN/GxMoXFeEi1QMXMIWI4BtzdqR9+cPGih2aAQTerFXk3p6l
	 40NHPSftykwyTq64CgbXYHBL8vciwqzDoMPcPhL1q1dlwMqkWNp2SUQkv8P95ZBSao
	 zPOSumIY6Nkb1gR23gLZmHpq0nEctPZHujQNEsLmgNJ/3ThBU4gd2ZpAXRcOhxUhVK
	 5kqFZ7SLJ1Fc93uD6/LU9ifM6dwZSxHqvv7Ys5fteuv1KpApkJyxxmSbkW0TGGrRPF
	 VrWODNPreVT5g==
Date: Fri, 21 Jun 2024 00:45:14 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: konrad.dybcio@linaro.org, djakov@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org, 
	dmitry.baryshkov@linaro.org, abel.vesa@linaro.org
Subject: Re: [PATCH V2 2/3] soc: qcom: icc-bwmon: Allow for interrupts to be
 shared across instances
Message-ID: <vjes4lm3um44f6oguvrq3gozemquzmmmicj47ieczwfuqkmaqp@aby3dj6ttdig>
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

In an effort to educate the reader, could you please describe what the
race condition is here.

It would also make sense to break this ("Handle...") into a separate
paragraph.

Regards,
Bjorn

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
> +	free_irq(bwmon->irq, bwmon);
>  }
>  
>  static const struct icc_bwmon_data msm8998_bwmon_data = {
> -- 
> 2.34.1
> 

