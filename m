Return-Path: <linux-pm+bounces-25755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44061A9462A
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 03:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9571898E83
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 01:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9BB12E5D;
	Sun, 20 Apr 2025 01:10:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D763B9;
	Sun, 20 Apr 2025 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745111425; cv=none; b=THw5ewrDSBOVj7Mz0oYEGYzDDokUX2Bhi3bO43EI1lhe5jJ+xpwZeSjKjaoPV9HBQQCJjiy3OeaTc66BvMTb6l60B2941X7EoERwiEtF5ZPj8zguL5+RRdX26xCeLHTXXozYdcdTbbz9ghsQ+mXg2X6IdR9Cp3iwhktCPL7P3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745111425; c=relaxed/simple;
	bh=ja50x9YSZBiEJzoBeBeZJTWwVHlolA3KqEdNCZcDRmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpNQEtrCpqfo9oKrZRlmq1ZfMwfUMIPptl42HEo3hPEh96V9ff2YdMopYd88in8EPliROC1oXpp/h6/Bv01OT2IUN3byLXG9PK5MfRd36Xm6vNRd0XsQiKHKZ/CHCJsXAh1sghVJVSF8owALWoaybNSQsZDhFnh4d5ehYgaGKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223fb0f619dso33633355ad.1;
        Sat, 19 Apr 2025 18:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745111423; x=1745716223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmtt+iGwGo57tSqQlN6wy7yMxAZqiR8ZZe19BPCcPEg=;
        b=l/dgHxd8m30kcJU6Ra8ayBs1ns397tHHAk+lrWyLY8A8T4dgDs+A1D3v1PWy4yuqOl
         4/BCCBBxBGoYr6U65MOP2pFISz3cvtHjf3ZCJW+tJ+qnYcV06js5rrgmsqXdE9TdGKj9
         NCAOavJ7ZK1mdGYA1AehsdfhvTZ6YIou0VUwZYFFJrTlicHsKDghPVbndQhaszVdPD+0
         qpGqYdNyVwj4wtljgXg76j6mJmRABfIztmeFLYk6kXrdxE2Po6CsNMDEo6pZlhqS+H91
         nIsOPIS+4QYe6ynPYn516GB+Uk4OySVRNcgKOvTl0T31okmBNU/AePcjKEfiBOzzS3i1
         dO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs+aO+Qmx4vFk83KPM31xTuOMAC8bFmBLCHsdKsAtANWD1balBl4cin0FJ+p91HnHSarvsVOy0er6HLKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMDpSQuM5uHLXTPyLO79nn1OugMxGOGylZQCtDpLc4Mtqr329O
	zOXkGGogln+OTI1tII18GWO4yXc8y/Z9IaQnjrm7JFfoCzshOKldwd35BCQzv8M=
X-Gm-Gg: ASbGncuMfEKiuMFj4BlmkZVA5P2X3J6xUYV9vkvpjRVM4GPk3bQK/I5M3Lt1uqNMmnp
	y+Y5Rnfvp6kmr6irzS1x5CnDOWVAwm0hjvQhgbEQOwPnVVtWVSvzPC36wwVq4NKBuuLeuh3gUze
	rYlH3pItk7HvYwRWUHUumpCep4fFELfkAwzEKj5L9dBcrycz0r0VWZ9jPBFNiD1TtBY185SZ+wF
	r0wCySbl9iCow59QLni5afzW7zpeYC9JbK+uLH4yDnVjshxC+OCKd+Jyo8sTU+rE33+4TD6u2Fm
	p+lEtLaD53YTe2wzGz2N7cwh9q7cjYp+MCVO4XghemewO3WGofp8YQTv39vnR+gAKuyokLcfbTT
	5nGfAmihBtnND9LWLF+W+UGwkKO0j
X-Google-Smtp-Source: AGHT+IELFEeT36yzUXduH5Fc3nPW03gNNzv3CpJC4KPjiXo9WDn2r/50Tid6nCAnSPzc6LaPnFU9Yg==
X-Received: by 2002:a17:903:19e3:b0:224:1af1:87f4 with SMTP id d9443c01a7336-22c5358625amr125819405ad.22.1745111422905;
        Sat, 19 Apr 2025 18:10:22 -0700 (PDT)
Received: from sultan-box.localdomain (n122-107-215-46.sbr1.nsw.optusnet.com.au. [122.107.215.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb427csm39739665ad.113.2025.04.19.18.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 18:10:22 -0700 (PDT)
Date: Sun, 20 Apr 2025 11:10:13 +1000
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
Subject: Re: [PATCH v2 1/6] cpufreq/sched: Fix the usage of
 CPUFREQ_NEED_UPDATE_LIMITS
Message-ID: <aARJdWE8VtWZPpK7@sultan-box.localdomain>
References: <6171293.lOV4Wx5bFT@rjwysocki.net>
 <3010358.e9J7NaK4W3@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3010358.e9J7NaK4W3@rjwysocki.net>

On Tue, Apr 15, 2025 at 11:58:08AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused
> by need_freq_update") modified sugov_should_update_freq() to set the
> need_freq_update flag only for drivers with CPUFREQ_NEED_UPDATE_LIMITS
> set, but that flag generally needs to be set when the policy limits
> change because the driver callback may need to be invoked for the new
> limits to take effect.
> 
> However, if the return value of cpufreq_driver_resolve_freq() after
> applying the new limits is still equal to the previously selected
> frequency, the driver callback needs to be invoked only in the case
> when CPUFREQ_NEED_UPDATE_LIMITS is set (which means that the driver
> specifically wants its callback to be invoked every time the policy
> limits change).
> 
> Update the code accordingly to avoid missing policy limits changes for
> drivers without CPUFREQ_NEED_UPDATE_LIMITS.
> 
> Fixes: 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused by need_freq_update")
> Closes: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org/
> Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for fixing this.

Reviewed-by: Sultan Alsawaf <sultan@kerneltoast.com>

> ---
> 
> v1 -> v2:
>    * Always set need_freq_update when limits_changed is set.
>    * Take CPUFREQ_NEED_UPDATE_LIMITS into account in sugov_update_next_freq().
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |   18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -83,7 +83,7 @@
>  
>  	if (unlikely(sg_policy->limits_changed)) {
>  		sg_policy->limits_changed = false;
> -		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> +		sg_policy->need_freq_update = true;
>  		return true;
>  	}
>  
> @@ -95,10 +95,22 @@
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
> -	if (sg_policy->need_freq_update)
> +	if (sg_policy->need_freq_update) {
>  		sg_policy->need_freq_update = false;
> -	else if (sg_policy->next_freq == next_freq)
> +		/*
> +		 * The policy limits have changed, but if the return value of
> +		 * cpufreq_driver_resolve_freq() after applying the new limits
> +		 * is still equal to the previously selected frequency, the
> +		 * driver callback need not be invoked unless the driver
> +		 * specifically wants that to happen on every update of the
> +		 * policy limits.
> +		 */
> +		if (sg_policy->next_freq == next_freq &&
> +		    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> +			return false;
> +	} else if (sg_policy->next_freq == next_freq) {
>  		return false;
> +	}
>  
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;
> 
> 
> 

