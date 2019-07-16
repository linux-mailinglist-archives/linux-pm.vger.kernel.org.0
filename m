Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A616AC47
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 17:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfGPPxY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 11:53:24 -0400
Received: from foss.arm.com ([217.140.110.172]:37024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfGPPxY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 11:53:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D041B337;
        Tue, 16 Jul 2019 08:53:22 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 432013F71A;
        Tue, 16 Jul 2019 08:53:20 -0700 (PDT)
Date:   Tue, 16 Jul 2019 16:53:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] drivers: firmware: psci: Manage runtime PM in the
 idle path for CPUs
Message-ID: <20190716155317.GB32490@e121166-lin.cambridge.arm.com>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-15-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513192300.653-15-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 09:22:56PM +0200, Ulf Hansson wrote:
> When the hierarchical CPU topology layout is used in DT, let's allow the
> CPU to be power managed through its PM domain, via deploying runtime PM
> support.
> 
> To know for which idle states runtime PM reference counting is needed,
> let's store the index of deepest idle state for the CPU, in a per CPU
> variable. This allows psci_cpu_suspend_enter() to compare this index with
> the requested idle state index and then act accordingly.

I do not see why a system with two CPU CPUidle states, say CPU retention
and CPU shutdown, should not be calling runtime PM on CPU retention
entry.

The question then is what cluster/package/system states
are allowed for a given CPU idle state, to understand
what idle states can be actually entered at any hierarchy
level given the choice made for the CPU idle state.

In the case above, a CPU entering retention state should prevent
runtime PM selecting a cluster shutdown state; most likely firmware
would demote the request to cluster retention but still, we should
find a way to describe these dependencies.

Thanks,
Lorenzo

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes:
> 	- Simplify the code by using the new per CPU struct, that stores the
> 	  needed struct device*.
> 
> ---
>  drivers/firmware/psci/psci.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 54e23d4ed0ea..2c4157d3a616 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -20,6 +20,7 @@
>  #include <linux/linkage.h>
>  #include <linux/of.h>
>  #include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/printk.h>
>  #include <linux/psci.h>
>  #include <linux/reboot.h>
> @@ -298,6 +299,7 @@ static int __init psci_features(u32 psci_func_id)
>  
>  struct psci_cpuidle_data {
>  	u32 *psci_states;
> +	u32 rpm_state_id;
>  	struct device *dev;
>  };
>  
> @@ -385,6 +387,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  			goto free_mem;
>  
>  		data->dev = dev;
> +		data->rpm_state_id = drv->state_count - 1;
>  	}
>  
>  	/* Idle states parsed correctly, store them in the per-cpu struct. */
> @@ -481,8 +484,11 @@ static int psci_suspend_finisher(unsigned long index)
>  int psci_cpu_suspend_enter(unsigned long index)
>  {
>  	int ret;
> -	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
> -	u32 composite_state = state[index - 1] | psci_get_domain_state();
> +	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
> +	u32 *states = data->psci_states;
> +	struct device *dev = data->dev;
> +	bool runtime_pm = (dev && data->rpm_state_id == index);
> +	u32 composite_state;
>  
>  	/*
>  	 * idle state index 0 corresponds to wfi, should never be called
> @@ -491,11 +497,23 @@ int psci_cpu_suspend_enter(unsigned long index)
>  	if (WARN_ON_ONCE(!index))
>  		return -EINVAL;
>  
> +	/*
> +	 * Do runtime PM if we are using the hierarchical CPU toplogy, but only
> +	 * when cpuidle have selected the deepest idle state for the CPU.
> +	 */
> +	if (runtime_pm)
> +		pm_runtime_put_sync_suspend(dev);
> +
> +	composite_state = states[index - 1] | psci_get_domain_state();
> +
>  	if (!psci_power_state_loses_context(composite_state))
>  		ret = psci_ops.cpu_suspend(composite_state, 0);
>  	else
>  		ret = cpu_suspend(index, psci_suspend_finisher);
>  
> +	if (runtime_pm)
> +		pm_runtime_get_sync(dev);
> +
>  	/* Clear the domain state to start fresh when back from idle. */
>  	psci_set_domain_state(0);
>  
> -- 
> 2.17.1
> 
