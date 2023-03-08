Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060676B04E2
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 11:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCHKqL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 05:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCHKqK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 05:46:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE79B6913
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 02:46:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u9so63994595edd.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Mar 2023 02:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678272366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5M6VatutTfufI28ha1InsEH90kQBh1lsWSkyas9k/Ts=;
        b=ENYXdYsgjmOtgMGCxKTIHvPZnbkg/DLl4wUzHlo9prNB2eCYcPAXdKOfis0SeoQIjj
         SbkDGpOpNUYUHQenDaWLpY6uF3qJR1TcJT5RCXMr93moFx94xCShRQbdGIYdCzIoGX3u
         HtlPP7CA3pra6o6866WEfdf7zHg85quVYC6kGR1/FdveV6eQJFixBrrqKP+tL5bd6Qtr
         hPAB5WBSqqHORx1ZwYnciE4c16Sdv4FJmryj81h6Q2xqiiBGAgq6ByHKL2KFBThvD2Es
         hSLYomGoHtsVHiaTXUf08TLWjiatwwLz7fZyKb9kkeH3VDyXzdfxL7s6XqTDlMsAuNCS
         a+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5M6VatutTfufI28ha1InsEH90kQBh1lsWSkyas9k/Ts=;
        b=utMG1ZQpaA9Fv+gSEiyJMGagQXGH2Qj/FKSLoPuI1f7gVa1BjwihVeOMMwYkBWG7SY
         /sWkrrHoGMRTDxDpbkBJx631HL2uQnvWhOnt+h8WS433StDxbiIi35oy5h3GPdIGqOpd
         zefchnUkKno5sCJhI7WiAiZTARIOoF/9UmuSpfPtzlaXjnmeI3zjK1QEb994mhRaECxT
         n0oOU7njNSgaFASdbOj3yZ9aobzp3AHPPnm1lvzwkzlRh2i6Ivf8nauJJcLsK1PoTQhb
         nYzqjhww6sqt+KB2YMhIiZkBskPCf31i+lBxd4Q9xJp11LRZKi+s8zHnwzrcuUHSIhSD
         33xg==
X-Gm-Message-State: AO0yUKV0wjl5LCDABowTGfnRvtUTJQ3/1e1qWc+LIEjoDDRl9lD0y+Bx
        3carLhf5L1g1lsS69WTdc1R+SyOxPjR6NY/KHOk=
X-Google-Smtp-Source: AK7set9vESpAD8gB4s27uCA8byM7hBz9aqYhkjrmNGEsvRtgwIZXcyBgKN8NxEWJJVovF5AhqkwPmQ==
X-Received: by 2002:a17:906:94d0:b0:906:430e:8309 with SMTP id d16-20020a17090694d000b00906430e8309mr15752518ejy.64.1678272366550;
        Wed, 08 Mar 2023 02:46:06 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id x6-20020a170906134600b008e724dfc44bsm7339330ejb.78.2023.03.08.02.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:46:06 -0800 (PST)
Message-ID: <74ba115e-9838-4983-7b93-188a8260dd8a@linaro.org>
Date:   Wed, 8 Mar 2023 11:46:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 4/4] power: max17040: get thermal data from adc if
 available
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308084419.11934-1-clamor95@gmail.com>
 <20230308084419.11934-5-clamor95@gmail.com>
 <c04d4306-de81-363c-2d2e-60f5283a5249@linaro.org>
 <CAPVz0n0DNpn7uO+2X9QREpdc51R--ogsLSXWTyL1TybDsO2GvQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPVz0n0DNpn7uO+2X9QREpdc51R--ogsLSXWTyL1TybDsO2GvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2023 10:23, Svyatoslav Ryhel wrote:
> ср, 8 бер. 2023 р. о 11:08 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> пише:
>>
>> On 08/03/2023 09:44, Svyatoslav Ryhel wrote:
>>> Since fuel gauge does not support thermal monitoring,
>>> some vendors may couple this fuel gauge with thermal/adc
>>> sensor to monitor battery cell exact temperature.
>>>
>>> Add this feature by adding optional iio thermal channel.
>>>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>  drivers/power/supply/max17040_battery.c | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
>>> index 6dfce7b1309e..8c743c26dc6e 100644
>>> --- a/drivers/power/supply/max17040_battery.c
>>> +++ b/drivers/power/supply/max17040_battery.c
>>> @@ -18,6 +18,7 @@
>>>  #include <linux/of_device.h>
>>>  #include <linux/regmap.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/iio/consumer.h>
>>>
>>>  #define MAX17040_VCELL       0x02
>>>  #define MAX17040_SOC 0x04
>>> @@ -143,6 +144,7 @@ struct max17040_chip {
>>>       struct power_supply             *battery;
>>>       struct power_supply_battery_info        *batt_info;
>>>       struct chip_data                data;
>>> +     struct iio_channel              *channel_temp;
>>>
>>>       /* battery capacity */
>>>       int soc;
>>> @@ -416,6 +418,11 @@ static int max17040_get_property(struct power_supply *psy,
>>>       case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>>>               val->intval = chip->batt_info->charge_full_design_uah;
>>>               break;
>>> +     case POWER_SUPPLY_PROP_TEMP:
>>> +             iio_read_channel_raw(chip->channel_temp,
>>> +                                  &val->intval);
>>> +             val->intval *= 10;
>>
>> I am not convinced this is needed at all. You basically chain two
>> subsystems only to report to user-space via power supply, but it is
>> already reported via IIO. I would understand it if you use the value for
>> something, e.g. control the charger. Here, it's just feeding different
>> user-space interface. Therefore:
>> 1. IO channels are not a hardware property of the fuel gauge,
>> 2. I have doubts this should be even exposed via power supply interface.
>>
> 
> I can assure you that this is only the beginning of weird vendor solutions
> I have discovered. Nonetheless, max17040 has no battery temp property,
> this means in case I have a critical battery overheating, userspace
> will tell me nothing

Of course will tell you - via IIO.

> since instead of having direct battery temp property under power supply I have
> separate iio sensor, which may not even be monitored. It is always nice to have
> battery explosions.

Hm, ok, I defer this to Sebastian. What's the policy - who should report
battery temperature if the battery/FG itself does not have any sensor?

Best regards,
Krzysztof

