Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB33C26F3
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 17:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhGIPkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhGIPkF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 11:40:05 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB08C0613DD
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 08:37:22 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id v10so7881702qto.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rcHQGITQT0Ev3LUdWDmu/OcX9pKeYERhlnakz2AyIbw=;
        b=JhI+lUTdrAqp+quFOkd+uVXkExHP3MSCVfAQKGk8S3CI9aJi81f1YJ8O3vZMhy8muw
         xH/M1oQXWZgcOJ4FWcDDapK005XdTg7AJBqXy9BUU8kS/y21VnaVi7fr/HAFNW/GJhHX
         FIVliP1ss4+WCKvlzXJphI5x2kvMhb00A7xmCYrTDGWiCRIgzZkB/Hf8P3CYqtWOULmg
         s781MBklg/7ag9lAGYRUgBhLsH7ZpzGzmVWPKGzudgC5C3digdUw+IJV08YDi2OYuvLZ
         QI9pEFDqOBbI5Xtiu5i0E3lf6h40Hm4+A6BE1F5HaWq+u0iaZix08WFVlhjvbklIBdAz
         pt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rcHQGITQT0Ev3LUdWDmu/OcX9pKeYERhlnakz2AyIbw=;
        b=GPuOaMU4endyDudB0AELewtG9cVkFBsXKhIkOrxt3iVfZI9/BWTWv8XTmRAS9ANEF+
         m/mXSgJZ4lJ0ZoOk5JWaYS0sTvO50pL5s5530bAQ28aZakzakxJ3G3m3S6Gl97VtgXc1
         kcnvU71ephbPl14h2NeKKkAqCFjn/eJAV1xNjlC9pjCEEdUsP2MW+IdLiDl+PyhIi73c
         0+pgn/sV4FkiC3JYco4VPuCJL/Pa6dN51ASmINcF99tHCtx57m4cH4zL3Lsm1nAUEan5
         XkD1iEjBOC+0LCUjcNcctDRi4nYbZILkjv6IGDFIeYBBIpi4wOSFCTCwFOU9kBYJDkRR
         gyBw==
X-Gm-Message-State: AOAM5327kipi4HPxZKdjJ5B/Hn6/YIkXPRScCKtbLr22Vq7wchKMpQau
        +spiGJTxiMQ+mO8TGXq8RGUgIA==
X-Google-Smtp-Source: ABdhPJz2Ui9kkZjSYNnuX2OGcNaYVVRTDwn4JfVlNcgsksptri/fedwygrdh1WQfi0MU5YbbAMhXZQ==
X-Received: by 2002:ac8:744e:: with SMTP id h14mr25952977qtr.34.1625845041088;
        Fri, 09 Jul 2021 08:37:21 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id p187sm2675297qkd.101.2021.07.09.08.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 08:37:20 -0700 (PDT)
Subject: Re: [Patch v3 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-4-thara.gopinath@linaro.org>
 <20210709064646.7vjgiba2o7beudly@vireshk-i7>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5a98ef2a-d170-f52d-cc48-b838cddaa5c2@linaro.org>
Date:   Fri, 9 Jul 2021 11:37:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709064646.7vjgiba2o7beudly@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/9/21 2:46 AM, Viresh Kumar wrote:
> On 08-07-21, 08:06, Thara Gopinath wrote:
>>   static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   {
>>   	struct platform_device *pdev = cpufreq_get_driver_data();
>> @@ -370,6 +480,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
>>   	}
>>   
>> +	ret = qcom_cpufreq_hw_lmh_init(policy, index);
> 
> You missed unregistering EM here (which is also missing from exit,
> which you need to fix first in a separate patch).

Hi!

So how exactly do you do this? I checked other users of the api and I do 
not see any free. I would say if needed, it should be a separate patch 
and outside of this series.

> 
>> +	if (ret)
>> +		goto error;
>> +
>>   	return 0;
>>   error:
>>   	kfree(data);
>> @@ -389,6 +503,10 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>>   
>>   	dev_pm_opp_remove_all_dynamic(cpu_dev);
>>   	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>> +	if (data->lmh_dcvs_irq > 0) {
>> +		devm_free_irq(cpu_dev, data->lmh_dcvs_irq, data);
> 
> Why using devm variants here and while requesting the irq ?
> 
>> +		cancel_delayed_work_sync(&data->lmh_dcvs_poll_work);
>> +	}
> 
> Please move this to qcom_cpufreq_hw_lmh_exit() or something.

Ok.

> 
> Now with sequence of disabling interrupt, etc, I see a potential
> problem.
> 
> CPU0                                    CPU1
> 
> qcom_cpufreq_hw_cpu_exit()
> -> devm_free_irq();
>                                          qcom_lmh_dcvs_poll()
>                                          -> qcom_lmh_dcvs_notify()
>                                            -> enable_irq()
> 
> -> cancel_delayed_work_sync();
> 
> 
> What will happen if enable_irq() gets called after freeing the irq ?
> Not sure, but it looks like you will hit this then from manage.c:
> 
> WARN(!desc->irq_data.chip, KERN_ERR "enable_irq before
>                                       setup/request_irq: irq %u\n", irq))
> 
> ?
> 
> You got a chicken n egg problem :)

Yes indeed! But also it is a very rare chicken and egg problem.
The scenario here is that the cpus are busy and running load causing a 
thermal overrun and lmh is engaged. At the same time for this issue to 
be hit the cpu is trying to exit/disable cpufreq. Calling 
cancel_delayed_work_sync first could solve this issue, right ? 
cancel_delayed_work_sync guarantees the work not to be pending even if
it requeues itself on return. So once the delayed work is cancelled, the 
interrupts can be safely disabled. Thoughts ?


> 

-- 
Warm Regards
Thara (She/Her/Hers)
