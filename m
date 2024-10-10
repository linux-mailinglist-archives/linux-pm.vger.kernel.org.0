Return-Path: <linux-pm+bounces-15476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EAB999165
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 20:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11C8B2B710
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 18:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00FA1EF08B;
	Thu, 10 Oct 2024 18:33:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528871EC01D;
	Thu, 10 Oct 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585185; cv=none; b=apYqLL96kiI9kw5CpmFqH+m2hoKnxqxF5TOWkuSwH12b/pYQHL5vtpEKwovp0/AgaadzFWnCLEpuzM7/NKLYBK/u5pSvgLazJAvKC1Q77QfyM53JcwVgsvVX8YFtggwiFME3l0Kcq4pZBkOkx+SXEFwEdZBjtLKOSqMHYXhJZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585185; c=relaxed/simple;
	bh=aHPY+gtyBpQSIvXitjmDkOYsS5G8pG2cXUm8T8Lna/M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rXb3eU13rbBKzZA+tOS/UFwZPdVK5eueRHRFH0Ccb8FV/LO7WksuObe4eysDsxwJvbe02RR/glM8ai4dzowSwZm80lQjwxtjTGLlY3qidbjbsbZb0hnHbj3uRXTHiUsPVBDMjAbSldfQNWYXXnrF1LGPeOTRWv7Cq6axctdRkoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 152C5497;
	Thu, 10 Oct 2024 11:33:32 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 590E33F58B;
	Thu, 10 Oct 2024 11:32:59 -0700 (PDT)
Message-ID: <b1b1e173-5374-4463-a5e1-d1b8c1976fc7@arm.com>
Date: Thu, 10 Oct 2024 19:32:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
From: Christian Loehle <christian.loehle@arm.com>
To: Anjali K <anjalik@linux.ibm.com>, Qais Yousef <qyousef@layalina.io>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Hongyan Xia
 <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ae65e4aa-3407-4fb0-b1f1-eb7c2626f768@linux.ibm.com>
 <fa2f15b1-1602-4fd0-80ff-9d33303b7b5a@arm.com>
Content-Language: en-US
In-Reply-To: <fa2f15b1-1602-4fd0-80ff-9d33303b7b5a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/8/24 10:56, Christian Loehle wrote:
> On 10/7/24 18:20, Anjali K wrote:
>> Hi, I tested this patch to see if it causes any regressions on bare-metal power9 systems with microbenchmarks.
>> The test system is a 2 NUMA node 128 cpu powernv power9 system. The conservative governor is enabled.
>> I took the baseline as the 6.10.0-rc1 tip sched/core kernel.
>> No regressions were found.
>>
>> +------------------------------------------------------+--------------------+----------+
>> |                     Benchmark                        |      Baseline      | Baseline |
>> |                                                      |  (6.10.0-rc1 tip   | + patch  |
>> |                                                      |  sched/core)       |          |
>> +------------------------------------------------------+--------------------+----------+
>> |Hackbench run duration (sec)                          |         1          |   1.01   |
>> |Lmbench simple fstat (usec)                           |         1          |   0.99   |
>> |Lmbench simple open/close (usec)                      |         1          |   1.02   |
>> |Lmbench simple read (usec)                            |         1          |   1      |
>> |Lmbench simple stat (usec)                            |         1          |   1.01   |
>> |Lmbench simple syscall (usec)                         |         1          |   1.01   |
>> |Lmbench simple write (usec)                           |         1          |   1      |
>> |stressng (bogo ops)                                   |         1          |   0.94   |
>> |Unixbench execl throughput (lps)                      |         1          |   0.97   |
>> |Unixbench Pipebased Context Switching throughput (lps)|         1          |   0.94   |
>> |Unixbench Process Creation (lps)                      |         1          |   1      |
>> |Unixbench Shell Scripts (1 concurrent) (lpm)          |         1          |   1      |
>> |Unixbench Shell Scripts (8 concurrent) (lpm)          |         1          |   1.01   |
>> +------------------------------------------------------+--------------------+----------+
>>
>> Thank you,
>> Anjali K
>>
> 
> The default CPUFREQ_DBS_MIN_SAMPLING_INTERVAL is still to have 2 ticks between
> cpufreq updates on conservative/ondemand.
> What is your sampling_rate setting? What's your HZ?
> Interestingly the context switch heavy benchmarks still show -6% don't they?
> Do you mind trying schedutil with a reasonable rate_limit_us, too?


After playing with this a bit more I can see a ~6% regression on
workloads like hackbench too.
That is to around 80% because of the update in check_preempt_wakeup_fair(),
the rest because of the context-switch. Overall the number of
cpufreq_update_util() calls for hackbench -pTl 20000 increased by a
factor of 20-25x, removing the one in check_preempt_wakeup_fair() brings
this down to 10x. For other workloads the amount of
cpufreq_update_util() calls is in the same ballpark as mainline.

I did also look into the forced_update mechanism because that still
bugged me and have to say, I'd prefer removing rate_limit_us,
last_freq_update_time and freq_update_delay_ns altogether. The number
of updates blocked by the rate_limit was already pretty low and have
become negligible now for most workloads/platforms.
commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER") put the
rate_limit_us in the microseconds but even for rate_limit_us==2000
I get on a rk3588 ([LLLL][bb][bb]), 250HZ:

mainline:
update_util	update_util dropped by rate_limit_us	actual freq changes
60s idle:
932	48	12

fio --name=test --rw=randread --bs=4k --runtime=30 --time_based --filename=/dev/nullb0 --thinktime=1ms
40274	129	36

hackbench -pTl 20000
319331	523	41

with $SUBJECT and rate_limit_us==93:
60s idle:
1031	5	11	

fio --name=test --rw=randread --bs=4k --runtime=30 --time_based --filename=/dev/nullb0 --thinktime=1ms
40297	17	32

hackbench -pTl 20000
7252343	600	60

just to mention a few.
This obviously depends on the OPPs, workload, and HZ though.

Overall I find the update (mostly) coming from the perf-domain
(and thus sugov update_lock also mostly contending there) quite
appealing, but given we update more often in terms of frequency and
arguably have more code locations calling the update (reintroduction
of update at enqueue), what exactly are we still consolidating here?

Regards,
Christian

