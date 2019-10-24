Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92305E36E4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 17:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409730AbfJXPmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 11:42:24 -0400
Received: from foss.arm.com ([217.140.110.172]:54832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406209AbfJXPmY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Oct 2019 11:42:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 621BB328;
        Thu, 24 Oct 2019 08:42:08 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CF5E3F71F;
        Thu, 24 Oct 2019 08:42:06 -0700 (PDT)
Date:   Thu, 24 Oct 2019 16:42:04 +0100
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
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 08/13] cpuidle: psci: Prepare to use OS initiated suspend
 mode via PM domains
Message-ID: <20191024154204.GB21622@bogus>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-9-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010113937.15962-9-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 01:39:32PM +0200, Ulf Hansson wrote:
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
> domain_state take precedence over the regular selected state, when idling
> the CPU in psci_enter_idle_state().
>
> This allows subsequent patches that implements support for PM domains for
> cpuidle-psci, to write the selected idle state parameter for the cluster
> into the domain_state variable. Furthermore, let's share the needed
> functions in a header file, to enable the support for PM domains to be
> implemented in a separate c-file.
>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 31 ++++++++++++++++++++++++++++---
>  drivers/cpuidle/cpuidle-psci.h | 11 +++++++++++
>  2 files changed, 39 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/cpuidle/cpuidle-psci.h
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 5c30f23a8a7b..a16467daf99d 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -20,17 +20,42 @@
>
>  #include <asm/cpuidle.h>
>
> +#include "cpuidle-psci.h"
>  #include "dt_idle_states.h"
>
>  static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> +static DEFINE_PER_CPU(u32, domain_state);
> +

[nit] for me name 'domain_state' is per domain and for one each in the
hierarchical topology. But here it's per cpu, just wondering if we can
rename it to provide implicit meaning ?

> +void psci_set_domain_state(u32 state)
> +{
> +	__this_cpu_write(domain_state, state);
> +}
> +
> +static inline u32 psci_get_domain_state(void)
> +{
> +	return __this_cpu_read(domain_state);
> +}
> +
> +static int __psci_enter_idle_state(int idx, u32 state)
> +{
> +	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
> +}
>
>  static int psci_enter_idle_state(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv, int idx)
>  {
> +	int ret;
>  	u32 *states = __this_cpu_read(psci_power_state);
> -	u32 state = idx ? states[idx - 1] : 0;
> +	u32 state = psci_get_domain_state();
>
> -	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
> +	if (!state && idx)
> +		state = states[idx - 1];

This can go as mentioned earlier once we have entry for WFI also.

> +
> +	ret = __psci_enter_idle_state(idx, state);
> +
> +	/* Clear the domain state to start fresh when back from idle. */
> +	psci_set_domain_state(0);
> +	return ret;
>  }
>
>  static struct cpuidle_driver psci_idle_driver __initdata = {
> @@ -56,7 +81,7 @@ static const struct of_device_id psci_idle_state_match[] __initconst = {
>  	{ },
>  };
>
> -static int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
> +int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)

Can this me made part of patch that uses it instead of here ?

--
Regards,
Sudeep
