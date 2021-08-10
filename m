Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0405E3E5853
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbhHJK2H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:28:07 -0400
Received: from foss.arm.com ([217.140.110.172]:53146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhHJK2D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 06:28:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D46286D;
        Tue, 10 Aug 2021 03:27:41 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3A493F70D;
        Tue, 10 Aug 2021 03:27:39 -0700 (PDT)
Subject: Re: [PATCH 7/8] cpufreq: scpi: Use auto-registration for energy model
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <7809d747fecbaad46699a178f26288a015055b20.1628579170.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4db552cd-a362-13ab-194e-5117addd636f@arm.com>
Date:   Tue, 10 Aug 2021 11:27:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7809d747fecbaad46699a178f26288a015055b20.1628579170.git.viresh.kumar@linaro.org>
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
>   drivers/cpufreq/scpi-cpufreq.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index d6a698a1b5d1..bc8c62b1beb5 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -163,8 +163,6 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
>   
>   	policy->fast_switch_possible = false;
>   
> -	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
> -
>   	return 0;
>   
>   out_free_cpufreq_table:
> @@ -193,7 +191,8 @@ static struct cpufreq_driver scpi_cpufreq_driver = {
>   	.name	= "scpi-cpufreq",
>   	.flags	= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
>   		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> -		  CPUFREQ_IS_COOLING_DEV,
> +		  CPUFREQ_IS_COOLING_DEV |
> +		  CPUFREQ_REGISTER_WITH_EM,
>   	.verify	= cpufreq_generic_frequency_table_verify,
>   	.attr	= cpufreq_generic_attr,
>   	.get	= scpi_cpufreq_get_rate,
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
