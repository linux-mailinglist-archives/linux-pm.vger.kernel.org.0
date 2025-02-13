Return-Path: <linux-pm+bounces-22019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69642A34182
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 15:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F52A3ACD76
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 14:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03D23A9A3;
	Thu, 13 Feb 2025 14:07:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47852222B3;
	Thu, 13 Feb 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455643; cv=none; b=htUZBN0v208b7XwjiIIKKfuoUsasp/1vSL7d3igdIO87tBGOVGwRQDA1QXAajCDf4lmYsvU4yK4dVDWFhcXmElzCegFmEwGNoCqooi35BmA4YzDHRnMH+5aylAeQ4Wokn3Z6D64l8aopsHlk3C3U/3BfO1C/d88RmxI84zqlH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455643; c=relaxed/simple;
	bh=ZXEIqVbXG564X53P+o//74YScKX9UeP3vYJ9OIagM5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnGaQ2uSgNDeF1gV0ZSvnmvyh7p5rGUwElVoAqracSXRvELOueYZo+CVtXYovJHAG4BDFvD66hgOPL2KNjiYibO75HwTdg+wmUQiFVvDVPcRg+QMa/r3IJHwgYwmjkOBb0iwjTnzNKLw6b2O0goz9XdJ5TNzc+0IY3k7gFXRrwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F36CB16F3;
	Thu, 13 Feb 2025 06:07:40 -0800 (PST)
Received: from [10.1.30.41] (e127648.arm.com [10.1.30.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 027EE3F58B;
	Thu, 13 Feb 2025 06:07:18 -0800 (PST)
Message-ID: <8d147f4f-f511-4f44-b18e-2011b0fab17c@arm.com>
Date: Thu, 13 Feb 2025 14:07:16 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle state
 over-eagerly
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, dsmythies@telus.net
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <12630185.O9o76ZdvQC@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <12630185.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 20:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It has been observed that the recent teo governor update which concluded
> with commit 16c8d7586c19 ("cpuidle: teo: Skip sleep length computation
> for low latency constraints") caused the max-jOPS score of the SPECjbb
> 2015 benchmark [1] on Intel Granite Rapids to decrease by around 1.4%.
> While it may be argued that this is not a significant increase, the
> previous score can be restored by tweaking the inequality used by teo
> to decide whether or not to preselect the deepest enabled idle state.
> That change also causes the critical-jOPS score of SPECjbb to increase
> by around 2%.
> 
> Namely, the likelihood of selecting the deepest enabled idle state in
> teo on the platform in question has increased after commit 13ed5c4a6d9c
> ("cpuidle: teo: Skip getting the sleep length if wakeups are very
> frequent") because some timer wakeups were previously counted as non-
> timer ones and they were effectively added to the left-hand side of the
> inequality deciding whether or not to preselect the deepest idle state.
> 
> Many of them are now (accurately) counted as timer wakeups, so the left-
> hand side of that inequality is now effectively smaller in some cases,
> especially when timer wakeups often occur in the range below the target
> residency of the deepest enabled idle state and idle states with target
> residencies below CPUIDLE_FLAG_POLLING are often selected, but the
> majority of recent idle intervals are still above that value most of
> the time.  As a result, the deepest enabled idle state may be selected
> more often than it used to be selected in some cases.
> 
> To counter that effect, add the sum of the hits metric for all of the
> idle states below the candidate one (which is the deepest enabled idle
> state at that point) to the left-hand side of the inequality mentioned
> above.  This will cause it to be more balanced because, in principle,
> putting both timer and non-timer wakeups on both sides of it is more
> consistent than only taking into account the timer wakeups in the range
> above the target residency of the deepest enabled idle state.
> 
> Link: https://www.spec.org/jbb2015/
> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -349,13 +349,13 @@
>  	}
>  
>  	/*
> -	 * If the sum of the intercepts metric for all of the idle states
> -	 * shallower than the current candidate one (idx) is greater than the
> +	 * If the sum of the intercepts and hits metric for all of the idle
> +	 * states below the current candidate one (idx) is greater than the
>  	 * sum of the intercepts and hits metrics for the candidate state and
>  	 * all of the deeper states, a shallower idle state is likely to be a
>  	 * better choice.
>  	 */
> -	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> +	if (2 * (idx_intercept_sum + idx_hit_sum) > cpu_data->total) {
>  		int first_suitable_idx = idx;
>  
>  		/*
> 
> 
> 

I'm curious, are Doug's numbers reproducible?
Or could you share the idle state usage numbers? Is that explainable?
Seems like a lot and it does worry me that I can't reproduce anything
as drastic.

I did a bit of x86 as well and got for Raptor Lake (I won't post the
non-x86 numbers now, but teo-tweak performs comparable to teo mainline.)

Idle 5 min:
device	 gov	 iter	 Joules	 idles	 idle_misses	 idle_miss_ratio	 belows	 aboves	
teo 	0 	170.02 	12690 	646 	0.051 	371 	275
teo 	1 	123.17 	8361 	517 	0.062 	281 	236
teo 	2 	122.76 	7741 	347 	0.045 	262 	85
teo 	3 	118.5 	8699 	668 	0.077 	307 	361
teo 	4 	80.46 	8113 	443 	0.055 	264 	179
teo-tweak 	0 	115.05 	10223 	803 	0.079 	323 	480
teo-tweak 	1 	164.41 	8523 	631 	0.074 	263 	368
teo-tweak 	2 	163.91 	8409 	711 	0.085 	256 	455
teo-tweak 	3 	137.22 	8581 	721 	0.084 	261 	460
teo-tweak 	4 	174.95 	8703 	675 	0.078 	261 	414
teo 	0 	164.34 	8443 	516 	0.061 	303 	213
teo 	1 	167.85 	8767 	492 	0.056 	256 	236
teo 	2 	166.25 	7835 	406 	0.052 	263 	143
teo 	3 	189.77 	8865 	493 	0.056 	276 	217
teo 	4 	136.97 	9185 	467 	0.051 	286 	181

At least in the idle case you can see an increase in 'above' idle_misses.

Firefox Youtube 4K video playback 2 min:
device	 gov	 iter	 Joules	 idles	 idle_misses	 idle_miss_ratio	 belows	 aboves	
teo 	0 	260.09 	67404 	11189 	0.166 	1899 	9290
teo 	1 	273.71 	76649 	12155 	0.159 	2233 	9922
teo 	2 	231.45 	59559 	10344 	0.174 	1747 	8597
teo 	3 	202.61 	58223 	10641 	0.183 	1748 	8893
teo 	4 	217.56 	61411 	10744 	0.175 	1809 	8935
teo-tweak 	0 	227.99 	61209 	11251 	0.184 	2110 	9141
teo-tweak 	1 	222.44 	61959 	10323 	0.167 	1474 	8849
teo-tweak 	2 	218.1 	64380 	11080 	0.172 	1845 	9235
teo-tweak 	3 	207.4 	60183 	11267 	0.187 	1929 	9338
teo-tweak 	4 	217.46 	61253 	10381 	0.169 	1620 	8761
menu 	0 	225.72 	87871 	26032 	0.296 	25412 	620
menu 	1 	200.36 	86577 	24712 	0.285 	24486 	226
menu 	2 	214.79 	84885 	24750 	0.292 	24556 	194
menu 	3 	206.07 	88007 	25938 	0.295 	25683 	255
menu 	4 	216.48 	88700 	26504 	0.299 	26302 	202

(Idle numbers aren't really reflective in energy used -> dominated by
active power.)

