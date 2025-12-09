Return-Path: <linux-pm+bounces-39346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F81CB0074
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 14:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90E91300AB3C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7C125CC79;
	Tue,  9 Dec 2025 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="JGLBbjve"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5AB1E8320;
	Tue,  9 Dec 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285963; cv=pass; b=bk4I70za8gvokFZpIxqF9sbOsrGyiHrDB4Xrej1Lath+cvfo+tj6DsDCfMyd0Jj4kOW+NogcQMcSI8M5rQwzEeMjR9bqfImG6jerXoswkFALlVA82bawvptdQCfz1YFB+D7RuOKhFxwutmva+YG94eBqDQ/UM03kn1AsRIEACLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285963; c=relaxed/simple;
	bh=g699DPFpSnMtTBFm3CgRVNNtybmisc2LrnZs94GZW8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaLYynT5++3yU5hmhiOuIJqV37u7zOl4Wro9dOx2e2CoiqeW6VTrX8Vmf19aL41prdNuZrj/EuO+0mpRy34Zy1z+/ubojWIY+o2Wj8yd2sw01warpLh17Ny8WG5VW1AJdkkj6Vsp6ft2vnPwQwKnIUdl0xS3VXUz91m5Y34uc10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=JGLBbjve; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1765285953; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EP3gl1HtjAikaBh1CO1Kep2Nj3jc9FjNjGtFwUKAty72pa0fpCk/WPXupo5dL550hI88HkOEcF9gPykS/vGSaWJJuz34lT4E13IxpZO58HaLT9+CHTqyVQx3QKRVI/g/ZyG2pDNCQggcphonRxtJUdpaLcrKNPH9p55qCdbB8F0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765285953; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f1mS5C1si6nIV3IMrI1+Ba/oe6Jwxki2TBn7BTMbMCk=; 
	b=DvEdcl3asa9wBqpMIeGilHm7Y5gx24RxdSFUQt4SshWTwYUUDpsVa3xhATzpQ255FPq3bhUlnuIzgBhS1dZcInAT5USq/Ge0hjbVtB4r8ncA6GQ5qqCCvnre2F5bPU2ElXeDWvaqpP6+BjhvM7SdHXRunVFIA/PObCSgOWsC+iw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765285953;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=f1mS5C1si6nIV3IMrI1+Ba/oe6Jwxki2TBn7BTMbMCk=;
	b=JGLBbjveMVT1J09F5GULTP1n3QWA7Aph2VwQtiuOkDdJSEoc6xAeqcYoTSkhjcpY
	YkqvFZFaHg2Xh3Y+YN9qH9sDi+oHH9lUi3YRBPIR9yrRxmBaP19uCqNjP+7Noqqy+/t
	v2+6NqZ9aOdgXzudM9ORbBy50I7rbdL2KCFbfs8c=
Received: by mx.zohomail.com with SMTPS id 1765285950647233.28454600518887;
	Tue, 9 Dec 2025 05:12:30 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 9ED15180580; Tue, 09 Dec 2025 22:12:22 +0900 (JST)
Date: Tue, 9 Dec 2025 22:12:22 +0900
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: ulf.hansson@linaro.org, heiko@sntech.de, 
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON
 before regulator ready
Message-ID: <nokcp3ky37sdonx2kaqnmtr2pdqwoifrtpam7tqqygldl32tec@y2p3tcnd3bxa>
References: <20251205064739.20270-1-rmxpzlb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205064739.20270-1-rmxpzlb@gmail.com>
X-ZohoMailClient: External

Hi,

On Fri, Dec 05, 2025 at 02:47:39PM +0800, Frank Zhang wrote:
> RK3588_PD_NPU initialize as GENPD_STATE_ON before regulator ready.
> rknn_iommu initlized success and suspend RK3588_PD_NPU. When rocket
> driver register, it will resume rknn_iommu.
> 
> If regulator is still not ready at this point, rknn_iommu resume fail,
> pm runtime status will be error: -EPROBE_DEFER.
> 
> This patch check regulator when pmdomain init, if regulator is not ready
> or not enabled, power off pmdomain. Consumer device can power on it's
> pmdomain after regulator ready
> 
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 1955c6d453e4..bc69f5d840e6 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -659,6 +659,11 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>  	return ret;
>  }
>  
> +static bool rockchip_pd_regulator_is_enabled(struct rockchip_pm_domain *pd)
> +{
> +	return IS_ERR_OR_NULL(pd->supply) ? false : regulator_is_enabled(pd->supply);
> +}
> +
>  static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
>  {
>  	return IS_ERR_OR_NULL(pd->supply) ? 0 : regulator_disable(pd->supply);
> @@ -861,6 +866,15 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>  		pd->genpd.name = pd->info->name;
>  	else
>  		pd->genpd.name = kbasename(node->full_name);
> +
> +	if (pd->info->need_regulator) {
> +		if (IS_ERR_OR_NULL(pd->supply))
> +			pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
> +
> +		if (!rockchip_pd_regulator_is_enabled(pd))
> +			rockchip_pd_power(pd, false);
> +	}

It is extremly unlikely, that you will be able to get the regulator
at driver probe time. The typical regulator for NPU or GPU is
connected via SPI or I2C, which will only be available after the
power domain driver has been probed. So I suppose this could be
simplified as:

--------------------------------------------
/*
 * power domain's needing a regulator should default to off, since
 * the regulator state is unknown at probe time. Also the regulator
 * state cannot be checked, since that usually requires IP needing
 * (a different) power domain.
 */
if (pd->info->need_regulator)
    rockchip_pd_power(pd, false);
--------------------------------------------

I think the proper fix would be to add support for registering the
regulator needing power-domain's delayed and then enforce requesting
the regulator at probe time. That's not trivial to implement, though.

Greetings,

-- Sebastian

> +
>  	pd->genpd.power_off = rockchip_pd_power_off;
>  	pd->genpd.power_on = rockchip_pd_power_on;
>  	pd->genpd.attach_dev = rockchip_pd_attach_dev;

