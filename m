Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A746686CAE
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 18:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjBARTY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 12:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjBARTX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 12:19:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BA54741C
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 09:19:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so53507435ejc.4
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 09:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zaEIeCiOrKHpCOtlR5RrYuYkrDweJDnGW6XjiZXdYqw=;
        b=S7J3fHKz7eoWsPIozlLaOcfDxUT6CU8eGxhhLcngjMrvGQujfyBhnoTo8zV8YbV7I5
         XKzpfcXL4/uH6WpTE9gL1It3699RLW3YxA6FwGgC31T8EnzAjWKUn9gikFOhdWYto/zI
         jH93fTOjKfm8Q9bjhgXEwJkaFraSLye8uhrIeK8oq7hL8HobfGPpr75HP5qjqVzjjeQZ
         YsHcbDa+3EPi5nl0nfsOQ+jU/FYp45RCyzX8nh51aTm4R2nxbJun3MkZm/1h5uCl39jO
         +jKnYTe4on6YFPGRimPmzSTeLEsICWEOZvdW666rTLjHPMtbMol9N2ZXzZujUlkBArAW
         ElRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zaEIeCiOrKHpCOtlR5RrYuYkrDweJDnGW6XjiZXdYqw=;
        b=Dzw9Ol3bGlGbz6aq0y/CSpLknAhm5HcuE5W+501H+RddzqPuIkjKbOjXxxgOzISZOY
         rtkkHPWGMsHATQ16F6HfrQQ630FrabjRcMBgJ3xoiHESoxXZ55Aaoz7v+VrEMQVuX/l1
         RX50QIRv4mKFn9t5gbjgsVPZ5om5vSSXUb4dw7L3ZjPvhL8mHPwrzumV0zfPfhDvTVt2
         UWbVfZh7CVQ4jZfykNzh6/OdJJF+kAEC9br50yZgOUrQz24jBTJNs6IQl/iAAzIQ+EhY
         aEFujYn/qUyIn6maepk7tt0+AuOPSR03MsqktDSSpmW4DvM3Bq5XkYOGvyBGf3mLqDeC
         dJlg==
X-Gm-Message-State: AO0yUKUN6HabtOQ7g16Twbwt3ssyejYxyqqiCmv6fkYvt+JqlQ8VWrus
        +50BAhWiY9Z6Vbh6LgXVSYotlw==
X-Google-Smtp-Source: AK7set8+DE09XcJZzYSicBIUvVpus1QzP6iRGUcYVUuihrlXVmIxky/e9/LE8wo+/+Zt86xjWOPzDQ==
X-Received: by 2002:a17:907:6d02:b0:877:5dbc:da84 with SMTP id sa2-20020a1709076d0200b008775dbcda84mr4102789ejc.72.1675271960025;
        Wed, 01 Feb 2023 09:19:20 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id qu21-20020a170907111500b00884c611145fsm6644803ejb.62.2023.02.01.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 09:19:19 -0800 (PST)
Message-ID: <9c86f610-b8f8-a6e5-396a-1f6339c8529f@linaro.org>
Date:   Wed, 1 Feb 2023 19:19:18 +0200
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
 <2a0ce32c-d100-d5c3-ac0c-ccd7100a2c06@linaro.org>
 <8eb9ba9b-dce8-5ece-6c2a-7e7a758c75ab@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <8eb9ba9b-dce8-5ece-6c2a-7e7a758c75ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/02/2023 19:16, Bryan O'Donoghue wrote:
> On 01/02/2023 17:12, Dmitry Baryshkov wrote:
>> On 01/02/2023 17:17, Bryan O'Donoghue wrote:
>>> On 01/02/2023 14:58, Dmitry Baryshkov wrote:
>>>> On 01/02/2023 16:45, Bryan O'Donoghue wrote:
>>>>> On 01/02/2023 13:41, Dmitry Baryshkov wrote:
>>>>>>>                           cci-cpufreq {
>>>>>>>                                   target-dev = <&cci_cache>;
>>>>>>>                                   cpu-to-dev-map-0 =
>>>>>>>                                           <  200000  200000000 >,
>>>>>>>                                           <  345600  200000000 >,
>>>>>>>                                           <  400000  200000000 >,
>>>>>>>                                           <  533330  297600000 >,
>>>>>>>                                           <  800000  297600000 >,
>>>>>>>                                           <  960000  297600000 >,
>>>>>>>                                           < 1113600  297000000 >,
>>>>>>>                                           < 1344000  595200000 >,
>>>>>>>                                           < 1459200  595200000 >,
>>>>>>>                                           < 1497600  595200000 >,
>>>>>>>                                           < 1651200  595200000 >;
>>>>>>>                                   cpu-to-dev-map-4 =
>>>>>>>                                           <  200000 200000000 >,
>>>>>>>                                           <  249600 200000000 >,
>>>>>>>                                           <  499200 297600000 >,
>>>>>>>                                           <  800000 297600000 >,
>>>>>>>                                           <  998400 595200000 >,
>>>>>>>                                           < 1113600 595200000 >;
>>>>>> These should map to existing opp entries.
>>>>>>
>>>>>> I ended up doing the interconnect driver that maps a clock to the
>>>>>> interconnect. Then I can use it in the cpu opp tables.
>>>>>>
>>>>>
>>>>> Can you point us at what it is you are proposing ?
>>>>
>>>> https://patchwork.kernel.org/project/linux-arm-msm/patch/20230120061417.2623751-9-dmitry.baryshkov@linaro.org/
>>>>
>>> Is there no driver code too ?
>>
>> There are two parts, one is the 'CBF clock' driver, which just 
>> provides a clock, another part actually connects the clock and 
>> interconnect. Initially I implemented it as a part of the CBF driver 
>> (see 
>> https://patchwork.kernel.org/project/linux-arm-msm/patch/20230120061417.2623751-5-dmitry.baryshkov@linaro.org/), next revision will move the interconnect part to drivers/interconnect.
>>
> 
> Ah so just to be clear - discussing with Dmitry - CCI has its own set of 
> fuses.
> 
> We have fusebin settings for clusterX and CCI.
> 
> So, I think we agree this means a separate driver for cci is warranted.

Yes.

-- 
With best wishes
Dmitry

