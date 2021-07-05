Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D0D3BBCFC
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhGEMrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jul 2021 08:47:47 -0400
Received: from foss.arm.com ([217.140.110.172]:45706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhGEMrr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Jul 2021 08:47:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A5641042;
        Mon,  5 Jul 2021 05:45:10 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D1063F73B;
        Mon,  5 Jul 2021 05:45:07 -0700 (PDT)
Subject: Re: [PATCH 2/3] PM: EM: Make em_cpu_energy() able to return bigger
 values
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     Chris.Redpath@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, segall@google.com,
        mgorman@suse.de, bristot@redhat.com, CCj.Yeh@mediatek.com
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-3-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <266f4b52-62c5-48bc-2680-1f09b6eb90cc@arm.com>
Date:   Mon, 5 Jul 2021 14:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625152603.25960-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/06/2021 17:26, Lukasz Luba wrote:
> The Energy Model (EM) em_cpu_energy() is responsible for providing good
> estimation regarding CPUs energy. It contains proper data structures which
> are then used during calculation. The values stored in there are in
> milli-Watts precision (or in abstract scale) smaller that 0xffff, which use

I guess you refer to 'if (... || power > EM_MAX_POWER)' check in
em_create_perf_table() [kernel/power/energy_model.c].

> sufficient unsigned long even on 32-bit machines. There are scenarios where
                                                              ^^^^^^^^^

Can you describe these scenarios better with one example (EAS placement
of an example task on a 2 PD system) which highlights the issue and how
it this patch-set solves it?

In this example you can list all the things which must be there to
create a situation in EAS in which the patch-set helps.

> we would like to provide calculated estimations in a better precision and
> the values might be 1000 times bigger. This patch makes possible to use

Where is this `1000` coming from?

> quite big values for also 32-bit machines.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 3f221dbf5f95..2016f5a706e0 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -101,7 +101,7 @@ void em_dev_unregister_perf_domain(struct device *dev);
>   * Return: the sum of the energy consumed by the CPUs of the domain assuming
>   * a capacity state satisfying the max utilization of the domain.
>   */
> -static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> +static inline u64 em_cpu_energy(struct em_perf_domain *pd,
>  				unsigned long max_util, unsigned long sum_util,
>  				unsigned long allowed_cpu_cap)
>  {
> @@ -180,7 +180,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	 *   pd_nrg = ------------------------                       (4)
>  	 *                  scale_cpu
>  	 */
> -	return ps->cost * sum_util / scale_cpu;
> +	return div_u64((u64)ps->cost * sum_util, scale_cpu);
>  }
>  
>  /**
> @@ -217,7 +217,7 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
>  {
>  	return NULL;
>  }
> -static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> +static inline u64 em_cpu_energy(struct em_perf_domain *pd,
>  			unsigned long max_util, unsigned long sum_util,
>  			unsigned long allowed_cpu_cap)
>  {
> 

