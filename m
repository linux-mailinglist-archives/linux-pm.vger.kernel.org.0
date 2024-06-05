Return-Path: <linux-pm+bounces-8644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C878FCE77
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 15:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3191C2140F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD1019AD4B;
	Wed,  5 Jun 2024 12:24:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C4B19AD47;
	Wed,  5 Jun 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590251; cv=none; b=Bqf+zroYqFVuDbzEIW0laaJIXen2N5RYLucQ4ollRAEX0Hm+UbW58nKRuU21il7xKMzxrbmH1ns067rl8wLz2RtUMgzTsUtGAruUBYXVV8EoIvlFl+jrDRAzhWzumMHDBbWfwACnHywJ/NJ1zfca3UL5XqViXGZJmShheKf/oCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590251; c=relaxed/simple;
	bh=n3ty1xTwxBm5dX7g7QjOm3hVgjJlDQb1B6sZe0BtFLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6NriYWE8M1wfrHqM4vmZ+II5UZuHd3EM4j+U/egbkvSdRm3UkHOjXeX4+DRrlU6asvXlAL/JOS+8Q4TbJBcuVpTqqSBlLwkHFQwV3S3VmfUqBn2awlTkrEWJ7JfDBp0Yt8/1Gq1pCgVVMeejt0ut2muXBuWePRAgY3oVMt2m2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A340C339;
	Wed,  5 Jun 2024 05:24:32 -0700 (PDT)
Received: from [10.1.32.39] (e127648.arm.com [10.1.32.39])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D83583F762;
	Wed,  5 Jun 2024 05:24:04 -0700 (PDT)
Message-ID: <1b44938c-9535-47e7-8cbc-2b844e5dfdff@arm.com>
Date: Wed, 5 Jun 2024 13:24:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Hongyan Xia
 <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240530104653.1234004-1-qyousef@layalina.io>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240530104653.1234004-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/24 11:46, Qais Yousef wrote:
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
> 3. update_blocked_averages()
> 4. on syscall that changes policy or uclamp values
> 
> The update at context switch should help guarantee that DL and RT get
> the right frequency straightaway when they're RUNNING. As mentioned
> though the update will happen slightly after enqueue_task(); though in
> an ideal world these tasks should be RUNNING ASAP and this additional
> delay should be negligible.

Do we care at all about PREEMPT_NONE (and voluntary) here? I assume no.
Anyway one scenario that should regress when we don't update at RT enqueue:
(Essentially means that util of higher prio dominates over lower, if
higher is enqueued first.)
System:
OPP 0, cap: 102, 100MHz; OPP 1, cap: 1024, 1000MHz
RT task A prio=0 runtime@OPP1=1ms, uclamp_min=0; RT task B prio=1 runtime@OPP1=1ms, uclamp_min=1024
rate_limit_us = freq transition delay = 1 (assume basically instant switch)
Let's say CONFIG_HZ=100 for the tick to not get in the way, doesn't really matter.

Before:
t+0:		Enqueue task A switch to OPP0
Running A at OPP 0
t+2us:		Enqueue task B switch to OPP1
t+1000us:	Task A done, switch to task B.
t+2000us:	Task B done

Now:
t+0:		Enqueue task A switch to OPP0
Running A at OPP 0
t+2us:		Enqueue task B
t+10000us:	Task A done, switch to task B and OPP1
t+11000us:	Task B done

Or am I missing something?

Kind Regards,
Christian

> [snip]

