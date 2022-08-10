Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E555E58EDBC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Aug 2022 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiHJN7F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Aug 2022 09:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiHJN6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Aug 2022 09:58:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5836C76A
        for <linux-pm@vger.kernel.org>; Wed, 10 Aug 2022 06:58:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso1050496wma.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Aug 2022 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=i8HHjwl7WH0iFq76RCd/7R6qXQKnZ7/bS7IRpUVTWS0=;
        b=wktmSceVeQiJ00CteNAZ/9N6Sm2lvi2R+yz76BkP9XOPDuz2Z/6h6BBlwJGOUaEPmJ
         EkatXfHekpnCRrmhtpqUrrWc5QHKgBi0WPefSRBiTJuxbPMSjkQneGHmefMfciQ3ORJu
         IVl5i9l7RoSs6MMcrq6Ze8TD1AX7/O6YDKH26uMF6qp5Q0X3uXc270P2TucMhtS7r0uM
         HJcaYQ7vNmtXSbchS64n/vLwszX6CTOFovvsMaSsdyIj7v0MPRXhRyMUHr/NTK6Vc7WU
         O2WF8N13S0X2VbC8BsJieugkmCkRmIIlX04ftjrFDGVUcM+0eJrzwNLYygBVqYNdpq+y
         Btsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=i8HHjwl7WH0iFq76RCd/7R6qXQKnZ7/bS7IRpUVTWS0=;
        b=Cl15Yaigo+kaDj9twmbhwTgY5YsBTHuCGyYiFQObL++0Qa3ogLG8FrStQmv3wHk4o+
         rDvMXeLFRpKkqqAWZCKz4YachZMuL9A/l8c+ZcpCqpL6vv4iBMybSaNiE/QDvZvQL5TR
         DQz+NMF8NJ8GxHgQHC+bgHl1hx4lVPQaNzcWLR01sYtB9Kw1V5GJ3wwBvRnv2O7qP/9I
         JTTGNVtXWXJBSARUzvJRj9TkrHcefiskt2IdW2iGr2gM2y0js6u9SREXOG8XgIEfZNSd
         TOn2BWpvpe94rn7nfB0YRoSJyZAqm45Q+ubMaCGNG20TTMDeBmxnm3GVVy1WXC0LNQ/R
         iXJg==
X-Gm-Message-State: ACgBeo0PwFG44OijNolDn7cljR5TY3FnxxutDBLTjy2DefjwY/JaBZ7S
        EN7dvcsVmxNDXiZz1XASZxlGrg==
X-Google-Smtp-Source: AA6agR6rDW8RUZXfTUmjdc22Q9BqrI8EAo6g/7PjpBCS6Em9aSvgLhZp3xCCg159xw/CA6Ou3td9Qg==
X-Received: by 2002:a05:600c:1f11:b0:3a5:3df9:4859 with SMTP id bd17-20020a05600c1f1100b003a53df94859mr2484539wmb.175.1660139917198;
        Wed, 10 Aug 2022 06:58:37 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u11-20020adfeb4b000000b0021f15514e7fsm19366090wrn.0.2022.08.10.06.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 06:58:36 -0700 (PDT)
Message-ID: <cbfa173b-25d9-e04f-e230-1cebedce75ce@linaro.org>
Date:   Wed, 10 Aug 2022 15:58:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal/core: Add missing EXPORT_SYMBOL_GPL
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220810100731.749317-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iv4oMsZyUg7-YY6cD2jsYyLdi7sDeE0GEm814kCEAvmQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iv4oMsZyUg7-YY6cD2jsYyLdi7sDeE0GEm814kCEAvmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/08/2022 13:58, Rafael J. Wysocki wrote:
> On Wed, Aug 10, 2022 at 12:07 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The function thermal_zone_device_register_with_trips() is not exported
>> for modules.
>>
>> Add the missing EXPORT_SYMBOL_GPL().
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> A Fixes tag missing?

I've added the missing tag in the thermal/linux-next branch

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/linux-next&id=78ad78d78b43538e6dcbce3fd0699f15b79cfe3f

> 
>> ---
>>   drivers/thermal/thermal_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index b4c68410c158..10c979dce512 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1329,6 +1329,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>>          kfree(tz);
>>          return ERR_PTR(result);
>>   }
>> +EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
>>
>>   struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
>>                                                           void *devdata, struct thermal_zone_device_ops *ops,
>> --
>> 2.34.1
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
