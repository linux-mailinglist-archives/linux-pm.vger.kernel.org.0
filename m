Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB912D20B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 17:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfL3QfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 11:35:11 -0500
Received: from foss.arm.com ([217.140.110.172]:56426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfL3QfL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Dec 2019 11:35:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72C4631B;
        Mon, 30 Dec 2019 08:35:10 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77BCB3F703;
        Mon, 30 Dec 2019 08:35:08 -0800 (PST)
Date:   Mon, 30 Dec 2019 16:35:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 10/15] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
Message-ID: <20191230163503.GA16256@bogus>
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
 <20191230144402.30195-11-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230144402.30195-11-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 30, 2019 at 03:43:57PM +0100, Ulf Hansson wrote:
> The per CPU variable psci_power_state, contains an array of fixed values,
> which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> each of the available CPU idle states.
> 
> This isn't sufficient when using the hierarchical CPU topology in DT, in
> combination with having PSCI OS initiated (OSI) mode enabled. More
> precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> idle state the cluster (a group of CPUs) should enter, while in PSCI
> Platform Coordinated (PC) mode, each CPU independently votes for an idle
> state of the cluster.
> 
> For this reason, introduce a per CPU variable called domain_state and
> implement two helper functions to read/write its value. Then let the
> domain_state take precedence over the regular selected state, when entering
> and idle state.
> 
> To avoid executing the above OSI specific code in the ->enter() callback,
> while operating in the default PSCI Platform Coordinated mode, let's also
> add a new enter-function and use it for OSI.
> 
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v5:
> 	- None.
> 
> ---
>  drivers/cpuidle/cpuidle-psci.c | 56 ++++++++++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 6a87848be3c3..9600fe674a89 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -29,14 +29,47 @@ struct psci_cpuidle_data {
>  };
>  
>  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
> +static DEFINE_PER_CPU(u32, domain_state);
> +
> +static inline void psci_set_domain_state(u32 state)
> +{
> +	__this_cpu_write(domain_state, state);
> +}
> +
> +static inline u32 psci_get_domain_state(void)
> +{
> +	return __this_cpu_read(domain_state);
> +}
> +
> +static inline int psci_enter_state(int idx, u32 state)
> +{
> +	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
> +}
> +
> +static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int idx)
> +{
> +	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
> +	u32 *states = data->psci_states;
> +	u32 state = psci_get_domain_state();
> +	int ret;
> +
> +	if (!state)
> +		state = states[idx];
> +
> +	ret = psci_enter_state(idx, state);
> +
> +	/* Clear the domain state to start fresh when back from idle. */
> +	psci_set_domain_state(0);
> +	return ret;
> +}
>  
>  static int psci_enter_idle_state(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv, int idx)
>  {
>  	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
>  
> -	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
> -					   idx, state[idx]);
> +	return psci_enter_state(idx, state[idx]);
>  }
>  
>  static struct cpuidle_driver psci_idle_driver __initdata = {
> @@ -79,7 +112,8 @@ static int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
>  	return 0;
>  }
>  
> -static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> +static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> +					struct device_node *cpu_node,
>  					unsigned int state_count, int cpu)
>  {
>  	int i, ret = 0;
> @@ -118,6 +152,15 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
>  			ret = PTR_ERR(data->dev);
>  			goto free_mem;
>  		}
> +
> +		/*
> +		 * Using the deepest state for the CPU to trigger a potential
> +		 * selection of a shared state for the domain, assumes the
> +		 * domain states are all deeper states.
> +		 */
> +		if (data->dev)

Do we still need this check ? I thought we won't attach genpd if OSI is
not enabled. If possible, please drop the check.

Other than that, looks good to me.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
