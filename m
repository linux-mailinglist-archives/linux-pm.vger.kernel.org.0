Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2396119DE
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 20:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJ1SGT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ1SGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 14:06:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EAD1E3900
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 11:06:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso4393590wmq.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvB7DRSLIJsu2QDVvAH21ZQ4Gy+2QZgnSgEI2dOTEt0=;
        b=Ic520TzF+Pp/65vQSil7BTJV5h3WfuACTMhLv1ySmCHBRQ3X7M2PCD/9jN1290F72j
         aTQ4vzmQKDhXlqioRHXUZI8sZ+9DbKh76ekk7RIMNaIDjjDMKfeQYA89t22WKg1Vo+AP
         P5a2O1n6oX389AFUyTE8qw+kGvNVYbXUIAqZSY8KFjnHMx/xOYT8BbwuZ+pU0IrJNEGE
         w8KuWHFVl5UYkLMXPvtdgsANVK6J32hAdYfteEBMWDUXmFFk4/NZsfBqhGGUx9/t0wOd
         FMkraDyv+4F3Gqm8uSX03G1HG+pRrwQ94WSAf6fygk6gn3KKOk7uhhlyD3VbxuHTlRxU
         q4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvB7DRSLIJsu2QDVvAH21ZQ4Gy+2QZgnSgEI2dOTEt0=;
        b=2DCKJweVMBn41HO+xiTBBhjH5d7hWYJyN1DLcPip7SGtBf/kk2/TRBFp5ViYKdTvDz
         ZuF68NFSs1MH1Ps/Fhy7vD7XlfubpjFF7gsvevq1umuRKKsl0USwZY2w5IX6QVyx+May
         XtLxC6m8Cx0K9S+YQDGv40IH2tBHM2FzyGUHZ7camXTDGv2MvllSsPoZtXY09Iz86wSN
         JzQ/3FSQhiBNxrSIbiesZI79RaF7qzxFATal04WhPIcLzJ2dIxn4gyIws3YTuNvoZ7z9
         bcYAqA3tFmRd5wEgVSfNyvfIN6Gz9ZZC89GqZK3RSraYId/GlKy7VID10cSfjkC0e9N3
         FEvA==
X-Gm-Message-State: ACrzQf2vZLST/+h9m+mgQSZt+onGrRXO0bBkqn1/6hdwjXBDv2e0Kdvc
        3Vmenb1b59lW/m7o9HY3NNN1Rw==
X-Google-Smtp-Source: AMsMyM7Q6+lUR906uXz77OJL7caD9hTq9B3vXTheF8RSh2YPDI3ohe3tEP/3XRjyZRMqQrdQPRdTqw==
X-Received: by 2002:a05:600c:310b:b0:3cf:33c4:bc7 with SMTP id g11-20020a05600c310b00b003cf33c40bc7mr331565wmo.25.1666980375762;
        Fri, 28 Oct 2022 11:06:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f140:5b68:9840:42ab? ([2a05:6e02:1041:c10:f140:5b68:9840:42ab])
        by smtp.gmail.com with ESMTPSA id k1-20020adff281000000b0022ac672654dsm4176673wro.58.2022.10.28.11.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 11:06:15 -0700 (PDT)
Message-ID: <15ac0fff-b864-3377-7d7a-62fb516e8552@linexp.org>
Date:   Fri, 28 Oct 2022 20:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] thermal/of: Accept but warn about TZ without trip
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
References: <20221028114433.51839-1-linus.walleij@linaro.org>
 <CAJZ5v0gVSZo2J2TO_0cL01P4EGLDOQ8ZkzZi=zLjPrO03WMP7g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <CAJZ5v0gVSZo2J2TO_0cL01P4EGLDOQ8ZkzZi=zLjPrO03WMP7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/10/2022 19:50, Rafael J. Wysocki wrote:
> On Fri, Oct 28, 2022 at 1:46 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> The thermal OF core used to accept the creation of thermal zones
>> without trip points, but recent changes made it error out as
>> thermal zones should according to specification have trip
>> points.
>>
>> Relax the requirements so we still create those thermal zones
>> but make a request to update the DTS in the kernel log.
>>
>> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>   drivers/thermal/thermal_of.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index d4b6335ace15..f683cbb4a72a 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -592,8 +592,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>>          struct thermal_zone_params *tzp;
>>          struct thermal_zone_device_ops *of_ops;
>>          struct device_node *np;
>> -       int delay, pdelay;
>> -       int ntrips, mask;
>> +       int delay = 0, pdelay = 0;
>> +       int ntrips = 0, mask = 0;
>>          int ret;
>>
>>          of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
>> @@ -610,7 +610,9 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>>          trips = thermal_of_trips_init(np, &ntrips);
>>          if (IS_ERR(trips)) {
>>                  pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
>> -               return ERR_CAST(trips);
>> +               pr_err("Trip points are compulsory for thermal zones, please add them to the DTS\n");
>> +               trips = NULL;
>> +               goto out_register;
>>          }
>>
>>          ret = thermal_of_monitor_init(np, &delay, &pdelay);
>> @@ -636,6 +638,7 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>>
>>          mask = GENMASK_ULL((ntrips) - 1, 0);
>>
>> +out_register:
>>          tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
>>                                                       mask, data, of_ops, tzp,
>>                                                       pdelay, delay);
>> --
> 
> Applied, but I'll push it for -rc4.

Thanks

