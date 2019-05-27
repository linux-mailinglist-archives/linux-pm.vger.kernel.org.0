Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9562B014
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 10:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfE0IXQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 04:23:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfE0IXQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 04:23:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5E53460A00; Mon, 27 May 2019 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558945394;
        bh=fAZ4peue9k6ed3jQSkZK9b3r/RruzJpm1saLRcNr50Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HOjTen8fmQzrMj/VyR227Hm75uLHTUFXastPLiN5t77bVXxZwax4l0D2M1Zhd0/vv
         KNbDP+MZZkluW/mjiL42WGsHWNocZkDJpKcosmf8NAS3Kz8o1rvMkNtjgAhw2B/9CV
         mfy4d1o0I3xqTf8XUKESp5cBju8Yff/dQ/Dt+qoY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 22AA760A00;
        Mon, 27 May 2019 08:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558945392;
        bh=fAZ4peue9k6ed3jQSkZK9b3r/RruzJpm1saLRcNr50Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WVMOkZeOqo8ZM8tBq9L7KmuPI6UWBglCjsMoXfbYJmkIrSXT2XybGirBp6anjXidp
         KjPfZ6jV1u9blL2ZY+VdoDv6nVgwLSfAAm4jPmClTXjV3ihoLXTVtqW44GQ2ttDhcC
         ubq/1O9yu/uQIBgUrQo7dn/eg6RTwHMq3Yw0qIE8=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 27 May 2019 13:53:12 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        dianders@chromium.org, Saravana Kannan <skannan@codeaurora.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH RFC 3/9] PM / devfreq: Add cpu based scaling support to
 passive_governor
In-Reply-To: <6e639c37-c231-f0b5-a280-9a69f2211ccc@samsung.com>
References: <20190328152822.532-1-sibis@codeaurora.org>
 <CGME20190328152906epcas1p15eb7c52740986df90a44ce265bef7d7c@epcas1p1.samsung.com>
 <20190328152822.532-4-sibis@codeaurora.org>
 <6e639c37-c231-f0b5-a280-9a69f2211ccc@samsung.com>
Message-ID: <3a2ad1bc744f85804c5f0dc9a74b69ff@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Chanwoo,

Thanks a lot for reviewing the patch. Like I
had indicated earlier we decided to go with
a simpler approach instead on qualcomm SoCs.
I am happy to re-spin this patch with your
comments addressed if we do find other users
for this feature.

On 2019-04-12 13:09, Chanwoo Choi wrote:
> Hi,
> 
> I agree this approach absolutely.
> Just I add some comments. Please check it.
> 
> On 19. 3. 29. 오전 12:28, Sibi Sankar wrote:
>> From: Saravana Kannan <skannan@codeaurora.org>
>> 
>> Many CPU architectures have caches that can scale independent of the
>> CPUs. Frequency scaling of the caches is necessary to make sure the 
>> cache
>> is not a performance bottleneck that leads to poor performance and
>> power. The same idea applies for RAM/DDR.
>> 
>> To achieve this, this patch add support for cpu based scaling to the
>> passive governor. This is accomplished by taking the current frequency
>> of each CPU frequency domain and then adjusts the frequency of the 
>> cache
>> (or any devfreq device) based on the frequency of the CPUs. It listens
>> to CPU frequency transition notifiers to keep itself up to date on the
>> current CPU frequency.
>> 
>> To decide the frequency of the device, the governor does one of the
>> following:
>> * Constructs a CPU frequency to device frequency mapping table from
>>   required-opps property of the devfreq device's opp_table
>> 
>> * Scales the device frequency in proportion to the CPU frequency. So, 
>> if
>>   the CPUs are running at their max frequency, the device runs at its
>>   max frequency. If the CPUs are running at their min frequency, the
>>   device runs at its min frequency. It is interpolated for frequencies
>>   in between.
>> 
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> [Sibi: Integrated cpu-freqmap governor into passive_governor]
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/devfreq/Kconfig            |   4 +
>>  drivers/devfreq/governor_passive.c | 276 
>> ++++++++++++++++++++++++++++-
>>  include/linux/devfreq.h            |  43 ++++-
>>  3 files changed, 315 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 6a172d338f6d..9a45f464a56b 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -72,6 +72,10 @@ config DEVFREQ_GOV_PASSIVE
>>  	  device. This governor does not change the frequency by itself
>>  	  through sysfs entries. The passive governor recommends that
>>  	  devfreq device uses the OPP table to get the frequency/voltage.
>> +	  Alternatively the governor can also be chosen to scale based on
>> +	  the online CPUs current frequency. A CPU frequency to device
>> +	  frequency mapping table(s) is auto-populated by the governor
>> +	  for this purpose.
>> 
>>  comment "DEVFREQ Drivers"
>> 
>> diff --git a/drivers/devfreq/governor_passive.c 
>> b/drivers/devfreq/governor_passive.c
>> index 3bc29acbd54e..2506682b233b 100644
>> --- a/drivers/devfreq/governor_passive.c
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -11,10 +11,63 @@
>>   */
>> 
>>  #include <linux/module.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/cpumask.h>
>>  #include <linux/device.h>
>>  #include <linux/devfreq.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>>  #include "governor.h"
>> 
>> +static unsigned int xlate_cpufreq_to_devfreq(struct 
>> devfreq_passive_data *data,
>> +					     unsigned int cpu)
>> +{
>> +	unsigned int cpu_min, cpu_max;
>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>> +	unsigned int dev_min, dev_max, cpu_percent, cpu_freq = 0, freq = 0;
>> +	unsigned long *freq_table = devfreq->profile->freq_table;
>> +	struct device *dev = devfreq->dev.parent;
>> +	struct devfreq_map *map;
>> +	int opp_cnt, i;
>> +
>> +	if (!data->state[cpu] || data->state[cpu]->first_cpu != cpu) {
>> +		freq = 0;
>> +		goto out;
> 
> goto out -> return 0;
> 
>> +	}
>> +
>> +	/* Use Interpolation if map is not available */
>> +	cpu_freq = data->state[cpu]->freq;
>> +	if (!data->map) {
>> +		cpu_min = data->state[cpu]->min_freq;
>> +		cpu_max = data->state[cpu]->max_freq;
>> +		if (freq_table) {
>> +			dev_min = freq_table[0];
>> +			dev_max = freq_table[devfreq->profile->max_state - 1];
> 
> Actually, it is not always true. The devfreq recommend the ascending 
> order for
> 'freq_table'. But, it is not mandatory. Also, some devfreq device uses 
> the
> decending order for 'freq_table'. So, a patch[1] was considering the 
> order
> when getting the minimum/maximum frequency from freq_table.
> 
> If you want to get the minimum/maximum frequency, you have to consider 
> the order
> of 'freq_table' as the patch[1].
> 
> [1] df5cf4a36178 ("PM / devfreq: Fix handling of min/max_freq == 0")
> 
>              /* Get minimum frequency according to sorting order */
> +               if (freq_table[0] < freq_table[df->profile->max_state - 
> 1])
> +                       value = freq_table[0];
> +               else
> +                       value = freq_table[df->profile->max_state - 1];
> 
> 
>> +		} else {
>> +			if (devfreq->max_freq <= devfreq->min_freq)
>> +				return 0;
>> +			dev_min = devfreq->min_freq;
>> +			dev_max = devfreq->max_freq;
>> +		}
>> +
>> +		cpu_percent = ((cpu_freq - cpu_min) * 100) / cpu_max - cpu_min;
>> +		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
>> +		goto out;
> 
> You don't need to jump 'out'. Instead, you better to use the 'else' 
> statement
> for if data->map is not NULL. I think that almost case when using this 
> patch
> will be available of data->map. In order to skip the likely 'false' 
> statement,
> I recommend the following sequence.
> 
> 	if (data->map) {
> 		map = data->map[cpu];
> 		...
> 	} else {
> 		/* Use Interpolation if map is not available */
> 	}
> 
> 
>> +	}
>> +
>> +	map = data->map[cpu];
>> +	opp_cnt = dev_pm_opp_get_opp_count(dev);
>> +	for (i = 0; i < opp_cnt; i++) {
>> +		freq = max(freq, map[i].dev_hz);
>> +		if (map[i].cpu_khz >= cpu_freq)
>> +			break;
>> +	}
>> +out:
>> +	dev_dbg(dev, "CPU%u: %d -> dev: %u\n", cpu, cpu_freq, freq);
> 
> IMO, I think it is not necessary. If you want to print log, you better 
> to print
> it on device driver instead of governor.
> 
>> +	return freq;
>> +}
>> +
>>  static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>  					unsigned long *freq)
>>  {
>> @@ -23,6 +76,7 @@ static int devfreq_passive_get_target_freq(struct 
>> devfreq *devfreq,
>>  	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>>  	unsigned long child_freq = ULONG_MAX;
>>  	struct dev_pm_opp *opp;
>> +	unsigned int cpu, tgt_freq = 0;
> 
> tgt means 'target'? If right, just use target_freq intead of 'tgt_freq'
> for the readability.
> 
>>  	int i, count, ret = 0;
>> 
>>  	/*
>> @@ -35,6 +89,14 @@ static int devfreq_passive_get_target_freq(struct 
>> devfreq *devfreq,
>>  		goto out;
>>  	}
>> 
>> +	if (p_data->cpufreq_type) {
>> +		for_each_possible_cpu(cpu)
>> +			tgt_freq = max(tgt_freq,
>> +				       xlate_cpufreq_to_devfreq(p_data, cpu));
>> +		*freq = tgt_freq;
> 
> You better to change from 'tgt_freq' to 'target_freq' for the 
> readability.
> 
>> +		goto out;
>> +	}
> 
> I think that 'goto out' using is not proper for supporting two case.
> Instead, you better to split out as following according to the type
> of parent device (devfreq device or cpufreq device).
> 
> 	switch (p_data->parent_type) {
> 	case DEVFREQ_PARENT_DEV:
> 		ret = get_target_freq_with_devfreq()
> 		break;
> 	case CPUFREQ_PARENT_DEV:
> 		ret = get_target_freq_with_cpufreq()
> 		break;
> 	default:
> 		dev_err(...)
> 		ret = -EINVAL;
> 		goto out;
> 	}
> 
> 	if (ret < 0) {
> 		/* exception handling for 'ret' value */
> 	}
> 
>> +
>>  	/*
>>  	 * If the parent and passive devfreq device uses the OPP table,
>>  	 * get the next frequency by using the OPP table.
>> @@ -149,6 +211,200 @@ static int devfreq_passive_notifier_call(struct 
>> notifier_block *nb,
>>  	return NOTIFY_DONE;
>>  }
>> 
>> +static int cpufreq_passive_notifier_call(struct notifier_block *nb,
>> +					 unsigned long event, void *ptr)
>> +{
>> +	struct devfreq_passive_data *data =
>> +			container_of(nb, struct devfreq_passive_data, nb);
>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>> +	struct cpufreq_freqs *freq = ptr;
>> +	struct devfreq_cpu_state *state;
> 
> nitpick. how about using 'cpu_state' instead of 'state'?
> in order to get the meaning from just variable name.
> 
>> +	int ret = 0;
>> +
>> +	if (event != CPUFREQ_POSTCHANGE)
>> +		goto out;
> 
> just 'return' is simple instead of 'goto out' because this case
> don't need to treat the any restoring code. And also, you have
> to check whether freq is NULL or not as following:
> 
> 	if (event != CPUFREQ_POSTCHANGE || !freq || data->state[freq->cpu])
> 		return ret;
> 	state = data->state[freq->cpu];
> 
>> +
>> +	state = data->state[freq->cpu];
>> +	if (!state)
>> +		goto out;
>> +
>> +	if (state->freq != freq->new) {
>> +		state->freq = freq->new;
> 
> You have to update the frequency after update_devfreq() is completed
> without error.
> 
>> +		mutex_lock(&devfreq->lock);
>> +		ret = update_devfreq(devfreq);
>> +		mutex_unlock(&devfreq->lock);
>> +		if (ret)
>> +			dev_err(&devfreq->dev, "Frequency update failed.\n");
> 
> Almost devfreq error used the following format: "Couldn't ..." .
> If there is no any specific reason to change the format for error log,
> 	"Couldnt update the frequency.\n"
> 
>> +	}> +out:
>> +	return ret;
> 
> Also, we can reduce the unneeded indentation as following:
> 
> 	if (state->freq == freq->new)
> 		return ret;
> 
> 	mutex_lock(&devfreq->lock);
> 	ret = update_devfreq(devfreq);
> 	mutex_unlock(&devfreq->lock);
> 	if (ret) {
> 		dev_err(&devfreq->dev, "Couldnt update the frequency.\n");
> 		return ret;
> 	}
> 	state->freq = freq->new;
> 
> 	return 0;
> 
>> +}
>> +
>> +static int cpufreq_passive_register(struct devfreq_passive_data 
>> **p_data)
>> +{
>> +	unsigned int cpu;
>> +	struct devfreq_map **cpu_map;
>> +	struct devfreq_map *map, *per_cpu_map;
>> +	struct devfreq_passive_data *data = *p_data;
>> +	struct devfreq *devfreq = (struct devfreq *)data->this;
>> +	int i, count = 0, opp_cnt = 0, ret = 0, iter_val = 0;
>> +	struct device_node *np, *opp_table_np, *cpu_np;
>> +	struct opp_table *opp_table, *cpu_opp_tbl;
>> +	struct device *dev = devfreq->dev.parent;
>> +	struct devfreq_cpu_state *state;
>> +	struct dev_pm_opp *opp, *cpu_opp;
>> +	struct cpufreq_policy *policy;
>> +	struct device *cpu_dev;
>> +	u64 cpu_khz, dev_hz;
>> +
>> +	get_online_cpus();
>> +	data->nb.notifier_call = cpufreq_passive_notifier_call;
>> +	ret = cpufreq_register_notifier(&data->nb,
>> +					CPUFREQ_TRANSITION_NOTIFIER);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Populate devfreq_cpu_state */
>> +	for_each_online_cpu(cpu) {
>> +		if (data->state[cpu])
>> +			continue;
>> +
>> +		policy = cpufreq_cpu_get(cpu);
>> +		if (policy) {
>> +			state = kzalloc(sizeof(*state), GFP_KERNEL);
>> +			if (!state)
>> +				return -ENOMEM;
>> +
>> +			state->first_cpu = cpumask_first(policy->related_cpus);
>> +			state->freq = policy->cur;
>> +			state->min_freq = policy->cpuinfo.min_freq;
>> +			state->max_freq = policy->cpuinfo.max_freq;
>> +			data->state[cpu] = state;
>> +			cpufreq_cpu_put(policy);
>> +		} else {
>> +			return -EPROBE_DEFER;
>> +		}
>> +	}
>> +
>> +	opp_table_np = dev_pm_opp_of_get_opp_desc_node(dev);
>> +	if (!opp_table_np)
>> +		goto out;
>> +
>> +	opp_cnt = dev_pm_opp_get_opp_count(dev);
>> +	if (opp_cnt <= 0)
>> +		goto put_opp_table;
>> +
>> +	/* Allocate memory for devfreq_map*/
>> +	cpu_map = kcalloc(num_possible_cpus(), sizeof(*cpu_map), 
>> GFP_KERNEL);
>> +	if (!cpu_map)
>> +		return -ENOMEM;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		per_cpu_map = kcalloc(opp_cnt, sizeof(*per_cpu_map),
>> +				      GFP_KERNEL);
>> +		if (!per_cpu_map)
>> +			return -ENOMEM;
>> +		cpu_map[cpu] = per_cpu_map;
>> +	}
>> +	data->map = cpu_map;
>> +
>> +	/* Populate devfreq_map */
>> +	opp_table = dev_pm_opp_get_opp_table(dev);
>> +	if (!opp_table)
>> +		return -ENOMEM;
>> +
>> +	for_each_available_child_of_node(opp_table_np, np) {
>> +		opp = dev_pm_opp_find_opp_of_np(opp_table, np);
>> +		if (IS_ERR(opp))
>> +			continue;
>> +
>> +		dev_hz = dev_pm_opp_get_freq(opp);
>> +		dev_pm_opp_put(opp);
>> +
>> +		count = of_count_phandle_with_args(np, "required-opps", NULL);
>> +		for (i = 0; i < count; i++) {
>> +			for_each_possible_cpu(cpu) {
>> +				cpu_dev = get_cpu_device(cpu);
>> +				if (!cpu_dev) {
>> +					dev_err(dev, "CPU get device failed.\n");
>> +					continue;
>> +				}
>> +
>> +				cpu_np = of_parse_required_opp(np, i);
>> +				if (!cpu_np) {
>> +					dev_err(dev, "Parsing required opp failed.\n");
>> +					continue;
>> +				}
>> +
>> +				/* Get cpu opp-table */
>> +				cpu_opp_tbl = dev_pm_opp_get_opp_table(cpu_dev);
>> +				if (!cpu_opp_tbl) {
>> +					dev_err(dev, "CPU opp table get failed.\n");
>> +					goto put_cpu_node;
>> +				}
>> +
>> +				/* Match the cpu opp node from required-opp with
>> +				 * the cpu-opp table */
>> +				cpu_opp = dev_pm_opp_find_opp_of_np(cpu_opp_tbl,
>> +								    cpu_np);
>> +				if (!cpu_opp) {
>> +					dev_dbg(dev, "CPU opp get failed.\n");
>> +					goto put_cpu_opp_table;
>> +				}
>> +
>> +				cpu_khz = dev_pm_opp_get_freq(cpu_opp);
>> +				if (cpu_opp && cpu_khz) {
>> +					/* Update freq-map if not already set */
>> +					map = cpu_map[cpu];
>> +					map[iter_val].cpu_khz = cpu_khz / 1000;
>> +					map[iter_val].dev_hz = dev_hz;
>> +				}
>> +				dev_pm_opp_put(cpu_opp);
>> +put_cpu_opp_table:
>> +				dev_pm_opp_put_opp_table(cpu_opp_tbl);
>> +put_cpu_node:
>> +				of_node_put(cpu_np);
>> +			}
>> +		}
>> +		iter_val++;
>> +	}
>> +	dev_pm_opp_put_opp_table(opp_table);
>> +put_opp_table:
>> +	of_node_put(opp_table_np);
>> +out:
>> +	put_online_cpus();
>> +
>> +	/* Update devfreq */
>> +	mutex_lock(&devfreq->lock);
>> +	ret = update_devfreq(devfreq);
>> +	mutex_unlock(&devfreq->lock);
>> +	if (ret)
>> +		dev_err(dev, "Frequency update failed.\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int cpufreq_passive_unregister(struct devfreq_passive_data 
>> **p_data)
>> +{
>> +	int cpu;
>> +	struct devfreq_passive_data *data = *p_data;
>> +
>> +	cpufreq_unregister_notifier(&data->nb,
>> +				    CPUFREQ_TRANSITION_NOTIFIER);
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		kfree(data->state[cpu]);
>> +		kfree(data->map[cpu]);
>> +		data->state[cpu] = NULL;
>> +		data->map[cpu] = NULL;
>> +	}
>> +
>> +	kfree(data->map);
>> +	data->map = NULL;
>> +
>> +	return 0;
>> +}
>> +
>>  static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>  				unsigned int event, void *data)
>>  {
>> @@ -159,7 +415,7 @@ static int devfreq_passive_event_handler(struct 
>> devfreq *devfreq,
>>  	struct notifier_block *nb = &p_data->nb;
>>  	int ret = 0;
>> 
>> -	if (!parent)
>> +	if (!parent && !p_data->cpufreq_type)
>>  		return -EPROBE_DEFER;
> 
> It makes the fault for the existing devfreq devices with passive 
> governor.
> Please remove '!p_data->cpufreq_type' condition.
> 
>> 
>>  	switch (event) {
>> @@ -167,13 +423,21 @@ static int devfreq_passive_event_handler(struct 
>> devfreq *devfreq,
>>  		if (!p_data->this)
>>  			p_data->this = devfreq;
>> 
>> -		nb->notifier_call = devfreq_passive_notifier_call;
>> -		ret = devm_devfreq_register_notifier(dev, parent, nb,
>> -					DEVFREQ_TRANSITION_NOTIFIER);
>> +		if (p_data->cpufreq_type) {
>> +			ret = cpufreq_passive_register(&p_data);
>> +		} else {
>> +			nb->notifier_call = devfreq_passive_notifier_call;
>> +			ret = devm_devfreq_register_notifier(dev, parent, nb,
>> +						DEVFREQ_TRANSITION_NOTIFIER);
>> +		}
> 
> I suggested the my opinion aboyt 'cpufreq_type' variable below.
> You can separte it for more clready with using parent device type.
> 
> 		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
> 			...
> 		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
> 			...
> 		else
> 			// error handling
> 
>>  		break;
>>  	case DEVFREQ_GOV_STOP:
>> -		devm_devfreq_unregister_notifier(dev, parent, nb,
>> -					DEVFREQ_TRANSITION_NOTIFIER);
>> +		if (p_data->cpufreq_type) {
>> +			cpufreq_passive_unregister(&p_data);
>> +		} else {
>> +			devm_devfreq_unregister_notifier(dev, parent, nb,
>> +						DEVFREQ_TRANSITION_NOTIFIER);
>> +		}
> 
> ditto.
> 
>>  		break;
>>  	default:
>>  		break;
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index fbffa74bfc1b..e8235fbe49e6 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -265,6 +265,38 @@ struct devfreq_simple_ondemand_data {
>>  #endif
>> 
>>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>> +/**
>> + * struct devfreq_cpu_state - holds the per-cpu state
>> + * @freq:	holds the current frequency of the cpu.
>> + * @min_freq:	holds the min frequency of the cpu.
>> + * @max_freq:	holds the max frequency of the cpu.
>> + * @first_cpu:	holds the cpumask of the first cpu of a policy.
>> + *
>> + * This structure stores the required cpu_state of a cpu.
>> + * This is auto-populated by the governor.
>> + */
>> +struct devfreq_cpu_state {
>> +	unsigned int freq;
>> +	unsigned int min_freq;
>> +	unsigned int max_freq;
>> +	unsigned int first_cpu;
>> +};
>> +
>> +/**
>> + * struct devfreq_map - holds mapping from cpu frequency
>> + * to devfreq frequency
>> + * @cpu_khz:	holds the cpu frequency in Khz
>> + * @dev_hz:	holds the devfreq device frequency in Hz
>> + *
>> + * This structure stores the lookup table between cpu
>> + * and the devfreq device. This is auto-populated by the
>> + * governor.
>> + */
>> +struct devfreq_map {
> 
> How about changing the structure name as following or others?
> - devfreq_freq_map or devfreq_cpufreq_map or others.
> 
> Because this structure name guessing the meaning of mapping
> between devfreq frequency and cpufreq frequency.
> 
>> +	unsigned int cpu_khz;
>> +	unsigned int dev_hz;
>> +};
>> +
>>  /**
>>   * struct devfreq_passive_data - void *data fed to struct devfreq
>>   *	and devfreq_add_device
>> @@ -278,11 +310,13 @@ struct devfreq_simple_ondemand_data {
>>   *			the next frequency, should use this callback.
>>   * @this:	the devfreq instance of own device.
>>   * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
>> + * @state:	holds the state min/max/current frequency of all online 
>> cpu's
> 
> As I commented above, how about using 'cpu_state' instead of 'state'?
> in order to get the meaning from just variable name.
> 
> nitpick. Also,  I think that you can skip 'holds' from the description
> of 'state' variable.
> 
> 
>> + * @map:	holds the maps between cpu frequency and device frequency
> 
> How about using 'cpufreq_map' instead of 'map' for the readability?
> IMHO, Because this variable is only used when parent device is cpu.
> I think that if you add to specify the meaningful prefix about cpu to
> variable name,
> it is easy to catch the meaning of variable.
> - map -> cpufreq_map.
> 
> nitpick. Also,  I think that you can skip 'holds' from the description
> of 'map' variable.
> 
>>   *
>>   * The devfreq_passive_data have to set the devfreq instance of 
>> parent
>>   * device with governors except for the passive governor. But, don't 
>> need to
>> - * initialize the 'this' and 'nb' field because the devfreq core will 
>> handle
>> - * them.
>> + * initialize the 'this', 'nb', 'state' and 'map' field because the 
>> devfreq
> 
> If you agree my opinion above,
> - state -> cpu_state.
> - map -> cpufreq_map
> 
>> + * core will handle them.
>>   */
>>  struct devfreq_passive_data {
>>  	/* Should set the devfreq instance of parent device */
>> @@ -291,9 +325,14 @@ struct devfreq_passive_data {
>>  	/* Optional callback to decide the next frequency of passvice device 
>> */
>>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>> 
>> +	/* Should be set if the devfreq device wants to be scaled with cpu*/
>> +	u8 cpufreq_type;
> 
> The devfreq devices with passive governor have always parent
> either devfreq device or cpufreq device. So, you better to specify
> the parent type as following: I think that it is more clear to check
> the type of parent device.
> 
> 	enum devfreq_parent_dev_type {
> 		DEVFREQ_PARENT_DEV,
> 		CPUFREQ_PARENT_DEV,
> 	};
> 
> 	enum devfreq_parent_dev_type parent_type;
> 
>> +
>>  	/* For passive governor's internal use. Don't need to set them */
>>  	struct devfreq *this;
>>  	struct notifier_block nb;
>> +	struct devfreq_cpu_state *state[NR_CPUS];
>> +	struct devfreq_map **map;
> 
> ditto.
> 
>>  };
>>  #endif
>> 
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
