Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A17F3BBD0C
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhGEMs1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jul 2021 08:48:27 -0400
Received: from foss.arm.com ([217.140.110.172]:45768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhGEMs1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Jul 2021 08:48:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8642E1042;
        Mon,  5 Jul 2021 05:45:50 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F10B93F73B;
        Mon,  5 Jul 2021 05:45:47 -0700 (PDT)
Subject: Re: [PATCH 3/3] PM: EM: Increase energy calculation precision
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     Chris.Redpath@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, segall@google.com,
        mgorman@suse.de, bristot@redhat.com, CCj.Yeh@mediatek.com
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-4-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <be567416-e7ac-e672-ddfe-f9175ba1c016@arm.com>
Date:   Mon, 5 Jul 2021 14:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625152603.25960-4-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/06/2021 17:26, Lukasz Luba wrote:
> The Energy Model (EM) provides useful information about device power in
> each performance state to other subsystems like: Energy Aware Scheduler
> (EAS). The energy calculation in EAS does arithmetic operation based on
> the EM em_cpu_energy(). Current implementation of that function uses
> em_perf_state::cost as a pre-computed cost coefficient equal to:
> cost = power * max_frequency / frequency.
> The 'power' is expressed in milli-Watts (or in abstract scale).
> 
> There are corner cases then the EAS energy calculation for two Performance
            ^^^^^^^^^^^^

Again, an easy to understand example to describe in which situation this
change would bring a benefit would help.

> Domains (PDs) return the same value, e.g. 10mW. The EAS compares these
> values to choose smaller one. It might happen that this values are equal
> due to rounding error. In such scenario, we need better precision, e.g.
> 10000 times better. To provide this possibility increase the precision on
> the em_perf_state::cost.
> 
> This patch allows to avoid the rounding to milli-Watt errors, which might
> occur in EAS energy estimation for each Performance Domains (PD). The
> rounding error is common for small tasks which have small utilization
> values.

What's the influence of the CPU utilization 'cpu_util_next()' here?

compute_energy()
    em_cpu_energy()
            return ps->cost * sum_util / scale_cpu
                              ^^^^^^^^
> The rest of the EM code doesn't change, em_perf_state::power is still
> expressed in milli-Watts (or in abstract scale). Thus, all existing
> platforms don't have to change their reported power. The same applies to

Not only existing platforms since there are no changes. So why
highlighting `existing` here.?

> EM clients, like thermal or DTPM (they use em_perf_state::power).
> 
> Reported-by: CCJ Yeh <CCj.Yeh@mediatek.com>
> Suggested-by: CCJ Yeh <CCj.Yeh@mediatek.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 5 ++++-
>  kernel/power/energy_model.c  | 3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 2016f5a706e0..91037dd57e61 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -16,7 +16,10 @@
>   * @power:	The power consumed at this level (by 1 CPU or by a registered
>   *		device). It can be a total power: static and dynamic.
>   * @cost:	The cost coefficient associated with this level, used during
> - *		energy calculation. Equal to: power * max_frequency / frequency
> + *		energy calculation. Equal to:
> +		power * 10000 * max_frequency / frequency
> + *		To increase the energy estimation presision use different
> + *		scale in this coefficient than in @power field.
>   */
>  struct em_perf_state {
>  	unsigned long frequency;
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 0f4530b3a8cd..2724f0ac417d 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -170,7 +170,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  	/* Compute the cost of each performance state. */
>  	fmax = (u64) table[nr_states - 1].frequency;
>  	for (i = 0; i < nr_states; i++) {
> -		table[i].cost = div64_u64(fmax * table[i].power,
> +		u64 power_res = (u64)table[i].power * 10000;
> +		table[i].cost = div64_u64(fmax * power_res,
>  					  table[i].frequency);
>  	}
>  
> 

