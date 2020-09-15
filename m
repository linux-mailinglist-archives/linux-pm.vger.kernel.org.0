Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7850F26AF85
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 23:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgIOVYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 17:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgIOVXy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 17:23:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F40FC06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:23:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a17so4774494wrn.6
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U4vBU3oWe9dELRdCn8qdtZpVCby9MX3wx5BJONCktfM=;
        b=kH+dSgCj5ikkoj3l26ItiM5aBmq9ccoXC+eP0bMX+EhhIqkBfMQHOFkixETK1/Bc3y
         6gmpsl095uZjQw8MV6fGWKPD/z3VvRFL5Q6YiBuYyCvtXx2Ai6PHU31z1iKbhnT4Wsal
         b4gRJKhH7KZk3ATxkr25TSxaVR/vIwDHfmyuusgdP7o1ZbB9mmIzWCwAlspDrQtPLlkQ
         jNxvfGsj5UvUPF/A2mU8rUGHp5y58OPQrooDya8fhZKiuDmmn1UnyJP8N6kR9gMVhKWb
         qKqODcV+5wpiyWFg8KGnoIc079tCk7ujqsuv8G65KbX1ePZvm47NimIMYnoSLNHVNnxQ
         VDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U4vBU3oWe9dELRdCn8qdtZpVCby9MX3wx5BJONCktfM=;
        b=JwpcrQovnlGCqTOp25awNyouy6bcuh9t5ydplqcCRHxuOUO0ei0otT3axb+c8tDmB9
         5Yr8C6AKbB/yh23ILvXPH0ZIDbJOWthdg+2a1PoLH4LokfjpwfztHIu/lg5ya2uReVDv
         H+rfdUsWeybF5C0kw1nnrEvp00ySmy6m9o5buhhSpr4mPaLrllnFXJYkhMjiSXgnteMO
         NlCU3h/V9wLeXKjdyrwTzt8LVlrYA/U/LjZGAS3aA2u/bJUFe/OwL+dFUuPqzVl9qi+v
         Y3y2XzXQ4WU334iocUyk+BiAAs3NmLB5QsTOL+mkFibDAf/hPTd6rl/hsWNEg1UmOHMt
         Oh6g==
X-Gm-Message-State: AOAM530WAj6zIdaXoVCcuq5Wt0cus6AInWxb/ggRZVDUJkeYMcSAxw+R
        5PuvsoHVGopX4USx8qucSJkXrw==
X-Google-Smtp-Source: ABdhPJzVmbzcbpwx4Bi4G9zg3BwdE2Jo7HoVd17VVFfllO62FrL18dS9jUEY/EljKr1bfZmVNdYXDw==
X-Received: by 2002:adf:e449:: with SMTP id t9mr23742970wrm.154.1600205031461;
        Tue, 15 Sep 2020 14:23:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:75c3:cda5:890e:8e1b? ([2a01:e34:ed2f:f020:75c3:cda5:890e:8e1b])
        by smtp.googlemail.com with ESMTPSA id q20sm1393652wmj.5.2020.09.15.14.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 14:23:50 -0700 (PDT)
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com>
 <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
 <20200915211309.GC2771744@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <808029c4-3a05-1926-934d-10739190ab9e@linaro.org>
Date:   Tue, 15 Sep 2020 23:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915211309.GC2771744@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/09/2020 23:13, Matthias Kaehlcke wrote:
> On Tue, Sep 15, 2020 at 10:55:52PM +0200, Daniel Lezcano wrote:
>> On 15/09/2020 19:58, Matthias Kaehlcke wrote:
>>> On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
>>>> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
>>>>> +Thermal folks
>>>>>
>>>>> Hi Rajendra,
>>>>>
>>>>> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
>>>>>> Hi Rob,
>>>>>>
>>>>>> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
>>>>>> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
>>>>>> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
>>>>>> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
>>>>>> calculating power values in mW, is there a need to document the property as something that *has* to be
>>>>>> based on real power measurements?
>>>>>
>>>>> Relative values may work for scheduling decisions, but not for thermal
>>>>> management with the power allocator, at least not when CPU cooling devices
>>>>> are combined with others that specify their power consumption in absolute
>>>>> values. Such a configuration should be supported IMO.
>>>>
>>>> The energy model is used in the cpufreq cooling device and if the
>>>> sustainable power is consistent with the relative values then there is
>>>> no reason it shouldn't work.
>>>
>>> Agreed on thermal zones that exclusively use CPUs as cooling devices, but
>>> what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
>>> GPU that specifies its power in mW?
>>
>> Well, if a SoC vendor decides to mix the units, then there is nothing we
>> can do.
>>
>> When specifying the power numbers available for the SoC, they could be
>> all scaled against the highest power number.
> 
> The GPU was just one example, a device could have heat dissipating components
> that are not from the SoC vendor (e.g. WiFi, modem, backlight), and depending
> on the design it might not make sense to have separate thermal zones.

Is it possible to elaborate, I'm not sure to get the point ?


>> There are so many factors on the hardware, the firmware, the kernel and
>> the userspace sides having an impact on the energy efficiency, I don't
>> understand why SoC vendors are so shy to share the power numbers...
> 
> nor do I, someone could just perform measurements to determine DPCs
> with the proper scale if Qualcomm refuses to provide them ...
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
