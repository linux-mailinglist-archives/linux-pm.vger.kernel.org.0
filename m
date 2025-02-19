Return-Path: <linux-pm+bounces-22393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB2A3B375
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752543A6279
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E117A30C;
	Wed, 19 Feb 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yKzgy0y2"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AEF8BF8
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953059; cv=none; b=E8gxVE2IcDOdT8oUHKTHi1299FoTypXZZ+sKGghG21O8lgtA/VRhga38eKQXlI5UqfamdYvtF7UOkPGv6i2c7u7RXdUnEzsLQ5KLy9hpTn3+AI/IJ8u0KBDyJrWtN8f+UnZOp5zhhjJC7WqF8UuNwL9TO6z2iamX1hjzCdvE/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953059; c=relaxed/simple;
	bh=GIK3DRXklKZVZel0Z1LrIooZwULZTxEBHjXcnRUluyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoXQB36dWZXXWsdwcPFdjziaeeac/Yz5Y3C7wDGRb/ff4Il429w4jZ/L9tj98zPA7Rv2Z4I1cNiTeenv3XtNi1cDOJ1vYz2GAGUl0POlrGYMw2cWCYd5Kob9AZvs7R1KAETO4R51r6OoLuao568WS6aVzppYladNxvQZrCs9SnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yKzgy0y2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kUTRJU/6XNS+Ziltnvt01u6UQNfGdBBiYXmQdZRzoKc=; b=yKzgy0y2gAUniVCffgsMaAlieY
	RgtUVaZdAgHkhZ22gN3unHMqX8CSzxq6ZDh23ZS3RrRZOyQ7UvQJ71dCagPOhobaEiocDelZ1XuSk
	18eZDvf8XhL0HTC51PQluB5yuCjZkzFJW8qm7pwivbGVW+g7l7e8loo3VwVHNVz/5AUaJ2abKuFaV
	AkJ26Ce8u4+lRas6UpBlwGWylk+SCQpyI47beiS1pWMmq/fopepUJR5qIx93v/PHnJLTl58D+N1bw
	OAixcrgZEHxMD/VzB1/hjtgcbSSifwLMFBPnVd0Mxjwex/xqbolkJO92ASWnJZ9YhcczicVKDd6mE
	tWOwlt1w==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tkfGn-00077N-H6; Wed, 19 Feb 2025 09:17:25 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] pmdomain: rockchip: Check if smcc could be handled by TA
Date: Wed, 19 Feb 2025 09:17:24 +0100
Message-ID: <3600260.V25eIC5XRa@diego>
In-Reply-To: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>
References: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 19. Februar 2025, 01:58:09 MEZ schrieb Shawn Lin:
> Non-existent trusted-firmware could lead smcc calls into some
> unset location which breaks the system.
> 
> Reported-by: Steven Price <steven.price@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Fixes: 58ebba35ddab ("pmdomain: rockchip: Add smc call to inform firmware")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

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
>  }
>  
>  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
> 





