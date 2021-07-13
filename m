Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB91B3C67FC
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 03:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhGMBVR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 21:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhGMBVR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 21:21:17 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B045FC0613DD
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 18:18:27 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 18so2899219qka.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 18:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DrmYRl9BF9d3iatBQwzwYcnmOf/PKMScaARgXZNfTEg=;
        b=BGg4Y9yfZ8aO0n2dQiUMFe4/T8Pzu7P6FwAuotW9PRRRRA3P2VAZvrYEcSlkT6F2au
         n68NRdiMxM/jwElgMufLj9V+Dw+oWi/aCGQXBHARGxpOdxWqYuz5Q6CmPokbM9RLqyKu
         qvQ6xkmBQDrcMh+EZ31nzPTNQqX+yKQdyN8GO1i6fdpcOZLX01Wz8eWcg0wXxP/MXbhe
         EplA5WRbmY3+lt9947hSi/AwHo7G3N579KeVEkN8XUwjmoXDhnYbtijnngNtKw/iDvEG
         hncgFXl1nFDUt5KS4NzW3JfGL4gsjfnRWWrY6LZMjeXIG/ubi5QI936WAV483Gsm1Khp
         CpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DrmYRl9BF9d3iatBQwzwYcnmOf/PKMScaARgXZNfTEg=;
        b=ArEJvrt4BCSClrRr5Y9fJSTZlM7CVznQg9TTqS8rZ0Y62IqACLWffS3F/WnVxfRh5P
         ZvqcXfXElcJF6pqjuBKhSMMZ8QI3dVS5Q4X1/QgMdYUCaYbvtQAb1u6bOU6UDawzQxfW
         htq0Q89LUeJ/v1H39fixupo1GMZOnjm2nouonX4PXePfXNPnntBXBqpyJOGTfcyTr0eQ
         u6JuGbaQ+RZd0qHfqtQ2OsYXzcWzHyLZO6faik4Md3HInmEEayC7/6NWGocrkO5SIBFd
         168dK7vnYfA4B+UWtwu785wY5Ry5ang0plNKfBJRT1r7UbC1FmlLcJ8iEGjMioDfa9AK
         PN2Q==
X-Gm-Message-State: AOAM532sdAhFj4vMT+36RPvMn7Ri4jQ/gL0cr9oz3C5uH5B4xwCEd4ho
        uVq99Tz8cqvWs8UO8JlAC6hbCA==
X-Google-Smtp-Source: ABdhPJyGwIx8zjXe7P/2vyJ3EWz4p1saDMwtAE4oaB0lYznF1yvNCsK6LHvpgFoRcdu/0X4ZjRENcg==
X-Received: by 2002:a05:620a:1a19:: with SMTP id bk25mr1708352qkb.38.1626139106830;
        Mon, 12 Jul 2021 18:18:26 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id f62sm3363273qke.135.2021.07.12.18.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 18:18:26 -0700 (PDT)
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
 <5a98ef2a-d170-f52d-cc48-b838cddaa5c2@linaro.org>
 <20210712044112.svhlagrktcfvyj35@vireshk-i7>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <b05e9c76-c0ed-9ecb-8225-9504e226677b@linaro.org>
Date:   Mon, 12 Jul 2021 21:18:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712044112.svhlagrktcfvyj35@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/12/21 12:41 AM, Viresh Kumar wrote:
> On 09-07-21, 11:37, Thara Gopinath wrote:
>> On 7/9/21 2:46 AM, Viresh Kumar wrote:
>>>> @@ -389,6 +503,10 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>>>>    	dev_pm_opp_remove_all_dynamic(cpu_dev);
>>>>    	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>>>> +	if (data->lmh_dcvs_irq > 0) {
>>>> +		devm_free_irq(cpu_dev, data->lmh_dcvs_irq, data);
>>>
>>> Why using devm variants here and while requesting the irq ?
> 
> Missed this one ?

Yep. I just replied to Bjorn's email on this. I will move to non devm 
version.

> 
>>>
>>>> +		cancel_delayed_work_sync(&data->lmh_dcvs_poll_work);
>>>> +	}
>>>
>>> Please move this to qcom_cpufreq_hw_lmh_exit() or something.
>>
>> Ok.
>>
>>>
>>> Now with sequence of disabling interrupt, etc, I see a potential
>>> problem.
>>>
>>> CPU0                                    CPU1
>>>
>>> qcom_cpufreq_hw_cpu_exit()
>>> -> devm_free_irq();
>>>                                           qcom_lmh_dcvs_poll()
>>>                                           -> qcom_lmh_dcvs_notify()
>>>                                             -> enable_irq()
>>>
>>> -> cancel_delayed_work_sync();
>>>
>>>
>>> What will happen if enable_irq() gets called after freeing the irq ?
>>> Not sure, but it looks like you will hit this then from manage.c:
>>>
>>> WARN(!desc->irq_data.chip, KERN_ERR "enable_irq before
>>>                                        setup/request_irq: irq %u\n", irq))
>>>
>>> ?
>>>
>>> You got a chicken n egg problem :)
>>
>> Yes indeed! But also it is a very rare chicken and egg problem.
>> The scenario here is that the cpus are busy and running load causing a
>> thermal overrun and lmh is engaged. At the same time for this issue to be
>> hit the cpu is trying to exit/disable cpufreq.
> 
> Yes, it is a very specific case but it needs to be resolved anyway. You don't
> want to get this ever :)
> 
>> Calling
>> cancel_delayed_work_sync first could solve this issue, right ?
>> cancel_delayed_work_sync guarantees the work not to be pending even if
>> it requeues itself on return. So once the delayed work is cancelled, the
>> interrupts can be safely disabled. Thoughts ?
> 
> I don't think even that would provide such guarantees to you here, as there is
> a chance the work gets queued again because of an interrupt that triggers right
> after you cancel the work.
> 
> The basic way of solving such issues is that once you cancel something, you need
> to guarantee that it doesn't get triggered again, no matter what.
> 
> The problem here I see is with your design itself, both delayed work and irq can
> enable each other, so no matter which one you disable first, won't be
> sufficient. You need to fix that design somehow.

So I really need the interrupt to fire and then the timer to kick in and 
take up the monitoring. I can think of introducing a variable 
is_disabled which is updated and read under a spinlock. 
qcom_cpufreq_hw_cpu_exit can hold the spinlock and set is_disabled to 
true prior to cancelling the work queue or disabling the interrupt. 
Before re-enabling the interrupt or re-queuing the work in 
qcom_lmh_dcvs_notify, is_disabled can be read and checked.

But does this problem not exist in target_index , fast_switch etc also ? 
One cpu can be disabling and the other one can be updating the target 
right?

> 

-- 
Warm Regards
Thara (She/Her/Hers)
