Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E3631695
	for <lists+linux-pm@lfdr.de>; Sun, 20 Nov 2022 22:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKTVav (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Nov 2022 16:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKTVau (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Nov 2022 16:30:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D512AC8
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 13:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668979795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bdm31HVF946Bl5tXtQMWTMTgK4/JfbClmpR+W+Eh+IE=;
        b=a4gFw8xnhctUSApVFdeNhswps9zYMMASOkcV5QDzspbZgxEzzG4nAcJKO3KnArSptmXKok
        bu2MmXJol/1LWIdMVBh83hhl+KFM6XFKIloMhooXtQvuhohMf798wnGnYi1jpulwqCLr3C
        kNiwDl0XDo+quDuJtbgVJ06NVxSHk40=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-6ByAtjelN8yFB9qPTT581g-1; Sun, 20 Nov 2022 16:29:54 -0500
X-MC-Unique: 6ByAtjelN8yFB9qPTT581g-1
Received: by mail-ed1-f70.google.com with SMTP id h9-20020a05640250c900b00461d8ee12e2so5478368edb.23
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 13:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bdm31HVF946Bl5tXtQMWTMTgK4/JfbClmpR+W+Eh+IE=;
        b=d9Zv+S83abKKg1sJVUyv+//81yIVhe82h+pgakOKr7XyWGUyZaihv/NicCYlRZYFUt
         /IsSqloVIdkGPiqT9gSNfuSlLm9/Qkv35jIqovhAipILfJstJopZB4ugbqx9+AaUIc62
         DxN5y4QW0is5rpJJRSBU9gWQo8G9aIlA+83j72GQ5FfhGUTjzG7UtUjHOyt3JYl/qTFo
         pbYC2YoTtt9nQKhG97k3PTuvWBwkjw0lHM74uoT7Vy2RLr1+pTPlvFFm5deRG17qK/To
         HPa2qCPRdaMTYMelPxUgAC1kXv/tXrEyos1H2frH2KpCo9FTVyHM9Ek0H1oJLoAoFhLd
         gJRA==
X-Gm-Message-State: ANoB5pmCAlDlDbzSQyHMMlkm/4MHlrZpVghrNnqmc1JRDd9ZEovzNFNY
        ts82lXNIVSKQnJ46bnhpBbtiLyaurXrAWcT9iGEIu0EKFMzJBGJNfyKt9BlCQ8PYKKN84Q0LJZf
        PRgCyqX5PgjMaMq9ZfFU=
X-Received: by 2002:a05:6402:b8c:b0:463:b8dc:893f with SMTP id cf12-20020a0564020b8c00b00463b8dc893fmr14142177edb.28.1668979793139;
        Sun, 20 Nov 2022 13:29:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf43sXRK38/nRt72jQB+rbrpM22LoNHoQZK/DuOpu3iAsPcpjdE29vefYKYVKZQ1SxNVSQa9VA==
X-Received: by 2002:a05:6402:b8c:b0:463:b8dc:893f with SMTP id cf12-20020a0564020b8c00b00463b8dc893fmr14142170edb.28.1668979792960;
        Sun, 20 Nov 2022 13:29:52 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d12-20020a056402078c00b0045b3853c4b7sm4423417edy.51.2022.11.20.13.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 13:29:52 -0800 (PST)
Message-ID: <1cde6f13-c131-332f-44f2-9a6a80b72330@redhat.com>
Date:   Sun, 20 Nov 2022 22:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] power: supply: bq25890: Add HiZ mode support
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20221109221504.79562-1-marex@denx.de>
 <20221109221504.79562-2-marex@denx.de>
 <ffd849db-fdb5-8578-85c2-74a8e030d86a@redhat.com>
In-Reply-To: <ffd849db-fdb5-8578-85c2-74a8e030d86a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/19/22 14:52, Hans de Goede wrote:
> Hi,
> 
> On 11/9/22 23:15, Marek Vasut wrote:
>> The bq25890 is capable of disconnecting itself from the external supply,
>> in which case the system is supplied only from the battery. This can be
>> useful e.g. to test the pure battery operation, or draw no power from
>> USB port.
>>
>> Implement support for this mode, which can be toggled by writing 0 or
>> non-zero to sysfs 'online' attribute, to select either offline or online
>> mode.
>>
>> The IRQ handler has to be triggered to update chip state, as switching
>> to and from HiZ mode does not generate an interrupt automatically.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Cc: Sebastian Reichel <sre@kernel.org>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Also your timing is excellent :)  As a hobby project I'm working
> on a x86 Lenovo Android tablet which has 2 separate batteries and
> each battery has its own bq25892 chip.
> 
> This requires putting the secondary bq25892 in Hi-Z mode when
> e.g. enabling the 5V USB/OTG boost regulator on the primary
> bq25892 to make the micro-usb output 5V.
> 
> Which is functionality which I can nicely build on top of this
> series.

So one thing which I noticed while working on my own stuff
on top of this, is that the charger IC resets (disables) Hi-Z
mode when its internal PG (power-good) signal goes from false
to true.

The Android kernel fork for the tablet I'm working on detects
the PG false -> true transition in its IRQ handler and then
re-enabled Hi-Z mode if it was requested.

I wonder if we should do something similar: remember the last
value written to /sys/class/power_supply/bq2589o-charger/online
and then in the IRQ handler if Hi-Z mode was requested re-enable
Hi-Z mode ?

Regards,

Hans



>> ---
>>  drivers/power/supply/bq25890_charger.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
>> index 676eb66374e01..70b5783999345 100644
>> --- a/drivers/power/supply/bq25890_charger.c
>> +++ b/drivers/power/supply/bq25890_charger.c
>> @@ -95,6 +95,7 @@ struct bq25890_init_data {
>>  
>>  struct bq25890_state {
>>  	u8 online;
>> +	u8 hiz;
>>  	u8 chrg_status;
>>  	u8 chrg_fault;
>>  	u8 vsys_status;
>> @@ -676,7 +677,8 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
>>  					     const union power_supply_propval *val)
>>  {
>>  	struct bq25890_device *bq = power_supply_get_drvdata(psy);
>> -	int maxval;
>> +	struct bq25890_state state;
>> +	int maxval, ret;
>>  	u8 lval;
>>  
>>  	switch (psp) {
>> @@ -691,6 +693,10 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
>>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>>  		lval = bq25890_find_idx(val->intval, TBL_IINLIM);
>>  		return bq25890_field_write(bq, F_IINLIM, lval);
>> +	case POWER_SUPPLY_PROP_ONLINE:
>> +		ret = bq25890_field_write(bq, F_EN_HIZ, !val->intval);
>> +		bq25890_update_state(bq, psp, &state);
>> +		return ret;
>>  	default:
>>  		return -EINVAL;
>>  	}
>> @@ -703,6 +709,7 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
>>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +	case POWER_SUPPLY_PROP_ONLINE:
>>  		return true;
>>  	default:
>>  		return false;
>> @@ -757,6 +764,7 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
>>  	} state_fields[] = {
>>  		{F_CHG_STAT,	&state->chrg_status},
>>  		{F_PG_STAT,	&state->online},
>> +		{F_EN_HIZ,	&state->hiz},
>>  		{F_VSYS_STAT,	&state->vsys_status},
>>  		{F_BOOST_FAULT, &state->boost_fault},
>>  		{F_BAT_FAULT,	&state->bat_fault},
>> @@ -772,10 +780,11 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
>>  		*state_fields[i].data = ret;
>>  	}
>>  
>> -	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT/NTC=%d/%d/%d/%d\n",
>> -		state->chrg_status, state->online, state->vsys_status,
>> -		state->chrg_fault, state->boost_fault, state->bat_fault,
>> -		state->ntc_fault);
>> +	dev_dbg(bq->dev, "S:CHG/PG/HIZ/VSYS=%d/%d/%d/%d, F:CHG/BOOST/BAT/NTC=%d/%d/%d/%d\n",
>> +		state->chrg_status, state->online,
>> +		state->hiz, state->vsys_status,
>> +		state->chrg_fault, state->boost_fault,
>> +		state->bat_fault, state->ntc_fault);
>>  
>>  	return 0;
>>  }
>> @@ -792,12 +801,14 @@ static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
>>  	if (!memcmp(&bq->state, &new_state, sizeof(new_state)))
>>  		return IRQ_NONE;
>>  
>> -	if (!new_state.online && bq->state.online) {	    /* power removed */
>> +	/* power removed or HiZ */
>> +	if ((!new_state.online || new_state.hiz) && bq->state.online) {
>>  		/* disable ADC */
>>  		ret = bq25890_field_write(bq, F_CONV_RATE, 0);
>>  		if (ret < 0)
>>  			goto error;
>> -	} else if (new_state.online && !bq->state.online) { /* power inserted */
>> +	} else if (new_state.online && !new_state.hiz && !bq->state.online) {
>> +		/* power inserted and not HiZ */
>>  		/* enable ADC, to have control of charge current/voltage */
>>  		ret = bq25890_field_write(bq, F_CONV_RATE, 1);
>>  		if (ret < 0)
> 

