Return-Path: <linux-pm+bounces-14244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 096DB978F1D
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E63B23011
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D49146018;
	Sat, 14 Sep 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GpuwAhen"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47600126C0B;
	Sat, 14 Sep 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726302513; cv=none; b=FJP63+d+2HWZabQ232DpgrfSPAqn6VzSsDSc5I7MVwTuAUSJ9uiYDBd8a9q4FTG3+bPSFHSztexoWIR7H/Y4Gu0rAWklL1rF1Ehd/qvft6VmVWMswKut7yTrjIeVdMCMFupEBW5sxJUgUk6Y4e9/RysTmNWZhpW5iRNM1n7t2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726302513; c=relaxed/simple;
	bh=kvQveuT66+yyOnDl4rid1x8W+VVeD52DRSPkfjMmlN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTvxHMPTtLRHoWAoym4pYcbyQBQ0hKC5EexhpRHFHm9Vrh3i2zL5CCnU8An+/UOSPYnbcYi4CadsK0XNZZxDr83ZsCmS4nsiVLWt4N/DoVy3H/ndZpnqEgRotUqSCwCsTeNzHN1/AP2yAtyl4SbdKNYKWPWKPNLIhNhnM0BHwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GpuwAhen; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1726302497;
	bh=kvQveuT66+yyOnDl4rid1x8W+VVeD52DRSPkfjMmlN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpuwAhent4UerZY2luprxIre1hzxVuFygJeZXMH4+agi4k2VIYgI5Rgypqhi7kvyZ
	 Ydc6Jqdra3bMr2a2DiWdZukl1XLwFLI3BA6Ouow35c36RXcCdvxWAfr25mV+/28sWo
	 CdAd+lVycHVgMCYJoehiyLg2qzTO5Mo7GkTe9iJg=
Date: Sat, 14 Sep 2024 10:28:16 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hns@goldelico.com, stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] power: supply: sysfs: enable is_writeable check during
 sysfs creation
Message-ID: <e76a8e70-1a0c-4242-ba96-07590e02c221@t-8ch.de>
References: <20240914081523.798940-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914081523.798940-1-andreas@kemnade.info>

Hi Andreas,

On 2024-09-14 10:15:23+0000, Andreas Kemnade wrote:
> The files in sysfs are created during device_add(). psy->use_cnt
> is not incremented yet. So attributes are created readonly
> without checking desc->property_is_writeable() and writeable
> files are readonly.
> 
> To fix this, revert back to calling desc->property_is_writeable()
> directly without using the helper.

Hans noticed the same issue, but fixed it differently [0].
The problem is that the hwmon registration also uses
power_supply_property_is_writeable() and has the same issue.
(Independently from my change)

IMO this is the better fix.

(Plus the renaming and unexporting of the function that I'll add if it
won't be part of the first fix)

[0] https://lore.kernel.org/all/20240908185337.103696-1-hdegoede@redhat.com/

> Fixes: be6299c6e55e ("power: supply: sysfs: use power_supply_property_is_writeable()")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Cc: stable@vger.kernel.org # 6.11
> ---
>  drivers/power/supply/power_supply_sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 3e63d165b2f70..b86e11bdc07ef 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -379,7 +379,8 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
>  		int property = psy->desc->properties[i];
>  
>  		if (property == attrno) {
> -			if (power_supply_property_is_writeable(psy, property) > 0)
> +			if (psy->desc->property_is_writeable &&
> +			    psy->desc->property_is_writeable(psy, property) > 0)
>  				mode |= S_IWUSR;
>  
>  			return mode;
> -- 
> 2.39.2
> 

