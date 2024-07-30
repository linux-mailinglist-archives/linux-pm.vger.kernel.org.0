Return-Path: <linux-pm+bounces-11682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FA29414EF
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70BE1C22E41
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86E1A2540;
	Tue, 30 Jul 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBXqE7pM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3219E83E
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351447; cv=none; b=s135wAQOTwpaZJnHwr9kNm1bCX9BP0XBIxorW8n8GfnXKWg3MOfjsWcVyrqRIde8vwXFm19JeDzRFfU3bmrlUCrbXiGtGABqRs9EpjaNaOGq2zMGvf6z6c41HWknYfktFnCAa+KGbvMkRf4AOpKV7x1sHPDeJkZsvTL/HGNlG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351447; c=relaxed/simple;
	bh=MNyIklkvk5eNrbXx1HAIESYmSdzQGisP3oacgmCWrJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEekcWE1qtZG6GhOxcINFrSgQWrb13yFB7iGWRWb81A2h4yl/B1pi1ES42RlWc+xiYRTri4uYtcawLM0Ae8FQ3vACL1avibROTio3f4URAfSFXZ5FO8HUm/1PmlfB7HcGpxoPyPH5NklIucu/K/HPHZu07zOHjQQWnCM92F/pZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBXqE7pM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-368440b073bso1985163f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722351443; x=1722956243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQkDwkMKeHB3gfeZECnxLbG2/UiCvD08G2Fc8wZUh4Q=;
        b=DBXqE7pMmv/a2ruOPbY13Np+OuXij5rE17wlqZzYl3pymE3ST491zFLvYwkULMd6nS
         mM6J5jx++J7ARxcFocBBPzBBnEK9oYMTZSqc48jNGN/i8EgBKyE0jpEx3kqvFncJmAbz
         5p7ceCP7h41RTJWHjjrJfUBIbwpPNR6t64LtyjTXB6xeNEOoK6FpL9YrJ2abktTBKAAZ
         75RW19eYN76HNleqS5/SKD3Y+lpPkNd/xVvzOxztjlJJgVusUS3kxRsJDjBIFndcE749
         1F44WNHtPLZDz5prheSaI//+oTcQn9ss64pEsAic4x1pvo4Op35m3Ar45/6bmZdepIl2
         CEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351443; x=1722956243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQkDwkMKeHB3gfeZECnxLbG2/UiCvD08G2Fc8wZUh4Q=;
        b=E+KWJFRI5WaQoGUW5tVzQFyYq8Khcev8CU30PdDMBzJQT8EdmVumdherU+UUBjvznh
         oz2RqrWhmqadJEot1ZlVDCtx0yXjjCl/fAxGP67ptPjPrfoSlYp9ZEEPOokxPiTkCmHM
         pA70wSf5Q2rhCYyKEEmZRaX8oOWVNiKUSsPYkNEpyuUFa6BAlNDx3uLAm+/9X7nr8m26
         frQrknEJHnNQz309DvSrmsWtg4hNvv4uoDmOdTYPsV9WnLvuc4EUP8zkEccYNkaFTlwO
         OitSiJK9xmv5/QVcpBZTWGGZ2+zx8WBYnSvueNiEamingEoonrR0UotEY4SzTzUXtqF4
         /qwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU3xQOg8i9K8qT3c51yBPt8JRxEW7rBkKK4KooPJcy0ouYR1T1sBa+G52rFWc/vDIh8mI6qrT8P6keipfQVBAvQpENuOQcEFg=
X-Gm-Message-State: AOJu0YwGi8vA7ZQlmY/nVHHDyUn+dPZDg666OUFFnUy5/cy/7tGACdSa
	/A2P/7r4nmqhKbkXVTAFsWLVYEBQRn7wV+xcFIhNNFktNPTK6Jb0cGPx8Y/IzX0=
X-Google-Smtp-Source: AGHT+IE8K5z3y5NAb85msPqG0Tkidle9ZyftH1V9Ip7movF2FO60IW4SMO/JQ0qbCQRYVV7qKFrV1w==
X-Received: by 2002:adf:b1da:0:b0:360:7856:fa62 with SMTP id ffacd0b85a97d-36b8c8e99e0mr1439005f8f.15.1722351442739;
        Tue, 30 Jul 2024 07:57:22 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42808f684d0sm196227775e9.6.2024.07.30.07.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 07:57:22 -0700 (PDT)
Message-ID: <4448b729-5998-440c-939e-08e719070ac5@linaro.org>
Date: Tue, 30 Jul 2024 16:57:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Avoid skipping trips in
 thermal_zone_set_trips()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <12509184.O9o76ZdvQC@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12509184.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/07/2024 16:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Say there are 3 trip points A, B, C sorted in ascending temperature
> order with no hysteresis.  If the zone temerature is exactly equal to
> B, thermal_zone_set_trips() will set the boundaries to A and C and the
> hardware will not catch any crossing of B (either way) until either A
> or C is crossed and the boundaries are changed.

When the temperature is B, an interrupt fired which led to the 
thermal_zone_update() and in turn it calls thermal_zone_set_trips()

As the current temperature is equal to trip B, it makes sense to set A 
and C, as B has been processes when handling the thermal trips right 
before calling thermal_zone_set_trips()

I'm failing to understand the issue you describe

Were you able to reproduce the issue with emul_temp ?


> To avoid that, use non-strict inequalities when comparing the trip
> threshold to the zone temperature in thermal_zone_set_trips().
> 
> In the example above, it will cause both boundaries to be set to B,
> which is desirable because an interrupt will trigger when the zone
> temperature becomes different from B regardless of which way it goes.
> That will allow a new interval to be set depending on the direction of
> the zone temperature change.
> 
> Fixes: 893bae92237d ("thermal: trip: Make thermal_zone_set_trips() use trip thresholds")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> 6.11-rc material.
> 
> ---
>   drivers/thermal/thermal_trip.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -82,10 +82,10 @@ void thermal_zone_set_trips(struct therm
>   		return;
>   
>   	for_each_trip_desc(tz, td) {
> -		if (td->threshold < tz->temperature && td->threshold > low)
> +		if (td->threshold <= tz->temperature && td->threshold > low)
>   			low = td->threshold;
>   
> -		if (td->threshold > tz->temperature && td->threshold < high)
> +		if (td->threshold >= tz->temperature && td->threshold < high)
>   			high = td->threshold;
>   	}
>   
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


