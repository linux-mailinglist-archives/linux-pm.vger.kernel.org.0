Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0474DD11D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 00:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiCQXXA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Mar 2022 19:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiCQXW7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2022 19:22:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBAB200351
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 16:21:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p6so4323095lfh.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 16:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0TlJeFaiz7dJRdwgygJHKKabVfjrr5QSbdY+xLrVeFE=;
        b=M2b6bug+iyFITuX3nsblKgcZzTCq5kvXT4o/6vw2bo1+t1mgQ+0tljKqzILqQV9KQC
         LprP3pV7fp/gwzLmpNSfU2FgCzaFUIdQtda0CazI2Yl/dXcIRVHSGQf1P5nQGlUQ1A2o
         +TRVVhXxvjJqCJQ3qjyvxgUhIogoSTNAHCii3o8W5NjnQmzB7XtTr80hHrl6Gqe2gwdr
         3Dyn0N/Ko/K6DwBDC1rZPRr9AswwTXzzwr/wKgmwLL9bc/X6PLGvuszD81GsdzLbRubR
         5SuwqxlgFcJlvYQxVcTLv/j62g/KPaIUwgrH2QPsC9FO67yo9av9xkDe9PZ6ozQ5zyuP
         eXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0TlJeFaiz7dJRdwgygJHKKabVfjrr5QSbdY+xLrVeFE=;
        b=Bf0Yq3cuXndzysJCGmaQQ8SXVMd/c3wL2VtLQqYj/kovmWBkAshTk8ZQRVJUzRlh2M
         xXaYIF8n/TLolfMKLTfgwJQ1KkvIRUfLd4W+0occ3YVB/QlhknppSgah6mdskw5mW0MS
         2y9OFZSYd9/uIYZPMrVewUFq3VC3suZsGmC9K11cnviQFgt/HXh/3Y4lRYlqWkvw5W+9
         hwyWwQaU8luDzR3c2Jm18Bw7mvaBtaATCoGAJQJoGoqPegbvm2kUljr0Jy2wIg+J0020
         lgsbWK4h5Oo+4ANNj8VIgG+xI7cT4Gdvtvmat8y4Jp2/E5V8Z0ZKsM7DKDdVnrJPS0aD
         OKTQ==
X-Gm-Message-State: AOAM533jPJCCxVUTIRogH0vx5Hb6UZgBuAxwg0aFllrFn45KeXpU8a/j
        7tSaiBHidCZ/XZ4Km2rlVIJaRA==
X-Google-Smtp-Source: ABdhPJydboPr2sH911862k1BuLse4EgcM8Y/5v7lTKBsfbN0O6OUdKMDW7vb6VT+lo0zI+MwdwIzsQ==
X-Received: by 2002:a05:6512:a88:b0:445:ce77:33d1 with SMTP id m8-20020a0565120a8800b00445ce7733d1mr4083544lfu.389.1647559299955;
        Thu, 17 Mar 2022 16:21:39 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 22-20020a05651c00d600b002496f5a7390sm41052ljr.89.2022.03.17.16.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 16:21:39 -0700 (PDT)
Message-ID: <0c477bfa-96de-17a1-69a6-25dc68e130f1@linaro.org>
Date:   Fri, 18 Mar 2022 02:21:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/4] cpufreq: qcom-hw: fix the race between LMH worker
 and cpuhp
Content-Language: en-GB
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220309223938.3819715-1-dmitry.baryshkov@linaro.org>
 <20220309223938.3819715-3-dmitry.baryshkov@linaro.org>
 <83344ef3-3b37-26d0-80a9-576d5e2f5098@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <83344ef3-3b37-26d0-80a9-576d5e2f5098@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/03/2022 02:10, Vladimir Zapolskiy wrote:
> Hi Dmitry,
> 
> On 3/10/22 12:39 AM, Dmitry Baryshkov wrote:
>> qcom_lmh_dcvs_poll() can be running when the cpu is being put offline.
>> This results in the following warnings and an oops. The driver would
>> disable the worker, but it happens closer to the end of
>> cpufreq_offline(). Change the locking in the qcom_lmh_dcvs_poll(), so
>> that the worker can not run in parallel with cpufreq_offline() call.
>>
>> [   55.650435] (NULL device *): dev_pm_opp_find_freq_floor: Invalid 
>> argument freq=00000000709ccbf9
>> [   55.659420] (NULL device *): Can't find the OPP for throttling: 
>> -EINVAL!
>> [   55.666329] Unable to handle kernel paging request at virtual 
>> address ffffadfba4bb6d81
>> [   55.674491] Mem abort info:
>> [   55.677363]   ESR = 0x96000004
>> [   55.680527]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [   55.686001]   SET = 0, FnV = 0
>> [   55.689164]   EA = 0, S1PTW = 0
>> [   55.692418]   FSC = 0x04: level 0 translation fault
>> [   55.697449] Data abort info:
>> [   55.700426]   ISV = 0, ISS = 0x00000004
>> [   55.704383]   CM = 0, WnR = 0
>> [   55.707455] swapper pgtable: 4k pages, 48-bit VAs, 
>> pgdp=00000000a98e9000
>> [   55.714354] [ffffadfba4bb6d81] pgd=0000000000000000, 
>> p4d=0000000000000000
>> [   55.721388] Internal error: Oops: 96000004 [#1] SMP
>> [   55.726397] Modules linked in:
>> [   55.729542] CPU: 7 PID: 162 Comm: kworker/7:1H Tainted: G S      
>> W         5.17.0-rc6-00100-g04890a1d9672 #724
>> [   55.746066] Workqueue: events_highpri qcom_lmh_dcvs_poll
>> [   55.751527] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS 
>> BTYPE=--)
>> [   55.758669] pc : cpufreq_cpu_get_raw+0x20/0x44
>> [   55.763233] lr : qcom_cpufreq_hw_get+0x10/0x64
>> [   55.767799] sp : ffff800009983d10
>> [   55.771207] x29: ffff800009983d10 x28: ffffaa13a4f2b000 x27: 
>> ffff7b31329f9305
>> [   55.778530] x26: ffffaa13a4f30af8 x25: ffffaa13a4f4e4c8 x24: 
>> ffff7b2ec2eda000
>> [   55.785851] x23: ffffffffffffffea x22: ffff7b2ec2e9fc18 x21: 
>> ffff7b2ec2e9fc00
>> [   55.793170] x20: 0000000000000100 x19: ffff7b2ec2e9fcc0 x18: 
>> ffffffffffffffff
>> [   55.800490] x17: 726620746e656d75 x16: 6772612064696c61 x15: 
>> ffff8000899839c7
>> [   55.807812] x14: 0000000000000000 x13: 0000000000000000 x12: 
>> 0000000000000000
>> [   55.815140] x11: ffff7b2ec2e9fc80 x10: ffffaa13a59a1a70 x9 : 
>> 0000000000000000
>> [   55.822468] x8 : ffff7b2eca6917c0 x7 : ffffaa13a528b000 x6 : 
>> 0000000000000001
>> [   55.829788] x5 : 0000000000040000 x4 : 000000000000024f x3 : 
>> 0000000000000000
>> [   55.837116] x2 : 0000000000000100 x1 : ffffaa13a4bb6d80 x0 : 
>> 000003e800000001
>> [   55.844439] Call trace:
>> [   55.846951]  cpufreq_cpu_get_raw+0x20/0x44
>> [   55.851155]  qcom_lmh_dcvs_poll+0x104/0x160
>> [   55.855452]  process_one_work+0x288/0x69c
>> [   55.859574]  worker_thread+0x74/0x470
>> [   55.863336]  kthread+0xfc/0x100
>> [   55.866568]  ret_from_fork+0x10/0x20
>> [   55.870246] Code: b00065c1 91360021 d503233f f8625800 (f8616800)
>> [   55.876501] ---[ end trace 0000000000000000 ]---
>>
>> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt 
>> support")
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 44d46e52baea..7c1bb002e1c3 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -296,6 +296,23 @@ static void qcom_lmh_dcvs_notify(struct 
>> qcom_cpufreq_data *data)
>>       struct dev_pm_opp *opp;
>>       unsigned int freq;
>> +    /*
>> +     * Synchronize against CPU going offline.
>> +     * cpufreq_offline() will get the write lock on policy->rwsem.
>> +     */
>> +retry:
>> +    if (unlikely(!down_read_trylock(&policy->rwsem))) {
>> +        mutex_lock(&data->throttle_lock);
>> +        if (data->cancel_throttle) {
>> +            mutex_unlock(&data->throttle_lock);
>> +            return;
>> +        }
>> +
>> +        mutex_unlock(&data->throttle_lock);
>> +
>> +        schedule();
>> +        goto retry;
>> +    }
> 
> do you see an option here to base the logic on policy->cpus mask value 
> instead of
> the semaphore lock status? I believe it should be possible, and, if so, 
> likely
> it would be preferable.

I used semaphore to remove a race with cpufreq_offline() code.
Using policy->cpus seems like a hack.

> 
>>       /*
>>        * Get the h/w throttled frequency, normalize it using the
>>        * registered opp table and use it to calculate thermal pressure.
>> @@ -314,9 +331,10 @@ static void qcom_lmh_dcvs_notify(struct 
>> qcom_cpufreq_data *data)
>>       /*
>>        * In the unlikely case policy is unregistered do not enable
>> -     * polling or h/w interrupt
>> +     * polling or h/w interrupt.
>> +     * If we are here, we have the policy->rwsem read lock,
>> +     * cancel_throttle can be toggled only with the write lock.
>>        */
>> -    mutex_lock(&data->throttle_lock);
>>       if (data->cancel_throttle)
>>           goto out;
>> @@ -331,7 +349,7 @@ static void qcom_lmh_dcvs_notify(struct 
>> qcom_cpufreq_data *data)
>>                    msecs_to_jiffies(10));
>>   out:
>> -    mutex_unlock(&data->throttle_lock);
>> +    up_read(&policy->rwsem);
>>   }
>>   static void qcom_lmh_dcvs_poll(struct work_struct *work)
>>
> 
> FWIW I can add my:
> 
> Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> 
> -- 
> Best wishes,
> Vladimir


-- 
With best wishes
Dmitry
