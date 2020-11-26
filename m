Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5753D2C51C5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 11:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbgKZKG5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 05:06:57 -0500
Received: from foss.arm.com ([217.140.110.172]:53512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgKZKG5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 05:06:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F9B7D6E;
        Thu, 26 Nov 2020 02:06:56 -0800 (PST)
Received: from [10.57.29.239] (unknown [10.57.29.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89BC03F23F;
        Thu, 26 Nov 2020 02:06:54 -0800 (PST)
Subject: Re: [PATCH v3 4/4] powercap/drivers/dtpm: Add CPU energy model based
 support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, corbet@lwn.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilina@codeaurora.org, rkumbako@codeaurora.org, rui.zhang@intel.com,
        linux-arm-kernel@lists.infradead.org
References: <20201123214208.11007-1-daniel.lezcano@linaro.org>
 <20201123214208.11007-5-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <50db7265-3870-b977-6e41-b0a0ac3cdb94@arm.com>
Date:   Thu, 26 Nov 2020 10:06:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201123214208.11007-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 11/23/20 9:42 PM, Daniel Lezcano wrote:
> With the powercap dtpm controller, we are able to plug devices with
> power limitation features in the tree.
> 

[snip]

> +
> +static void pd_release(struct dtpm *dtpm)
> +{
> +	struct dtpm_cpu *dtpm_cpu = dtpm->private;
> +

Maybe it's worth to add:
------------------->8----------------
if (freq_qos_request_active(&dtpm_cpu->qos_req))
	freq_qos_remove_request(&dtpm_cpu->qos_req);
-------------------8<---------------

If we are trying to unregister dtpm in error path due to freq_qos
registration failure, a warning would be emitted from freq_qos.

> +	freq_qos_remove_request(&dtpm_cpu->qos_req);
> +	kfree(dtpm_cpu);
> +}

[snip]

> +
> +static int cpuhp_dtpm_cpu_online(unsigned int cpu)
> +{
> +	struct dtpm *dtpm;
> +	struct dtpm_cpu *dtpm_cpu;
> +	struct cpufreq_policy *policy;
> +	struct em_perf_domain *pd;
> +	char name[CPUFREQ_NAME_LEN];
> +	int ret;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +
> +	if (!policy)
> +		return 0;
> +
> +	pd = em_cpu_get(cpu);
> +	if (!pd)
> +		return -EINVAL;
> +
> +	dtpm = per_cpu(dtpm_per_cpu, cpu);
> +	if (dtpm)
> +		return power_add(dtpm, pd);
> +
> +	dtpm = dtpm_alloc(&dtpm_ops);
> +	if (!dtpm)
> +		return -EINVAL;
> +
> +	dtpm_cpu = kzalloc(sizeof(dtpm_cpu), GFP_KERNEL);
> +	if (!dtpm_cpu) {
> +		kfree(dtpm);
> +		return -ENOMEM;
> +	}
> +
> +	dtpm->private = dtpm_cpu;
> +	dtpm_cpu->cpu = cpu;
> +
> +	for_each_cpu(cpu, policy->related_cpus)
> +		per_cpu(dtpm_per_cpu, cpu) = dtpm;
> +
> +	sprintf(name, "cpu%d", dtpm_cpu->cpu);
> +
> +	ret = dtpm_register(name, dtpm, __parent);
> +	if (ret)
> +		goto out_kfree_dtpm_cpu;
> +
> +	ret = power_add(dtpm, pd);
> +	if (ret)
> +		goto out_power_sub;

Shouldn't we call dtpm_unregister() instead?
The dtpm_unregister() would remove the zone, which IIUC we
are currently missing.

> +
> +	ret = freq_qos_add_request(&policy->constraints,
> +				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
> +				   pd->table[pd->nr_perf_states - 1].frequency);
> +	if (ret)
> +		goto out_dtpm_unregister;

Could this trigger different steps, starting from out_power_sub_v2
below?

> +
> +	return 0;
> +
> +out_dtpm_unregister:
> +	dtpm_unregister(dtpm);
> +	dtpm_cpu = NULL; /* Already freed by the release ops */
> +out_power_sub:
> +	power_sub(dtpm, pd);

I would change the order of these two above into something like:

out_power_sub_v2:
	power_sub(dtpm, pd);
out_dtpm_unregister_v2:
	dtpm_unregister(dtpm);
	dtpm_cpu = NULL;

> +out_kfree_dtpm_cpu:
> +	for_each_cpu(cpu, policy->related_cpus)
> +		per_cpu(dtpm_per_cpu, cpu) = NULL;
> +	kfree(dtpm_cpu);
> +
> +	return ret;
> +}

IIUC power_sub() would decrement the power and set it to 0 for that
dtmp, then the dtpm_unregister() would also try to decrement the power,
but by the value of 0. So it should be safe.

Regards,
Lukasz

