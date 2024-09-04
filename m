Return-Path: <linux-pm+bounces-13628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3596C805
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDA52815A7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7C1E6DE8;
	Wed,  4 Sep 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hF20nqou"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1C1DB94D
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479798; cv=none; b=PbrTByxebmX0vYjtBcPnzT2BH4E40929Zma7SbzIGDk8yBPiqhsNhfidxjtjXa3ner/8BXNOOilfYWuOOtqJzX3uVBXh1cAXnVMvCwWDCBdT/wc/0rrd4QUEf/Pc5TTcG+72NdyqakFfUY3NRJ4KZKZH9q0ey9vMyLJnbWyemP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479798; c=relaxed/simple;
	bh=zYOLZTFPvvYSOSc2fv3IguP/FYXkl249MfKJPWCA7kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3sjZo3jSeIPxssKWdHoRfl/sPyiv8i8xdtHx+18sA1ISO9nb7Vt4AQ/zm4JghxI8QSMIBNNVBggybIusHYJ9jpMa1iauwSPJutOQWRTTySYA9k+or1Vkak4Mdl9qnogLH5oAiWn8dWS/fiQ1hoGVwDwz/S03pFn5AwK2wTrAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hF20nqou; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725479795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyMgDp0oQpk8xs0d2Wu+7QfF1fZAU5as65r2vHepi88=;
	b=hF20nqoulFzmpwYhj6YGl7nlgZlnjy88LrSVh5EF5ICjedKRoK5bUbYAL7FYSo6HCtJASy
	isNeS+vDMNoQqBCyKRYD70J5sEkr8YWd8c1GlWKVzFAbI2D45J5rLNbAsRi81R8AIAge0J
	8dWmCdbCMkRIZJHGTK16cD9Tc6h7TYE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-mDk_a4BHN9q-sIiHtXMg1w-1; Wed, 04 Sep 2024 15:56:33 -0400
X-MC-Unique: mDk_a4BHN9q-sIiHtXMg1w-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c268497042so10919a12.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 12:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479792; x=1726084592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyMgDp0oQpk8xs0d2Wu+7QfF1fZAU5as65r2vHepi88=;
        b=glNQYTZeet3+9rKf6Znqu4qQHqF5yYBIH8gyDR5ZWCAhm9tfP0Tunv+nGZWD0Nytvx
         0ORmIg37HpK7HtaZmLL3vdMFJsMCU499WeFFv4tBBSTlUwfWD0ds/reHKby0OYGxXaH1
         27wMFsqXy55/4AMM7VxoZJjEiW2lGkl3L5uCKTbR8zyXW0fjnAUESpbSPDVoyKeG0C25
         1lVO2cOOJ92CRzJPbGeJLZdZSUUsfVxl4oepHKZLLPOuzk6expFzLqUuFpaTwY07ocAm
         cNluMWUEgygPNCDykILt7YSjhhv9JZe5uBh7TRbXraNpmmiITk3zRB5WAScD+9UYWOC0
         bj/w==
X-Gm-Message-State: AOJu0YywqlWSTDQzkCiVsKXZeKhhQnfUuEi/JQSNycbFMryG9x+Qc1iO
	SpZJgVb0Kf6OTiJEB9P5duG64P9yOSWLuB1ZV8GqMoLxMvg+AV3qpX9wc7Y1BOcAoSoeaS7+dy2
	8E7kp1azWp87I8UATVcHgLZIGBGk20dkpN/zB6lQoJ1fbcCIX6rxpQGmEdJnzD/iw
X-Received: by 2002:a17:907:7d94:b0:a8a:445f:ac4d with SMTP id a640c23a62f3a-a8a445faeefmr194778166b.18.1725479792501;
        Wed, 04 Sep 2024 12:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUYaXXQh+1CG8qYzIjIH9BH0plEBZg36QtqdYDfY9l1zWcwlr4QsXieG1LGJdh51ODPYq/jw==
X-Received: by 2002:a17:907:7d94:b0:a8a:445f:ac4d with SMTP id a640c23a62f3a-a8a445faeefmr194775666b.18.1725479791991;
        Wed, 04 Sep 2024 12:56:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62037380sm31371666b.47.2024.09.04.12.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:56:31 -0700 (PDT)
Message-ID: <23d4b0c9-d344-49fe-a10c-e63f1f6fd83f@redhat.com>
Date: Wed, 4 Sep 2024 21:56:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/9] power: supply: core: rename psy_has_property()
 to psy_desc_has_property()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-1-62efeb93f8ec@weissschuh.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240904-power-supply-extensions-v3-1-62efeb93f8ec@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/4/24 9:25 PM, Thomas Weißschuh wrote:
> The function only takes a desc as parameter, align the naming.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/power_supply_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 8f6025acd10a..cff68c4fd63c 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1183,8 +1183,8 @@ bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
>  }
>  EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
>  
> -static bool psy_has_property(const struct power_supply_desc *psy_desc,
> -			     enum power_supply_property psp)
> +static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
> +				  enum power_supply_property psp)
>  {
>  	bool found = false;
>  	int i;
> @@ -1209,7 +1209,7 @@ int power_supply_get_property(struct power_supply *psy,
>  		return -ENODEV;
>  	}
>  
> -	if (psy_has_property(psy->desc, psp))
> +	if (psy_desc_has_property(psy->desc, psp))
>  		return psy->desc->get_property(psy, psp, val);
>  	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
>  		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
> @@ -1308,7 +1308,7 @@ static int psy_register_thermal(struct power_supply *psy)
>  		return 0;
>  
>  	/* Register battery zone device psy reports temperature */
> -	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> +	if (psy_desc_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
>  		/* Prefer our hwmon device and avoid duplicates */
>  		struct thermal_zone_params tzp = {
>  			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
> @@ -1361,7 +1361,7 @@ __power_supply_register(struct device *parent,
>  		pr_warn("%s: Expected proper parent device for '%s'\n",
>  			__func__, desc->name);
>  
> -	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
> +	if (psy_desc_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
>  	    (!desc->usb_types || !desc->num_usb_types))
>  		return ERR_PTR(-EINVAL);
>  
> 


