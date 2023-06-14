Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC542730916
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 22:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjFNUSl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 16:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbjFNUSj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 16:18:39 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC62684
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 13:18:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b203891b2cso16333481fa.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686773915; x=1689365915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3z4LksCb5ueTglC0JGeQEDUNVhjTTokwLYl+JChFA8=;
        b=vDTbEIhSwCMFEKapNjV49THldsXX7vksRYltEL5iyE6zAL0oQx4MTo0RPZn6BJ8MSZ
         Sl6d+GSF1y01QOBS3k9R6GkSqlnOEKIFGYUpgl8EdJ7N0LGOnqhP1tDxsl9TLojqkoZF
         uW+mkbOjsNZnJOEzipz2oXR8SCgdyNk++8Hz+nVtR3WjN6b+BOcnSxV1PzHN2kbDsrS3
         F1UzmqXZxZ1tWMNKfjtTQFeNb5AKvDtuMduSYlT+kaM22SVHYqi7oq3t64EDzW9enXNS
         owM8yhtdjPdfFz+A46g0tRdf4jUgtHX3g+OkGjVxcO2S77Ix2QIgWuft2ATQeBqUiLWw
         TALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686773915; x=1689365915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3z4LksCb5ueTglC0JGeQEDUNVhjTTokwLYl+JChFA8=;
        b=ivDtp7cTFF/V6d59xrHlc/sYXgrhv8D00H3H9kkMlUB8A/64kmnglQmSnGoaVqXgbj
         n0PFeC0KIjXpT06e5Dke2yzSdyxG4ea9ebsFIPRbAGqHi6GRH8+6O+uG1YlRvbU6Dw+I
         irXGva2iAtceKg9scycRBb/rgPso9W9lCZYt3qYzCHyEO0wmpcc3XwOmJAfv1OuYbgAm
         UQlJ9IrQr5VAM1it8VY5gBrjio8u3gDIDXW4IwOX3TW7RIo/b2XAN1lH59sRrvx24fuD
         6zZ7pU74y4FNURa1z11adDWM3uLYU8ZwbYQpUVQaHMQ5YUUipuYN66338DApQ9kzJdBy
         W+og==
X-Gm-Message-State: AC+VfDzRxYa1rEGkYWboq8GMsAPNCO+M0FMtjWC00q60h/VMVTkhYw6d
        O4j9PYFA4v71JYa+s1+7PPOW4hmUHtT8Qm6XMa8=
X-Google-Smtp-Source: ACHHUZ5sMkvfIdJJwZT2OQw2vgr5nn41GHBSNx10KZQJ/bfZWcCuhvBqnM/dNYLNbJRlYvOCO4q47A==
X-Received: by 2002:a2e:9d19:0:b0:2b0:a4b1:df6 with SMTP id t25-20020a2e9d19000000b002b0a4b10df6mr6522791lji.49.1686773915411;
        Wed, 14 Jun 2023 13:18:35 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d21-20020a2eb055000000b002aeee2a093csm2714757ljl.59.2023.06.14.13.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 13:18:34 -0700 (PDT)
Message-ID: <f19546be-54fd-00fb-293c-c228e0d6d5d3@linaro.org>
Date:   Wed, 14 Jun 2023 23:18:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/18] ARM: qcom: apq8064: support CPU frequency scaling
Content-Language: en-GB
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <6486dcef.050a0220.4c054.4c59@mx.google.com>
 <99a68056-a4c9-d475-9245-e0802ffe4c89@linaro.org>
 <64889725.5d0a0220.9f037.0597@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <64889725.5d0a0220.9f037.0597@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/06/2023 19:19, Christian Marangi wrote:
> On Mon, Jun 12, 2023 at 05:20:02PM +0300, Dmitry Baryshkov wrote:
>> On 11/06/2023 19:27, Christian Marangi wrote:
>>> On Mon, Jun 12, 2023 at 08:39:04AM +0300, Dmitry Baryshkov wrote:
>>>> Implement CPUFreq support for one of the oldest supported Qualcomm
>>>> platforms, APQ8064. Each core has independent power and frequency
>>>> control. Additionally the L2 cache is scaled to follow the CPU
>>>> frequencies (failure to do so results in strange semi-random crashes).
>>>
>>> Hi, can we talk, maybe in private about this interconnect-cpu thing?
>>
>> Hi, sure. Feel free to ping me on IRC (lumag) or via email. Or we can just
>> continue our discussion here, as it might be interesting to other people
>> too.
>>
> 
> Don't know if here is the right place to discuss my concern and problem
> with L2 scaling on ipq8064...

I think I will try segregating L2 data to l2-cache device node (I saw 
your comment that it is not populated by default. I'll have to fix this).

> 
>>> I see you follow the original implementation of the msm_bus where in
>>> practice with the use of the kbps the correct clock and voltage was set.
>>> (and this was also used to set the fabric clock from nominal to fast)
>>>
>>> On ipq806x and I assume other SoC there isn't always a 1:1 map of CPU
>>> freq and L2 freq. For example on ipq8064 we have max CPU freq of 1.4GHz
>>> and L2 freq of 1.2GHz, on ipq8065 we have CPU 1.7GHz and L2 of 1.4GHz.
>>
>> This is also the case for apq8064. The vendor kernel defines 15 frequencies
>> for L2 cache clock, but then for some reasons all PVS tables use just 3
>> entries from these 15.
>>
> 
> Eh who knows why they did this... Probably the hfpll was limited or they
> notice no temp/power benefits were present with scaling with that much
> of steps?
> 
>>> (and even that is curious since I used the debug regs and the cxo
>>> crystal to measure the clock by hardware (yes i ported the very ancient
>>> clk-debug to modern kernel and it works and discovered all sort of
>>> things) the L2 (I assume due to climitation of the hfpll) actually can't
>>> never reach that frequency (1.4GHz in reality results to something like
>>> 1.2GHz from what I notice a stable clock is there only with frequency of
>>> max 1GHz))
>>
>> I would like to point you to https://github.com/andersson/debugcc/, which is
>> a userspace reimplementation of clk-debug. We'd appreciate your patches
>> there.
>>
> 
> Hi, I wasted some good time on the implementation but manage to make it
> work and proposed a pr! I assume the thing can be reused for apq8064 if
> someone ever wants to have fun with that.

Thanks a lot! Generally I think that debugcc is a very valuable 
debugging tool and it should be getting more attention from the 
community. With the chips newer than 8064 it is easy enough to add new 
platform data.

> 
>>> So my idea was to introduce a simple devfreq driver and use the PASSIVE
>>> governor where it was added the possibility to link to a CPU frequency
>>> and with interpolation select the L2 frequency (and voltage)
>>
>> I stumbled upon this idea, when I was working on the msm8996 and it's CBF
>> clock (CBF = interconnect between two core clusters). While it should be
>> possible to use DEVFREQ in simple cases (e.g. L2 clock >= max(CPU clock), if
>> possible). However real configurations are slightly harder.
>> E.g. for the purpose of this patchset, the relationship for apq8064 is the
>> following (in MHz):
>>
>>   CPU    L2
>>   384    384
>>   486    648
>>   594    648
>>   702    648
>> ....    ...
>> 1026    648
>> 1134   1134
>> ....   ....
>> 1512   1134
>> ....   ....
>>
>> It should be noted that msm8960 also used just three values for the L2 cache
>> frequencies. From what I can see, only msm8x60 made L2 freq tightly follow
>> the CPU frequency.
>>
> 
> Happy to test and found a common path... With the merge of the cpu opp
> and nvmem work, I was just about to send the L2 devfreq driver... And
> also the fabric devfreq driver. But I wonder if I can use this
> interconnect thing for the 2 task.
> 
>>>   From some old comments in ancient qsdk code it was pointed out that due
>>> to a hw limitation the secondary cpu can't stay at a high clock if L2
>>> was at the idle clock. (no idea if this is specific to IPQ806x) So this
>>> might be a cause of your crash? (I also have random crash with L2
>>> scaling and we are planning to just force the L2 at max frequency)
>>
>> It might be related. It was more or less the same story with msm8996, which
>> was either 'maxcpus=2' or scaling the CBF clock.
>>
> 
> Might be a krait defect... and this is pretty bad...

I don't know if it is a defect or just a misfeature. Anyway, we know 
that L2 should be clocked high enough and we can cope with it.

> 
>>> But sorry for all of this (maybe) useless info. I checked the other
>>> patch and I didn't understand how the different L2 frequency are
>>> declared and even the voltage. Is this something that will come later?
>>> I'm very interested in this implementation.
>>
>> The L2 frequency (<&kraitcc 4>) is converted into bandwidth vote, which then
>> goes into the OPP tables. But please also see the discussion started at the
>> patch 15.
>>
> 
> I didn't notice you were defining multiple supply, scaling the voltage
> under the hood with that trick. It's not a bad idea but as pointed out
> it might be problematic, since is seems krait is very sensible with L2
> frequency and voltage so we should simulate the original implementation
> as close as possible...

It was my original intention,as the vendor kernel does it in the 
vdd-mem, vdd-dig, vdd-core, L2-freq, core freq order. I did not expect 
that voltages are scaled after BW casts. (this describes freq-increase 
case, in case of decreasing frequency the order is inverted).

> 
>>>
>>>>
>>>> Core voltage is controlled through the SAW2 devices, one for each core.
>>>> The L2 has two regulators, vdd-mem and vdd-dig.
>>>>
>>>> Depenency: [1] for interconnect-clk implementation
>>>>
>>>> https://lore.kernel.org/linux-arm-msm/20230512001334.2983048-3-dmitry.baryshkov@linaro.org/
>>>>
>>>
>>
>> -- 
>> With best wishes
>> Dmitry
>>
> 

-- 
With best wishes
Dmitry

