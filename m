Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6410369589
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhDWPEW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 11:04:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50429 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243167AbhDWPEI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 11:04:08 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZxL8-0000Oy-VO
        for linux-pm@vger.kernel.org; Fri, 23 Apr 2021 15:03:31 +0000
Received: by mail-ed1-f69.google.com with SMTP id f9-20020a50fe090000b02903839889635cso16780463edt.14
        for <linux-pm@vger.kernel.org>; Fri, 23 Apr 2021 08:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BnP33dKyOiWs5gTSp1Xp21cLfmehBUMSIZEClRM77mc=;
        b=PaetFiTJRrI08LU7R4a9Ga5Bt/rq/UZY7Y7JRLplSTzP7x0sqDRKRX1laXlM8c2XNH
         aY5+MbabPTSIF7Qc+QTHia8XjCi0hvgex7G5EFQfyQjPnfGssymlLWYHUZHEDNm4Dvwr
         XeLFaUshTCvLdagc8HNJfxPq2br9TRJLzTBENtaQZirOx5Ma5U3dPYed1Y33ZjwznCxd
         SNx995E3PgekuzKHSbciMOnY2xDppQUzbVFMCzdc/Ma5j8SJ4D725PK/zcCfhjJ7Iv3v
         42CccnKqpb6PkZON8EK1CyfQZ4p0okkVA5gM9EFUtTuYmh/81MVePojY6eSS/VGoCIMg
         a8qw==
X-Gm-Message-State: AOAM532zT0YqRdzTfCmYq8mz95s20Zw8PwMsf253geQQ+NPv+Wx4WMMK
        M1yzignJonUgPBZW+kQF5li2Ad6Nku64z1Gi0RssK1L3RHH116OrZEy7PvhJ1i+BVgrYpAwPld5
        yvGYE0LUk/9Khct1dRMOe5jFoigBi7cenHZrM
X-Received: by 2002:a05:6402:26ca:: with SMTP id x10mr5042809edd.386.1619190210642;
        Fri, 23 Apr 2021 08:03:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH/qcs80BvCxBEJB+SWn/ljk0PbwcWStmFW4iLrCx0OvXxbQsL+wVMKcNWhhBRigcCKa+P+w==
X-Received: by 2002:a05:6402:26ca:: with SMTP id x10mr5042791edd.386.1619190210501;
        Fri, 23 Apr 2021 08:03:30 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id t7sm4207682ejo.120.2021.04.23.08.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 08:03:30 -0700 (PDT)
Subject: Re: [PATCH] PM: runtime: document common mistake with
 pm_runtime_get_sync()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210422164606.68231-1-krzysztof.kozlowski@canonical.com>
 <CAJZ5v0iUQBfrTtVmfrrDixZnnr1_THgaM1+mFu4TRT+OOYb2mw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a56096c4-0b64-ca16-8d5c-d086e96a436d@canonical.com>
Date:   Fri, 23 Apr 2021 17:03:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iUQBfrTtVmfrrDixZnnr1_THgaM1+mFu4TRT+OOYb2mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/04/2021 16:08, Rafael J. Wysocki wrote:
> On Thu, Apr 22, 2021 at 6:46 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> pm_runtime_get_sync(), contradictory to intuition, does not drop the
>> runtime PM usage counter on errors which lead to several wrong usages in
>> drivers (missing the put).  pm_runtime_resume_and_get() was added as a
>> better implementation so document the preference of using it, hoping it
>> will stop bad patterns.
>>
>> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  Documentation/power/runtime_pm.rst | 4 +++-
>>  include/linux/pm_runtime.h         | 3 +++
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
>> index 18ae21bf7f92..478f08942811 100644
>> --- a/Documentation/power/runtime_pm.rst
>> +++ b/Documentation/power/runtime_pm.rst
>> @@ -378,7 +378,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>>
>>    `int pm_runtime_get_sync(struct device *dev);`
>>      - increment the device's usage counter, run pm_runtime_resume(dev) and
>> -      return its result
>> +      return its result;
>> +      be aware that it does not drop the device's usage counter on errors so
>> +      usage of pm_runtime_resume_and_get(dev) usually results in cleaner code
> 
> Whether or not it results in cleaner code depends on what that code does.
> 
> If the code is
> 
> pm_runtime_get_sync(dev);
> 
> <Do something that will fail if the device is in a low-power state,
> but there is no way to handle the failure gracefully anyway>
> 
> pm_runtime_put(dev);
> 
> then having to use pm_runtime_resume_and_get() instead of the
> pm_runtime_get_sync() would be a nuisance.
> 
> However, if the code wants to check the return value, that is:
> 
> error = pm_runtime_resume_and_get(dev);
> if (error)
>         return error;
> 
> <Do something that will crash and burn the system if the device is in
> a low-power state>
> 
> pm_runtime_put(dev);
> 
> then obviously pm_runtime_resume_and_get() should be your choice.
> 
> The rule of thumb seems to be whether or not the return value is going
> to be used.

Yes, you're right. What I wanted to point is that there is a pattern of
missing put when using pm_runtime_get_sync() all over the kernel. It's
quite common mistake because the interface is non-intuitive.

Therefore I find worth to warn users of the API: usually, for simple
cases, one should use the pm_runtime_resume_and_get(). This only a hint,
matching common cases, but not every case. I am not claiming that one is
better than other, just that old interface mislead in the past.

Maybe you wish to rephrase the comment to:
"be aware that it does not drop the device's usage counter on errors so
check if pm_runtime_resume_and_get(dev) would result in a cleaner code"


Best regards,
Krzysztof
