Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A1A233061
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 12:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG3KaF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 06:30:05 -0400
Received: from foss.arm.com ([217.140.110.172]:37800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3KaE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 06:30:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 578A130E;
        Thu, 30 Jul 2020 03:30:03 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14CB3F66E;
        Thu, 30 Jul 2020 03:29:55 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] arch_topology: disable frequency invariance for
 CONFIG_BL_SWITCHER
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, sudeep.holla@arm.com,
        will@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
        peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-4-ionela.voinescu@arm.com>
 <20200730042423.4j22udejluis7blw@vireshk-mac-ubuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1db4317a-0018-1590-f0ae-ed5e235b174f@arm.com>
Date:   Thu, 30 Jul 2020 12:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730042423.4j22udejluis7blw@vireshk-mac-ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/07/2020 06:24, Viresh Kumar wrote:
> On 22-07-20, 10:37, Ionela Voinescu wrote:
>> +++ b/drivers/base/arch_topology.c
>> @@ -27,6 +27,7 @@ __weak bool arch_freq_counters_available(struct cpumask *cpus)
>>  }
>>  DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>>  
>> +#ifndef CONFIG_BL_SWITCHER
>>  void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>>  			 unsigned long max_freq)
>>  {
>> @@ -46,6 +47,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>>  	for_each_cpu(i, cpus)
>>  		per_cpu(freq_scale, i) = scale;
>>  }
>> +#endif
> 
> I don't really like this change, the ifdef hackery is disgusting and
> then we are putting that in a completely different part of the kernel.
> 
> There are at least these two ways of solving this, maybe more:
> 
> - Fix the bl switcher driver and add the complexity in it (which you
>   tried to do earlier).
> 
> - Add a cpufreq flag to skip arch-set-freq-scale call.

I agree it's not nice but IMHO the cpufreq flag is worse since we would
introduce new infrastructure only for a deprecated feature. I'm assuming
that BL SWITCHER is the only feature needing this CPUfreq flag extension.

#ifdef CONFIG_BL_SWITCHER is already in drivers/irqchip/irq-gic.c so
it's ugly already.

Runtime detecting (via bL_switching_enabled) of BL SWITCHER is right now
also only handled inside vexpress-spc-cpufreq.c via a
bL_switcher_notifier. A mechanism which also sits behind a #ifdef
CONFIG_BL_SWITCHER.


So IMHO, the additional #ifdef CONFIG_BL_SWITCHER in
drivers/base/arch_topology.c it's a small price to pay.

Are there still any users of CONFIG_BL_SWITCHER? I guess it's only
limited to A15/A7 systems w/ vexpress-spc-cpufreq.c ... so probably only
TC2?
