Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEB35FA2BF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 19:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJJRbJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 13:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJJRbI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 13:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D18B4F188
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665423066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDDVWQqGV7gvQyNwBIVstExRrojdZ/VXRIM1CnHozBQ=;
        b=Idi8stMmZlkETgb52Z9UAgK1rXVnJ1phM/QhSZF0/wLUrVWyw5whD8dXuJe9MxtOxQrLZs
        6Syfkht8LMIAyN06V40lnhwiT5IsAwL/KbSqXOZv4lqIXiTCiI0OLzXa4sXmbHwx4UHdJA
        LhujeAxyaT/wkaElRRjKznL4yKLfmdI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-a8ie0KGKMaSXWO-iGmK5uQ-1; Mon, 10 Oct 2022 13:31:05 -0400
X-MC-Unique: a8ie0KGKMaSXWO-iGmK5uQ-1
Received: by mail-ej1-f69.google.com with SMTP id ga20-20020a1709070c1400b0078db506c555so1060762ejc.6
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 10:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDDVWQqGV7gvQyNwBIVstExRrojdZ/VXRIM1CnHozBQ=;
        b=7ZvgG569B6Sn2kfL0/nTFFyUb91hDlFp1l91VHdlIeeHhUTuvE5CUpZeMmmP1hpWUH
         72uY0Q3SbbpW176y8N5qC5XSU3FdBYhaMF16LmcQrpffWzt0CgIzYwfeTdhO2txi8yr3
         fQtFmW/7cF5wRiXr9OxBMDlE2J5CvmBa/wQibk3CMT8QFRMdsjjdsmsGDSHmgQeXinnp
         vWwRMaolA2nt9vI80rfEMLQ7qbgqwlPyAdQqfWhR9sv2yGepdgdzjIWUaMwHQ5PG2RD3
         kOnIj+bxMDvkZINmiUQZXKy4gTuY/SboI0w/nPdw4EgI7HRchEQb+SI5MFojsFkmboPq
         MQoQ==
X-Gm-Message-State: ACrzQf3NKUHuhpRpd88nCUi5vRfgnPhuD3GaLn5t6WK+B99hEgDj0DcM
        cZIITqOOEBFyU2NHa/P66MH1oM2iAZpKC7jxKKGHgP7VhT/XOVmv4PTXULVLtCXTdOxtRxH6WcU
        ufqntB9+NhGBBZ/LFe0w=
X-Received: by 2002:a05:6402:496:b0:443:a5f5:d3b with SMTP id k22-20020a056402049600b00443a5f50d3bmr19398567edv.331.1665423063961;
        Mon, 10 Oct 2022 10:31:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4xQYeY3SpfW+hwgwKaPjtKpBxxg/QCkZfDjm3jk89mbQtJpsflzZrTe51+hpFrTa5erHbNZA==
X-Received: by 2002:a05:6402:496:b0:443:a5f5:d3b with SMTP id k22-20020a056402049600b00443a5f50d3bmr19398539edv.331.1665423063716;
        Mon, 10 Oct 2022 10:31:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id v8-20020a50a448000000b004590d4e35cdsm7502464edb.54.2022.10.10.10.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 10:31:03 -0700 (PDT)
Message-ID: <5521819a-4879-10d1-37ac-8a8fd38436e6@redhat.com>
Date:   Mon, 10 Oct 2022 19:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 2/2] power: supply: bq25890: Rename
 POWER_SUPPLY_PROP_CURRENT_NOW to CC current
To:     Marek Vasut <marex@denx.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221009191839.102686-1-marex@denx.de>
 <20221009191839.102686-2-marex@denx.de> <Y0NSBvkcOOx/3XcR@qmqm.qmqm.pl>
 <1da48c09-fe83-c4d7-8d6f-c5e5a7189bc0@denx.de>
 <36389281-89dd-8bbf-851b-3b227765c17d@redhat.com>
 <2bcdbfa7-0029-fd49-edfd-70c061e34e2a@denx.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2bcdbfa7-0029-fd49-edfd-70c061e34e2a@denx.de>
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

On 10/10/22 18:45, Marek Vasut wrote:
> On 10/10/22 15:27, Hans de Goede wrote:
>> Hi,
> 
> Hi,
> 
>> On 10/10/22 02:00, Marek Vasut wrote:
>>> On 10/10/22 00:58, Michał Mirosław wrote:
>>>> On Sun, Oct 09, 2022 at 09:18:39PM +0200, Marek Vasut wrote:
>>>>> The POWER_SUPPLY_PROP_CURRENT_NOW property represents, as far as I can tell,
>>>>> the immediate power supply input current, however, this driver reports the
>>>>> immediate battery charge current using that property, i.e. content of REG12
>>>>> ICHGR -- ADC conversion of Charge Current (IBAT). Replace the property with
>>>>> POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT, which as far as I can tell should
>>>>> be used to report immediate battery charge voltage.
>>>>>
>>>>> This also aligns the behavior of POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT
>>>>> with POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE, as the former reports IBAT
>>>>> and the later reports VBAT.
>>>>
>>>> I believe this is wrong: CC_CURRENT would be the constant-current charge phase
>>>> current limit (ICHG in REG04).
>>>>
>>>> Documentation/power/power_supply_class.rst mentions that:
>>>>
>>>> CONSTANT_CHARGE_CURRENT
>>>>     constant charge current programmed by charger.
>>>
>>> I think I will wait for the subsystem maintainer to clarify these properties, because right now, this driver seems to be a complete mess in terms of what it reports and through which property. And I'm afraid that is because neither of those properties are clearly documented.
>>
>> CURRENT_NOW normally is only used in fuel-gauge IC drivers (or in
>> the fuel-gauge/battery-type power_supply device registered by a MFD device).
>>
>> When CURRENT_NOW is used on a fuel-gauge / battery type power_supply class
>> device then CURRENT_NOW indeed should work as mentioned in the commit msg:
>> "this driver reports the immediate battery charge current using that property"
>> re-purposing this for reporting "the immediate power supply input current"
>> seems wrong to me.
>>
>> For reporting "the immediate power supply input current" IMHO adding
>> a new POWER_SUPPLY_PROP_INPUT_CURRENT_NOW property would be more
>> appropriate to go hand in hand with the existing
>> POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT limit.
> 
> The BQ25896 only ever samples one type of current using its ADC -- I_BAT -- charge current that is at this time used to charge the battery. So we do not really need a new property for that (maybe, let's see below).

Ah, ok from the discussion I was under the impression that the bq25890
could measure its input current. If it only ever measure the current
to/from the battery then we indeed don't need a new property for this.

>> As for what to do with the existing use of POWER_SUPPLY_PROP_CURRENT_NOW
>> in the bq25890 driver. I agree that this is a bit confusing, since
>> charger type ICs really have 2/3 currents which are relevant:
>>
>> 1. The input-current from an external powersupply (if present)
> 
> Not present on BQ25896
> 
>> 2. The output-current going to the rest of the system
> 
> Not present on BQ25896
> 
>> 3. The (dis)charge-current flowing to/from the battery
> 
> That's the I_BAT

Ack.

>> having an attribute simply named "current" is not really helpful,
>> it is fine (and widely used by userspace) on battery-type power_supply
>> class devices since there is only the 1 current going into/out-off
>> the battery.
>>
>> I see 3 solutions for this for charger style devices:
>>
>> 1. Document that current_now is for the (dis)charge current flowing
>> into/out-off the attached battery. So basically document what
>> the bq25890 driver is doing now.
>>
>> 2. Add a new charge_current_now attribute for this and switch
>> bq25890 over.
>>
>> 3. Don't report the charge-current in the charger driver, since
>> this is duplicate info with the fuel-gauge driver.
>>
>> 2. has a bit of a risk of breaking userspace, so I'm not
>> sure if that is a viable option. Given this I have a slight
>> preference for solution 1.
>>
>> I hope this helps clarify the confusion surrounding this a bit.
> 
> Maybe we should add POWER_SUPPLY_PROP_CHARGE_CURRENT_NOW and deprecate POWER_SUPPLY_PROP_CURRENT_NOW ? That won't break userspace and would be clear in what it does. Yes, we would have duplicate sysfs attribute.

We have a long history of upower (GNOME, XFCE, others) and
the KDE equivalent (PowerDevil?) using POWER_SUPPLY_PROP_CURRENT_NOW
so I'm afraid we will not be able to remove that in a long long time.

As such I believe it would be better to just clearly
document that the current attribute is for the power
going into/out-of the battery and leave it at that.

Regards,

Hans

