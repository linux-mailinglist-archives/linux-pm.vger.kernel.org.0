Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8622686C7E
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 18:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjBARMT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 12:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjBARMQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 12:12:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3D97C711
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 09:12:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qw12so37487008ejc.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIk8eTkHo9ODpAtWDwlPuTWs0EkV2MBMW4e9Fd7x0Bg=;
        b=Xd9IQ8CygVxb+cxSfiP0jxkT3PjUDD6/f4eBckP5BXvNvGVln9bD02GRS/vkVI7i4L
         2Gi7M8D/vin+eFf0XBTM4TQRKXhNkJX+vqskmCmmcsMSZam5s6nuEr+HRMrZJ+Hq6GTx
         wNIsopA4ascfllYHWOpPubwNcFkL6NJRm/Ig/Et1ImCxpnFdZvfEFdpApfYkWv3SDid4
         +7OGBu1HcIiDUworcCzhMQPwh0opbqc0YLCYsYnM5qPXhSdUFQtyy9UmemFgaF0bGy2F
         NNWhcww1mqBr0ME6Ond7HaAFnipwrsUeP8xQ1iXa4mel/AB3rSMzS+KLw+DvJ5K4lDz1
         Dt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIk8eTkHo9ODpAtWDwlPuTWs0EkV2MBMW4e9Fd7x0Bg=;
        b=PGfzfTxR2kuBrNX/sqPqTlwCYYoH3BoFtgQX8jEMDpcvBHbKJy4V6/0Mv0cm+THYPV
         DVFXLWpWd9cSFRQm/p1NszNlo06AhFKTI3oRLtglzX26QdOvAFVpv9QK4LE2/HqZx7vN
         7pT5kznGjllkqv+uddfJkKiww+6P8x3PMtG5rqqwrACMxmQbhCWuhjarL+sgMeiOZp4n
         7AopeYzAoPxrsSE/sp6AVafV+3TLHgOzurgVQMFTVOw/pdSgX5T7ThOW4zdSK+vxWfF9
         DOAsBqgDjOmmmbHxpVn7Vg3HzEIAOuDqiqOmEZQY6DwiimAOvotouoALpXr4usRzyZGn
         Tfeg==
X-Gm-Message-State: AO0yUKXk0RWGCvaBbcfOcs2kuv+OHgXcI5g78Ag1kSE6IKpwj6w7qWMV
        qyo0yCbKhfTLT88OHssAbbIf7A==
X-Google-Smtp-Source: AK7set/nFljA0OyJjPBvnk643gWGAo83BWFR6mbUZYcU9GRlajhBxQ3DgRyxoercqjfd1D96harVtg==
X-Received: by 2002:a17:906:16d4:b0:88a:7408:384c with SMTP id t20-20020a17090616d400b0088a7408384cmr3167010ejd.47.1675271529484;
        Wed, 01 Feb 2023 09:12:09 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ay10-20020a170906d28a00b00882f9130eb3sm7183306ejb.223.2023.02.01.09.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 09:12:09 -0800 (PST)
Message-ID: <2a0ce32c-d100-d5c3-ac0c-ccd7100a2c06@linaro.org>
Date:   Wed, 1 Feb 2023 19:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Jun Nie <jun.nie@linaro.org>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
 <20230201080227.473547-2-jun.nie@linaro.org>
 <515f4e9e-2804-e03a-26f5-f2d3ac331109@linaro.org>
 <71ba0d05-6183-95ef-9e45-cc3dd512475f@linaro.org>
 <CAA8EJpqyqC5D+O=KJnuZnWN4BwBOKcquN11nJfEp2WMSmJobBg@mail.gmail.com>
 <58a5e856-3e8b-d660-09ee-7a18b184452f@linaro.org>
 <1d33eb58-95d1-643d-52cc-2888ff0cea43@linaro.org>
 <86478fbd-590a-f94f-6cc1-f4d06a96826e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <86478fbd-590a-f94f-6cc1-f4d06a96826e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/02/2023 17:17, Bryan O'Donoghue wrote:
> On 01/02/2023 14:58, Dmitry Baryshkov wrote:
>> On 01/02/2023 16:45, Bryan O'Donoghue wrote:
>>> On 01/02/2023 13:41, Dmitry Baryshkov wrote:
>>>>>                           cci-cpufreq {
>>>>>                                   target-dev = <&cci_cache>;
>>>>>                                   cpu-to-dev-map-0 =
>>>>>                                           <  200000  200000000 >,
>>>>>                                           <  345600  200000000 >,
>>>>>                                           <  400000  200000000 >,
>>>>>                                           <  533330  297600000 >,
>>>>>                                           <  800000  297600000 >,
>>>>>                                           <  960000  297600000 >,
>>>>>                                           < 1113600  297000000 >,
>>>>>                                           < 1344000  595200000 >,
>>>>>                                           < 1459200  595200000 >,
>>>>>                                           < 1497600  595200000 >,
>>>>>                                           < 1651200  595200000 >;
>>>>>                                   cpu-to-dev-map-4 =
>>>>>                                           <  200000 200000000 >,
>>>>>                                           <  249600 200000000 >,
>>>>>                                           <  499200 297600000 >,
>>>>>                                           <  800000 297600000 >,
>>>>>                                           <  998400 595200000 >,
>>>>>                                           < 1113600 595200000 >;
>>>> These should map to existing opp entries.
>>>>
>>>> I ended up doing the interconnect driver that maps a clock to the
>>>> interconnect. Then I can use it in the cpu opp tables.
>>>>
>>>
>>> Can you point us at what it is you are proposing ?
>>
>> https://patchwork.kernel.org/project/linux-arm-msm/patch/20230120061417.2623751-9-dmitry.baryshkov@linaro.org/
>>
> Is there no driver code too ?

There are two parts, one is the 'CBF clock' driver, which just provides 
a clock, another part actually connects the clock and interconnect. 
Initially I implemented it as a part of the CBF driver (see 
https://patchwork.kernel.org/project/linux-arm-msm/patch/20230120061417.2623751-5-dmitry.baryshkov@linaro.org/), 
next revision will move the interconnect part to drivers/interconnect.

-- 
With best wishes
Dmitry

