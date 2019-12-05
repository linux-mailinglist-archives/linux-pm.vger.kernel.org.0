Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD491146F6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 19:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfLESft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 13:35:49 -0500
Received: from foss.arm.com ([217.140.110.172]:43696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfLESft (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 13:35:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71FD331B;
        Thu,  5 Dec 2019 10:35:48 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76AD13F718;
        Thu,  5 Dec 2019 10:35:46 -0800 (PST)
Date:   Thu, 5 Dec 2019 18:35:44 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
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
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v3 10/13] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
Message-ID: <20191205183544.GB1516@e121166-lin.cambridge.arm.com>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
 <20191127102914.18729-11-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127102914.18729-11-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 27, 2019 at 11:29:11AM +0100, Ulf Hansson wrote:

[...]

> -static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> +static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> +					struct device_node *cpu_node,
>  					unsigned int state_count, int cpu)
>  {
>  	int i, ret = 0;
> @@ -118,6 +152,11 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
>  		goto free_mem;
>  	}
>  
> +	/* Manage the deepest state via a dedicated enter-function. */
> +	if (dev)
> +		drv->states[state_count - 1].enter =
> +			psci_enter_domain_idle_state;


It is unfortunate to make this arbitrary choice, it would be best
if you could detect which states are "domain" states aka are governed
by multiple cpus.

This inizialization though does not belong in here, it is done at driver
level, it should not be done in this per-cpu path. IIUC the logic the
enter pointer should only be overridden if and only if all cpus managed
by the driver have a corresponding device associated.

To be frank I would even move the psci_has_osi_support() check from
psci_dt_attach_cpu() to this path and prevent calling
psci_dt_attach_cpu() and the tail of the function if
(!psci_has_osi_support()).

>  	data->dev = dev;

I think Sudeep already mentioned that, by using psci_has_osi_support()
as above you can prevent running this code, there is really no point,
the data->dev NULL sentinel is already initialized.

Lorenzo

>  	/* Idle states parsed correctly, store them in the per-cpu struct. */
> @@ -129,7 +168,8 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
>  	return ret;
>  }
>  
> -static __init int psci_cpu_init_idle(unsigned int cpu, unsigned int state_count)
> +static __init int psci_cpu_init_idle(struct cpuidle_driver *drv,
> +				     unsigned int cpu, unsigned int state_count)
>  {
>  	struct device_node *cpu_node;
>  	int ret;
> @@ -145,7 +185,7 @@ static __init int psci_cpu_init_idle(unsigned int cpu, unsigned int state_count)
>  	if (!cpu_node)
>  		return -ENODEV;
>  
> -	ret = psci_dt_cpu_init_idle(cpu_node, state_count, cpu);
> +	ret = psci_dt_cpu_init_idle(drv, cpu_node, state_count, cpu);
>  
>  	of_node_put(cpu_node);
>  
> @@ -201,7 +241,7 @@ static int __init psci_idle_init_cpu(int cpu)
>  	/*
>  	 * Initialize PSCI idle states.
>  	 */
> -	ret = psci_cpu_init_idle(cpu, ret);
> +	ret = psci_cpu_init_idle(drv, cpu, ret);
>  	if (ret) {
>  		pr_err("CPU %d failed to PSCI idle\n", cpu);
>  		goto out_kfree_drv;
> -- 
> 2.17.1
> 
