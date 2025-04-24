Return-Path: <linux-pm+bounces-26135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EADC3A9B3D0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45321BA53C5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3596227FD79;
	Thu, 24 Apr 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MpKEmzI6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059151624C5
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511705; cv=none; b=omhm/GUQ8z1pm9W3kNYhRBnvGeuQkizFNFUPmZo3rwqACnI/gsDoEQT2lZNmkiiZDikPWXOBG/3cIsJ0Yqv9w6xHzn+9D5hYFrQpuoIINJsKl+kdGNnidDLayaWHueY0DHDwctFI1mp6YP0s8Yh+qMqtO4xf5tx6SUuZH1mR580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511705; c=relaxed/simple;
	bh=N1LvDqlaHJwix0L58K+uG0murbc8Z9oJ6R1h7Z2kM1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnRj4Gny0IxuFTgCrxlzXsmk5UTrPKUsol8mCNp5j+1zOf62BdekvjBlT1+NPl+kyS7XEDT+jhTmGEb2Mu6XiZpwm/K6MqmL18iNyTUN0W88jIaS8niVTQFey5rlnZ5kZycEH4evtvFNa1IME31QLLv/bDP34Q8PbVtLvAU0Umw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MpKEmzI6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ace333d5f7bso216809066b.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745511701; x=1746116501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dhyruI8H4WvEtqRFSbUpsDUEBq04DUJcZn9mG7FKACg=;
        b=MpKEmzI68fD3je3Wfo9JjalwHemTJqHAQWRVAcw8LDsOYYJEG1JtUCMCA4UOXpCJrb
         CZ9kZjMuCu1MpgkUNR9EKIOFQbaq0eHu0KREG6kB0M8jgsB73YsoeVPCSX0QjkjgWvK3
         Pdg92jSI8Fzjx99LUMcDvl3vmAYKDHxDX0avbkmbNQtW0iM2gdXfv+XGgivh+fJGUrFm
         nHcgN1ZxlMpa3beAbgtmc9YO4t54REdYDOvmRWqOzlPZ+nK7OhbKnBHDOb8KTXmcbXLy
         rCrcu0WjjoQG1s9lfcapUo9aBa/eKQTtY8aP14CGeG57KVcGq2cvDHjDBodwvB47Czgh
         la0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511701; x=1746116501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhyruI8H4WvEtqRFSbUpsDUEBq04DUJcZn9mG7FKACg=;
        b=pJsd2izYAXOM6mN8Beo4YNHkor/a9GVymq9kToMCruxT3DFZ/hRr0P/L2oBZaXxoy8
         WpnSJ0FLmYlfitnYV2wVps0eRYEj+WBc60HILLs8JeEtkSrf2H2jDsIRUi6U95ayy5Rs
         WH+z3qAFIr3MmOO6BALXtkHs3v/jowSPJD76L0oS6YePZx7/FkF9+wNDQS0Dboq4PFP4
         FcGMreqiL2qbyxUfkyK3tVK1ZrJ/3j/cawVqi4E1k7awxSZm1dsOlb1zPAzzq9UCUkie
         b+gx0J7G0NGUmhSfs2DK8Z7nRVQGOpWX6iKP0WqQC72FyYWyjIJP9hArdTIIzAYRTFj/
         /YbA==
X-Gm-Message-State: AOJu0YxNTTo7bfKTUAmvg5KdyvipL7lcpbGidp8J1xJav0pqdrulQgfn
	ZOutGtql69IChHxfY7i0SXEMategQ01T1WXzdI6V8g71rPT87TUOvJqSjx4wtuo=
X-Gm-Gg: ASbGncvledN3gRtIrZusCnbElxkSfeJXjGqthQ6mYINcSBTtRYcGcSBpyw4pbSbQ9kc
	VapIZTz5AI9r1u6RRpF+ZnjFOTW2F7pSe77qGnK+zHAK+HBYMWNqsL9Sh9+KJedBWdFM7nIg+N0
	I++8KN247DjtMWz9wzVbJiP26hUAVueSBQPlvm/itUqbUExgojqkQ2+l9tJG7c+1gLsR8/6jcDW
	fTK9N4SCOZTuZuAN0hDjFy9sxQCjKWoo4OsXVQAoOe9oUuHRhnCJfQs58X1xlbFc3wkzv12CvyE
	CFid5KiK46RU+O/I5js/aw4ZjXDZkFiDpGXMoIbBFOrP3elfKw==
X-Google-Smtp-Source: AGHT+IFBuPsFqWBVaxD0NkHLCf/0KgIji9RD8TCmgZElYimVI+psaaD+Mb0B6Zu0J/2A0rbOBZFv6w==
X-Received: by 2002:a17:907:2ce4:b0:ac7:391b:e688 with SMTP id a640c23a62f3a-ace6b5daee9mr20560566b.58.1745511701167;
        Thu, 24 Apr 2025 09:21:41 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:d677:e5de:3a6:836])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace59c25b01sm127421666b.129.2025.04.24.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:21:40 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:21:36 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sultan Alsawaf <sultan@kerneltoast.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, regressions@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3] cpufreq: Avoid using inconsistent policy->min and
 policy->max
Message-ID: <aAplED3IA_J0eZN0@linaro.org>
References: <5907080.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5907080.DvuYhMxLoT@rjwysocki.net>

Hi Rafael,

On Wed, Apr 16, 2025 at 04:12:37PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since cpufreq_driver_resolve_freq() can run in parallel with
> cpufreq_set_policy() and there is no synchronization between them,
> the former may access policy->min and policy->max while the latter
> is updating them and it may see intermediate values of them due
> to the way the update is carried out.  Also the compiler is free
> to apply any optimizations it wants both to the stores in
> cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_freq()
> which may result in additional inconsistencies.
> 
> To address this, use WRITE_ONCE() when updating policy->min and
> policy->max in cpufreq_set_policy() and use READ_ONCE() for reading
> them in cpufreq_driver_resolve_freq().  Moreover, rearrange the update
> in cpufreq_set_policy() to avoid storing intermediate values in
> policy->min and policy->max with the help of the observation that
> their new values are expected to be properly ordered upfront.
> 
> Also modify cpufreq_driver_resolve_freq() to take the possible reverse
> ordering of policy->min and policy->max, which may happen depending on
> the ordering of operations when this function and cpufreq_set_policy()
> run concurrently, into account by always honoring the max when it
> turns out to be less than the min (in case it comes from thermal
> throttling or similar).
> 
> Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> Cc: 5.16+ <stable@vger.kernel.org> # 5.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This replaces the last 3 patches in
> 
> https://lore.kernel.org/linux-pm/6171293.lOV4Wx5bFT@rjwysocki.net/
> 
> v2 -> v3:
>    * Fold 3 patches into one.
>    * Drop an unrelated white space fixup change.
>    * Fix a typo in a comment (Christian).
> 
> v1 -> v2: Cosmetic changes
> 
> ---
>  drivers/cpufreq/cpufreq.c |   32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -495,8 +495,6 @@
>  {
>  	unsigned int idx;
>  
> -	target_freq = clamp_val(target_freq, policy->min, policy->max);
> -
>  	if (!policy->freq_table)
>  		return target_freq;
>  
> @@ -520,7 +518,22 @@
>  unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>  					 unsigned int target_freq)
>  {
> -	return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
> +	unsigned int min = READ_ONCE(policy->min);
> +	unsigned int max = READ_ONCE(policy->max);
> +
> +	/*
> +	 * If this function runs in parallel with cpufreq_set_policy(), it may
> +	 * read policy->min before the update and policy->max after the update
> +	 * or the other way around, so there is no ordering guarantee.
> +	 *
> +	 * Resolve this by always honoring the max (in case it comes from
> +	 * thermal throttling or similar).
> +	 */
> +	if (unlikely(min > max))
> +		min = max;
> +
> +	return __resolve_freq(policy, clamp_val(target_freq, min, max),
> +			      CPUFREQ_RELATION_LE);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>  
> @@ -2338,6 +2351,7 @@
>  	if (cpufreq_disabled())
>  		return -ENODEV;
>  
> +	target_freq = clamp_val(target_freq, policy->min, policy->max);
>  	target_freq = __resolve_freq(policy, target_freq, relation);
>  
>  	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
> @@ -2631,11 +2645,15 @@
>  	 * Resolve policy min/max to available frequencies. It ensures
>  	 * no frequency resolution will neither overshoot the requested maximum
>  	 * nor undershoot the requested minimum.
> +	 *
> +	 * Avoid storing intermediate values in policy->max or policy->min and
> +	 * compiler optimizations around them because they may be accessed
> +	 * concurrently by cpufreq_driver_resolve_freq() during the update.
>  	 */
> -	policy->min = new_data.min;
> -	policy->max = new_data.max;
> -	policy->min = __resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
> -	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
> +	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RELATION_H));
> +	new_data.min = __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_L);
> +	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);

I've tested the cpufreq throttling again in 6.15-rc3 to check your fix
for the schedutil CPUFREQ_NEED_UPDATE_LIMITS regression I reported [1].
The CPU frequency is now being throttled correctly when reaching high
temperatures. Thanks for fixing this!

Unfortunately, the opposite case has now regressed with this patch:
After the CPU frequency has been throttled due to high temperature and
the device cools down again, the CPU frequency is stuck at minimum until
you reboot. policy->max will never restore to the maximum frequency.

I've confirmed that this causes unexpected slowness after temperature
throttling on a Qualcomm X1E laptop, and Johan has confirmed that e.g.
the ThinkPad X13s is also affected. I would expect that most devices
using cpufreq cooling in the kernel are affected.

Looking at the code, I think the problem is that __resolve_freq() ->
cpufreq_frequency_table_target() -> cpufreq_table_find_index*() and
cpufreq_is_in_limits() are still using the old policy->min/max value.
In this patch, you have only moved the clamp_val() usage directly in
__resolve_freq().

You can see this in the following debug log. I started a stress test
that increases the device temperature until the CPU frequency was
throttled to minimum. Then I stopped the stress test, the device cooled
down, cpufreq_set_policy() was called with the new max frequency, but
__resolve_freq() still returned the frequency clamped to the old maximum.

  [  149.959693] cpufreq: handle_update for cpu 0 called
  [  149.964782] cpufreq: updating policy for CPU 0
  [  149.969411] cpufreq: setting new policy for CPU 0: 0 - 3206400 kHz
  [  149.975842] cpufreq: new min and max freqs are 710400 - 3206400 kHz
  [  149.982347] cpufreq: governor limits update
  [  149.986715] cpufreq: cpufreq_governor_limits: for CPU 0
  [...]
  [  161.219209] cpufreq: handle_update for cpu 0 called
  [  161.224291] cpufreq: updating policy for CPU 0
  [  161.228927] cpufreq: setting new policy for CPU 0: 0 - 710400 kHz
  [  161.235238] cpufreq: new min and max freqs are 710400 - 710400 kHz
  [  161.241635] cpufreq: governor limits update
  [  161.245989] cpufreq: cpufreq_governor_limits: for CPU 0
  [  221.253253] cpufreq: handle_update for cpu 0 called
  [  221.258322] cpufreq: updating policy for CPU 0
  [  221.262946] cpufreq: setting new policy for CPU 0: 0 - 3417600 kHz
  [  221.269418] cpufreq: new min and max freqs are 710400 - 710400 kHz
                 ^ here the new maximum is not being applied
  [  221.275839] cpufreq: governor limits update
  [  221.280195] cpufreq: cpufreq_governor_limits: for CPU 0

Any thoughts how to fix this properly?

Please Cc me if you send a patch with the fix. The Reported-by: tag from
me on the fix for the CPUFREQ_NEED_UPDATE_LIMITS problem didn't Cc me
when sending for some reason, so I only learned about your fix when Greg
sent out the stable backports yesterday. :-)

Thanks,
Stephan

[1]: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org/

#regzbot introduced: 7491cdf46b5cbdf123fc84fbe0a07e9e3d7b7620

