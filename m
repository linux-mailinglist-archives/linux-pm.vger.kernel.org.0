Return-Path: <linux-pm+bounces-24929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A44AA7F8C2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF447A3DAA
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 08:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF0221546;
	Tue,  8 Apr 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGM+TbXw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F7219E99
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102781; cv=none; b=eYrc7TrN5Uqo/EvsoMyUEvXB3IdfwzBIlokHOIt8zD3FAAGthhA+vffuuwVzf+TE/j3yISZ7ae+6+H3S0/Gw6OFsWkhTvdu0/Sx26k66Xu1XyYfmQdjYCHshmqF6a2zbLqLThEeecJY3WIlC+1V2iINc3nsT2gFLmjUblAgZX2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102781; c=relaxed/simple;
	bh=9GDIO++JNka8swO6s9giWNyq+Tl4y4O2HaqtgHOSTTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPRHgLeB6rcjknFVuGLNVmcyk57jHdHTwq7UUc52haLXo50R+Ns7PFD9+bXITnjMmu8NRDkCS9j+bunbIgSrfWXYm0H9MAAfEpVySajsEFFo1++b2/K6un+j+sQzO2lkDEG48Cfa0ZIlTmhy8Be61M9YlFNbI1wGpgPaKeaqAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QGM+TbXw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso34874115e9.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Apr 2025 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744102778; x=1744707578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UW5UEBIC2fvLgEE7aqaeWlqxDj1Xfvs+TW5wbP5DlME=;
        b=QGM+TbXw+bR6uUsQcybe0GvK4OEq+mJDkqO+5Ni9DRRwNJRBxiRarSJm98/r1c+Oyk
         huoM5j2TEl125nkPXNzqNTcJiFjpl2xdgEJAPlQWFsify52DeinV8xwDdn0ExNTSq6Qf
         a2Wjt3MgDmIc+EJ0Jed0/oVZWLCLQpOMejd5A21k0cU5GRPIVCqosamuBgxhj380mAKB
         e6WMmskCiU4u0zZA3s+1O4rYUODKZYuklbwVacTNXqlhXlJ1BPrwnTycbxUtMhzIDyb0
         bfmipBpo3MecKD3iyk/BprJsw55U9n/FKXo6WtYX5B7EeQtGupvPWzbi6C1xM0YvEeuM
         GTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102778; x=1744707578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW5UEBIC2fvLgEE7aqaeWlqxDj1Xfvs+TW5wbP5DlME=;
        b=NfXqN4EL0EjdWMJmK3Ivu0trkwIDqfa4L9dAImXH0PTHsa1ZgrsLR5xLSGQh3zcGjE
         QO/JkSBzvX8k6o1UhEoDDYm6i7TrvbmA5BamGttWm6siJI9WxeQED7wt0XAKK3ZZrEKq
         4lOvGIij6T+gJLftM7ajAHDuvjjUOZVDrN+LoqAGfmIQ8Y5cv05bB5X3g/L2ikFkV2Vx
         GShhrHdKN5ktznmk5GjUOxmn0mnH/d2LKnoFI7QbIE/sq8cs+3rjPUrw08nsOecfjGff
         skAAGY/2LkGrSVBvjssM45dtNg2IdsE3tJjKmC7s9f/SsL6tkRFyfvouSNTEd9UTijqo
         KHFg==
X-Forwarded-Encrypted: i=1; AJvYcCWoP9eu9BlRPiukpjQgoDuWcydm45uUwDwT4dd2hqyo3f/yGLl98qlvocBIXeXRe1hyYP+91CEcxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHCfrXK7mGHvkYeptuiHU6ImLIqQqoS9/WiRUrwhh8IkqeTBu
	y2SHlOZYsleAZcotMR4TQNnxcEay3R+XY7cSXiZkl17PssXdMuEkmTzTUMxdI2k=
X-Gm-Gg: ASbGnctHZCvLPWuGG7hetmermVA9PcXBcOMxXb7TWleLOmMvVnVMbTYjB2h0hXm7BDZ
	5M32jEpPBTTUP8dpqFkvGf1aWRFJOA1yg4jgemvFYLWiHEqb1wvkMnHITR6fFqqVppWlTS6NCIU
	1kVbxNVDCJBbpzmHuOyGVJUnn5kUhd1hhikDKdTJoTM2Z/uyJ32TBX8TfVrrS75U/2hvyMw0nHJ
	HZpkDBKW2pqO3cL8vTa12xgs2LbsW9QkoF8F/9i63VJ4cSvWSw50aqKd9vCnf/YaS7AzVIwDlpW
	NhDFtThJidAKU+0LbBO/7QvZfnn0ppx9aFpZmr90DU+rbTz6LFHKV6s=
X-Google-Smtp-Source: AGHT+IHEfD0DEw0nhPMBkT/vzIF8/zOBJoBPD+hGdZb0j1wbN2G+PRbTcfFssvpUFnD8uApO8cUzMQ==
X-Received: by 2002:a05:600c:1e23:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-43ecf81c304mr140398715e9.5.1744102777838;
        Tue, 08 Apr 2025 01:59:37 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:5d6b:d01c:7ee:e98f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec169b8a3sm156634925e9.19.2025.04.08.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:59:36 -0700 (PDT)
Date: Tue, 8 Apr 2025 10:59:31 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Sultan Alsawaf <sultan@kerneltoast.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused
 by need_freq_update
Message-ID: <Z_Tlc6Qs-tYpxWYb@linaro.org>
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212015734.41241-2-sultan@kerneltoast.com>

Hi,

On Wed, Dec 11, 2024 at 05:57:32PM -0800, Sultan Alsawaf wrote:
> From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
> 
> A redundant frequency update is only truly needed when there is a policy
> limits change with a driver that specifies CPUFREQ_NEED_UPDATE_LIMITS.
> 
> In spite of that, drivers specifying CPUFREQ_NEED_UPDATE_LIMITS receive a
> frequency update _all the time_, not just for a policy limits change,
> because need_freq_update is never cleared.
> 
> Furthermore, ignore_dl_rate_limit()'s usage of need_freq_update also leads
> to a redundant frequency update, regardless of whether or not the driver
> specifies CPUFREQ_NEED_UPDATE_LIMITS, when the next chosen frequency is the
> same as the current one.
> 
> Fix the superfluous updates by only honoring CPUFREQ_NEED_UPDATE_LIMITS
> when there's a policy limits change, and clearing need_freq_update when a
> requisite redundant update occurs.
> 
> This is neatly achieved by moving up the CPUFREQ_NEED_UPDATE_LIMITS test
> and instead setting need_freq_update to false in sugov_update_next_freq().
> 
> Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 28c77904ea74..e51d5ce730be 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  
>  	if (unlikely(sg_policy->limits_changed)) {
>  		sg_policy->limits_changed = false;
> -		sg_policy->need_freq_update = true;
> +		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
>  		return true;
>  	}
>  
> @@ -96,7 +96,7 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
>  	if (sg_policy->need_freq_update)
> -		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> +		sg_policy->need_freq_update = false;
>  	else if (sg_policy->next_freq == next_freq)
>  		return false;
>  

This patch breaks cpufreq throttling (e.g. for thermal cooling) for
cpufreq drivers that:

 - Have policy->fast_switch_enabled/fast_switch_possible set, but
 - Do not have CPUFREQ_NEED_UPDATE_LIMITS flag set

There are several examples for this in the tree (search for
"fast_switch_possible"). Of all those drivers, only intel-pstate and
amd-pstate (sometimes) set CPUFREQ_NEED_UPDATE_LIMITS.

I can reliably reproduce this with scmi-cpufreq on a Qualcomm X1E
laptop:

 1. I added some low temperature trip points in the device tree,
    together with passive cpufreq cooling.
 2. I run a CPU stress test on all CPUs and monitor the temperatures
    and CPU frequencies.

When using "performance" governor instead of "schedutil", the CPU
frequencies are being throttled as expected, as soon as the temperature
trip points are reached.

When using "schedutil", the CPU frequencies stay at maximum as long as
the stress test is running. No throttling happens, so the device heats
up far beyond the defined temperature trip points. Throttling is applied
only after stopping the stress test, since this forces schedutil to
re-evaluate the CPU frequency.

Reverting this commit fixes the problem.

Looking at the code, I think the problem is that:
 - sg_policy->limits_changed does not result in
   sg->policy->need_freq_update without CPUFREQ_NEED_UPDATE_LIMITS
   anymore, and
 - Without sg->policy->need_freq_update, get_next_freq() skips calling
   cpufreq_driver_resolve_freq(), which would normally apply the policy
   min/max constraints.

Do we need to set CPUFREQ_NEED_UPDATE_LIMITS for all cpufreq drivers
that set policy->fast_switch_possible? If I'm reading the documentation
comment correctly, that flag is just supposed to enable notifications if
the policy min/max changes, but the resolved target frequency is still
the same. This is not the case here, the target frequency needs to be
throttled, but schedutil isn't applying the new limits.

Any suggestions how to fix this? I'm happy to test patches with my
setup.

Thanks,
Stephan

#regzbot introduced: 8e461a1cb43d69d2fc8a97e61916dce571e6bb31

