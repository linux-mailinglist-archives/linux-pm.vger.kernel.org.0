Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BAA3E5850
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbhHJK1x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:27:53 -0400
Received: from foss.arm.com ([217.140.110.172]:53114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhHJK1A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 06:27:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D03FC6D;
        Tue, 10 Aug 2021 03:26:28 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF7DD3F70D;
        Tue, 10 Aug 2021 03:26:26 -0700 (PDT)
Subject: Re: [PATCH 6/8] cpufreq: qcom-cpufreq-hw: Use auto-registration for
 energy model
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <0b0d533988c3a4318b9fdc5e10c857348e203132.1628579170.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <68aa4250-da98-e70a-2850-03d97f768b2c@arm.com>
Date:   Tue, 10 Aug 2021 11:26:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0b0d533988c3a4318b9fdc5e10c857348e203132.1628579170.git.viresh.kumar@linaro.org>
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
>   drivers/cpufreq/qcom-cpufreq-hw.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index f86859bf76f1..221433c6dcb0 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -362,8 +362,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   		goto error;
>   	}
>   
> -	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
> -
>   	if (policy_has_boost_freq(policy)) {
>   		ret = cpufreq_enable_boost_support();
>   		if (ret)
> @@ -406,7 +404,8 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
>   static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>   	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
>   			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> -			  CPUFREQ_IS_COOLING_DEV,
> +			  CPUFREQ_IS_COOLING_DEV |
> +			  CPUFREQ_REGISTER_WITH_EM,
>   	.verify		= cpufreq_generic_frequency_table_verify,
>   	.target_index	= qcom_cpufreq_hw_target_index,
>   	.get		= qcom_cpufreq_hw_get,
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
