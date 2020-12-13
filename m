Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA62D8CA9
	for <lists+linux-pm@lfdr.de>; Sun, 13 Dec 2020 12:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394352AbgLMLC6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Dec 2020 06:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391023AbgLMLC6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Dec 2020 06:02:58 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0C5C0613D3
        for <linux-pm@vger.kernel.org>; Sun, 13 Dec 2020 03:02:17 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id i9so13510092wrc.4
        for <linux-pm@vger.kernel.org>; Sun, 13 Dec 2020 03:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=REbzHnQpX8ZFKZ/7cj+SuCzQJd+wUlVVcehKx4VnzHw=;
        b=wmpcNnjg2dS8LcAP80ETORu4VS/cSH0a2uYfQFZB4DAGPSzGiwyXzxmSwmql+X5UJG
         wImax83S0MM3N+3OTuHqU7tCO/hmCFpUJjKwlY6gqs/nHrtCM1PFSoyocgeKFUHZU5Kk
         JW4WWaUjshyfXNADsEZ6O3qu5R16AqnJyVxw1XIy6R32gCg8EF11ZhngWICZBugHE0L0
         xui8tThIXUKa+G9K6JOJPE+/za8lAq8NKozP30yZjtI0/hnLAvCJOrmBCi45yWhJTVYu
         XEoDBbHRjyfWde/GQSAg57Cc7Q5buuLrmGDIlJLYTcSFUGOnR45OvgiaBgg4iggClPE4
         DwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=REbzHnQpX8ZFKZ/7cj+SuCzQJd+wUlVVcehKx4VnzHw=;
        b=LSNbi0513qTtmUT+54gvhAYwVOUiYYTBHIlse9FWuH0M+x/SZDe9R9jTWtvBjbiJiL
         v+JjzeG2tu+sbzXXAG6GQ1Ncoit6FTJoIrDaBxK2lbVfDFAPmkpyd3ASnN9a3FyydvFK
         a8i/TWUh367bkif9l95ipFIjauLblWWs3beP2k49FHz1Jtlboab58fmC+JC3r3eOJBtF
         h+zZ0CXSnLjlJyEHmWJ0kv4NqEETD3XIPChMtbft8yzLH3yj++2AXz0sk3VUZ78aAp5A
         gOPOdunBdSTjFft7S4S3/trQkvAQ/syqJX2V0i1XRnhhnJ8tkNGqPspYVhHUSyJXT/5T
         JJjw==
X-Gm-Message-State: AOAM531eYti7pB1AXDvjHtstPwQ73yQsP2uEm+WsmFxAqtqn8Z7J4gMy
        hLqN+P2lhatMAodDJlAc0xUURQ==
X-Google-Smtp-Source: ABdhPJxcw7hP/Ce0Jao2cU3RgX+XzikJNgWR3P9pEAhLQV4Mjf1BjcxPh4lxYN/ZIwgVwJGyRHrdqg==
X-Received: by 2002:a5d:4349:: with SMTP id u9mr22841145wrr.319.1607857335973;
        Sun, 13 Dec 2020 03:02:15 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ed37:d2d0:f316:c7b3? ([2a01:e34:ed2f:f020:ed37:d2d0:f316:c7b3])
        by smtp.googlemail.com with ESMTPSA id q17sm25043907wrr.53.2020.12.13.03.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Dec 2020 03:02:15 -0800 (PST)
Subject: Re: [PATCH] thermal/core: Make 'forced_passive' as obsolete candidate
To:     Matthew Garrett <mjg59@codon.org.uk>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
References: <20201208153046.297456-1-daniel.lezcano@linaro.org>
 <cc2085ca-ada9-d616-eed5-3496889da3bb@linaro.org>
 <20201212035012.GA11926@codon.org.uk>
 <20015331-955b-756f-3dce-4eb78e473704@linaro.org>
 <20201212200806.GA19048@codon.org.uk>
 <6105a8e5-7590-5ba1-5f2b-aa24bf286150@linaro.org>
 <20201213011105.GA21385@codon.org.uk>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a2e3c6ac-b87d-9dec-bf1f-60814739b2fe@linaro.org>
Date:   Sun, 13 Dec 2020 12:02:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201213011105.GA21385@codon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/12/2020 02:11, Matthew Garrett wrote:
> On Sun, Dec 13, 2020 at 12:39:26AM +0100, Daniel Lezcano wrote:
>> On 12/12/2020 21:08, Matthew Garrett wrote:
>>> Anything that provides a trip point that has no active notifications and
>>> doesn't provide any information that tells the kernel to poll it.
>>
>> I'm not able to create a setup as you describe working correctly with
>> the forced passive trip point.
>>
>> The forced passive trip can not be detected as there is no comparison
>> with the defined temperature in the thermal_zone_device_update() function.
> 
> The logic seems to be in the step_wise thermal governor. I'm not sure
> why it would be used in thermal_zone_device_update() - the entire point
> is that we don't get updates from the device?

The thermal_zone_device_update() loops the trip points:

        for (count = 0; count < tz->trips; count++)
                handle_thermal_trip(tz, count);

As the 'forced_passive' is not in this loop (because it was moved in the
step_wise governor), the temperature crossing is never detected and the
'forced_passive' logic in the governor is never called.

That is something I realized when answering to your comment.

>> If my analysis is correct, this 'feature' is broken since years, more
>> than 8 years to be exact and nobody complained.
> 
> I've no problem with it being removed if there are no users, but in that
> case the justification should be rewritten - ACPI table updates aren't a
> complete replacement for the functionality offered (and can't be used if
> the lockdown LSM is being used in any case).

Yes, I understand your point. Given it is not working since years, I
think we can just drop the feature and change the reason of the removal
in the log, instead of ACPI table updates, just say it is no longer used.

Does it sound fine ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
