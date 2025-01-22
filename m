Return-Path: <linux-pm+bounces-20803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3BDA190A0
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 12:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E78161124
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F0421171B;
	Wed, 22 Jan 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNgXJjqk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05FE2101AD;
	Wed, 22 Jan 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545301; cv=none; b=LsknsFS3yDmFAn/yUSQPvbtV967VZNhX4lweFnu5vdJ5THtZnkdfR6dFVM9gZYFl4TBBOOS7g8s+nSwqkbbcYLHtotAguBvmeCX6P0w5r5XlQoebHfaPnRFULBiSLbWx5V++s25SmaGEzb3Gv2B89wBZ32YShIWmk9Fs5a3rE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545301; c=relaxed/simple;
	bh=qgdsDOji/Ki6OjklleBu3dfhkX2SIINNrfcy28ZqIgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNo1Q+84xtMmAPPfjC9jLRR0j0qS7LQ161CyY3HfL7IOmRGRvwxTtf4uQTN7MGlnBEG//UxkIMB1zG/dmo/AeUJMwnbKEIMFc3tGG9F7LX6yKLXDZ+2AfWTP/rFnUOd9KH8E9Uc368SdnYoYMOVT5U4ujjYMlgj0YN0Fl8MiMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNgXJjqk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5426fcb3c69so5418485e87.3;
        Wed, 22 Jan 2025 03:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737545296; x=1738150096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8uucZoYmTyAW8wW7Yobh9x7Be1LOOBbsYawBwsq5P0=;
        b=RNgXJjqkHjeho5Q/MTAVogr/IwgBioiJOlW54IoGcPC92cgbN5AewYPFsvhfcK4bNh
         lfQO15j6HKcpuLTvwBcURpLCzIqj3RFqF4s5HlPYhwze/CvPlZzsFaDt6BBGx8ST+Ipj
         ppN4DJQs3OwW78mp5Wp5ndGZEVB8vmyWxMbiZuDESOFp02lrHtk0qDlnIGayma1R+WUu
         wsXPDtffl8BK+xs3+4mp0A1MG9AsTp0K4lGYnztyfuw8b8g5lkro1MB8x4Z2/IqZTtay
         pS4FTcOTjV5RIZgHaBkWGUIQKON6LDfZh08w79sM1zWoTXvuDOu47HQw4RtC+1fmPG7v
         zr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737545296; x=1738150096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8uucZoYmTyAW8wW7Yobh9x7Be1LOOBbsYawBwsq5P0=;
        b=PFphqzrJH2DT8sOSqtFbMfoSsqe1OUtOWP8a9rAfw9M0BBt8DLZqcE8OoozlyF+2qj
         va0cvmvojN7AwLV7XpL3APyIZ5qVWOUoVLvIUqqwcSl5a4lfW0MSNyBIF+8Ghk8KxY1i
         Uq0kXmwGdRHuVvCNJ3gBx/KM2S9ZJfWdeOd5HmK6mY10hQqNn5hQtF0PaaHS/0FdCXyA
         qWbhhviSU6Y7aDPqWg/ZQgHuuhXsgD0ZpOhHFxM59NYZ5JD2ADNHgnKKE8daNur31S2Y
         2aqIol3vKgFneXmUDpFwVJeZYQ8mc714WYgv1sRxjayUdRjTtopcyTGu+1c6LVcJjjUa
         Tl+w==
X-Forwarded-Encrypted: i=1; AJvYcCUEeAhXZyOsjZgG6qtHXA9uifspx4Id8LeqH0y6COpQMsSK4f7ydHZkx5Js4GVYpuB/XaVvrBQBYhge@vger.kernel.org, AJvYcCVPVbocS1nmY7XL9BqkJErUZy1R8aFw3gdPyj+zcZxMHyuo4gUbHK7c66V+BfVlCuByn/eAnJIU2Ns=@vger.kernel.org, AJvYcCXLVkoVItZMG1PuoaZCsjU75u4vd8OAvgmZeTAPYG7aJ9dx4LPsWXY5nsv5CBZoalD0YfeDL4ertg0O@vger.kernel.org, AJvYcCXXs5hOhyNZo/ifI1N8XmCKiFZi+/zLbZMtlKQTXatzoZz9IalF7oyOXdGkJ4EibxrIa6OQp+tCcdgS/cLR+ZDdZB2qirDT@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgm22umiESwNCjSnGAxI4kmKCh+jP26ZYSbq+kDQN1Aqh/qov
	72JzDQqywRDoPUpvna5wVOJBOQsjuBVmbMBQnOrOKPCjscr0sfUJ
X-Gm-Gg: ASbGncsA6uXb3Nii2fIp42z5jyeDH2TeKIRnqHmJ+GhJ/5Z5MEirbHz5tAeNb8x+05d
	Y+UFWl3sM4oU7tS/pB0peDuFDRukiz+sKwWQ9RnaHT0Hyeg1OTzlCdFOprAZ3B6IXmoAf4mVVry
	axF0OLBHd92kj5xuT0w2K2XHJ0RVaIcO+42X6tXrd7wjqbTEin+M23uwdzQLPvULVo5TvibYimV
	kOOhZ98L/oOjVJx0UvE+tpEe4O4jKwiCHAvkD2NNU1FuD5yTDkjPxTE9uzYNigR3zQcen4h/d0Z
	lcUwYu0=
X-Google-Smtp-Source: AGHT+IFY2ZBn6rdMHyRFnFAwDqHZp13c5/EODEKdU4E4T1JbLWhr6Ok/wScVhHBxOQ5gw+OI+RSfxw==
X-Received: by 2002:a05:6512:159b:b0:540:1fd9:b634 with SMTP id 2adb3069b0e04-5439c28255cmr8070137e87.34.1737545295590;
        Wed, 22 Jan 2025 03:28:15 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af78d62sm2171995e87.241.2025.01.22.03.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 03:28:13 -0800 (PST)
Message-ID: <7b6d3226-4422-415a-9146-16c421463ac5@gmail.com>
Date: Wed, 22 Jan 2025 13:28:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] reboot: reboot, not shutdown, on
 hw_protection_reboot timeout
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Fabio Estevam
 <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
 kernel@pengutronix.de
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-2-161d3fc734f0@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250113-hw_protection-reboot-v2-2-161d3fc734f0@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/01/2025 18:25, Ahmad Fatoum wrote:
> hw_protection_shutdown() will kick off an orderly shutdown and if that
> takes longer than a configurable amount of time, an emergency shutdown
> will occur.
> 
> Recently, hw_protection_reboot() was added for those systems that don't
> implement a proper shutdown and are better served by rebooting and
> having the boot firmware worry about doing something about the critical
> condition.
> 
> On timeout of the orderly reboot of hw_protection_reboot(), the system
> would go into shutdown, instead of reboot. This is not a good idea, as
> going into shutdown was explicitly not asked for.
> 
> Fix this by always doing an emergency reboot if hw_protection_reboot()
> is called and the orderly reboot takes too long.
> 
> Fixes: 79fa723ba84c ("reboot: Introduce thermal_zone_device_critical_reboot()")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>   kernel/reboot.c | 70 ++++++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 49 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 847ac5d17a659981c6765699eac323f5e87f48c1..222b63dfd31020d0e2bc1b1402dbfa82adc71990 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -932,48 +932,76 @@ void orderly_reboot(void)
>   }
>   EXPORT_SYMBOL_GPL(orderly_reboot);
>   
> +static const char *hw_protection_action_str(enum hw_protection_action action)
> +{
> +	switch (action) {
> +	case HWPROT_ACT_SHUTDOWN:
> +		return "shutdown";
> +	case HWPROT_ACT_REBOOT:
> +		return "reboot";
> +	default:
> +		return "undefined";
> +	}
> +}
> +
> +static enum hw_protection_action hw_failure_emergency_action;

nit: Do we have a (theoretical) possibility that two emergency restarts 
get scheduled with different actions? Should the action be allocated 
(maybe not) for each caller, or should there be a check if an operation 
with conflicting action is already scheduled?

If this was already considered and thought it is not an issue:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


Yours,
	-- Matti

