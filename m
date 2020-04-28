Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD341BC077
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgD1OCo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgD1OCo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 10:02:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47046C03C1A9
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 07:02:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so24810393wrr.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rY3CRcAFqM0r3u1r5CyGUBjmbsvyJi4WnwH8VyT/XyA=;
        b=NqzyPql244U67mE1tPqX1J69YJBmhEdTnkfCDeye6vKrlqJMfJWy1ORLEaDWY4OGlJ
         RZzr5OBNiW7/k9YvDi1YJ4+4J35juV2CulQSwA9w3u82fwTVMTsD6ALA6Thd0+jMvGZ7
         e2fkZqe1Ze8dKit6fTPingsbuGxb8lq2ic2sCqtAgSuyoeQ954k3uv4Z/Mi1+lb+maa8
         3Kkqv1K0RkQHukDiju/yccJR0+qPZAmgeZ3dc/9ZHBEOCvyQ0UUU0kq/rcxc+JmCoS9m
         ltGLa4o/JydUKZUZbZUZkL8n7I3ArPkHvgzd7pFz0O8XkG8DkV5gaB5Z21Ms7tSyp/6m
         +GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rY3CRcAFqM0r3u1r5CyGUBjmbsvyJi4WnwH8VyT/XyA=;
        b=HZuNIRW8vB8kpFXoex4mSTUZ6mOTqL4v3/maf52rp12mIQMBMJmrhuMyiislmxCSDn
         DVgXak/4K22K4WWS2jvZRwRMX68SFOqfT20NO/lqtB2bBtxUNLOc9RxEz4I50OrMdiUh
         G6Mw6mzU60bSnGU1gJ8b/GySM8OvzkkLTI4eT+VCAsP0n6IqOmxytmoosVnzeE3ilkRV
         EgY0ssNQEkctXsMQG+oSJJ+mP8vu4IlnZsMwVvCh0dOtZVvsOPohACYJra/jIa1zcGDv
         lIuhTIkuJTenZrIFNNsIcG4gfY3RAzYoIAZn3gmqQFWZrAdA0abh77ECelKANea+uQB6
         7kaA==
X-Gm-Message-State: AGi0PuZGugBqhBO39gKBztoS1xtrloPnPzwazxEo6gBH8It8ZlkF6mhb
        KYhN5M2tDWLhCygYM/jD6VNwQw==
X-Google-Smtp-Source: APiQypIH72mVvQkqFyv4Z2EHmlevB6QwM5yecqL8pdgUOrd6RrWoeWQlFIiXGyU3Ux1FeYTWCNL39g==
X-Received: by 2002:a5d:420d:: with SMTP id n13mr36458743wrq.204.1588082562689;
        Tue, 28 Apr 2020 07:02:42 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id d5sm25743358wrp.44.2020.04.28.07.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 07:02:42 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] thermal: Add HiSilicon Kunpeng thermal driver
To:     "shenyang (M)" <shenyang39@huawei.com>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com
Cc:     linux-pm@vger.kernel.org, linuxarm@huawei.com,
        wangzhou1@hisilicon.com
References: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
 <1587455093-33876-3-git-send-email-shenyang39@huawei.com>
 <53ca3883-9155-c023-7916-10ec8cccf977@linaro.org>
 <0be585d3-1180-7b42-8b51-392a34793f70@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b1739246-3639-a6c1-6c0d-275eb2ab0d16@linaro.org>
Date:   Tue, 28 Apr 2020 16:02:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0be585d3-1180-7b42-8b51-392a34793f70@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/04/2020 13:58, shenyang (M) wrote:
> On 2020/4/27 20:13, Daniel Lezcano wrote:
>> On 21/04/2020 09:44, Yang Shen wrote:
>>> Support HiSilicon Kunpeng tsensor. the driver will report the max
>>> temperature for each core.
>>
>> As this is a new driver, can you give a bit more details of the hardware
>> in this description.
>>
>> A subsidiary question, why do you want to aggregate the temperatures in
>> this driver ?
>>
> 
> OK. In fact, there are five temperature sensors distributed in the SOC.
> And our strategy is to collect all temperatures and return the max to
> the interface.

The aggregation should be done in the thermal framework not in the driver.

Why not create one sensor per thermal zone, so giving the opportunity to
create different configurations with different cooling device ?

The function thermal_zone_of_get_sensor_id() will return the sensor id
associated with the thermal zone. So you can get inspiration from
imx_sc_thermal_probe() to instantiate multiple sensors from the thermal
zone.

The platform will end up with one thermal zone per core (assuming that
is what you have).

Each thermal zone will be cool down by the same cooling device, the
thermal framework will aggregate the decision and it will take the max
cooling level requested by each governor of each thermal zone, that ends
up to the same result as aggregating the temperature in the driver.

By doing this, you keep the possibility to do different combinations at
the DT level for better thermal control with different type of cooling
device.


> I will add a description of the hardware in the next version.
> 

[ ... ]

>>> +static int kunpeng_thermal_temp_correct(u32 tmp, u32 trim)
>>> +{
>>> +    int trim_high = KUNPENG_TSENSOR_TRIM_HIGH(trim);
>>> +    int trim_low = KUNPENG_TSENSOR_TRIM_LOW(trim);
>>> +    int val = KUNPENG_TSENSOR_TEMP_VAL(tmp);
>>> +
>>> +    if (trim_high == trim_low)
>>> +        return INT_MIN;
>>> +
>>> +    /* temperature of tsensor needs to be calibrated */
>>> +    return KUNPENG_TSENSOR_BASIC_TRIM_RANGE * (val - trim_low) /
>>> +           (trim_high - trim_low) + KUNPENG_TSENSOR_BASIC_TMP;
>>
>> Is it possible to give some details about why this is done?
>>
> 
> The hardware will measure the two standard temperature readings and
> write them into the registers, and the driver will calibrate the
> current readings according to the two standard temperature readings.
> 
> I will add this comment.
> 

[ ... ]

>> What is the IMU ?
>>
> 
> IMU is stand for Intelligent Management Unit. It functions as a
> supervisor and a manager of the chip. It has complete SoC
> components and is totally independent from the application processor
> system.
> So the IMU will read the tsensors temperature registers too.
> 
>> I don't see in this driver anything related to the sensors being shared
>> with something else.
>>
> 
> Yes. This driver use the device independently. But the driver cannot
> disable devices when it is removed.
> I add comments here to avoid user confusion.

I see, the kernel has no knowledge of it.

Thanks for the clarification.

>>> + */
>>> +static int kunpeng_thermal_remove(struct platform_device *pdev)
>>> +{
>>> +    struct thermal_zone_device *thermal_zone =
>>> platform_get_drvdata(pdev);
>>> +
>>> +    thermal_zone_device_unregister(thermal_zone);
>> Why not add a devm_thermal_zone_device_register() ? and get rid of this
>> function ?
>>
> 
> Do  you ask me to add this function in thermal_core.c?

Yes


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
