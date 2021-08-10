Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0224F3E583E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhHJKZS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:25:18 -0400
Received: from foss.arm.com ([217.140.110.172]:53088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhHJKZS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 06:25:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F7586D;
        Tue, 10 Aug 2021 03:24:56 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B99F3F70D;
        Tue, 10 Aug 2021 03:24:54 -0700 (PDT)
Subject: Re: [PATCH 5/8] cpufreq: omap: Use auto-registration for energy model
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <a17b0f64c3a4cd84a126b3315539c13b15b4738c.1628579170.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e1d23a96-d9af-7151-3023-c279f6b0c970@arm.com>
Date:   Tue, 10 Aug 2021 11:24:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a17b0f64c3a4cd84a126b3315539c13b15b4738c.1628579170.git.viresh.kumar@linaro.org>
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
>   drivers/cpufreq/omap-cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index e035ee216b0f..303136f97773 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -131,7 +131,6 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
>   
>   	/* FIXME: what's the actual transition time? */
>   	cpufreq_generic_init(policy, freq_table, 300 * 1000);
> -	dev_pm_opp_of_register_em(mpu_dev, policy->cpus);
>   
>   	return 0;
>   }
> @@ -144,7 +143,8 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
>   }
>   
>   static struct cpufreq_driver omap_driver = {
> -	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +			  CPUFREQ_REGISTER_WITH_EM,
>   	.verify		= cpufreq_generic_frequency_table_verify,
>   	.target_index	= omap_target,
>   	.get		= cpufreq_generic_get,
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
