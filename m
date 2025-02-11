Return-Path: <linux-pm+bounces-21888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B48FA31715
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2BB1888F2E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B70A264F95;
	Tue, 11 Feb 2025 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg6XAMzb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600326563F;
	Tue, 11 Feb 2025 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307739; cv=none; b=e82si+12MBRqCu4WsEiQTXm79XyEO6s1PImd3epu2Xfgu1El2cm1o7hOBqEUaas9CJ4Ubsbwzg3mLvXb714UM5D9JcfJGVsLz+WyXFzBRob6e21IvuuZAivmWGZWGjoKBrcMWwQBA79ljvIttBBwuOmhNGciFxpOZG2L7gmGE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307739; c=relaxed/simple;
	bh=ft9S8SqsolK3whhc7XXUN7Q8EDYX3DgvWorDRfJ1fMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8bY90dISKvyQt2zUmnrzCUf7l9eLDYoGtfS/VkZIyUFEkW/v4e7/CmIc+x/9e1MPmJsivk8MImkE7BL7D8/iF9vssN0h3bIWsxYRO8Up5RwJFw6hLMb6l4oKDo09K3PSfORtyW+K9wceXjbeWTITvsWvidn+NtYkNPgUGMv6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eg6XAMzb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de5a8a96abso6242827a12.3;
        Tue, 11 Feb 2025 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739307735; x=1739912535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZyUrG6+M9kIYP0+SgijnDH3fs7yuMG/QqkNcnw9Coc=;
        b=Eg6XAMzbCyemUyarE+LyF/Exa6I0qK3mnpGYwUO0NDn/frLBIDyw6wA4aP69ibuE7d
         +Baym/yGiZ8e3K93QL3KDl+nHJm0b7ZwbM5eCEfdhrAWBYn+rnyGGlh3Ed2fFvMXhH9R
         b8mAd7ir2lkpsyKMPyM1TrRy/RXDy2II4Ojybwv0kp61hNsn7tKZG2Ok7uaBR81ab4Pl
         /wRbZYsVA0O/qC5A/7IZnSKAUXezLsrDXS4rFn+zQEbPFXK1eKKil74uxECDHwNAXrVS
         N4W+cdC6+xzMU40/kcS4JbELlTzMktClr9hHfhTeGvZ+dwxlK0E/mWdUHmuq1yKKyeYn
         55WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739307735; x=1739912535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZyUrG6+M9kIYP0+SgijnDH3fs7yuMG/QqkNcnw9Coc=;
        b=r+pEqxxdEsI3zwA+ZnaoN5p9phshIr/2jTJCAjHiYg6t7LDE/h+/AUA4ngzTi+3Veq
         f90Wnlk9RELWWpyuvkNFNVyH5ZpdD0PxhRqyGxn8IwUH0/3Rx0M4sbLRBtx7vhnsWhwL
         4iYS3UGh5QMTu7zO3sGuV8XhBljgQnEgY68NaYvQzG4GunJGEgNnNCzqucKqNYvxTuqR
         OLceQ6aJvN25s6MM6I606djjmO7AIFZ6hfIJMYgNrkaR5JCnYcaam2ujpj1sXWghUZ5Y
         WuBXEbX678+ERmqxsfvCGp2CTcXWTO6eP1trrMK1A6PrEZIzi10AKsoSDgS1QzYMWspj
         QJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/GbpGcilhRbIBz3lZyepq1z+kfQkhITwzebLtiCEHUvIIZz5uT2soKyRc1fJAvHovxQt1XVDxcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrK/3ubuuuPYD7iQo0U93V/ruCdfSbdkU/JmlOgzNpSMHR9i4K
	OuYaekLlX2Ak7vcwa/W9KIowLbQDSq4rbVhil1Pf+yaTmApx5qwC
X-Gm-Gg: ASbGncsUggWcPlKzhE3pFBnyBhalaHKnrPtAmxF+nOtuQqbhyZnbbz0LGcknIU0zUez
	rcmdOD5VB/g0WOP3MhAIlhIxx4AIR1GjTg4VJZsZGS1CNQMlUeLKsOHLHkipkuizEk2lpK8OO0H
	t0gRjybaIbOEbpXsgbpert/8tQFw1v/dmF+DqAWIbpUIFqO+uggmOi7SP+sVSTrqOBsXwGMQjNl
	KiiJklOvlLKqHw2dJEePP6Ceh38AHWI54NE2JQyksx7iY/B+RqCE8qkhKsT7N8AqxWlGBfMIpkL
	LPN4PFu9aJNS9KSYnL9c3ZGRN+2ZLDD8dGxZzMZlh1Olyl1zaUAS818ot/JSduyKzOOq
X-Google-Smtp-Source: AGHT+IHqLEivGCVvNMQ6NNhVQpp4h9odmjTAzgocmscHHvn9K6CfBFVwrXAxIVu+9+avU/K/FUwa6Q==
X-Received: by 2002:a05:6402:5290:b0:5dc:cfc5:9324 with SMTP id 4fb4d7f45d1cf-5deaddebf28mr1573710a12.30.1739307734700;
        Tue, 11 Feb 2025 13:02:14 -0800 (PST)
Received: from [192.168.1.23] (146.10-240-81.adsl-dyn.isp.belgacom.be. [81.240.10.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e70bfsm1132746466b.104.2025.02.11.13.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 13:02:14 -0800 (PST)
Message-ID: <fc9e1b15-ed1a-4d7f-aee7-7687e4deaa91@gmail.com>
Date: Tue, 11 Feb 2025 22:02:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/4] power: supply: axp20x_battery: Update temp sensor
 for AXP717 from device tree
To: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, lee@kernel.org,
 samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, sre@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20250204155835.161973-1-macroalpha82@gmail.com>
 <20250204155835.161973-4-macroalpha82@gmail.com>
Content-Language: en-US
From: Philippe Simons <simons.philippe@gmail.com>
In-Reply-To: <20250204155835.161973-4-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested on Allwinner H700 devices.

Tested-by: Philippe Simons <simons.philippe@gmail.com>

On 04/02/2025 16:58, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Allow a boolean property of "x-powers,no-thermistor" to specify devices
> where the ts pin is not connected to anything. This works around an
> issue found with some devices where the efuse is not programmed
> correctly from the factory or when the register gets set erroneously.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   drivers/power/supply/axp20x_battery.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index 3c3158f31a48..f4cf129a0b68 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -89,6 +89,8 @@
>   #define AXP717_BAT_CC_MIN_UA		0
>   #define AXP717_BAT_CC_MAX_UA		3008000
>   
> +#define AXP717_TS_PIN_DISABLE		BIT(4)
> +
>   struct axp20x_batt_ps;
>   
>   struct axp_data {
> @@ -117,6 +119,7 @@ struct axp20x_batt_ps {
>   	/* Maximum constant charge current */
>   	unsigned int max_ccc;
>   	const struct axp_data	*data;
> +	bool ts_disable;
>   };
>   
>   static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> @@ -984,6 +987,24 @@ static void axp717_set_battery_info(struct platform_device *pdev,
>   	int ccc = info->constant_charge_current_max_ua;
>   	int val;
>   
> +	axp_batt->ts_disable = (device_property_read_bool(axp_batt->dev,
> +							  "x-powers,no-thermistor"));
> +
> +	/*
> +	 * Under rare conditions an incorrectly programmed efuse for
> +	 * the temp sensor on the PMIC may trigger a fault condition.
> +	 * Allow users to hard-code if the ts pin is not used to work
> +	 * around this problem. Note that this requires the battery
> +	 * be correctly defined in the device tree with a monitored
> +	 * battery node.
> +	 */
> +	if (axp_batt->ts_disable) {
> +		regmap_update_bits(axp_batt->regmap,
> +				   AXP717_TS_PIN_CFG,
> +				   AXP717_TS_PIN_DISABLE,
> +				   AXP717_TS_PIN_DISABLE);
> +	}
> +
>   	if (vmin > 0 && axp717_set_voltage_min_design(axp_batt, vmin))
>   		dev_err(&pdev->dev,
>   			"couldn't set voltage_min_design\n");

