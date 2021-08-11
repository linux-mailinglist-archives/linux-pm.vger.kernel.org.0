Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED293E8F8F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 13:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbhHKLih (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 07:38:37 -0400
Received: from foss.arm.com ([217.140.110.172]:47948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237371AbhHKLig (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Aug 2021 07:38:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8850106F;
        Wed, 11 Aug 2021 04:38:12 -0700 (PDT)
Received: from [10.57.12.152] (unknown [10.57.12.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 114053F70D;
        Wed, 11 Aug 2021 04:38:09 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Quentin Perret <qperret@google.com>, r@google.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
 <78bc08fe-71c2-398c-9a10-caa54b8bd866@arm.com> <YRKINFhDmYqvgxsN@google.com>
 <cf9d78fe-cff0-1992-2c15-7053e4431296@arm.com>
 <b888407c-d444-8184-cbb7-ce8e925b254b@arm.com> <YRKfluMP8G41/P61@google.com>
 <20210811050327.3yxrk4kqxjjwaztx@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <165735fc-1d03-42cb-b5eb-8a9c1d3c4387@arm.com>
Date:   Wed, 11 Aug 2021 12:38:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210811050327.3yxrk4kqxjjwaztx@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/11/21 6:03 AM, Viresh Kumar wrote:
> On 10-08-21, 16:47, Quentin Perret wrote:
>> On Tuesday 10 Aug 2021 at 16:12:29 (+0100), Lukasz Luba wrote:
>>> I've checked that. It's not the policy notifier and arch_topology which
>>> cause an issue, but the cpufreq governor setup code. Anyway, we cannot
>>> wait so late with the EM registration, till e.g. ::ready() callback.
>>
>> Aha, yes, because by the time the arch_topology driver rebuilds the
>> sched domains, the governor is not 'installed', which means the
>> scheduler is not in a position to enable EAS yet. So we need to wait
>> until sched_cpufreq_governor_change() is called for that. Makes sense,
>> thanks for checking, and +1 to your conclusion.
> 
> What about this then ?

If it doesn't break the current drivers which implement this callback,
then looks good.

> 
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Wed Aug 11 10:24:28 2021 +0530
> 
>      cpufreq: Call ->ready() before initializing governor
> 
>      The driver may want to do stuff from the ->ready() callback, like
>      registering with the EM core, after the policy is initialized, but
>      before the governor is setup (since governor may end up using that
>      information).
> 
>      Call the ->ready() callback before setting up the governor.
> 
>      Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a060dc2aa2f2..2df41b98bbb3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1494,6 +1494,10 @@ static int cpufreq_online(unsigned int cpu)
>                  write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>          }
> 
> +       /* Callback for handling stuff after policy is ready */
> +       if (cpufreq_driver->ready)
> +               cpufreq_driver->ready(policy);
> +
>          ret = cpufreq_init_policy(policy);
>          if (ret) {
>                  pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
> @@ -1505,10 +1509,6 @@ static int cpufreq_online(unsigned int cpu)
> 
>          kobject_uevent(&policy->kobj, KOBJ_ADD);
> 
> -       /* Callback for handling stuff after policy is ready */
> -       if (cpufreq_driver->ready)
> -               cpufreq_driver->ready(policy);
> -
>          if (cpufreq_thermal_control_enabled(cpufreq_driver))
>                  policy->cdev = of_cpufreq_cooling_register(policy);
> 
