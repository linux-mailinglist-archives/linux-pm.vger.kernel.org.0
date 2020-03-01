Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D21750B5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 00:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCAXAG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 18:00:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37567 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgCAXAF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2020 18:00:05 -0500
Received: by mail-qk1-f194.google.com with SMTP id m9so8402116qke.4
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2020 15:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4XRXBMLfswElGthzyg0E7Y81nyO8pgBgTsiCR8yuSgc=;
        b=zMc6JRlgzRoL15hbFE0UuWcUNn5t+cMEZsMGJbfZfkyGC3Ge2SXwiA2mgXDETX+qKb
         lSO/khYjroRrITgYGfZpURi2NXhKdPqqJtW8YaiJAJUMHL6ApUFC9DHKM0wh9nH2XnIq
         rmSup6BcYRbwZE8LTou+6pEKpjwYArWHx38qzF8aCXdBtLVNNF87BMuIiKOE7FmSKKqu
         yIm6QUh024sqwDzdeOxVWCKDkRLIDqdSDbfgKNHjlVq5GPg1CdIYs2Lhj35tV8NDOA0v
         PhWr5dVGN/n2Zu3051108/htS58boP9oqreh7BzdcajsVixQIEUKxlaXSP/eehPxDN6n
         yMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4XRXBMLfswElGthzyg0E7Y81nyO8pgBgTsiCR8yuSgc=;
        b=SV+QpKTL5eOvPIWZYRGCeK4Q5X+0d6TCtOTa9OkfDoEUnzjzDsK5vLo0/pffcOTVq9
         9VZ8MUE6GNpzFKMCbTVL85kuMwED9eIk2pnotCmgwa/aV8sf45CnVTdSjHbTdvgyxmKM
         1AWw+PAhnUKxoqqoJ/Bh9QzH5Oqj30iWu1amEgMLvW/m8diLFgSGsHvXIYFeCJpxok86
         wxxjtB7crPvrkzy8H34i1i47V+A6Rced+x+hBMGyJWir7182pOWXz5So+ubjcfJ99CAm
         sT9c+WjLfy1YTL5wu2epOLzJiFMwG6FrlqPpnEllKMOCCIicixxgfCxoovpASsPSjWzD
         mw8Q==
X-Gm-Message-State: APjAAAXA3CAcD4+xL7sbwEpLWjR5GGrx1SnsP6nrH0qjN6skV1m/jFrA
        SDqQqImWOxTLJnsKh2AC+KW0X86DuWk=
X-Google-Smtp-Source: APXvYqxRSt63yPuuv0mIlA6u7e9vwd1xjy3UqXV8n7ZSULKVSBb5W1bqB9wAsiYTXtWndOxnkPV83Q==
X-Received: by 2002:a37:68c6:: with SMTP id d189mr14155448qkc.307.1583103603911;
        Sun, 01 Mar 2020 15:00:03 -0800 (PST)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id q1sm1562355qtp.81.2020.03.01.15.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 15:00:03 -0800 (PST)
Subject: Re: [Patch v4 4/7] thermal: Add generic power domain warming device
 driver.
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
 <1574254593-16078-5-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqBusMHWNHBCMXx6TxFO=8B6ytoyvvSfi14Z=-ahBDV5A@mail.gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <ac341c33-003a-587a-7078-84a7f0c01a3a@linaro.org>
Date:   Sun, 1 Mar 2020 18:00:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqBusMHWNHBCMXx6TxFO=8B6ytoyvvSfi14Z=-ahBDV5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

Thanks for the reviews. Sorry for the delay in response.
I have started working on this again. So this should pick
up pace now.

On 2/4/20 11:54 AM, Ulf Hansson wrote:
> On Wed, 20 Nov 2019 at 13:56, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Resources modeled as power domains in linux kenrel can  be used to warm the
>> SoC(eg. mx power domain on sdm845).  To support this feature, introduce a
>> generic power domain warming device driver that can be plugged into the
>> thermal framework (The thermal framework itself requires further
>> modifiction to support a warming device in place of a cooling device.
>> Those extensions are not introduced in this patch series).
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>> v3->v4:
>>          - Removed late_init hook pd_warming_device_ops.
>>          - Use of_genpd_add_device instead of pm_genpd_add_device to attach
>>            device to the generic power domain.
>>          - Use thermal_of_cooling_device_parent_register to register the
>>            cooling device so that the device with genpd attached can be
>>            made parent of the cooling device.
>>          - With above changes, remove reference to generic_pm_domain in
>>            pd_warming_device.
>>
>>   drivers/thermal/Kconfig              |  10 +++
>>   drivers/thermal/Makefile             |   2 +
>>   drivers/thermal/pwr_domain_warming.c | 138 +++++++++++++++++++++++++++++++++++
>>   include/linux/pwr_domain_warming.h   |  29 ++++++++
> 
> Not sure about what the thermal maintainers think about the naming
> here. In the end, it's their call.
> 
> However, normally we use "pm_domain_*", rather than "pwr_domain_*",
> but maybe just "pd_*" is sufficient here.

I will rename this to pd_ for now.

> 
>>   4 files changed, 179 insertions(+)
>>   create mode 100644 drivers/thermal/pwr_domain_warming.c
>>   create mode 100644 include/linux/pwr_domain_warming.h
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 001a21a..0c5c93e 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -187,6 +187,16 @@ config DEVFREQ_THERMAL
>>
>>            If you want this support, you should say Y here.
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
>>   config THERMAL_EMULATION
>>          bool "Thermal emulation mode support"
>>          help
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 74a37c7..382c64a 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -27,6 +27,8 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)   += clock_cooling.o
>>   # devfreq cooling
>>   thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>>
>> +thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)       += pwr_domain_warming.o
>> +
>>   # platform thermal drivers
>>   obj-y                          += broadcom/
>>   obj-$(CONFIG_THERMAL_MMIO)             += thermal_mmio.o
>> diff --git a/drivers/thermal/pwr_domain_warming.c b/drivers/thermal/pwr_domain_warming.c
>> new file mode 100644
>> index 0000000..40162b9
>> --- /dev/null
>> +++ b/drivers/thermal/pwr_domain_warming.c
>> @@ -0,0 +1,138 @@
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
>> +       struct device dev;
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
>> +       *state = dev_pm_genpd_get_performance_state(&pd_wdev->dev);
>> +
>> +       return 0;
>> +}
>> +
>> +static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
>> +                                unsigned long state)
>> +{
>> +       struct pd_warming_device *pd_wdev = cdev->devdata;
>> +       struct device *dev = &pd_wdev->dev;
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
>> +static struct thermal_cooling_device_ops pd_warming_device_ops = {
>> +       .get_max_state  = ::pd_wdev_get_max_state,
>> +       .get_cur_state  = pd_wdev_get_cur_state,
>> +       .set_cur_state  = pd_wdev_set_cur_state,
>> +};
>> +
>> +struct thermal_cooling_device *
>> +pwr_domain_warming_register(struct device *parent, char *pd_name, int pd_id)
> 
> Maybe rename this to: thermal_of_pd_warming_register()

How about pd_of_warming_register? It is consistent with other cooling 
device register like cpuidle_of_cooling_register and 
cpufreq_of_cooling_register.

> Moreover, I think you could replace the "struct device *parent", with
> a "struct device_node *node" as in-parameter. That's all you need,
> right?

You mean pd_wdev->dev.parent need not be populated ? The device
in this case will be created under /sys/devices which I do not think
is the correct.
With a parent device specified, the power controller that resides the 
power domain that can act as the warming dev, becomes the parent of the 
warming dev. In case of this patch series, for the mx warming dev, 
179c0000.rsc/179c0000.rsc\:power-controller/ becomes the parent.(The 
device will be created under 
/sys/devices/platform/soc\@0/179c0000.rsc/179c0000.rsc\:power-controller/)

Other way might be to register the warming device under virtual devices 
as a new category of devices.

I prefer to keep it as a child of the power controller device, but I am 
open to explore other options and to re-do this bit. What do you think?

> 
>> +{
>> +       struct pd_warming_device *pd_wdev;
>> +       struct of_phandle_args pd_args;
>> +       int ret;
>> +
>> +       pd_wdev = kzalloc(sizeof(*pd_wdev), GFP_KERNEL);
>> +       if (!pd_wdev)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       dev_set_name(&pd_wdev->dev, "%s_warming_dev", pd_name);
> 
> Perhaps skip the in-param *pd_name and make use of the suggested
> "struct device_node *node", the index and something with "warming...",
> when setting the name.

Won't the index have to be in-param in this case ?

> 
> Just an idea, as to simplify for the caller.
> 
>> +       pd_wdev->dev.parent = parent;
> 
> This isn't needed, I think.
> 
>> +
>> +       ret = device_register(&pd_wdev->dev);
>> +       if (ret)
>> +               goto error;
>> +
>> +       pd_args.np = parent->of_node;
>> +       pd_args.args[0] = pd_id;
>> +       pd_args.args_count = 1;
>> +
>> +       ret = of_genpd_add_device(&pd_args, &pd_wdev->dev);
>> +
> 
> White space.

Will fix it.

> 
>> +       if (ret)
>> +               goto error;
>> +
>> +       ret = dev_pm_genpd_performance_state_count(&pd_wdev->dev);
>> +       if (ret < 0)
>> +               goto error;
>> +
>> +       pd_wdev->max_state = ret - 1;
>> +       pm_runtime_enable(&pd_wdev->dev);
>> +       pd_wdev->runtime_resumed = false;
>> +
>> +       pd_wdev->cdev = thermal_of_cooling_device_parent_register
>> +                                       (NULL, parent, pd_name, pd_wdev,
>> +                                        &pd_warming_device_ops);
> 
> As stated in patch3, I don't get it why you need to use this new API
> for "parents".

I agree with you. I cannot re-collect my thought process for this API.
I compiled and tested using the regular API and everything works fine.
I will drop patch 3 and use the thermal_of_cooling_device_register here.

> 
>> +       if (IS_ERR(pd_wdev->cdev)) {
>> +               pr_err("unable to register %s cooling device\n", pd_name);
>> +               pm_runtime_disable(&pd_wdev->dev);
>> +               ret = PTR_ERR(pd_wdev->cdev);
>> +               goto error;
>> +       }
>> +
>> +       return pd_wdev->cdev;
>> +error:
>> +       put_device(&pd_wdev->dev);
> 
> If device_register() succeeds you need to call device_unregister(),
> rather than put_device() as a part of the error handling.

Will fix this.

> 
>> +       kfree(pd_wdev);
> 
> You need a ->release() callback to manage kfree(), after you called
> device_register().

mm?? I did not get this. What release callback? You mean for power 
controller driver to call ?

> 
>> +       return ERR_PTR(ret);
> 
> Another thing is missing in the error path, which is to remove the
> device for the genpd. I think calling pm_genpd_remove_device() should
> work fine here.

I will fix this. I am thinking this will be be needed in 
pwr_domain_warming_unregister as well.


-- 
Warm Regards
Thara
