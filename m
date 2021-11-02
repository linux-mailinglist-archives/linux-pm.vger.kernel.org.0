Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADD2442FF5
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 15:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhKBOPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 10:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhKBOPf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 10:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635862380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iH/2e/wikez8Ul76Vyks6IXMr0Ua0X0rQ4GfdFV+Uc=;
        b=hPcTsM2w4cf2Y0Kut23++0vIT6f+nkF2IiQ/TP9KrIHZMBktGlfgsQ830yyNQHIwlL81YQ
        jhQCqrDsma8ytc1qv4D1Ru9N8/ug+aw6bIGQMQ4H4RcAXyoXC4bBo7kOFDwDmDe3H3YUGk
        amkwVMfiBZp/reSAww/jDYyldsj2nZI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-5BXlVuevPaWvkMNh5RObdQ-1; Tue, 02 Nov 2021 10:12:59 -0400
X-MC-Unique: 5BXlVuevPaWvkMNh5RObdQ-1
Received: by mail-ed1-f71.google.com with SMTP id i22-20020a05640242d600b003e28aecc0afso6396221edc.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Nov 2021 07:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/iH/2e/wikez8Ul76Vyks6IXMr0Ua0X0rQ4GfdFV+Uc=;
        b=ETTs6oxY1qAJjLySUcd4r5tVmwgVOIN9O7ss39r/uAxA8m9MLKsWcuPTQQq0FJlCRV
         BnJDlsmULFcCBHRittTKrZiaR1I6fwaIvIloQM1ZW25bA5P0kNmRiwg9DXo48oCwvUQA
         Fs8xkSDpqqyG57CpP0OiarwD5QPTjXVcTMK03dHEOaG6iA5jl/OQrQxWfj0fuMH1B1kN
         2Gibqp9uQV1hRNbXj3tZLbZafPeXI4Mkwyk34ZXz+AkG9R1k2W3zZVszpv62JqERb+BX
         1R2xUenO2hDdq7+L96FdQwuGbZ8u+5C4kyt9nC3raJVg80AyononRMnjIsAsuWqKVIFf
         5YOA==
X-Gm-Message-State: AOAM530c9RML+bOkAXCOtvV2Mz5gFJKUk4CpH5T0wy1a67JMTmLJ3AIt
        7KWk0ySpT+gYvdGGEIRBP+dJ9cS6QdEKZcUSd2P1BDA2/ZGObTzhEgklsMU6GspJoYz0r0vGwyC
        7kzh5KrcGKOcgZg+vfBo=
X-Received: by 2002:a17:906:c301:: with SMTP id s1mr46124377ejz.409.1635862373616;
        Tue, 02 Nov 2021 07:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+ixxnyOcDdQqSVZiYMCwXTPXBclYSYRPD80VvvknhhaT2v3qRnyd1L/2+ts7dxYBhlXa+Ig==
X-Received: by 2002:a17:906:c301:: with SMTP id s1mr46124248ejz.409.1635862372275;
        Tue, 02 Nov 2021 07:12:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bm1sm8220290ejb.38.2021.11.02.07.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 07:12:51 -0700 (PDT)
Message-ID: <e74947c4-74c8-a17e-f4cb-752a79851954@redhat.com>
Date:   Tue, 2 Nov 2021 15:12:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] power: supply: bq27xxx: Fix kernel crash on IRQ
 handler register error
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
References: <20211031152522.3911-1-hdegoede@redhat.com>
 <CAHp75Vc6GO4e0_Qp6HfFtd_kbSakaMXsQN4oEPArdmMrxTFb7A@mail.gmail.com>
 <20211102132352.yqazgy2njnbthujb@earth.universe>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211102132352.yqazgy2njnbthujb@earth.universe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 11/2/21 14:23, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Oct 31, 2021 at 09:34:46PM +0200, Andy Shevchenko wrote:
>> On Sun, Oct 31, 2021 at 5:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> When registering the IRQ handler fails, do not just return the error code,
>>> this will free the devm_kzalloc()-ed data struct while leaving the queued
>>> work queued and the registered power_supply registered with both of them
>>> now pointing to free-ed memory, resulting in various kernel crashes
>>> soon afterwards.
>>>
>>> Instead properly tear-down things on IRQ handler register errors.
>>
>> FWIW,
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Thanks, queued.

Thank you, note these 2 patches (for the bq25980 driver) are also
pure bug-fixes, I posted them as part of a larger series, but
in hindsight I should have probably posted them separately:

https://lore.kernel.org/platform-driver-x86/20211030182813.116672-4-hdegoede@redhat.com/
https://lore.kernel.org/platform-driver-x86/20211030182813.116672-5-hdegoede@redhat.com/

It would be good if you can pick these 2 up too
(I'll respin the rest of the series to address various
review comments without them then).

Let me know if you want me to resend these 2 as a stand alone
series.

Regards,

Hans



>>> Fixes: 703df6c09795 ("power: bq27xxx_battery: Reorganize I2C into a module")
>>> Cc: Andrew F. Davis <afd@ti.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> - Fix devm_kzalloc()-ed type in the commit message
>>> ---
>>>  drivers/power/supply/bq27xxx_battery_i2c.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>>> index 46f078350fd3..cf38cbfe13e9 100644
>>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>>> @@ -187,7 +187,8 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>>>                         dev_err(&client->dev,
>>>                                 "Unable to register IRQ %d error %d\n",
>>>                                 client->irq, ret);
>>> -                       return ret;
>>> +                       bq27xxx_battery_teardown(di);
>>> +                       goto err_failed;
>>>                 }
>>>         }
>>>
>>> --
>>> 2.31.1
>>>
>>
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko

