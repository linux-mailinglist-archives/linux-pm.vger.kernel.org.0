Return-Path: <linux-pm+bounces-13631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E7196C80D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19DF281F57
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20041E764A;
	Wed,  4 Sep 2024 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlSCdQS8"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7801E6DFB
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479851; cv=none; b=sG9BeLCj/Si+QC9jwX5vJ+rnePNio6In81KJ/mGKcMPYBy7uSLybWFkjZPyeLEgEX0VgDziG/InYeM2gBhuYFS6NGbqLL/PVRSlKW2/yKaxcEiL6Tc1CzFjdX/5fQ9enJbW8OHNJt7z2Cy0abHHxkXj4fYkrEpeTfKdaUB8JURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479851; c=relaxed/simple;
	bh=Xwgfnwm4aixwjHxK45Cfat1yHYnqgba6d47DLMpHEVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiAz1iV55uUMJDW52qdWLvFCNbhY9SNO3ZyLpgt8sWK/I+6+o/OrHDH+AykssxwJ60IE3UGX0l91J2yznOQhWuh0S9a54ye1c6yG/Pm9M3i79qbM8ZaUO2S2Bdz/5Bc6xaq49jWIP5WzAXI/5+Z8TuIWS0QhpXa4fbR2+/s/f54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlSCdQS8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725479849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfOc/OwTB9hjAZ4+hRIzp7kADInixhRm8yePf7xIchM=;
	b=NlSCdQS8ssym0JxaKEomFDLnTCDur9swUf4rREY8TxkdF2Yy3wwZuNEj/FOl9aQXcTZaL1
	qBroIyL1mZj3enN8XZi7Ipwlf4OZMweiWZqlVRyBenDhI29bAob6trM+7pSz2ds38X4zC4
	e4CqgEYvwUC+Nt9zZrs7PptRMB6uBh8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-de-QUh6_MIudjgNjRuC9cA-1; Wed, 04 Sep 2024 15:57:27 -0400
X-MC-Unique: de-QUh6_MIudjgNjRuC9cA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8698664af8so2365666b.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 12:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479847; x=1726084647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfOc/OwTB9hjAZ4+hRIzp7kADInixhRm8yePf7xIchM=;
        b=f0r92f1TffAio/0nv6yDS99ewgufK/SDJU1pXWdPJjDn2AaaUj1N2FVcR7AAGEsdyr
         XE9TexoQ6Kx20rK+mcMkazBgUZ/o6t8JBTkRezWP8qTuEUES8FgYOO0H0cwIECDrrprK
         KgG/R6aOxTKWMKN9s8PRNxx8geDYAc4AoO+zw6uQRHVYOsH9avoWZYmPJPP28Dk6W3N9
         +juS+CB9QIxKcSe0s6Mb4/b81aUjKRAyZ4YveNuqGmPCsnf6tV0yEnBDlxfwM73u0GOE
         jXeNpDZ6jFdAjc4EUU1yVZBVfzhXKNaM3buUwgecZjMwviYenFPQFs9/rr5Q9b9jnD3l
         qBww==
X-Gm-Message-State: AOJu0Yykavh8bJB4Odl+0SP6/Y3Vc/opKm/2/6kR03Lzyphdhxhu+xsX
	f9oduAHAeznmbQYDONCozqFJYomfords+NIlzkKUKwImZvnrx+Rqfze6DhjExywgi8woIMyIuOU
	ct1BsfIxX/FEQ0bHMN8JkPNw4AFMPeMdLWSTY5e2+rSDP3zLSXN2VJCL2
X-Received: by 2002:a17:907:94d4:b0:a89:b829:7598 with SMTP id a640c23a62f3a-a8a42fdba65mr344795666b.12.1725479846705;
        Wed, 04 Sep 2024 12:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQhgIOlhuLY34Q4gwUYH9FdcOa8lFucrXBT8MB62RussGsqf5BBIcU5nwJAWBclu+fIPfYxw==
X-Received: by 2002:a17:907:94d4:b0:a89:b829:7598 with SMTP id a640c23a62f3a-a8a42fdba65mr344794466b.12.1725479846369;
        Wed, 04 Sep 2024 12:57:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62370ee0sm30693466b.106.2024.09.04.12.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:57:26 -0700 (PDT)
Message-ID: <e64f38b4-8c7d-4680-ac17-a364cc843f48@redhat.com>
Date: Wed, 4 Sep 2024 21:57:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 4/9] power: supply: sysfs: register battery
 properties
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-4-62efeb93f8ec@weissschuh.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240904-power-supply-extensions-v3-4-62efeb93f8ec@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/4/24 9:25 PM, Thomas Weißschuh wrote:
> Instead of only registering properties from the psy_desc itself,
> also register the ones from the battery.
> Use power_supply_has_property() for this test which makes the logic also
> easier to read.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/power_supply_sysfs.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 3e63d165b2f7..4ab08386bcb7 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -367,7 +367,6 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct power_supply *psy = dev_get_drvdata(dev);
>  	umode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
> -	int i;
>  
>  	if (!power_supply_attrs[attrno].prop_name)
>  		return 0;
> @@ -375,19 +374,11 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
>  	if (attrno == POWER_SUPPLY_PROP_TYPE)
>  		return mode;
>  
> -	for (i = 0; i < psy->desc->num_properties; i++) {
> -		int property = psy->desc->properties[i];
> -
> -		if (property == attrno) {
> -			if (power_supply_property_is_writeable(psy, property) > 0)
> -				mode |= S_IWUSR;
> -
> -			return mode;
> -		}
> -	}
> -
> -	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
> +	if (power_supply_has_property(psy, attrno)) {
> +		if (power_supply_property_is_writeable(psy, attrno) > 0)
> +			mode |= S_IWUSR;
>  		return mode;
> +	}
>  
>  	return 0;
>  }
> 


