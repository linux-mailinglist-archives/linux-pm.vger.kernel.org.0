Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D21D5F9FA1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJJNu3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiJJNu2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 09:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947BF4D833
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665409825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16tCcsCnrPF1xudrBRvqZwSZs9zjTjlAyB3VmGrGHJ4=;
        b=DKOpl9wfOjQOs0saIrxEfuTEmuAUu6cTKsHRIWj2WFgsKhzeRJ6S7MyZAu2KK/k/drFom9
        KlvJVPssngHi+bZic/WZscNH8bO1Exp+U0JyJJOjiIkr7A+ToUO404nRMCs8oXHChDK3qf
        z832GSIJFo+WZym0JFvV8CialdC9gYs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-mTRp1L3bNqyYV3wB5XOFEQ-1; Mon, 10 Oct 2022 09:50:24 -0400
X-MC-Unique: mTRp1L3bNqyYV3wB5XOFEQ-1
Received: by mail-ej1-f70.google.com with SMTP id gn33-20020a1709070d2100b00787e6fbcb72so4496483ejc.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 06:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16tCcsCnrPF1xudrBRvqZwSZs9zjTjlAyB3VmGrGHJ4=;
        b=34zT3BMnbU8wWpM0qvHts9/z+WY0ytkW7B2eowLG+7bwo02uMr/YzMWR991BTdtLdn
         XuRxSrLdRCxNXKb4hmM9cpfZyeJGkdpk3m+tEj3VwPXKzePyk6gXGoRXrQQWq4HLvM8x
         zSFimiR4cKOgqqc3TfRJNRcqOcs58sMoTA+CZezv3nt9pphj9G/45ajVkiaeJtBhmwZS
         xS5XrSDjrjQzo3ktCEklbrWwTv2q/iF95ZC8wmRiYQAVS7kYeTg19PK8au4Vep6JowVb
         mNzu++iOHhAwYdC8HmabG6f5+5nomGCQAGiszVmgVEZ97wdrtC9w/CCUrvnkwk4/8PfD
         HSHA==
X-Gm-Message-State: ACrzQf0eJfofVAyiqTF7qJX27eM3F4GBsjxWyG9QeoGuxx86F/XGkGPM
        IAbOqy+OSZOQaOF9CiK8lzGO4m+yda9T1y+WQMz9s6i0PYiR2Mbckrlq78AKLZQZGsAf9SKQsHD
        BTzzrlJTZcI9uroL/7lc=
X-Received: by 2002:aa7:c58a:0:b0:459:1511:6cff with SMTP id g10-20020aa7c58a000000b0045915116cffmr18202370edq.27.1665409822995;
        Mon, 10 Oct 2022 06:50:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6KFB46KlT9YhMP5+OrVVNi/nbTcto3o8ihUwbjjVjRZB7W9CoAl23suR9QIMLfQ/y7o5l95A==
X-Received: by 2002:aa7:c58a:0:b0:459:1511:6cff with SMTP id g10-20020aa7c58a000000b0045915116cffmr18202356edq.27.1665409822754;
        Mon, 10 Oct 2022 06:50:22 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709063da200b0073d83f80b05sm5425607ejh.94.2022.10.10.06.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 06:50:22 -0700 (PDT)
Message-ID: <dde63fea-04eb-c438-27d3-fe6ff5c174bc@redhat.com>
Date:   Mon, 10 Oct 2022 15:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] power: supply: bq25890: Add CC voltage to ADC
 properties
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Marek Vasut <marex@denx.de>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221009191839.102686-1-marex@denx.de>
 <Y0NUbeUae01t+UGa@qmqm.qmqm.pl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y0NUbeUae01t+UGa@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/10/22 01:08, Michał Mirosław wrote:
> On Sun, Oct 09, 2022 at 09:18:38PM +0200, Marek Vasut wrote:
>> The POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE , representing register
>> REG0E field BATV is an ADC conversion of Battery Voltage (VBAT). Mark
>> the property as ADC one.
> 
> In this case I believe the property is representing wrong value: it
> should be REG06 - the programmed voltage limit, and _MAX should reflect
> maximum setting possible.

I believe this is correct, POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
should contain the voltage up to which the charger will charge the
connected battery.

The POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE and
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT basically reflect
2 configuration settings / values for the 2 phases most charge-ICs use:

Phase 1, when the voltage of the battery is below the constant-charge-voltage
the charger operates in constant-current mode, operating as a current source
delivering constant-charge-current Ampere into the battery.

Phase 2, when the open-clamp voltage has reached the constant-charge-voltage
value, then the charger IC will switch to constant-voltage mode, operating
as a voltage source, feeding a smaller current into the battery for as long
as there is a voltage differential between the open-clamp voltage of the
battery and the voltage source. Once the 2 reach equilibrium the current
becomes 0 Amps and charging is done.

The POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE and
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT are supposed to reflect the
current resp. voltage settings for these 2 phases and are not supposed
to be ADC readings (an ADC reading is not constant).

As for VOLTAGE_NOW, that is supposed to be an ADC reading, but as
I mentioned about current_now in my earlier reply to patch 2/2 in this
series, VOLTAGE_NOW normally is only used on battery-type power_supply
class devices (so with fuel-gauge ICs).

The problem with using VOLTAGE_NOW with a charger IC is that
(like currents) a charger IC basically has 3 voltages:

1. The input-voltage from an external powersupply (if present)
2. The output-voltage going to the rest of the system
3. The voltage of the connected battery

With 3. being complicated by there being both an actually measured
voltage, which is the result of the internal battery voltage +
an offset caused by the (dis)charge current. as well as a so
called open-clamp voltage which is purely the internal battery
voltage (which gets measured or guessed through magic)

For battery-type power-supply class devices VOLTAGE_NOW is
used to reflect the actual measured voltage of the battery
connections. So using it for Vsys here, which I assume is 2.
from my list of 3 voltages above pretty much feels wrong.

As I mentioned in my reply to 2/2 I believe that for
CURRENT_NOW and likewise VOLTAGE_NOW we should document that
when these are used with charger type power-supply class devices
these 2 should reflect the current/voltage of the battery
connection of the charger, so that they match with their
use in battery-type power-supply devices (where they
are found much more often, many charger-ICs don't have an
ADC for this at all.

We don't really have any existing properties to convey the
Vsys voltage (nor current) atm. So if we want to export
this then IMHO we should add new:

POWER_SUPPLY_PROP_SYSTEM_VOLTAGE,
POWER_SUPPLY_PROP_SYSTEM_CURRENT,

properties for these.

> Though I think there is no proper property
> for the VSYS value that is currently occupying VOLTAGE_NOW - this
> might be better modelled as a separate regulator maybe?

Ack, see above.

> 
> But, for the time being this look ok.

I disagree the current abuse of POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
should be fixed, "REG0E field BATV is an ADC conversion of Battery Voltage (VBAT)"
should be the value used for VOLTAGE_NOW and the current Vsys reading exported
in VOLTAGE_NOW should instead be reported in a new property.

And then POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE should be used
to actually report the 4.2 or 4.35 volt limit (guessing here) to which
the charger will actually charge the battery.

As with my other reply I hope this helps to clarify how these properties
should be used. Or at least how I strongly believe that they should be
used...

Regards,

Hans



> 
>> Fixes: 21d90eda433f ("power: bq25890: fix ADC mode configuration")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>> To: linux-pm@vger.kernel.org
>> ---
>>  drivers/power/supply/bq25890_charger.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
>> index 6020b58c641d2..34dbd498f0f51 100644
>> --- a/drivers/power/supply/bq25890_charger.c
>> +++ b/drivers/power/supply/bq25890_charger.c
>> @@ -432,6 +432,7 @@ static bool bq25890_is_adc_property(enum power_supply_property psp)
>>  {
>>  	switch (psp) {
>>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>>  	case POWER_SUPPLY_PROP_TEMP:
>>  		return true;
>> -- 
>> 2.35.1
>>
> 

