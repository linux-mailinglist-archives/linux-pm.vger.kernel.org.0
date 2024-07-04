Return-Path: <linux-pm+bounces-10630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D2927CE5
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 20:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F141C22220
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A042349659;
	Thu,  4 Jul 2024 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dYnVuHGX"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4FE15491;
	Thu,  4 Jul 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116984; cv=none; b=UXl6s9WwgKOSQclRexMdw624vnpBOqvTVmIBWAFY8gAs/wXQ+4cq9NQxkfzDPZfgBHUvI6UWiCkFniJGxV+0flxC+DVTcvXbkXt9VR+xvB6YpMhDV1uLJjUmVWsFxSrPeaBVY1exqUKH6dG1Qv8T34Eoa6OMIksDIWpc4O2Ukuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116984; c=relaxed/simple;
	bh=5d/dB4AsLDLrUV0iB98Gfxiyh26yO3HZ8Hx1w+E/ZNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgwcviE0svh9N8caMNlYxhIaB1oSLBt6x0BlAEhZRFBYa+X3jWdKvyE/V7mcyzJPhsi0OEzgXfUVbJvVjVpzE7xEe7S/l3pUHP9g5xzJ4uRQKLHlJHOvKe62iF/5W0T888p4Eme2qRiLHgi2ZhPWq5JEygyvxGXec0YWvU9acdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dYnVuHGX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720116978;
	bh=5d/dB4AsLDLrUV0iB98Gfxiyh26yO3HZ8Hx1w+E/ZNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYnVuHGX5hdWPRFDaQopLHp/LP69wqpUd+usfunfEK/X/17gWqtMzdoHKz//7Gr1C
	 PFtoBAsH7OAy+0dwk3EYG82ysadfethxc45svz6nPUwD4EOqaGQlZWDNF/83ztVwaw
	 Ru/oLroh7CexjOHBCljggFDw2V3QGmr0RM0MVPh8=
Date: Thu, 4 Jul 2024 20:16:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] power: supply: cros_charge-control: Fix signedness bug
 in charge_behaviour_store()
Message-ID: <48a348a0-0489-45bb-874b-246c7683a5a5@t-8ch.de>
References: <ZoWKEs4mCqeLyTOB@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoWKEs4mCqeLyTOB@stanley.mountain>

Hi Dan,

Thanks!

On 2024-07-04 10:20:03+0000, Dan Carpenter wrote:
> The C standard is vague about the signedness of enums, but in this case
> here, they are treated as unsigned so the error handling does not work.
> Use an int type to fix this.
> 
> Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  drivers/power/supply/cros_charge-control.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
> index 73d7f2dc0fa3..3183a13eefd0 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -204,14 +204,13 @@ static ssize_t charge_behaviour_store(struct device *dev, struct device_attribut
>  {
>  	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
>  							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
> -	enum power_supply_charge_behaviour behaviour;
>  	int ret;
>  
> -	behaviour = power_supply_charge_behaviour_parse(EC_CHARGE_CONTROL_BEHAVIOURS, buf);
> -	if (behaviour < 0)
> -		return behaviour;
> +	ret = power_supply_charge_behaviour_parse(EC_CHARGE_CONTROL_BEHAVIOURS, buf);
> +	if (ret < 0)
> +		return ret;
>  
> -	priv->current_behaviour = behaviour;
> +	priv->current_behaviour = ret;
>  
>  	ret = cros_chctl_configure_ec(priv);
>  	if (ret < 0)
> -- 
> 2.43.0
> 

