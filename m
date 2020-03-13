Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA773184A24
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 16:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgCMPDF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 11:03:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35282 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMPDE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 11:03:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id d8so12990856qka.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2020 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eFNXLKStv2hg6vAmjDX147WvWuSgMNwcWrKlrLIyNJU=;
        b=J7UnUbl9ctijkZvETuhF2hc0OMJeFQjsVukcnWBIivUe52Pao9vewDvONPsWAupqgx
         UM0886uf9mLGKQkU8VQB185wQS4WwmPkjWc7UHdAyV94aSuWySlHmE3FGcedek/oV3U8
         HKuw+IesrCpz8oNHIrjywlWJk1IgKlgmy9pBlwC+sm1avY33ghWFsISK6hhcW5V5s6Yh
         O0ZYROVcAEk9yUOiEisjBzVgwaDiWEj+s148o4pQ5oseaCe6ZhdmWpYGEpRcRIc2b5W7
         VjBfh6G3zbf2sZkbnpjF2exFmkcBBJpqPStIdF/dPabjVf+fPz/sESjzTqqWyafLKhzT
         UeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFNXLKStv2hg6vAmjDX147WvWuSgMNwcWrKlrLIyNJU=;
        b=UbYLitlyH7ZhtWqYMK8/paDILcY+tHyUtv5qRXiVFlHlem8kuf4ApDl61ibvxrYmNR
         5eaRSC8yMp6EcGX7iU6DYlQUx7T81kmi3bZ6HduW7eg/pVoNe7bl7ZOt9Ax2v6pNsJew
         LP+9aj6DViqNgcdWl2jfKP1FWxd5nlJW9JPmDrvnju6Pwcunw4vLR7T3x3j6loRTKAt/
         /dW0nXy1oUly+BSnetfNsaFOai0Q//EkS/EigrOeYy0a7V/oJMnDfoUKz8i6bSXAeU9K
         T3TnK4ZhHcrC54NNLFuID5MBnfB+cHE8I/xa8TvwMfJBoPp1dCCsUiJ523RAdFUJy39T
         yD7w==
X-Gm-Message-State: ANhLgQ0yw2977v+prqf/MgjGb52gCSqnSHgYgsqxKuLuacrmrZWVRJlM
        Fv1BoAO7d58/vaeEiQhb86rXGg==
X-Google-Smtp-Source: ADFU+vtMY8vpGBVV4atpZVS6vYpJnjsti9wnuTPA/iC6ha2U+5xIxJbMXzcrP5RaohNt9EtiDO2P1g==
X-Received: by 2002:a37:7d2:: with SMTP id 201mr13919655qkh.146.1584111781830;
        Fri, 13 Mar 2020 08:03:01 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id c190sm8142895qkb.80.2020.03.13.08.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 08:03:00 -0700 (PDT)
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
 <ac341c33-003a-587a-7078-84a7f0c01a3a@linaro.org>
 <CAPDyKFotwoiDkF6Ru39rOv+GxF7dgXG6tc0oQHMim8yKB2hRvQ@mail.gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <decacd00-9c41-a664-6329-dca494fd7302@linaro.org>
Date:   Fri, 13 Mar 2020 11:02:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFotwoiDkF6Ru39rOv+GxF7dgXG6tc0oQHMim8yKB2hRvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

Thanks for the reviews. Will send out v5 soon.

On 3/13/20 9:13 AM, Ulf Hansson wrote:
> [...]
> 
>>>> +static struct thermal_cooling_device_ops pd_warming_device_ops = {
>>>> +       .get_max_state  = ::pd_wdev_get_max_state,
>>>> +       .get_cur_state  = pd_wdev_get_cur_state,
>>>> +       .set_cur_state  = pd_wdev_set_cur_state,
>>>> +};
>>>> +
>>>> +struct thermal_cooling_device *
>>>> +pwr_domain_warming_register(struct device *parent, char *pd_name, int pd_id)
>>>
>>> Maybe rename this to: thermal_of_pd_warming_register()
>>
>> How about pd_of_warming_register? It is consistent with other cooling
>> device register like cpuidle_of_cooling_register and
>> cpufreq_of_cooling_register.
> 
> Well, we actually have the following:
> of_devfreq_cooling_register()
> of_cpufreq_cooling_register()
> cpuidle_of_cooling_register()
> 
> So maybe this is the most consistent. :-)
> of_pd_warming_register()

Sure!

> 
>>
>>> Moreover, I think you could replace the "struct device *parent", with
>>> a "struct device_node *node" as in-parameter. That's all you need,
>>> right?
>>
>> You mean pd_wdev->dev.parent need not be populated ? The device
>> in this case will be created under /sys/devices which I do not think
>> is the correct.
> 
> Good point!
> 
>> With a parent device specified, the power controller that resides the
>> power domain that can act as the warming dev, becomes the parent of the
>> warming dev. In case of this patch series, for the mx warming dev,
>> 179c0000.rsc/179c0000.rsc\:power-controller/ becomes the parent.(The
>> device will be created under
>> /sys/devices/platform/soc\@0/179c0000.rsc/179c0000.rsc\:power-controller/)
>>
>> Other way might be to register the warming device under virtual devices
>> as a new category of devices.
> 
> No, that sounds wrong.
> 
> Another option is to create a specific bus type for these new
> pd_warming devices. But I admit that sounds a bit too much, let's
> assign a parent.
> 
>>
>> I prefer to keep it as a child of the power controller device, but I am
>> open to explore other options and to re-do this bit. What do you think?
> 
> Sure, sorry for the noise.

No issues!

> 
>>
>>>
>>>> +{
>>>> +       struct pd_warming_device *pd_wdev;
>>>> +       struct of_phandle_args pd_args;
>>>> +       int ret;
>>>> +
>>>> +       pd_wdev = kzalloc(sizeof(*pd_wdev), GFP_KERNEL);
>>>> +       if (!pd_wdev)
>>>> +               return ERR_PTR(-ENOMEM);
>>>> +
>>>> +       dev_set_name(&pd_wdev->dev, "%s_warming_dev", pd_name);
>>>
>>> Perhaps skip the in-param *pd_name and make use of the suggested
>>> "struct device_node *node", the index and something with "warming...",
>>> when setting the name.
>>
>> Won't the index have to be in-param in this case ?
> 
> Isn't that already the case?
> 
> Huh, long time since I reviewed this.
> 
>>
>>>
>>> Just an idea, as to simplify for the caller.
>>>
>>>> +       pd_wdev->dev.parent = parent;
>>>
>>> This isn't needed, I think.
> 
> So ignore this comment, as discussed above.
> 
>>>
>>>> +
>>>> +       ret = device_register(&pd_wdev->dev);
>>>> +       if (ret)
>>>> +               goto error;
>>>> +
>>>> +       pd_args.np = parent->of_node;
>>>> +       pd_args.args[0] = pd_id;
>>>> +       pd_args.args_count = 1;
>>>> +
>>>> +       ret = of_genpd_add_device(&pd_args, &pd_wdev->dev);
>>>> +
>>>
>>> White space.
>>
>> Will fix it.
>>
>>>
>>>> +       if (ret)
>>>> +               goto error;
>>>> +
>>>> +       ret = dev_pm_genpd_performance_state_count(&pd_wdev->dev);
>>>> +       if (ret < 0)
>>>> +               goto error;
>>>> +
>>>> +       pd_wdev->max_state = ret - 1;
>>>> +       pm_runtime_enable(&pd_wdev->dev);
>>>> +       pd_wdev->runtime_resumed = false;
>>>> +
>>>> +       pd_wdev->cdev = thermal_of_cooling_device_parent_register
>>>> +                                       (NULL, parent, pd_name, pd_wdev,
>>>> +                                        &pd_warming_device_ops);
>>>
>>> As stated in patch3, I don't get it why you need to use this new API
>>> for "parents".
>>
>> I agree with you. I cannot re-collect my thought process for this API.
>> I compiled and tested using the regular API and everything works fine.
>> I will drop patch 3 and use the thermal_of_cooling_device_register here.
> 
> Great, one confusing piece seems to go away then. :-)
> 
>>
>>>
>>>> +       if (IS_ERR(pd_wdev->cdev)) {
>>>> +               pr_err("unable to register %s cooling device\n", pd_name);
>>>> +               pm_runtime_disable(&pd_wdev->dev);
>>>> +               ret = PTR_ERR(pd_wdev->cdev);
>>>> +               goto error;
>>>> +       }
>>>> +
>>>> +       return pd_wdev->cdev;
>>>> +error:
>>>> +       put_device(&pd_wdev->dev);
>>>
>>> If device_register() succeeds you need to call device_unregister(),
>>> rather than put_device() as a part of the error handling.
>>
>> Will fix this.
>>
>>>
>>>> +       kfree(pd_wdev);
>>>
>>> You need a ->release() callback to manage kfree(), after you called
>>> device_register().
>>
>> mm?? I did not get this. What release callback? You mean for power
>> controller driver to call ?
> 
> No, this how life cycle management of devices should be implemented.
> 
> Have a look at genpd_release_dev() - and see how that is being used
> for genpd's virtual devices, that should explain more.

Ah yes. I get it now. Will fix this.

-- 
Warm Regards
Thara
