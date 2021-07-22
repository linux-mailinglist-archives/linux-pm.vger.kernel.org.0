Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C113D1F00
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 09:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhGVGrG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 02:47:06 -0400
Received: from foss.arm.com ([217.140.110.172]:46086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhGVGrG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Jul 2021 02:47:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E20DD6E;
        Thu, 22 Jul 2021 00:27:41 -0700 (PDT)
Received: from [10.57.9.248] (unknown [10.57.9.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D95873F66F;
        Thu, 22 Jul 2021 00:27:39 -0700 (PDT)
Subject: Re: [PATCH v4 3/9] PM / EM: Extend em_perf_domain with a flag field
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com, mka@chromium.org
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <1625738946-295849-4-git-send-email-vincent.donnefort@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <acddc3ca-09f5-d3cb-7938-6008a3d52805@arm.com>
Date:   Thu, 22 Jul 2021 08:27:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1625738946-295849-4-git-send-email-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/8/21 11:09 AM, Vincent Donnefort wrote:
> Merge the current "milliwatts" option into a "flag" field. This intends to
> prepare the extension of this structure for inefficient states support in
> the Energy Model.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 7ca4f9cc8baf..1deb727245be 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -40,8 +40,7 @@ struct em_perf_state {
>    * em_perf_domain - Performance domain
>    * @table:		List of performance states, in ascending order
>    * @nr_perf_states:	Number of performance states
> - * @milliwatts:		Flag indicating the power values are in milli-Watts
> - *			or some other scale.
> + * @flags:		See "em_perf_domain flags"
>    * @cpus:		Cpumask covering the CPUs of the domain. It's here
>    *			for performance reasons to avoid potential cache
>    *			misses during energy calculations in the scheduler
> @@ -56,10 +55,18 @@ struct em_perf_state {
>   struct em_perf_domain {
>   	struct em_perf_state *table;
>   	int nr_perf_states;
> -	int milliwatts;
> +	unsigned long flags;
>   	unsigned long cpus[];
>   };
>   
> +/*
> + *  em_perf_domain flags:
> + *
> + *  EM_PERF_DOMAIN_MILLIWATTS: The power values are in milli-Watts or some
> + *  other scale.
> + */
> +#define EM_PERF_DOMAIN_MILLIWATTS BIT(0)
> +
>   #define em_span_cpus(em) (to_cpumask((em)->cpus))
>   
>   #ifdef CONFIG_ENERGY_MODEL
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 30ab73ab6439..3ab0b913bcfa 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -56,7 +56,8 @@ DEFINE_SHOW_ATTRIBUTE(em_debug_cpus);
>   static int em_debug_units_show(struct seq_file *s, void *unused)
>   {
>   	struct em_perf_domain *pd = s->private;
> -	char *units = pd->milliwatts ? "milliWatts" : "bogoWatts";
> +	char *units = (pd->flags & EM_PERF_DOMAIN_MILLIWATTS) ?
> +		"milliWatts" : "bogoWatts";
>   
>   	seq_printf(s, "%s\n", units);
>   
> @@ -343,7 +344,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>   	if (ret)
>   		goto unlock;
>   
> -	dev->em_pd->milliwatts = milliwatts;
> +	if (milliwatts)
> +		dev->em_pd->flags |= EM_PERF_DOMAIN_MILLIWATTS;
>   
>   	em_debug_create_pd(dev);
>   	dev_info(dev, "EM: created perf domain\n");
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
