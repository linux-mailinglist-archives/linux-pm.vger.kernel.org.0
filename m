Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6EA69FC9F
	for <lists+linux-pm@lfdr.de>; Wed, 22 Feb 2023 21:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjBVUCQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Feb 2023 15:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjBVUCP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Feb 2023 15:02:15 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B9810D8
        for <linux-pm@vger.kernel.org>; Wed, 22 Feb 2023 12:02:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 6so8500217wrb.11
        for <linux-pm@vger.kernel.org>; Wed, 22 Feb 2023 12:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DhRHqLvJYj4z0OtfIAXKHf1ueOdpgGPMIlUvp6o9wU=;
        b=LuZjvwH5mTmoVKOQ5rgu5wz8iw6tbtBDxCTfofuI+d5noVMrRsUXNrTOVletSNSW7N
         vZk6GlW7cnwH+3xQOWyLQlLSObIZuqpZiedixnk0FBMesbVSc02BKRGfW5j6QkUhT/Om
         AmaWYL9jtnldAg9kdMoYLg719UcpWxmX/FyZ8sqDB2TrMSknUOzsNvaD45UBCyZBhGZH
         Ieinpk9E4ynyY0zlEv5THiBtrGn3I2TlRg6jrchetcPQrmFQb2IehCSIXQAofMDL1BDu
         HyENn8ozCh+mY0q9GulfSCqKJHAC+elEAlCOb8SsGo9pgM2+hZVS9iR2AybzM20YpPio
         Ss8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DhRHqLvJYj4z0OtfIAXKHf1ueOdpgGPMIlUvp6o9wU=;
        b=4ctH9LCt7AyPmAWCScoMXuOCIg7l8z+qm9ueCr0Ch7Z+AsQzXzB/GxbUKd5bw7bUQK
         EQKV/MyrD0dYyYPOk4u70k3Ter6hieygeOIY9EYvCuksawjOaYLDHNx6u9jDh7K4EHw7
         Dwl+Q9ABaNzVy6Huk4g+AOmkcpWv/woFVdYVSblfOEfLK90gpKaQBOuMm3AwagX4cm6G
         2qaKkJQ5y6kUl7v9dd+oOVrt0qBGmjSpNqxnJ6midKLUp/EUiC4RVD0Oc7Nz/mNW/sZA
         MkTaK7c9mXzMoCaXvnQmEFPEODhtiewt1cIKi9VI8bht75X4W3t1hK608N+W90kdfPC3
         i94A==
X-Gm-Message-State: AO0yUKWuZlK1DOWDH/7OBxRtfW0n7cAODRZKH/ciqgaaxuSMsz1yYIlT
        0CUl//OE3TBNSOV+vAuamtXEqQ==
X-Google-Smtp-Source: AK7set/bADOJP7PA3ZphGOiQaCHM69eQJJAVWrjg0xc37DsmGxBQ0ZSN0pumGeSCDOoCx3djUrS4eA==
X-Received: by 2002:adf:e641:0:b0:2c5:592b:b70b with SMTP id b1-20020adfe641000000b002c5592bb70bmr9793791wrn.50.1677096132426;
        Wed, 22 Feb 2023 12:02:12 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:be67:8d59:7eae:a15d? ([2a05:6e02:1041:c10:be67:8d59:7eae:a15d])
        by smtp.googlemail.com with ESMTPSA id z14-20020a5d654e000000b002c5801aa9b0sm8640233wrv.40.2023.02.22.12.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 12:02:11 -0800 (PST)
Message-ID: <66a6fdeb-d8e8-0041-769e-84abba7367c8@linaro.org>
Date:   Wed, 22 Feb 2023 21:02:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 16/16] thermal/traces: Replace the thermal zone
 structure parameter with the field value
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-17-daniel.lezcano@linaro.org>
 <CAJZ5v0jfZ2_LyPC9ArnSfHpYgr379HBhk5ODyESoewL_ee1wYw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jfZ2_LyPC9ArnSfHpYgr379HBhk5ODyESoewL_ee1wYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/02/2023 20:51, Rafael J. Wysocki wrote:
> On Tue, Feb 21, 2023 at 7:08 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> In the work of the thermal zone device self-encapsulation, let's pass
>> the field value instead of dereferencing them in the traces which
>> force us to export publicly the thermal_zone_device structure.
>>
>> No fonctionnal change intended.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/gov_fair_share.c              |  2 +-
>>   drivers/thermal/gov_power_allocator.c         |  4 ++--
>>   drivers/thermal/gov_step_wise.c               |  2 +-
>>   drivers/thermal/thermal_core.c                |  5 ++--
>>   include/trace/events/thermal.h                | 24 +++++++++----------
>>   .../trace/events/thermal_power_allocator.h    | 12 +++++-----
>>   6 files changed, 25 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
>> index aad7d5fe3a14..e6c21abaaa80 100644
>> --- a/drivers/thermal/gov_fair_share.c
>> +++ b/drivers/thermal/gov_fair_share.c
>> @@ -35,7 +35,7 @@ static int get_trip_level(struct thermal_zone_device *tz)
>>           * point, in which case, trip_point = count - 1
>>           */
>>          if (count > 0)
>> -               trace_thermal_zone_trip(tz, count - 1, trip.type);
>> +               trace_thermal_zone_trip(tz->type, tz->id, count - 1, trip.type);
> 
> Haven't you introduced an accessor for tz->id in this series?  Why not
> use it here?
> 
> And there can be an analogous accessor for tz->type.
> 
> If there are accessors like that, they should be used consistently
> everywhere as applicable IMO.

governors are part of the thermal core code, so they are authorized to 
access the thermal structure internals, that is why they are not passing 
through the accessors.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

