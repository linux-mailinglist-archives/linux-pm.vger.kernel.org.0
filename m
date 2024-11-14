Return-Path: <linux-pm+bounces-17546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2830B9C8494
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB05281D57
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706BA1F585B;
	Thu, 14 Nov 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQEqZz4w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C013CA99
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571722; cv=none; b=JNzeacGN5hy98nLy98+2DQXbP/6GbVb0fnelnKo5JdwoJNHUbIyVtFncIsDq6yit9Gu1JKB7u1/S/oY1+tTDYQecAeJr9WMvA9hVzKOkLowwBEn+VxA+z3J/Ib4/1g+qKrGNIo7Qag0d1PApbocEIbFHFm79JjDl/t6vyCH6VSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571722; c=relaxed/simple;
	bh=icAKHO3XdFjTPRQoSoY40/A30bW01Zctkb2EmkZvI00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcyLOIGsedgdELYx4/bnx3CFQ6n11tKNiS5ljwoE5xbXn2+h9sHg7sFK31MyTre2GDtKNNSyDlisVIJihNQlmmb2plKGmuCQ/84qYb/vBjx+catuBd3ajRyBa/d1QXkbcNURIHQgKOGnI0I/oLurI5F2+jhgKltrWn+qC6rcJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VQEqZz4w; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43169902057so3097555e9.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 00:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731571719; x=1732176519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+O9kp15ulmkDsZL6FcyG0SNyoP+OGnZmJFKve5ejek=;
        b=VQEqZz4wa4ShjonakVafS5dz/QQ3Egq4FbJJxMo4M/yLn0JPG01+uXx4drFElLI4Mw
         gpLFbj+60CGRjkNxIUAvkt1/uneFKYf8Yb8Y5TsXFTGGl3Wq1AFEggga7ekpfu+GJP93
         TJonO9pQxfKylQxwaPpd+AIjSOGPyazA5Ptptgj1r/k59BrXf5zH2Y6+FHMbsVQe3Ybf
         zyVVpYCtvaQrhTYH9BupYGR9xZ7YmxE1JBDYTh8FTeKQ6TpBGce6WGlDlWGho2FrfXaq
         Fr+3GYVNc2XnW4x+8NPcl+RWTnrCOGMYInkugSCrOQqHye049+ump9+pkgCaa0jxInCO
         4CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731571719; x=1732176519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+O9kp15ulmkDsZL6FcyG0SNyoP+OGnZmJFKve5ejek=;
        b=S86B//m53WoumzGBZq5uSYLABXCuPgaePSe62kgwHOpvQiL2btv2Ig4jRaGoZEYy7u
         urglPVHY6Z7Sw47wxYwOFoNsH8aHOTk1vG3x2Nwy6qhP6vYxKh+gvrcuQSZS9AN9lvPw
         rU5KJXf4r7UF4Mb6INvSJDaDhNYgbjo6aG/uv5n2UFYcP3RqNkhcWO1BBhQnI/6GLtpN
         N3egfTGv3fXbARsQNEFZkLLyTCTfIWIGt2tfAlpMWtei7iZ0qjXf9+rHmgkXAikC+Dt3
         nLXsI/UMdsOPhW09uzqbBX5beiC8BuEfoY5p7lmflpPS9prtTRTK3oAV11txUDMBtAam
         kQFw==
X-Forwarded-Encrypted: i=1; AJvYcCWJg5p2JYRwuiM/VIY8f3ps+QjH5AlFrFQsHJ4VhL7grBLDS+BGR31DZddm2EmhDrBFzSkvVAaqjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/8ybluF1YUXWBhMkO36Gfkoz7UEYqHE7CnfYeWov/Ze3W7Ay
	Myt1TNqY/OPIQMmOemAq4nzIJGnbavS8IvNwWMqcQ+uFjxgrFbJFf4vjTvzc3w2yXJZUp2qQaCK
	q
X-Google-Smtp-Source: AGHT+IHyd6RzOZzyB9DdcPGem/cYcPNN7x7i0VssOkuKf2eJ37J7FH3H9T6y3I8gzSOnXFeEryo80g==
X-Received: by 2002:a05:600c:5247:b0:42c:b63e:fe91 with SMTP id 5b1f17b1804b1-432cd474820mr77028005e9.24.1731571718928;
        Thu, 14 Nov 2024 00:08:38 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3821ae161e3sm753266f8f.64.2024.11.14.00.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 00:08:38 -0800 (PST)
Message-ID: <2c70b9c3-e0f0-4551-864d-5d5252fccf99@linaro.org>
Date: Thu, 14 Nov 2024 09:08:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/thermal: Fix common realloc mistake
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241108044700.37633-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241108044700.37633-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Zhang,

thanks for spotting the issue

On 08/11/2024 05:47, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Do not set thermometer->tz NULL when realloc failed.

You may describe a bit more the change.

eg.

If the 'realloc' fails, the thermal zones pointer is set to NULL. This 
makes all thermal zones references which were previously successfully 
initialized to be lost.

> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   tools/thermal/thermometer/thermometer.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
> index 1a87a0a77f9f..e08291a97fd8 100644
> --- a/tools/thermal/thermometer/thermometer.c
> +++ b/tools/thermal/thermometer/thermometer.c
> @@ -259,6 +259,7 @@ static int thermometer_add_tz(const char *path, const char *name, int polling,
>   {
>   	int fd;
>   	char tz_path[PATH_MAX];
> +	void *tmp;

Please use right type:

	struct tz *tz;

>   	sprintf(tz_path, CLASS_THERMAL"/%s/temp", path);
>   
> @@ -268,12 +269,13 @@ static int thermometer_add_tz(const char *path, const char *name, int polling,
>   		return -1;
>   	}
>   
> -	thermometer->tz = realloc(thermometer->tz,
> +	tmp = realloc(thermometer->tz,
>   				  sizeof(*thermometer->tz) * (thermometer->nr_tz + 1));
> -	if (!thermometer->tz) {
> +	if (!tmp) {
>   		ERROR("Failed to allocate thermometer->tz\n");
>   		return -1;
>   	}
> +	thermometer->tz = tmp;
>   
>   	thermometer->tz[thermometer->nr_tz].fd_temp = fd;
>   	thermometer->tz[thermometer->nr_tz].name = strdup(name);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

