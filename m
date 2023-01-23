Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B16678432
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jan 2023 19:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjAWSJ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Jan 2023 13:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjAWSJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2023 13:09:50 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08006190
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 10:09:49 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so9237959wmc.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8UgnE9yzQF0/kVw1PL+2zXVglBvTk6kltxJXDJT9BEE=;
        b=lO/ofHm2oLCA8D9EygOt6I2k8rvS0T7OuwBbIv5LSIb7VeVPbdkncXCquvm8YyHI0l
         o05cJNTCy+zYkKzckP9szX+y4NgGH1r/pmDCrAd9YGLBMynEu1YPZ3PRPcfSZGkrPny0
         eVaGzV3BYK4d1SVwpRO2AZPZDnDrZdCVncXuR6efnEZK5FlzkfXRHySIHKp//5nBZ0xC
         D1Li4GFq3RDqvVRmBnLJ3Ztl7S5fbjxnBBQrFgXXzfPEBQI23aQje4nwVRrC19HuJSGH
         sigiGlCfqv/7Pea+9vvYVrfP896xT5/eraqB4Dwpu4hPFsilJ1rmRKrzfUkd33ToDVgM
         FvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UgnE9yzQF0/kVw1PL+2zXVglBvTk6kltxJXDJT9BEE=;
        b=XvwcY1O3k6SExjKipvGMf/3hdezbFN79/neacUbiXlaKI/FeY4ITZTcEeGeCsA95b9
         4gSodStLBhC3Y79C2cmAazG0GF5Ku0WoWRVMEdV2j7TeacycuIY2/bKg1lBez8GMW3Mj
         isY5UVjdtdJnUviTLw15J17tCwBx2WYdCKqn/kHLakYT4eW9Fy1eqUHQ/RNX1O/HlpUJ
         1/1Fdef44aNOUmrRVc0qfl9Wwe7Lvz449YU4SDcfxuJSgF/julfymHn3aFkFl9KxX00A
         laV5s5dvB2gS+Q3VVfDF1z0lFCwUWq0H4dKIP+3Xijc8E/39xqCr8yy3DZPDln2ObCPd
         dU3w==
X-Gm-Message-State: AFqh2kpjztJArplBnrnSK6iazULrOtnhfsEuKSf1UCikY9utU3syUSk2
        uVE8i3qnQpwiRscdLM5fxmxMOA==
X-Google-Smtp-Source: AMrXdXt9rMaHRspPdmiatf0waXS8DVwHrYK+M9dNQzuX3sPOYtaOZ4bjAgTVu9rg3cprzcsKmgGQrg==
X-Received: by 2002:a05:600c:3586:b0:3da:fb3c:c1ab with SMTP id p6-20020a05600c358600b003dafb3cc1abmr24815025wmq.0.1674497387509;
        Mon, 23 Jan 2023 10:09:47 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o13-20020a05600c4fcd00b003d237d60318sm12380338wmq.2.2023.01.23.10.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:09:47 -0800 (PST)
Message-ID: <ff598dd3-91d0-b660-7821-e34177056954@linaro.org>
Date:   Mon, 23 Jan 2023 19:09:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for
 intel_soc_dts_iosf
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <20230118181622.33335-3-daniel.lezcano@linaro.org>
 <CAJZ5v0hCJF-+1SFHyNF-=4FWPLcOqRnc09KeA=rz6BdYTvb=BQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hCJF-+1SFHyNF-=4FWPLcOqRnc09KeA=rz6BdYTvb=BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Srinivas,

On 19/01/2023 21:04, Rafael J. Wysocki wrote:
> On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> From: Daniel Lezcano <daniel.lezcano@kernel.org>
>>
>> The thermal framework gives the possibility to register the trip
>> points with the thermal zone. When that is done, no get_trip_* ops are
>> needed and they can be removed.
>>
>> Convert ops content logic into generic trip points and register them with the
>> thermal zone.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>>
>> @@ -320,7 +304,8 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
>>          dts->trip_mask = trip_mask;
>>          dts->trip_count = trip_count;
>>          snprintf(name, sizeof(name), "soc_dts%d", id);
>> -       dts->tzone = thermal_zone_device_register(name,
>> +       dts->tzone = thermal_zone_device_register_with_trips(name,
>> +                                                 dts->trips,
>>                                                    trip_count,
>>                                                    trip_mask,
>>                                                    dts, &tzone_ops,
>> @@ -430,27 +415,28 @@ struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
>>                  notification = false;
>>          else
>>                  notification = true;
>> -       for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
>> -               sensors->soc_dts[i].sensors = sensors;
>> -               ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
>> -                                          notification, trip_count,
>> -                                          read_only_trip_count);
>> -               if (ret)
>> -                       goto err_free;
>> -       }
> 
> How is this change related to the rest of the patch?

We want to register the thermal zone with the trip points.

thermal_zone_device_register() becomes

thermal_zone_device_register_with_trips()

But in the current code, the trip points are updated after the thermal 
zones are created (and strictly speaking it is wrong as get_trip_temp 
can be invoked before the trip points are updated).

So the change inverts the initialization where we update the trip points 
and then we register the thermal zones.

>>
>>          for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
>>                  ret = update_trip_temp(&sensors->soc_dts[i], 0, 0,
>>                                         THERMAL_TRIP_PASSIVE);
>>                  if (ret)
>> -                       goto err_remove_zone;
>> +                       goto err_free;
>>
>>                  ret = update_trip_temp(&sensors->soc_dts[i], 1, 0,
>>                                         THERMAL_TRIP_PASSIVE);
>>                  if (ret)
>> -                       goto err_remove_zone;
>> +                       goto err_free;
>>          }
>>
>> +       for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
>> +               sensors->soc_dts[i].sensors = sensors;
>> +               ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
>> +                                          notification, trip_count,
>> +                                          read_only_trip_count);
>> +               if (ret)
>> +                       goto err_remove_zone;
>> +       }
>> +

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

