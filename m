Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D135FA223
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJJQpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJJQpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 12:45:43 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA0264A2
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 09:45:36 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 69A9484D8E;
        Mon, 10 Oct 2022 18:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665420333;
        bh=xYn8KlFlu4UOd6AIU/ZOQ7980p6LUjwPnho76QhMGTk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HGyYTDkYOjEsK9UiUr61uIgRAsXTdJXbrfe8wPxo5UAOvxdrxb+7+qgf6Wim11TZK
         lxnFIDY86Pr04WEInthLIemZRuG+B/zh2H8SZBluGgunETZz1mkPZFDe6jwJrs7lE6
         irLzV0oRAqyk06jIDa79N/zzHf0ILZttU5L1vlLZ+ARKQnaRluSmLmx2d6Fy1yh9ab
         LI9an316YywLL9iktheFdxHf4NI03qe3bIi7aHqT0ad4U82J+dYlCMEWxSs4XZuyZm
         fru9Sr/TxmaNM/tUopCJWNTZY+J3XXnK/iqVXsmGjs8AFoPsX9PuxpsqjvRV9VNL//
         JUbs+27NJE3Ig==
Message-ID: <2bcdbfa7-0029-fd49-edfd-70c061e34e2a@denx.de>
Date:   Mon, 10 Oct 2022 18:45:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] power: supply: bq25890: Rename
 POWER_SUPPLY_PROP_CURRENT_NOW to CC current
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221009191839.102686-1-marex@denx.de>
 <20221009191839.102686-2-marex@denx.de> <Y0NSBvkcOOx/3XcR@qmqm.qmqm.pl>
 <1da48c09-fe83-c4d7-8d6f-c5e5a7189bc0@denx.de>
 <36389281-89dd-8bbf-851b-3b227765c17d@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <36389281-89dd-8bbf-851b-3b227765c17d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/10/22 15:27, Hans de Goede wrote:
> Hi,

Hi,

> On 10/10/22 02:00, Marek Vasut wrote:
>> On 10/10/22 00:58, Michał Mirosław wrote:
>>> On Sun, Oct 09, 2022 at 09:18:39PM +0200, Marek Vasut wrote:
>>>> The POWER_SUPPLY_PROP_CURRENT_NOW property represents, as far as I can tell,
>>>> the immediate power supply input current, however, this driver reports the
>>>> immediate battery charge current using that property, i.e. content of REG12
>>>> ICHGR -- ADC conversion of Charge Current (IBAT). Replace the property with
>>>> POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT, which as far as I can tell should
>>>> be used to report immediate battery charge voltage.
>>>>
>>>> This also aligns the behavior of POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT
>>>> with POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE, as the former reports IBAT
>>>> and the later reports VBAT.
>>>
>>> I believe this is wrong: CC_CURRENT would be the constant-current charge phase
>>> current limit (ICHG in REG04).
>>>
>>> Documentation/power/power_supply_class.rst mentions that:
>>>
>>> CONSTANT_CHARGE_CURRENT
>>>     constant charge current programmed by charger.
>>
>> I think I will wait for the subsystem maintainer to clarify these properties, because right now, this driver seems to be a complete mess in terms of what it reports and through which property. And I'm afraid that is because neither of those properties are clearly documented.
> 
> CURRENT_NOW normally is only used in fuel-gauge IC drivers (or in
> the fuel-gauge/battery-type power_supply device registered by a MFD device).
> 
> When CURRENT_NOW is used on a fuel-gauge / battery type power_supply class
> device then CURRENT_NOW indeed should work as mentioned in the commit msg:
> "this driver reports the immediate battery charge current using that property"
> re-purposing this for reporting "the immediate power supply input current"
> seems wrong to me.
> 
> For reporting "the immediate power supply input current" IMHO adding
> a new POWER_SUPPLY_PROP_INPUT_CURRENT_NOW property would be more
> appropriate to go hand in hand with the existing
> POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT limit.

The BQ25896 only ever samples one type of current using its ADC -- I_BAT 
-- charge current that is at this time used to charge the battery. So we 
do not really need a new property for that (maybe, let's see below).

> As for what to do with the existing use of POWER_SUPPLY_PROP_CURRENT_NOW
> in the bq25890 driver. I agree that this is a bit confusing, since
> charger type ICs really have 2/3 currents which are relevant:
> 
> 1. The input-current from an external powersupply (if present)

Not present on BQ25896

> 2. The output-current going to the rest of the system

Not present on BQ25896

> 3. The (dis)charge-current flowing to/from the battery

That's the I_BAT

> having an attribute simply named "current" is not really helpful,
> it is fine (and widely used by userspace) on battery-type power_supply
> class devices since there is only the 1 current going into/out-off
> the battery.
> 
> I see 3 solutions for this for charger style devices:
> 
> 1. Document that current_now is for the (dis)charge current flowing
> into/out-off the attached battery. So basically document what
> the bq25890 driver is doing now.
> 
> 2. Add a new charge_current_now attribute for this and switch
> bq25890 over.
> 
> 3. Don't report the charge-current in the charger driver, since
> this is duplicate info with the fuel-gauge driver.
> 
> 2. has a bit of a risk of breaking userspace, so I'm not
> sure if that is a viable option. Given this I have a slight
> preference for solution 1.
> 
> I hope this helps clarify the confusion surrounding this a bit.

Maybe we should add POWER_SUPPLY_PROP_CHARGE_CURRENT_NOW and deprecate 
POWER_SUPPLY_PROP_CURRENT_NOW ? That won't break userspace and would be 
clear in what it does. Yes, we would have duplicate sysfs attribute.
