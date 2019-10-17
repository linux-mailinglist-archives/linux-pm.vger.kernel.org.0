Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4FDB164
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfJQPqF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 11:46:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41998 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392654AbfJQPqF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 11:46:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so2285729qkl.9
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=EInTdxDjDLXDstDiLqEeeyfhKiB3PsTEBGK0hKU+4QE=;
        b=wcVh7+FmV6UtER8BX9mpGqMwW+bqm65EPR2eJoBAs1jnfHWhQLDWZ4G1vTJIZzH2fl
         2hlOplz2HcgHYUJ2f3gQ1zfzcCpHk1V5W7mtExYsVRW0bP9l0a0SPET/eGjkp4bpOuhs
         q9sYFFXTLNJHQbO4lhkdccjbVG88CGWl2Ag2wtKlm9//XT4savE30zoQuS2XAjbS71fC
         BE9VosMPbMWj6Vt0IPfTHjuSUdeLHrg+ss2T8PWZCOAZLGJZSDfwU3hUoz3X0p6CVH49
         XStCqwW5j6yPp8l+IvM/gyblpTMvdVsHVS061meUaBMxIlhipFooO32mB55u7/bH65sj
         n4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=EInTdxDjDLXDstDiLqEeeyfhKiB3PsTEBGK0hKU+4QE=;
        b=TD7Cw4FWbG8pJ9dxGz3tAmuh7KZ+5FiZXv17dBn5sKVREqk+91JfdvxyEe58mGrh1P
         vOiMmZienHT7TVDlMfvkRyedNsVLUM+OSPVLEpakeEQ42fbmdf4kzPl43a9AjRb80VUu
         Sl3Fnro10T0TpFL3gf3c2oUnh+y4O/D+x5YAFVMzca9U9iKybyQAlIroXDZkApRF7We3
         eWCxSjhmBG/Y/otS/BUgdnBDCEAxruyRcV7HMXL9tfyAkt5Py5Q1X5i40JBWqrT840AK
         b4s95dCJn9BLWNPXlbk94BVc76MLuhSOTIvXcp0NnswurbItG7cpxrKBhGfFWtndeTK7
         Etqw==
X-Gm-Message-State: APjAAAV5qo0dZ55cl05X17xO+PLnOlzVwD3rA7RzUGM17p/aVBrEbL9t
        PoLzqsQBUDjRZm1ijTbPlA8YjQ==
X-Google-Smtp-Source: APXvYqyMqSPDwxxgLHQmRTWCNlphdMU4ZzB6zFKuw8LoEBzOqtqxKtvcCaysEGKiP/O5TUD+Hffjgw==
X-Received: by 2002:ae9:e513:: with SMTP id w19mr3920393qkf.308.1571327162320;
        Thu, 17 Oct 2019 08:46:02 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id c126sm1360612qkd.13.2019.10.17.08.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 08:46:01 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] thermal: Add generic power domain warming device
 driver.
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-5-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFoOpxWWhbr0ZSmuKEoqx=qoZ2ksLO9QodyhWU35tPVX6w@mail.gmail.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DA88CB8.6050206@linaro.org>
Date:   Thu, 17 Oct 2019 11:46:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoOpxWWhbr0ZSmuKEoqx=qoZ2ksLO9QodyhWU35tPVX6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/17/2019 04:47 AM, Ulf Hansson wrote:
> On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Resources modeled as power domains in linux kenrel
>> can  be used to warm the SoC(eg. mx power domain on sdm845).
>> To support this feature, introduce a generic power domain
>> warming device driver that can be plugged into the thermal framework
>> (The thermal framework itself requires further modifiction to
>> support a warming device in place of a cooling device.
>> Those extensions are not introduced in this patch series).
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  drivers/thermal/Kconfig              |  10 +++
>>  drivers/thermal/Makefile             |   2 +
>>  drivers/thermal/pwr_domain_warming.c | 136 +++++++++++++++++++++++++++++++++++
>>  include/linux/pwr_domain_warming.h   |  31 ++++++++
>>  4 files changed, 179 insertions(+)
>>  create mode 100644 drivers/thermal/pwr_domain_warming.c
>>  create mode 100644 include/linux/pwr_domain_warming.h
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 001a21a..0c5c93e 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -187,6 +187,16 @@ config DEVFREQ_THERMAL
>>
>>           If you want this support, you should say Y here.
>>
>> +config PWR_DOMAIN_WARMING_THERMAL
>> +       bool "Power Domain based warming device"
>> +       depends on PM_GENERIC_DOMAINS_OF
>> +       help
>> +         This implements the generic power domain based warming
>> +         mechanism through increasing the performance state of
>> +         a power domain.
>> +
>> +         If you want this support, you should say Y here.
>> +
>>  config THERMAL_EMULATION
>>         bool "Thermal emulation mode support"
>>         help
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 74a37c7..382c64a 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -27,6 +27,8 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)   += clock_cooling.o
>>  # devfreq cooling
>>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>>
>> +thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)       += pwr_domain_warming.o
>> +
>>  # platform thermal drivers
>>  obj-y                          += broadcom/
>>  obj-$(CONFIG_THERMAL_MMIO)             += thermal_mmio.o
>> diff --git a/drivers/thermal/pwr_domain_warming.c b/drivers/thermal/pwr_domain_warming.c
>> new file mode 100644
>> index 0000000..60fae3e
>> --- /dev/null
>> +++ b/drivers/thermal/pwr_domain_warming.c
>> @@ -0,0 +1,136 @@
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
>> +#include <linux/pm_runtime.h>
>> +#include <linux/slab.h>
>> +#include <linux/pwr_domain_warming.h>
>> +
>> +struct pd_warming_device {
>> +       struct thermal_cooling_device *cdev;
>> +       struct generic_pm_domain *gpd;
> 
> No, this isn't a genpd provider and thus we should not need to carry
> the above pointer in the struct pd_warming_device.

I store this to attach the device in late_init. More about this
approach below.

> 
>> +       struct device *dev;
>> +       int max_state;
>> +       int cur_state;
>> +       bool runtime_resumed;
>> +};
>> +
>> +static int pd_wdev_get_max_state(struct thermal_cooling_device *cdev,
>> +                                unsigned long *state)
>> +{
>> +       struct pd_warming_device *pd_wdev = cdev->devdata;
>> +
>> +       *state = pd_wdev->max_state;
>> +       return 0;
>> +}
>> +
>> +static int pd_wdev_get_cur_state(struct thermal_cooling_device *cdev,
>> +                                unsigned long *state)
>> +{
>> +       struct pd_warming_device *pd_wdev = cdev->devdata;
>> +
>> +       *state = dev_pm_genpd_get_performance_state(pd_wdev->dev);
>> +
>> +       return 0;
>> +}
>> +
>> +static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
>> +                                unsigned long state)
>> +{
>> +       struct pd_warming_device *pd_wdev = cdev->devdata;
>> +       struct device *dev = pd_wdev->dev;
>> +       int ret;
>> +
>> +       ret = dev_pm_genpd_set_performance_state(dev, state);
>> +
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (state && !pd_wdev->runtime_resumed) {
>> +               ret = pm_runtime_get_sync(dev);
>> +               pd_wdev->runtime_resumed = true;
>> +       } else if (!state && pd_wdev->runtime_resumed) {
>> +               ret = pm_runtime_put(dev);
>> +               pd_wdev->runtime_resumed = false;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static int pd_wdev_late_init(struct thermal_cooling_device *cdev)
>> +{
>> +       struct pd_warming_device *pd_wdev = cdev->devdata;
>> +       struct device *dev = &cdev->device;
>> +       int state_count, ret;
>> +
>> +       ret = pm_genpd_add_device(pd_wdev->gpd, dev);
> 
> The pm_genpd_add_device() is a legacy interface and we are striving to
> remove it. I think there are two better options for you to use to deal
> with the attach thingy.
I was not aware of this. Apologies.
> 
> 1. The easiest one is probably just to convert into using
> of_genpd_add_device() instead. I think you already have the
> information that you need in the ->cdev pointer to do that. However,
> that also means you need to add the ->late_init() callback to the
> struct thermal_cooling_device_ops, like what you do here.
> 
> 2. Maybe the most correct solution is, rather than attaching
> &cdev->device to the PM domain, to register a separate new device
> (device_register()) and assign it the corresponding OF node as the
> genpd provider's subnode and then attach this one instead. If
> "power-domains" can be specified in the subnode, you can even use
> dev_pm_domain_attach() to attach the device to the PM domain, else
> of_genpd_add_device() should work. In the second step, when
> registering the cooling device, the new device above should be
> assigned as parent to the device that is about to be registered via
> thermal_of_cooling_device_register(). In other words, the
> thermal_of_cooling_device_register() needs to be extended to cope with
> receiving a parent device as an in-parameter, but that should be
> doable I think. In this way, you don't need to add the ->late_init()
> callback at all, but you can instead just use the parent device when
> operating on the PM domain.

I did toy with registering a separate device vs reusing cdev device.
My rational was, the power domain is actually controlled/needed by the
cdev and hence should be attached to it.
For me either solution is acceptable . It is a trade off between
creating a new device and registering it as a parent of cooling device
vs introducing a late init. With the second approach I should be able to
do away with the generic_pm_domain pointer in pd_warming_device. To
register a parent for a cooling device, I will have to introduce a new
API in the thermal framework. Like
thermal_of_cooling_device_parent_register. I am ok with this as well.

 I would like to hear on what some of the thermal maintainers/reviewers
have to say about both the approaches and which is better.

 I will wait a few days for others to review and if there are no major
comments, I will send across the series after updating it to the second
approach.

-- 
Warm Regards
Thara
