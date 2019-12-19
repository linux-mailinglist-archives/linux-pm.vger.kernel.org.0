Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505841264E3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 15:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfLSOec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 09:34:32 -0500
Received: from foss.arm.com ([217.140.110.172]:39490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfLSOec (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 09:34:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7907931B;
        Thu, 19 Dec 2019 06:34:31 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E8A83F6CF;
        Thu, 19 Dec 2019 06:34:29 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:34:27 +0000
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
        Kevin Hilman <khilman@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 13/14] cpuidle: psci: Add support for PM domains by
 using genpd
Message-ID: <20191219143427.GF20746@bogus>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-14-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211154343.29765-14-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 11, 2019 at 04:43:42PM +0100, Ulf Hansson wrote:
> When the hierarchical CPU topology layout is used in DT and the PSCI OSI
> mode is supported by the PSCI FW, let's initialize a corresponding PM
> domain topology by using genpd. This enables a CPU and a group of CPUs,
> when attached to the topology, to be power-managed accordingly.
>
> To trigger the attempt to initialize the genpd data structures let's use a
> subsys_initcall, which should be early enough to allow CPUs, but also other
> devices to be attached.
>
> The initialization consists of parsing the PSCI OF node for the topology
> and the "domain idle states" DT bindings. In case the idle states are
> compatible with "domain-idle-state", the initialized genpd becomes
> responsible of selecting an idle state for the PM domain, via assigning it
> a genpd governor.
>
> Note that, a successful initialization of the genpd data structures, is
> followed by a call to psci_set_osi_mode(), as to try to enable the OSI mode
> in the PSCI FW. In case this fails, we fall back into a degraded mode
> rather than bailing out and returning an error code.
>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v4:
> 	- None.
>
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 267 ++++++++++++++++++++++++++
>  drivers/cpuidle/cpuidle-psci.c        |   4 +-
>  drivers/cpuidle/cpuidle-psci.h        |   5 +
>  3 files changed, 274 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index 656ef3d59149..c2f94ba42222 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -7,14 +7,281 @@
>   *
>   */
>
> +#define pr_fmt(fmt) "CPUidle PSCI: " fmt
> +
>  #include <linux/cpu.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/psci.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
>
>  #include "cpuidle-psci.h"
>
> +struct psci_pd_provider {
> +	struct list_head link;
> +	struct device_node *node;
> +};
> +
> +static LIST_HEAD(psci_pd_providers);
> +static bool osi_mode_enabled;
> +
> +static int psci_pd_power_off(struct generic_pm_domain *pd)
> +{
> +	struct genpd_power_state *state = &pd->states[pd->state_idx];
> +	u32 *pd_state;
> +
> +	/* If we have failed to enable OSI mode, then abort power off. */
> +	if (!osi_mode_enabled)
> +		return -EBUSY;
> +

Why is above check needed ? Shouldn't we have disable/remove pd of
OSI is not enabled ?

> +	if (!state->data)
> +		return 0;
> +
> +	/* OSI mode is enabled, set the corresponding domain state. */
> +	pd_state = state->data;
> +	psci_set_domain_state(*pd_state);
> +
> +	return 0;
> +}
> +

[...]

> +static const struct of_device_id psci_of_match[] __initconst = {
> +	{ .compatible = "arm,psci" },

I think we can drop the above one as it's for v0.1 which didn't support
OSI.

> +	{ .compatible = "arm,psci-0.2" },
> +	{ .compatible = "arm,psci-1.0" },
> +	{}
> +};
> +
> +static int __init psci_idle_init_domains(void)
> +{
> +	struct device_node *np = of_find_matching_node(NULL, psci_of_match);
> +	struct device_node *node;
> +	int ret = 0, pd_count = 0;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	/* Currently limit the hierarchical topology to be used in OSI mode. */
> +	if (!psci_has_osi_support())
> +		goto out;
> +
> +	/*
> +	 * Parse child nodes for the "#power-domain-cells" property and
> +	 * initialize a genpd/genpd-of-provider pair when it's found.
> +	 */
> +	for_each_child_of_node(np, node) {
> +		if (!of_find_property(node, "#power-domain-cells", NULL))
> +			continue;
> +
> +		ret = psci_pd_init(node);
> +		if (ret)
> +			goto put_node;
> +
> +		pd_count++;
> +	}
> +
> +	/* Bail out if not using the hierarchical CPU topology. */
> +	if (!pd_count)
> +		goto out;
> +
> +	/* Link genpd masters/subdomains to model the CPU topology. */
> +	ret = psci_pd_init_topology(np);
> +	if (ret)
> +		goto remove_pd;
> +
> +	/* Try to enable OSI mode. */
> +	ret = psci_set_osi_mode();
> +	if (ret)
> +		pr_warn("failed to enable OSI mode: %d\n", ret);

Same question as above: shouldn't we disable and goto remove_pd ?

--
Regards,
Sudeep
