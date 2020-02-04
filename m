Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9E15151F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 05:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBDEwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 23:52:55 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:48563 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727150AbgBDEwy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 23:52:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580791973; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=1LmCc49vRYr+8Xq3wixV2EuAx8jm92puf1kCH70zbkc=; b=QgsHM4U7MA3AiIVgWewM8OMjsli3AT8azyvmpui7pxj4h/pqHS1zkDUT1u6+dak+R/Iu60uq
 c/1PmcyUG1XX2An6dBQMWFDYzZZ+XGA/ICTjnyXxn4jrRFY7gKrdZrh8HXaYD1g1M+hdqZ31
 0q2or6vt5RVWQgU8Eddd3UuCqrM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e38f8a4.7ff89e740960-smtp-out-n03;
 Tue, 04 Feb 2020 04:52:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E54DBC447A1; Tue,  4 Feb 2020 04:52:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E172C433CB;
        Tue,  4 Feb 2020 04:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E172C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
 <1580736940-6985-6-git-send-email-mkshah@codeaurora.org>
 <20200203170832.GA38466@bogus>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
Date:   Tue, 4 Feb 2020 10:22:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203170832.GA38466@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 2/3/2020 10:38 PM, Sudeep Holla wrote:
> On Mon, Feb 03, 2020 at 07:05:38PM +0530, Maulik Shah wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> If the hierarchical CPU topology is used, but the OS initiated mode isn't
>> supported, we need to rely solely on the regular cpuidle framework to
>> manage the idle state selection, rather than using genpd and its
>> governor.
>>
>> For this reason, introduce a new PSCI DT helper function,
>> psci_dt_pm_domains_parse_states(), which parses and converts the
>> hierarchically described domain idle states from DT, into regular flattened
>> cpuidle states. The converted states are added to the existing cpuidle
>> driver's array of idle states, which make them available for cpuidle.
>>
> And what's the main motivation for this if OSI is not supported in the
> firmware ?

Hi Sudeep,

Main motivation is to do last-man activities before the CPU cluster can 
enter a deep idle state.

>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> [applied to new path, resolved conflicts]
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> ---
>>   drivers/cpuidle/cpuidle-psci-domain.c | 137 +++++++++++++++++++++++++++++-----
>>   drivers/cpuidle/cpuidle-psci.c        |  41 +++++-----
>>   drivers/cpuidle/cpuidle-psci.h        |  11 +++
>>   3 files changed, 153 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
>> index 423f03b..3c417f7 100644
>> --- a/drivers/cpuidle/cpuidle-psci-domain.c
>> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
>> @@ -26,13 +26,17 @@ struct psci_pd_provider {
>>   };
>>
>>   static LIST_HEAD(psci_pd_providers);
>> -static bool osi_mode_enabled __initdata;
>> +static bool osi_mode_enabled;
>>
>>   static int psci_pd_power_off(struct generic_pm_domain *pd)
>>   {
>>   	struct genpd_power_state *state = &pd->states[pd->state_idx];
>>   	u32 *pd_state;
>>
>> +	/* If we have failed to enable OSI mode, then abort power off. */
>> +	if ((psci_has_osi_support()) && !osi_mode_enabled)
>> +		return -EBUSY;
>> +
> Why is this needed ? IIUC we don't create genpd domains if OSI is not
> enabled.

we do create genpd domains, for cpu domains, we just abort power off 
here since idle states are converted into regular flattened mode.

however genpd poweroff will be used by parent domain (rsc in this case) 
which is kept in hireachy in DTSI with cluster domain to do last man 
activities.

>>   	if (!state->data)
>>   		return 0;
>>
>> @@ -101,6 +105,105 @@ static void psci_pd_free_states(struct genpd_power_state *states,
>>   	kfree(states);
>>   }
>>
>> +static void psci_pd_convert_states(struct cpuidle_state *idle_state,
>> +			u32 *psci_state, struct genpd_power_state *state)
>> +{
>> +	u32 *state_data = state->data;
>> +	u64 target_residency_us = state->residency_ns;
>> +	u64 exit_latency_us = state->power_on_latency_ns +
>> +			state->power_off_latency_ns;
>> +
>> +	*psci_state = *state_data;
>> +	do_div(target_residency_us, 1000);
>> +	idle_state->target_residency = target_residency_us;
>> +	do_div(exit_latency_us, 1000);
>> +	idle_state->exit_latency = exit_latency_us;
>> +	idle_state->enter = &psci_enter_domain_idle_state;
>> +	idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
>> +
>> +	strncpy(idle_state->name, to_of_node(state->fwnode)->name,
>> +		CPUIDLE_NAME_LEN - 1);
>> +	strncpy(idle_state->desc, to_of_node(state->fwnode)->name,
>> +		CPUIDLE_NAME_LEN - 1);
>> +}
>> +
>> +static bool psci_pd_is_provider(struct device_node *np)
>> +{
>> +	struct psci_pd_provider *pd_prov, *it;
>> +
>> +	list_for_each_entry_safe(pd_prov, it, &psci_pd_providers, link) {
>> +		if (pd_prov->node == np)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +int __init psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
>> +			struct device_node *cpu_node, u32 *psci_states)
>> +{
>> +	struct genpd_power_state *pd_states;
>> +	struct of_phandle_args args;
>> +	int ret, pd_state_count, i, state_idx, psci_idx;
>> +	u32 cpu_psci_state = psci_states[drv->state_count - 1];
>> +	struct device_node *np = of_node_get(cpu_node);
>> +
>> +	/* Walk the CPU topology to find compatible domain idle states. */
>> +	while (np) {
>> +		ret = of_parse_phandle_with_args(np, "power-domains",
>> +					"#power-domain-cells", 0, &args);
>> +		of_node_put(np);
>> +		if (ret)
>> +			return 0;
>> +
>> +		np = args.np;
>> +
>> +		/* Verify that the node represents a psci pd provider. */
>> +		if (!psci_pd_is_provider(np)) {
>> +			of_node_put(np);
>> +			return 0;
>> +		}
>> +
>> +		/* Parse for compatible domain idle states. */
>> +		ret = psci_pd_parse_states(np, &pd_states, &pd_state_count);
>> +		if (ret) {
>> +			of_node_put(np);
>> +			return ret;
>> +		}
>> +
>> +		i = 0;
>> +		while (i < pd_state_count) {
>> +
>> +			state_idx = drv->state_count;
>> +			if (state_idx >= CPUIDLE_STATE_MAX) {
>> +				pr_warn("exceeding max cpuidle states\n");
>> +				of_node_put(np);
>> +				return 0;
>> +			}
>> +
>> +			psci_idx = state_idx + i;
>> +			psci_pd_convert_states(&drv->states[state_idx + i],
>> +					&psci_states[psci_idx], &pd_states[i]);
>> +
>> +			/*
>> +			 * In the hierarchical CPU topology the master PM domain
>> +			 * idle state's DT property, "arm,psci-suspend-param",
>> +			 * don't contain the bits for the idle state of the CPU,
>> +			 * let's add those here.
>> +			 */
>> +			psci_states[psci_idx] |= cpu_psci_state;
> No we can't do that. Refer previous discussions around that.

Thanks for pointing this.

i will remove this in next version, we already have cpu idle state bits 
present in cluster modes.

>
>> +			pr_debug("psci-power-state %#x index %d\n",
>> +				psci_states[psci_idx], psci_idx);
>> +
>> +			drv->state_count++;
>> +			i++;
>> +		}
>> +		psci_pd_free_states(pd_states, pd_state_count);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int __init psci_pd_init(struct device_node *np)
>>   {
>>   	struct generic_pm_domain *pd;
>> @@ -125,11 +228,14 @@ static int __init psci_pd_init(struct device_node *np)
>>   	 * Parse the domain idle states and let genpd manage the state selection
>>   	 * for those being compatible with "domain-idle-state".
>>   	 */
>> -	ret = psci_pd_parse_states(np, &states, &state_count);
>> -	if (ret)
>> -		goto free_name;
>>
>> -	pd->free_states = psci_pd_free_states;
>> +	if (psci_has_osi_support()) {
>> +		ret = psci_pd_parse_states(np, &states, &state_count);
>> +		if (ret)
>> +			goto free_name;
>> +		pd->free_states = psci_pd_free_states;
>> +	}
>> +
>>   	pd->name = kbasename(pd->name);
>>   	pd->power_off = psci_pd_power_off;
>>   	pd->states = states;
>> @@ -236,10 +342,6 @@ static int __init psci_idle_init_domains(void)
>>   	if (!np)
>>   		return -ENODEV;
>>
>> -	/* Currently limit the hierarchical topology to be used in OSI mode. */
>> -	if (!psci_has_osi_support())
>> -		goto out;
>> -
>>   	/*
>>   	 * Parse child nodes for the "#power-domain-cells" property and
>>   	 * initialize a genpd/genpd-of-provider pair when it's found.
>> @@ -265,14 +367,16 @@ static int __init psci_idle_init_domains(void)
>>   		goto remove_pd;
>>
>>   	/* Try to enable OSI mode. */
>> -	ret = psci_set_osi_mode();
>> -	if (ret) {
>> -		pr_warn("failed to enable OSI mode: %d\n", ret);
>> -		psci_pd_remove_topology(np);
>> -		goto remove_pd;
>> +	if (psci_has_osi_support()) {
>> +		ret = psci_set_osi_mode();
>> +		if (ret) {
>> +			pr_warn("failed to enable OSI mode: %d\n", ret);
>> +			psci_pd_remove_topology(np);
>> +			goto remove_pd;
>> +		} else
>> +			osi_mode_enabled = true;
>>   	}
>>
>> -	osi_mode_enabled = true;
>>   	of_node_put(np);
>>   	pr_info("Initialized CPU PM domain topology\n");
>>   	return pd_count;
>> @@ -293,9 +397,6 @@ struct device __init *psci_dt_attach_cpu(int cpu)
>>   {
>>   	struct device *dev;
>>
>> -	if (!osi_mode_enabled)
>> -		return NULL;
>> -
>>   	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
>>   	if (IS_ERR_OR_NULL(dev))
>>   		return dev;
>> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
>> index edd7a54..3fa2aee 100644
>> --- a/drivers/cpuidle/cpuidle-psci.c
>> +++ b/drivers/cpuidle/cpuidle-psci.c
>> @@ -49,7 +49,7 @@ static inline int psci_enter_state(int idx, u32 state)
>>   	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
>>   }
>>
>> -static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>> +int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>>   					struct cpuidle_driver *drv, int idx)
>>   {
>>   	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
>> @@ -193,24 +193,29 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>>   		goto free_mem;
>>   	}
>>
>> -	/* Currently limit the hierarchical topology to be used in OSI mode. */
>> -	if (psci_has_osi_support()) {
>> -		data->dev = psci_dt_attach_cpu(cpu);
>> -		if (IS_ERR(data->dev)) {
>> -			ret = PTR_ERR(data->dev);
>> +	if (!psci_has_osi_support()) {
>> +		ret = psci_dt_pm_domains_parse_states(drv, cpu_node,
>> +					      psci_states);
>> +		if (ret)
>>   			goto free_mem;
>> -		}
>> -
>> -		/*
>> -		 * Using the deepest state for the CPU to trigger a potential
>> -		 * selection of a shared state for the domain, assumes the
>> -		 * domain states are all deeper states.
>> -		 */
>> -		if (data->dev) {
>> -			drv->states[state_count - 1].enter =
>> -				psci_enter_domain_idle_state;
>> -			psci_cpuidle_use_cpuhp = true;
>> -		}
>> +	}
>> +
>> +	data->dev = psci_dt_attach_cpu(cpu);
>> +	if (IS_ERR(data->dev)) {
>> +		ret = PTR_ERR(data->dev);
>> +		goto free_mem;
>> +	}
>> +
>> +	/*
>> +	 * Using the deepest state for the CPU to trigger a potential
>> +	 * selection of a shared state for the domain, assumes the
>> +	 * domain states are all deeper states.
>> +	 */
>> +
>> +	if (data->dev) {
>> +		drv->states[state_count - 1].enter =
>> +			psci_enter_domain_idle_state;
>> +		psci_cpuidle_use_cpuhp = true;
>>   	}
>>
>>   	/* Idle states parsed correctly, store them in the per-cpu struct. */
> --
> Regards,
> Sudeep

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
