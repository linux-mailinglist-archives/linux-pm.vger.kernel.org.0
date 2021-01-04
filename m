Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC10E2E9945
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 16:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhADPzS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 10:55:18 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:62872 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbhADPzM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 10:55:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609775686; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=YzxHGoqkp22rvV2IgBjDOAwXv5FnJaahbGgEp3/YMzg=; b=B9VRxbaLlv+lPiNAlQWm9vWiPs/0NuSh4VE0dHqswbLeEVj999n6+abOsua9eZLE9br4ns5O
 XEFTJRImNLR2fZUqygSI1NzRJccq1PQtDO6QQ2L55/t5SWiOSG6tk4r8iJ193fO1zxf22Kxd
 JrRDIced6WbbCpk2B1VvwUnvaBk=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ff33a2cb4d9fe55c1582ec2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 04 Jan 2021 15:54:20
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF861C43461; Mon,  4 Jan 2021 15:54:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03931C433CA;
        Mon,  4 Jan 2021 15:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03931C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 4 Jan 2021 08:54:18 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] PM / Domains: add domain feature flag for next
 wakeup
Message-ID: <X/M6KheIV5ES68V1@codeaurora.org>
References: <20201130225039.15981-1-ilina@codeaurora.org>
 <20201130225039.15981-2-ilina@codeaurora.org>
 <CAPDyKFr0+Hzod+cq1gBN66O-Tvt5RAB2aK=rzcqGaPF41TMRnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFr0+Hzod+cq1gBN66O-Tvt5RAB2aK=rzcqGaPF41TMRnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 22 2020 at 06:07 -0700, Ulf Hansson wrote:
>On Mon, 30 Nov 2020 at 23:51, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> PM domains may support entering multiple power down states when the
>> component devices and sub-domains are suspended. Also, they may specify
>> the residency value for an idle state, only after which the idle state
>> may provide power benefits. If the domain does not specify the residency
>> for any of its idle states, the governor's choice is much simplified.
>>
>> Let's make this optional with the use of a PM domain feature flag.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v6:
>>         - New patch based on discussions on v5 of the series
>> ---
>>  drivers/base/power/domain.c | 18 ++++++++++++++++++
>>  include/linux/pm_domain.h   | 28 ++++++++++++++++++++++------
>>  2 files changed, 40 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 1b0c9ccbbe1f..1e6c0bf1c945 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1748,6 +1748,24 @@ int dev_pm_genpd_remove_notifier(struct device *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_genpd_remove_notifier);
>>
>> +/**
>> + * genpd_enable_next_wakeup - Enable genpd gov to use next_wakeup
>> + *
>> + * @genpd: The genpd to be updated
>> + * @enable: Enable/disable genpd gov to use next wakeup
>> + */
>> +void genpd_enable_next_wakeup(struct generic_pm_domain *genpd, bool enable)
>> +{
>> +       genpd_lock(genpd);
>> +       if (enable)
>> +               genpd->flags |= GENPD_FLAG_GOV_NEXT_WAKEUP;
>> +       else
>> +               genpd->flags &= ~GENPD_FLAG_GOV_NEXT_WAKEUP;
>> +       genpd->next_wakeup = KTIME_MAX;
>> +       genpd_unlock(genpd);
>> +}
>> +EXPORT_SYMBOL_GPL(genpd_enable_next_wakeup);
>> +
>
>Please drop this, as I don't think we need a dedicated function to
>enable this feature.
>
Ah, I responded to the patch #2 regarding this before reading this
email.

>Instead, it seems like a better idea to let the genpd provider set it,
>before it calls pm_genpd_init(), along with its other genpd
>configurations.
>
If we no longer have a need for this feature in the domain, we could
dynamically disable it.

>>  static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>>                                struct generic_pm_domain *subdomain)
>>  {
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 2ca919ae8d36..1f359bd19f77 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -55,13 +55,19 @@
>>   *
>>   * GENPD_FLAG_RPM_ALWAYS_ON:   Instructs genpd to always keep the PM domain
>>   *                             powered on except for system suspend.
>> + *
>> + * GENPD_FLAG_GOV_NEXT_WAKEUP: Enable the genpd governor to consider its
>> + *                             components' next wakeup when  determining the
>> + *                             optimal idle state. This is setup only if the
>> + *                             domain's idle state specifies a residency.
>>   */
>> -#define GENPD_FLAG_PM_CLK       (1U << 0)
>> -#define GENPD_FLAG_IRQ_SAFE     (1U << 1)
>> -#define GENPD_FLAG_ALWAYS_ON    (1U << 2)
>> -#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
>> -#define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
>> -#define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
>> +#define GENPD_FLAG_PM_CLK         (1U << 0)
>> +#define GENPD_FLAG_IRQ_SAFE       (1U << 1)
>> +#define GENPD_FLAG_ALWAYS_ON      (1U << 2)
>> +#define GENPD_FLAG_ACTIVE_WAKEUP   (1U << 3)
>> +#define GENPD_FLAG_CPU_DOMAIN     (1U << 4)
>> +#define GENPD_FLAG_RPM_ALWAYS_ON   (1U << 5)
>> +#define GENPD_FLAG_GOV_NEXT_WAKEUP (1U << 6)
>
>Nitpick.
>
>To me, the configuration is something that corresponds to the genpd,
>rather than the governor (even if it affects it in this case). That
>said, how about just naming the flag something like
>"GENPD_FLAG_MIN_RESIDENCY", as to indicate that the genpd's power off
>states have minimum residencies values that may deserve to be
>considered, while power off.
>
Hmmm..
>>
>>  enum gpd_status {
>>         GENPD_STATE_ON = 0,     /* PM domain is on */
>> @@ -205,6 +211,11 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
>>         return to_gpd_data(dev->power.subsys_data->domain_data);
>>  }
>>
>> +static inline bool genpd_may_use_next_wakeup(struct generic_pm_domain *genpd)
>> +{
>> +       return genpd->flags & GENPD_FLAG_GOV_NEXT_WAKEUP;
>> +}
>
>This can probably be moved into drivers/base/power/domain_governor.c.
>
Okay.
>> +
>>  int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev);
>>  int pm_genpd_remove_device(struct device *dev);
>>  int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>> @@ -217,6 +228,7 @@ int pm_genpd_remove(struct generic_pm_domain *genpd);
>>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>>  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>>  int dev_pm_genpd_remove_notifier(struct device *dev);
>> +void genpd_enable_next_wakeup(struct generic_pm_domain *genpd, bool enable);
>>
>>  extern struct dev_power_governor simple_qos_governor;
>>  extern struct dev_power_governor pm_domain_always_on_gov;
>> @@ -275,6 +287,10 @@ static inline int dev_pm_genpd_remove_notifier(struct device *dev)
>>         return -EOPNOTSUPP;
>>  }
>>
>> +static void genpd_enable_next_wakeup(struct generic_pm_domain *genpd,
>> +                                    bool enable)
>> +{ }
>> +
>>  #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>>  #define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>>  #endif
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
>
>Kind regards
>Uffe
