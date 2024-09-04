Return-Path: <linux-pm+bounces-13629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7952C96C809
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330AF283063
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4CD1E6DFB;
	Wed,  4 Sep 2024 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LakdnPFf"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A2D1DB94D
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479809; cv=none; b=uBapNIIS6z6IlxVEzI3TpBaoI3EYJ8FnJAJJDyXo8NcEeECrI8+IBdUwE0iC4eROsZvMNz1EfsC6xr7RwQmRNZ/Yh78w1ckbGS7Q7MbYD2OQ950AsXbP4q67jelRiKltasUxftCnenuSg0oQkue+E04fhw2f9l3PXiBYEylMKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479809; c=relaxed/simple;
	bh=6tk844i+icxNldvAfW+R49ukLwXtkcz600j0MfXxKyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPlRBgI5+uyMpnI6SbbgiSLr3a46sAPNr0SQBhC79GsZ7G7gO8+K7VNdwepQ0QEj92Xryz5b8pwuCEruZ34RGNj1MW6F4Fcns8B5CJVCMUC4R9SnepbUNH3X6x9cFNSW7MTM6s7gMIdLE25WfkMx4NrSARPeNQZ9eGEnqk/WQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LakdnPFf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725479806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6KR/5kQWmNiegkO5DFGDhvnugbLFLgCWTk43Wsr+3M=;
	b=LakdnPFfLXJrT36jQOGVAYmFzhg1c64Em/q5zNw4D+FgLPz3yOG1zhyLngszIKEiqBmZuR
	Qy19SwX6QUrdQZNG/4ikn2JvQXQ8ZfmIUoQlsamXSl8NTJxFvxEOOK6Ur756wXYl8IE73J
	XgL5uUAp9K00tpyBOpqQrVzXkCuanow=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-ZZdfr3g1PJO7Dqb4EEEE0Q-1; Wed, 04 Sep 2024 15:56:45 -0400
X-MC-Unique: ZZdfr3g1PJO7Dqb4EEEE0Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a867b95db47so3893666b.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 12:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479804; x=1726084604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6KR/5kQWmNiegkO5DFGDhvnugbLFLgCWTk43Wsr+3M=;
        b=P6FS+k7Dq+9Q/kIc9PCnNv9MZIw6HrNfQK9GjI3WCCpiE3nUq/lX3Z5vU4jqXAuWjs
         oEvXHxHrlMXq05ROE7TVp/ZBnhIwyH6iL3i6+TL7txD75MHWuJF0ciq+e8QED3DguVXZ
         O7gmhm4r+d7FI0FsaNSUp2iNu22Ckjr1vbfwWwhW9lroUQAJbhYUa44bq7QrzzrYt80J
         hVlDmWIfmLuvtZuzkZ55y3vix3tioB05IEk+r0gAAQ0b2Q/l2PFdw6TETGwnvxLUTrHo
         h8hEDHtTxXYWM1dQa6jI6oR4QLUT7jR8gmy6X8TKWQnBB8DvukrKIuPlLm6tARR7OWqX
         pUbw==
X-Gm-Message-State: AOJu0YwMu1zz9RlyHx3IsuKDzknEBKG3d6sk76L6L0uCpMOW1Yh1ox4v
	XiGEsBhB/BEYxHc4q9SugAKd5m+nDPiPscCGDKaCa1bsrbIkGPBKmuL6Gniw0Cf+jAR/Xs2QepX
	otz4OYyaUzrRtgZvx7BJuyCbFAKVovCt5mUnD4Pkc5kBzIbqbB+S2upVJM2XXfyMV
X-Received: by 2002:a17:906:da82:b0:a86:83c7:e885 with SMTP id a640c23a62f3a-a89d8ab4a32mr1004287066b.63.1725479804377;
        Wed, 04 Sep 2024 12:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGnmYBGkoRxJVJFeeUnvt218Ul+nvy0dlAfM8sPzl/OWoH0RC2VfEBzk4PyiW7u2tC6V0+NA==
X-Received: by 2002:a17:906:da82:b0:a86:83c7:e885 with SMTP id a640c23a62f3a-a89d8ab4a32mr1004285366b.63.1725479803794;
        Wed, 04 Sep 2024 12:56:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d164sm30468766b.111.2024.09.04.12.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:56:43 -0700 (PDT)
Message-ID: <c938ab4e-ad58-48f6-a612-1717557d2891@redhat.com>
Date: Wed, 4 Sep 2024 21:56:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/9] power: supply: core: register thermal zone for
 battery
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-2-62efeb93f8ec@weissschuh.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240904-power-supply-extensions-v3-2-62efeb93f8ec@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/4/24 9:25 PM, Thomas Weißschuh wrote:
> power_supply_read_team() can also read the temperature from the battery.
> But currently when registering the thermal zone, the battery is not
> checked for POWER_SUPPLY_PROP_TEMP.
> Introduce a helper which can check both the desc and the battery info
> for property existence and use that.
> Export the helper to the rest of the psy core because it will also be
> used by different subcomponents.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/power/supply/power_supply.h      |  3 +++
>  drivers/power/supply/power_supply_core.c | 14 +++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> index 3cbafc58bdad..b01faeaf7827 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -13,6 +13,9 @@ struct device;
>  struct device_type;
>  struct power_supply;
>  
> +extern bool power_supply_has_property(struct power_supply *psy,
> +				      enum power_supply_property psp);
> +
>  #ifdef CONFIG_SYSFS
>  
>  extern void power_supply_init_attrs(void);
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index cff68c4fd63c..dcb7e4853030 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1199,6 +1199,18 @@ static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
>  	return found;
>  }
>  
> +bool power_supply_has_property(struct power_supply *psy,
> +			       enum power_supply_property psp)
> +{
> +	if (psy_desc_has_property(psy->desc, psp))
> +		return true;
> +
> +	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> +		return true;
> +
> +	return false;
> +}
> +
>  int power_supply_get_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    union power_supply_propval *val)
> @@ -1308,7 +1320,7 @@ static int psy_register_thermal(struct power_supply *psy)
>  		return 0;
>  
>  	/* Register battery zone device psy reports temperature */
> -	if (psy_desc_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> +	if (power_supply_has_property(psy, POWER_SUPPLY_PROP_TEMP)) {
>  		/* Prefer our hwmon device and avoid duplicates */
>  		struct thermal_zone_params tzp = {
>  			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
> 


