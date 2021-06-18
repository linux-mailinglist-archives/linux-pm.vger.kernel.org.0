Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85DB3AD49F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 23:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhFRV5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 17:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhFRV5b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 17:57:31 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD13C061574
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 14:55:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c9so14559263qkm.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nF8NeUljq4C2NCfttpjUfqcwd2814FwpZLu1UqPsH7c=;
        b=w5qTdpCgve7Txzi1+CWpuew+k/v1jhh9E4oMXi4gNZ7mdergFslhDKw4en5qhwJo2k
         UvvXpW6XVp1bbPdnSFGKZORMEINM4pe+H2WUJ0jUJoiqNi2Xv08nDy4RCM6RUfPu0vsN
         2FF5LMg7ekh6TmR28Aa40v2U7GWH4N+rUglA9fBBt8ace/AJtVDOOVmEZMmzdSenbaIn
         LaBKJhpvhchz9esn2bRC0Z82LNbK7jdc8bQ0vg9O6piwnEJcJJTapHhljEr73lIROT9A
         pwEFAYcMsNnJjt+B0mbWQiu3hqe+4EtI+iavkilWWdiyFRzltqqpfetyhLUCcIoGaO85
         6SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nF8NeUljq4C2NCfttpjUfqcwd2814FwpZLu1UqPsH7c=;
        b=JfWZLlHwDffxVGDye6SgbbzcSWigYHeqP6FVH0O7amIFkWOoro+HSR4N2shfMkaAl4
         +Ge1YbPpepdlazrPRQrqn9gxqWaXrS4G6AaMyXUSnKB2MAYcCkd0VTZ92PLPKox9DN1a
         FzbSF2AV2jtzFXE8Pl3GJUSbQnSOHOdKxFkWUvRjdGEmpDq+tQWXa7gwHb3Nth+BGlmb
         iiOfnx/sVzMUjwW0MumWJGObuNgwqHZi2LfJTpSFYsbCJeBaSRQ8nkCx4H+dSpKvYhyY
         V957sQRxofgCTAgrW1AgmNNKZ6n+1n00IDWLBSj+wBxAiPl+XC0y22/p+lbKGotUKUwM
         orkA==
X-Gm-Message-State: AOAM532ul5chCo9lGxfMbap0jq5Nq6rqjO34xicEy6yIVVwk8LGcvpKI
        tpzVBWOxkoiwXFDGeX1ZZ25izg==
X-Google-Smtp-Source: ABdhPJy93brvNdosgkB7q9Q/j9iGHd8JELUI0RZqZgV2RWevhaynBKYXWCQRtDyMrsZ0FX1b/PgP+w==
X-Received: by 2002:a05:620a:1a88:: with SMTP id bl8mr10936410qkb.480.1624053320398;
        Fri, 18 Jun 2021 14:55:20 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id m3sm2455132qkk.27.2021.06.18.14.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 14:55:20 -0700 (PDT)
Subject: Re: [PATCH 3/5] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
 <20210608222926.2707768-4-thara.gopinath@linaro.org>
 <YMzjBvkbITbSIzwf@builder.lan>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <4e6f96c0-5f9c-bd35-7b6a-95ac6e907dab@linaro.org>
Date:   Fri, 18 Jun 2021 17:55:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YMzjBvkbITbSIzwf@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/18/21 2:16 PM, Bjorn Andersson wrote:
> On Tue 08 Jun 17:29 CDT 2021, Thara Gopinath wrote:
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> [..]
>> @@ -305,6 +383,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   
>>   	index = args.args[0];
>>   
>> +	lmh_mitigation_enabled = of_property_read_bool(pdev->dev.of_node, "qcom,support-lmh");
> 
> Rather than adding a new interrupt _and_ a flag to tell the driver that
> this new interrupt should be used, wouldn't it be sufficient to just see
> if the interrupt is specified?

Yes. you are right. It should be. Though when I wrote it there was some 
reason which I forget now. I will remove it.

-- 
Warm Regards
Thara (She/Her/Hers)

> 
>> +
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>>   	if (!res) {
>>   		dev_err(dev, "failed to get mem resource %d\n", index);
>> @@ -329,6 +409,11 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   		goto unmap_base;
>>   	}
>>   
>> +	if (!alloc_cpumask_var(&data->cpus, GFP_KERNEL)) {
>> +		ret = -ENOMEM;
>> +		goto unmap_base;
>> +	}
>> +
>>   	data->soc_data = of_device_get_match_data(&pdev->dev);
>>   	data->base = base;
>>   	data->res = res;
>> @@ -347,6 +432,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   		goto error;
>>   	}
>>   
>> +	cpumask_copy(data->cpus, policy->cpus);
>>   	policy->driver_data = data;
>>   
>>   	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
>> @@ -370,6 +456,20 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>   			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
>>   	}
>>   
>> +	if (lmh_mitigation_enabled) {
>> +		data->lmh_dcvs_irq = platform_get_irq(pdev, index);
>> +		if (data->lmh_dcvs_irq < 0) {
> 
> This will be -ENXIO if the interrupt isn't specified and <0 for other
> errors, so you should be able to distinguish the two failure cases.
> 
> Regards,
> Bjorn
> 
>> +			ret = data->lmh_dcvs_irq;
>> +			goto error;
>> +		}
>> +		ret = devm_request_irq(dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
>> +				       0, "dcvsh-irq", data);
>> +		if (ret) {
>> +			dev_err(dev, "Error %d registering irq %x\n", ret, data->lmh_dcvs_irq);
>> +			goto error;
>> +		}
>> +		INIT_DEFERRABLE_WORK(&data->lmh_dcvs_poll_work, qcom_lmh_dcvs_poll);
>> +	}
>>   	return 0;
>>   error:
>>   	kfree(data);
>> -- 
>> 2.25.1
>>


