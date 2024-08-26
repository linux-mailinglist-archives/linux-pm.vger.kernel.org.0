Return-Path: <linux-pm+bounces-12881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC12895F3CA
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 16:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2677B21C8E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5818BBBF;
	Mon, 26 Aug 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTaHrBPj"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F918757A
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682362; cv=none; b=llJ5OJg74o3fsN14BqPMhT+YW5uSCFk4u2Uh45tSqaxw9uqpJoV7+qRkBNDbI80PTfqfZIGCwH9gBI/xsuuyKSbosH5GXwzzS2Um+AEj6cR4UWhtD6gH3w/aYCw3enG7GBnBq3RCEvwijsRTxZ8+SXjjctetGaPovzlLp6zJrrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682362; c=relaxed/simple;
	bh=M3+icb9ze2b0j3muau5Wzrz2Mr5zDjVxwMH/uJIEUY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcgBVo6AzHlUkneUjUz5Gs97nToCsCmUnNXyHxjN0ztfU5PvdN1LWyHd//7rG8Inp2/w7XzyPiOf6Bns9RDnGoWIxSlGiRh8gk+jzE9X6uykP3FelRH+PniPYVJbezdm+y/CH99gaX1WYPujAztrYh9vjMpxUergXxBMcd81z38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTaHrBPj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724682359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4owlqzaXy+TQHLAvRQqMwPaAPqTMmEvJ75N++pfFPMs=;
	b=DTaHrBPjZXh2wh9xlVaAdYf50eRzJP4GbLZmATjvegLgk32cc0Olo90YpeScN+SCE6YqMm
	bCVnoMPrFIJtTbHIwi+UmyrTtHWQgmlr7ejhmj1KA47EposzswVWVABFqb0YVpNqFNxXf+
	w2mIKW9pB7fMQ8IWyAn4nMJEIgJDMQI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-peZfMhWzOq-vC-K24AR9dQ-1; Mon, 26 Aug 2024 10:25:58 -0400
X-MC-Unique: peZfMhWzOq-vC-K24AR9dQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a868403dbdeso316221866b.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 07:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682357; x=1725287157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4owlqzaXy+TQHLAvRQqMwPaAPqTMmEvJ75N++pfFPMs=;
        b=u2Sk4R1rJ1CQwUYg2fDKDl6XFz6ebVp3vKXxMimWho9zVgy4W3y3CFiVVPPAPYOpFZ
         qT/TrYw4bnmE74dq+f8O51wwUvUO3sDRanUanhNxTVb9IexrGw9rni+8lRLGEnrmVixw
         bUcjPCce3E2L0KYc7j3zuy9DFCNoYPXjTq1vk9wt+NdNQ+pxaTXyR0AB6UVQbU4PQDD8
         KL2zVKRVyn+2aRqnoNtIf+Ef+L1ZOwW8FxRRNXGEM1WjpGMyrVKAZ87fntIBQxtSDLfH
         nA5JfrjlXsVqlR5DDfBMKAMesjRpWluFXFTTDAZQTDZIPDBLJHMfs6yRh+JO/3MEZUee
         V9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZt8NVPM9Hz5bTvOZjjSGirWMpcErn0c602dIYPA/lXmb5R0t0bUoZ3/AtJd1RpQxxw6i1pbayjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSY9ugWaU5+Yka8hUMMMnkP+58Xr4cxhzHnDrCo08LlqEJgTNS
	m3+6ipwyDib3YqCbJ1w/nETKrtfSl5kwiRM5O96xpPLWdpjJg/vC69EhO3+wtJ2F9LqptYwcvJC
	ShBDM6GCHacL+IBoxBtf72CYMUqnX1ZacfLo9uj3GwExXntCSFx0iGtkl
X-Received: by 2002:a17:906:dac4:b0:a86:ad8b:3511 with SMTP id a640c23a62f3a-a86ad8b3797mr753865366b.49.1724682357065;
        Mon, 26 Aug 2024 07:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdVXOvL8B4z58VMuOlhm1uu9XVsyzdxS83WY3dIcs/VgLKIZR7OM3EgZdMBSAHupB7xLQTuw==
X-Received: by 2002:a17:906:dac4:b0:a86:ad8b:3511 with SMTP id a640c23a62f3a-a86ad8b3797mr753862466b.49.1724682356519;
        Mon, 26 Aug 2024 07:25:56 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484b5csm667649666b.164.2024.08.26.07.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:25:55 -0700 (PDT)
Message-ID: <f4313bb4-3f80-4bba-b6c2-7dcdeddf4303@redhat.com>
Date: Mon, 26 Aug 2024 16:25:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ABI: testing: sysfs-class-power: clarify charge_type
 documentation
To: Andres Salomon <dilinger@queued.net>, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
References: <20240820041942.30ed42f3@5400>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240820041942.30ed42f3@5400>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/20/24 10:19 AM, Andres Salomon wrote:
> The existing docs here are a bit vague. This reformats and rewords it,
> and is based upon the wording originally used by the dell-laptop driver
> battery documentation and also sysfs-class-power-wilco.
> 
> The wording for "Long Life" and "Bypass" remain the same, because I'm
> unfamiliar with hardware that use them.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  Documentation/ABI/testing/sysfs-class-power | 38 +++++++++++++++------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 7c81f0a25a48..84973f66b42c 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -377,17 +377,33 @@ What:		/sys/class/power_supply/<supply_name>/charge_type
>  Date:		July 2009
>  Contact:	linux-pm@vger.kernel.org
>  Description:
> -		Represents the type of charging currently being applied to the
> -		battery. "Trickle", "Fast", and "Standard" all mean different
> -		charging speeds. "Adaptive" means that the charger uses some
> -		algorithm to adjust the charge rate dynamically, without
> -		any user configuration required. "Custom" means that the charger
> -		uses the charge_control_* properties as configuration for some
> -		different algorithm. "Long Life" means the charger reduces its
> -		charging rate in order to prolong the battery health. "Bypass"
> -		means the charger bypasses the charging path around the
> -		integrated converter allowing for a "smart" wall adaptor to
> -		perform the power conversion externally.
> +		Select the charging algorithm to use for a battery.
> +
> +		Standard:
> +			Fully charge the battery at a moderate rate.
> +		Fast:
> +			Quickly charge the battery using fast-charge
> +			technology. This is typically harder on the battery
> +			than standard charging and may lower its lifespan.
> +		Trickle:
> +			Users who primarily operate the system while
> +			plugged into an external power source can extend
> +			battery life with this mode. Vendor tooling may
> +			call this "Primarily AC Use".
> +		Adaptive:
> +			Automatically optimize battery charge rate based
> +			on typical usage pattern.
> +		Custom:
> +			Use the charge_control_* properties to determine
> +			when to start and stop charging. Advanced users
> +			can use this to drastically extend battery life.
> +		Long Life:
> +			The charger reduces its charging rate in order to
> +			prolong the battery health.
> +		Bypass:
> +			The charger bypasses the charging path around the
> +			integrated converter allowing for a "smart" wall
> +			adaptor to perform the power conversion externally.
>  
>  		Access: Read, Write
>  


