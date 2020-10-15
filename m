Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85728F014
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 12:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbgJOKWC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 06:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389258AbgJOKWC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 06:22:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414BAC061755
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 03:22:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n18so2763215wrs.5
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HSLoaI3Bb+OZrae1XegNlhU8itLV0T9QFLmqbbYjrSE=;
        b=njFZ7+MCpBTWYGR9y3/X+X/ytYtI07rgf4gZK9LzXmwOutQ8kBYZtgQDtP1kssCS44
         xnvCjf9B8hjm8GsI3tMCgFSTnAzXI/BzTXUHGjw+Kv9m4yYCFV0vQO/nGZkaQHYI4KOY
         mwjdo8uVWcGjiGJ/qS646+02iibE8IatAJt5W0yIjkNZrqqPQIjQFsaa2rGDMETeHsK/
         1nLhBl2coETZoab3Dowu9J5fPiaJjk0FarQb46H0+BFPhgUbH4dwurPycn8ldNgs2f+s
         XP6rXLQskJuqrZ8jBdwuURi1FXhq1Ae2vV5yI7nOHt0BFJREmVdwz6VSlwa0WhWKIuGp
         /aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HSLoaI3Bb+OZrae1XegNlhU8itLV0T9QFLmqbbYjrSE=;
        b=Dgi3VXfRM/w9JPZqT5dApWrJZSsIvwad3y1dix5AswTo2WKySUtds44QsexztTVTW0
         SXyUR9qjkcuzKpIrbFZWnVMoOkkBivi+hgx2zUYXX0fX7XcMyAS9pFpD9DYYNbp07RqE
         JI2hK7KYfaHi+DRmmEk+jArTBdlxprP1sgCA8Ky/LqJSNKlpqJHGg3UrYBzGTYm3zuN2
         oobR5NvYY083R6V3/ngTs3qXXCttwWYVpsDCsue4eohK5ZSDCx1OE3lXBLZJ9xBvfJvP
         2TT7vzHMRuWRWap/g6Zlrkxi4cHh3Gv8UBF13yqNAXZETLqfJRmiJnrQnasenxwITo2v
         wOAg==
X-Gm-Message-State: AOAM531bkfBk5+EXQktAOOpPvZ2v7za/40D1raoe6ZS/dFbyU2mwXgy3
        rFfE210AUIl42Y3+D4RGtBLKVA==
X-Google-Smtp-Source: ABdhPJzJncH5BCQjJ4evPmXyN+1spvZRDp4Rs202jnAZ/jtV+lnqrDDddpV2zfaeIyf0COpuFX86AA==
X-Received: by 2002:adf:f182:: with SMTP id h2mr3452294wro.199.1602757318825;
        Thu, 15 Oct 2020 03:21:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5400:5b12:4f4c:844b? ([2a01:e34:ed2f:f020:5400:5b12:4f4c:844b])
        by smtp.googlemail.com with ESMTPSA id u6sm3437856wmj.40.2020.10.15.03.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 03:21:58 -0700 (PDT)
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
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
 <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
Date:   Thu, 15 Oct 2020 12:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/10/2020 11:00, Lukasz Luba wrote:

[ ... ]

>> There is the SCMI and the DT. Because there are two sources where it is
>> impossible to know if they are using the same units, we are stuck to
>> ensure a consistency for the kernel.
>>
>> The platform should use:
>>   - the SCMI only (scaled or real)
>>   - the DT only (real)
>>   [ - the firmware file only (scaled or real) ]
>>
> 
> Do you mean by SCMI - registration using em_dev_register_perf_domain() ?

It was high level description, but yes, I guess it is the case.

>> As it is not possible to know if they are scaled or real, there is no
>> choice except making them mutually exclusive.
> 
> So you propose a bit more restriction in registration EM, to not get
> lost in the future. I also have these doubts. Let's consider it and
> maybe agree.
> 
> I've recommended Qcom to use em_dev_register_perf_domain() when they
> have this obfuscated power values. Then any developer in the future
> who wants to add EM for a new device on that platform, should use the
> em_dev_register_perf_domain().
> 
> In this case the flag in EM that you have proposed makes sense.
> We probably need an argument 'bool abstract_scale' in the
> em_dev_register_perf_domain(..., bool abstract_scale)
> as a source of information.

I was suggesting to add a flag to the em_perf_domain structure giving
the source of the power numbers.

So if the IPA is having the 'sustainable-power' set in DT but the
em_perf_domain is flagged with power number coming from SCMI, then they
will be incompatible, the thermal zone will fail to register.


> We would allow to co-exist em_dev_register_perf_domain(..., false)
> with dev_pm_opp_of_register_em() EM devices.
> 
> Is it make sense?

Well, it does not change my opinion. We should assume the energy model
is always milliwatts. If the SoC vendors find a way to get around with
bogoWatts, then good to them and up to them to deal with in the future.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
