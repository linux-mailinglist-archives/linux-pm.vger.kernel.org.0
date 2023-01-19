Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C4F674799
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jan 2023 00:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjASX4t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Jan 2023 18:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjASX4s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2023 18:56:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706C9F3A6
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2023 15:56:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso2519124wms.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2023 15:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7zfu79BDE69Zh0TrvdzIrEU2jRKWV7JH3x7U+ZjYWM0=;
        b=SJhxSwdZNU7z2+p1g3yIQBnyVza86mIdK28LITnqaoKYY+K/HVrfV1WLttbwLO2Nkp
         ZVhAQP84sWr8ifdX7EhC+kLFhh02b9sNd76wq7HJO8LywM5aZecSuvBTvNq7LzYNwI3C
         oD6zQDjq2WRlwUFPrcE0IZFE96cBBkUvPd50ksZb6lLZkT1LaAdfycv19codiQlbN4l0
         PSbsi2XsqIwN18gSevvEN4hiSjFoV3Tkat6RwmwnfYU1NI+z8Bbt/md1qbumq192GNEq
         cROMbpkJDxGYfgUvuqXd+RgiufUo24/8mMqXDFDOwvPNk21IixWNf7DPeZJ0U40dcCIn
         A/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zfu79BDE69Zh0TrvdzIrEU2jRKWV7JH3x7U+ZjYWM0=;
        b=HcgyPXaOnlEQdMi87lD8TIGK9KPMVblO2z44WLLatPGzTW6E3RPWxjybS1f+U2a8zy
         0OugjvUaROCdFJ1WYSSeFAy6y+CTh73ByDkW7ogZDy0rqjBe89omGSz0rbOW2ljJcVUQ
         0XJ3ix3aj48tdxWXsZO7OoY6qSP7EnjFEiHlEDpcZdpGepZQi8czxSe6Xgyiddh7JayX
         SUEj4D4UbtGaywSry8jEVkLY0MvYvZXqddu+MiJb2VOI553gwzI5ku5yaa/f5yJHet4T
         aW9xDuYuX4QJCxpLpWl4jRa+edjcmNQrn3SEwbMhq0UJBlXC7IoBTRz6+hhSVv388fPG
         /bsA==
X-Gm-Message-State: AFqh2krzkqOkk5UcCTKrIDtFbfQ8fh6sB1ytHUpuuopKy8Gdglfsu1tu
        qqqSxjRWEDiPBr4v9m53kLMiXaWSjVuKS+N4
X-Google-Smtp-Source: AMrXdXt4ndAKiOX5/+V2WXaYeC/vcQeAB0NXODmWZRk/BIIRlfvQ7Yl95THd31XadduqSNeOpdHRZg==
X-Received: by 2002:a05:600c:1c83:b0:3da:fbd8:59a0 with SMTP id k3-20020a05600c1c8300b003dafbd859a0mr12107833wms.11.1674172604830;
        Thu, 19 Jan 2023 15:56:44 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c1c0800b003d9862ec435sm606542wms.20.2023.01.19.15.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 15:56:44 -0800 (PST)
Message-ID: <35dcb764-e340-5fe7-6637-cdb5f84266ce@linaro.org>
Date:   Thu, 19 Jan 2023 23:56:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] interconnect: Skip call into provider if initial bw is
 zero
Content-Language: en-US
To:     Vivek Aknurwar <quic_viveka@quicinc.com>, djakov@kernel.org
Cc:     quic_mdtipton@quicinc.com, quic_okukatla@quicinc.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
 <83a7bfed-3b16-3d01-b1b2-f197252bd0b1@linaro.org>
 <5e1f37ba-494a-19d2-e412-7631508ab142@linaro.org>
 <151790dd-02e5-a1f5-aab5-360f39e21c57@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <151790dd-02e5-a1f5-aab5-360f39e21c57@quicinc.com>
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

On 19/01/2023 22:18, Vivek Aknurwar wrote:
> Hi Bryan,
> Thanks for taking time to review the patch.
> 
> On 1/13/2023 5:40 PM, Bryan O'Donoghue wrote:
>> On 14/01/2023 01:24, Bryan O'Donoghue wrote:
>>> On 13/01/2023 22:07, Vivek Aknurwar wrote:
>>>> Currently framework sets bw even when init bw requirements are zero 
>>>> during
>>>> provider registration, thus resulting bulk of set bw to hw.
>>>> Avoid this behaviour by skipping provider set bw calls if init bw is 
>>>> zero.
>>>>
>>>> Signed-off-by: Vivek Aknurwar <quic_viveka@quicinc.com>
>>>> ---
>>>>   drivers/interconnect/core.c | 17 ++++++++++-------
>>>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>>>> index 25debde..43ed595 100644
>>>> --- a/drivers/interconnect/core.c
>>>> +++ b/drivers/interconnect/core.c
>>>> @@ -977,14 +977,17 @@ void icc_node_add(struct icc_node *node, 
>>>> struct icc_provider *provider)
>>>>       node->avg_bw = node->init_avg;
>>>>       node->peak_bw = node->init_peak;
>>>> -    if (provider->pre_aggregate)
>>>> -        provider->pre_aggregate(node);
>>>> -
>>>> -    if (provider->aggregate)
>>>> -        provider->aggregate(node, 0, node->init_avg, node->init_peak,
>>>> -                    &node->avg_bw, &node->peak_bw);
>>>> +    if (node->avg_bw || node->peak_bw) {
>>>> +        if (provider->pre_aggregate)
>>>> +            provider->pre_aggregate(node);
>>>> +
>>>> +        if (provider->aggregate)
>>>> +            provider->aggregate(node, 0, node->init_avg, 
>>>> node->init_peak,
>>>> +                        &node->avg_bw, &node->peak_bw);
>>>> +        if (provider->set)
>>>> +            provider->set(node, node);
>>>> +    }
>>>> -    provider->set(node, node);
>>>>       node->avg_bw = 0;
>>>>       node->peak_bw = 0;
>>>
>>> I have the same comment/question for this patch that I had for the 
>>> qcom arch specific version of it. This patch seems to be doing at a 
>>> higher level what the patch below was doing at a lower level.
>>>
>>> https://lore.kernel.org/lkml/1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org/T/#m0c90588d0d1e2ab88c39be8f5f3a8f0b61396349
>>>
>>> what happens to earlier silicon - qcom silicon which previously made 
>>> explicit zero requests ?
> 
> This patch is to optimize and avoid all those bw 0 requests on each node 
> addition during probe (which results in rpmh remote calls) for upcoming 
> targets.

So why not change it just for rpmh ?

You are changing it for rpm here, as well as for Samsung and NXP 
interconnects.

Taking rpm as an example, for certain generations of silicon we make an 
explicit zero call.

https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_bimc.c#L1367

Here's the original RPM commit that sets a zero

https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d91d108656a7a44a6dfcfb318a25d39c5418e54b

>>> https://lore.kernel.org/lkml/1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org/T/#m589e8280de470e038249bb362634221771d845dd
>>>
>>> https://lkml.org/lkml/2023/1/3/1232
>>>
>>> Isn't it a better idea to let lower layer drivers differentiate what 
>>> they do ?
> 
> AFAIU lower layer driver can/should not differentiate between normal 
> flow calls vs made as a result from probe/initialization of driver. 
> Hence even bw 0 request is honored as like client in general wish to 
> vote 0 as in an normal use case.

But surely if I vote zero, then I mean to vote zero ?

Do we know that for every architecture and for every different supported 
that ignoring a zero vote is the right thing to do ?

I don't think we do know that.

https://lore.kernel.org/linux-arm-msm/20230116132152.405535-1-konrad.dybcio@linaro.org/

I think for older rpm this is a departure from long existing logic.

Maybe its entirely benign but, IMO you should be proposing this change 
at the rpmh level only, not at the top level across multiple different 
interconnect arches.

---
bod
