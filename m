Return-Path: <linux-pm+bounces-31769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9C3B1868D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 19:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425291C83891
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77627C15A;
	Fri,  1 Aug 2025 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1LrvfmU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6326C386
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068942; cv=none; b=u8oGic/GETJV3z5dLCwca1DhQLxCZgPIMVvpCJ9YKfM+MdILK1qUA31oUNBkGIgYCwZdSoIuQRkICq/mHo4vtCvzGkjtKWP5jhNUckfUurLsomMG5ZY9u1W1tYBrgNM3oV1ljg1UDgkBJYu97FUCg/O864TWrS5Fw7zicR6tA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068942; c=relaxed/simple;
	bh=F4U3zLqHM8NpqW1pxXipEfzZi7+0Ycu/7mQRmHJXjNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPziO8Gje4Ym5abRJRwM3bRTmVCkG73SDVDfCk/hnMWPjFRVSz2ocACqj7it8okc14H2Fdf68UCS/VGJUF5wNJ7pG5wAz0eS1eYMZixtKgxXdm26dIXdtWZNEjpsQ62SoW6TEg46OUKqVDG5S0rM/YckAB3VO6NCEDeGyWM9W9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h1LrvfmU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso11326665e9.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754068937; x=1754673737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3M/PDNKda01rnV3OeJ4NocScrvK7XCljjn5Nn7NUvKM=;
        b=h1LrvfmUw0OzSRB7ak5Wyus2nhqdj3beFoANdHEK0uZycmnGOVSVVJXNMmqaqU22bl
         DFmjBQo5Bc8Q+8YBEuNao6NHaG8eVvLHUTZe8HpuZfUZCzL1Z4PAjumZ5BmvDX3p1hQA
         DPNIzrMHpeeFslE9ri0bFdkM5kSZf90Xpdi8RZmyFyP6l/1oj4h6SQf123y4XHAOnm3D
         LdB2v0AXA/6z0d5MQtxWjACaG+Pt8W5QamRAe0kVfCoBjajHXnTk2HGShraEqlHk+G1k
         sPB7aQ5Im3BxE3IxypSDj+LQi/bKdCc+C07por9MFdL85QUe2zclk33INcvYiGoFCAjw
         EoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754068937; x=1754673737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3M/PDNKda01rnV3OeJ4NocScrvK7XCljjn5Nn7NUvKM=;
        b=AuN6vmfzWq96AmLKnBcX1QEbmZWReSP+KHeJcr8Q1IcEbcd/EQGYwy0xYJN5a3OXFz
         kNdO3k7NdrglaPjxL3KF91uK6w6poFbDNlWRd3h89q/W5D4nfHInmonyU7fNJGbb8BSn
         5gV5WXtI2ERuSy2U1ezho94pDBc7kHFjqO8vXktx7rVUcj79RewUUUOFXzhQ5i3GX7Jj
         E2EbMsXxwlDJ/ZRslrZDLfTv+56oP9k0cWkQH/RuQD4AGh3q8zHrHI2Kvhega7gOC9nE
         3EtyLXItUB7ecwfSrV9ebdUXUY9rdWoS3RSSidsbJGI6N97WraU530zL1u2zl+CoceKh
         obmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6eCBJdVnj0oAu+BT5pzfLMt5PJeJcvYIcNnk0UFWAY3ZF01pyW7VKrmN7R2MIdhdGGI3Lx3KwAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hPK1yidzHLiutnNxY3mg0+XWjwco4VSjM0K2Arj92MShY/e0
	dTOVlQ4LIvnABTPMqTIbq0LD9d0Z754JNxZpeMu6rEF4TGo9a2OGx0uEQEh1dzzNjD4=
X-Gm-Gg: ASbGnctGsb+QPXrfBpkv+2DSvx0ta7+2wOoV7IbvPTbihVByOm8oB+a10mtQT3ralzY
	ZksD7B1DR/BWkh14Av4q9KA8KFx0PQwK89Bu5b919Qqd7WP7tIKCnhmAiX+yE5KkZp5KVdvKT/d
	Yne2c/sFzLUoER9CNuDPjAo2b4be+rKjUltJcRPJosXdoih6dNvOHa8TLrPk4gYZnrUzlhFvTt2
	znA/YZ7tylxwiQtpLXDY6PGqrmJX/ovrzcuH5TrwCukU6ASJuZh6Dh6pa/47Yf3j9EAoPZVW6u8
	twk0uGkPOYEQ+Z3f32htsnz+apvdh4vwnpo+l1jZrXu0PNE4PvJdHRb5kxBq4ySyCi36Z85yJ+2
	bop1An+YlIiDSt2vhS1P+Hv/yNEdrnMxdToqRV1VJI8SLXOkEY5fdfTayQI+RRQ==
X-Google-Smtp-Source: AGHT+IEr7UdyBNz9mF08fNxf3R1Ysej2mqN5c0NMeUJedJILvrCdFfPD3tDpMYty7zL96HPHkqBLJQ==
X-Received: by 2002:a05:600c:1554:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-458b6b58472mr716105e9.18.1754068936946;
        Fri, 01 Aug 2025 10:22:16 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm6681912f8f.44.2025.08.01.10.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 10:22:16 -0700 (PDT)
Message-ID: <d29b1e05-f783-44ed-a2e3-585a191ec426@linaro.org>
Date: Fri, 1 Aug 2025 19:22:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] thermal: tegra: Fix dereference of pointer tz
 before it is null checked
To: Colin Ian King <colin.i.king@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730135441.2078022-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250730135441.2078022-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/07/2025 15:54, Colin Ian King wrote:
> Currently pointer tz is dereferenced before it is being null checked
> leading to a potential null pointer deferernce issue. Fix this by
> only defererencing it once it has been null checked.

Actually the callback should assume tz is never NULL because the caller 
does:

	ret = tz->ops.set_trip_temp(tz, trip, temp);

So removing the NULL pointer check is safe here.


> Fixes: 6fc2e1a5f98f ("thermal/drivers/tegra: Switch to new of API")
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/thermal/tegra/soctherm.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 53a5c649f4b1..53fa6099b67f 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -585,14 +585,19 @@ static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
>   static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz,
>   					const struct thermal_trip *trip, int temp)
>   {
> -	struct tegra_thermctl_zone *zone = thermal_zone_device_priv(tz);
> -	struct tegra_soctherm *ts = zone->ts;
> -	const struct tegra_tsensor_group *sg = zone->sg;
> -	struct device *dev = zone->dev;
> +	struct tegra_thermctl_zone *zone;
> +	struct tegra_soctherm *ts;
> +	const struct tegra_tsensor_group *sg;
> +	struct device *dev;
>   
>   	if (!tz)
>   		return -EINVAL;
>   
> +	zone = thermal_zone_device_priv(tz);
> +	ts = zone->ts;
> +	sg = zone->sg;
> +	dev = zone->dev;
> +
>   	if (trip->type == THERMAL_TRIP_CRITICAL) {
>   		/*
>   		 * If thermtrips property is set in DT,


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

