Return-Path: <linux-pm+bounces-14053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4813C975BC7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 22:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA81287418
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 20:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83E7149C7D;
	Wed, 11 Sep 2024 20:34:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491D613B284;
	Wed, 11 Sep 2024 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086873; cv=none; b=tF7P7i1ZNLemDfrQ8qd1j88o4ZCfkWelh/CxNUOWzimHJhmzNWnxcJV/1PiE22K3bdefevNGiWfnNHgN/C8Je4+pULF98TTUnfqx+RzAhKljIAyKARA5eJuorDoFAhYQW68wHPQy6b4pcOPyQxqEMYgI+A3nDnJisjEdzBkvA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086873; c=relaxed/simple;
	bh=VOxBUeeLidkTRUpcglXaVU1jliuf+MIXQC9LD2HePFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEVv/Qq5U4PGnfPBWugs3ExTLCrAp4kid3hM57X9zJHP0ltkHRmrzeecGGOMaQCLc8LQIXYBOk0OupmjWp5uXZymtf2oTCunyBvUYqhgNaxeeGjD27xZ4XVd6+puqFaeqtPPbI4n0J7c/Hes7Vf67Ob5t8aMV1A7cEwDIE8CFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCD9D1007;
	Wed, 11 Sep 2024 13:34:53 -0700 (PDT)
Received: from [10.57.50.223] (unknown [10.57.50.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C8713F66E;
	Wed, 11 Sep 2024 13:34:21 -0700 (PDT)
Message-ID: <6e4a4605-f6c5-4948-ac38-c4ddf4990754@arm.com>
Date: Wed, 11 Sep 2024 21:34:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Hongyan Xia
 <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240728184551.42133-1-qyousef@layalina.io>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240728184551.42133-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/24 19:45, Qais Yousef wrote:
> Improve the interaction with cpufreq governors by making the
> cpufreq_update_util() calls more intentional.
> 
> At the moment we send them when load is updated for CFS, bandwidth for
> DL and at enqueue/dequeue for RT. But this can lead to too many updates
> sent in a short period of time and potentially be ignored at a critical
> moment due to the rate_limit_us in schedutil.
> 
> For example, simultaneous task enqueue on the CPU where 2nd task is
> bigger and requires higher freq. The trigger to cpufreq_update_util() by
> the first task will lead to dropping the 2nd request until tick. Or
> another CPU in the same policy triggers a freq update shortly after.
> 
> Updates at enqueue for RT are not strictly required. Though they do help
> to reduce the delay for switching the frequency and the potential
> observation of lower frequency during this delay. But current logic
> doesn't intentionally (at least to my understanding) try to speed up the
> request.
> 
> To help reduce the amount of cpufreq updates and make them more
> purposeful, consolidate them into these locations:
> 
> 1. context_switch()
> 2. task_tick_fair()
> 3. sched_balance_update_blocked_averages()
> 4. on sched_setscheduler() syscall that changes policy or uclamp values
> 5. on check_preempt_wakeup_fair() if wakeup preemption failed
> 6. on __add_running_bw() to guarantee DL bandwidth requirements.
> 

Actually now reading that code again reminded me, there is another
iowait boost change for intel_pstate.
intel_pstate has either intel_pstate_update_util() or
intel_pstate_update_util_hwp().
Both have
	if (smp_processor_id() != cpu->cpu)
		return;
Now since we move that update from enqueue to context_switch() that will
always be false.
I don't think that was deliberate but rather to simplify intel_pstate
synchronization, although !mcq device IO won't be boosted which you
could argue is good.
Just wanted to mention that, doesn't have to be a bad, but surely some
behavior change.

