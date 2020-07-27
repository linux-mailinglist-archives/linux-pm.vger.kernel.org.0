Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F2222F6F1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 19:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgG0RqB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 13:46:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbgG0RqB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 13:46:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 278AB30E;
        Mon, 27 Jul 2020 10:46:00 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16AF83F718;
        Mon, 27 Jul 2020 10:45:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] sched: Cleanup SCHED_THERMAL_PRESSURE kconfig
 entry
To:     Qian Cai <cai@lca.pw>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20200712165917.9168-1-valentin.schneider@arm.com>
 <20200712165917.9168-3-valentin.schneider@arm.com>
 <20200727141825.GA4174@lca.pw>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <16f8c1d4-778b-3ab8-f328-bae80f3973b4@arm.com>
Date:   Mon, 27 Jul 2020 19:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727141825.GA4174@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/07/2020 16:18, Qian Cai wrote:
> On Sun, Jul 12, 2020 at 05:59:16PM +0100, Valentin Schneider wrote:
>> As Russell pointed out [1], this option is severely lacking in the
>> documentation department, and figuring out if one has the required
>> dependencies to benefit from turning it on is not straightforward.
>>
>> Make it non user-visible, and add a bit of help to it. While at it, make it
>> depend on CPU_FREQ_THERMAL.
>>
>> [1]: https://lkml.kernel.org/r/20200603173150.GB1551@shell.armlinux.org.uk
>>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  init/Kconfig | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 0498af567f70..0a97d85568b2 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -492,8 +492,21 @@ config HAVE_SCHED_AVG_IRQ
>>  	depends on SMP
>>  
>>  config SCHED_THERMAL_PRESSURE
>> -	bool "Enable periodic averaging of thermal pressure"
>> +	bool
>>  	depends on SMP
>> +	depends on CPU_FREQ_THERMAL
>> +	help
>> +	  Select this option to enable thermal pressure accounting in the
>> +	  scheduler. Thermal pressure is the value conveyed to the scheduler
>> +	  that reflects the reduction in CPU compute capacity resulted from
>> +	  thermal throttling. Thermal throttling occurs when the performance of
>> +	  a CPU is capped due to high operating temperatures.
>> +
>> +	  If selected, the scheduler will be able to balance tasks accordingly,
>> +	  i.e. put less load on throttled CPUs than on non/less throttled ones.
>> +
>> +	  This requires the architecture to implement
>> +	  arch_set_thermal_pressure() and arch_get_thermal_pressure().
>>  
>>  config BSD_PROCESS_ACCT
>>  	bool "BSD Process Accounting"
>> -- 
> 
> On arm64 linux-next (20200727),
> 
> https://gitlab.com/cailca/linux-mm/-/blob/master/arm64.config
> 
> WARNING: unmet direct dependencies detected for SCHED_THERMAL_PRESSURE
>   Depends on [n]: SMP [=y] && CPU_FREQ_THERMAL [=n]
>   Selected by [y]:
>   - ARM64 [=y]

Not sure, but:

(1) do we wan to let people enable SCHED_THERMAL_PRESSURE for arm64 so
arm64 can potentially run w/o a CPU freq cooling device?

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2d4abbc9f8d0..baffe8b66da2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,7 +192,6 @@ config ARM64
        select PCI_SYSCALL if PCI
        select POWER_RESET
        select POWER_SUPPLY
-       select SCHED_THERMAL_PRESSURE
        select SPARSE_IRQ
        select SWIOTLB
        select SYSCTL_EXCEPTION_TRACE
diff --git a/init/Kconfig b/init/Kconfig
index 37b089f87804..8b36e07fb230 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -492,7 +492,7 @@ config HAVE_SCHED_AVG_IRQ
        depends on SMP

 config SCHED_THERMAL_PRESSURE
-       bool
+       bool "Thermal pressure accounting"
        depends on SMP
        depends on CPU_FREQ_THERMAL
        help

Or

(2) should SCHED_THERMAL_PRESSURE for arm64 be enabled by default?

But then it makes no sense to allow the removal of CONFIG_CPU_FREQ_THERMAL.

linux-next/master$ make ARCH=arm64 defconfig

// Remove CONFIG_CPU_FREQ_THERMAL
linux-next/master$ grep CPU_FREQ_THERMAL .config
# CONFIG_CPU_FREQ_THERMAL is not set

linux-next/master$ make
scripts/kconfig/conf  --syncconfig Kconfig

WARNING: unmet direct dependencies detected for SCHED_THERMAL_PRESSURE
  Depends on [n]: SMP [=y] && CPU_FREQ_THERMAL [=n]
  Selected by [y]:
  - ARM64 [=y]

WARNING: unmet direct dependencies detected for SCHED_THERMAL_PRESSURE
  Depends on [n]: SMP [=y] && CPU_FREQ_THERMAL [=n]
  Selected by [y]:
  - ARM64 [=y]

WARNING: unmet direct dependencies detected for SCHED_THERMAL_PRESSURE
  Depends on [n]: SMP [=y] && CPU_FREQ_THERMAL [=n]
  Selected by [y]:
  - ARM64 [=y]
  HOSTCC  scripts/dtc/dtc.o

---

There is a similar issue with arm.

I would prefer for (1).
