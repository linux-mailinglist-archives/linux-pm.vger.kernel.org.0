Return-Path: <linux-pm+bounces-12951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FF896067D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A77287D89
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2A819AA46;
	Tue, 27 Aug 2024 09:59:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5A1465AC;
	Tue, 27 Aug 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752774; cv=none; b=vFXPjFDiqQ/xYxZyj/3XUQGogYEjCXgCFryLVpEIEPVGbYFOk+HVXuYUxZUGQacSBlLNP2MEc67SOpdmHjDkv0fDD8/gIqK/QcofWy+EiIhYBR19k6vyadGT+mtrAjBqb071HUMD49MustmPAYlbxlNV5WKSyihglsIvJbnk3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752774; c=relaxed/simple;
	bh=rtdaZNORUcVPjsi7s+VtSTMyfcWESUFzfJ5Zzi7PG3k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIXJUacdVrnM9oCd5vKpmheVSYpinyG/HK5d0HieNSz7mKKBACMMC5ySUyRcv6A8GKv+P0ym6OkUIlRnt6snV2Ogy/eCUBzTkmcNaLsZuwVkgGpGiyAKkT3Dn3/B/KHh6mLc7jDIA9jY8V1oJqXLO40Zc8Gcnre4R/QrMP8WKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtNFv32sdz6J6xg;
	Tue, 27 Aug 2024 17:55:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BCCF140447;
	Tue, 27 Aug 2024 17:59:29 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 10:59:28 +0100
Date: Tue, 27 Aug 2024 10:59:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konradybcio@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-msm@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 02/10] pmdomain: rockchip: Simplify locking with guard()
Message-ID: <20240827105927.00007ac7@Huawei.com>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-2-8320722eaf39@linaro.org>
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
	<20240823-cleanup-h-guard-pm-domain-v1-2-8320722eaf39@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 14:51:06 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Simplify error handling (smaller error handling) over locks with
> guard().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Musing inline.

LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 5679ad336a11..538dde58d924 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -910,7 +910,7 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
>  	 * Prevent any rockchip_pmu_block() from racing with the remainder of
>  	 * setup (clocks, register initialization).
>  	 */
> -	mutex_lock(&dmc_pmu_mutex);
> +	guard(mutex)(&dmc_pmu_mutex);
>  
>  	for_each_available_child_of_node_scoped(np, node) {
>  		error = rockchip_pm_add_one_domain(pmu, node);
> @@ -943,13 +943,10 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
>  	if (!WARN_ON_ONCE(dmc_pmu))
>  		dmc_pmu = pmu;
>  
> -	mutex_unlock(&dmc_pmu_mutex);
> -
>  	return 0;
>  
>  err_out:
>  	rockchip_pm_domain_cleanup(pmu);

I wonder.  Could you use a devm_add_action_or_reset for this and allow early
returns throughout?

Would need to take the lock again perhaps and I haven't checked if there
is any issue in dropping and retaking the mutex however.
The block logic is non obvious so I couldn't quickly figure this out.
 
> -	mutex_unlock(&dmc_pmu_mutex);
>  	return error;
>  }
>  
> 


