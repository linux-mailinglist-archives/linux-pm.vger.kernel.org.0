Return-Path: <linux-pm+bounces-14364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA3497AEAC
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 12:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4380FB23F54
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 10:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083BA15C13E;
	Tue, 17 Sep 2024 10:22:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF63159571;
	Tue, 17 Sep 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568536; cv=none; b=PwncjNswHS6VqQ74dWd0g2/EDCtwga31JQUfiwrT+S7y6XgCfxQC4igUPJmvpRBc3seIpSxm8+5XcRCuGRHEo5/846ZoIdCIWJcrzOSAi5/Ts3NS5quB6i61gp6kWPGfljWBDoJ8roTrB/zPlQeq5XHcA4Sqq7DYLnlKRPxALUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568536; c=relaxed/simple;
	bh=MX7hrA4AKrbGn96IPppUU4/Y35+8h9yCbDoZTZtKY+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkFAy5GgnkFrYxJhAJzgqhEQ9jh72rm2EA94IT2RG+nWRDsSKQxGh6EvB7lENH+j7LKnu6T5gH4Rh314VgDwcnQyeQ1P36/ju3RvpxVGkJdmbaaDZvNFHt6eVQkXRUCxPYehNBQvfmwWeZ4m+tSCurZ47KQUdPFsgf8DuayHXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB5961007;
	Tue, 17 Sep 2024 03:22:43 -0700 (PDT)
Received: from [10.1.35.57] (e127648.arm.com [10.1.35.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 020813F64C;
	Tue, 17 Sep 2024 03:22:12 -0700 (PDT)
Message-ID: <e41ad66f-b8eb-4a17-aab0-6dc0f8fa55f8@arm.com>
Date: Tue, 17 Sep 2024 11:22:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/16] sched/schedutil: Add a new tunable to dictate
 response time
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-7-qyousef@layalina.io>
 <c55339cd-85d6-4777-beec-41c4d9931b9a@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <c55339cd-85d6-4777-beec-41c4d9931b9a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/24 23:22, Dietmar Eggemann wrote:
> On 20/08/2024 18:35, Qais Yousef wrote:
>> The new tunable, response_time_ms,  allow us to speed up or slow down
>> the response time of the policy to meet the perf, power and thermal
>> characteristic desired by the user/sysadmin. There's no single universal
>> trade-off that we can apply for all systems even if they use the same
>> SoC. The form factor of the system, the dominant use case, and in case
>> of battery powered systems, the size of the battery and presence or
>> absence of active cooling can play a big role on what would be best to
>> use.
>>
>> The new tunable provides sensible defaults, but yet gives the power to
>> control the response time to the user/sysadmin, if they wish to.
>>
>> This tunable is applied before we apply the DVFS headroom.
>>
>> The default behavior of applying 1.25 headroom can be re-instated easily
>> now. But we continue to keep the min required headroom to overcome
>> hardware limitation in its speed to change DVFS. And any additional
>> headroom to speed things up must be applied by userspace to match their
>> expectation for best perf/watt as it dictates a type of policy that will
>> be better for some systems, but worse for others.
>>
>> There's a whitespace clean up included in sugov_start().
>>
>> Signed-off-by: Qais Yousef <qyousef@layalina.io>
>> ---
>>  Documentation/admin-guide/pm/cpufreq.rst |  17 +++-
>>  drivers/cpufreq/cpufreq.c                |   4 +-
>>  include/linux/cpufreq.h                  |   3 +
>>  kernel/sched/cpufreq_schedutil.c         | 115 ++++++++++++++++++++++-
>>  4 files changed, 132 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
>> index 6adb7988e0eb..fa0d602a920e 100644
>> --- a/Documentation/admin-guide/pm/cpufreq.rst
>> +++ b/Documentation/admin-guide/pm/cpufreq.rst
>> @@ -417,7 +417,7 @@ is passed by the scheduler to the governor callback which causes the frequency
>>  to go up to the allowed maximum immediately and then draw back to the value
>>  returned by the above formula over time.
>>  
>> -This governor exposes only one tunable:
>> +This governor exposes two tunables:
>>  
>>  ``rate_limit_us``
>>  	Minimum time (in microseconds) that has to pass between two consecutive
>> @@ -427,6 +427,21 @@ This governor exposes only one tunable:
>>  	The purpose of this tunable is to reduce the scheduler context overhead
>>  	of the governor which might be excessive without it.
>>  
>> +``respone_time_ms``
s/respone/response
>> +	Amount of time (in milliseconds) required to ramp the policy from
>> +	lowest to highest frequency. Can be decreased to speed up the
>                   ^^^^^^^^^^^^^^^^^
> 
> This has changed IMHO. Should be the time from lowest (or better 0) to
> second highest frequency.
> 
> https://lkml.kernel.org/r/20230827233203.1315953-6-qyousef@layalina.io
> 
> [...]
> 

Isn't it even more complicated than that?
We have the headroom applied on top of the response_time_ms, so
response_time_ms will be longer than the time it takes to reach highest cap OPP.
Furthermore, applying this to a big CPU e.g. with OPP0 cap of 200, starting
from 0 is (usually?) irrelevant, as we likely wouldn't be here if we were at 0.
I get the intent, but conveying this in an understandable interface is hard.

