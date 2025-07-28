Return-Path: <linux-pm+bounces-31523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73CB1425C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 21:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528A51889DD4
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CD27702F;
	Mon, 28 Jul 2025 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFAUpLir"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7177213E85;
	Mon, 28 Jul 2025 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729511; cv=none; b=ZsrNJP7zvOeg8A3rb6YEnzdN8IUlfM0O7QvIEaBwSGdwjOHvVHYWmqcjG6yyoJEovpvgBlb+33bFdN+YkAdRB0/cxUULD4XTwxkLjnmWrnDm26w7sWxx3NCHFk0zXels/SL+MQfW3xH+8+AL4yo8oE50DzyaDlG5GmDV4XAGuZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729511; c=relaxed/simple;
	bh=uJ09m06cGIXYcKJAuNcPDUL2P89VhpbovEzGzOUVFDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8L+dnYeGiF7z5kZnNmCYcrN44WSPOSYbTRb/iloUXZdMnQzPKBFJQ1T+9VNdg1q7La/T78hIFfktfLXeZBLsXgmFibooHr6Iph1PZbfevqMeo1ONfYI7F5l2E+SYWeyaX0QFJzAFs/3QakN7Wi9Ev1VitbtaM+dN7LxQx92Iwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFAUpLir; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b77673fd78so2291527f8f.0;
        Mon, 28 Jul 2025 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753729508; x=1754334308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8tyl9lHdA81nm81xEAtlVPivOrOS0EsmhmFVRT4sEg=;
        b=OFAUpLirBRVl2hv8ajKIdqgE0o3bJPdfbKtcFF+UBfUcqPoY5nCztcFrgxRiiGBqOd
         u/up2XghAztWZ3gYp1YI+rqyvix+LvVGdkdyZ2CSMu33YfA8skwkIQEeuk4B0VVfEnE7
         o45s1WnF5CzoXVTqVueXNLse2edAtskqWCZu3dUcI2RTXQAyO7KgCCTYi+29yw0qPS/T
         ykp73UK13+yb8hGAwL/btf0EgDDsWRCCS2xsQFRs/6/LFIodq8E2RG5wPuWNK2UUlZ6S
         YTBV+aL1utr7cECh1mxDhr9Fxlqj35vC2gJIsouM9tYI6UFD2eEATPH4O1Tg9ZM66b5+
         clBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729508; x=1754334308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8tyl9lHdA81nm81xEAtlVPivOrOS0EsmhmFVRT4sEg=;
        b=FyXmarE95SeYWcn110KbKimMecerPhd/FL/eGzsVgqEHtqkmX5D8b1ukonFxlq7iF3
         W+VY8F0v4sEsOMeHNqjdSKgwUXCtDcXYq0vuIOoFpkNZ2ZjZc9/kOKkv2yLClT+k/epa
         xqGpngqpXrjg/Na2R5Xl4FShFPZFA7oduMp7TO+syRE8heXpXPiTJHIF1YzVwJJN4MN8
         eS/wZzNWWgkU6MRgQSDVx56alUej9rtQzvwfXDQJzD+ckBpVMeKQ4zXcQa/BSa2Kog+4
         kt/7n8RDS0ql2rokIbvRB2pn16K5wJxGYezx7XZ6mQi0jzvwT1HKMteEfyaxl/q5KdFx
         CL5A==
X-Forwarded-Encrypted: i=1; AJvYcCVY1Qt6y+ujLxpyRX1Uqlj2LclEYDuSvEhQb6rDF13L70HIGK4toiZLCpNp08nobXDWVOWzVRplcWf3yBU=@vger.kernel.org, AJvYcCXrGcsSNG3JST9Xv0Wl0qZIh3HjacyFELtWd1bT1ptyCaDq7NVpUxpe7RDw9wh30jAUARs/b7kxkdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKyCOD86zHS40iRhwjLAZl18bi1ogtwUNxy1kqLPu6saeXSWP9
	ptwIGOZbSCBQVnzvzKE17Kr7KS4dDKAIbEZ4LrJG40l/PdkSJxu7uSL1
X-Gm-Gg: ASbGncvYaj8I+bYYj0nM+AnZBn5G17v8r9ne+pTk738qLKAIlrHTgJMhdlwzrywwQ/y
	9qZYKkVKaL2Vmh8OJB2J4bESu0yRbALJWC+DFt8R7CWfJXkhbmEXlp3l++eI0Ixg6iSgbLaQzBx
	iANJL+KSbxNO7bujqZO+Bxntw1aS94uL32pRPeuhOKk3LMa6fKIHRaz7Ar342kvWessRX0hT3gx
	mZKWu56vXQLL95sgUOVSTY09CSlLz+1BBJJTQknZ00k99R4df6bJv9M5r8BBH7YUTd3tgbZrtX5
	IHpOWZpHXbJ60AoHwyHlNyy78maHYwrHam9tTanhQTgpbuUbts9fJnIAsaoo2LddgSr7YWhYPW/
	OTjWAbiSq35AHW6BgQ3QHK7/J53YexqQ5z3pG0nASPyRTT7I/rvvR1TSSPsHN
X-Google-Smtp-Source: AGHT+IFcL8oDmNiTtqYnZ4kVTC+YTXm0GIWOZCFgiWNORVPGWDSRoWaZghZ8qMKkFT+EkLwOW3Ilcg==
X-Received: by 2002:a05:6000:2c0e:b0:3b7:8cac:821b with SMTP id ffacd0b85a97d-3b78cac8909mr1477560f8f.20.1753729507743;
        Mon, 28 Jul 2025 12:05:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7883228dasm4678561f8f.50.2025.07.28.12.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 12:05:07 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:05:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
Cc: ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org
Subject: Re: [PATCH] x86/amd/power: Replace do_div() with div64_u64()
Message-ID: <20250728200506.46631e2d@pumpkin>
In-Reply-To: <20250724212221.9964-1-nikolay.niko.nikolov@gmail.com>
References: <20250724212221.9964-1-nikolay.niko.nikolov@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 14:21:05 -0700
Niko Nikolov <nikolay.niko.nikolov@gmail.com> wrote:

> do_div() divides 64-by-32, and can risk truncation if divisor exceeds 32 bits.
> Use div64_u64() for full 64/64-bit division as recommended, resolving static analysis warnings.

There seem to be a lot of unrelated (mostly whitespace) changes.

You also need to check the domain of the values.

Ok and nak - is is just p-lain broken.

> 
> Signed-off-by: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
> ---
>  arch/x86/events/amd/power.c | 49 ++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
> index dad42790cf7d..35eff3383660 100644
> --- a/arch/x86/events/amd/power.c
> +++ b/arch/x86/events/amd/power.c
> @@ -15,12 +15,12 @@
>  #include "../perf_event.h"
>  
>  /* Event code: LSB 8 bits, passed in attr->config any other bit is reserved. */
> -#define AMD_POWER_EVENT_MASK		0xFFULL
> +#define AMD_POWER_EVENT_MASK 0xFFULL
>  
>  /*
>   * Accumulated power status counters.
>   */
> -#define AMD_POWER_EVENTSEL_PKG		1
> +#define AMD_POWER_EVENTSEL_PKG 1
>  
>  /*
>   * The ratio of compute unit power accumulator sample period to the
> @@ -65,7 +65,7 @@ static void event_update(struct perf_event *event)
>  	delta *= cpu_pwr_sample_ratio * 1000;
>  	tdelta = new_ptsc - prev_ptsc;
>  
> -	do_div(delta, tdelta);
> +	div64_u64(delta, tdelta);

nak - this is broken...

	David

>  	local64_add(delta, &event->count);
>  }
>  
> @@ -144,8 +144,8 @@ static void pmu_event_read(struct perf_event *event)
>  	event_update(event);
>  }
>  
> -static ssize_t
> -get_attr_cpumask(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t get_attr_cpumask(struct device *dev,
> +				struct device_attribute *attr, char *buf)
>  {
>  	return cpumap_print_to_pagebuf(true, buf, &cpu_mask);
>  }
> @@ -165,12 +165,12 @@ static struct attribute_group pmu_attr_group = {
>   * Currently it only supports to report the power of each
>   * processor/package.
>   */
> -EVENT_ATTR_STR(power-pkg, power_pkg, "event=0x01");
> +EVENT_ATTR_STR(power - pkg, power_pkg, "event=0x01");
>  
> -EVENT_ATTR_STR(power-pkg.unit, power_pkg_unit, "mWatts");
> +EVENT_ATTR_STR(power - pkg.unit, power_pkg_unit, "mWatts");
>  
>  /* Convert the count from micro-Watts to milli-Watts. */
> -EVENT_ATTR_STR(power-pkg.scale, power_pkg_scale, "1.000000e-3");
> +EVENT_ATTR_STR(power - pkg.scale, power_pkg_scale, "1.000000e-3");
>  
>  static struct attribute *events_attr[] = {
>  	EVENT_PTR(power_pkg),
> @@ -180,8 +180,8 @@ static struct attribute *events_attr[] = {
>  };
>  
>  static struct attribute_group pmu_events_group = {
> -	.name	= "events",
> -	.attrs	= events_attr,
> +	.name = "events",
> +	.attrs = events_attr,
>  };
>  
>  PMU_FORMAT_ATTR(event, "config:0-7");
> @@ -192,8 +192,8 @@ static struct attribute *formats_attr[] = {
>  };
>  
>  static struct attribute_group pmu_format_group = {
> -	.name	= "format",
> -	.attrs	= formats_attr,
> +	.name = "format",
> +	.attrs = formats_attr,
>  };
>  
>  static const struct attribute_group *attr_groups[] = {
> @@ -204,17 +204,17 @@ static const struct attribute_group *attr_groups[] = {
>  };
>  
>  static struct pmu pmu_class = {
> -	.attr_groups	= attr_groups,
> +	.attr_groups = attr_groups,
>  	/* system-wide only */
> -	.task_ctx_nr	= perf_invalid_context,
> -	.event_init	= pmu_event_init,
> -	.add		= pmu_event_add,
> -	.del		= pmu_event_del,
> -	.start		= pmu_event_start,
> -	.stop		= pmu_event_stop,
> -	.read		= pmu_event_read,
> -	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> -	.module		= THIS_MODULE,
> +	.task_ctx_nr = perf_invalid_context,
> +	.event_init = pmu_event_init,
> +	.add = pmu_event_add,
> +	.del = pmu_event_del,
> +	.start = pmu_event_start,
> +	.stop = pmu_event_stop,
> +	.read = pmu_event_read,
> +	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> +	.module = THIS_MODULE,
>  };
>  
>  static int power_cpu_exit(unsigned int cpu)
> @@ -278,10 +278,9 @@ static int __init amd_power_pmu_init(void)
>  		return -ENODEV;
>  	}
>  
> -
>  	cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
> -			  "perf/x86/amd/power:online",
> -			  power_cpu_init, power_cpu_exit);
> +			  "perf/x86/amd/power:online", power_cpu_init,
> +			  power_cpu_exit);
>  
>  	ret = perf_pmu_register(&pmu_class, "power", -1);
>  	if (WARN_ON(ret)) {


