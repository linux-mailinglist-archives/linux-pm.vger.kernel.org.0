Return-Path: <linux-pm+bounces-25549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71161A8B8FA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 14:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7017AF52F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD237248866;
	Wed, 16 Apr 2025 12:26:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612B7247298;
	Wed, 16 Apr 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806405; cv=none; b=qpm5pkHNzMt6FF+HmwMQ8fSnzgc1l7E9Y8cZxDbcjFRGo7W2PaoQX2M62UyP3mlIcf6IY3FXJAOkeZ64kXWf7o4kzIB7vpYC3VJ0SyOPEjdu7ghoM72R5bDWw6ua3rah3O4AkNqtxSb2KyKhtqaSuUJiGBUe489QeNawAcxjlK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806405; c=relaxed/simple;
	bh=vG2J1Hj2FNZuu1cgoj6wUf4S5WfNGtJRWBdxRxCAZO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhSNxim8aKmv+2gy/lgWfXFVAFrJpKTgvmBmwzHMZljbXYupfSUYGAb69VwtLatee+u6PN4xHUkjSCVlkk3secPO5WYEXMHUVH+0wBL9ZsEjw/n1YrfrUbHzWZZ/m9fWW9J+KI4lI5+Hf1TWg4XIcBxTWQrhD6pp1Z+0WBuALYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DA0B1595;
	Wed, 16 Apr 2025 05:26:38 -0700 (PDT)
Received: from [10.1.35.42] (e127648.arm.com [10.1.35.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1C5D3F694;
	Wed, 16 Apr 2025 05:26:37 -0700 (PDT)
Message-ID: <99a6d0e2-5b6e-4cd9-8bd5-e7f24a9a14f0@arm.com>
Date: Wed, 16 Apr 2025 13:26:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] cpufreq/sched: Set need_freq_update in
 ignore_dl_rate_limit()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
References: <6171293.lOV4Wx5bFT@rjwysocki.net>
 <10666429.nUPlyArG6x@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <10666429.nUPlyArG6x@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 11:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that ignore_dl_rate_limit() need not piggy back on the
> limits_changed handling to achieve its goal (which is to enforce a
> frequency update before its due time).
> 
> Namely, if sugov_should_update_freq() is updated to check
> sg_policy->need_freq_update and return 'true' if it is set when
> sg_policy->limits_changed is not set, ignore_dl_rate_limit() may
> set the former directly instead of setting the latter, so it can
> avoid hitting the memory barrier in sugov_should_update_freq().
> 
> Update the code accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Much cleaner now, thanks!
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  kernel/sched/cpufreq_schedutil.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -96,6 +96,9 @@
>  		smp_mb();
>  
>  		return true;
> +	} else if (sg_policy->need_freq_update) {
> +		/* ignore_dl_rate_limit() wants a new frequency to be found. */
> +		return true;
>  	}
>  
>  	delta_ns = time - sg_policy->last_freq_update_time;
> @@ -388,7 +391,7 @@
>  static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
>  {
>  	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
> -		WRITE_ONCE(sg_cpu->sg_policy->limits_changed, true);
> +		sg_cpu->sg_policy->need_freq_update = true;
>  }
>  
>  static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
> 
> 
> 


