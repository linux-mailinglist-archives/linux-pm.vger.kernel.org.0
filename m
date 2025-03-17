Return-Path: <linux-pm+bounces-24212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C539BA657B0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 17:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A751C175682
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3503192D8A;
	Mon, 17 Mar 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEhXOilo"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6A188CB1
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227875; cv=none; b=Wk3sX1MolaYuKo3zE3V2XG8wkkrbPejLEVWTv08o5eJ/1DFmpsEyn0co3tNSIAeF7AN7e4N472c8WDSwMZpXVtw70AHFrOdvrxI18hFgtxED+WObZFeEzZY95eIgLWYcKsyAWTpMzrv60WTysU+XtpE/WACvbeHXRZKxvpyvPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227875; c=relaxed/simple;
	bh=Uoc1DrwhFhqKapvK2aZfs21XdFLHjo6sg1n08s0IZcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFkGAWe6R1eysE/aPAeOJbCXgtWndkGtku9sTwjU/u0RJ3ScKPGCoARJkQ8K8N9rFBUuRAr/K+jo6975ZpdeFfkQAVtv/hcGo81jovjk2HwR16ao70yxANTKsmkTouKROFdYFg8oj9yFPa9f+BCkQdlO3PXor3Wop4SKJFNuvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEhXOilo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742227872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMxOns8OLCANHT+gWoMrsh+8iH9de53W50uJK8mjjKs=;
	b=MEhXOiloO8IjTmd4nrxj3uvjB0In4oqAcr5MZqIO0BRCl/nl5OMyI62AGFJNQkjwI/nH/G
	k/StE3ABLkicKUVSU44tXzX5yvwVf3kjKkJzoGbgPo+dfx+HI2T/VrOMFnXN0oQFznDFhB
	b7Uk38Dt9vGCjb7usRS6GIGRiVUK9WA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-_zFdxoy6PSqKnlB95EdUsg-1; Mon, 17 Mar 2025 12:11:11 -0400
X-MC-Unique: _zFdxoy6PSqKnlB95EdUsg-1
X-Mimecast-MFC-AGG-ID: _zFdxoy6PSqKnlB95EdUsg_1742227870
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac2bb3ac7edso512580466b.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 09:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742227870; x=1742832670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMxOns8OLCANHT+gWoMrsh+8iH9de53W50uJK8mjjKs=;
        b=Vl6h6lR4H/B/24eMeSbK+qgFk46McWmhuwKJ9KNPjOtK02/VTm2g0ul+3YN4Py+uzf
         oXChpdrVws38cYHjg0GS35jXd95qR3EJeThyXSvUT4lPtVOh2Bt4gkjEJNDk+pc1Qu55
         AZFpa0WD8mjzIo6BPYrx4ixZuUWfspFDQLkuwsXTVJmQC3odx3KR757s4CZIfGuUt66b
         nO/SlffaDn5orFwtGxRtX/ctRKV60AB9eXWuNRwNLBSl6i/9CRAeqdV4wwnDUgnaXzl8
         uL2/8tAexeVYaFlGEDPjkISa1Bxa316581R0flInp45pVEKIxCihRm4Yd2FaruWPAkHt
         mYpw==
X-Forwarded-Encrypted: i=1; AJvYcCUazc+fhKUUQqICtlvYICSunsIUIfpH261s3PaDkKzqpwfX7XOK8U2pdhLqMIDsIQy/V3fKtp+oww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytcu0rEJRg4q6HBbJ+rtw5H0xJhgQqaIOnf2J9hTD83POIpyy2
	7DzAV3Zmzg4u1kbXgBuh2xT7UJwnrNdihenMLBCDiyQlew8DztIAPVaTuoR0kvQLxpvn6YvVWX4
	RSBsHt7r3BHSXqX+jzgXEPZI+XX2yXF7YUx+7fMdl9oihqwvE3Zgf0HiW
X-Gm-Gg: ASbGncsPlfWiAxqczblYCMQuKjPJ2gE/WZVjiqsRySvxlgnuGzgSndgD2gMvuu+JJAo
	lD/KpNE1/8FsYy9ATjR3YLOzdZrNaiGwzMtJVLfc9Qa9mv4yjaYfDFIvwd/p64Ehp/Ll7FWX2cI
	16anIDrDh1kxI87OWlJKnpnLvE0RUnUdJWd3XnB2qzt8MkuBEcbBb3Gygbce04OtSsDw8DUf/LH
	yBkMFz+q6uKuMuJS8X8/PGXuZ8EcRZCl22PWsEEBe2wJRbA+OtFB1P1mb6Vwdj8EGZR43dfese9
	Pg4bZDI9Zy22x3/K7Zlz0SFhTaDiAIVZC/MLqgo8KpYuy/mTRujN12O4oq8b1zNj/Id6WaYaZiR
	TBprtyLyd9SxJEQRvUTqyPog/2N9bEruMwJHcK2BYLdbzNh6W8K8xg1OrIKJRSh/x5w==
X-Received: by 2002:a17:906:ee85:b0:ac2:d6d1:fe65 with SMTP id a640c23a62f3a-ac38d515007mr31489766b.41.1742227869874;
        Mon, 17 Mar 2025 09:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0sssDA3BQRaSOyamV/S0PXeQ9xKfhQPA6HZicsQtZlhud1G2Kdvgy67YBjeYvH5sJJ0eE7Q==
X-Received: by 2002:a17:906:ee85:b0:ac2:d6d1:fe65 with SMTP id a640c23a62f3a-ac38d515007mr31484766b.41.1742227869395;
        Mon, 17 Mar 2025 09:11:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314858a8fsm676871266b.80.2025.03.17.09.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 09:11:08 -0700 (PDT)
Message-ID: <d9da58be-7a83-4007-8ea7-8c6d6005094a@redhat.com>
Date: Mon, 17 Mar 2025 17:11:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] power: supply: add inhibit-charge-awake to
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
 Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org,
 sre@kernel.org, linux@weissschuh.net
References: <20250317155349.1236188-1-lkml@antheas.dev>
 <20250317155349.1236188-13-lkml@antheas.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250317155349.1236188-13-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 17-Mar-25 4:53 PM, Antheas Kapenekakis wrote:
> OneXPlayer devices have a charge inhibit feature
> that allows the user to select between it being
> active always or only when the device is on.
> 
> Therefore, add attribute inhibit-charge-awake to
> charge_behaviour to allow the user to select
> that charge should be paused only when the device
> is awake.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Thanks, patch looks good to me, FWIW:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  drivers/power/supply/test_power.c           |  1 +
>  include/linux/power_supply.h                |  1 +
>  4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 2a5c1a09a28f9..78afb2422fc5a 100644
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
> +			===================== ========================================
> +			auto:                 Charge normally, respect thresholds
> +			inhibit-charge:       Do not charge while AC is attached
> +			inhibit-charge-awake: inhibit-charge only when device is awake
> +			force-discharge:      Force discharge while AC is attached
> +			===================== ========================================
>  
>  What:		/sys/class/power_supply/<supply_name>/technology
>  Date:		May 2007
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index edb058c19c9c4..8d036faf220ec 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -140,6 +140,7 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
>  static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]		= "auto",
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]	= "inhibit-charge",
> +	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE]	= "inhibit-charge-awake",
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE]	= "force-discharge",
>  };
>  
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
> index 2a975a110f485..958e0c0cf2876 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -214,6 +214,7 @@ static const struct power_supply_desc test_power_desc[] = {
>  		.property_is_writeable = test_power_battery_property_is_writeable,
>  		.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
>  				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
> +				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE)
>  				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
>  	},
>  	[TEST_USB] = {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 6ed53b2921624..bb8e9e62ce834 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -212,6 +212,7 @@ enum power_supply_usb_type {
>  enum power_supply_charge_behaviour {
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
> +	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE,
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
>  };
>  


