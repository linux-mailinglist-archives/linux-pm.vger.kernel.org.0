Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADC7192B47
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 15:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgCYOfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 10:35:38 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37882 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgCYOfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 10:35:36 -0400
Received: by mail-qv1-f67.google.com with SMTP id n1so1141031qvz.4
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2020 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+kwXOGpMaPekrAzfhftfE+gw1YnXEMbIx547SEtRJs8=;
        b=u6luavn1Vsw0nblaWrGICZrBOI5aygYZDNJfSeSFwROrkidjCDpGRJgdi+mMUs+U9A
         26JsvmnurOMQEScqA26HQRFi4gm1TdEoiPfyNgm61+5ElwYvpXdwjZIq0WDJNpo6GOIl
         mRyvDRy0cvxi/aMelDBdZxLuBFv3lg9MAHWR5F940+ht5bkDBC7PRRUzuPqTHg+mP+r2
         xX1yUBj2Sp6HbxoRaFEK7zBrX7C44/pI6m1V8rQbsm8ojLa5IKBI/k9HD5JNpH62a9TS
         b491lAKXeaksvjjDBsDn77sAoj/E6wd/c03D8zTphOR3/5K9c6XkVzfgh/qzgpk4UXGy
         T5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+kwXOGpMaPekrAzfhftfE+gw1YnXEMbIx547SEtRJs8=;
        b=LosIUTIW0KTC27/UdXo+oqRf9o9fIBlQynw/pXqOPnF+rP8fTyxVXE4DBEHDK1QNhW
         UhbCXzxePl7Thi3ppQETrSlYOGwtv+d4Pih15BbAFvkMdPEcGMQIYnVzuN2RZzMrjpt5
         bOpfDTzppdUDnEpoxC7r7RgoiVDhWS5gbtpT8mIh0jTQjL4iu3eyx8tuaIBcP2DJIHw9
         AKuUsKgfhBJkeFNLPQhZyl5rIEyDecIQMvAqugID98Rrw9Zeg3bFnThVuzCOK1W+0k8w
         yf6KaRCINLpr50WUcX07wRil8LpbbBGFBZjyAs4xOeKDU5wjC59Kp8fvtNYOmAR9wG5F
         DEuw==
X-Gm-Message-State: ANhLgQ3h2SQWmOPJ1cfA2lO99KRz2DqdKJJVBTDQY0J1h5Ez1nnpmdx5
        Qn8HAvZnBRDQz4xYhXWgDnkwEw==
X-Google-Smtp-Source: ADFU+vuNxobH1Mq6LBSt0Der6JSj8ojaHpucegR+t8b4DvSDA49x5wkorDVhZyM7KlZMcxClhmiQkg==
X-Received: by 2002:a0c:fe87:: with SMTP id d7mr2362960qvs.37.1585146934157;
        Wed, 25 Mar 2020 07:35:34 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id l18sm15345100qke.132.2020.03.25.07.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:35:33 -0700 (PDT)
Subject: Re: [Patch v5 3/6] thermal: Add generic power domain warming device
 driver.
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
 <20200320014107.26087-4-thara.gopinath@linaro.org>
 <CAPDyKFqn0E=-sNZy=09tLZn=6VxEfiXL-vUNwb9HK8+WLDBiPw@mail.gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <31aba776-28ee-3aac-08eb-6f39f8279bfe@linaro.org>
Date:   Wed, 25 Mar 2020 10:35:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqn0E=-sNZy=09tLZn=6VxEfiXL-vUNwb9HK8+WLDBiPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,
Thanks for the review!

On 3/23/20 11:57 AM, Ulf Hansson wrote:

--snip
>> +
>> +static void pd_warming_release(struct device *dev)
>> +{
>> +       kfree(dev);
> 
> This is wrong, you should free a "struct pd_warming_device *". Use the
> "container of" macro to get it from 'dev'.

Will fix this.
> 
>> +}
>> +
>> +struct thermal_cooling_device *
>> +of_pd_warming_register(struct device *parent, int pd_id)
>> +{
>> +       struct pd_warming_device *pd_wdev;
>> +       struct of_phandle_args pd_args;
>> +       char cdev_name[THERMAL_NAME_LENGTH];
>> +       int ret;
>> +
>> +       pd_wdev = kzalloc(sizeof(*pd_wdev), GFP_KERNEL);
>> +       if (!pd_wdev)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       dev_set_name(&pd_wdev->dev, "%s_%d_warming_dev",
>> +                    dev_name(parent), pd_id);
>> +       pd_wdev->dev.parent = parent;
>> +       pd_wdev->dev.release = pd_warming_release;
>> +
>> +       ret = device_register(&pd_wdev->dev);
>> +       if (ret) {
>> +               put_device(&pd_wdev->dev);
>> +               goto free_pd_wdev;
>> +       }
>> +
>> +       ret = ida_simple_get(&pd_ida, 0, 0, GFP_KERNEL);
>> +       if (ret < 0)
>> +               goto unregister_device;
> 
> If you use and ida, you might as well use it as a part of the
> dev_set_name() above.
> 
> That should give you a unique name, similar to how you use it for the
> cdev_name below.

dev_set_name above already has a unique name with the power controller 
name and the power domain id. cdev on the other hand creates a virtual 
thermal device and needs a unique name.

> 
>> +
>> +       pd_wdev->id = ret;
>> +
>> +       pd_args.np = parent->of_node;
>> +       pd_args.args[0] = pd_id;
>> +       pd_args.args_count = 1;
>> +
>> +       ret = of_genpd_add_device(&pd_args, &pd_wdev->dev);
>> +
>> +       if (ret)
>> +               goto remove_ida;
>> +
>> +       ret = dev_pm_genpd_performance_state_count(&pd_wdev->dev);
>> +       if (ret < 0)
>> +               goto out_genpd;
>> +
>> +       pd_wdev->max_state = ret - 1;
>> +       pm_runtime_enable(&pd_wdev->dev);
>> +       pd_wdev->runtime_resumed = false;
>> +
>> +       snprintf(cdev_name, sizeof(cdev_name), "thermal-pd-%d", pd_wdev->id);
>> +       pd_wdev->cdev = thermal_of_cooling_device_register
>> +                                       (NULL, cdev_name, pd_wdev,
>> +                                        &pd_warming_device_ops);
>> +       if (IS_ERR(pd_wdev->cdev)) {
>> +               pr_err("unable to register %s cooling device\n", cdev_name);
>> +               ret = PTR_ERR(pd_wdev->cdev);
>> +               goto out_runtime_disable;
>> +       }
>> +
>> +       return pd_wdev->cdev;
>> +
>> +out_runtime_disable:
>> +       pm_runtime_disable(&pd_wdev->dev);
>> +out_genpd:
>> +       pm_genpd_remove_device(&pd_wdev->dev);
>> +remove_ida:
>> +       ida_simple_remove(&pd_ida, pd_wdev->id);
>> +unregister_device:
>> +       device_unregister(&pd_wdev->dev);
>> +       pd_warming_release(&pd_wdev->dev);
> 
> This is wrong, drop this.

Oops . sorry . Will do. Will fix rest of the comments below as well.

> 
>> +free_pd_wdev:
>> +       kfree(pd_wdev);
> 
> Since you should free this from the ->release() callback, there is no
> need to do this here.
> 
>> +       return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(of_pd_warming_register);
>> +
>> +void pd_warming_unregister(struct thermal_cooling_device *cdev)
>> +{
>> +       struct pd_warming_device *pd_wdev = cdev->devdata;
>> +       struct device *dev = &pd_wdev->dev;
>> +
>> +       if (pd_wdev->runtime_resumed) {
>> +               dev_pm_genpd_set_performance_state(dev, 0);
>> +               pm_runtime_put(dev);
>> +               pd_wdev->runtime_resumed = false;
>> +       }
>> +       pm_runtime_disable(dev);
>> +       pm_genpd_remove_device(dev);
>> +       ida_simple_remove(&pd_ida, pd_wdev->id);
>> +       thermal_cooling_device_unregister(cdev);
>> +       kfree(pd_wdev);
> 
> Don't use kfree here, but instead device_unregister(dev);
> 
>> +}
>> +EXPORT_SYMBOL_GPL(pd_warming_unregister);
>> diff --git a/include/linux/pd_warming.h b/include/linux/pd_warming.h
>> new file mode 100644
>> index 000000000000..550a5683b56d
>> --- /dev/null
>> +++ b/include/linux/pd_warming.h
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019, Linaro Ltd.
>> + */
>> +#ifndef __PWR_DOMAIN_WARMING_H__
>> +#define __PWR_DOMAIN_WARMING_H__
>> +
>> +#include <linux/pm_domain.h>
>> +#include <linux/thermal.h>
>> +
>> +#ifdef CONFIG_PWR_DOMAIN_WARMING_THERMAL
>> +struct thermal_cooling_device *
>> +of_pd_warming_register(struct device *parent, int pd_id);
>> +
>> +void pd_warming_unregister(struct thermal_cooling_device *cdev);
>> +
>> +#else
>> +static inline struct thermal_cooling_device *
>> +of_pd_warming_register(struct device *parent, int pd_id)
>> +{
>> +       return ERR_PTR(-ENOSYS);
>> +}
>> +
>> +static inline void
>> +pd_warming_unregister(struct thermal_cooling_device *cdev)
>> +{
>> +}
>> +#endif /* CONFIG_PWR_DOMAIN_WARMING_THERMAL */
>> +#endif /* __PWR_DOMAIN_WARMING_H__ */
>> --
>> 2.20.1
>>
> 
> Besides the few things above, this looks good to me.
> 
> Kind regards
> Uffe
> 

-- 
Warm Regards
Thara
