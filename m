Return-Path: <linux-pm+bounces-10999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCE892EB37
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF761C21A4F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231016A95A;
	Thu, 11 Jul 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fT4KpS0v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0914B95A
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710153; cv=none; b=EB4CZI3DZjpF7BVIHjdiSajt/toLh2Bnt53TaZbBsgR98PToeWeEt9YPa+XVxx0vDyp+cTLO9NBH3DCyp2keBuGnLDzjDHQI5W2SlK0vLDrTW1SMRzFZPEH1sLgsXlynmILIfb8EF0x+8a4UgR0jPc1Vfie08HkWmPsuOqtkmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710153; c=relaxed/simple;
	bh=ytn6MCNLOHTbSsoVE/5vS2Wi1bcMT3Of3X6JXR9MYzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VA3Dbgehl5ZfN8lf53hhOYd5UTxDrMUxB+uco9h54OdqgqC0ckXdBvgYRTluyhkPE9OTQ1PLUhlMocUJIz91bYYI1d/u6Y6grT+ow4ycRJJRCZoXkardjNnFH+EBqs6RscyJZZV8Txg0vyiYBj7wtX3s96LgZlhKvPIlTq9xDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fT4KpS0v; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-356c4e926a3so593962f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720710149; x=1721314949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9dvNcQBnTEKo5779z6bXahpogw3lKW0g8cNRqRNDfY=;
        b=fT4KpS0vs+5wp5Uxv8J7Z4NDrT3HKzNrFKbcL5JrGOsXtcbUjJ59Tq1keAAs9v/WSE
         EqqEv07ycwCksOWpNxWe+Mdqu3svJsSdN3GFYeZ/JmcjvCOo4glXcyN40uWRcqBXnbMD
         Ll79nA7vR2vKN5c/kDKSM/KJiBJF91LMKwcS51Sp/LXR4PBmKM/dLPLkWcu4w+RYAnsa
         qV8LP8p4FazTl5Kfwslc92mhTWZLE2v9uIZ+JjsxrGTTcHAnJyP5QGqRNNzsNI4JtOGG
         yWTnZsY4MlvFIPv5OmqLbx5r9xdQRbzR++V2MvyHrFonOiZ2L74GfTXbVm5rgIeOboVT
         Wmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710149; x=1721314949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9dvNcQBnTEKo5779z6bXahpogw3lKW0g8cNRqRNDfY=;
        b=kDLJ3Zw0aUpqEf95UFWv6ok71j0NlcO/U+mkM0i24D6m4Rm4LIcMg562wmH9lLi6OM
         xl4mOKfFJ7Qx4iEClWNbe4FJAg/b4G4y2N8bKBP5LZjBewWILw2NpWGYSsgdkbaVNYDc
         8Ynobzu8vM5OGleGpl9ik6Jy7JlS/YRqxlDo5PNceAQM3pd9L+8+M7QuAeUViV3oO23k
         7oBuq9xPNShTfFj5qq3MElWKq9jUbS7oOL8emDO48n9qkvjnr8g7jBWDqIfxdzf3S7H/
         iZddYD5YWDhkVYwuE+LsXjO6g2V/1WVK9bFmDOL4GGESCIeK0qer1VTtOxSoxtQlIqkC
         LuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4+HQgXIMrPC0MTXLXLdM1Bmkurlt4O31hKTn/9JLW4mI5Rq4Nw+bgsQd8Sma6Tl2IsTlzldir0m+GGK6K8DwmUipDQc62SGM=
X-Gm-Message-State: AOJu0Yxi54vDGcZYs4YDBwpozC9qXDbJvWTiGjhRWunUQRgTJ+f/1teV
	EB/ca1emhkPzqu8jKcrhkPGaX9jFn5CSVRc14SdOdPlAW8UafG0WAey1M3C0ts4s+btN+bPk6U0
	V
X-Google-Smtp-Source: AGHT+IHwmwu3bRx0O4YEQnb4PenjONpIPFN8JuuvvCEEWdmNgUSd3YYB9OebCozI32YS26uXCptgww==
X-Received: by 2002:adf:e88f:0:b0:364:8568:f843 with SMTP id ffacd0b85a97d-367ceadb1ffmr5532820f8f.59.1720710148951;
        Thu, 11 Jul 2024 08:02:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5271:58fd:a8cb:b4aa? ([2a05:6e02:1041:c10:5271:58fd:a8cb:b4aa])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-367cde848e7sm7882574f8f.44.2024.07.11.08.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 08:02:28 -0700 (PDT)
Message-ID: <fe954bb1-c6d1-4534-8f5e-eb965de19475@linaro.org>
Date: Thu, 11 Jul 2024 17:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: core: Add sanity checks for polling_delay and
 passive_delay
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5802156.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5802156.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/07/2024 14:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If polling_delay is nonzero and passive_delay is greater than
> polling_delay, the thermal zone temperature will be updated less
> often when tz->passive is nonzero, which is not as expected.  Make
> the thermal zone registration fail with -EINVAL in that case as
> this is a clear thermal zone configuration mistake.
> 
> If polling_delay is nonzero and passive_delay is 0, which is regarded
> as a valid thermal zone configuration, the thermal zone will use polling
> except when tz->passive is nonzero.  However, the expected behavior in
> that case is to continue temperature polling with the same delay value
> regardless of tz->passive, so set passive_delay to the polling_delay
> value then.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> 
> This supersedes
> 
> https://lore.kernel.org/linux-pm/4940808.31r3eYUQgx@rjwysocki.net/
> 
> ---
>   drivers/thermal/thermal_core.c |    8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1391,6 +1391,14 @@ thermal_zone_device_register_with_trips(
>   	if (num_trips > 0 && !trips)
>   		return ERR_PTR(-EINVAL);
>   
> +	if (polling_delay) {
> +		if (passive_delay > polling_delay)
> +			return ERR_PTR(-EINVAL);
> +
> +		if (!passive_delay)
> +			passive_delay = polling_delay;
> +	}
> +
>   	if (!thermal_class)
>   		return ERR_PTR(-ENODEV);
>   
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


