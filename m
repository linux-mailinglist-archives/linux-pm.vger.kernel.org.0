Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF400296142
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368291AbgJVO6U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 10:58:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34021 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505412AbgJVO6T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 10:58:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kVc2g-00069c-VM; Thu, 22 Oct 2020 14:58:15 +0000
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
To:     Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher>
 <20201022122949.GW2628@hirez.programming.kicks-ass.net>
 <20201022145250.GK32041@suse.de>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <6606e5f4-3f66-5844-da02-5b11e1464be6@canonical.com>
Date:   Thu, 22 Oct 2020 15:58:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201022145250.GK32041@suse.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/10/2020 15:52, Mel Gorman wrote:
> On Thu, Oct 22, 2020 at 02:29:49PM +0200, Peter Zijlstra wrote:
>> On Thu, Oct 22, 2020 at 02:19:29PM +0200, Rafael J. Wysocki wrote:
>>>> However I do want to retire ondemand, conservative and also very much
>>>> intel_pstate/active mode.
>>>
>>> I agree in general, but IMO it would not be prudent to do that without making
>>> schedutil provide the same level of performance in all of the relevant use
>>> cases.
>>
>> Agreed; I though to have understood we were there already.
> 
> AFAIK, not quite (added Giovanni as he has been paying more attention).
> Schedutil has improved since it was merged but not to the extent where
> it is a drop-in replacement. The standard it needs to meet is that
> it is at least equivalent to powersave (in intel_pstate language)
> or ondemand (acpi_cpufreq) and within a reasonable percentage of the
> performance governor. Defaulting to performance is a) giving up and b)
> the performance governor is not a universal win. There are some questions
> currently on whether schedutil is good enough when HWP is not available.
> There was some evidence (I don't have the data, Giovanni was looking into
> it) that HWP was a requirement to make schedutil work well. That is a
> hazard in itself because someone could test on the latest gen Intel CPU
> and conclude everything is fine and miss that Intel-specific technology
> is needed to make it work well while throwing everyone else under a bus.
> Giovanni knows a lot more than I do about this, I could be wrong or
> forgetting things.
> 
> For distros, switching to schedutil by default would be nice because
> frequency selection state would follow the task instead of being per-cpu
> and we could stop worrying about different HWP implementations but it's
> not at the point where the switch is advisable. I would expect hard data
> before switching the default and still would strongly advise having a
> period of time where we can fall back when someone inevitably finds a
> new corner case or exception.

..and it would be really useful for distros to know when the hard data
is available so that they can make an informed decision when to move to
schedutil.

> 
> For reference, SLUB had the same problem for years. It was switched
> on by default in the kernel config but it was a long time before
> SLUB was generally equivalent to SLAB in terms of performance. Block
> multiqueue also had vaguely similar issues before the default changes
> and a period of time before it was removed removed (example whinging mail
> https://lore.kernel.org/lkml/20170803085115.r2jfz2lofy5spfdb@techsingularity.net/)
> It's schedutil's turn :P
> 

