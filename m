Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B631CD391
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEKIO6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgEKIO5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 04:14:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD0C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 01:14:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m12so12113658wmc.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kGsLe4/aScJ9UT86wtST9mfAq55tuuv0S1YsnxoytDw=;
        b=KSbNrimuc1cr0aSysvuHqYvO73pXUvd6OySoiEoQhS2b7WCf9rl3wnrNnqgnYpJSqE
         F/NHIkHN0puc7DQtaiNWlgo0x+RyU7QyTCjCU+vaSUVGE6LcABfGT+8bqbsfozLKmYBY
         z5bquJCq+2Vq3AvviRbA3QE7NGaDkDP3XO4JfUOjiiMizZWfsgi7C/za2uqaiRc0cBWa
         CiBS+RXqFkUrOD5hG1ujS7WtMXKiPEunhSHBLIqpEf1JoF850QafZaNweXCBPE1vkouf
         Jzys/0oDdFRfV4Eq0iIbo6NarH5FP7rn+Ksfze0d9TMCwjWUVvEvk4Tq27e0DgZXdF8s
         zHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kGsLe4/aScJ9UT86wtST9mfAq55tuuv0S1YsnxoytDw=;
        b=K9YHs+w1qqDxYCva08tF3AgAXAQUevIAhiVirdM93xFmVkbLf8RkIymit/iWBM6QGp
         818562pe+aNNi0dhGrIdDuJhlz72lsPOjCb6kAy3GFc7TeTdi/gXEanZtF7a82v1a8AQ
         aIWc9iF5q1DjqmGdPSGqyfRojNsnWyK/I4ojSl3g/hDDAYV0IO9jZY2yN9so2x+S087O
         WiSM0IF3bBSI4yDIRPVYMBeUL6t+vEwaSnRpjJbrZV3UQwc+0Tp3kGV5yk3+LvrXG8Md
         XZzTKc/N5NWfQ1VlfgvIf9h3Q5Tqxvk9yPoKBTjBjsR2cJK+Y/iOtH/SRiuFe8U0asGt
         mXGQ==
X-Gm-Message-State: AGi0PuZiN/HXnAyOtqtvavbTuCwTs5nZc6M85NSc54h36N+KzqLwA+u3
        t+0DYNxAG2cmMq0NfEf3D12yQoe8PGg=
X-Google-Smtp-Source: APiQypJS3JH7rHikuxBOh9z+9/hagjvUZf6v3rXEy1eiDSaK0UDw+7zZ5slUpvSq7601UABG5cTovA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr29424883wmh.120.1589184895768;
        Mon, 11 May 2020 01:14:55 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:bc24:dba9:7b74:2aa9? ([2a01:e34:ed2f:f020:bc24:dba9:7b74:2aa9])
        by smtp.googlemail.com with ESMTPSA id h188sm27899672wme.8.2020.05.11.01.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 01:14:55 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] thermal: Add HiSilicon Kunpeng thermal driver
To:     Zhou Wang <wangzhou1@hisilicon.com>,
        "shenyang (M)" <shenyang39@huawei.com>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com
Cc:     linux-pm@vger.kernel.org, linuxarm@huawei.com
References: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
 <1587455093-33876-3-git-send-email-shenyang39@huawei.com>
 <53ca3883-9155-c023-7916-10ec8cccf977@linaro.org>
 <0be585d3-1180-7b42-8b51-392a34793f70@huawei.com>
 <b1739246-3639-a6c1-6c0d-275eb2ab0d16@linaro.org>
 <5EB65D33.80105@hisilicon.com>
 <96c7578e-25cf-d258-6505-8c1c631dbe82@linaro.org>
 <5EB8A9DC.9030004@hisilicon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <85f9f90f-2b67-4cfd-cc28-b14e037755b7@linaro.org>
Date:   Mon, 11 May 2020 10:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5EB8A9DC.9030004@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/05/2020 03:26, Zhou Wang wrote:
> On 2020/5/10 13:04, Daniel Lezcano wrote:
>> On 09/05/2020 09:35, Zhou Wang wrote:
>>> On 2020/4/28 22:02, Daniel Lezcano wrote:
>>>> On 28/04/2020 13:58, shenyang (M) wrote:
>>>>> On 2020/4/27 20:13, Daniel Lezcano wrote:
>>>>>> On 21/04/2020 09:44, Yang Shen wrote:
>>>>>>> Support HiSilicon Kunpeng tsensor. the driver will report the max
>>>>>>> temperature for each core.
>>>>>>
>>>>>> As this is a new driver, can you give a bit more details of the hardware
>>>>>> in this description.
>>>>>>
>>>>>> A subsidiary question, why do you want to aggregate the temperatures in
>>>>>> this driver ?
>>>>>>
>>>>>
>>>>> OK. In fact, there are five temperature sensors distributed in the SOC.
>>>>> And our strategy is to collect all temperatures and return the max to
>>>>> the interface.
>>>>
>>>> The aggregation should be done in the thermal framework not in the driver.
>>>>
>>>> Why not create one sensor per thermal zone, so giving the opportunity to
>>>> create different configurations with different cooling device ?
>>>
>>> Hi Daniel,
>>>
>>> In our SoC, we use IMU(Intelligent Management Unit) which is an out of band
>>> management processor to control cooling device. We use fans to cool CPU, one
>>> fan is for one SoC. So getting one temperature for one SoC is enough here.
>>>
>>> We also want to report temperature of the SoC from kernel thermal subsystem,
>>> so users get get SoC temperature from sysfs or user space tool, like Im-sensor.
>>> The goal of this driver is just to do this.
>>
>> Are you saying you don't care of any cooling devices from the kernel as
>> the IMU is taking care of it ?
> 
> Yes.
> 
>>
>> Do you have a pointer to a DT where the thermal zones are defined?
> 
> These sensors are in an aarch64 server system(Kunpeng920), which is based on ACPI.

Ah right.

What is the benefit of hiding the real hardware by taking the max value
of all the sensors and providing to the userspace a truncated view of
what is happening on the system?

Why not simply register a thermal_zone_device per sensor and get rid of
the 'max' value? So the userspace can have a correct view of the thermal
behavior of its system.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
