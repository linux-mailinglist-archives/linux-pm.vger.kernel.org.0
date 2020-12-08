Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7F62D2B0B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 13:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgLHMcR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 07:32:17 -0500
Received: from foss.arm.com ([217.140.110.172]:48326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgLHMcQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 07:32:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEF861FB;
        Tue,  8 Dec 2020 04:31:30 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 243FD3F68F;
        Tue,  8 Dec 2020 04:31:27 -0800 (PST)
Subject: Re: [PATCH V4 3/3] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
References: <cover.1606198885.git.viresh.kumar@linaro.org>
 <c0d7c796be7df6ac0102d8c2701fc6b541d2ff7d.1606198885.git.viresh.kumar@linaro.org>
 <95991789-0308-76a9-735b-01ef620031b9@arm.com>
 <20201207121704.hpyw3ij3wvb5s7os@vireshk-i7>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <dfe2693c-8e9a-3103-2135-8c9a87be3ab1@arm.com>
Date:   Tue, 8 Dec 2020 13:31:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207121704.hpyw3ij3wvb5s7os@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/12/2020 13:17, Viresh Kumar wrote:
> On 03-12-20, 12:54, Dietmar Eggemann wrote:
>> On 24/11/2020 07:26, Viresh Kumar wrote:

[...]

>> When I ran schbench (-t 16 -r 5) on hikey960 I get multiple (~50)
>> instances of ~80ms task activity phase and then ~20ms idle phase on all
>> CPUs.
>>
>> So I assume that scenario 1 is at the beginning (but you mentioned the
>> task were sleeping?)
> 
> I am not able to find the exact values I used, but I did something
> like this to create a scenario where the old computations shall find
> the CPU as idle in the last IPA window:
> 
> - schbench -m 2 -t 4 -s 25000 -c 20000 -r 60
> 
> - sampling rate of IPA to 10 ms
> 
> With this IPA wakes up many times and finds the CPUs to have been idle
> in the last IPA window (i.e. 10ms).

Ah, this makes sense.

So with this there are only 8 worker threads w/ 20ms runtime and 75ms
period (30ms message thread time (-C) and 25 latency (-c)).

So much more idle time between two invocations of the worker/message
threads and more IPA sampling.

[...]

>>>  Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=800 load={{0x64,0x64,0x64,0x64,0x64,0x64,0x64,0x64}} dynamic_power=5280
>>>  New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=708 load={{0x4d,0x5c,0x5c,0x5b,0x5c,0x5c,0x51,0x5b}} dynamic_power=4672
>>>
>>> As can be seen, the idle time based load is 100% for all the CPUs as it
>>> took only the last window into account, but in reality the CPUs aren't
>>> that loaded as shown by the utilization numbers.
>>
>> Is this an IPA sampling at the end of the ~20ms idle phase?
> 
> This is during the phase where the CPUs were fully busy for the last
> period.

OK.

