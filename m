Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604AB3D9000
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhG1OB7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbhG1OB6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 10:01:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47904C061764
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 07:01:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h14so4154835lfv.7
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HkzKATWQiJzwj9+f4qauTnrP7HOjchHXfR7sVxWkLd4=;
        b=Z2XfG/9ykSGrj/xt0ovI/QuVJGiIPo8ma/mlpZecQ5KGkrdwUl0o4wNcgsrB5M6CPy
         k+LRIVKdGv37hjQyssh7sOp4ReHsKazfJU8T2WDcfrvC/knSTILmluDY0QDU/Ev5vgAr
         o9pGwdEvesM0RkO4A5bCBuH1Zuq64s3JJJf+OUpGokUqIjL7s/mZw4+Td14Tb+Qes4ge
         AvfPzyB90XtBS5DYsTZHW+8RWQTx7tX1AYN3lldi1CDuFzT7cD5Ez6DMLV1WIfHu89iF
         N4+wbNvwWcIAOwcD7tR6wMUsNunVzqXRYy0Dwm3t12W9ILVQPFKbvd0V3qDg8bScDJW4
         3cnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HkzKATWQiJzwj9+f4qauTnrP7HOjchHXfR7sVxWkLd4=;
        b=Ac/Z9BxFgfry47m5I65zzJ4xIOFCbfiiCa5XeoNBq/GtiWaEDmur61Eks1RiTxnSRo
         LICCjOyj0rKnaqSf7gUxuZElVqUXi36D7NSNIKX1KslCc4ydphFSJ5agmBu3CkLEjTxt
         5uSdnBOC8kJ2oGrFVx/QFCWfSn9z0AwiWXUvhLRzBPPdn92M55mDVg/3FSXxNLypeAvJ
         NuSdUFun2bLCI5XAb+85gyZIbU70lqGnEl02kVJTx7qedP8ayCC1hyqdJL3i82mQ0pxa
         y9bEW/3iutCOnhAP9EjrnuKZ5GN4BAhCrmnJr+UGC3bNDygf0A+kQ8jhOc5l5BVUqXV4
         jiLg==
X-Gm-Message-State: AOAM532ddFmUuyko15jrfm6JnqeGFtAUvO6XM9xpoL00FppZ6n7fm2GI
        S5a7MO96qNqyqbjgm4kmTwzL1Q==
X-Google-Smtp-Source: ABdhPJyX6gIG42z6TXISGYD1AbaGbevxFM65kRY0gZHdDQyTHym/lcLS3jklXa5hLa0Zm/Hprzll9g==
X-Received: by 2002:a05:6512:400c:: with SMTP id br12mr21749856lfb.268.1627480913485;
        Wed, 28 Jul 2021 07:01:53 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l13sm514250ljj.43.2021.07.28.07.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 07:01:53 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] arm64: dts: sc7180: Add required-opps for i2c
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rojay@codeaurora.org,
        stephan@gerhold.net
References: <YPHpsO5LlQRQxj9y@yoga>
 <CAE-0n53CHD8c7C4ETWRgzmZmFSCcBw46wSs4pKbYMRjA_tD3yg@mail.gmail.com>
 <YPHxfHPC/faq/y+J@yoga>
 <CAE-0n50qx80cMFPJ1x9rc+EMR1L+j2CUMyDjWAbnE9mPHjf-TQ@mail.gmail.com>
 <YPIBK/NJgBNZVI8Y@yoga> <12711a61-e16c-d2bc-6e04-ab94c7551abe@codeaurora.org>
 <YPXQNFYKfH/xZxFY@yoga> <bc79ea3e-4981-8f9b-f9a7-59cb972047a7@codeaurora.org>
 <YP2Y6qs5P5mb2jzE@yoga> <b6b315ae-ee68-6ba8-7453-f28dace3d8d2@codeaurora.org>
 <YQDTImwRhp8juvKh@yoga>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <f73f1c31-dc31-32f9-d7d8-1aa3233b0040@linaro.org>
Date:   Wed, 28 Jul 2021 17:01:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQDTImwRhp8juvKh@yoga>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/07/2021 06:46, Bjorn Andersson wrote:
> On Tue 27 Jul 02:35 CDT 2021, Rajendra Nayak wrote:
> 
>>
>> On 7/25/2021 10:31 PM, Bjorn Andersson wrote:
>>> On Mon 19 Jul 23:29 CDT 2021, Rajendra Nayak wrote:
>>>
>>>>
>>>>
>>>> On 7/20/2021 12:49 AM, Bjorn Andersson wrote:
>>>>> On Mon 19 Jul 04:37 CDT 2021, Rajendra Nayak wrote:
>>>>>
>>>>>>
>>>>>>
>>>>>> On 7/17/2021 3:29 AM, Bjorn Andersson wrote:
>>>>>>> On Fri 16 Jul 16:49 CDT 2021, Stephen Boyd wrote:
>>>>>>>
>>>>>>>> Quoting Bjorn Andersson (2021-07-16 13:52:12)
>>>>>>>>> On Fri 16 Jul 15:21 CDT 2021, Stephen Boyd wrote:
>>>>>>>>>
>>>>>>>>>> Quoting Bjorn Andersson (2021-07-16 13:18:56)
>>>>>>>>>>> On Fri 16 Jul 05:00 CDT 2021, Rajendra Nayak wrote:
>>>>>>>>>>>
>>>>>>>>>>>> qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 MHz)
>>>>>>>>>>>> Though qup-i2c does not support DVFS, it still needs to vote for a
>>>>>>>>>>>> performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
>>>>>>>>>>>> requirement.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Sounds good, but...
>>>>>>>>>>>
>>>>>>>>>>>> Use 'required-opps' to pass this information from
>>>>>>>>>>>> device tree, and also add the power-domains property to specify
>>>>>>>>>>>> the CX power-domain.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> ..is the required-opps really needed with my rpmhpd patch in place?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Yes? Because rpmhpd_opp_low_svs is not the lowest performance state for
>>>>>>>>>> CX.
>>>>>>>>>
>>>>>>>>> On e.g. sm8250 the first available non-zero corner presented in cmd-db
>>>>>>>>> is low_svs.
>>>>>>
>>>>>> what rail is this? the mmcx? Perhaps it does not support RET.
>>>>>> cx usually supports both collapse state and RET.
>>>>>>
>>>>>
>>>>> That was the one I was specifically looking at for the MDSS_GDSC->MMCX
>>>>> issue, so it's likely I didn't look elsewhere.
>>>>>
>>>>>>>>
>>>>>>>> Indeed. On sc7180 it's not the first non-zero corner. I suppose
>>>>>>>> retention for CX isn't actually used when the SoC is awake so your
>>>>>>>> rpmhpd patch is putting in a vote for something that doesn't do anything
>>>>>>>> at runtime for CX? I imagine that rpmh only sets the aggregate corner to
>>>>>>>> retention when the whole SoC is suspended/sleeping, otherwise things
>>>>>>>> wouldn't go very well. Similarly, min_svs may be VDD minimization? If
>>>>>>>> so, those first two states are basically states that shouldn't be used
>>>>>>>> at runtime, almost like sleep states.
>>>>>>>>
>>>>>>>
>>>>>>> But if that's the case, I don't think it's appropriate for the "enabled
>>>>>>> state" of the domain to use any of those corners.
>>>>>>
>>>>>> I rechecked the downstream kernels where all this voting happens from within
>>>>>> the clock drivers, and I do see votes to min_svs for some clocks, but Stephen is
>>>>>> right that RET is not something that's voted on while in active state.
>>>>>>
>>>>>> But always going with something just above the ret level while active will also
>>>>>> not work for all devices, for instance for i2c on 7180, it needs a cx vote of
>>>>>> low svs while the rail (cx) does support something lower than that which is min svs.
>>>>>> (why can't it just work with min svs?, I don't know, these values and recommendations
>>>>>> come in from the voltage plans published by HW teams for every SoC and we just end up
>>>>>> using them in SW, perhaps something to dig further and understand which I will try and
>>>>>> do but these are the values in voltage plans and downstream kernels which work for now)
>>>>>>
>>>>>
>>>>> So to some degree this invalidates my argumentation about the
>>>>> enabled_corner in rpmhpd, given that "enabled" means a different corner
>>>>> for each rail - not just the one with lowest non-zero value.
>>>>
>>>> Right, it might work in some cases but might not work for all.
>>>>
>>>
>>> Which makes it way less desirable.
>>>
>>> The enable state for rpmhpd power domains doesn't meet my expectations
>>> for how a power domain should behave,
>>
>> Right and that's perhaps because these are not the usual power-domains,
>> which have one "on/active" state and one or more "off/inactive" states (off/ret/clock-stop)
>> Rpmhpd has multiple "on/active" states, and whats "on/active" for one consumer
>> might not be "on/active" for another, so this information is hard to be managed
>> at a generic level and these requests in some way or the other need to come
>> in explicitly from the resp. consumers.
>>
> 
> I think it's fine if we just acknowledge that this is how the rpmhpd
> domains works.
> 
> But I am worried about how we're going to handle the case where the
> consumer is indirectly referencing one of these power-domains using a
> subdomain (gdsc).

With the proper subdomain relationship in place and with Ulf's patches, 
this seems to be handled correctly. gdsc sets proper level for the 
parent power domain, which gets voted and unvoted by the core pm code 
when gdsc's power domain is powered on or off.

> And the open question is if a solution to that problem will solve this
> problem as well, or if we need to have this and some mechanism to
> describe the "on state" for the parent of a subdomain.


-- 
With best wishes
Dmitry
