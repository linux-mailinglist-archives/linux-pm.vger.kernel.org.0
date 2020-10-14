Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4E128E517
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgJNRKL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 13:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJNRKL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 13:10:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA921C0613D2
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 10:10:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d3so318758wma.4
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I0pEDuKxGGGuBmYvVm4TwEpZ23vGsYXeXFdnlUxUTUw=;
        b=XG+flZeApLSKjELCtEfUK5RLhkkl2AezZuRLW/3HGQqXHI9rfLH//X/riYc2iWGlS4
         ZdEoupzAN6IKfvxxPOu3fME+Bb/hxrbRCSQLBoT71y4lPQZhB0wdr0jzp3DH3A8ncCon
         L4higHI9JkFDrd4L6JlUKMafZ25w9RA1pf3zbRRzC4T5Q8Wf/sEmwWskuaQ964q8O7Y4
         cJ0ulkn3/MbKESdSMRzJOw1wWcXUlx+Ej4lIhFm2t+PoY5Q98gBSh3XKWyUp0w45jUAt
         I633QBbypN3bg584AFQzgCRRdTTajq3IpO3iQpvF2ZXJceq3VSlnuLaULqEyv6PBd3Vy
         P0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0pEDuKxGGGuBmYvVm4TwEpZ23vGsYXeXFdnlUxUTUw=;
        b=WVR4m7jyGW4uKM7cmWdDWWWO5cRpj9El2PLt+qG74S7VmvIxAWo7qvXH26pbh+HFm1
         h4v6M+gfU+B3JkZeXZAG/grS/5vBHVLqCRn5MWvgkP0fUiE485Z8o3HnoxvZjomiUnZg
         DIRggDxnFuTLf+EaiumV8/XLXfmm1iDUC8fIxDnxcJIRxsZZOTzyJZqWFSQhcByLUaeF
         S4zHJ/Cf0gLWcYz5NzYOWouvb7A95cG1R4Y18Z6eOVpUvWmmTRZMdaxrxpmjwzBgEyde
         gjmRgV/MxSa/MpzkJtUY8NIFCdRHUuDwgdrPTsNMypwuY3K4D24LJNO+fqCL4zetqwaG
         LcbA==
X-Gm-Message-State: AOAM532rSB/U7U+Lz+pgGLewtuCy5uWmwLXOp0ylXC0gXGlK3JCHUE7o
        +SK+I2iclBWl5l1Id6H2FpsTwA==
X-Google-Smtp-Source: ABdhPJyXOPxJ4gMTARh7uvf1rLbQDsa7rciyJvewLeZvZZGKN3pSdr3HLVGC63ubPZYm4uVL/CS7AQ==
X-Received: by 2002:a05:600c:1149:: with SMTP id z9mr438655wmz.180.1602695409214;
        Wed, 14 Oct 2020 10:10:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5400:5b12:4f4c:844b? ([2a01:e34:ed2f:f020:5400:5b12:4f4c:844b])
        by smtp.googlemail.com with ESMTPSA id q2sm5772845wrw.40.2020.10.14.10.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 10:10:08 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, amitk@kernel.org,
        corbet@lwn.net, Dietmar.Eggemann@arm.com, qperret@google.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org
References: <20201002114426.31277-1-lukasz.luba@arm.com>
 <d2960f6a-1805-1fb4-98ae-4a756d20370b@arm.com>
 <765e6603-b614-fb72-64ff-248b42474803@linaro.org>
 <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
 <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org>
 <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
Date:   Wed, 14 Oct 2020 19:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2020 17:24, Lukasz Luba wrote:

[ ... ]

> We have to update the EM doc about allowed abstract scale, which
> implies EAS, IPA doc update with some information to the community that
> these components can handle it.
> 
> The script will just make developers life easier, but the current
> documentation does not say anything about abstract scale.

... yes, because there is no consistency across the source of power
numbers and no tools to ensure DT power numbers consistency, yet.

>> In any case, if the DT is specifying real numbers, and SCMI abstract
>> numbers or the opposite, obviously there is a conflict if we are using
>> both.
> 
> True, DT only allows real numbers (I have Rob's opinion regarding
> patch 3/3).
> 
> It's not that there is only SCMI which might use abstract scale. Qcom
> already has it and other vendors will follow (not exposing real
> numbers). They would register bogoWatts to EM because they know that EAS
> can deal with both.

So vendors are using bogoWatts, despite the documentation.

By updating the documentation saying it supports the abstract values,
that means every new framework, device with power values, will have to
comply with that. How is it possible to add a device with power numbers
if the existing ones are obfuscated ?

With two subsystems using the energy model, evolving independently we
can see there are conflicts. With more subsystems, that may become a
source of confusion, especially with different contributors.

I think the energy model should stick to milliwatts and keep the
documentation unchanged regarding this. And vendors should take the
responsibility of not sticking to the documentation.

>> I suggest to fix the conflict first and provide the features to make the
>> numbers more easy to share (like the script described above and/or the
>> firmware file).
>>
>> Then with the right tools, everything can be documented.
>>
> 
> We cannot block one way of registration to EM when the other was used.
> They might have correct and consistent numbers.

What is the rational of using two firmware power information ?

> It's up to the platform developers to choose the path:
> - go with bogoWatts - if they are not allowed to expose sensitive
>   information, use em_dev_register_perf_domain() in drivers, not DT;
>   make sure everything that is needed works; check the doc, which
>   sub-systems can handle it or needs some tuning (patches 1/3 and 2/3
>   try to help here);
> - use milliWatts - easier; DT is allowed; help from the community in
>   reviews, possible results comparisons; both EM registration ways
>   might be used;
> 
> We cannot force vendors/OEM engineers to store milliWatts in the
> Energy Model if these values are protected by some NDA. 

If I am able to measure one real power value, (and I'm pretty sure it is
quite possible), whatever which one, it is possible to deduce all the
numbers with the linear scale. IMO that is a false debate. Anyway ...

> Your proposed
> way of providing data into EM from user-space firmware.bin IMHO also
> falls into the same bucket. That information would be accessible in EM
> debugfs and they would avoid it.

I think you misunderstood my point.

There is the SCMI and the DT. Because there are two sources where it is
impossible to know if they are using the same units, we are stuck to
ensure a consistency for the kernel.

The platform should use:
 - the SCMI only (scaled or real)
 - the DT only (real)
 [ - the firmware file only (scaled or real) ]


As it is not possible to know if they are scaled or real, there is no
choice except making them mutually exclusive.

From my POV, it is not adequate to let SCMI power information co-exists
with the DT power information if we know they can be with different units.

I've just expressed my opinions:

 - vendors take responsibility of putting different units for the EM

 - Power numbers should come from the same source


Up to Rafael to decide what to do with this documentation update.

Thanks
  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
