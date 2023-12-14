Return-Path: <linux-pm+bounces-1133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86D812A6D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 09:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453DD281F80
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B971D52D;
	Thu, 14 Dec 2023 08:31:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1CC812A;
	Thu, 14 Dec 2023 00:31:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 021BEC15;
	Thu, 14 Dec 2023 00:32:25 -0800 (PST)
Received: from [10.57.85.242] (unknown [10.57.85.242])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3249B3F5A1;
	Thu, 14 Dec 2023 00:31:34 -0800 (PST)
Message-ID: <2c2fad2b-89ce-437e-96b3-f06e6f99639f@arm.com>
Date: Thu, 14 Dec 2023 08:32:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Rework system pressure interface to the scheduler
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org,
 linux-trace-kernel@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, mhiramat@kernel.org, vschneid@redhat.com,
 bristot@redhat.com, mgorman@suse.de, bsegall@google.com,
 juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 konrad.dybcio@linaro.org, andersson@kernel.org, agross@kernel.org,
 rui.zhang@intel.com, viresh.kumar@linaro.org, rafael@kernel.org,
 sudeep.holla@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <47b4cbcb-d33d-4699-a148-0108cf734e23@arm.com>
 <CAKfTPtATWSWdk1dhnMvBqTZigtprv7d_0j0zpf48WfVDfMit5g@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtATWSWdk1dhnMvBqTZigtprv7d_0j0zpf48WfVDfMit5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/14/23 08:29, Vincent Guittot wrote:
> On Thu, 14 Dec 2023 at 09:21, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Vincent,
>>
>> I've been waiting for this feature, thanks!
>>
>>
>> On 12/12/23 14:27, Vincent Guittot wrote:
>>> Following the consolidation and cleanup of CPU capacity in [1], this serie
>>> reworks how the scheduler gets the pressures on CPUs. We need to take into
>>> account all pressures applied by cpufreq on the compute capacity of a CPU
>>> for dozens of ms or more and not only cpufreq cooling device or HW
>>> mitigiations. we split the pressure applied on CPU's capacity in 2 parts:
>>> - one from cpufreq and freq_qos
>>> - one from HW high freq mitigiation.
>>>
>>> The next step will be to add a dedicated interface for long standing
>>> capping of the CPU capacity (i.e. for seconds or more) like the
>>> scaling_max_freq of cpufreq sysfs. The latter is already taken into
>>> account by this serie but as a temporary pressure which is not always the
>>> best choice when we know that it will happen for seconds or more.
>>>
>>> [1] https://lore.kernel.org/lkml/20231211104855.558096-1-vincent.guittot@linaro.org/
>>>
>>> Vincent Guittot (4):
>>>     cpufreq: Add a cpufreq pressure feedback for the scheduler
>>>     sched: Take cpufreq feedback into account
>>>     thermal/cpufreq: Remove arch_update_thermal_pressure()
>>>     sched: Rename arch_update_thermal_pressure into
>>>       arch_update_hw_pressure
>>>
>>>    arch/arm/include/asm/topology.h               |  6 +--
>>>    arch/arm64/include/asm/topology.h             |  6 +--
>>>    drivers/base/arch_topology.c                  | 26 ++++-----
>>>    drivers/cpufreq/cpufreq.c                     | 48 +++++++++++++++++
>>>    drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +-
>>>    drivers/thermal/cpufreq_cooling.c             |  3 --
>>>    include/linux/arch_topology.h                 |  8 +--
>>>    include/linux/cpufreq.h                       | 10 ++++
>>>    include/linux/sched/topology.h                |  8 +--
>>>    .../{thermal_pressure.h => hw_pressure.h}     | 14 ++---
>>>    include/trace/events/sched.h                  |  2 +-
>>>    init/Kconfig                                  | 12 ++---
>>>    kernel/sched/core.c                           |  8 +--
>>>    kernel/sched/fair.c                           | 53 ++++++++++---------
>>>    kernel/sched/pelt.c                           | 18 +++----
>>>    kernel/sched/pelt.h                           | 16 +++---
>>>    kernel/sched/sched.h                          |  4 +-
>>>    17 files changed, 152 insertions(+), 94 deletions(-)
>>>    rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)
>>>
>>
>> I would like to test it, but something worries me. Why there is 0/5 in
>> this subject and only 4 patches?
> 
> I removed a patch from the series but copied/pasted the cover letter
> subject without noticing the /5 instead of /4

OK

> 
>>
>> Could you tell me your base branch that I can apply this, please?
> 
> It applies on top of tip/sched/core + [1]
> and you can find it here:
> https://git.linaro.org/people/vincent.guittot/kernel.git/log/?h=sched/system-pressure

Thanks for the info and handy link.

