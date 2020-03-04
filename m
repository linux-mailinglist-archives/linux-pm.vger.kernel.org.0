Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716A3179016
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 13:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgCDMMz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 07:12:55 -0500
Received: from foss.arm.com ([217.140.110.172]:33446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgCDMMz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Mar 2020 07:12:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D02731B;
        Wed,  4 Mar 2020 04:12:54 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15F823F534;
        Wed,  4 Mar 2020 04:12:52 -0800 (PST)
Date:   Wed, 4 Mar 2020 12:12:51 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] cpuidle: psci: Split psci_dt_cpu_init_idle()
Message-ID: <20200304121250.GD25004@bogus>
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303203559.23995-4-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 03, 2020 at 09:35:58PM +0100, Ulf Hansson wrote:
> To make the code a bit more readable, but also to prepare some code to be
> re-used, let's move the OSI specific initialization out of the
> psci_dt_cpu_init_idle() and into a separate function.
>
> Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")

Not sure if this fixes anything but I am fine to have this if next one is
a real fix.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
> 	- Adopted suggestions from Stephen to use IS_ERR_OR_NULL and
> 	PTR_ERR_OR_ZERO, which further clarified the code.
>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 46 ++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index edd7a54ef0d3..bae9140a65a5 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -160,6 +160,29 @@ int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
>  	return 0;
>  }
>
> +static int __init psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
> +					    struct psci_cpuidle_data *data,
> +					    unsigned int state_count, int cpu)
> +{
> +	/* Currently limit the hierarchical topology to be used in OSI mode. */
> +	if (!psci_has_osi_support())
> +		return 0;
> +
> +	data->dev = psci_dt_attach_cpu(cpu);
> +	if (IS_ERR_OR_NULL(data->dev))
> +		return PTR_ERR_OR_ZERO(data->dev);
> +

This is what I was asking to do before this was merged when I meant to drop
if(data->dev) check. So happy to see it :)

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
