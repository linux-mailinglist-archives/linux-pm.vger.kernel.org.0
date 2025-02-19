Return-Path: <linux-pm+bounces-22404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDCCA3BAB9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 10:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F29176A1B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480ED1DED4C;
	Wed, 19 Feb 2025 09:34:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289C1C548C
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957693; cv=none; b=XmRy+bESA580QxQ6FzAQCLEdmWNIP1+fXr5ARupyAXnS2rnUUbwFCeynbx7CgQGvcBrt6TDuaDASKXUgNn8kzgf86uNylfh1PKdJ0LJyEIClN6XHEGPacmgIEmfMGvbi+gFAbpGFj0VsfaFP11t/a3YN4Q7Ox+n7DjoIB4cWcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957693; c=relaxed/simple;
	bh=3S1mMRskoudkuUXndGjgGujr/onBVi4pl6t8xSfOVTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHKLY/cYx5tcs8p0wR9epWbVTx7bjlAlqlNaKUQDSLP8iLuUDYW5r6Gt+ZmQt/3dNURK2354DnrsmynouIoeCgx25JczQ0hW3glcdL0LijGssWjulzCnRW/yVAMXjZQyo5N7boaga0NYx3uJZ2ShQcEo5LR124p9Ccl2iBSfM8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7202312FC;
	Wed, 19 Feb 2025 01:35:09 -0800 (PST)
Received: from [10.57.84.90] (unknown [10.57.84.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3F423F59E;
	Wed, 19 Feb 2025 01:34:49 -0800 (PST)
Message-ID: <a0b41ce7-4ab8-4baa-adee-8b5717326729@arm.com>
Date: Wed, 19 Feb 2025 09:34:47 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: rockchip: Check if smcc could be handled by TA
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org
References: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2025 00:58, Shawn Lin wrote:
> Non-existent trusted-firmware could lead smcc calls into some
> unset location which breaks the system.
> 
> Reported-by: Steven Price <steven.price@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Fixes: 58ebba35ddab ("pmdomain: rockchip: Add smc call to inform firmware")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Tested-by: Steven Price <steven.price@arm.com>

Although one note below...

> ---
> Hi Ulf, this's a follow-up patch fixing the issue Steven saw.
> 
>  drivers/pmdomain/rockchip/pm-domains.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 49842f1..27a5c68 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -572,9 +572,10 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>  	}
>  
>  	/* Inform firmware to keep this pd on or off */
> -	arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
> -			pmu->info->pwr_offset + pd_pwr_offset,
> -			pd->info->pwr_mask, on, 0, 0, 0, &res);
> +	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_NONE)
> +		arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
> +				pmu->info->pwr_offset + pd_pwr_offset,
> +				pd->info->pwr_mask, on, 0, 0, 0, &res);

Note that if the conduit is SMCCC_CONDUIT_HVC then this will still
attempt an SMC. I'm not sure if this situation can happen in practice.

There is a (horrifyingly complex) macro arm_smccc_1_1_invoke() which
will automatically use the correct conduit, and even copes with the
SMCCC_CONDUIT_NONE case (by simply failing the call).

Steve

>  }
>  
>  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)


