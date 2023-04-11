Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0096DE585
	for <lists+linux-pm@lfdr.de>; Tue, 11 Apr 2023 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDKULT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Apr 2023 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDKULS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2023 16:11:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C459E4
        for <linux-pm@vger.kernel.org>; Tue, 11 Apr 2023 13:10:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l18so8702019wrb.9
        for <linux-pm@vger.kernel.org>; Tue, 11 Apr 2023 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681243842; x=1683835842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfBfNskvypXUycnZQQ0UPCU28NArkIdiou+Ydxicj0o=;
        b=pWrViBD+E9e0MWmsA1+vukbrbsswkhCWcgy5blFII47Agl40WoubaF0onbR5WWNb+5
         nlly42UpmFY6l239REpsQoctNFzShcE6ldQA+dROxnYVQb5Fkum0vXDCuv69hy/xxzJg
         hyuNc8a/oP/+6asFGRktWsGPu5WEc8Stj5KapqnkZqExVd3LsOylRDyN7NxmEeVTWNjY
         yVUBybSB3VvQykjmr4dObDy/pOfDFHx43zNCpxMIRude8B8Po0q5CXF7qD7bVw+2qHkJ
         7eyVTgDxerjP9VLsQmD4p5vnDZG5W33Rluc5MJBhvehVNcwbrcZxVQBxK5LCu1rzUDRI
         f+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681243842; x=1683835842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfBfNskvypXUycnZQQ0UPCU28NArkIdiou+Ydxicj0o=;
        b=p61c39lsYspiPjWPav7JeSCiTmcMoNqx7kaMEyDv77kM3/azmP7zb0enVqvysjNfgx
         jmKTskawtYsEFM9V3hzv5F7hKjvoVTrD+PDPh/LEUcp175Bs7/Z+aLxsu+rTRVSCVgxy
         wwXDt2EhMwiW7PJ0Vhw7/fNe1K/4TSMICoGwgRb7yWP747ZSv+KqcnOVz9EyQ/w8xAFG
         GPq9+HNlgMHct5sMQ44YaVcLWKPOPThxDSB6NoDEgYMoWIvQqHgUFxohbJ2zedqXp0pX
         o2cv+1deWeNZqSfJ6dLAtSZW0GqgNAhn8nqsVVLa42W4IHWvSgBv2tPDDl4nEz4xeJLy
         gkIg==
X-Gm-Message-State: AAQBX9d5+aUzKbS+jJQM6U+vW2M3Ue7kEN3//TwXbqR3qAxFuZ9qCCP8
        vOyeemU3bfk4obT3e+JAiucp3ray+E+bWHK11F8=
X-Google-Smtp-Source: AKy350bErnFy1KNGoWttECgScLVSmo9W4x3uuYTwEuiy1WhRyf0XtReJP3N0dvfnok6jwB2COfkJXw==
X-Received: by 2002:adf:ee85:0:b0:2ef:b123:46d9 with SMTP id b5-20020adfee85000000b002efb12346d9mr2995534wro.3.1681243842473;
        Tue, 11 Apr 2023 13:10:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3227:36b8:19f8:5420? ([2a05:6e02:1041:c10:3227:36b8:19f8:5420])
        by smtp.googlemail.com with ESMTPSA id g14-20020adff40e000000b002f3de0cd69bsm988900wro.59.2023.04.11.13.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 13:10:42 -0700 (PDT)
Message-ID: <87119ec6-43e1-6062-93dc-be133fdeb88a@linaro.org>
Date:   Tue, 11 Apr 2023 22:10:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/7] thermal/drivers/intel_pch_thermal: Use thermal
 driver device to write a trace
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tim Zimmermann <tim@linux4.de>
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
 <20230410205305.1649678-2-daniel.lezcano@linaro.org>
 <CAJZ5v0gA2-WBOs6-N4iaaypdq4-P0JH+jLfOsaYi4GpdqorAcQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gA2-WBOs6-N4iaaypdq4-P0JH+jLfOsaYi4GpdqorAcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/04/2023 20:16, Rafael J. Wysocki wrote:
> On Mon, Apr 10, 2023 at 10:53 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The pch_critical() callback accesses the thermal zone device structure
>> internals, it dereferences the thermal zone struct device and the 'type'.
>>
>> For the former, the driver related device should be use instead and
>> for the latter an accessor already exists. Use them instead of
>> accessing the internals.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/intel/intel_pch_thermal.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
>> index dce50d239357..0de46057db2a 100644
>> --- a/drivers/thermal/intel/intel_pch_thermal.c
>> +++ b/drivers/thermal/intel/intel_pch_thermal.c
>> @@ -127,7 +127,10 @@ static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
>>
>>   static void pch_critical(struct thermal_zone_device *tzd)
>>   {
>> -       dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
>> +       struct pch_thermal_device *ptd = thermal_zone_device_priv(tzd);
>> +
>> +       dev_dbg(&ptd->pdev->dev, "%s: critical temperature reached\n",
>> +               thermal_zone_device_type(tzd));
> 
> No, this just makes the code more complex than it is and the only
> reason seems to be "cleanliness".
> 
> Something like
> 
> thermal_zone_dbg(tzd, "critical temperature reached\n");
> 
> would work, the above doesn't.  Sorry.

Why not add a trace directly in handle_critical_trips() in 
thermal_core.c and remove this one ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

