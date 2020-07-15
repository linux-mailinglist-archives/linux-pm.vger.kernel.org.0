Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26091221841
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 01:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGOXKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 19:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgGOXKq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 19:10:46 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E222C061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 16:10:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j10so3298014qtq.11
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 16:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mLrSPcSP9NHr2sVXnCdLqh0ohhYXZ2KFJWAV+LYwv1A=;
        b=ANY+5vdGSeAT/ltQoNROcJ9ixl8Rc/x2Z00hZxkjpCYlnOWkR1aF1UenJ1gu/CpAxd
         IKFrTmlj26YREMUyfj6H5BjIPO7Tbef/srWBW+sfi13desk4JB9w4Cis23tng3Vg1Qt3
         EOEW0xf5Qz2jWuERZFGUYquD/ipBWaHLTVZ1LHyPZsBDsqNYPdeD2wpTNjSjCC1xlOuD
         woTV4oet1UFKbmcvaNXHis7JY/mK2LeRzpv6nFTWHT48+j7xVo6JsZPU73HDjN5xrXLy
         VA7qdiPYvOk1BIyCmFvuZeXmlLxSyqKHbqtFj0v7xT2bmtvoDlrmamOHvid0056ViNqJ
         LOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mLrSPcSP9NHr2sVXnCdLqh0ohhYXZ2KFJWAV+LYwv1A=;
        b=pzRG1pptatlUqKBaPYANkBl9tg3xIJSElb9nQEBCkzuIkRvM0/A+cwIgmHCUgUru01
         eoz6+LLqwUv7KFgVapK3TIPo1P0bQhaoo2TyAKfWDTSlxjo6Ixi18GIePg68iJtmTcZE
         yO8luR2/W+XltNMIcomMYCH4GQ6FLpN5fZ8LmOvwJq/8TDnLi0NynMTgOPwuDVtv2V7D
         6e3kbi9GgV913pVsh4iYNRgQQFuCH2GOffZnbfPTdaB5DhaEbCKvGxCknWckEj1iJAL7
         Jvlx+bc1MUaLshz86uf7yWTYut3uX9STjs5YUlZLbwcrYIHe3pnsJpx7YQZ1Gt6qI6Xj
         eLXw==
X-Gm-Message-State: AOAM533ETabuu3TlXyvEP64L1VJ7EGcx4ScKF96ZajJFLoli71Sy/qb6
        RH4dYzBHSnTlGXI+DCkHT8rK/A==
X-Google-Smtp-Source: ABdhPJwNvqcjdr0yGKhR8wd7uBcp5VMF1bVDGBTc8kuZrD49NBcYItmKf4SjA36kglpeWz8EL4Zc8Q==
X-Received: by 2002:ac8:2672:: with SMTP id v47mr2200099qtv.330.1594854645102;
        Wed, 15 Jul 2020 16:10:45 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id c24sm5448445qtd.82.2020.07.15.16.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 16:10:44 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] thermal: Introduce support for monitoring falling
 temperature
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
 <7437ee89-e76d-0c82-9860-5c6076ad8a30@linaro.org>
 <b25d54d35cec777f0dcc5b2bcacce27321d9bd45.camel@intel.com>
 <5861acec-c49a-47cc-d7c6-ccef11dc1d58@linaro.org>
 <e078f9ebd3e8e440d5c04d2abac31201f5d3443d.camel@intel.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <75d5465a-fbbb-8bfb-6fd0-4063ce292147@linaro.org>
Date:   Wed, 15 Jul 2020 19:10:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e078f9ebd3e8e440d5c04d2abac31201f5d3443d.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/15/20 4:27 AM, Zhang Rui wrote:
> Hi, Thara,
> 
> On Tue, 2020-07-14 at 17:39 -0400, Thara Gopinath wrote:
>>
>>>
>>> For example, to support this, we can
>>> either
>>> introduce both "cold" trip points and "warming devices", and
>>> introduce
>>> new logic in thermal framework and governors to handle them,
>>> Or
>>> introduce "cold" trip point and "warming" device, but only
>>> semantically, and treat them just like normal trip points and
>>> cooling
>>> devices. And strictly define cooling state 0 as the state that
>>> generates most heat, and define max cooling state as the state that
>>> generates least heat. Then, say, we have a trip point at -10C, the
>>> "warming" device is set to cooling state 0 when the temperature is
>>> lower than -10C, and in most cases, this thermal zone is always in
>>> a
>>> "overheating" state (temperature higher than -10C), and the
>>> "warming"
>>> device for this thermal zone is "throttled" to generate as least
>>> heat
>>> as possible. And this is pretty much what the current code has
>>> always
>>> been doing, right?
>>
>>
>> IMHO, thermal framework should move to a direction where the term
>> "mitigation" is used rather than cooling or warming. In this case
>> "cooling dev" and "warming dev" should will become
>> "temp-mitigating-dev". So going by this, I think what you mention as
>> option 1 is more suitable where new logic is introduced into the
>> framework and governors to handle the trip points marked as "cold".
>>
>> Also in the current set of requirements, we have a few power domain
>> rails and other resources that are used exclusively in the thermal
>> framework for warming alone as in they are not used ever for cooling
>> down a zone. But then one of the requirements we have discussed is
>> for cpufreq and gpu scaling to be behave as warming devices where
>> the minimum operating point/ voltage of the relevant cpu/gpu is
>> restricted.
>> So in this case, Daniel had this suggestion of introducing negative
>> states for presently what is defined as cooling devices. So cooling
>> dev
>> / temp-mitigation-dev states can range from say -3 to 5 with 0 as
>> the
>> good state where no mitigation is happening. This is an interesting
>> idea
>> though I have not proto-typed it yet.
> 
> Agreed. If some devices support both "cooling" and "warning", we should
> have only one "temp-mitigating-dev" instead.
>>
>>>
>>> I can not say which one is better for now as I don't have the
>>> background of this requirement. It's nice that Thara sent this RFC
>>> series for discussion, but from upstream point of view, I'd prefer
>>> to
>>> see a full stack solution, before taking any code.
>>
>> We had done a session at ELC on this requirement. Here is the link
>> to
>> the presentation. Hopefully it gives you some back ground on this.
> 
> yes, it helps. :)
>>
>>
> https://elinux.org/images/f/f7/ELC-2020-Thara-Ram-Linux-Kernel-Thermal-Warming.pdf
>>
>> I have sent across some patches for introducing a generic power
>> domain
>> warming device which is under review by Daniel.
>>
>> So how do you want to proceed on this? Can you elaborate a bit more
>> on
>> what you mean by a full stack solution.
> 
> I mean, the patches, and the idea look good to me, just with some minor
> comments. But applying this patch series, alone, does not bring us
> anything because we don't have a thermal zone driver that supports cold
> trip point, right?
> I'd like to see this patch series together with the support in
> thermal_core/governors and real users like updated/new thermal
> zone/cdev drivers that supports the cold trip point and warming
> actions.
> Or else I've the concern that this piece of code may be changed back
> and forth when prototyping the rest of the support.

Got it! I will try to include more pieces in the next version.

> 
> thanks,
> rui
> 

-- 
Warm Regards
Thara
