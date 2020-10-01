Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9A27FD20
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 12:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJAKSD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 06:18:03 -0400
Received: from foss.arm.com ([217.140.110.172]:58128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgJAKSD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Oct 2020 06:18:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4074ED6E;
        Thu,  1 Oct 2020 03:18:02 -0700 (PDT)
Received: from bogus (unknown [10.57.52.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 627973F70D;
        Thu,  1 Oct 2020 03:17:59 -0700 (PDT)
Date:   Thu, 1 Oct 2020 11:17:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] cpuidle: psci: Enable s2idle when using OSI with the
 PM domain topology
Message-ID: <20201001101756.GB906@bogus>
References: <20200901082707.106860-1-ulf.hansson@linaro.org>
 <20200901082707.106860-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901082707.106860-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 10:27:07AM +0200, Ulf Hansson wrote:
> To select domain idle states for cpuidle-psci, the PM domains via genpd are
> being managed by using runtime PM. This works fine for the regular idle
> path, but it doesn't when doing s2idle.
>
> More precisely, the domain idle states becomes temporarily disabled, which
> is because the PM core disables runtime PM for devices during system
> suspend.

When you refer system suspend above, you mean both S2R and S2I ?

> Even if genpd tries to power off the PM domain in the
> suspend_noirq phase, that doesn't help to properly select a domain idle
> state, as this needs to be done on per CPU basis.
>

And what prevents doing per CPU basis ?

> Let's address the issue by enabling the syscore flag for the attached CPU
> devices. This prevents genpd from trying to power off the corresponding PM
> domains in the suspend_noirq phase. Moreover, let's assign a specific
> ->enter_s2idle() callback for the corresponding domain idle state and let
> it invoke pm_genpd_syscore_poweroff|poweron(), rather than using runtime
> PM.
>

The syscore_suspend is not executed for S2I and using syscore APIs here
is bit confusing IMO. If Rafael is fine, I have no objections.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c |  2 ++
>  drivers/cpuidle/cpuidle-psci.c        | 30 +++++++++++++++++++++++----
>  2 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index b6e9649ab0da..65437ba5fa78 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -324,6 +324,8 @@ struct device *psci_dt_attach_cpu(int cpu)
>  	if (cpu_online(cpu))
>  		pm_runtime_get_sync(dev);
>
> +	dev_pm_syscore_device(dev, true);
> +
>  	return dev;
>  }
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 74463841805f..6322d55a0a7d 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/psci.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -52,8 +53,9 @@ static inline int psci_enter_state(int idx, u32 state)
>  	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
>  }
>
> -static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> -					struct cpuidle_driver *drv, int idx)
> +static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
> +					  struct cpuidle_driver *drv, int idx,
> +					  bool s2idle)
>  {
>  	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
>  	u32 *states = data->psci_states;
> @@ -66,7 +68,10 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>  		return -1;
>
>  	/* Do runtime PM to manage a hierarchical CPU toplogy. */
> -	pm_runtime_put_sync_suspend(pd_dev);
> +	if (s2idle)
> +		pm_genpd_syscore_poweroff(pd_dev);
> +	else
> +		pm_runtime_put_sync_suspend(pd_dev);

Since CPU genpd is special and handled so in core, can this be moved to core ?
I mean pm_runtime_put_sync_suspend handle that based genpd_is_cpu_domain.

--
Regards,
Sudeep
