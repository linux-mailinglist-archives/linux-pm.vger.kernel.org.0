Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53AF653F3
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfGKJkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 05:40:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55176 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfGKJkG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 05:40:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ACBC960159; Thu, 11 Jul 2019 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562838004;
        bh=0ssG2GNR8L/+/10jXcM2XYnH8GTmRCIhHCfYEyrmC/k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EIiddrbXCHEs/KMWWFvs3Rn7jxtmZW0YCwgZ1sNths5dqmNLuEM2UgniiotNdE6qJ
         OSthxSlePOoiEjm9i2Gd9NlpIvr2EQVhTf/HMW8UZaC9MgSiP9CF01JmIrEJCaQX2+
         eIuNTlGnCAcQatuYRUPy3kdfWAew8D9r7raUiBxU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.43.141] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5AA8060159;
        Thu, 11 Jul 2019 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562838003;
        bh=0ssG2GNR8L/+/10jXcM2XYnH8GTmRCIhHCfYEyrmC/k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Zu0TjO2NTVBlKFtxKpxwS3EHPfiDH1CyM/Z/AQ/N8KJoe6XxRg6o3y3E+bTYaXOcL
         MKHEiEXpIGm3xyECqSUcpxgEk9WT1xdSHpG0Ku9u055z2ylCI4YVCvjS3BMSVfms4b
         ryChf+200QeX18UmQRIRcj3qMReo3JqYG4wArnIQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AA8060159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] opp: Return genpd virtual devices from
 dev_pm_opp_attach_genpd()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <2ed7993d-523b-270a-2be9-83ad2426e946@codeaurora.org>
Date:   Thu, 11 Jul 2019 15:09:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/8/2019 11:30 AM, Viresh Kumar wrote:
> The cpufreq drivers don't need to do runtime PM operations on the
> virtual devices returned by dev_pm_domain_attach_by_name() and so the
> virtual devices weren't shared with the callers of
> dev_pm_opp_attach_genpd() earlier.
> 
> But the IO device drivers would want to do that. This patch updates the
> prototype of dev_pm_opp_attach_genpd() to accept another argument to
> return the pointer to the array of genpd virtual devices.
> 
> Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> @Rajendra: Can you please test this one ? I have only compile tested it.

Sorry for the delay, I seem to have completely missed this patch.
I just gave this a try and here are some observations,

I have a case where I have one device with 2 power domains, one of them
is scale-able (supports perf state) and the other one supports only being
turned on and off.

1. In the driver I now need to use dev_pm_domain_attach_by_name/id to attach the
power domain which supports only on/off and then use dev_pm_opp_attach_genpd()
for the one which supports perf states.

2. My OPP table has only 1 required_opps, so the required_opp_count for the OPP table is 1.
Now if my device tree has my scale-able powerdomain at index 1 (it works if its at index 0)
then I end up with this error

[    2.858628] ufshcd-qcom 1d84000.ufshc: Index can't be greater than required-opp-count - 1, rpmh_pd (1 : 1)

so it looks like a lot of the OPP core today just assumes that if a device has multiple power domains,
all of them are scale-able which isn't necessarily true.

> 
>   drivers/opp/core.c     | 5 ++++-
>   include/linux/pm_opp.h | 4 ++--
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2958cc7bbb58..07b6f1187b3b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1775,6 +1775,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>    * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
>    * @dev: Consumer device for which the genpd is getting attached.
>    * @names: Null terminated array of pointers containing names of genpd to attach.
> + * @virt_devs: Pointer to return the array of virtual devices.
>    *
>    * Multiple generic power domains for a device are supported with the help of
>    * virtual genpd devices, which are created for each consumer device - genpd
> @@ -1789,7 +1790,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>    * This helper needs to be called once with a list of all genpd to attach.
>    * Otherwise the original device structure will be used instead by the OPP core.
>    */
> -struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
> +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
> +		const char **names, struct device ***virt_devs)
>   {
>   	struct opp_table *opp_table;
>   	struct device *virt_dev;
> @@ -1850,6 +1852,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
>   		name++;
>   	}
>   
> +	*virt_devs = opp_table->genpd_virt_devs;
>   	mutex_unlock(&opp_table->genpd_virt_dev_lock);
>   
>   	return opp_table;
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index be570761b77a..7c2fe2952f40 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -131,7 +131,7 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
>   void dev_pm_opp_put_clkname(struct opp_table *opp_table);
>   struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
>   void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
> -struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
> +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
>   void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
>   int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>   int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
> @@ -295,7 +295,7 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
>   
>   static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
>   
> -static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
> +static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs)
>   {
>   	return ERR_PTR(-ENOTSUPP);
>   }
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
