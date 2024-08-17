Return-Path: <linux-pm+bounces-12388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B77955952
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 20:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6478F1C20C03
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDBA839EB;
	Sat, 17 Aug 2024 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="Xf2TAjJu"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF922334
	for <linux-pm@vger.kernel.org>; Sat, 17 Aug 2024 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723920704; cv=none; b=meTNYpdB9Djni0pIjzlLyANP+jqmhTE6ee0eT5c6inrdEZg057pGtpGCQhgHId8JC12NkiCaqT6GEW/L0oEM4MyO5c3mgEKcJAXu+WlmvpsBkXxw7e/9zpM7ylMkQP5tDkQ5jBQB+9bWfBGrRbem8j6P1rHH/P6hNAifz5QuEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723920704; c=relaxed/simple;
	bh=MjP2DD6/GFdjWJPfJS4LlxOJ+1kSArHevkSXjV6J+l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH9RdBX2KnbTycSuLZUk6vJ5UfJDD+U+eI1FvtX500ytFWlGquJ0WY+/ErtpSg3uEFv0cw9N/KmdIP+KoUbvkNS8dw2rEIvKCKS27smOSQcmAFsyvMay6PPeBjNxN9LdQas2kno0H/dxF6Rw5UWKjIHIpJBpZkCzz67l+By58nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=Xf2TAjJu; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
Date: Sat, 17 Aug 2024 20:51:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1723920698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMvWByJNuw5TyydJGoxlSzz4CSYY6PeFa1vY2R3Mvno=;
	b=Xf2TAjJui0ncJXwKgSk1YtCoQaB4JJNB2B3jlL3MKWNVjd8s1wI/pxjmEcRBZmjPB7OKCK
	EcUjSp+koAu0bKCeG1nGbXboGF9ouVwN3nqyphiUbAJIeT59Qpu+ogItx8cbtr318ju9O3
	jHhLSkydWB00/+RrBjqWgU0223ccKWw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Sebastian Reichel <sre@kernel.org>,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>,
	Dirk Brandewie <dirk.brandewie@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] power: supply: max17042_battery: Fix SOC threshold calc
 w/ no current sense
Message-ID: <20240817185136.GA102892@l14.localdomain>
References: <20240817-max17042-soc-threshold-fix-v1-1-72b45899c3cc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-max17042-soc-threshold-fix-v1-1-72b45899c3cc@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 17, 2024 at 12:51:14PM +0200, Artur Weber wrote:
> Commit 223a3b82834f ("power: supply: max17042_battery: use VFSOC for
> capacity when no rsns") made it so that capacity on systems without
> current sensing would be read from VFSOC instead of RepSOC. However,
> the SOC threshold calculation still read RepSOC to get the SOC
> regardless of the current sensing option state.
> 
> Fix this by applying the same conditional to determine which register
> should be read.
> 
> This also seems to be the intended behavior as per the datasheet - SOC
> alert config value in MiscCFG on setups without current sensing is set
> to a value of 0b11, indicating SOC alerts being generated based on
> VFSOC, instead of 0b00 which indicates SOC alerts being generated based
> on RepSOC.
> 
> This fixes an issue on the Galaxy S3/Midas boards, where the alert
> interrupt would be constantly retriggered, causing high CPU usage
> on idle (around ~12%-15%).
> 
> Fixes: e5f3872d2044 ("max17042: Add support for signalling change in SOC")
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Reviewed-by: Henrik Grimler <henrik@grimler.se>

Can confirm that this fixes high irq CPU usage on exynos4412-i9300 and
exynos4412-i9305, thanks!

Best regards
Henrik Grimler

> ---
> Commit 223a3b82834f ("power: supply: max17042_battery: use VFSOC for
> capacity when no rsns") made it so that capacity on systems without
> current sensing would be read from VFSOC instead of RepSOC. However,
> the SOC threshold calculation still read RepSOC to get the SOC
> regardless of the current sensing option state.
> 
> Fix this by applying the same conditional to determine which register
> should be read.
> 
> This also seems to be the intended behavior as per the datasheet - SOC
> alert config value in MiscCFG on setups without current sensing is set
> to a value of 0b11, indicating SOC alerts being generated based on
> VFSOC, instead of 0b00 which indicates SOC alerts being generated based
> on RepSOC.
> 
> This fixes an issue on the Galaxy S3/Midas boards, where the alert
> interrupt would be constantly retriggered, causing high CPU usage
> on idle (around ~12%-15%).
> ---
>  drivers/power/supply/max17042_battery.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index e7d37e422c3f..496c3e1f2ee6 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -853,7 +853,10 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
>  	/* program interrupt thresholds such that we should
>  	 * get interrupt for every 'off' perc change in the soc
>  	 */
> -	regmap_read(map, MAX17042_RepSOC, &soc);
> +	if (chip->pdata->enable_current_sense)
> +		regmap_read(map, MAX17042_RepSOC, &soc);
> +	else
> +		regmap_read(map, MAX17042_VFSOC, &soc);
>  	soc >>= 8;
>  	soc_tr = (soc + off) << 8;
>  	if (off < soc)
> 
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240817-max17042-soc-threshold-fix-e96f15a622e5
> 
> Best regards,
> -- 
> Artur Weber <aweber.kernel@gmail.com>
> 

