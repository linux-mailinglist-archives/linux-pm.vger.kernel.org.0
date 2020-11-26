Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4B2C57DA
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 16:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390022AbgKZPG6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 10:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389860AbgKZPG6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 10:06:58 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11EFC0617A7
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 07:06:57 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id u12so2499874wrt.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 07:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IIkKdgG3MXucw3bhwEXYRsXrYXFeeMD56CZk70OXd98=;
        b=V+KbBdJetUPHiz08XVz2xtuvEwzvDhJeNOUmMm3YHvh2VEIPgciQeMzpe4tdz6wfVb
         QeIZS5Jhe64Z1DnqB6YJMaKZtJP1/O3Hu9xDHIfayi/a9QvO5sqN+8vvr5utc/JD3mvO
         tZ0ZWKOS0fEsWIM8Y73mfAgAAyixQUjBYa1Z46lP765OQbSRlkfU7KNrLyr+gc8qXlhw
         8xfJHqye20Tmz/6n5gzjanwJUvw0PGq8sfWrxRRqjs5jxr+tqVmM4S5g9nhTBSpZiTFu
         mr8PgaB2MSAUNsB3weM34d0Lz0Mj2wGFXQLcheksSTdZKoZqUw7MLNxxXN0bOxv9ictB
         FPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IIkKdgG3MXucw3bhwEXYRsXrYXFeeMD56CZk70OXd98=;
        b=KeVsy479CFsTTgUdyow5mAENhqvOSAaeedlZbgG5Am00Yp86VHcSWgNXgKMvNuACNS
         Rc6eopKGqzmiItjdUGihFONz3n0mrCOMF0X/kvq9fe4m+q+juf7pjPSaJPZLtmz1bhag
         hBu/dnFqWFlCvoq7uDLdnENuY+EBDviFua5gKTLGf6umD9QT0pn8WNqejhbdWF+PK3xQ
         tBfFSRCSvlRPabdiTdnPf04+hpWWl9IvXRZmmj0st083AfwHAtUJ8aerROVAO9wT5vq3
         3FvRsGYoDJKrOo7AiZjxO+DFw9sgnGmyDokXOg/Sj48koxwtVHeW5Xure6aj+D9T5R9F
         32Fw==
X-Gm-Message-State: AOAM53048J1Z9Rn3NXpiaHxuZLS8gEfajJOE+sBNXUSC8LmVX4UzNI3R
        ZGSLvGrrnNP8QqLgynrRw/ziSw==
X-Google-Smtp-Source: ABdhPJxq4h0HMwUBOCYGysfOyb2AHk+w3QVN3uFDg1LPIyPzhTxlNA+HwvwT6MxVENkQalyVMf1L5Q==
X-Received: by 2002:adf:f2ce:: with SMTP id d14mr4389915wrp.94.1606403216354;
        Thu, 26 Nov 2020 07:06:56 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:c023:e75f:e8c4:d86? ([2a01:e34:ed2f:f020:c023:e75f:e8c4:d86])
        by smtp.googlemail.com with ESMTPSA id p11sm9662762wrj.14.2020.11.26.07.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:06:55 -0800 (PST)
Subject: Re: [PATCH v3 4/4] powercap/drivers/dtpm: Add CPU energy model based
 support
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rjw@rjwysocki.net, corbet@lwn.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilina@codeaurora.org, rkumbako@codeaurora.org, rui.zhang@intel.com,
        linux-arm-kernel@lists.infradead.org
References: <20201123214208.11007-1-daniel.lezcano@linaro.org>
 <20201123214208.11007-5-daniel.lezcano@linaro.org>
 <50db7265-3870-b977-6e41-b0a0ac3cdb94@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <68b0f4e5-bdff-a4a7-f59a-e2a4d0a138de@linaro.org>
Date:   Thu, 26 Nov 2020 16:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <50db7265-3870-b977-6e41-b0a0ac3cdb94@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,


On 26/11/2020 11:06, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 11/23/20 9:42 PM, Daniel Lezcano wrote:
>> With the powercap dtpm controller, we are able to plug devices with
>> power limitation features in the tree.
>>
> 
> [snip]
> 
>> +
>> +static void pd_release(struct dtpm *dtpm)
>> +{
>> +    struct dtpm_cpu *dtpm_cpu = dtpm->private;
>> +
> 
> Maybe it's worth to add:
> ------------------->8----------------
> if (freq_qos_request_active(&dtpm_cpu->qos_req))
>     freq_qos_remove_request(&dtpm_cpu->qos_req);
> -------------------8<---------------
> 
> If we are trying to unregister dtpm in error path due to freq_qos
> registration failure, a warning would be emitted from freq_qos.

Ah yes, good point.

>> +    freq_qos_remove_request(&dtpm_cpu->qos_req);
>> +    kfree(dtpm_cpu);
>> +}
> 
> [snip]
> 
>> +
>> +static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>> +{
>> +    struct dtpm *dtpm;
>> +    struct dtpm_cpu *dtpm_cpu;
>> +    struct cpufreq_policy *policy;
>> +    struct em_perf_domain *pd;
>> +    char name[CPUFREQ_NAME_LEN];
>> +    int ret;
>> +
>> +    policy = cpufreq_cpu_get(cpu);
>> +
>> +    if (!policy)
>> +        return 0;
>> +
>> +    pd = em_cpu_get(cpu);
>> +    if (!pd)
>> +        return -EINVAL;
>> +
>> +    dtpm = per_cpu(dtpm_per_cpu, cpu);
>> +    if (dtpm)
>> +        return power_add(dtpm, pd);
>> +
>> +    dtpm = dtpm_alloc(&dtpm_ops);
>> +    if (!dtpm)
>> +        return -EINVAL;
>> +
>> +    dtpm_cpu = kzalloc(sizeof(dtpm_cpu), GFP_KERNEL);
>> +    if (!dtpm_cpu) {
>> +        kfree(dtpm);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    dtpm->private = dtpm_cpu;
>> +    dtpm_cpu->cpu = cpu;
>> +
>> +    for_each_cpu(cpu, policy->related_cpus)
>> +        per_cpu(dtpm_per_cpu, cpu) = dtpm;
>> +
>> +    sprintf(name, "cpu%d", dtpm_cpu->cpu);
>> +
>> +    ret = dtpm_register(name, dtpm, __parent);
>> +    if (ret)
>> +        goto out_kfree_dtpm_cpu;
>> +
>> +    ret = power_add(dtpm, pd);
>> +    if (ret)
>> +        goto out_power_sub;
> 
> Shouldn't we call dtpm_unregister() instead?
> The dtpm_unregister() would remove the zone, which IIUC we
> are currently missing.
> 
>> +
>> +    ret = freq_qos_add_request(&policy->constraints,
>> +                   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
>> +                   pd->table[pd->nr_perf_states - 1].frequency);
>> +    if (ret)
>> +        goto out_dtpm_unregister;
> 
> Could this trigger different steps, starting from out_power_sub_v2
> below?
> 
>> +
>> +    return 0;
>> +
>> +out_dtpm_unregister:
>> +    dtpm_unregister(dtpm);
>> +    dtpm_cpu = NULL; /* Already freed by the release ops */
>> +out_power_sub:
>> +    power_sub(dtpm, pd);
> 
> I would change the order of these two above into something like:

Ok, I'll revisit the rollback routine.

> out_power_sub_v2:
>     power_sub(dtpm, pd);
> out_dtpm_unregister_v2:
>     dtpm_unregister(dtpm);
>     dtpm_cpu = NULL;
> 
>> +out_kfree_dtpm_cpu:
>> +    for_each_cpu(cpu, policy->related_cpus)
>> +        per_cpu(dtpm_per_cpu, cpu) = NULL;
>> +    kfree(dtpm_cpu);
>> +
>> +    return ret;
>> +}
> 
> IIUC power_sub() would decrement the power and set it to 0 for that
> dtmp, then the dtpm_unregister() would also try to decrement the power,
> but by the value of 0. So it should be safe.

Right.


Thanks for the review


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
