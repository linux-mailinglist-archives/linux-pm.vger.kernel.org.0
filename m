Return-Path: <linux-pm+bounces-13632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893CC96C812
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4268D281645
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA61E8B68;
	Wed,  4 Sep 2024 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/I+jOk6"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37021E7677
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479949; cv=none; b=guEoqbHny16wycUhNQxZ7QINrMj438o4Fbgpimfw760xuP/fEQEeYaC+bi2J82pe2+IaCcPSgqe6Y+JTp1ieROYhRnjzs5pkSGuNS2nCTSQWnys+HR942Nc8/pcMsCxxprrgb6oW05/J8OW9dqv+gCBm5jvrcZ2qhu54HUWIXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479949; c=relaxed/simple;
	bh=q4Zx2I3Gi9EYhBHmJYx0PYPLfRI02GuBKpR7J2sbZuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeN3MhSpiyxfT+FYQjaKSnHTEBZm/ToaXQJP0CnKzOjRjQcxOrs2FHfLYy3VedTLGo84D5GZBz8Z7Y0kUSLWTDQH/uutq6Vl4QtoM77T6Ow7OdXr5cBxHJ3tjyipx02EMFX8pdJAuarH4g5lrCIQufWxotn4J6SnVAIr9iapwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/I+jOk6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725479946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVc6JRTF1durtkuxn7+CXSDcgneG4y9FqqasPGYLMFI=;
	b=U/I+jOk6X/iXSlAfEhYCPt8/0jvQ2x+b0pQXsyb2/IQjrnR+ny+icQjQEMiCB0GXNRvfLc
	ywSq6XBrqe6d1SeCwAme3TFA1cXJiBYE0pEvv9rGta+vSYdPCXLrzAnsBa0xFc4P7StEZ1
	wzcz/lGgEplT5DXrmqH18vbOxuY9Ddk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-jZX4qDG6MzWT-9IXXNazuA-1; Wed, 04 Sep 2024 15:59:05 -0400
X-MC-Unique: jZX4qDG6MzWT-9IXXNazuA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c24b4a57b4so3093998a12.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 12:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479940; x=1726084740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVc6JRTF1durtkuxn7+CXSDcgneG4y9FqqasPGYLMFI=;
        b=UmU3e1AvI+pIgpXDPArnEsETld4km7H+oZW0/nQoG9+1haK7nSyInMFnGXTuCLOz78
         03E19+spXcyqs7Ge+tj+O50acq9KJaJ9RS29bNOl/fCimM3phdz6oi0sz/+ii5LNsbqp
         jWeKh8Q4ywvej4rD8cgKzRALBIax8dfUXtjGqy4Ctr6uzDtJYg1UFtDdAEOnw04fKokL
         hAHlYlmHtEhonSO9+gCO7Fi7jzcNmc2os4RRThDrQ0QSozmeU9PMBA9+KxQ/0B6DdwGI
         o9zI+OwsFDR17vOhukauneBvlCRYQiI2fX3q68DHwLIMawal4m+mXSi/VivGPu+tF0ot
         /KKw==
X-Gm-Message-State: AOJu0YzDpBIbfjWMw+HNLQtcVZB1Mah5Nc/zxZterdq4vgPKP7CDUzr3
	B1Da2FryZK4hsJwaTQI+YAUSetiVmQz+/fJZLF0yRBbwZvPaot1q6a2mXSC6RbsUMZtepmJ80BV
	WMbW8ZK7EQflf+ATE1npVh04A8uT14D/U4ooINO5miqB+8puc/brVLfL/
X-Received: by 2002:a17:907:3ea6:b0:a86:95ff:f3a0 with SMTP id a640c23a62f3a-a897f77ef10mr1757507966b.3.1725479940565;
        Wed, 04 Sep 2024 12:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgDwNRq0AbKATIeRJchwrsuYhAK9IGlpgF1YxJRkZZpzO5Ek1cAhmzW/UQMzonzWzKDKaFsg==
X-Received: by 2002:a17:907:3ea6:b0:a86:95ff:f3a0 with SMTP id a640c23a62f3a-a897f77ef10mr1757504666b.3.1725479939992;
        Wed, 04 Sep 2024 12:58:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62038d6fsm31568966b.61.2024.09.04.12.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:58:59 -0700 (PDT)
Message-ID: <e2ed8a03-7973-4ab9-9b9d-d1c23616de86@redhat.com>
Date: Wed, 4 Sep 2024 21:58:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 5/9] power: supply: sysfs: rework uevent property
 loop
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-5-62efeb93f8ec@weissschuh.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240904-power-supply-extensions-v3-5-62efeb93f8ec@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/4/24 9:25 PM, Thomas Weißschuh wrote:
> Instead of looping through all properties known to be supported by the
> psy, loop over all known properties and decide based on the return value
> of power_supply_get_property() whether the property existed.
> 
> This makes the code shorter now and even more so when power supply
> extensions are added.
> It also simplifies the locking, as it can all happen inside
> power_supply_get_property().
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


p.s.

Last review for me in this set. I'm afraid I don't have the bandwidth
atm to also review the actual extension API.





> ---
>  drivers/power/supply/power_supply_sysfs.c | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 4ab08386bcb7..915a4ba62258 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -290,6 +290,8 @@ static ssize_t power_supply_show_property(struct device *dev,
>  				dev_dbg_ratelimited(dev,
>  					"driver has no data for `%s' property\n",
>  					attr->attr.name);
> +			else if (ret == -EINVAL) /* property is not supported */
> +				return -ENODATA;
>  			else if (ret != -ENODEV && ret != -EAGAIN)
>  				dev_err_ratelimited(dev,
>  					"driver failed to report `%s' property: %zd\n",
> @@ -451,11 +453,7 @@ static int add_prop_uevent(const struct device *dev, struct kobj_uevent_env *env
>  
>  int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  {
> -	const struct power_supply *psy = dev_get_drvdata(dev);
> -	const enum power_supply_property *battery_props =
> -		power_supply_battery_info_properties;
> -	unsigned long psy_drv_properties[POWER_SUPPLY_ATTR_CNT /
> -					 sizeof(unsigned long) + 1] = {0};
> +	struct power_supply *psy = dev_get_drvdata(dev);
>  	int ret = 0, j;
>  	char *prop_buf;
>  
> @@ -483,22 +481,8 @@ int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  	if (ret)
>  		goto out;
>  
> -	for (j = 0; j < psy->desc->num_properties; j++) {
> -		set_bit(psy->desc->properties[j], psy_drv_properties);
> -		ret = add_prop_uevent(dev, env, psy->desc->properties[j],
> -				      prop_buf);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	for (j = 0; j < power_supply_battery_info_properties_size; j++) {
> -		if (test_bit(battery_props[j], psy_drv_properties))
> -			continue;
> -		if (!power_supply_battery_info_has_prop(psy->battery_info,
> -				battery_props[j]))
> -			continue;
> -		ret = add_prop_uevent(dev, env, battery_props[j],
> -			      prop_buf);
> +	for (j = 0; j < POWER_SUPPLY_ATTR_CNT; j++) {
> +		ret = add_prop_uevent(dev, env, j, prop_buf);
>  		if (ret)
>  			goto out;
>  	}
> 


