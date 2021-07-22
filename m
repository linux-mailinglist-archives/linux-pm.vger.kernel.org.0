Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A659A3D1EFA
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 09:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhGVGpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 02:45:06 -0400
Received: from foss.arm.com ([217.140.110.172]:46018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhGVGpG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Jul 2021 02:45:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D27D6E;
        Thu, 22 Jul 2021 00:25:41 -0700 (PDT)
Received: from [10.57.9.248] (unknown [10.57.9.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4493F66F;
        Thu, 22 Jul 2021 00:25:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/9] PM / EM: Mark inefficient states
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com, mka@chromium.org
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <1625738946-295849-3-git-send-email-vincent.donnefort@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7bdc7082-cdfb-710f-ce28-0dc179efcd35@arm.com>
Date:   Thu, 22 Jul 2021 08:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1625738946-295849-3-git-send-email-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/8/21 11:08 AM, Vincent Donnefort wrote:
> Some SoCs, such as the sd855 have OPPs within the same performance domain,
> whose cost is higher than others with a higher frequency. Even though
> those OPPs are interesting from a cooling perspective, it makes no sense
> to use them when the device can run at full capacity. Those OPPs handicap
> the performance domain, when choosing the most energy-efficient CPU and
> are wasting energy. They are inefficient.
> 
> Hence, add support for such OPPs to the Energy Model. The table can now
> be read skipping inefficient performance states (and by extension,
> inefficient OPPs).
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 3f221dbf5f95..7ca4f9cc8baf 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -17,13 +17,25 @@
>    *		device). It can be a total power: static and dynamic.
>    * @cost:	The cost coefficient associated with this level, used during
>    *		energy calculation. Equal to: power * max_frequency / frequency
> + * @flags:	see "em_perf_state flags" description below.
>    */
>   struct em_perf_state {
>   	unsigned long frequency;
>   	unsigned long power;
>   	unsigned long cost;
> +	unsigned long flags;
>   };
>   
> +/*
> + * em_perf_state flags:
> + *
> + * EM_PERF_STATE_INEFFICIENT: The performance state is inefficient. There is
> + * in this em_perf_domain, another performance state with a higher frequency
> + * but a lower or equal power cost. Such inefficient states are ignored when
> + * using em_pd_get_efficient_*() functions.
> + */
> +#define EM_PERF_STATE_INEFFICIENT BIT(0)
> +
>   /**
>    * em_perf_domain - Performance domain
>    * @table:		List of performance states, in ascending order
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index c4871a8ff977..30ab73ab6439 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -2,7 +2,7 @@
>   /*
>    * Energy Model of devices
>    *
> - * Copyright (c) 2018-2020, Arm ltd.
> + * Copyright (c) 2018-2021, Arm ltd.
>    * Written by: Quentin Perret, Arm ltd.
>    * Improvements provided by: Lukasz Luba, Arm ltd.
>    */
> @@ -42,6 +42,7 @@ static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
>   	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
>   	debugfs_create_ulong("power", 0444, d, &ps->power);
>   	debugfs_create_ulong("cost", 0444, d, &ps->cost);
> +	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
>   }
>   
>   static int em_debug_cpus_show(struct seq_file *s, void *unused)
> @@ -160,6 +161,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>   		table[i].cost = div64_u64(fmax * table[i].power,
>   					  table[i].frequency);
>   		if (table[i].cost >= prev_cost) {
> +			table[i].flags = EM_PERF_STATE_INEFFICIENT;
>   			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
>   				table[i].frequency);
>   		} else {
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
