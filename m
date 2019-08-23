Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6319E9B5DD
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 19:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404598AbfHWRv3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 13:51:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44645 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404583AbfHWRv3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 13:51:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so11972066qtg.11
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 10:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xWUh9AvHNgLqrzxP/xK+WD24eUE59TC5eLQx78jgBig=;
        b=ltlZcnzqsGrvGraphXnSGhOZU9Su4FtVODn/08MzZ/PLBuyVb0fE/4X+SuFpZlLJzF
         MxEabPuCHGK1xwCDsDumBc7cObKXfC3/kaZKjiR8o6phye0YfVmD96EB+64NQdAuU9GE
         UMjYCyVyzQpIQ18UyaTWAunDfdMTQwGc6xc0RVekX01EVhXtO9SIvJsUeK3UjKNIp/oh
         NfBP8+KB5giIZVgzydEE1mWL2JzQmx0cTzIJP6wviS7wJpapdesVwwfBQ8Y+RhSh5AAY
         y7D1aFxw/tHbIUk4kQfB3irHk0RTzT1oIVbFh104vxdWTyWOr4o+mKlF8D4wfFhEsf/8
         D7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xWUh9AvHNgLqrzxP/xK+WD24eUE59TC5eLQx78jgBig=;
        b=UOGTt5RcERuUdPH+9lPeBgmS9wENpj4jjj2nbE/ZAapXhUQC8Ex97nEpQloTOcLHaN
         oMpe0SoXyEajUWmgNjZfTgUfxfd7kLhDqSpnsU250n9TTzBbvySD+GbWzEcMVABDhCEC
         MqoF2UHxWCsDVNJ/dmWApIxmZzd9Slvg+gwXqEy6gzGZfc9239/xVtRq1g6kIcVK98r3
         DtxaFPCrlZx3ykmAraJ1nA4Os+NTsyR1OP/t4rOKqYSDQZ8BDhWz+CViTjJO47uXUq/J
         oa+L9sGh18IoyOr9x1fQLp4Ut0s2ypgqKjPU6HbKBxdThTbkEtdBd94oG83EVwa24nbH
         eNWw==
X-Gm-Message-State: APjAAAUKFVrURwKLqUwRRAA9hcXdP5nrLIRZxKasyQ6fd5hvWFbtnOuJ
        uzvu7bF8Ix+wvwNhuZXeg+chlA==
X-Google-Smtp-Source: APXvYqyVD83AxBOV7BBR/pe1On+XIisUiaK/3kXjReFioJwdBo2QaNtWVS6Mtz7Jz9IbudfQeTJjKg==
X-Received: by 2002:ac8:60c5:: with SMTP id i5mr5932695qtm.72.1566582688033;
        Fri, 23 Aug 2019 10:51:28 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id 136sm1786848qkg.96.2019.08.23.10.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 10:51:27 -0700 (PDT)
Subject: Re: [PATCH 3/4] thermal: qcom: Add RPMHPD cooling device driver.
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
 <1565398727-23090-4-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFoj=f4+r=PaRq-EEZjVooYGCy6k1crepS2TChgcHD0WRQ@mail.gmail.com>
Cc:     qualcomm-lt@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5D60279E.1020601@linaro.org>
Date:   Fri, 23 Aug 2019 13:51:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoj=f4+r=PaRq-EEZjVooYGCy6k1crepS2TChgcHD0WRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/22/2019 11:19 AM, Ulf Hansson wrote:
> On Sat, 10 Aug 2019 at 02:58, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> The MX power domain in RPMH can be used to warm the
>> the SoC in SDM845. To support this feature, introduce
>> a RPMH power domain cooling device driver that can be
>> plugged into the thermal framework.(The thermal framework
>> itself requires further modifiction to support a warming
>> device in place of a cooling device. Those extensions are
>> not introduced in this patch series).
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  drivers/thermal/qcom/Kconfig            |   7 ++
>>  drivers/thermal/qcom/Makefile           |   1 +
>>  drivers/thermal/qcom/qcom-rpmhpd-cdev.c | 141 ++++++++++++++++++++++++++++++++
>>  3 files changed, 149 insertions(+)
>>  create mode 100644 drivers/thermal/qcom/qcom-rpmhpd-cdev.c
>>
>> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
>> index aa9c1d8..a540130 100644
>> --- a/drivers/thermal/qcom/Kconfig
>> +++ b/drivers/thermal/qcom/Kconfig
>> @@ -20,3 +20,10 @@ config QCOM_SPMI_TEMP_ALARM
>>           trip points. The temperature reported by the thermal sensor reflects the
>>           real time die temperature if an ADC is present or an estimate of the
>>           temperature based upon the over temperature stage value.
>> +
>> +config CONFIG_QCOM_RPMHPD_CDEV
>> +       tristate "Qualcomm RPMHPD based cooling device"
>> +       depends on QCOM_RPMHPD
>> +       help
>> +         This enables RPMHPD based cooling devices. On SDM845, this is
>> +         MX power domain.
>> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
>> index 7c8dc6e..e4eb520 100644
>> --- a/drivers/thermal/qcom/Makefile
>> +++ b/drivers/thermal/qcom/Makefile
>> @@ -4,3 +4,4 @@ obj-$(CONFIG_QCOM_TSENS)        += qcom_tsens.o
>>  qcom_tsens-y                   += tsens.o tsens-common.o tsens-v0_1.o \
>>                                    tsens-8960.o tsens-v2.o tsens-v1.o
>>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)     += qcom-spmi-temp-alarm.o
>> +obj-$(CONFIG_QCOM_RPMHPD_CDEV)         += qcom-rpmhpd-cdev.o
>> diff --git a/drivers/thermal/qcom/qcom-rpmhpd-cdev.c b/drivers/thermal/qcom/qcom-rpmhpd-cdev.c
>> new file mode 100644
>> index 0000000..265523b
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qcom-rpmhpd-cdev.c
>> @@ -0,0 +1,141 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019, Linaro Ltd
>> + */
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/thermal.h>
>> +
>> +struct rpmhpd_cooling_device {
>> +       struct thermal_cooling_device *cdev;
>> +       struct device *pwr_domain;
>> +       int max_state;
>> +       int cur_state;
>> +       bool is_pwr_domain_on;
>> +};
>> +
>> +static const char sdm845_rpmhpd_cdev_name[] = "mx";
>> +
>> +static const struct of_device_id rpmhpd_cdev_match_table[] = {
>> +       { .compatible = "qcom,sdm845-rpmhpd-cdev", .data = &sdm845_rpmhpd_cdev_name },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, rpmhpd_cdev_match_table);
>> +
>> +static int rpmhpd_cdev_get_max_state(struct thermal_cooling_device *cdev,
>> +                                    unsigned long *state)
>> +{
>> +       struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
>> +
>> +       *state = rpmhpd_cdev->max_state;
>> +       return 0;
>> +}
>> +
>> +static int rpmhpd_cdev_get_cur_state(struct thermal_cooling_device *cdev,
>> +                                    unsigned long *state)
>> +{
>> +       struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
>> +       int perf_state;
>> +
>> +       dev_pm_genpd_get_performance_state(rpmhpd_cdev->pwr_domain,
>> +                                          &perf_state);
>> +       *state = perf_state;
>> +       return 0;
>> +}
>> +
>> +static int rpmhpd_cdev_set_cur_state(struct thermal_cooling_device *cdev,
>> +                                    unsigned long state)
>> +{
>> +       struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
>> +       struct device *pwr_domain = rpmhpd_cdev->pwr_domain;
> 
> Nitpick: Using pwr_domain as the name of the variable is a bit
> confusing. Why not just name it "dev"?

Sure! I will change it.

> 
>> +       int ret;
>> +
>> +       ret = dev_pm_genpd_set_performance_state(pwr_domain, state);
>> +
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (state && !rpmhpd_cdev->is_pwr_domain_on) {
> 
> Nitpick: To clarify, I would suggest to rename "is_pwr_domain_on" to
> "runtime_resumed".

Done!

> 
>> +               ret = pm_runtime_get_sync(pwr_domain);
>> +               rpmhpd_cdev->is_pwr_domain_on = true;
>> +       } else if (!state && rpmhpd_cdev->is_pwr_domain_on) {
>> +               ret = pm_runtime_put(pwr_domain);
>> +               rpmhpd_cdev->is_pwr_domain_on = false;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static struct thermal_cooling_device_ops rpmhpd_cooling_device_ops = {
>> +       .get_max_state = rpmhpd_cdev_get_max_state,
>> +       .get_cur_state = rpmhpd_cdev_get_cur_state,
>> +       .set_cur_state = rpmhpd_cdev_set_cur_state,
>> +};
>> +
>> +static int rpmhpd_cdev_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev, *pd_dev;
>> +       struct rpmhpd_cooling_device *rpmhpd_cdev;
>> +       const char *rpmhpd_cdev_name = of_device_get_match_data(dev);
>> +       unsigned int count;
>> +       int ret;
>> +
>> +       if (!dev->pm_domain) {
>> +               pd_dev = dev_pm_domain_attach_by_name(dev, rpmhpd_cdev_name);
> 
> I don't think this is needed, unless you have multiple PM domains that
> can be attached per device.
> 
> If there is only one PM domain the platform bus should already have
> attached it at this point.

I agree. I realized after sending the patches out. I will remove this at
this point. If there is a need to have multiple power domains , we can
add it back later. There is more changes needed in the driver to support
multiple power domains anyways.

> 
>> +               if (IS_ERR(pd_dev))
>> +                       return PTR_ERR(pd_dev);
>> +       } else {
>> +               pd_dev = dev;
>> +       }
>> +
>> +       rpmhpd_cdev = devm_kzalloc(dev, sizeof(*rpmhpd_cdev), GFP_KERNEL);
>> +       if (!rpmhpd_cdev) {
>> +               ret = -ENOMEM;
>> +               goto detach_pd;
>> +       }
>> +
>> +       ret = dev_pm_genpd_performance_state_count(pd_dev, &count);
>> +       if (ret)
>> +               goto detach_pd;
>> +
>> +       rpmhpd_cdev->pwr_domain = pd_dev;
>> +       rpmhpd_cdev->max_state = count - 1;
>> +       rpmhpd_cdev->is_pwr_domain_on = false;
>> +
>> +       pm_runtime_enable(pd_dev);
>> +
>> +       rpmhpd_cdev->cdev = thermal_of_cooling_device_register
>> +                                       (dev->of_node, rpmhpd_cdev_name,
>> +                                        rpmhpd_cdev,
>> +                                        &rpmhpd_cooling_device_ops);
>> +       if (IS_ERR(rpmhpd_cdev->cdev)) {
>> +               dev_err(dev, "unable to register %s cooling device\n",
>> +                       rpmhpd_cdev_name);
>> +               ret = PTR_ERR(rpmhpd_cdev->cdev);
>> +               goto detach_pd;
>> +       }
>> +
>> +       return 0;
>> +
>> +detach_pd:
>> +       dev_pm_domain_detach(pd_dev, false);
> 
> Not needed, see above.
> 
>> +       return ret;
>> +}
>> +
>> +static struct platform_driver rpmhpd_cdev_driver = {
>> +       .driver = {
>> +               .name = "qcom-rpmhpd-cdev",
>> +               .of_match_table = rpmhpd_cdev_match_table,
>> +       },
>> +       .probe = rpmhpd_cdev_probe,
> 
> Looks like you should implement a ->remove() callback as well. Or
> perhaps you think this should be a built-in-driver?

Mmm.. I think I will add a remove.

Regards
Thara
> 
>> +};
>> +module_platform_driver(rpmhpd_cdev_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm RPMHPD cooling device driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.1.4
>>
> 
> Kind regards
> Uffe
> 


-- 
Regards
Thara
