Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A735552386
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbiFTSFx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 14:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243503AbiFTSFx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 14:05:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1811819C13
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 11:05:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eo8so16263138edb.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XiRsA9p7clrxwNXOBW8YIibGQVXtYIrbRGbE9R7TwHo=;
        b=DCxlO++cgWCVcTYIDDwVkSYMJx9iJt8iSiIzVT3VJLGhMTa1506egO+dV5q7xOWZNN
         1CJNzcM+MxlJkd5OyNu9wWzhpBWEkctPtLV6+LRVq7SbU6AVW2UuIeO1Ln6KNU4PRZai
         J2UvJqBB2aiut4sf6Y2i5yzAGRNeHAKIVe+dygYVlcNiZBKWjWyzl7z9uLTeGSsW5qRe
         2129SMuWkg+8pNfXlcuPZUnHJBEpgqUmjHbik2030FBWfM+qKexnsyYHxUsMiAOWVPoR
         JatZ0ZANfYaA2fmm9+55osq1ELaQIrmFezNZb0blnbZidv5u3vusTOfFyEkjQhjroDrm
         9YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XiRsA9p7clrxwNXOBW8YIibGQVXtYIrbRGbE9R7TwHo=;
        b=33kTNikfV+efIex7QWE4C1kE1iOiVOcE/nIq/JRVASA7e+z4VVUMzqNXD4cLmOcj/w
         X+NgkCmgNFUOo0WNXaKyR3e5LRjTU5Uq+48t2njYmDBhVk/9qSK9M140NrnpZgTNeeb+
         5Yeq1r3Btm/m+kxnEowtfoth61Jx/5RlyXuTiMT+8reMPYT0+YhQQube22lI+rL7Tdnc
         ctKC2XIhNDCXlotCXgGIJIqIVV+IcjBZSM/NRUG+KmKdBw9lyCncoiueShQcSnsSBDCR
         ToVxVh57OxgjArMSN6hCLcIRnUpJEqI61mHYkRJ4SqvgHr2LSCq8Dc0AUmt6AGg08zXB
         jgqg==
X-Gm-Message-State: AJIora9SsiDXMhU9G+CbJ+/uOBGk96b7ZCSNy8NYPHRFy4v5GvsIyCBG
        W5+BkUSCSxrdlvfNeU+J2xk9HA==
X-Google-Smtp-Source: AGRyM1vUQM4S6zgcqheRKTmmHiCebR+hBiTpuCpYbnhSZ8yx2SsI0bL1MrWHLssBsHZKbIs7rLJu0w==
X-Received: by 2002:a50:ef04:0:b0:435:6560:abba with SMTP id m4-20020a50ef04000000b004356560abbamr20868899eds.3.1655748350584;
        Mon, 20 Jun 2022 11:05:50 -0700 (PDT)
Received: from [192.168.0.211] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kw25-20020a170907771900b00722dac96232sm629689ejc.126.2022.06.20.11.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:05:49 -0700 (PDT)
Message-ID: <54971435-aa26-acbf-7539-8484ee7e6b99@linaro.org>
Date:   Mon, 20 Jun 2022 20:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/9] dt-bindings: thermal: Define trips node in $defs
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     l.stach@pengutronix.de, Marco Felsch <m.felsch@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220617070847.186876-1-francesco.dolcini@toradex.com>
 <20220617070847.186876-2-francesco.dolcini@toradex.com>
 <b3311560-bbba-7fd9-7cda-65cfbd33458f@linaro.org>
 <20220620154810.GB23829@francesco-nb.int.toradex.com>
 <66ba39e3-5462-59c7-3831-20ba3ceed43b@linaro.org>
 <20220620174323.GC23829@francesco-nb.int.toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620174323.GC23829@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
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

On 20/06/2022 19:43, Francesco Dolcini wrote:
> On Mon, Jun 20, 2022 at 06:44:23PM +0200, Krzysztof Kozlowski wrote:
>> On 20/06/2022 17:48, Francesco Dolcini wrote:
>>> On Fri, Jun 17, 2022 at 06:02:39PM -0700, Krzysztof Kozlowski wrote:
>>>> but anyway this should not be done per-driver bindings, but
>>>> in more general way. Either the problem - using one DTS for different
>>>> temperature grades - looks generic or is wrong at the core. In the first
>>>> option, the generic bindings should be fixed. In the second case - using
>>>> same DTS for different HW is not correct approach and why only thermal
>>>> should be specific? I can imagine that cooling devices might have
>>>> different settings, regulator voltages for DVFS could be a bit different...
>>>
>>> Let me try to explain the problem I am trying to solve here.
>>>
>>> Currently the imx-thermal driver harcode the critical trip threshold,
>>> this trip point is read-only as it is considered a system property that
>>> should not be changed and it is set to a value that is less than the
>>> actual SoC maximum temperature. NO thermal_of driver used.
>>>
>>> Because of that there are systems that cannot work on some valid
>>> temperature range.
>>>
>>> We are currently looking at a solution that would be backward compatible
>>> with old device tree.
>>>
>>> I proposed the following:
>>> 1- just increase the threshold to the actual max value allowed according
>>>    to the SoC thermal grade. 
>>>
>>>    As easy as 
>>>
>>> -	data->temp_critical = data->temp_max - (1000 * 5);
>>> +	data->temp_critical = data->temp_max;
>>>    
>>>    in drivers/thermal/imx_thermal.c 
>>>
>>>    https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/
>>>
>>>    It was not considered good enough by Lucas since this is a overall
>>>    system design question, therefore should be configurable.
>>>
>>> 2- make the critical trip write-able from userspace/sysfs.
>>>
>>>    Daniel is against this since critical trip point is a system
>>>    property, not something the user should be allowed to change.
>>>
>>> 3- kernel parameter: https://lore.kernel.org/all/20220516190001.147919-1-francesco.dolcini@toradex.com/
>>>
>>>    Initially proposed by Daniel, but Marco did not like the idea.
>>>
>>> 4- New device tree property, fsl,tempmon-critical-offset, ditched also
>>>    by Marco
>>>
>>> 5- The current solution in this patch, with the existing trip points
>>>    that are hardcoded in the code exposed in the device tree as trips.
>>
>> Thanks for the explanation, I see the problem.
>>
>>>
>>> Ideally one could just implement the imx6/7 thermal sensor reading and
>>> just make use of the thermal_of driver, however that would break
>>> compatibility with a lot of existing system ... to me this is just a
>>> no-go.
>>
>> This I did not understand...  What is not implemented in thermal sensor
>> which would solve the issue? And why it cannot be implemented in
>> backwards compatible way?
> 
> Currently the imx_thermal driver defines its own trip points. How would
> you change the code to work with old device tree binaries using the
> generic thermal_of driver? imx_thermal would need to be changed to be a
> thermal sensor device, all the thermal trip point code removed.
> The driver is using thermal_zone_device_register().
> 
> Maybe I am missing an obvious solution, just correct me if I am wrong.

Probably you would need to support both solutions in the same driver,
based on presence of thermal-sensor-cells property. It won't be
particularly easy code, but maybe it is worth anyway... I am quite
surprised to see that IMX thermal driver does not use generic framework
and does not support generic bindings.

>> Your change is also not backwards friendly, which means existing boards
>> (old DTS) will not receive the update.
> The change proposed in this series is 100% backward compatible,
> the code-defined trip point are optionally overwritten by the dts.
> 
> 
>>> Adding only one set of thermal trip point in the dts (no thermal-grade
>>> specific set) could work in some specific scenario, however it does not
>>> work for me since I have the same dts files using different temperature
>>> grade SoC. I would need to update this in the firmware before starting
>>> Linux.
>>
>> 2. If the devices are in general compatible but have discoverable
>> differences, use one DTS, discover the differences and apply them
>> dynamically via driver (e.g. read the temperature offset from some
>> nvmem/OTP).
> 
> Yes, of course, I agree.
> That would work and it would be a reasonable approach in general, but it
> has one big drawback, it will force an update on the firmware on
> well-established products. Anyway, would you accept a change on the
> thermal_imx driver using a single set of trips from the dts, but not
> using the thermal_of driver?

More comments were not concering the Linux IMX thermal implementation
but rather bindings. From my point of view, you can use the same generic
thermal bindings even if your implementation does not use thermal_of.

> 
>>> Lucas, are you really that against the simple working solution I
>>> proposed initially [1]? I feel like I am running in circles ...
>>
>> Yes, because it is not generic and skips other similar cases, like
>> regulator voltages or battery properties. I can easily imagine that next
>> week someone comes with duplicated opp tables, then duplicated voltages,
>> then duplicated CPU nodes and finally we have one DTS for imx6 and imx7
>> but everything is in multiple variants. :)
> 
> The patch I proposed in [1] was just making the hard-coded threshold
> more reasonable, instead of setting the critical threshold to max-5 to
> just max. Your concern here does not really applies.
> 
> Here the patch https://lore.kernel.org/all/20220420091300.179753-1-francesco.dolcini@toradex.com/


Ah, that comment was not to me but to Lucas.

Best regards,
Krzysztof
