Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7813E5831
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhHJKWN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:22:13 -0400
Received: from foss.arm.com ([217.140.110.172]:53000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239790AbhHJKUm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 06:20:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81DEF6D;
        Tue, 10 Aug 2021 03:20:20 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE5C93F70D;
        Tue, 10 Aug 2021 03:20:17 -0700 (PDT)
Subject: Re: [PATCH 3/8] cpufreq: imx6q: Use auto-registration for energy
 model
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <ba662b10e043e7734eb9d9e9bbc4c75afab9c2a4.1628579170.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ff0a6452-22b0-8d03-5fc5-4a48e460eb3d@arm.com>
Date:   Tue, 10 Aug 2021 11:20:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ba662b10e043e7734eb9d9e9bbc4c75afab9c2a4.1628579170.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/10/21 8:36 AM, Viresh Kumar wrote:
> Use the CPUFREQ_REGISTER_WITH_EM flag to allow cpufreq core to
> automatically register with the energy model.
> 
> This allows removal of boiler plate code from the driver and fixes the
> unregistration part as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/imx6q-cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 5bf5fc759881..aa8df5b468d7 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -192,14 +192,14 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>   	policy->clk = clks[ARM].clk;
>   	cpufreq_generic_init(policy, freq_table, transition_latency);
>   	policy->suspend_freq = max_freq;
> -	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
>   
>   	return 0;
>   }
>   
>   static struct cpufreq_driver imx6q_cpufreq_driver = {
>   	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> -		 CPUFREQ_IS_COOLING_DEV,
> +		 CPUFREQ_IS_COOLING_DEV |
> +		 CPUFREQ_REGISTER_WITH_EM,
>   	.verify = cpufreq_generic_frequency_table_verify,
>   	.target_index = imx6q_set_target,
>   	.get = cpufreq_generic_get,
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
