Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE93CB545
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhGPJdD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 05:33:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27938 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233772AbhGPJdA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Jul 2021 05:33:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626427805; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=QfX1cy6BRq8atEmaeOQYNQ5ZME2FA2z59j0zFsixeDI=; b=NnZu2hw7JchNjluXKqJGgcIusEzYCrMh4N7UUVUhRRV+4/hcGfuvuOoJ+LV7dr9d8kiWhVjx
 NL5oiNi9eKwDAy8iONORmJOR8iTt0jRhlo9au8MvqME7zisEwTq0nslfKdsp1mZzF2cjf2eQ
 DK6roMF4RRpGkCTLnUtePLsFkMM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60f1519c4815712f3a982b48 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Jul 2021 09:30:04
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18BCBC43460; Fri, 16 Jul 2021 09:30:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.50.2.235] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2947CC433D3;
        Fri, 16 Jul 2021 09:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2947CC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
To:     ulf.hansson@linaro.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net
References: <1626412425-30715-1-git-send-email-rnayak@codeaurora.org>
 <1626412425-30715-2-git-send-email-rnayak@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <60c91d5b-21d3-fed8-853d-c89bc08160d2@codeaurora.org>
Date:   Fri, 16 Jul 2021 14:59:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1626412425-30715-2-git-send-email-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/16/2021 10:43 AM, Rajendra Nayak wrote:
> Some devics within power domains with performance states do not
> support DVFS, but still need to vote on a default/static state
> while they are active. They can express this using the 'required-opps'
> property in device tree, which points to the phandle of the OPP
> supported by the corresponding power-domains.
> 
> Add support to parse this information from DT and then set the
> specified performance state during attach and drop it on detach.
> Also drop/set as part of runtime suspend/resume callbacks.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>   drivers/base/power/domain.c | 29 ++++++++++++++++++++++++++++-
>   include/linux/pm_domain.h   |  1 +
>   2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a934c67..eef5507 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -917,6 +917,10 @@ static int genpd_runtime_suspend(struct device *dev)
>   	if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
>   		return 0;
>   
> +	/* Drop the default performance state */
> +	if (dev_gpd_data(dev)->default_pstate)
> +		dev_pm_genpd_set_performance_state(dev, 0);
> +
>   	genpd_lock(genpd);
>   	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>   	genpd_power_off(genpd, true, 0);
> @@ -937,6 +941,7 @@ static int genpd_runtime_resume(struct device *dev)
>   {
>   	struct generic_pm_domain *genpd;
>   	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> +	unsigned int default_pstate = gpd_data->default_pstate;
>   	struct gpd_timing_data *td = &gpd_data->td;
>   	bool runtime_pm = pm_runtime_enabled(dev);
>   	ktime_t time_start;
> @@ -968,6 +973,9 @@ static int genpd_runtime_resume(struct device *dev)
>   	if (ret)
>   		return ret;
>   
> +	/* Set the default performance state */
> +	if (default_pstate)
> +		dev_pm_genpd_set_performance_state(dev, default_pstate);
>    out:
>   	/* Measure resume latency. */
>   	time_start = 0;
> @@ -1000,6 +1008,8 @@ static int genpd_runtime_resume(struct device *dev)
>   	genpd_stop_dev(genpd, dev);
>   err_poweroff:
>   	if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
> +		if (default_pstate)
> +			dev_pm_genpd_set_performance_state(dev, 0);
>   		genpd_lock(genpd);
>   		gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>   		genpd_power_off(genpd, true, 0);
> @@ -2598,6 +2608,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>   
>   	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>   
> +	/* Drop the default performance state */
> +	if (dev_gpd_data(dev)->default_pstate) {
> +		dev_pm_genpd_set_performance_state(dev, 0);
> +		dev_gpd_data(dev)->default_pstate = 0;
> +	}
> +
>   	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
>   		ret = genpd_remove_device(pd, dev);
>   		if (ret != -EAGAIN)
> @@ -2635,9 +2651,10 @@ static void genpd_dev_pm_sync(struct device *dev)
>   static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>   				 unsigned int index, bool power_on)
>   {
> +	struct device_node *np;
>   	struct of_phandle_args pd_args;
>   	struct generic_pm_domain *pd;
> -	int ret;
> +	int ret, pstate;
>   
>   	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>   				"#power-domain-cells", index, &pd_args);
> @@ -2678,6 +2695,16 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>   	if (ret)
>   		genpd_remove_device(pd, dev);
>   
> +	/* Set the default performance state */
> +	np = base_dev->of_node;
> +	if (of_parse_phandle(np, "required-opps", index)) {
> +		pstate = of_get_required_opp_performance_state(np, index);
> +		if (pstate > 0) {
> +			dev_pm_genpd_set_performance_state(dev, pstate);
> +			dev_gpd_data(dev)->default_pstate = pstate;
> +		}
> +	}

I realized this needs better error handling after I sent it out,
I'll fix and respin.

> +
>   	return ret ? -EPROBE_DEFER : 1;
>   }
>   
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 21a0577..67017c9 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -198,6 +198,7 @@ struct generic_pm_domain_data {
>   	struct notifier_block *power_nb;
>   	int cpu;
>   	unsigned int performance_state;
> +	unsigned int default_pstate;
>   	unsigned int rpm_pstate;
>   	ktime_t	next_wakeup;
>   	void *data;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
