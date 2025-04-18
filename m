Return-Path: <linux-pm+bounces-25701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48299A935EA
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 12:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D246730A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C0B26FD86;
	Fri, 18 Apr 2025 10:18:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705362528EA;
	Fri, 18 Apr 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971503; cv=none; b=ooyNJkog19saXSMPGfPaTDsv1rriiJqvah9MCSYcWyB+QRx/M4atq3zkEyFe2Wi77eFnRE+5xWbSb6BkbF3PZDA7F2xKH9KNJDq/NjaGprqbHQgT6z9e23eZBQtCeTsdvmewEHngEsRJxRk+C/0Xwbomxf1U/uUSAQF+hFtl4QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971503; c=relaxed/simple;
	bh=CmVPON/iatRsPZzG29/bxbUZ8IXBQNJaac+12CrXTFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZfc8DKxXE2JwAi7nJ2yZT62vSEOhNRr3y+Awy256arX57HtzZ+EZ9NIAgxYy2ILDNSqkrqzIupos0MeMCgOUHVbI6m6a0JDFnDGyP1GGQjLxKoyzmaQPJtq1BBhjufnbio6es/h0TymYfI1103MHZ0GT9qqSdKHrtnJbs4TNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224100e9a5cso21056305ad.2;
        Fri, 18 Apr 2025 03:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971501; x=1745576301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWu+8ChlXVy38S6xmpYuUF0tvb7WzX0hMNuvI4KykjE=;
        b=u4jlLO6doqu34b28eg0esbEiMMRltf/tUhMj+xVDSsEyOSvzyQbF5MO5Y2gkhSh57b
         nZ+yf/xTg+oz5QrXWXFWMiD4EVP8AmODBegnjXpW6sRQbB3YlkybJ0mdfAfQUzXd3sYc
         ddhTw1l69ntQK8jXAm6ny6Ug/5cW5ds5roaLISIAnylpDiRNDZznzSJqzESQTG/2TSi1
         VNzCRcSnMHq7lktfioOZnSoA3ONyGdzTHre/FCxnYLRF5zy8OMqrZVsc0yZiL+3HB0Kf
         CW4/jTfEIn5z8QLHzGE5fjoJtB6ToukQN7USScJH/dxd/Z9RCWrLbrfA3HRUydGGweKB
         taaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIyuXN1vQA/k0lN3fDqYc5lg+rzm+R94R5dAdoXPWNrI+m/4xJQekYr0vGdXPsEnvqBKKOtyRS7FHhDic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNBbyAbPYTBthMD0J7iYdWnUv5JvCQorXyxDdweku+/2tRDCB
	e7AXkwndUat2fZBK7PGwOfQOTCn24AMLRg9DBBCARinSnM8NUjzYurLtb3Fk
X-Gm-Gg: ASbGncsFP4J7mTzn1e2fnBvFDTApXzWTrE2QEwdSIrLqD4eEW3emHmDeNdmItkJT3Ur
	l0vBIJxCf4+ElBJzGes6SmULGBne9jKZVFX78F6tUWrVXlxEZYaXQZhhzNVpWB7OZgk4N1ETga9
	gn+bJtBRP7GQCDr/dsALNkVkDGo3xZ5PbkqGVxv5+SZMRenFd58TGIPwLQLgYAVqy63ebTmYa1P
	T2ldMqrqNQ41A1ncpswqGVrzLbGeRQ/wvklYZel9yZRqqOMbeUJGDFrlGCqYFqubqShqV6vkKz5
	SsAUmrwpom6E+f5I1p0SMQWYBIeLK+z0mVyhpPixD6wjG4+9YvRkMRadouCZOkHJ3aHRJsjkOIr
	Bv+C01kMOIJItRIoSqRNj9AT93aJc
X-Google-Smtp-Source: AGHT+IEsjgW/1z/jDp+j/0gbGgsoTmvWeHA8/861Tm7YHQ56kuNSS6q7YrFe9pB+7RJFBiq1SfqSRQ==
X-Received: by 2002:a17:902:e747:b0:225:b718:4dff with SMTP id d9443c01a7336-22c5361b4cfmr32304705ad.53.1744971500576;
        Fri, 18 Apr 2025 03:18:20 -0700 (PDT)
Received: from sultan-box.localdomain (n122-107-215-46.sbr1.nsw.optusnet.com.au. [122.107.215.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaee68bsm1305632b3a.175.2025.04.18.03.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:18:20 -0700 (PDT)
Date: Fri, 18 Apr 2025 20:18:11 +1000
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 5/6] cpufreq: Avoid using inconsistent policy->min and
 policy->max
Message-ID: <aAIm48RPmm1d_Y6u@sultan-box.localdomain>
References: <6171293.lOV4Wx5bFT@rjwysocki.net>
 <9458818.CDJkKcVGEf@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9458818.CDJkKcVGEf@rjwysocki.net>

On Tue, Apr 15, 2025 at 12:04:21PM +0200, Rafael J. Wysocki wrote:
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
> v1 -> v2: Minor edit in the subject
> 
> ---
>  drivers/cpufreq/cpufreq.c |   46 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -490,14 +490,12 @@
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>  
> -static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *policy,
> -					   unsigned int target_freq,
> -					   unsigned int relation)
> +static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> +				   unsigned int target_freq,
> +				   unsigned int relation)
>  {
>  	unsigned int idx;
>  
> -	target_freq = clamp_val(target_freq, policy->min, policy->max);
> -
>  	if (!policy->freq_table)
>  		return target_freq;
>  
> @@ -507,6 +505,15 @@
>  	return policy->freq_table[idx].frequency;
>  }
>  
> +static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *policy,
> +					   unsigned int target_freq,
> +					   unsigned int relation)
> +{
> +	target_freq = clamp_val(target_freq, policy->min, policy->max);
> +
> +	return __resolve_freq(policy, target_freq, relation);
> +}
> +
>  /**
>   * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
>   * one.
> @@ -521,7 +528,22 @@
>  unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>  					 unsigned int target_freq)
>  {
> -	return clamp_and_resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
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
> @@ -2632,11 +2654,15 @@
>  	 * Resolve policy min/max to available frequencies. It ensures
>  	 * no frequency resolution will neither overshoot the requested maximum
>  	 * nor undershoot the requested minimum.
> +	 *
> +	 * Avoid storing intermediate values in policy->max or policy->min and
> +	 * compiler optimizations around them because them may be accessed
> +	 * concurrently by cpufreq_driver_resolve_freq() during the update.
>  	 */
> -	policy->min = new_data.min;
> -	policy->max = new_data.max;
> -	policy->min = clamp_and_resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
> -	policy->max = clamp_and_resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
> +	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RELATION_H));
> +	new_data.min = __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_L);
> +	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);

I don't think this is sufficient, because this still permits an incoherent
policy->min and policy->max combination, which makes it possible for schedutil
to honor the incoherent limits; i.e., schedutil may observe old policy->min and
new policy->max or vice-versa.

We also can't permit a wrong freq to be propagated to the driver and then send
the _right_ freq afterwards; IOW, we can't let a bogus freq slip through and
just correct it later.

How about using a seqlock?

Sultan

