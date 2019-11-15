Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4420FE3C2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 18:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfKORQA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 12:16:00 -0500
Received: from foss.arm.com ([217.140.110.172]:34096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbfKORQA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Nov 2019 12:16:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F99431B;
        Fri, 15 Nov 2019 09:15:59 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994393F6C4;
        Fri, 15 Nov 2019 09:15:57 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:15:55 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 09/13] cpuidle: psci: Attach CPU devices to their PM
 domains
Message-ID: <20191115171555.GD27170@bogus>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-10-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029164438.17012-10-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 05:44:34PM +0100, Ulf Hansson wrote:
> In order to enable a CPU to be power managed through its PM domain, let's
> try to attach it by calling psci_dt_attach_cpu() during the cpuidle
> initialization.
>
> psci_dt_attach_cpu() returns a pointer to the attached struct device, which
> later should be used for runtime PM, hence we need to store it somewhere.
> Rather than adding yet another per CPU variable, let's create a per CPU
> struct to collect the relevant per CPU variables.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
> 	- Rebased.
>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 830995b8a56f..167249d0493f 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -20,14 +20,20 @@
>
>  #include <asm/cpuidle.h>
>
> +#include "cpuidle-psci.h"
>  #include "dt_idle_states.h"
>
> -static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> +struct psci_cpuidle_data {
> +	u32 *psci_states;
> +	struct device *dev;
> +};
> +
> +static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
>
>  static int psci_enter_idle_state(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv, int idx)
>  {
> -	u32 *state = __this_cpu_read(psci_power_state);
> +	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
>
>  	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
>  					   idx, state[idx]);
> @@ -78,7 +84,9 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
>  {
>  	int i, ret = 0;
>  	u32 *psci_states;
> +	struct device *dev;
>  	struct device_node *state_node;
> +	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
>
>  	state_count++; /* Add WFI state too */
>  	psci_states = kcalloc(state_count, sizeof(*psci_states), GFP_KERNEL);
> @@ -104,8 +112,16 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
>  		goto free_mem;
>  	}
>
> -	/* Idle states parsed correctly, initialize per-cpu pointer */
> -	per_cpu(psci_power_state, cpu) = psci_states;
> +	dev = psci_dt_attach_cpu(cpu);

Why do we need to call psci_dt_attach_cpu for even PC mode and ...

> +	if (IS_ERR(dev)) {
> +		ret = PTR_ERR(dev);
> +		goto free_mem;
> +	}
> +
> +	data->dev = dev;
> +

... assign NULL above. I don't see the need for one. Default it will be
NULL anyway and we can call psci_dt_attach_cpu only if psci_has_osi_support()

I will look through further patches to see if it make sense or not.

--
Regards,
Sudeep
