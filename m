Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7161738E49
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfFGPBt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 11:01:49 -0400
Received: from foss.arm.com ([217.140.110.172]:42000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbfFGPBt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 11:01:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5FFD346;
        Fri,  7 Jun 2019 08:01:48 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 316D33F71A;
        Fri,  7 Jun 2019 08:01:46 -0700 (PDT)
Date:   Fri, 7 Jun 2019 16:01:44 +0100
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
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] drivers: firmware: psci: Simplify state node
 parsing
Message-ID: <20190607150144.GD15577@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-6-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513192300.653-6-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 09:22:47PM +0200, Ulf Hansson wrote:
> Instead of iterating through all the state nodes in DT, to find out how
> many states that needs to be allocated, let's use the number already known
> by the cpuidle driver. In this way we can drop the iteration altogether.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> 
> Changes:
> 	- None.
> 
> ---
>  drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 88e90e0f06b9..9c2180bcee4c 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -306,26 +306,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  			struct device_node *cpu_node, int cpu)
>  {
> -	int i, ret = 0, count = 0;
> +	int i, ret = 0, num_state_nodes = drv->state_count - 1;
>  	u32 *psci_states;
>  	struct device_node *state_node;
>  
> -	/* Count idle states */
> -	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> -					      count))) {
> -		count++;
> -		of_node_put(state_node);
> -	}
> -
> -	if (!count)
> -		return -ENODEV;
> -
> -	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> +	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
> +			GFP_KERNEL);
>  	if (!psci_states)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < num_state_nodes; i++) {
>  		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);

Why not start using of_get_cpu_state_node here which was introduced in
earlier patch as part of this simplification ?

--
Regards,
Sudeep
