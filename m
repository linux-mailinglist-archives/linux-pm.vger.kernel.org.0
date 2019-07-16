Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA4A6AB03
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfGPOxm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 10:53:42 -0400
Received: from foss.arm.com ([217.140.110.172]:36078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPOxm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 10:53:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E0A337;
        Tue, 16 Jul 2019 07:53:41 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A28203F59C;
        Tue, 16 Jul 2019 07:53:38 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:53:36 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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
        linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 07/18] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
Message-ID: <20190716145336.GC7250@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-8-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513192300.653-8-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 09:22:49PM +0200, Ulf Hansson wrote:
> The per CPU variable psci_power_state, contains an array of fixed values,
> which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> each of the available CPU idle states.
>
> This isn't sufficient when using the hierarchical CPU topology in DT in
> combination with having PSCI OS initiated (OSI) mode enabled. More
> precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> idle state the cluster (a group of CPUs) should enter, while in PSCI
> Platform Coordinated (PC) mode, each CPU independently votes for an idle
> state of the cluster.
>
> For this reason, let's introduce an additional per CPU variable called
> domain_state and implement two helper functions to read/write its values.
> Following patches, which implements PM domain support for PSCI, will use
> the domain_state variable and set it to corresponding bits that represents
> the selected idle state for the cluster.
>
> Finally, in psci_cpu_suspend_enter() and psci_suspend_finisher(), let's
> take into account the values in the domain_state, as to get the complete
> suspend parameter.
>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes:
> 	- Clarify changelog.
> 	- Drop changes in psci_cpu_on() as it belongs in the patch for hotplug.
> 	- Move some code inside "#ifdef CONFIG_CPU_IDLE".
>
> ---
>  drivers/firmware/psci/psci.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index b11560f7c4b9..4aec513136e4 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -285,6 +285,17 @@ static int __init psci_features(u32 psci_func_id)
>
>  #ifdef CONFIG_CPU_IDLE
>  static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> +static DEFINE_PER_CPU(u32, domain_state);
> +
> +static inline u32 psci_get_domain_state(void)
> +{
> +	return __this_cpu_read(domain_state);
> +}
> +
> +static inline void psci_set_domain_state(u32 state)
> +{
> +	__this_cpu_write(domain_state, state);
> +}
>
>  static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>  {
> @@ -420,15 +431,17 @@ int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
>  static int psci_suspend_finisher(unsigned long index)
>  {
>  	u32 *state = __this_cpu_read(psci_power_state);
> +	u32 composite_state = state[index - 1] | psci_get_domain_state();
>

The more I read this code and PSCI spec, I think it's not simple OR here
unless the specification states that. ACPI LPI explicitly stated that as
it was generic and PSCI doesn't. It can be made workable for original
format, but I think it's not that simple for extended format unless the
suspend parameters are carefully designed to achieve that, so we can't
just convert existing platforms the way it's shown on HiKey in this series.

--
Regards,
Sudeep
