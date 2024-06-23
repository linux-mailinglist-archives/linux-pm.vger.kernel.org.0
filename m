Return-Path: <linux-pm+bounces-9829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96D913A13
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 13:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4B21F21BD8
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 11:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EC0136E13;
	Sun, 23 Jun 2024 11:26:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75141369B4;
	Sun, 23 Jun 2024 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719142009; cv=none; b=jKCh7CxRJ1wiZG6XFzZNY3HBLgV+3dDxk9WpS4aWpvemamq/B+VHXperaTHkZJ54rT4nNW5SdxQ1mv57GE6hJIymRtQP2gaenfDl6XcwX46FDw8srHG2IkJRT8vVOtXrgUfsJv+eEi1Ged76qK/MGpRfM2ac8H46BQJUeiAUZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719142009; c=relaxed/simple;
	bh=Dd6YcmLb8o+G6RWqBuwSGvOw3f/TCS3z7u0PqBD9BPg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qHvxh4d9Q/XUmydvjiG+irW0eYuI/+OnFO20I5kZnkrT+6sWxD3AGlgEjyNR4Zu8LcS0CmDxe1mtD4LMiiLHdNgJ9RkNreaiuRl+1MmG712rRhp9VZknlLuEo5r5UqGYPrwsvhzXFbnqdmhBdnN2Wwbpn5Bc4qDdETG/fa2xDik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C80BC0005;
	Sun, 23 Jun 2024 11:26:38 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Jun 2024 13:26:38 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
 <sre@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Sebastian
 Reichel <sebastian.reichel@collabora.com>, linux-mips@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: ingenic: Fix some error handling paths in
 ingenic_battery_get_property()
In-Reply-To: <51e49c18574003db1e20c9299061a5ecd1661a3c.1719121781.git.christophe.jaillet@wanadoo.fr>
References: <51e49c18574003db1e20c9299061a5ecd1661a3c.1719121781.git.christophe.jaillet@wanadoo.fr>
Message-ID: <f3b7a454fbd761450303ea8128c888fa@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: contact@artur-rojek.eu

Hi Christophe,

thanks for the patch, looking good.

Acked-by: Artur Rojek <contact@artur-rojek.eu>

Cheers,
Artur

On 2024-06-23 07:50, Christophe JAILLET wrote:
> If iio_read_channel_processed() fails, 'val->intval' is not updated, 
> but it
> is still *1000 just after. So, in case of error, the *1000 accumulate 
> and
> 'val->intval' becomes erroneous.
> 
> So instead of rescaling the value after the fact, use the dedicated 
> scaling
> API. This way the result is updated only when needed. In case of error, 
> the
> previous value is kept, unmodified.
> 
> This should also reduce any inaccuracies resulting from the scaling.
> 
> Finally, this is also slightly more efficient as it saves a function 
> call
> and a multiplication.
> 
> Fixes: fb24ccfbe1e0 ("power: supply: add Ingenic JZ47xx battery 
> driver.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/power/supply/ingenic-battery.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/ingenic-battery.c 
> b/drivers/power/supply/ingenic-battery.c
> index 2e7fdfde47ec..0a40f425c277 100644
> --- a/drivers/power/supply/ingenic-battery.c
> +++ b/drivers/power/supply/ingenic-battery.c
> @@ -31,8 +31,9 @@ static int ingenic_battery_get_property(struct 
> power_supply *psy,
> 
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_HEALTH:
> -		ret = iio_read_channel_processed(bat->channel, &val->intval);
> -		val->intval *= 1000;
> +		ret = iio_read_channel_processed_scale(bat->channel,
> +						       &val->intval,
> +						       1000);
>  		if (val->intval < info->voltage_min_design_uv)
>  			val->intval = POWER_SUPPLY_HEALTH_DEAD;
>  		else if (val->intval > info->voltage_max_design_uv)
> @@ -41,8 +42,9 @@ static int ingenic_battery_get_property(struct 
> power_supply *psy,
>  			val->intval = POWER_SUPPLY_HEALTH_GOOD;
>  		return ret;
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> -		ret = iio_read_channel_processed(bat->channel, &val->intval);
> -		val->intval *= 1000;
> +		ret = iio_read_channel_processed_scale(bat->channel,
> +						       &val->intval,
> +						       1000);
>  		return ret;
>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>  		val->intval = info->voltage_min_design_uv;

