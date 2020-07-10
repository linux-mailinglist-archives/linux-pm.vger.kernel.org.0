Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA7321B4D9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 14:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgGJMQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 08:16:49 -0400
Received: from foss.arm.com ([217.140.110.172]:42928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgGJMQs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 08:16:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA19C0A;
        Fri, 10 Jul 2020 05:16:47 -0700 (PDT)
Received: from [10.37.12.58] (unknown [10.37.12.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FF483F8C6;
        Fri, 10 Jul 2020 05:16:44 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] cpuidle: psci: Prevent domain idlestates until
 consumers are ready
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200707125804.13030-1-ulf.hansson@linaro.org>
 <20200707125804.13030-6-ulf.hansson@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <11a26809-1fb0-c09e-9f74-eddeec9180ff@arm.com>
Date:   Fri, 10 Jul 2020 13:16:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200707125804.13030-6-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/7/20 1:58 PM, Ulf Hansson wrote:
> Depending on the SoC/platform, additional devices may be part of the PSCI
> PM domain topology. This is the case with 'qcom,rpmh-rsc' device, for
> example, even if this is not yet visible in the corresponding DTS-files.

I was interested by your description and checked related DT
to this device. It's probably the best what we can do in such situation
and such requirements.

> 
> Without going into too much details, a device like the 'qcom,rpmh-rsc' may
> have HW constraints that needs to be obeyed to, before a domain idlestate
> can be picked.
> 
> Therefore, let's implement the ->sync_state() callback to receive a
> notification when all consumers of the PSCI PM domain providers have been
> attached/probed to it. In this way, we can make sure all constraints from
> all relevant devices, are taken into account before allowing a domain
> idlestate to be picked.
> 
> Acked-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>



Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

> ---
>   drivers/cpuidle/cpuidle-psci-domain.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index bf527d2bb4b6..b6e9649ab0da 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -27,6 +27,7 @@ struct psci_pd_provider {
>   };
>   
>   static LIST_HEAD(psci_pd_providers);
> +static bool psci_pd_allow_domain_state;
>   
>   static int psci_pd_power_off(struct generic_pm_domain *pd)
>   {
> @@ -36,6 +37,9 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
>   	if (!state->data)
>   		return 0;
>   
> +	if (!psci_pd_allow_domain_state)
> +		return -EBUSY;
> +
>   	/* OSI mode is enabled, set the corresponding domain state. */
>   	pd_state = state->data;
>   	psci_set_domain_state(*pd_state);
> @@ -222,6 +226,15 @@ static void psci_pd_remove_topology(struct device_node *np)
>   	psci_pd_init_topology(np, false);
>   }
>   
> +static void psci_cpuidle_domain_sync_state(struct device *dev)
> +{
> +	/*
> +	 * All devices have now been attached/probed to the PM domain topology,
> +	 * hence it's fine to allow domain states to be picked.
> +	 */
> +	psci_pd_allow_domain_state = true;
> +}
> +
>   static const struct of_device_id psci_of_match[] = {
>   	{ .compatible = "arm,psci-1.0" },
>   	{}
> @@ -289,6 +302,7 @@ static struct platform_driver psci_cpuidle_domain_driver = {
>   	.driver = {
>   		.name = "psci-cpuidle-domain",
>   		.of_match_table = psci_of_match,
> +		.sync_state = psci_cpuidle_domain_sync_state,
>   	},
>   };
>   
> 
