Return-Path: <linux-pm+bounces-29360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577BAE48AC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB42917E515
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBB628DEFA;
	Mon, 23 Jun 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmsz0fG1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30328D8D9
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692593; cv=none; b=q36FifEYSSs2HKIXMcTtsOLo7nv0Htb/xo5sefoqQur3kNrhJpWYxopPRB4Kw/Gk0mvp4OOkACOLqxyavIxiBGQwEVytPxwsPb58vz9/mZdlUmZvaaeLa7aMPXj20sAEj6Hhh7HQRMHZdpFtY4bpI9V7HCGq6TZ3HuS1jjMOKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692593; c=relaxed/simple;
	bh=rvlexOk2KxBUOGBjG89VU+HC4brRNmm9u14ZwZa9zuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB0m0I8eKGvyxsSj1ML/69bo3n69WtEsi1K2nRgm89X7ralawcHFMQwrwQB06qIoPg3XH5XxKZz5p4FsIBvcWetkrRMmHyvJHUXZa5w4c3N2NJbf5I5QePdzG8k6mxd7WVir2EhKjdI3Qs0jK+4l9fJMrJLNDhH44Q/PJWQRRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cmsz0fG1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234f17910d8so38366935ad.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750692591; x=1751297391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jAVqu/xxn5U99+rZ3TEpqjiwAM44h/eW9lw9VkDNhA=;
        b=cmsz0fG1MEpkD4+3zUVSaoPiglOu2d6FKV1k1BLSJfa8CyaqYNfLBp/3iB/MboJjnG
         4uogqpEL/Wg9a/cXazouEOGkuVyHzFuHNI73HJxdwIsc6aiX27xwyyZz1dXP/9tLz/6P
         /CiACCtg1UcZRxqsFlQKJt+dHC30EFW8F4+Q0LnddixxgqsMbIupQ/SSD5T/K97Uk/dT
         kGQIgoRvjjt6P5m/mITwYUhT2yxDhfWkAKbBHh6YXY5Rgag925OrA8JHJgUpQBBaIZ7S
         S9CbxcEnLMfwcl3o7LDl9YMLiMS8s6rwDA8g2ZGBTM/jlzAo3Lur6My3rXobCOfQsv4T
         UlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692591; x=1751297391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jAVqu/xxn5U99+rZ3TEpqjiwAM44h/eW9lw9VkDNhA=;
        b=k3e71BMMFB5Nx6CgDWeY5/OE2lcqZfP+iRMQGmHCiJAH9n5ZtDKkim1eF8nOcrbMm6
         wXmS3seSEBEf5HMihVPW8Pblg2+gJ948IOHb/nQwtZRYtk8RaWgpxZ3dRrQvasseGzYX
         tqR47DxViGw5Q6hNtoRvzdUQpaA+Yin/G9U5UDf2JFDLmMhSpuoHCwc5FnH52TZpSSUf
         jwYngY1bwoyRcIXGBblvP++8Brh9fhbjhEJJD6Qv9QtC0JXAtPOePb2b3dHsZVcTZVZj
         j8nZCImOZwj/VWX/2U8A12EIiiCQza7spsHe3DZjNSpPcmvtt8TtSCvB0k5MpZRhOAVF
         4b0g==
X-Forwarded-Encrypted: i=1; AJvYcCUtDk316NVFdAWK6bNjebp6sosJcdJRmI4ZRy5hQ9CS+4zVbQcUXzjiMzgJi6wvgUej8qSBtCslHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWeu6yhu6KKMTYeOM6g9L/gY7PSwwsGshj2eQHkM2EXduBQyA
	441jn8wa4CCTaaV81Jr47uJCLOD7uEViBQBmUI5urKl4Ceg4UNro30MbJcwfvjKN73E=
X-Gm-Gg: ASbGncupsfpDhPt0qtGEBinghUYuobWHgMalKY+X34ur38D7F6rES5IlKB7VMvD2Gaw
	gKYvQ4/oVCqiRkrvYeYcem0Aax9nDz8sNTd0i7g7zXj89hA37qiQELnruAiva3sTuWSbfygfRj6
	vZ6/S42WTWZ5Ekp3+4DmEFzs/qVzJ6G1vMJl1CMkO+oAYeL25Mfl3KN68aHXFg+2q5mYr6Z/efn
	aoK7zA3ByvZX9acc6gbJnofUJ232B3nRXLiBn9GU5etMQG2DcgWTdH2lSLDF5QrhrTeIOuw+eDl
	krGpDr8nYhbt3hG8/3kdwbUB64Pus/5hq9VTVWI3wsD2AAm+kmRB0SbAtq1g8KMJG3s01jra5P4
	=
X-Google-Smtp-Source: AGHT+IE/tDEriXoZY84SIRgiQjRfx7Nqv/jCO1aRGKRzkXGAXMW0IvvtgLzNFd2r0jGkIlFdCJKogw==
X-Received: by 2002:a17:902:d501:b0:235:f3df:bc26 with SMTP id d9443c01a7336-237d976311fmr188832525ad.3.1750692590758;
        Mon, 23 Jun 2025 08:29:50 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d145:b99:ea4b:a65f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12427cdsm7052225a12.39.2025.06.23.08.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:29:50 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:29:47 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Message-ID: <aFly61yCMttkp12e@p14s>
References: <20250617193450.183889-1-hiagofranco@gmail.com>
 <20250617193450.183889-4-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617193450.183889-4-hiagofranco@gmail.com>

On Tue, Jun 17, 2025 at 04:34:50PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> When the remote core is started before Linux boots (e.g., by the
> bootloader), the driver currently is not able to attach because it only
> checks for cores running in different partitions. If the core was kicked

Again, we have a nomenclature issue here with "If the core was kicked by the
bootloader".  What does "kicked" mean here?  Is it just powered and held in
reset or is it executing.  And are you referring to the A core or the M core?


> by the bootloader, it is in the same partition as Linux and it is
> already up and running.
> 
> This adds power mode verification through dev_pm_genpd_is_on(), enabling
> the driver to detect when the remote core is already running and
> properly attach to it if all the power domain devices are on.
> 
> To accomplish this, we need to avoid passing any attach_data or flags to
> dev_pm_domain_attach_list(), letting the platform device become a
> consumer of the power domain provider. With that the current power state
> of the genpds will not change, allowing the detection of the remote core
> power state.
> 
> We enable and sync the device runtime PM during probe to make sure the
> power domains are correctly managed when the core is controlled by the
> kernel.
> 
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
> v4 -> v5:
>  - pm_runtime_get_sync() removed in favor of
>    pm_runtime_resume_and_get(). Now it also checks the return value of
>    this function.
>  - Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove()
>    function.
> v3 -> v4:
>  - Changed to use the new dev_pm_genpd_is_on() function instead, as
>    suggested by Ulf. This will now get the power status of the two
>    remote cores power domains to decided if imx_rpoc needs to attach or
>    not. In order to do that, pm_runtime_enable() and
>    pm_runtime_get_sync() were introduced and pd_data was removed.
> v2 -> v3:
>  - Unchanged.
> v1 -> v2:
>  - Dropped unecessary include. Removed the imx_rproc_is_on function, as
>    suggested.
> ---
>  drivers/remoteproc/imx_rproc.c | 37 +++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 627e57a88db2..b53083f2553e 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
> @@ -890,10 +891,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
>  static int imx_rproc_attach_pd(struct imx_rproc *priv)
>  {
>  	struct device *dev = priv->dev;
> -	int ret;
> -	struct dev_pm_domain_attach_data pd_data = {
> -		.pd_flags = PD_FLAG_DEV_LINK_ON,
> -	};
> +	int ret, i;
> +	bool detached = true;
>  
>  	/*
>  	 * If there is only one power-domain entry, the platform driver framework
> @@ -902,7 +901,22 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
>  	if (dev->pm_domain)
>  		return 0;
>  
> -	ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> +	ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> +	/*
> +	 * If all the power domain devices are already turned on, the remote
> +	 * core is already up when the kernel booted (e.g. kicked by the
> +	 * bootloader). In this case attach to it.

Same comment as above.  What got kicked?  A core or M core.  And what does
"kicked" mean?  I can guess what is happening but guessing rarely leads to
anything positive.

In the next revision, please use other words than "kicked".


> +	 */
> +	for (i = 0; i < ret; i++) {
> +		if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> +			detached = false;
> +			break;
> +		}
> +	}
> +
> +	if (detached)
> +		priv->rproc->state = RPROC_DETACHED;
> +

Ok for the above.

>  	return ret < 0 ? ret : 0;
>  }
>  
> @@ -1146,6 +1160,15 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (dcfg->method == IMX_RPROC_SCU_API) {
> +		pm_runtime_enable(dev);
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret) {
> +			dev_err(dev, "pm_runtime get failed: %d\n", ret);
> +			goto err_put_clk;
> +		}
> +	}
> +
>  	ret = rproc_add(rproc);
>  	if (ret) {
>  		dev_err(dev, "rproc_add failed\n");
> @@ -1171,6 +1194,10 @@ static void imx_rproc_remove(struct platform_device *pdev)
>  	struct rproc *rproc = platform_get_drvdata(pdev);
>  	struct imx_rproc *priv = rproc->priv;
>  
> +	if (priv->dcfg->method == IMX_RPROC_SCU_API) {
> +		pm_runtime_disable(priv->dev);
> +		pm_runtime_put(priv->dev);
> +	}
>  	clk_disable_unprepare(priv->clk);
>  	rproc_del(rproc);
>  	imx_rproc_put_scu(rproc);
> -- 
> 2.39.5
> 

