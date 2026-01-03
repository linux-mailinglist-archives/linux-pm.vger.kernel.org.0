Return-Path: <linux-pm+bounces-40151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 796ADCF0151
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 15:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CECA300B920
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC8930CD8F;
	Sat,  3 Jan 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2Yh5lya"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728983FF1;
	Sat,  3 Jan 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767452192; cv=none; b=iZL2PObFzPD0fM55PwAeT7xOPBTa4msMp4VruLKgeWRYFZHSgicQZaKqrOqFxvtBLOJcGmDk2rQQn94W5eaPY3Rfx5z7corm/QpXq1N9XJWnldzJ2zH/m8AaHhg6Akvn2Y1Ftp7/m+gdzcfngXM/6+8aTzwTx959o/ELeSnzA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767452192; c=relaxed/simple;
	bh=x2QN1I4wepPchqVnDuJiY1AyTZaeb/D3c4nw1BGU+Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXD8T7EutF6PAtQjsIc0cy+QJOJPF80QQkENKoRzM3GzARARmaNxdvkDCLmqgjsQQQThQWGSz2xgDW4AgkBgY2wjn4CNfv5PXJKQ+CzxUqDvStJLtgrh4aZzLWHZ//rkc4oZR7LBBl0oRlyjA7STfOPEuUCh8ArAvwbipEMBouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2Yh5lya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019F6C113D0;
	Sat,  3 Jan 2026 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767452192;
	bh=x2QN1I4wepPchqVnDuJiY1AyTZaeb/D3c4nw1BGU+Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2Yh5lya7TE0mR+nRdKnEqfkYGsNTvxJu5vljye/vREK0/v7Y31scMSRR4ldBC/Ww
	 32VdwyzdqEsyL7FayJjUhQHgmR6MYCvIiSNw6+/XwT+PRVw9C55CRdUyICMq3/e3iZ
	 44GpLdnVapZpz0g2pnPPYGFRhwy2vq5Vbhhg9uwynynu+8z9MuC7nbsZON+qOHYA4S
	 IiTKDsYNDvkbAamvpQHRKO8mU4aCuUK6ujBld8lmkbARZpnU+ecJDdPZEwoi/ogaRS
	 NJ59/vtrVsC730X6ovaheh52g/b/AuQGPlO9EqfBAHCSfi6nU4ev0pJAFeuNuOBJZ3
	 nJiIbAzFVrZrQ==
Date: Sat, 3 Jan 2026 08:56:27 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org, amitk@kernel.org, 
	mani@kernel.org, casey.connolly@linaro.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/8] remoteproc: qcom: probe all child devices
Message-ID: <evb5tn2cht7wk76fuc2wpsyxepknigfw37633n6ypuapstbceh@tn5glmi65bdv>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-3-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223123227.1317244-3-gaurav.kohli@oss.qualcomm.com>

On Tue, Dec 23, 2025 at 06:02:21PM +0530, Gaurav Kohli wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Generalise the qcom,bam-dmux child node support by probing all
> remoteproc children with of_platform_populate(). This will be used to
> enable support for devices which are best represented as subnodes of the
> remoteproc, such as those representing QMI clients.

Please flip this around, start with the description of the problem
you're trying to solve.

> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>

This must have your signed-off-by, where you certifies the origin of
this patch.

> ---
>  drivers/remoteproc/qcom_q6v5.c     | 4 ++++
>  drivers/remoteproc/qcom_q6v5_mss.c | 8 --------
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 58d5b85e58cd..a02839c7ed8c 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2014 Sony Mobile Communications AB
>   * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
>   */
> +#include <linux/of_platform.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/interconnect.h>
> @@ -351,6 +352,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>  		return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
>  				     "failed to acquire interconnect path\n");
>  
> +	of_platform_populate(q6v5->dev->of_node, NULL, NULL, q6v5->dev);

There are other child nodes here, in particular the GLINK and SMD edges.
Do we really want platform_devices registered for them?

Regards,
Bjorn

> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(qcom_q6v5_init);
> @@ -361,6 +364,7 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_init);
>   */
>  void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5)
>  {
> +	of_platform_depopulate(q6v5->dev);
>  	qmp_put(q6v5->qmp);
>  }
>  EXPORT_SYMBOL_GPL(qcom_q6v5_deinit);
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 91940977ca89..d40565c1cc62 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -238,7 +238,6 @@ struct q6v5 {
>  	struct qcom_rproc_pdm pdm_subdev;
>  	struct qcom_rproc_ssr ssr_subdev;
>  	struct qcom_sysmon *sysmon;
> -	struct platform_device *bam_dmux;
>  	bool need_mem_protection;
>  	bool has_alt_reset;
>  	bool has_mba_logs;
> @@ -2029,7 +2028,6 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>  static int q6v5_probe(struct platform_device *pdev)
>  {
>  	const struct rproc_hexagon_res *desc;
> -	struct device_node *node;
>  	struct q6v5 *qproc;
>  	struct rproc *rproc;
>  	const char *mba_image;
> @@ -2163,10 +2161,6 @@ static int q6v5_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto remove_sysmon_subdev;
>  
> -	node = of_get_compatible_child(pdev->dev.of_node, "qcom,bam-dmux");
> -	qproc->bam_dmux = of_platform_device_create(node, NULL, &pdev->dev);
> -	of_node_put(node);
> -
>  	return 0;
>  
>  remove_sysmon_subdev:
> @@ -2186,8 +2180,6 @@ static void q6v5_remove(struct platform_device *pdev)
>  	struct q6v5 *qproc = platform_get_drvdata(pdev);
>  	struct rproc *rproc = qproc->rproc;
>  
> -	if (qproc->bam_dmux)
> -		of_platform_device_destroy(&qproc->bam_dmux->dev, NULL);
>  	rproc_del(rproc);
>  
>  	qcom_q6v5_deinit(&qproc->q6v5);
> -- 
> 2.34.1
> 

