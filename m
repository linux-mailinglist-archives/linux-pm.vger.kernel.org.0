Return-Path: <linux-pm+bounces-39288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E579CCABF36
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 04:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84193301AD12
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA37A1A9F9D;
	Mon,  8 Dec 2025 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="AGBNPbqC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m49234.qiye.163.com (mail-m49234.qiye.163.com [45.254.49.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845C15746E;
	Mon,  8 Dec 2025 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163892; cv=none; b=EUsIJILxjcAczGxRPaLcz+JnqMdyK7uqGVTZJJp3UDDGMbEffPb9RKZ4taigtCXo9n35Jwl7KJ9kFvUTbFD5y2gUwraZO4kHd7Vck+wHiD2kPx6t9fcQUuuM8vX6OI2J8AjCnPrpTMaUDHKJfGxbxgE34rdztPtaZNGsdBDQ+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163892; c=relaxed/simple;
	bh=S+IcUOBvLbr8FqeF25/8ppRr7rGC4zPMDi10TU5XdUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuxAJO/SJPqu6axnm9LOsHQ2cdCiEwE7G7z6Op6Uzeop/CkL9v7TSLHbxRzKMqljK7lxmnmwVeH3yi2SNp2rrnYAuLfEC4lBipOOCyoej5Pe4EdZtzDq/YvGRnpjalVafBJXmU6NBfXZkW8lX9ivtoIMOpTVvKws78gUKdSU02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=AGBNPbqC; arc=none smtp.client-ip=45.254.49.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.51] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2c55f01cb;
	Mon, 8 Dec 2025 11:17:59 +0800 (GMT+08:00)
Message-ID: <27dff4a5-1e9d-458d-936a-941c3f10c139@rock-chips.com>
Date: Mon, 8 Dec 2025 11:17:56 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON
 before regulator ready
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: ulf.hansson@linaro.org, heiko@sntech.de,
 Quentin Schulz <quentin.schulz@cherry.de>,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251205064739.20270-1-rmxpzlb@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20251205064739.20270-1-rmxpzlb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9afbf74a8003abkunm5f783d0527a9bb2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhkZQlZCHx4fTRgdSUNNH0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=AGBNPbqC2bNDmPm7K0v/fuotV9dWhP34C9k6XFs0UxgTlVR0ZgpTogpHzatNY5iVXPAKXBO26ueuwrHui7Mtsf9GYPD+W8644XOs2H0u8fMMgDbBcx3PCXmbi1myE8KsN2LMw2kvfzhO9ctVpkQWQgCYnSHttxxr2vMgtAkTmc4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=1Hv4tC4zreaZB0KkuD0NA2HKLqwbNxwKjVQcNBrPpT4=;
	h=date:mime-version:subject:message-id:from;

On 12/5/2025 2:47 PM, Frank Zhang wrote:
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
> +
>  	pd->genpd.power_off = rockchip_pd_power_off;
>  	pd->genpd.power_on = rockchip_pd_power_on;
>  	pd->genpd.attach_dev = rockchip_pd_attach_dev;
> 

@Quentin, Could you please try this patch? This should resolve the
problem you're currently facing where the NPU fails to work in
built-in module.

Tested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>

-- 
Best, 
Chaoyi

