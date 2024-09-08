Return-Path: <linux-pm+bounces-13859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244C5970839
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 16:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388731C212E3
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50F16630E;
	Sun,  8 Sep 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oKGWFfGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9443156243
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807135; cv=none; b=CthpWdte8NtYpeXtg/z6d2uPsp6/6+ZhivdeuYRsr936Ufc/TYDPgsv2Pi3/pUTPL9y2cb+wXZbAdcWCdxnSySoTWRlp5iERDZjZ+//VWBBlJ+dOZelbizjnV0Qrlb10KLX7fiw5wb8SeBayUDbX5cXuMe9hOy0irrGo0W6Y1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807135; c=relaxed/simple;
	bh=bhwUp0817S16D/6jjumcLcALbcCJvgoukpBc+nhWga0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJkRke0Cyil2xFi+OjyVwqjj7tqkmS727/YOpejBTNClVkOALEr1UiVd3sPEJ/g93O0NK5ioadpJnzNMPboDoxHzv2uPvSAoXAyfMg1Kz9CAA5fNFNeE9gBxzvV0pWXpg/InkktxdBgXWFAof0bzmlAbWbDxqigUlDAsoIG5v1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oKGWFfGS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725807128;
	bh=bhwUp0817S16D/6jjumcLcALbcCJvgoukpBc+nhWga0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKGWFfGSHfEKOPJp+OxaIRPQgXgwUCa+TrYHV16xaZegTnjdRpK0iqcfs47RSADHd
	 bkIb6v6PwGP9z2OiIkoncXRCZ6DdKQh4BUT455CHIKlHb1sIdaF1EQleLKRe38Ir9F
	 PdrEBcMKG/MO9u0VTDYEGIQYh5r3GGrxS/UlMjAg=
Date: Sun, 8 Sep 2024 16:52:08 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 6.11 regression fix] power: supply: sysfs: Revert use
 power_supply_property_is_writeable()
Message-ID: <de97c24e-85b2-4196-80da-5718075c900b@t-8ch.de>
References: <20240908144414.82887-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240908144414.82887-1-hdegoede@redhat.com>

Hi Hans,

On 2024-09-08 16:44:14+0000, Hans de Goede wrote:
> power_supply_property_is_writeable() contains the following check:
> 
>         if (atomic_read(&psy->use_cnt) <= 0 ||
>                         !psy->desc->property_is_writeable)
>                 return -ENODEV;
> 
> psy->use_cnt gets initialized to 0 and is incremented by
> __power_supply_register() after it calls device_add(); and thus after
> the driver core calls power_supply_attr_is_visible() to get the attr's
> permissions.
> 
> So when power_supply_attr_is_visible() runs psy->use_cnt is 0 failing
> the above check. This is causing all the attributes to have permissions
> of 444 even those which should be writable.
> 
> Move back to manually calling psy->desc->property_is_writeable() without
> the psy->use_cnt check to fix this.

Thanks for the fix!

OTOH the whole power_supply_attr_is_visible() is completely unused
outisde of the psy core. So instead we could unexport it, drop the use_cnt
check and use it again.
(All of this as part of the psy extension series, for now your revert
should be used)

What do you think?

> 
> Fixes: be6299c6e55e ("power: supply: sysfs: use power_supply_property_is_writeable()")
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note this is a straight-forward revert of be6299c6e55e
> ---
>  drivers/power/supply/power_supply_sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 6cd3fac1891b..fb9b67b5a9aa 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -387,7 +387,8 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
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
> 2.46.0
> 

