Return-Path: <linux-pm+bounces-24154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB9DA64EB3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AC2188BB2D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 12:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616123956A;
	Mon, 17 Mar 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXQthMvd"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB3214A8F
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214423; cv=none; b=q6L4+mfGSfxwN2bLfj5k1GylhaMdVNjsBB1cYBeAcQRV54n5qAfU5EfNX7nmZ2EBeVJx/4rDngaXhlvydAJgdSmLj3ugkmUkkzw1r7kz1orp3HOkDSV/1LP94QMlYlQb5w59KoLA6vrMaV830FCsmU1J45ku8wZyboDXMoj3uEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214423; c=relaxed/simple;
	bh=Vic61tvV7K+zZ66KhZ9Nn4YiXR+6vfw+HabXpTBZ+bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS598XPdqjiw/E+LGjlgDoYf0VQ+0KxxgJqAZpiUPsLoR1asXXcS5u2lsh0Vz2cVck5Sb7aFoqJgf44J5cRQiMcx28FpzDdxVWstty1rWYLoMRDwM+E+fli6rYCvUjyfm/rQttR8f+jtX9XvaVWheOYtNWHrcvNqE/sva/dLKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXQthMvd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742214420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gq/3oDcqRFjbGO554tsErOa27UmZsBKNvIRH2SBUzQs=;
	b=iXQthMvdafA9nunsLX1q3nOo+vmj3TCeaxDv29rPXvWd1xdo2ZFmYYN9JM6ajaLveCXmVG
	+loo7RTJM0iYJoNS+ZZ3VI+bxJBtCO/ftyJjGmcLe/ZU337dc1yU/aTrbA3wtU5tTCbWLb
	LDzg1wZVoc+02RfYZrRahFG1zoqnxe8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-Yvd7F9D5M7ef-YwwF9GI3A-1; Mon, 17 Mar 2025 08:26:59 -0400
X-MC-Unique: Yvd7F9D5M7ef-YwwF9GI3A-1
X-Mimecast-MFC-AGG-ID: Yvd7F9D5M7ef-YwwF9GI3A_1742214418
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abf4c4294b0so445698466b.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 05:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742214418; x=1742819218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gq/3oDcqRFjbGO554tsErOa27UmZsBKNvIRH2SBUzQs=;
        b=RQfVMdLlooqcpcZgMZGGP5wrkWx3f4qVoLSNhfA27JC1njM/3mc3X0kAYKlbd2Pgwk
         QcCwvUbwDpNon/teANhEgUN3wwyFwTgMTQxgtV/eyL7uUAgzXPaLMhEjs6nyP3S8Rfda
         AzIqXsTWwXefmLc2zkfvYaJ67FBjCC69KuKNDayVbwLF+x6fw/DW33B3L6oc3H5XgUoz
         QGTsUFcmqhzmKVszz67iPgg5h243Ac8m1dbi2O/X8H/aFfUrqMUW9z5Tr2n5J4+0BSmF
         8lYGbYVUwO7efE7MmPN7GKrACgix2QdZl51dpdNEasO3voRwPd3QAfT9IT4Ubj6P3Vsi
         tC7g==
X-Forwarded-Encrypted: i=1; AJvYcCXmfOzoLetnedHHA/AJG6mU89qWigwh8IvJ72svmYW+Xa0TPN7CsG+A5H2RFUw9tY+SqQSLITTgzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45iz6XS3Fj6diHCh/dfCzak1OZIfneB2RsrxBp0tUvoJY9tdl
	WX3IqRjwrWQ/FMJ+NkblA8HVkoJX+jsQO6oVX+Jt8I/pQjbrIzipJm6YntH3XnH65c4AeJZvxI0
	J+eOs25KP/rOL5gsRKQShplL+q3vAN0Ib2rbentipKzhnZ/Kd8RbIN3er
X-Gm-Gg: ASbGncvC7E4u5fjuPRDsnYE7Ui6R3/+mGClsOjSMUl6MCvv2BoX7ykjrw+H5QC3JmMu
	amzNaiZm1ZUiSdKHUoI+OrhNqP6aKeAwVoUWEPMUVEB2vNmYTrfREtz/4nqMcnac6RwvIz2DJcf
	TpuBhJuJb1ewmOazaoUuARWE/DQGT56FOAeF+P5Eit421MhplernSJnL8HeqdihaPvkP/rcoX51
	7+5R5vLRuRGJ6yZXaE0xWYoYZnrRWGJ4rDXt1L1J0Fd9micky1GQdWkUIwrTiCRGIZ8uI/49I6z
	T52+Xekw5ZU7h2VrhcE=
X-Received: by 2002:a17:907:1784:b0:ac2:d1bd:3296 with SMTP id a640c23a62f3a-ac3122c9347mr1739014766b.10.1742214418200;
        Mon, 17 Mar 2025 05:26:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSAvM62Zyz90XQdYPLgsDArMxRRO1V+0sKnFycYqInMYtAjSRZs8HD7Xb01ze8pexMuvtFOg==
X-Received: by 2002:a17:907:1784:b0:ac2:d1bd:3296 with SMTP id a640c23a62f3a-ac3122c9347mr1739011866b.10.1742214417791;
        Mon, 17 Mar 2025 05:26:57 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad3d53sm5823562a12.52.2025.03.17.05.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:26:57 -0700 (PDT)
Message-ID: <b1ac8a33-06ed-482a-b5f6-ca88eb3802a1@redhat.com>
Date: Mon, 17 Mar 2025 13:26:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] power: supply: add inhibit-charge-s0 to
 charge_behaviour
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
References: <20250311165406.331046-1-lkml@antheas.dev>
 <20250311165406.331046-6-lkml@antheas.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250311165406.331046-6-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Antheas,

On 11-Mar-25 17:53, Antheas Kapenekakis wrote:
> OneXPlayer devices have a charge bypass

The term "charge bypass" is typically used for the case where the
external charger gets directly connected to the battery cells,
bypassing the charge-IC inside the device, in making
the external charger directly responsible for battery/charge
management.

Yet you name the feature inhibit charge, so I guess it simply
disables charging of the battery rather then doing an actual
chaerger-IC bypass ?

Assuming I have this correct, please stop using the term
charge-bypass as that has a specific (different) meaning.

> feature
> that allows the user to select between it being
> active always or only when the device is on.
> 
> Therefore, add attribute inhibit-charge-s0 to
> charge_behaviour to allow the user to select
> that bypass should only be on when the device is

Also don't use bypass here please.

> in the s0 state.
> 
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  drivers/power/supply/test_power.c           |  1 +
>  include/linux/power_supply.h                |  1 +
>  4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 2a5c1a09a28f..4a187ca11f92 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -508,11 +508,12 @@ Description:
>  		Access: Read, Write
>  
>  		Valid values:
> -			================ ====================================
> -			auto:            Charge normally, respect thresholds
> -			inhibit-charge:  Do not charge while AC is attached
> -			force-discharge: Force discharge while AC is attached
> -			================ ====================================
> +			================== =====================================
> +			auto:              Charge normally, respect thresholds
> +			inhibit-charge:    Do not charge while AC is attached
> +			inhibit-charge-s0: same as inhibit-charge but only in S0

Only in S0 suggests that charging gets disabled when the device is on / in-use,
I guess this is intended to avoid generating extra heat while the device is on?

What about when the device is suspended, should the battery charge then ?

On x86 we've 2 sorts of suspends S3, and the current name suggests that the
device will charge (no inhibit) then. But modern hw almost always uses
s0i3 / suspend to idle suspend and the name suggests charging would then
still be inhibited?

Also s0 is an ACPI specific term, so basically 2 remarks here:

1. The name should probably be "inhibit-charge-when-on" since the power_supply
   calls is platform agnositic and "S0" is not.

2. We need to clearly define what happens when the device is suspended and then
   make sure that the driver matches this (e.g. if we want to *not* inhibit during
   suspend we may need to turn this feature off during suspend).

Regards,

Hans



> +			force-discharge:   Force discharge while AC is attached
> +			================== =====================================
>  
>  What:		/sys/class/power_supply/<supply_name>/technology
>  Date:		May 2007
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index edb058c19c9c..1a98fc26ce96 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -140,6 +140,7 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
>  static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]		= "auto",
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]	= "inhibit-charge",
> +	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0]	= "inhibit-charge-s0",
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE]	= "force-discharge",
>  };
>  
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
> index 2a975a110f48..4bc5ab84a9d6 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -214,6 +214,7 @@ static const struct power_supply_desc test_power_desc[] = {
>  		.property_is_writeable = test_power_battery_property_is_writeable,
>  		.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
>  				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
> +				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0)
>  				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
>  	},
>  	[TEST_USB] = {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 6ed53b292162..b1ca5e148759 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -212,6 +212,7 @@ enum power_supply_usb_type {
>  enum power_supply_charge_behaviour {
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
> +	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0,
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
>  };
>  


