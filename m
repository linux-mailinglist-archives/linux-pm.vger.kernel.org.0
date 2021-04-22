Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8546D36860D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 19:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbhDVRgm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 13:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVRgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 13:36:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C5EC061756
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 10:36:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so33622703wrm.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lotpi9GZ6JPdTYF1Tc1mMLoIS8x4dJMlm5P+JRko4p8=;
        b=AgoaZjOtQNYI7lUJtuStVyjbesyoyrqqI+zShNKzhAMh8oF5XgldyIbG/kfLkrvwJC
         NLftfnuiw6//Rgtiw86Sj/PX8iIXPcv17Baz//qx4hfyEEMzjS8zg9OHd00uQYUhdJuo
         91BWRwLoEsxbM1Egb3IweWo0w4aHzfdaHI0OYqPeHDDIo27wZc6BaFM/l2eQFbXXcXuz
         4IB6EJfWOdb3XeYxubnipkBPWYfUb4OE/BDmu36+6NiOlmHHG0g6FSmxwOoopO5QKohj
         yCyId28HId4hlFw0BItvVEWerJHo2O35SEU8XIwicwYzsrJfTh2LxlUTNxGp1lGXcIbt
         3z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lotpi9GZ6JPdTYF1Tc1mMLoIS8x4dJMlm5P+JRko4p8=;
        b=YV8gQTQp0Ev/GlsuWVYaxd6bcnKZaR7f8GPeJZOP07FmpZPnvZb3c+IDmNoexL/3dG
         yAuTfCF/zpqb+cQJ4tdnV5JbmRmr/26KNMKFt+dcJBgLQpugU9PFsYwuJY7oivLzUgU1
         V3DGq9j6aQ6jqbYKrcu1YWzrgNgwaXcUa4pIcRb8IZV5uD7Raxr0OVqPh/Ym+4rbNo6Z
         7iamJd9kS1xbpS1gIsWED7y/PhA/FuISG/Tn3AfPgWadYWN+CJttOIbQdiM8JCOjUEhI
         PQIeYAIyXQTT2YezoQe7TZVV/A+l2E4PQfOTdgRI2F1h+llFSgXM3cCDzG1SbMHtK27C
         cCBA==
X-Gm-Message-State: AOAM530WXBKH35yCXciF4dRXoiQpRMwtlEYtIjkP8ItfNOBfjrN5uiPF
        dIPjydkG2KTtA0/+9+JT9pNZPw==
X-Google-Smtp-Source: ABdhPJy8u4KI0OFaLA6S5XbhWmAj908iIkYI0KnP3Dm8Gix4lwslvIHx39tv5X/FZoadDyiLxDCX0g==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr5501813wrq.95.1619112964609;
        Thu, 22 Apr 2021 10:36:04 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2191:9b4c:c38f:a1a9? ([2a01:e34:ed2f:f020:2191:9b4c:c38f:a1a9])
        by smtp.googlemail.com with ESMTPSA id i4sm4997426wrx.56.2021.04.22.10.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:36:04 -0700 (PDT)
Subject: Re: [PATCH 0/3] Thermal governors improvements and a fix
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210422153624.6074-1-lukasz.luba@arm.com>
 <25ceedef-f3eb-0187-7397-9d4ca30fcb93@linaro.org>
 <d783748d-105d-5919-6550-442229dd612a@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <12a5ba3b-9822-30a1-5d23-2b67197a69ad@linaro.org>
Date:   Thu, 22 Apr 2021 19:36:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d783748d-105d-5919-6550-442229dd612a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/04/2021 19:33, Lukasz Luba wrote:
> 
> 
> On 4/22/21 6:31 PM, Daniel Lezcano wrote:
>> On 22/04/2021 17:36, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> The patch set introduces one fix (patch 1/3) and two improvements, which
>>> are possible thanks to the new helper function [1].
>>> The patch 1/3 with a fix for fair share thermal governor is also sent
>>> CC'ed stable, but it's hard to point a particular commit, which back
>>> then was for fair_share.c.
>>>
>>> The patch set should apply on top of [1].
>>>
>>> Regards,
>>> Lukasz
>>>
>>> [1]
>>> https://lore.kernel.org/linux-pm/20210422114308.29684-2-lukasz.luba@arm.com/
>>>
>>>
>>> Lukasz Luba (3):
>>>    thermal: fair share: lock thermal zone while looping over instances
>>>    thermal: fair share: use __thermal_cdev_update()
>>>    thermal: power allocator: use __thermal_cdev_update()
>>>
>>>   drivers/thermal/gov_fair_share.c      | 11 +++++++----
>>>   drivers/thermal/gov_power_allocator.c |  3 +--
>>>   2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> Applied, thanks
> 
> thanks!
> 
>>
>> Two users left of thermal_cdev_update ;)
>>
>>
> 
> True, I didn't dare to touch them, since that would require more
> work and understandings :)

Yeah I agree. The changes are no trivial ...




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
