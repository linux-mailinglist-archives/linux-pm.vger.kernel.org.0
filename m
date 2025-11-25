Return-Path: <linux-pm+bounces-38542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD493C84494
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 902054E1F18
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A346B259CB6;
	Tue, 25 Nov 2025 09:45:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA037256D;
	Tue, 25 Nov 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063939; cv=none; b=ESJeLBQr2RzYpAsOU14ekiGPuHQSkcwi7SLZTjealRh+xhnE3+mV5b79c9m7SKg9uVSWC8Y0rXUa7/OPrxHa5OS6GVtntPb0PvBHvEljHXQ2EEQpShH8ZwaNviKGhfA9y1kpHy15h5Rw73tsN6dqkgpxnXVI2FS1ZiyBlBCMJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063939; c=relaxed/simple;
	bh=a48C5T6ENsbSBoimwDvD/ho55hLflc0rsQZk/dIQaYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1Ge+uPSpwpCKilDolg4lwOt7QRYAe59PQvqE0wGwbTD6h1pWE7hIdQSMBfnyZapujcOxuTS9rlLuwevEoG3BYL/r8evzcOBMXsuvA+/ekZZpomWXewoSRooLZYVpSxoFi7RE3OP5c87b1yPhxtDa9waQQSi9zv3GYM8pWIjvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DFA11477;
	Tue, 25 Nov 2025 01:45:28 -0800 (PST)
Received: from [10.57.40.104] (unknown [10.57.40.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D727D3F66E;
	Tue, 25 Nov 2025 01:45:33 -0800 (PST)
Message-ID: <2be3bf24-a707-48df-b224-22b5ab290006@arm.com>
Date: Tue, 25 Nov 2025 09:46:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yu-Che Cheng <giver@google.com>, Tomasz Figa <tfiga@chromium.org>,
 stable@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com>
 <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sergey,

On 11/21/25 03:55, Sergey Senozhatsky wrote:
> Hi Christian,
> 
> On (25/11/20 10:15), Christian Loehle wrote:
>> On 11/20/25 04:45, Sergey Senozhatsky wrote:
>>> Hi,
>>>
>>> We are observing a performance regression on one of our arm64 boards.
>>> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
>>> Rework schedutil governor performance estimation").
>>>
>>> UI speedometer benchmark:
>>> w/commit:	395  +/-38
>>> w/o commit:	439  +/-14
>>>
>>
>> Hi Sergey,
>> Would be nice to get some details. What board?
> 
> It's an MT8196 chromebook.
> 
>> What do the OPPs look like?
> 
> How do I find that out?
> 
>> Does this system use uclamp during the benchmark? How?
> 
> How do I find that out?
> 
>> Given how large the stddev given by speedometer (version 3?) itself is, can we get the
>> stats of a few runs?
> 
> v2.1
> 
> w/o patch     w/ patch
> 440 +/-30     406 +/-11
> 440 +/-14     413 +/-16
> 444 +/-12     403 +/-14
> 442 +/-12     412 +/-15
> 
>> Maybe traces of cpu_frequency for both w/ and w/o?
> 
> trace-cmd record -e power:cpu_frequency attached.
> 
> "base" is with ada8d7fa0ad4
> "revert" is ada8d7fa0ad4 reverted.


I did some analysis based on your trace files.
I have been playing some time ago with speedometer performance
issues so that's why I'm curious about your report here.

I've filtered your trace purely based on cpu7 (the single biggest cpu).
Then I have cut the data from the 'warm-up' phase in both traces, to
have similar start point (I think).

It looks like the 2 traces can show similar 'pattern' of that benchmark
which is good for analysis. If you align the timestamp:
176.051s and 972.465s then both plots (frequency changes in time) look
similar.

There are some differences, though:
1. there are more deeps in the freq in time, so more often you would
    pay extra penalty for the ramp-up again
2. some of the ramp-up phases are a bit longer ~100ms instead of ~80ms
    going from 2GHz to 3.6GHz
3.


There are idle phases missing in the trace, so we have to be careful
when e.g. comparing avg frequency, because that might not be the real
indication of the delivered computation and not indicate the gap in the 
score.

Here are the stats:
1. revert:
frequency
count  1.318000e+03
mean   2.932240e+06
std    5.434045e+05
min    2.000000e+06
50%    3.000000e+06
85%    3.600000e+06
90%    3.626000e+06
95%    3.626000e+06
99%    3.626000e+06
max    3.626000e+06

2. base:
           frequency
count  1.551000e+03
mean   2.809391e+06
std    5.369750e+05
min    2.000000e+06
50%    2.800000e+06
85%    3.500000e+06
90%    3.600000e+06
95%    3.626000e+06
99%    3.626000e+06
max    3.626000e+06


A better indication in this case would be comparison of the frequency
residency in time, especially for the max freq:
1. revert: 11.92s
2. base: 9.11s

So there is 2.8s longer residency for that fmax (while we even have
longer period for finishing that Speedometer 2 test on 'base').

Here is some detail about that run*:
+---------------+---------------------+---------------+----------------+
| Trace         | Total Trace         | Time at Max   | % of Total     |
|               | Duration (s)        | Freq (s)      | Time           |
+---------------+---------------------+---------------+----------------+
| Base Trace    | 24.72               | 9.11          | 36.9%          |
| Revert Trace  | 22.88               | 11.92         | 52.1%          |
+---------------+---------------------+---------------+----------------+

*We don't know the idle periods which might happen for those frequencies


I wonder if you had a fix patch for the util_est in your kernel...
That fix has been recently backported to 6.6 stable [1].

You might want to try that patch as well, w/ or w/o this revert.
IMHO it might be worth to have it on top. It might help
the main Chrome task ('CrRendererMain') to stay longer on the biggest
cpu, since the util_est would be higher. You can read the discussion
that I had back then with PeterZ and VincentG [2].

Regards,
Lukasz

[1] 
https://lore.kernel.org/stable/20251121130232.828187990@linuxfoundation.org/
[2] 
https://lore.kernel.org/lkml/20230912142821.GA22166@noisy.programming.kicks-ass.net/

