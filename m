Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E28563A4A6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 10:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiK1JSV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 04:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiK1JSR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 04:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80742186C2
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 01:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669627041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iqZWLvhDYohmyhXfOCg4UYHkNCfDkbWm/McuPc5mUYI=;
        b=bjCLCc95NZNzd8eE8cB2uRZOc/0jc3sfTnJAHpo1t3s5HzIBJC2PFozfJ0eCzGoQ+oxBMI
        hzpZNxdr7t4V7LOVXdt4bfp3k4ftmQ4PvRrjjE5XoJw6dPyAPnupSXG3QkyI7Z6cn238Ho
        zKM1Q1BsCXX9foZPyq5pN5MdslNZZMA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-LYs37vvGOra7Gk7nli0r6Q-1; Mon, 28 Nov 2022 04:16:40 -0500
X-MC-Unique: LYs37vvGOra7Gk7nli0r6Q-1
Received: by mail-ej1-f69.google.com with SMTP id qw20-20020a1709066a1400b007af13652c92so4026685ejc.20
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 01:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqZWLvhDYohmyhXfOCg4UYHkNCfDkbWm/McuPc5mUYI=;
        b=K/UUNUpP/4RuOJis0udRWCVL5oMGMrKGeGZpMQcv6RSF4cJpSfwOa6rCfjShd1VP/d
         1+nty3dUxT3md+w6OaY8B+SaXtd25pMBQmjg3BjN/JClwkA2ZxzhnQUo/iMnGKK2/A/T
         Xq5U6kcS+gXlC+zXcRnw/g7P5TusMwRmEh4N4KDZiWhZvPx+eMa8QJwufm6mcup9SN6/
         RnOg2sSpWmIuIYBRrd4n5qMCx7CreA/8HcnKI+J3Wn0Gm1P89b8rUqKSeQHKIHuAwKAA
         yBckFIjfbc0LSTKaUOQCsviWduIINSgA8ZzW6k24CydbBXqvpAtNfXNHe7Bm4Xo9pFGS
         +IzA==
X-Gm-Message-State: ANoB5plE00kwAt1W4K9YQa8BwumYqi4EsUQCsjrqJ6sOP2x8ccDt5fJc
        w9YdrRDvHAZzpmD7k5EczUM2q1n7vhlIHhw+R23uRUYKDDsC2IyciGgZ7iOllOWiFurPBdme8nU
        vE28pPm2jfw7Da6nD4ZI=
X-Received: by 2002:a17:906:b241:b0:7bc:1f2c:41b5 with SMTP id ce1-20020a170906b24100b007bc1f2c41b5mr13957588ejb.463.1669626998826;
        Mon, 28 Nov 2022 01:16:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5OVrM6IqY2RvPqj3bK5i5kKG7ixx0P8IWpyH4EYhY9UlRrdy6qFsAMcrFXQlK/T6Im7GY4+g==
X-Received: by 2002:a17:906:b241:b0:7bc:1f2c:41b5 with SMTP id ce1-20020a170906b24100b007bc1f2c41b5mr13957577ejb.463.1669626998560;
        Mon, 28 Nov 2022 01:16:38 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b0077a8fa8ba55sm3014927eju.210.2022.11.28.01.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:16:37 -0800 (PST)
Message-ID: <20f66702-18c1-4d2f-cdf3-a18bfc8035c7@redhat.com>
Date:   Mon, 28 Nov 2022 10:16:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 10/10] power: supply: bq25890: Add new
 linux,iinlim-percentage property
To:     Marek Vasut <marex@denx.de>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-11-hdegoede@redhat.com>
 <d2f2fe8f-9463-d496-dc4f-e3f27dd84526@denx.de>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d2f2fe8f-9463-d496-dc4f-e3f27dd84526@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 11/27/22 22:34, Marek Vasut wrote:
> On 11/27/22 19:02, Hans de Goede wrote:
>> Some devices, such as the Lenovo Yoga Tab 3 Pro (YT3-X90F) have
>> multiple batteries with a separate bq25890 charger for each battery.
>>
>> This requires the maximum current the external power-supply can deliver
>> to be divided over the chargers. The Android vendor kernel shipped
>> on the YT3-X90F divides this current with a 40/60 percent split so that
>> batteries are done charging at approx. the same time if both were fully
>> empty at the start.
>>
>> Add support for a new "linux,iinlim-percentage" percentage property which
>> can be set to indicate that a bq25890 charger should only use that
>> percentage of the external power-supply's maximum current.
>>
>> So far this new property is only used on x86/ACPI (non devicetree) devs,
>> IOW it is not used in actual devicetree files. The devicetree-bindings
>> maintainers have requested properties like these to not be added to the
>> devicetree-bindings, so the new property is deliberately not added
>> to the existing devicetree-bindings.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/power/supply/bq25890_charger.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
>> index b0d07ff24ace..2bd7721b969f 100644
>> --- a/drivers/power/supply/bq25890_charger.c
>> +++ b/drivers/power/supply/bq25890_charger.c
>> @@ -126,6 +126,7 @@ struct bq25890_device {
>>       bool read_back_init_data;
>>       bool force_hiz;
>>       u32 pump_express_vbus_max;
>> +    u32 iinlim_percentage;
> 
> If this is percentage, u8 should be enough, right ?

It is not a charger-chip register value and it is used in
calculations so it is best if this is native integer size.

And I was passing its address directly to device_property_read_u32(),
but that has changed in v2.

>>       enum bq25890_chip_version chip_version;
>>       struct bq25890_init_data init_data;
>>       struct bq25890_state state;
>> @@ -727,6 +728,18 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
>>       }
>>   }
>>   +/*
>> + * If there are multiple chargers the maximum current the external power-supply
>> + * can deliver needs to be divided over the chargers. This is done according
>> + * to the bq->iinlim_percentage setting.
>> + */
>> +static int bq25890_charger_get_scaled_iinlim_regval(struct bq25890_device *bq,
>> +                            int iinlim_ua)
>> +{
>> +    iinlim_ua = iinlim_ua * bq->iinlim_percentage / 100;
> 
> Can this ever add up to value above 100 ?
> Should this use some clamp() ?

bq->iinlim_percentage should never be more then 100. I have added a check
for this when reading the property for version 2 of the series.

Thank you for all the reviews. I've also addressed all your other small
remarks and I will send out a v2 series with these fixed.

Regards,

Hans



> 
>> +    return bq25890_find_idx(iinlim_ua, TBL_IINLIM);
>> +}
>> +
>>   /* On the BQ25892 try to get charger-type info from our supplier */
>>   static void bq25890_charger_external_power_changed(struct power_supply *psy)
>>   {
> 
> [...]
> 

