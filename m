Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9939F3E5821
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhHJKTw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:19:52 -0400
Received: from foss.arm.com ([217.140.110.172]:52976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238598AbhHJKTw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 06:19:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE6C36D;
        Tue, 10 Aug 2021 03:19:29 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D5E63F70D;
        Tue, 10 Aug 2021 03:19:28 -0700 (PDT)
Subject: Re: [PATCH 2/8] cpufreq: dt: Use auto-registration for energy model
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <f66047fca65a2d368e881d62e1623dbeef2eacd2.1628579170.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d6e6bb3c-55fc-7d2e-5716-a133c89e3efa@arm.com>
Date:   Tue, 10 Aug 2021 11:19:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f66047fca65a2d368e881d62e1623dbeef2eacd2.1628579170.git.viresh.kumar@linaro.org>
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
>   drivers/cpufreq/cpufreq-dt.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index ece52863ba62..b727006e85af 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -143,8 +143,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>   		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
>   	}
>   
> -	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
> -
>   	return 0;
>   
>   out_clk_put:
> @@ -176,7 +174,8 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
>   
>   static struct cpufreq_driver dt_cpufreq_driver = {
>   	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> -		 CPUFREQ_IS_COOLING_DEV,
> +		 CPUFREQ_IS_COOLING_DEV |
> +		 CPUFREQ_REGISTER_WITH_EM,
>   	.verify = cpufreq_generic_frequency_table_verify,
>   	.target_index = set_target,
>   	.get = cpufreq_generic_get,
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
