Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5A2E9916
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 16:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbhADPoz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 10:44:55 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:64265 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhADPoz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 10:44:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609775068; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=2kEW574552axvFTCX0ca3UBgxKZWAVavVS+i5XjTR2E=; b=NJlLxXeKDowgeeD1iRzqlj1CzMeAvz36UBU50RaLgp/QaC+W3473NB8O1FHU/FsA80z4qEG+
 5CO6UQbcTAEDYFgU1LYOVq1Ww2aWd/MCYQOSjpppZW4vCdKiOGohu23xOJXK3GYUs9Gtmrft
 iexIIJYkPHxgpa/7pT58uKT1buk=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ff337a31f36cf41df4b098d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 04 Jan 2021 15:43:31
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B48F6C43461; Mon,  4 Jan 2021 15:43:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9029BC433C6;
        Mon,  4 Jan 2021 15:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9029BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 4 Jan 2021 08:43:28 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] PM / domains: inform PM domain of a device's next
 wakeup
Message-ID: <X/M3oB292GCO4vl9@codeaurora.org>
References: <20201130225039.15981-1-ilina@codeaurora.org>
 <20201130225039.15981-3-ilina@codeaurora.org>
 <CAPDyKFphczBOyDmSQBh3PE7YaUBYy4Y5uoozrv4QOf4pEbk-yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFphczBOyDmSQBh3PE7YaUBYy4Y5uoozrv4QOf4pEbk-yg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 22 2020 at 06:10 -0700, Ulf Hansson wrote:
>On Mon, 30 Nov 2020 at 23:51, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> Some devices may have a predictable interrupt pattern while executing
>> usecases. An example would be the VSYNC interrupt associated with
>> display devices. A 60 Hz display could cause a interrupt every 16 ms. If
>> the device were in a PM domain, the domain would need to be powered up
>> for device to resume and handle the interrupt.
>>
>> Entering a domain idle state saves power, only if the residency of the
>> idle state is met. Without knowing the idle duration of the domain, the
>> governor would just choose the deepest idle state that matches the QoS
>> requirements. The domain might be powered off just as the device is
>> expecting to wake up. If devices could inform PM frameworks of their
>> next event, the parent PM domain's idle duration can be determined.
>>
>> So let's add the dev_pm_genpd_set_next_wakeup() API for the device to
>> inform PM domains of the impending wakeup. This information will be the
>> domain governor to determine the best idle state given the wakeup.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v6:
>>         - Update documentation
>> Changes in v5:
>>         - Fix commit text as pointed by Ulf
>>         - Use -EOPNOTSUPP
>> Changes in v4:
>>         - Use PM domain data to store next_wakeup
>>         - Drop runtime PM documentation
>> Changes in v3:
>>         - Fix unwanted change
>> Changes in v2:
>>         - Update documentation
>>         - Remove runtime PM enabled check
>>         - Update commit text
>> ---
>>  drivers/base/power/domain.c | 41 +++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   |  8 ++++++++
>>  2 files changed, 49 insertions(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 1e6c0bf1c945..191539a8e06d 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -408,6 +408,46 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
>>
>> +/**
>> + * dev_pm_genpd_set_next_wakeup - Notify PM framework of an impending wakeup.
>> + *
>> + * @dev: Device to handle
>> + * @next: impending interrupt/wakeup for the device
>> + *
>> + * Allow devices to inform of the next wakeup. But, if the domain were already
>> + * powered off, we will not wakeup the domain to recompute it's idle duration.
>
>How about clarifying this as:
>
>"It's assumed that the users guarantee that the genpd wouldn't be
>detached while this routine is getting called. Additionally, it's also
>assumed that @dev isn't runtime suspended (RPM_SUSPENDED).
>
Sure.

>> + * Although devices are expected to update the next_wakeup after the end of
>> + * their usecase as well, it is possible the devices themselves may not know
>> + * about that. Stale @next will be ignored when powering off the domain.
>> + */
>> +int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
>> +{
>> +       struct generic_pm_domain *genpd;
>> +       struct generic_pm_domain_data *gpd_data;
>> +       int ret = -EINVAL;
>> +
>> +       genpd = dev_to_genpd_safe(dev);
>> +       if (!genpd)
>> +               return -ENODEV;
>> +
>> +       if (WARN_ON(!dev->power.subsys_data ||
>> +                   !dev->power.subsys_data->domain_data))
>> +               return ret;
>> +
>> +       genpd_lock(genpd);
>> +       gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
>> +       if (ktime_before(ktime_get(), next)) {
>> +               gpd_data->next_wakeup = next;
>> +               genpd->flags |= GENPD_FLAG_GOV_NEXT_WAKEUP;
>
>I don't think we should set this here, but instead leave this to be
>set by the genpd provider at initialization.
>
But, we don't want it to be enabled by default. It is possible that
domains may have multiple idle states but none of the devices in the
domain have the need for next wakeup. We could optimize out the next
wakeup for those cases.
Or, the domain needs to call genpd_enable_next_wakeup() (patch #1) to
allow this feature. Is that acceptable?

>> +               ret = 0;
>> +       }
>> +       genpd_unlock(genpd);
>
>I would suggest to simplify the above into:
>
>gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
>gpd_data->next_wakeup = next;
>
>Then there is no need for locks because:
>*) We assume the device remains attached to the genpd.
>**) The device isn't runtime suspended, hence its corresponding genpd
>is powered on and thus the genpd governor can't be looking at
>"gpd_data->next_wakeup" simulantfsfulsy.
>
:)
>Moreover, as we agreed to ignore stale values for "next", there is no
>reason to validate it against the current ktime, so let's just skip
>it.
>
Okay.

>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
>> +
>> +
>>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>>  {
>>         unsigned int state_idx = genpd->state_idx;
>> @@ -1450,6 +1490,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
>>         gpd_data->td.constraint_changed = true;
>>         gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>>         gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
>> +       gpd_data->next_wakeup = KTIME_MAX;
>
>When looking at patch3, I wonder if it perhaps could be easier to use
>"zero" as the default value? What do you think, just an idea?
>
Hmm.. Let me think it over.

Thanks,
Lina

>>
>>         spin_lock_irq(&dev->power.lock);
>>
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 1f359bd19f77..cc27d3d88849 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -9,6 +9,7 @@
>>  #define _LINUX_PM_DOMAIN_H
>>
>>  #include <linux/device.h>
>> +#include <linux/ktime.h>
>>  #include <linux/mutex.h>
>>  #include <linux/pm.h>
>>  #include <linux/err.h>
>> @@ -197,6 +198,7 @@ struct generic_pm_domain_data {
>>         struct notifier_block *power_nb;
>>         int cpu;
>>         unsigned int performance_state;
>> +       ktime_t next_wakeup;
>>         void *data;
>>  };
>>
>> @@ -229,6 +231,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>>  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>>  int dev_pm_genpd_remove_notifier(struct device *dev);
>>  void genpd_enable_next_wakeup(struct generic_pm_domain *genpd, bool enable);
>> +int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
>>
>>  extern struct dev_power_governor simple_qos_governor;
>>  extern struct dev_power_governor pm_domain_always_on_gov;
>> @@ -291,6 +294,11 @@ static void genpd_enable_next_wakeup(struct generic_pm_domain *genpd,
>>                                      bool enable)
>>  { }
>>
>> +static inline int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
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
