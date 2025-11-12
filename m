Return-Path: <linux-pm+bounces-37864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB42C53C0D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F993BADC5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4E345731;
	Wed, 12 Nov 2025 17:29:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7E337B8A;
	Wed, 12 Nov 2025 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968559; cv=none; b=oFm95uAZxzkliAru5H5dcbqhYQgEr76Cr8DDMVIFVxL3Xh7Wa4IvBJHWxeZzoW9AXhTa1v/wXpesYjU1iztuGLeWFpiOCkF5yUa/OfuiN2ctLoH2IfRb4Lj9lhZXgADTZ6xGCCKTFNIW0bzim9KgD5maPCw0AI3Ldz72rpm2d1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968559; c=relaxed/simple;
	bh=eZlxYc92kSCs178/i8tEwgBR3SN/jRkBpCYXfobk2W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bx3y7Ywf/G/32heuxDoPV4A9S5Tj0jKPoZhjlsZ1fcB8YI6j00xwnEAp3WRTWr76WeSleyjeVW7OrTXZ62slxIa2OtTTWn0wT9MuGgENAsfycqfAWY2Uy+mT37moVWwJ8gZPcQimTz2N08lwf+c+VICXUCmW+Xs0lKkNQGTfcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A497F1515;
	Wed, 12 Nov 2025 09:29:08 -0800 (PST)
Received: from [10.1.28.59] (e127648.arm.com [10.1.28.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AA713F66E;
	Wed, 12 Nov 2025 09:29:15 -0800 (PST)
Message-ID: <a5de1eca-494e-4624-a86b-bf917e562a08@arm.com>
Date: Wed, 12 Nov 2025 17:29:13 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] cpuidle: governors: teo: Decay metrics below
 DECAY_SHIFT threshold
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki>
 <3396811.44csPzL39Z@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3396811.44csPzL39Z@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 16:25, Rafael J. Wysocki wrote:
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
> ---
>  drivers/cpuidle/governors/teo.c |   20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
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
> @@ -159,7 +169,7 @@ static void teo_update(struct cpuidle_dr
>  	int i, idx_timer = 0, idx_duration = 0;
>  	s64 target_residency_ns, measured_ns;
>  
> -	cpu_data->short_idles -= cpu_data->short_idles >> DECAY_SHIFT;
> +	teo_decay(&cpu_data->short_idles);
>  
>  	if (cpu_data->artificial_wakeup) {
>  		/*
> @@ -195,8 +205,8 @@ static void teo_update(struct cpuidle_dr
>  	for (i = 0; i < drv->state_count; i++) {
>  		struct teo_bin *bin = &cpu_data->state_bins[i];
>  
> -		bin->hits -= bin->hits >> DECAY_SHIFT;
> -		bin->intercepts -= bin->intercepts >> DECAY_SHIFT;
> +		teo_decay(&bin->hits);
> +		teo_decay(&bin->intercepts);
>  
>  		target_residency_ns = drv->states[i].target_residency_ns;
>  
> @@ -207,7 +217,7 @@ static void teo_update(struct cpuidle_dr
>  		}
>  	}
>  
> -	cpu_data->tick_intercepts -= cpu_data->tick_intercepts >> DECAY_SHIFT;
> +	teo_decay(&cpu_data->tick_intercepts);
>  	/*
>  	 * If the measured idle duration falls into the same bin as the sleep
>  	 * length, this is a "hit", so update the "hits" metric for that bin.
> @@ -222,7 +232,7 @@ static void teo_update(struct cpuidle_dr
>  			cpu_data->tick_intercepts += PULSE;
>  	}
>  
> -	cpu_data->total -= cpu_data->total >> DECAY_SHIFT;
> +	teo_decay(&cpu_data->total);
>  	cpu_data->total += PULSE;

This will result in total no longer being a strict sum of the bins.
Any reason not to do something like:

-----8<-----

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index e5b795cf3155..ff58d70ee80d 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -148,14 +148,19 @@ struct teo_cpu {
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
 
-static void teo_decay(unsigned int *metric)
+static unsigned int teo_decay(unsigned int *metric)
 {
        unsigned int delta = *metric >> DECAY_SHIFT;
+       unsigned int decay;
 
-       if (delta)
+       if (delta) {
                *metric -= delta;
-       else
-               *metric = 0;
+               return delta;
+       }
+
+       decay = *metric;
+       *metric = 0;
+       return decay;
 }
 
 /**
@@ -168,6 +173,7 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
        struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
        int i, idx_timer = 0, idx_duration = 0;
        s64 target_residency_ns, measured_ns;
+       unsigned int total_decay = 0;
 
        teo_decay(&cpu_data->short_idles);
 
@@ -205,8 +211,8 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
        for (i = 0; i < drv->state_count; i++) {
                struct teo_bin *bin = &cpu_data->state_bins[i];
 
-               teo_decay(&bin->hits);
-               teo_decay(&bin->intercepts);
+               total_decay += teo_decay(&bin->hits);
+               total_decay += teo_decay(&bin->intercepts);
 
                target_residency_ns = drv->states[i].target_residency_ns;
 
@@ -232,7 +238,7 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
                        cpu_data->tick_intercepts += PULSE;
        }
 
-       teo_decay(&cpu_data->total);
+       cpu_data->total -= total_decay;
        cpu_data->total += PULSE;
 }
 


