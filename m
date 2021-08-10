Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD33E582B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbhHJKVV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:21:21 -0400
Received: from foss.arm.com ([217.140.110.172]:53028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239814AbhHJKVS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 06:21:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD9C76D;
        Tue, 10 Aug 2021 03:20:56 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC5D73F70D;
        Tue, 10 Aug 2021 03:20:54 -0700 (PDT)
Subject: Re: [PATCH 4/8] cpufreq: mediatek: Use auto-registration for energy
 model
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <fe10f291210bfd16620f4be766e6647c8e577995.1628579170.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <12fc1e9d-bb74-63c2-7905-c0917df1cf5b@arm.com>
Date:   Tue, 10 Aug 2021 11:20:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fe10f291210bfd16620f4be766e6647c8e577995.1628579170.git.viresh.kumar@linaro.org>
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
>   drivers/cpufreq/mediatek-cpufreq.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 87019d5a9547..4743f2e58b97 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -448,8 +448,6 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>   	policy->driver_data = info;
>   	policy->clk = info->cpu_clk;
>   
> -	dev_pm_opp_of_register_em(info->cpu_dev, policy->cpus);
> -
>   	return 0;
>   }
>   
> @@ -465,7 +463,8 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>   static struct cpufreq_driver mtk_cpufreq_driver = {
>   	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
>   		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> -		 CPUFREQ_IS_COOLING_DEV,
> +		 CPUFREQ_IS_COOLING_DEV |
> +		 CPUFREQ_REGISTER_WITH_EM,
>   	.verify = cpufreq_generic_frequency_table_verify,
>   	.target_index = mtk_cpufreq_set_target,
>   	.get = cpufreq_generic_get,
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
