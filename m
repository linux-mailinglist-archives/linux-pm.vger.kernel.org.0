Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461235FCD59
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 23:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJLVgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 17:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJLVgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 17:36:48 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D16AD73C0
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 14:36:45 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 47ABF8455E;
        Wed, 12 Oct 2022 23:36:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665610603;
        bh=OuCXA5U1FEsa03Dc4BPzHBdkg5KhlTmEnIRT0n5gcJA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CZY+zBu6ufbUB+1F9edEHmabsseahgv8muQF71dYfULimx1H7UBHtdbzGbaf085yY
         MIVg5c/JoJtv4/sFzRMYAgLd6LlXzP9+zOPo5+ZEIa3t5sb5y9GmJzJAe9B3viXbN6
         6ZgKNa+p9xwbwHTbYkOv5FAkpXDpPmFMV6w2cSjSBu2hplvGuRHozPzxi6onRbvYB6
         CI74X2JWsy1KOlreKYwTOkPT/RhRiLX+0vkqNVfwu92lIpJ95IC+WncC+Zf9bWokvs
         JztoC1fPUEh1shlooI2CwDAGl3fCWY4boDztUnUUdL5mVuS4NsiPRnqoGWgbAyOnZ7
         glul7UQt6gtvA==
Message-ID: <7e9aa397-eb39-64ae-5e34-69c9b0749b46@denx.de>
Date:   Wed, 12 Oct 2022 23:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/7] power: supply: bq25890: Clean up
 POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-3-marex@denx.de>
 <1bbd11c1-20df-d9d2-568c-2c616b6dbd80@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <1bbd11c1-20df-d9d2-568c-2c616b6dbd80@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/12/22 21:56, Hans de Goede wrote:
> Hi,

Hi,

> On 10/10/22 23:03, Marek Vasut wrote:
>> Clean up misuse of POWER_SUPPLY_PROP_VOLTAGE,
>> POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX
>> and POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
>> and document what exactly each value means.
>>
>> The POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE content is newly read
>> back from hardware, while POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX
>> is reported as the maximum value set in DT.
>>
>> The POWER_SUPPLY_PROP_VOLTAGE is newly used to report immediate value
>> of battery voltage V_BAT, which is what this property was intended to
>> report and which has been thus far misused to report the charger chip
>> output voltage V_SYS.
>>
>> The V_SYS is no longer reported as there is currently no suitable
>> property to report V_SYS. V_SYS reporting will be reinstated in
>> subsequent patch.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>> To: linux-pm@vger.kernel.org
>> ---
>>   drivers/power/supply/bq25890_charger.c | 76 +++++++++++++++++---------
>>   1 file changed, 49 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
>> index 5924b036b1588..7632aad8bf0a1 100644
>> --- a/drivers/power/supply/bq25890_charger.c
>> +++ b/drivers/power/supply/bq25890_charger.c
>> @@ -529,24 +529,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>>   			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
>>   		break;
>>   
>> -	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>> -		if (!state.online) {
>> -			val->intval = 0;
>> -			break;
>> -		}
>> -
>> -		ret = bq25890_field_read(bq, F_BATV); /* read measured value */
>> -		if (ret < 0)
>> -			return ret;
>> -
>> -		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
>> -		val->intval = 2304000 + ret * 20000;
>> -		break;
>> -
>> -	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>> -		val->intval = bq25890_find_val(bq->init_data.vreg, TBL_VREG);
>> -		break;
>> -
>>   	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
>>   		val->intval = bq25890_find_val(bq->init_data.iprechg, TBL_ITERM);
>>   		break;
>> @@ -563,15 +545,6 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>>   		val->intval = bq25890_find_val(ret, TBL_IINLIM);
>>   		break;
>>   
>> -	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> -		ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
>> -		if (ret < 0)
>> -			return ret;
>> -
>> -		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
>> -		val->intval = 2304000 + ret * 20000;
>> -		break;
>> -
>>   	case POWER_SUPPLY_PROP_CURRENT_NOW:	/* I_BAT now */
>>   		/*
>>   		 * This is ADC-sampled immediate charge current supplied
>> @@ -628,6 +601,55 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>>   		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
>>   		break;
>>   
>> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:	/* V_BAT now */
>> +		/*
>> +		 * This is ADC-sampled immediate charge voltage supplied
>> +		 * from charger to battery. The property name is confusing,
>> +		 * for clarification refer to:
>> +		 * Documentation/ABI/testing/sysfs-class-power
>> +		 * /sys/class/power_supply/<supply_name>/voltage_now
>> +		 */
>> +		if (!state.online) {
>> +			val->intval = 0;
>> +			break;
>> +		}
> 
> I see that this 'if (!state.online) { }' block was also there in the original
> POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE code, but I wonder why this is here?
> 
> Does the bq25890 not support sampling the battery voltage when discharging/
> when running from the battery as power-source ?
> 
> I would expect the battery voltage sampling to work fine when discharging
> too, and this is useful into to have during discharge too. Especially when
> there is no fuel-gauge ...

This does work fine while discharging too, so I'll drop the 
!state.online check .
