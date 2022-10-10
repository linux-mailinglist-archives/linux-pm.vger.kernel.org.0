Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778A55F95EC
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 02:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiJJAZ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Oct 2022 20:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiJJAZU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Oct 2022 20:25:20 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD6F4B9B1
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 17:00:57 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0514984B62;
        Mon, 10 Oct 2022 02:00:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665360053;
        bh=p3a6hXZtK+ulMupILln8nimv1U1d9s29Ctyy7p3f/d8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mIYk3Xws+y7en0JrBDyK2AxLV2ntPJUgPYJAyHUUgJkpsHhIvC+HxDse8KwpWISMa
         wLIvs1fCkzvS8xEFGyLWxwqv1YE1Eu6qCktdU8Xu3DH06DuSYwOJx4D01K5vDf4eTC
         +/dsSai3BSM6u7ULr/kuXOYZ8QavIrdtWvBIxsYA1KkzHmzAuzuFcVJ8puOpeE4WfV
         sOEcoKG7RWiGz8mP6V0RH98CWI9848bD35yXZuiP/qMbWna9knEy1e4ZcaVkqvuBCn
         w5MFluFQLlnb87N+1KFQEbF1ZNYljGKN9tKAixilgmA0nKhTQTQK6ZuATYmtkQcc3J
         cCBuVb5S153dg==
Message-ID: <1da48c09-fe83-c4d7-8d6f-c5e5a7189bc0@denx.de>
Date:   Mon, 10 Oct 2022 02:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] power: supply: bq25890: Rename
 POWER_SUPPLY_PROP_CURRENT_NOW to CC current
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221009191839.102686-1-marex@denx.de>
 <20221009191839.102686-2-marex@denx.de> <Y0NSBvkcOOx/3XcR@qmqm.qmqm.pl>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y0NSBvkcOOx/3XcR@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/10/22 00:58, Michał Mirosław wrote:
> On Sun, Oct 09, 2022 at 09:18:39PM +0200, Marek Vasut wrote:
>> The POWER_SUPPLY_PROP_CURRENT_NOW property represents, as far as I can tell,
>> the immediate power supply input current, however, this driver reports the
>> immediate battery charge current using that property, i.e. content of REG12
>> ICHGR -- ADC conversion of Charge Current (IBAT). Replace the property with
>> POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT, which as far as I can tell should
>> be used to report immediate battery charge voltage.
>>
>> This also aligns the behavior of POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT
>> with POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE, as the former reports IBAT
>> and the later reports VBAT.
> 
> I believe this is wrong: CC_CURRENT would be the constant-current charge phase
> current limit (ICHG in REG04).
> 
> Documentation/power/power_supply_class.rst mentions that:
> 
> CONSTANT_CHARGE_CURRENT
>    constant charge current programmed by charger.

I think I will wait for the subsystem maintainer to clarify these 
properties, because right now, this driver seems to be a complete mess 
in terms of what it reports and through which property. And I'm afraid 
that is because neither of those properties are clearly documented.
