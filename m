Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C226CDBF3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Mar 2023 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjC2OSG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Mar 2023 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjC2ORT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2023 10:17:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4277F5BA0
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 07:16:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r29so15860969wra.13
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680099363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkjlmmdc6+r7J1KgH/df1iRCkHOUNpvDCHr74dZ5Ttk=;
        b=hciMjcGJzvZUruUgDjUU1RMvOaqnB0d2RGwL16SljLlZzKv2NDMDVlSnI+DEcOv1if
         XQ1VEK/Ov7e8bcm3ETZLSNaz/ASh1RwapBpvR3oVVdbHAWaMAM7gKYWZUKLPr0aJT3TH
         AD7or7awvUreM76if5/PI6QdI8cXx2qKtJ9VUalPb4KPpE+0GEzYhQNLL7w7hmUOPfOF
         WzAH/cyl1aXxHEEsAYMEXgjgdrGCE6c8fvOo6FwDYIvzlqIum0yi3tZuW4AmdxoRTXpx
         SJIneEGJ0N3oGSEFcBfQrchbuXAiYkKgs/hMp7ZQsM9SpzaTVZWTgFxafX0M4HyVAnZ/
         /QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680099363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkjlmmdc6+r7J1KgH/df1iRCkHOUNpvDCHr74dZ5Ttk=;
        b=DWscrikaZIxMnBsO6sw9c/WRStRWpPPS+hWMQ6h4gsd6Fa688uyRsnTpP1+G++zw9L
         CiH8bTNs+ZXXJJ0qC98nQ8GF763oe01EzSQ8cvUsrv4iV2B+Jj7Zr7ivs5AHGahkmxCP
         hFdOFHQFtrN6X5EaQV0HnsJSJ3V+SdbUSwk7IYahF0Jpfp4oSPwGgKzpvYZAj17fnPeu
         7Ib8viygMOYyHij8JpSu7ojnLy0V1R705H7t4xwl7ND645tkMBFIjEv0Nlv+mliXu9jY
         i/kL3QtBNmM6Sr0dzYqj1EDdYyI6uJyCIBUDJiWQgNFU8bJiy6gQe59VpWqmJ3+/4o+W
         nR6A==
X-Gm-Message-State: AAQBX9feKjUdjMiQrqbjfavZGVolv8q+vLi9H7PatkoDc4MA8rGeiLSo
        ThJ/mVn5OkSqfkdC+3HjYjb3GA==
X-Google-Smtp-Source: AKy350bwIiKRV2P7Hs8e2DqroflAijovovRLfFOtqrz94tfgBBJd2oQd4D51Bky7jmAzcvfDiZAWvA==
X-Received: by 2002:adf:eed1:0:b0:2d8:ce83:5de0 with SMTP id a17-20020adfeed1000000b002d8ce835de0mr16376520wrp.48.1680099363011;
        Wed, 29 Mar 2023 07:16:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7c0e:2838:74e9:d05? ([2a05:6e02:1041:c10:7c0e:2838:74e9:d05])
        by smtp.googlemail.com with ESMTPSA id a6-20020a056000100600b002c8ed82c56csm30319851wrx.116.2023.03.29.07.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 07:16:02 -0700 (PDT)
Message-ID: <016dc073-c9a3-4b96-6c58-7b21e0f998a5@linaro.org>
Date:   Wed, 29 Mar 2023 16:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
References: <20230329090055.7537-1-rui.zhang@intel.com>
 <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
 <CAJZ5v0hGnoEhYadoK-KPTvMtvviOrGqbY9jrmOUzTjOGe_rB_A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hGnoEhYadoK-KPTvMtvviOrGqbY9jrmOUzTjOGe_rB_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/03/2023 14:06, Rafael J. Wysocki wrote:
> On Wed, Mar 29, 2023 at 11:57 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 29/03/2023 11:00, Zhang Rui wrote:
>>> When the hwmon device node of a thermal zone device is not found,
>>> using hwmon->device causes a kernel NULL pointer dereference.
>>>
>>> Reported-by: Preble Adam C <adam.c.preble@intel.com>
>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>> ---
>>> Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
>>> dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
>>> I'm not sure if the Fix tag applies to such commit or not.
>>
>> Actually it reverts the work done to encapsulate the thermal zone device
>> structure.
> 
> So maybe instead of the wholesale switch to using "driver-specific"
> device pointers for printing messages, something like
> thermal_zone_debug/info/warn/error() taking a thermal zone pointer as
> the first argument can be defined?
> 
> At least this particular bug could be avoided this way.

Actually we previously said the thermal_hwmon can be considered as part 
of the thermal core code, so we can keep using tz->device.

I'll drop this change from the series.

On the other side, adding more thermal_zone_debug/info.. gives 
opportunities to external components of the core thermal framework to 
write thermal zone device related message. I'm not sure that is a good 
thing, each writer should stay in its namespace, no ?

>>> ---
>>>    drivers/thermal/thermal_hwmon.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
>>> index c59db17dddd6..261743f461be 100644
>>> --- a/drivers/thermal/thermal_hwmon.c
>>> +++ b/drivers/thermal/thermal_hwmon.c
>>> @@ -229,7 +229,7 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>>>        hwmon = thermal_hwmon_lookup_by_type(tz);
>>>        if (unlikely(!hwmon)) {
>>>                /* Should never happen... */
>>> -             dev_dbg(hwmon->device, "hwmon device lookup failed!\n");
>>> +             dev_dbg(&tz->device, "hwmon device lookup failed!\n");
>>
>> As it 'Should never happen', I would replace that by:
>>
>>          if (WARN_ON(!hwmon))
>>                  /* Should never happen... */
>>                  return;
>>
>>
>>
>>>                return;
>>>        }
>>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

