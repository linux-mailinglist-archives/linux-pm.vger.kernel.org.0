Return-Path: <linux-pm+bounces-30872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223FB06300
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 17:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E715683A2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EB31925BC;
	Tue, 15 Jul 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpER6Ywk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960623D2AC
	for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593571; cv=none; b=TyPKqyQRcxh+yZRqvQENidWzNF5O82LuJGTPFQqO4uRU//LD+VyFYYluMzinesbXbfgw7TLZB0lR46QDp3SGCXA/7d8VRLyOlgyMjOMBwjwf9sEeBC6ESXBU3xMQNJbcarwqep83ksNVb7R/XM7PhBF0D6bN/gQDzXgxbPkOtvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593571; c=relaxed/simple;
	bh=qUHDQT2XageAU0kIkbMdtj4nwVZk54055G83360ZEYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo9dwIMmeIESobBMFl2MjelkYml+s/Re0gnE2VXXFvKl+GB14+nD51qjjabtOgA2YRJ3NJ2rdyA4Si4G0ZHXX+2K/CA1cdb2Wtysd27RhJe+FMP+brLlx1OxBpfWZac3qOWP45xdqmbZpdrCNuIkuicutqTC8hJ/lz6r16LBW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LpER6Ywk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234c5b57557so56702305ad.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752593568; x=1753198368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33yHY0U8ND4bNjhKpzusNE0usrblN+UAP92ijnAvwrA=;
        b=LpER6Ywkpzp3odZ3jSD6Ze2ve5LNucUm756K7LtGKO7RvKcBz9fvsZ5cFfDUIEynW4
         6mH+k3mm4KyOW/TGChu3rQUzDpD7RTXnVAYnWeKpjxJnTeilkcrHwsvgAvIEscmrHgQl
         mZnf7y9d/P/UcK+l2ZRwMoGmhfhVPh3M3NgFr7x5H5m2bE7loEiUKmSx0RxqxCK6LRMM
         j4NwIONNl24iAD5D15Ph9ij3WG4neTgIDnucbvRlCh4GZE/7eWpNvNxCRyUDYutCqk9b
         /FQsQgLLv36+iniId5VUULJPoc/Q74J9i7tCYnifkgsfNLOWmq2Rs25FA+Vc1M7PjlVY
         Pu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593568; x=1753198368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33yHY0U8ND4bNjhKpzusNE0usrblN+UAP92ijnAvwrA=;
        b=cuuFkpIBrKQltSrzYzPIaimTdSRdokt5qES38n508LML7PUsGlrPnaQ4iNy8o2JomL
         sDZwrHa8u8hyBSyE/ifWixOqCcfg+b60tmwgNR6HJPbUeRRz3egQd/kczAS6ArAaFgve
         oaNPLVjOwMoOJng6yCeKFbsuViLAf7xkwF5muS4p8ynQb9BN6g7J76MuS45ZEi9b0vbE
         yApj/0O61B2rVhzIsyTW3EFhMnNZBG7x+43rLgZgr2JCFFR30vrKUzuCShA7RMslM7FJ
         zBHDY3pzGhcamBM7OFIs3CMmn72gn6euX6q9/Th6J0A5czp6fBR3ioeuSS7je3NeytG6
         +qsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkugcJJgPGfJ6+VWB/NjuOEORGWGAmN/y6HKsJxZ/syohqhsQPg93W9tNZG8byLBkWxOfPtdgH8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhkTcIfIXMN+nSR9Eqbx+YAwV/RNdheGvjwvzJRW+E6mCtNHe
	YWfx4TKZ8HqHwIZVCW5xLP6EGCHy5lZLMsC2mLSVlMik6GbD7Ka6/hO6fagCqmA9T1g=
X-Gm-Gg: ASbGncuDlAJ4c6d/AKSkEDzAxJWimcE3uKTe0NhrReKqDtb1hYbl/Ur5C6xeEEDkqWU
	WAPtaBjdBnO4J+VZmu20X+21RRVBtT8N0aiOJGWbC2bNggYFdPjAXCoVsZf0H3abLMtzyqdkKqh
	WoeFpxqTuioTi6GAtUuUcCdhAdOgWYFhZWkCVbjeQ1j46Q5MDYhwB+mChAlZXnDQslErcQUOI/m
	AJKKqU0aNAl37RIrPW9KtYv/dVlXwKgSpItvYrGK9/l1xIzJW71k6cGCKImWxlDKybcoZ25PjW4
	CATpLX6PKid6DOobFkpEQwgQDC13n+5cQaq8WdxdjHqRL24lhPA0fK88W5DwfPQVw19iceMdV+L
	ADHmLUYYzyZ7aIvgY4S+QreIt
X-Google-Smtp-Source: AGHT+IHkJUK5ENBeylJNtS4qtHpCbavXcR17LDaafdWZuI5joLSCqs8sTEoGsBj18ccUt3gtd70HMA==
X-Received: by 2002:a17:903:2c8:b0:237:d25b:8f07 with SMTP id d9443c01a7336-23dee0d7c54mr275182995ad.44.1752593567667;
        Tue, 15 Jul 2025 08:32:47 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3f17:6d67:cf82:708])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4323cd5sm110969645ad.126.2025.07.15.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:32:47 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:32:44 -0600
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
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Message-ID: <aHZ0nK4ZZShAr6Xz@p14s>
References: <20250629172512.14857-1-hiagofranco@gmail.com>
 <20250629172512.14857-4-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629172512.14857-4-hiagofranco@gmail.com>

On Sun, Jun 29, 2025 at 02:25:12PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> When the Cortex-M remote core is started and already running before
> Linux boots (typically by the Cortex-A bootloader using a command like
> bootaux), the current driver is unable to attach to it. This is because
> the driver only checks for remote cores running in different SCFW
> partitions. However in this case, the M-core is in the same partition as
> Linux and is already powered up and running by the bootloader.
> 
> This patch adds a check using dev_pm_genpd_is_on() to verify whether the
> M-core's power domains are already on. If all power domain devices are
> on, the driver assumes the M-core is running and proceed to attach to
> it.
> 
> To accomplish this, we need to avoid passing any attach_data or flags to
> dev_pm_domain_attach_list(), allowing the platform device become a
> consumer of the power domain provider without changing its current
> state.
> 
> During probe, also enable and sync the device runtime PM to make sure
> the power domains are correctly managed when the core is controlled by
> the kernel.
> 
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
> v6 -> v7:
>  - Added Peng reviewed-by.
> v5 -> v6:
>  - Commit description improved, as suggested. Added Ulf Hansson reviewed
>    by. Comment on imx-rproc.c improved.
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
> index 627e57a88db2..24597b60c5b0 100644
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
> +	 * core is already powered up and running when the kernel booted (e.g.,
> +	 * started by U-Boot's bootaux command). In this case attach to it.
> +	 */
> +	for (i = 0; i < ret; i++) {
> +		if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> +			detached = false;
> +			break;
> +		}
> +	}

I was doing one final review of this work when I noticed the return code for
dev_pm_domain_attach_list() is never checked for error. 

Thanks,
Mathieu

> +
> +	if (detached)
> +		priv->rproc->state = RPROC_DETACHED;
> +
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

