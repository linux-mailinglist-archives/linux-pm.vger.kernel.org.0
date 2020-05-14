Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D411D3273
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgENOQd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 10:16:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48348 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgENOQd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 10:16:33 -0400
Received: from 89-64-84-17.dynamic.chello.pl (89.64.84.17) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id ce086dfbd8228c14; Thu, 14 May 2020 16:16:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     viresh.kumar@linaro.org, Souvik.Chakravarty@arm.com,
        Thanu.Rangarajan@arm.com, Sudeep.Holla@arm.com,
        guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] cpufreq: Add SW BOOST support for drivers without frequency table
Date:   Thu, 14 May 2020 16:16:29 +0200
Message-ID: <5858421.kfVlu25t0p@kreacher>
In-Reply-To: <1588929064-30270-3-git-send-email-wangxiongfeng2@huawei.com>
References: <1588929064-30270-1-git-send-email-wangxiongfeng2@huawei.com> <1588929064-30270-3-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, May 8, 2020 11:11:03 AM CEST Xiongfeng Wang wrote:
> Software-managed BOOST get the boost frequency by check the flag
> CPUFREQ_BOOST_FREQ at driver's frequency table. But some cpufreq driver
> don't have frequency table and use other methods to get the frequency
> range, such CPPC cpufreq driver.
> 
> To add SW BOOST support for drivers without frequency table, we add
> members in 'cpufreq_policy.cpufreq_cpuinfo' to record the max frequency
> of boost mode and non-boost mode. The cpufreq driver initialize these two
> members when probing.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 23 +++++++++++++++--------
>  include/linux/cpufreq.h   |  2 ++
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 475fb1b..a299426 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2508,15 +2508,22 @@ static int cpufreq_boost_set_sw(int state)
>  	int ret = -EINVAL;
>  
>  	for_each_active_policy(policy) {
> -		if (!policy->freq_table)
> -			continue;
> -
> -		ret = cpufreq_frequency_table_cpuinfo(policy,
> +		if (policy->freq_table) {
> +			ret = cpufreq_frequency_table_cpuinfo(policy,
>  						      policy->freq_table);
> -		if (ret) {
> -			pr_err("%s: Policy frequency update failed\n",
> -			       __func__);
> -			break;
> +			if (ret) {
> +				pr_err("%s: Policy frequency update failed\n",
> +				       __func__);
> +				break;
> +			}
> +		} else if (policy->cpuinfo.boost_max_freq) {
> +			if (state)
> +				policy->max = policy->cpuinfo.boost_max_freq;
> +			else
> +				policy->max = policy->cpuinfo.nonboost_max_freq;
> +			policy->cpuinfo.max_freq = policy->max;
> +		} else {
> +			continue;
>  		}

Why do you need to update this function?

The driver should be able to provide its own ->set_boost callback just fine,
shouldn't it?

>  
>  		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 018dce8..c3449e6 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -43,6 +43,8 @@ enum cpufreq_table_sorting {
>  struct cpufreq_cpuinfo {
>  	unsigned int		max_freq;
>  	unsigned int		min_freq;
> +	unsigned int		boost_max_freq;
> +	unsigned int		nonboost_max_freq;
>  
>  	/* in 10^(-9) s = nanoseconds */
>  	unsigned int		transition_latency;
> 




