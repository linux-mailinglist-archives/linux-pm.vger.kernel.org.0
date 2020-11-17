Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251A22B6C16
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 18:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgKQRos (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 12:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgKQRoq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 12:44:46 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF5FC0613CF
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 09:44:46 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d12so24014806wrr.13
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 09:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2KngzT5ko8rC3OE2ve8gvahOiuba+uhDRJQ9LOXl0+U=;
        b=U26KxbAXVUUUUL1n5lEOI+uP+pQIx39CGrKbakbVvqZkamGw28UVz32cC9lesi6lRN
         DnJF9yjA3ZI8kYVJclfFfFyDGAGn5xWyQIDffoZEVhpf0mkP1VzJ7LhYgua60W/ZollW
         0X7rqlIdAmvayvJPqL/lS5ZN9kDohVdOqdJ8z/KNTygSOkXxahF6ek5qVzoo+dsH/k63
         OyTe0Ly/CEP7C180c3iNgNVAgwzZLoDTs+ULga4gFfNVEhl+n1x7EaNujowpADJt5t28
         rbi6TPAcwU+XNmiTh2JCMxQV8Niy+g60OEC7RJtuDeO3d7vL7aY0YlQ0EbTyArlm5mTF
         1PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2KngzT5ko8rC3OE2ve8gvahOiuba+uhDRJQ9LOXl0+U=;
        b=i4rSHEFKh9sIOiE/8/n3UsMeGDt/eR1RQeZ2/hQrpNB6MkhJICMAwCX2vVEe4sAE3Q
         IMM7U+trbtjfFwh2MHJb881BNoYxU9nSnfCuK2n5lMWo/JEcoLoqxeIJxIm3COvgexH4
         jKpxkp6OjybQvYWst5xvjvmKYN9Z+O2ew4iXTogH4vpK1z7o9WyrPbqGwfdLVlB9SsIA
         KSABDxKajXxXUKwIM5dnLDjS+ECkk712xA7fHe0Dg0NfoKvqB/Owa/vG1jXcnKXDX9js
         RzApmtvsrjDqZJ/wU61kydlU/P+v+OBJ2y7DQc1jvUO5Nb+fs6HYH2JfCp0OUrkgXqqG
         7LKQ==
X-Gm-Message-State: AOAM5333f9DQCY6/4k2hS4yMHjNbUCGz3FfDrQneOIWhPOAHUsxDK79m
        WXknfQCSM5S2D9ow3URWEuaJXw==
X-Google-Smtp-Source: ABdhPJxxEywh7zcSdCOpHrh5uQpARJrYhQeE0KoFgQi1md4vXIramoI6QvgWCCjx/ZqOFlHoqWGY9g==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr597996wrn.427.1605635084716;
        Tue, 17 Nov 2020 09:44:44 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:5150:1004:6c70:8db9? ([2a01:e34:ed2f:f020:5150:1004:6c70:8db9])
        by smtp.googlemail.com with ESMTPSA id n11sm27882644wru.38.2020.11.17.09.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 09:44:43 -0800 (PST)
Subject: Re: [PATCH v2 4/4] powercap/drivers/dtpm: Add CPU energy model based
 support
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rjw@rjwysocki.net, ilina@codeaurora.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rkumbako@codeaurora.org,
        rui.zhang@intel.com
References: <20201116152649.11482-1-daniel.lezcano@linaro.org>
 <20201116152649.11482-5-daniel.lezcano@linaro.org>
 <c467cb4d-2226-e558-e340-cd5764490078@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6c9db999-0846-cd42-a061-c638197b5661@linaro.org>
Date:   Tue, 17 Nov 2020 18:44:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c467cb4d-2226-e558-e340-cd5764490078@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/11/2020 14:15, Lukasz Luba wrote:
> Hi Daniel,
> 
> Only one small comment regarding the setup of 'power_limit'.
> 
> On 11/16/20 3:26 PM, Daniel Lezcano wrote:
>> With the powercap dtpm controller, we are able to plug devices with
>> power limitation features in the tree.
>>
>> The following patch introduces the CPU power limitation based on the
>> energy model and the performance states.
>>
>> The power limitation is done at the performance domain level. If some
>> CPUs are unplugged, the corresponding power will be subtracted from
>> the performance domain total power.
>>
>> It is up to the platform to initialize the dtpm tree and add the CPU.
>>

[ ... ]

>> +
>> +    dtpm = per_cpu(dtpm_per_cpu, cpu);
>> +    if (dtpm)
>> +        return power_add(dtpm, pd);
> 
> The dtpm->power_limit is not incremented in this path, when a new
> CPU joins the cluster.
> Is it correct?

Yes, you are right, there is something missing here. It does not change
the behavior of the power capping, but the value will be inconsistent in
the tree.

> Or maybe we need something like:
> ------------------------------>8---------------------
>         if (dtpm) {
>                 ret = power_add(dtpm, pd);
>                 if (!ret)
>                         dtpm->power_limit = dtpm->power_max;
>                 return ret;
>         }
> ------------------------8<---------------
> 
> The power_max should be updated after successful power_add().
> It would disturb user set value in power_limit, though (described
> below).
> 
> 
>> +
>> +    dtpm = dtpm_alloc();
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
>> +    ret = power_add(dtpm, pd);
>> +    if (ret)
>> +        goto out_kfree_dtpm_cpu;
>> +
>> +    dtpm->power_limit = dtpm->power_max;
> 
> Here, the power_limit will be set only once with power_max
> for a single CPU. I am not sure, but maybe we can simple say:
> 
> dtpm->power_limit = dtpm->power_max * cpumask_weight(policy->related_cpus)
> 
> an avoid touching it later (?)
> 
> Because this function can be called in runtime, when the power_limit
> was already set by userspace, the hotpluging in/out/in... CPU shouldn't
> change this limit.

Hmm, I have to think about it because the power_limit is always less or
equal to power_max.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
