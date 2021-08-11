Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0496A3E9600
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhHKQcu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 12:32:50 -0400
Received: from foss.arm.com ([217.140.110.172]:54234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhHKQco (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Aug 2021 12:32:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5C041063;
        Wed, 11 Aug 2021 09:32:13 -0700 (PDT)
Received: from [10.57.12.152] (unknown [10.57.12.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 966B83F718;
        Wed, 11 Aug 2021 09:32:11 -0700 (PDT)
Subject: Re: [PATCH V2 9/9] cpufreq: scmi: Use .register_em() callback
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1628682874.git.viresh.kumar@linaro.org>
 <6094d891b4cb0cba3357e2894c8a4431c4c65e67.1628682874.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <143a03df-d858-b2de-a2cc-983c35d71e53@arm.com>
Date:   Wed, 11 Aug 2021 17:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6094d891b4cb0cba3357e2894c8a4431c4c65e67.1628682874.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/11/21 12:58 PM, Viresh Kumar wrote:
> Set the newly added .register_em() callback to register with the EM
> after the cpufreq policy is properly initialized.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/scmi-cpufreq.c | 55 ++++++++++++++++++++--------------
>   1 file changed, 32 insertions(+), 23 deletions(-)

>   
> +static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
> +{
> +	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
> +	bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
> +	struct scmi_data *priv = policy->driver_data;
> +
> +	em_dev_register_perf_domain(get_cpu_device(policy->cpu), priv->nr_opp,
> +				    &em_cb, priv->opp_shared_cpus,
> +				    power_scale_mw);

I would free the priv->opp_shared_cpus mask here, since we don't
need it anymore and memory can be reclaimed. Don't forget this
setup would be called N CPUs times, on this per-CPU policy platform.

If freed here, then also there wouldn't be a need to free it in
scmi_cpufreq_exit() so you can remove it from there.

> +}
> +
>   static struct cpufreq_driver scmi_cpufreq_driver = {
>   	.name	= "scmi",
>   	.flags	= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> @@ -261,6 +269,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
>   	.get	= scmi_cpufreq_get_rate,
>   	.init	= scmi_cpufreq_init,
>   	.exit	= scmi_cpufreq_exit,
> +	.register_em	= scmi_cpufreq_register_em,
>   };
>   
>   static int scmi_cpufreq_probe(struct scmi_device *sdev)
> 

I will test&review this patch on Monday when I re-flash custom FW to my
Juno (just to be sure that this per-CPU cpufreq + shared EM/EAS works).
