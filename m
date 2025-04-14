Return-Path: <linux-pm+bounces-25341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B605A87789
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 07:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDB31890193
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 05:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A7719DFA7;
	Mon, 14 Apr 2025 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auXjx+Gm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434B1990D8;
	Mon, 14 Apr 2025 05:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744609856; cv=none; b=tdXJ5KsNo8XKApE5naHH4mt+a9IQM2r05hZF/ogs5aRSAj62BVlrd0rebh0V4KaK961jxRqPLJVyht0o//In62TYldyEo9e6T20vB90P28cNCTg8kcIhAlFfUTWCh8m2IPxfb31+pHBSxGIhNtN4I63OtIsMWNKOchd4PTeQNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744609856; c=relaxed/simple;
	bh=2Mrd74G8jnzozakHJyUqjNWTFaTsEQFw2FnelXGs4eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvIo1+pch5Q4xQCnZiCz2pMCzN6N1oi3M2odGbmesp02o95iIkq1OyVY8VX3WxK5e59eb4MOK1xCzrO2Ag3CICVl3+wXahd8HVa+xXjwXPovb1jYqMA298Z8MOwb1Ml3h+v7rZQ+MTBCPrKDNkLns6j6odLM9BgNbjip2BFPkOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auXjx+Gm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5499614d3d2so4468514e87.3;
        Sun, 13 Apr 2025 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744609852; x=1745214652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjZiPaurJef/nQ7PXXGeudPtbJ9Ii7WZiGcrpGC547I=;
        b=auXjx+GmqSGJVPahuvNCUuB5zSxOI09ifa0PnxiI6ESujGx2ibNszEKRuj0zj7e8qi
         2BIee82uHSsOzDaot1j0JF9ruhBjIxboNxYSiGmw9l0BcozGP4xchTX9G95CH9mYCgne
         4yyRT40r7ye0m6MX/4W2xfsa7t22HF3nKz2NNTFlvnVokd57spX5VdTlLA5c8LVqom1P
         0euL8HoTvbebvpdB1m7H1ithY9OVFFyBYT9mvWu43qOKaWerWWcaORJ5zUmtE+mt3NFG
         FEuufGtlA2BeEmfsFzVRNiIMC8/oMy2hXqsexDHBwOCOs415SkLhNXW78HRDvju/AloY
         nqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744609852; x=1745214652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjZiPaurJef/nQ7PXXGeudPtbJ9Ii7WZiGcrpGC547I=;
        b=meGSTdCKX/k/3v5VDxjfOUagqEm1rUgKWJ8tZCqZdpXTfsuguTK8uugkO8eisj3rzZ
         JkKBVcQAZWe9rKyzFRKvcW3FdbREYWdectMGiPkdPWZeZoyk9srU1yxayS66rxsB12oA
         nxszit48690jZPGvtptCZuXqQPHEafV44hbQktXrPMmAUDf1lhEPxjngPhwR/DpexoNG
         /UDI28l+b9CxXeDN80KOBpL86QtvnMzpOBSn48iTxdWjXqkYOtw5h9uu1SuE0woagNTH
         rNRQUbhFT7buf5dK/rR1cKjh69FGn+2XINvEgrwOKnsBbJ12+ivCt66xDgMl/OSQGtJ4
         TB4w==
X-Forwarded-Encrypted: i=1; AJvYcCUl/NmsuV8YxSfG93+h0ehmy+F4BmGoEX25R8lPMFtve506EudnFxtBI/aMABMo1hISEjOaL+AqkZltQvM=@vger.kernel.org, AJvYcCVM4svmuWnIkbdaNnRFMZQ4XcCz0IngPVSK+Rl/4+oYv1uHiycDuGU5Q4v568Fy5uYQcUjupQRwkG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuXccHqpitUpTyLl4cIehjBG0F84oMv/j+U1tnQcq6V/Wd1fH8
	N3RXE22hBxpk1r9RLyWS2bV3OtKJFut7IZXcfWywv2U7ZTCV470p
X-Gm-Gg: ASbGncvwWC++ipVbo1hM0s3raY9jMOnE1jwhdYqRw6GMwMnVaEFW6jQdCthCleUVwSM
	21mvdyb1GBKnlXjatMNzyHl3Lb4UX1TZf997BF9ktqAH1Ww0jgZkFGpT5JBw3rEI7F//8XePGbL
	8viQu0bt/nvdi+rGXvPvuHwqIpbjaHS1Gzl49iYFpTJ0ZjgCxOSYqxJgW5A/JNSY5YdMmH6R7dO
	Oe7KSbapNrN9tdi3cWzv1qhoDJg3HYGrCJVqyW3sSFYS+5snbiG5u2ZK0WtIgx4naBt+b+tB+tI
	tIbPIqXrpQbXO6hDh08yMge3sY0joKG0Jvsriek5eXNawF0VeItHxYKHMP9xsr/euALzkQ+UWzW
	yL2+3O6qo2iJ1N5vPFPlBGQ==
X-Google-Smtp-Source: AGHT+IGwehThK/mwC7NzmRgvxhCl43K9ObVWa+VGJVROKVO9BH25ZKpqXCcq49QGDVWL6eOlrdkO9A==
X-Received: by 2002:a05:6512:23a3:b0:54a:fa47:b2a5 with SMTP id 2adb3069b0e04-54d45293cefmr2989067e87.23.1744609852045;
        Sun, 13 Apr 2025 22:50:52 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d123298sm1004252e87.1.2025.04.13.22.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 22:50:51 -0700 (PDT)
Message-ID: <462374bc-a7e7-4660-83aa-5c3b9127a720@gmail.com>
Date: Mon, 14 Apr 2025 08:50:50 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] power: Extend power_on_reason.h for upcoming PSCRR
 framework
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
 Guenter Roeck <groeck@chromium.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, chrome-platform@lists.linux.dev
References: <20250411121757.573419-1-o.rempel@pengutronix.de>
 <20250411121757.573419-2-o.rempel@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250411121757.573419-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 15:17, Oleksij Rempel wrote:
> Prepare for the introduction of the Power State Change Reason Recorder
> (PSCRR)  framework by expanding the power_on_reason.h header. This
> extension includes new power-on reasons:
> - POWER_ON_REASON_OVER_CURRENT for over-current conditions.
> - POWER_ON_REASON_REGULATOR_FAILURE for regulator failures.
> - POWER_ON_REASON_OVER_TEMPERATURE for over temperature situations.
> - POWER_ON_REASON_EC_PANIC for EC panics
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

FWIW:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
> changes v6:
> - add POWER_ON_REASON_EC_PANIC
> - s/POWER_ON_REASON_OVERTEMPERATURE/POWER_ON_REASON_OVER_TEMPERATURE
> ---
>   include/linux/power/power_on_reason.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
> index 95a1ec0c403c..bf9501792696 100644
> --- a/include/linux/power/power_on_reason.h
> +++ b/include/linux/power/power_on_reason.h
> @@ -15,5 +15,9 @@
>   #define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
>   #define POWER_ON_REASON_BROWN_OUT "brown-out reset"
>   #define POWER_ON_REASON_UNKNOWN "unknown reason"
> +#define POWER_ON_REASON_OVER_CURRENT "over current"
> +#define POWER_ON_REASON_REGULATOR_FAILURE "regulator failure"
> +#define POWER_ON_REASON_OVER_TEMPERATURE "over temperature"
> +#define POWER_ON_REASON_EC_PANIC "EC panic"
>   
>   #endif /* POWER_ON_REASON_H */


