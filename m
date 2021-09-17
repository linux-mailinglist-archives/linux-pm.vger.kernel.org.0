Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB56A40F386
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 09:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhIQHwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 03:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhIQHwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 03:52:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FAC061764
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:51:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 140so6629892wma.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AkeG9+bCFIMeTbdQIw8gG7qxjkL1CtCRf0Fp7JdFLyI=;
        b=g+hPMSPuni0MWMxtUBbtbcfSKQsF3Sm4o2r7+Vxgjfh7II58iuwsnczPNIXPU0I6r6
         uJDBNLwpvsixrQJ7PhWq++Eedc4i9udYeannexLIw/dxlXe5Vd9J3/YsSOm8qng8DOY1
         27fU/GKuyzwK1M7Y14fFlzdKFhBBTbdpzl+OSnH/aPsrLMTv8QKJRiVriJSpIo2latvy
         DcsdVyVmmQA1P0UNeYWEYg2LLq6BGJpWNwUnXsB+Ca5ejP6+nvnYMHxxfGGTtFrEDcwu
         eL9XHl1T8q7Ktj6d4zo/KtECtyr0I20bNXDN+PKa775wbHyL0UVwkOExcME3JLJ1FM0w
         ioqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AkeG9+bCFIMeTbdQIw8gG7qxjkL1CtCRf0Fp7JdFLyI=;
        b=Syyq0qRtQfBqQIW8Zca5bIeSF7RQ3Sk1D4aJhLGrK7S2L6fMS82xyuOKcK3NE4zVFe
         ZMkEKYcxUsCdlJM63k3T+mjlSZTw9To10AQXlAoD5LKikzRsar4NrZ0WU3CBAElghPIU
         bCVd5bzbhnEsmTJGvFdTIViChTO4QCZLHeci3M6rYrlnnUvnDdGFHCegqvw9l+XfBQjE
         iHkm+Sc4RBd8kiLSSbizJh1L60GT/NV/ZXY6lH7M4lWVLKKs+mMH+34EM7yq1WVgFov/
         fbGqqJwz5RqgGex+O9FD7bJbP3sEn+olXEkUEaPWOYgcvbhS+hwdVAELFmQWUIwQyFTI
         k1XQ==
X-Gm-Message-State: AOAM530XnNLS0rxAjbkUol4wLB5NC3P9hniBJGG/UJ1YGhTNuAyQpWBB
        NEpB3XPDMpSM+N60CheplIQ4yQ==
X-Google-Smtp-Source: ABdhPJyBUOQFNT82g8i7TvQn8r9hNwE4JkZuZyEV4XcSZASZzR/f6fstxZOAid9DKHryBgxvxtVyPQ==
X-Received: by 2002:a7b:c014:: with SMTP id c20mr8800479wmb.81.1631865070670;
        Fri, 17 Sep 2021 00:51:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cf95:6508:8470:7171? ([2a01:e34:ed2f:f020:cf95:6508:8470:7171])
        by smtp.googlemail.com with ESMTPSA id u29sm3199045wru.34.2021.09.17.00.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 00:51:10 -0700 (PDT)
Subject: Re: [PATCH] thermal: brcmstb_thermal: Interrupt is optional
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210426213647.704823-1-f.fainelli@gmail.com>
 <933c889e-dee0-4fc3-bf1a-b3655cabbb28@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7359c3c1-8928-d448-e503-13f587cbb567@linaro.org>
Date:   Fri, 17 Sep 2021 09:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <933c889e-dee0-4fc3-bf1a-b3655cabbb28@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Applied, thanks

On 16/09/2021 02:05, Florian Fainelli wrote:
> 
> 
> On 4/26/2021 2:36 PM, Florian Fainelli wrote:
>> Utilize platform_get_irq_optional() to silence these messages:
>>
>> brcmstb_thermal a581500.thermal: IRQ index 0 not found
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> This patch was never picked up and still applies. Daniel, can you pick
> it up?
> 
> Thanks!
> 
>> ---
>>   drivers/thermal/broadcom/brcmstb_thermal.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c
>> b/drivers/thermal/broadcom/brcmstb_thermal.c
>> index 8df5edef1ded..0cedb8b4f00a 100644
>> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
>> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
>> @@ -351,7 +351,7 @@ static int brcmstb_thermal_probe(struct
>> platform_device *pdev)
>>         priv->thermal = thermal;
>>   -    irq = platform_get_irq(pdev, 0);
>> +    irq = platform_get_irq_optional(pdev, 0);
>>       if (irq >= 0) {
>>           ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>>                           brcmstb_tmon_irq_thread,
>>
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
