Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9859686CA1
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 18:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjBARRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 12:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjBARQ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 12:16:59 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC680977F
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 09:16:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h12so17977832wrv.10
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wr38XRGgvFXUxHBa8d+Ks/KuiYTFOwvWM5h9IiFhLX8=;
        b=XmrfqOPtuCeetmyqGs/bH/G/sTEkeIo/6JvbD6Jlxn6Efu++VNVbR0GR7G8P6hjegQ
         128hLlvbYA91b6W7m94mBB+H0eks6nSQXjwXZHE3Jo+rdAxhGdkj4sWBmiMJPoaPyTJ0
         FcTIMzrcQNtaDK5qfsq/npKCzaIiiaABEpz7f11Zf0JsdZwu92vwt6cBcRqRcwlDCRRS
         Pl4bHeOsHFhy/KjxeyrlzeRdIrGmj0X6qz5hk57ofSuhWu/XHBEu3nC3IZ48B0WOcIzc
         1hp9Rpd3qRWZFqB+oNfk1bWiRleGQ2OakPGrRXpkZeMbdt7IlEy56/2Awo770Na/impT
         XrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr38XRGgvFXUxHBa8d+Ks/KuiYTFOwvWM5h9IiFhLX8=;
        b=cBjnxZXReHoQ4Mc8AC/WIJjYVoGpxY01B7EsgJwlJgPi9NmEkhEgZ1XBqVUJoJP+7i
         UsWy8AHQClqkRUEGnamkJm2tdbmVcsGRbAkKV6rcZkF3tHlMLeM79A7CdSAbvImC/va5
         vc8tvDs0Eo7Kb+tSktFr+HquHRvTfXb/zPbiwdK4MRC3uQtAual/Qkdin73aowOebkd9
         c7wt7OZBDH/YJlq8fAgm7imW7dCBg2I+bFLBD9LkCZrIabJOh8CELb2/uIgoVCkEOBfa
         nh0/O8VIa1SvQ0TzzH9YDrGiL/O91Llbd/pWvmfflgWlaTy4U/Zct6bt4bfwkg8w/brM
         RQXA==
X-Gm-Message-State: AO0yUKWeVe/xxnGY5M3vAhwwQ+Mhuv6l728oyQFK5q4BRyfSnbBd/gyW
        ovJgkPqTifilkQjKCl5xkS4gbg==
X-Google-Smtp-Source: AK7set+N2m4euaJ1j3qjryKWqRm5bfdc9maiQA2BzwcJfWWO6xVi6bumDqUizwD0zDYDSblrrEd+mw==
X-Received: by 2002:a5d:4d84:0:b0:2bf:eb0e:ccb8 with SMTP id b4-20020a5d4d84000000b002bfeb0eccb8mr3197612wru.37.1675271815318;
        Wed, 01 Feb 2023 09:16:55 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b002be5401ef5fsm18329544wrd.39.2023.02.01.09.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 09:16:54 -0800 (PST)
Message-ID: <8eb9ba9b-dce8-5ece-6c2a-7e7a758c75ab@linaro.org>
Date:   Wed, 1 Feb 2023 17:16:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <2a0ce32c-d100-d5c3-ac0c-ccd7100a2c06@linaro.org>
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

On 01/02/2023 17:12, Dmitry Baryshkov wrote:
> On 01/02/2023 17:17, Bryan O'Donoghue wrote:
>> On 01/02/2023 14:58, Dmitry Baryshkov wrote:
>>> On 01/02/2023 16:45, Bryan O'Donoghue wrote:
>>>> On 01/02/2023 13:41, Dmitry Baryshkov wrote:
>>>>>>                           cci-cpufreq {
>>>>>>                                   target-dev = <&cci_cache>;
>>>>>>                                   cpu-to-dev-map-0 =
>>>>>>                                           <  200000  200000000 >,
>>>>>>                                           <  345600  200000000 >,
>>>>>>                                           <  400000  200000000 >,
>>>>>>                                           <  533330  297600000 >,
>>>>>>                                           <  800000  297600000 >,
>>>>>>                                           <  960000  297600000 >,
>>>>>>                                           < 1113600  297000000 >,
>>>>>>                                           < 1344000  595200000 >,
>>>>>>                                           < 1459200  595200000 >,
>>>>>>                                           < 1497600  595200000 >,
>>>>>>                                           < 1651200  595200000 >;
>>>>>>                                   cpu-to-dev-map-4 =
>>>>>>                                           <  200000 200000000 >,
>>>>>>                                           <  249600 200000000 >,
>>>>>>                                           <  499200 297600000 >,
>>>>>>                                           <  800000 297600000 >,
>>>>>>                                           <  998400 595200000 >,
>>>>>>                                           < 1113600 595200000 >;
>>>>> These should map to existing opp entries.
>>>>>
>>>>> I ended up doing the interconnect driver that maps a clock to the
>>>>> interconnect. Then I can use it in the cpu opp tables.
>>>>>
>>>>
>>>> Can you point us at what it is you are proposing ?
>>>
>>> https://patchwork.kernel.org/project/linux-arm-msm/patch/20230120061417.2623751-9-dmitry.baryshkov@linaro.org/
>>>
>> Is there no driver code too ?
> 
> There are two parts, one is the 'CBF clock' driver, which just provides 
> a clock, another part actually connects the clock and interconnect. 
> Initially I implemented it as a part of the CBF driver (see 
> https://patchwork.kernel.org/project/linux-arm-msm/patch/20230120061417.2623751-5-dmitry.baryshkov@linaro.org/), next revision will move the interconnect part to drivers/interconnect.
> 

Ah so just to be clear - discussing with Dmitry - CCI has its own set of 
fuses.

We have fusebin settings for clusterX and CCI.

So, I think we agree this means a separate driver for cci is warranted.

---
bod
