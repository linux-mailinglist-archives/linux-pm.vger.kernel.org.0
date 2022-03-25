Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE54E7C3D
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 01:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiCYT1X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Mar 2022 15:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiCYT1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2022 15:27:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF7425D5ED
        for <linux-pm@vger.kernel.org>; Fri, 25 Mar 2022 12:00:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h11so11490059ljb.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Mar 2022 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V+mqdl/8yeQYl/IuysCLzhmn9y/CpmqU+8Go5SfPM1w=;
        b=xIWQ/+DTLejUwomBZ0gLI3Na0Yst9Q5CF47xgJzx4QyFvzcSJ80q1ptsiEho7rbcf0
         /sdy4W66Z4Z0xunh+lMqJObMWzwj1O100nCROYZTsPeF1p5JEwZOWUO0ZqNutqWfJDiu
         YG0tAvndqF1zSLveQC2i3jsd+NZvUbJCE5/usAzkQ73VwMpqQVPyyrb5s54UxA5MDucP
         /tqYPRnaivPNrXoUcl7zD7Ronm7hjQKtqCKIRL6gpNOb6+engVawD0oUkXvgBA4026ao
         d9huTAptGjD+/ybRzBgP5TC4lAruiiILOMumnLDrC3E0ukHz0SdAmyKYrm7l6yOQtPdl
         uSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V+mqdl/8yeQYl/IuysCLzhmn9y/CpmqU+8Go5SfPM1w=;
        b=PW2a1wur233yi+s9gMGzF5Fw8kF5Rxrc+tfXg0U36V6gpeMB7vkroNtXGvAqnVaAHU
         0ZC6lfkIxZp9wY4bWDi3iFXEsNEUy66iGpbgjowN803RULPvH5cI7MVEj8o0HTIDchf8
         EdftjkkZ8YRJ18RrhS2bwBk6HWwsSREWQZaV+BFIjkjsK95KRabEaC2BT3fge8dcFb82
         4+MIiZ0XtnCQzbglqCYpJHU0geHgZqFnYovsu7csgJj1gtUFoGyAqnjODpSgYxGWh0Ff
         lguUC9cwhMkTYcUgh+zW6V0e3KoooItGa+/BL3xOZVSr+ybtkhi+x9uDKcUgmeNOJ33I
         5ecw==
X-Gm-Message-State: AOAM530uGHQqSgQS/Jckow8HmLu6tQja46dZXl0CdUVnabw2bxGGrZxT
        mt6kn7StZQQ1I5wmhWRDYrRCLc0nN08NfA==
X-Google-Smtp-Source: ABdhPJy4+0fo8WFN/jfJd8qX8ZRY8Ouo8jbMZ/1RHx1QyBjtR7ao7I4CHYfeYCcfYjaiQF/lzscWXA==
X-Received: by 2002:ac2:5ff2:0:b0:448:7f69:889d with SMTP id s18-20020ac25ff2000000b004487f69889dmr8780218lfg.202.1648234352533;
        Fri, 25 Mar 2022 11:52:32 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r9-20020ac25f89000000b0044a1008c5d7sm790323lfe.234.2022.03.25.11.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 11:52:31 -0700 (PDT)
Message-ID: <d7966059-c003-d49a-a5ce-bff1e0604b58@linaro.org>
Date:   Fri, 25 Mar 2022 21:52:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/4] cpufreq: qcom-hw: fix the race between LMH worker
 and cpuhp
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220309223938.3819715-1-dmitry.baryshkov@linaro.org>
 <20220309223938.3819715-3-dmitry.baryshkov@linaro.org>
 <YjyVgx08RiFDYwT5@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YjyVgx08RiFDYwT5@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/03/2022 19:00, Bjorn Andersson wrote:
> On Wed 09 Mar 14:39 PST 2022, Dmitry Baryshkov wrote:
> 
>> qcom_lmh_dcvs_poll() can be running when the cpu is being put offline.
>> This results in the following warnings and an oops. The driver would
>> disable the worker, but it happens closer to the end of
>> cpufreq_offline(). Change the locking in the qcom_lmh_dcvs_poll(), so
>> that the worker can not run in parallel with cpufreq_offline() call.
>>
>> [   55.650435] (NULL device *): dev_pm_opp_find_freq_floor: Invalid argument freq=00000000709ccbf9
>> [   55.659420] (NULL device *): Can't find the OPP for throttling: -EINVAL!
>> [   55.666329] Unable to handle kernel paging request at virtual address ffffadfba4bb6d81
>> [   55.674491] Mem abort info:
>> [   55.677363]   ESR = 0x96000004
>> [   55.680527]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [   55.686001]   SET = 0, FnV = 0
>> [   55.689164]   EA = 0, S1PTW = 0
>> [   55.692418]   FSC = 0x04: level 0 translation fault
>> [   55.697449] Data abort info:
>> [   55.700426]   ISV = 0, ISS = 0x00000004
>> [   55.704383]   CM = 0, WnR = 0
>> [   55.707455] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000a98e9000
>> [   55.714354] [ffffadfba4bb6d81] pgd=0000000000000000, p4d=0000000000000000
>> [   55.721388] Internal error: Oops: 96000004 [#1] SMP
>> [   55.726397] Modules linked in:
>> [   55.729542] CPU: 7 PID: 162 Comm: kworker/7:1H Tainted: G S      W         5.17.0-rc6-00100-g04890a1d9672 #724
>> [   55.746066] Workqueue: events_highpri qcom_lmh_dcvs_poll
>> [   55.751527] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   55.758669] pc : cpufreq_cpu_get_raw+0x20/0x44
>> [   55.763233] lr : qcom_cpufreq_hw_get+0x10/0x64
>> [   55.767799] sp : ffff800009983d10
>> [   55.771207] x29: ffff800009983d10 x28: ffffaa13a4f2b000 x27: ffff7b31329f9305
>> [   55.778530] x26: ffffaa13a4f30af8 x25: ffffaa13a4f4e4c8 x24: ffff7b2ec2eda000
>> [   55.785851] x23: ffffffffffffffea x22: ffff7b2ec2e9fc18 x21: ffff7b2ec2e9fc00
>> [   55.793170] x20: 0000000000000100 x19: ffff7b2ec2e9fcc0 x18: ffffffffffffffff
>> [   55.800490] x17: 726620746e656d75 x16: 6772612064696c61 x15: ffff8000899839c7
>> [   55.807812] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>> [   55.815140] x11: ffff7b2ec2e9fc80 x10: ffffaa13a59a1a70 x9 : 0000000000000000
>> [   55.822468] x8 : ffff7b2eca6917c0 x7 : ffffaa13a528b000 x6 : 0000000000000001
>> [   55.829788] x5 : 0000000000040000 x4 : 000000000000024f x3 : 0000000000000000
>> [   55.837116] x2 : 0000000000000100 x1 : ffffaa13a4bb6d80 x0 : 000003e800000001
>> [   55.844439] Call trace:
>> [   55.846951]  cpufreq_cpu_get_raw+0x20/0x44
> 
> While I don't have the line numbers, I presume this would be cause by
> policy->cpus being empty and:
> 
>     int cpu = cpumask_first(policy->cpus);
> 
> returning >= nr_cpu_ids, which means that the get_cpu_device(cpu); on
> the next line will return NULL and then we keep playing opp on that
> NULL?
> 
> 
> Seems like this would be exactly the same mistake as I did wrt
> policy->cpus vs policy->related_cpus and we don't actually need the
> specific CPU, we just need a cpu device in the frequency domain.
> 
> As such we should actually do cpumaks_first(policy->related_cpus)
> instead.
> 
>> [   55.851155]  qcom_lmh_dcvs_poll+0x104/0x160
>> [   55.855452]  process_one_work+0x288/0x69c
>> [   55.859574]  worker_thread+0x74/0x470
>> [   55.863336]  kthread+0xfc/0x100
>> [   55.866568]  ret_from_fork+0x10/0x20
>> [   55.870246] Code: b00065c1 91360021 d503233f f8625800 (f8616800)
>> [   55.876501] ---[ end trace 0000000000000000 ]---
>>
>> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 44d46e52baea..7c1bb002e1c3 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -296,6 +296,23 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>>   	struct dev_pm_opp *opp;
>>   	unsigned int freq;
>>   
>> +	/*
>> +	 * Synchronize against CPU going offline.
>> +	 * cpufreq_offline() will get the write lock on policy->rwsem.
>> +	 */
>> +retry:
>> +	if (unlikely(!down_read_trylock(&policy->rwsem))) {
>> +		mutex_lock(&data->throttle_lock);
>> +		if (data->cancel_throttle) {
>> +			mutex_unlock(&data->throttle_lock);
>> +			return;
>> +		}
>> +
>> +		mutex_unlock(&data->throttle_lock);
>> +
>> +		schedule();
>> +		goto retry;
>> +	}
> 
> And doing that instead would remove the need for doing this crazy
> locking between the cpufreq core and qcom driver.

I didn't like the idea that the notifier is running in parallel with the 
cpufreq code modifying the policy. We can check if that's an issue 
separately.

> 
> Above change would be trivial and -rc material.
> 
> Regards,
> Bjorn
> 
>>   	/*
>>   	 * Get the h/w throttled frequency, normalize it using the
>>   	 * registered opp table and use it to calculate thermal pressure.
>> @@ -314,9 +331,10 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>>   
>>   	/*
>>   	 * In the unlikely case policy is unregistered do not enable
>> -	 * polling or h/w interrupt
>> +	 * polling or h/w interrupt.
>> +	 * If we are here, we have the policy->rwsem read lock,
>> +	 * cancel_throttle can be toggled only with the write lock.
>>   	 */
>> -	mutex_lock(&data->throttle_lock);
>>   	if (data->cancel_throttle)
>>   		goto out;
>>   
>> @@ -331,7 +349,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>>   				 msecs_to_jiffies(10));
>>   
>>   out:
>> -	mutex_unlock(&data->throttle_lock);
>> +	up_read(&policy->rwsem);
>>   }
>>   
>>   static void qcom_lmh_dcvs_poll(struct work_struct *work)
>> -- 
>> 2.34.1
>>


-- 
With best wishes
Dmitry
