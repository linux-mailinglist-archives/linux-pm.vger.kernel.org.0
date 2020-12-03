Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23F62CD4F6
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 12:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgLCLyv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 06:54:51 -0500
Received: from foss.arm.com ([217.140.110.172]:38240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgLCLyv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Dec 2020 06:54:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7239911D4;
        Thu,  3 Dec 2020 03:54:05 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DDC43F718;
        Thu,  3 Dec 2020 03:54:03 -0800 (PST)
Subject: Re: [PATCH V4 3/3] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
References: <cover.1606198885.git.viresh.kumar@linaro.org>
 <c0d7c796be7df6ac0102d8c2701fc6b541d2ff7d.1606198885.git.viresh.kumar@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <95991789-0308-76a9-735b-01ef620031b9@arm.com>
Date:   Thu, 3 Dec 2020 12:54:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c0d7c796be7df6ac0102d8c2701fc6b541d2ff7d.1606198885.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/11/2020 07:26, Viresh Kumar wrote:
> Several parts of the kernel are already using the effective CPU
> utilization (as seen by the scheduler) to get the current load on the
> CPU, do the same here instead of depending on the idle time of the CPU,
> which isn't that accurate comparatively.
> 
> This is also the right thing to do as it makes the cpufreq governor
> (schedutil) align better with the cpufreq_cooling driver, as the power
> requested by cpufreq_cooling governor will exactly match the next
> frequency requested by the schedutil governor since they are both using
> the same metric to calculate load.
> 
> This was tested on ARM Hikey6220 platform with hackbench, sysbench and
> schbench. None of them showed any regression or significant
> improvements. Schbench is the most important ones out of these as it
> creates the scenario where the utilization numbers provide a better
> estimate of the future.
> 
> Scenario 1: The CPUs were mostly idle in the previous polling window of
> the IPA governor as the tasks were sleeping and here are the details
> from traces (load is in %):
> 
>  Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=203 load={{0x35,0x1,0x0,0x31,0x0,0x0,0x64,0x0}} dynamic_power=1339
>  New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=600 load={{0x60,0x46,0x45,0x45,0x48,0x3b,0x61,0x44}} dynamic_power=3960

When I ran schbench (-t 16 -r 5) on hikey960 I get multiple (~50)
instances of ~80ms task activity phase and then ~20ms idle phase on all
CPUs.

So I assume that scenario 1 is at the beginning (but you mentioned the
task were sleeping?) and scenario 2 is somewhere in the middle of the
testrun?
IMHO, the util-based approach delivers really better results at the
beginning and at the end of the entire testrun.
During the testrun, the util-based and the idle-based approach deliver
similar results.

It's a little bit tricky to compare test results since the IPA sampling
rate is 100ms and the load values you get depend on how the workload
pattern and the IPA sampling align.

> Here, the "Old" line gives the load and requested_power (dynamic_power
> here) numbers calculated using the idle time based implementation, while
> "New" is based on the CPU utilization from scheduler.
> 
> As can be clearly seen, the load and requested_power numbers are simply
> incorrect in the idle time based approach and the numbers collected from
> CPU's utilization are much closer to the reality.

I assume the IPA sampling is done after ~50ms of the first task activity
phase.

> Scenario 2: The CPUs were busy in the previous polling window of the IPA
> governor:
> 
>  Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=800 load={{0x64,0x64,0x64,0x64,0x64,0x64,0x64,0x64}} dynamic_power=5280
>  New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=708 load={{0x4d,0x5c,0x5c,0x5b,0x5c,0x5c,0x51,0x5b}} dynamic_power=4672
> 
> As can be seen, the idle time based load is 100% for all the CPUs as it
> took only the last window into account, but in reality the CPUs aren't
> that loaded as shown by the utilization numbers.

Is this an IPA sampling at the end of the ~20ms idle phase?

[...]
