Return-Path: <linux-pm+bounces-37953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B21C1C57456
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 12:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 463AA344816
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F89733F8AE;
	Thu, 13 Nov 2025 11:50:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF41621C17D;
	Thu, 13 Nov 2025 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034616; cv=none; b=iahUE0OUlf1Ml39nB8S9ACQMhNmp6CSdAHjWq02Mup7i7yX+WmnLqyVq7yo7ZpgyQ0Ro7ukB1qfPEm19NzUc6fWyXmnS62kK+qCleANyaGtP00FU5JPu/VDomHb40FEf1tryAPrv9lPkJFljr4CdY9Aplo9BWVVEJnN/iZOUur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034616; c=relaxed/simple;
	bh=jnvy5pDHfCGfJpN9gg9RTW7Gw+S3EtHdgVRb4LGNoQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxDx3l24K+VAG8sGUf9FXuO+rQ8oo3zGR+wPbsUUvAYA83hml5Zv8CiB8iLAkNBXjiP8gSJNuIjTu7V7hhkpATwqozxEcQIn6Ua0Ba84kszd4yCc0TOMVFsVat2blrywjgLxu53kF01OIgbYAhRqiNp7GZ/c4STWVzWxuFlnb6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 792B112FC;
	Thu, 13 Nov 2025 03:50:06 -0800 (PST)
Received: from [10.1.28.59] (e127648.arm.com [10.1.28.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5DA03F66E;
	Thu, 13 Nov 2025 03:49:58 -0800 (PST)
Message-ID: <de94fdde-e2dc-45e7-a203-12a45775ffa6@arm.com>
Date: Thu, 13 Nov 2025 11:49:46 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] cpuidle: governors: teo: Decay metrics below
 DECAY_SHIFT threshold
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki>
 <3396811.44csPzL39Z@rafael.j.wysocki> <2819353.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2819353.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 18:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a given governor metric falls below a certain value (8 for
> DECAY_SHIFT equal to 3), it will not decay any more due to the
> simplistic decay implementation.  This may in some cases lead to
> subtle inconsistencies in the governor behavior, so change the
> decay implementation to take it into account and set the metric
> at hand to 0 in that case.
> 
> Suggested-by: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
> 
> v1 -> v2:
>    * Ensure that cpu_data->total is always the sum of the intercepts and hits
>      metrics for all of the idle states (Christian).
> 
> ---
>  drivers/cpuidle/governors/teo.c |   26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -148,6 +148,16 @@ struct teo_cpu {
>  
>  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
>  
> +static void teo_decay(unsigned int *metric)
> +{
> +	unsigned int delta = *metric >> DECAY_SHIFT;
> +
> +	if (delta)
> +		*metric -= delta;
> +	else
> +		*metric = 0;
> +}
> +
>  /**
>   * teo_update - Update CPU metrics after wakeup.
>   * @drv: cpuidle driver containing state data.
> @@ -158,8 +168,9 @@ static void teo_update(struct cpuidle_dr
>  	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
>  	int i, idx_timer = 0, idx_duration = 0;
>  	s64 target_residency_ns, measured_ns;
> +	unsigned int total = 0;
>  
> -	cpu_data->short_idles -= cpu_data->short_idles >> DECAY_SHIFT;
> +	teo_decay(&cpu_data->short_idles);
>  
>  	if (cpu_data->artificial_wakeup) {
>  		/*
> @@ -195,8 +206,10 @@ static void teo_update(struct cpuidle_dr
>  	for (i = 0; i < drv->state_count; i++) {
>  		struct teo_bin *bin = &cpu_data->state_bins[i];
>  
> -		bin->hits -= bin->hits >> DECAY_SHIFT;
> -		bin->intercepts -= bin->intercepts >> DECAY_SHIFT;
> +		teo_decay(&bin->hits);
> +		total += bin->hits;
> +		teo_decay(&bin->intercepts);
> +		total += bin->intercepts;
>  
>  		target_residency_ns = drv->states[i].target_residency_ns;
>  
> @@ -207,7 +220,9 @@ static void teo_update(struct cpuidle_dr
>  		}
>  	}
>  
> -	cpu_data->tick_intercepts -= cpu_data->tick_intercepts >> DECAY_SHIFT;
> +	cpu_data->total = total + PULSE;
> +
> +	teo_decay(&cpu_data->tick_intercepts);
>  	/*
>  	 * If the measured idle duration falls into the same bin as the sleep
>  	 * length, this is a "hit", so update the "hits" metric for that bin.
> @@ -221,9 +236,6 @@ static void teo_update(struct cpuidle_dr
>  		if (TICK_NSEC <= measured_ns)
>  			cpu_data->tick_intercepts += PULSE;
>  	}
> -
> -	cpu_data->total -= cpu_data->total >> DECAY_SHIFT;
> -	cpu_data->total += PULSE;
>  }
>  
>  static bool teo_state_ok(int i, struct cpuidle_driver *drv)
> 
> 
> 


