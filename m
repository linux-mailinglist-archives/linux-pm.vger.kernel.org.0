Return-Path: <linux-pm+bounces-10541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE8926020
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 14:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229991C21B0C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A0F175555;
	Wed,  3 Jul 2024 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEy79cb8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39E172798
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009276; cv=none; b=kGtEPVgOCRb4d6JtS67rWnFRpqdVVkUhdWM1H7cwkXL87wX3TlwyVkKyWQV+smpKr4zIiZHOL3f+3u5H6vhn7FMnVaghpRMk6+G9XuWqvn85NhEpEYcaf1GW5TXrafSy3dvc2hekQyu7TXOwIEgyn2VEK7Uod8q1vDQNoiHLzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009276; c=relaxed/simple;
	bh=cubV7PSPhJbJ+Qx4nqp+Dd4OkcCI8xjyljP7mHG1qOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlY6HogA75Oh8EmImy67TE+X6kz6hHJDMOBGeAW7LO4pq1gIC8sDWwHvgSAd3+lgrYo9DSuwODy0eHZ2Z0yLLLk0frvi+fXF04G/DQzuwUMS4s+PUXwRjGsrt4LvHeE9xIOnCk1yLn2pzBWe5sGbNcdgNiBweoJZqxatvEFSfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hEy79cb8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso7603293e87.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720009273; x=1720614073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+m8M3n1qsYckd6mSAf4YNSgVy1Uh2copyKJHcyhOiQ4=;
        b=hEy79cb8yCJ8LpfHgReutG402o3o3xLWz7STVx0R/B3rn65FjszZrjBQxYYH3MrhTE
         DQhYL/cXr7YJ6HOicYRPOEu1X7fR3qYTDxEMWg/Er2X2Ob59fqs24HQiHNBLyP/rnjPt
         l0kCQk9Rl2UtTp4wn4/AAoJNth0A1gayb2k8W7JhFus7uoivwhOMaaeF2J3m2b4R58NY
         rnWDwkUxkWij2fN4xabWLO8ff5qLOMZEvDFlir+T4A4DtlVFvkEslEvumD9Vljre0s3i
         yJeDMj9yfHLdbcXSB0KzPGUKBGOpc8hCHTz0hqwZB6yKnS5q64Ib4Y6DXZnwemvHgNgZ
         rX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720009273; x=1720614073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+m8M3n1qsYckd6mSAf4YNSgVy1Uh2copyKJHcyhOiQ4=;
        b=AjcNDx9G7Qe2sxoWfxBZrADfapLS0TdZ5mpFYIlLve/Tua+Ua1DT++A0KCrZ2C1mxf
         ashxu1H4f4vUlEDQf7dhBNQVdCKcvmn0rRehJPsVW6Y3bx2jocnnb5OpbhN6Pe1YuaPH
         /lt0+LVoIJHBPWM/GLr3A7guDfxNE1KpedOWT2qXM50USl9OHf6JVLpm7RLCtz4JZjaf
         BNg29tEe0HSUJid051D0f3yypE2GelH6l9mq67NnnTGY5OVl0L439zUnKe7Tqr0tkuFt
         Iv9X5pvV8XU/DCDSSzSTM6nMlABguE7SQKC9ed1Kmm8tmzgjZn53ZWvsKa4XLq/l/Ly7
         EALg==
X-Forwarded-Encrypted: i=1; AJvYcCXgGgZhLSeQL2kmoATd9uvKZYvZJewiy3FBXZ+eQunUj3PJavpx3DRH0fOcHn81jI6NmAQ2EpmRPbhqhVyRJ6ltY6Md2RrpzJg=
X-Gm-Message-State: AOJu0YwvWXHtqoBVcY5ohs06gZQreJ9ej67qNZSj/GySfNwchlsERRu2
	BVNTXDfUPoNi97tFTLttr6XF/ebfExgR2bwqUmtxnzE3k+LNJUKpn/gq8RapViA=
X-Google-Smtp-Source: AGHT+IGoCrWnpI4H3vkYZIW4U5GwbaIxS3AV0bKKM6IK+U0+ym4oAlShp5iDrd+SuM0Al6aqGSLjKA==
X-Received: by 2002:a05:6512:3988:b0:52c:f2e0:db23 with SMTP id 2adb3069b0e04-52e826886a0mr8508503e87.40.1720009272232;
        Wed, 03 Jul 2024 05:21:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256b0c19eesm243158405e9.45.2024.07.03.05.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:21:11 -0700 (PDT)
Message-ID: <47440afc-1b76-4dff-8c72-427103d7184a@linaro.org>
Date: Wed, 3 Jul 2024 14:21:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 4/5] thermal: imx: Drop critical trip check
 from imx_set_trip_temp()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-wireless@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <1890956.tdWV9SEqCh@rjwysocki.net>
 <2272035.iZASKD2KPV@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2272035.iZASKD2KPV@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/07/2024 16:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because the IMX thermal driver does not flag its critical trip as
> writable, imx_set_trip_temp() will never be invoked for it and so the
> critical trip check can be dropped from there.

And as a rule of thumb, we should not allow writing the critical trip 
point temperature in the thermal core code.

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/imx_thermal.c |    9 ---------
>   1 file changed, 9 deletions(-)
> 
> Index: linux-pm/drivers/thermal/imx_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/imx_thermal.c
> +++ linux-pm/drivers/thermal/imx_thermal.c
> @@ -335,21 +335,12 @@ static int imx_set_trip_temp(struct ther
>   			     int temp)
>   {
>   	struct imx_thermal_data *data = thermal_zone_device_priv(tz);
> -	struct thermal_trip trip;
>   	int ret;
>   
>   	ret = pm_runtime_resume_and_get(data->dev);
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> -	if (ret)
> -		return ret;
> -
> -	/* do not allow changing critical threshold */
> -	if (trip.type == THERMAL_TRIP_CRITICAL)
> -		return -EPERM;
> -
>   	/* do not allow passive to be set higher than critical */
>   	if (temp < 0 || temp > trips[IMX_TRIP_CRITICAL].temperature)
>   		return -EINVAL;
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


