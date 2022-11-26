Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9551639600
	for <lists+linux-pm@lfdr.de>; Sat, 26 Nov 2022 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKZMzd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Nov 2022 07:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKZMza (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2022 07:55:30 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21111C24
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2022 04:55:27 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 88A1C85020;
        Sat, 26 Nov 2022 13:55:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669467325;
        bh=GyBxEHG+u2yKPc0TXRttxjwuiz+mRzpSHc4Zij8ZByU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IsBXVOsYEPqBCqJJ58Q6e54W/4gRhZRUQVA/yIR6ybHjlP7aZtb8GVuPCkXJyVhmG
         6mkP/eAcaHRjx4+p2IyajZEaZu2dzuoumahUsyZetngYpCnb/yQ1ASDQZvkDJvFQ0z
         8Oq37bi9C+ww5J6gOW027kzi3qshh4b67HqJvXYRcSJ8eJg+vwrgdGiX8PAaEJTNye
         keRDaOkSDDJLI2w/OjKtwtJB+6d8nMYpCJS5jLVMVu00/hyjnn+7UIoZ+XdL//pXiA
         RS9JpCLl3Oyu/35kIAuxVaXq6A9fW/2DO45iJ7J+BT09nd1ZodRhqMqHvxAeLEmCbb
         7IjU8LgK1oCZg==
Message-ID: <7e2ee4f1-25d1-86db-7b8d-8785caef6c37@denx.de>
Date:   Sat, 26 Nov 2022 12:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] power: supply: bq25890: Add HiZ mode support
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20221109221504.79562-1-marex@denx.de>
 <20221109221504.79562-2-marex@denx.de>
 <ffd849db-fdb5-8578-85c2-74a8e030d86a@redhat.com>
 <1cde6f13-c131-332f-44f2-9a6a80b72330@redhat.com>
 <c0cc1774-8373-ec5d-29c7-5f7d056821b3@denx.de>
 <2ae29632-58e9-4ee5-3d59-397bff4932fc@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <2ae29632-58e9-4ee5-3d59-397bff4932fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/21/22 09:04, Hans de Goede wrote:
> Hi,

Hi,

> On 11/21/22 01:50, Marek Vasut wrote:
>> On 11/20/22 22:29, Hans de Goede wrote:
>>>
>>>
>>> On 11/19/22 14:52, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 11/9/22 23:15, Marek Vasut wrote:
>>>>> The bq25890 is capable of disconnecting itself from the external supply,
>>>>> in which case the system is supplied only from the battery. This can be
>>>>> useful e.g. to test the pure battery operation, or draw no power from
>>>>> USB port.
>>>>>
>>>>> Implement support for this mode, which can be toggled by writing 0 or
>>>>> non-zero to sysfs 'online' attribute, to select either offline or online
>>>>> mode.
>>>>>
>>>>> The IRQ handler has to be triggered to update chip state, as switching
>>>>> to and from HiZ mode does not generate an interrupt automatically.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>> ---
>>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>>> Cc: Sebastian Reichel <sre@kernel.org>
>>>>
>>>> Thanks, patch looks good to me:
>>>>
>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>> Also your timing is excellent :)  As a hobby project I'm working
>>>> on a x86 Lenovo Android tablet which has 2 separate batteries and
>>>> each battery has its own bq25892 chip.
>>>>
>>>> This requires putting the secondary bq25892 in Hi-Z mode when
>>>> e.g. enabling the 5V USB/OTG boost regulator on the primary
>>>> bq25892 to make the micro-usb output 5V.
>>>>
>>>> Which is functionality which I can nicely build on top of this
>>>> series.
>>>
>>> So one thing which I noticed while working on my own stuff
>>> on top of this, is that the charger IC resets (disables) Hi-Z
>>> mode when its internal PG (power-good) signal goes from false
>>> to true.
>>>
>>> The Android kernel fork for the tablet I'm working on detects
>>> the PG false -> true transition in its IRQ handler and then
>>> re-enabled Hi-Z mode if it was requested.
>>>
>>> I wonder if we should do something similar: remember the last
>>> value written to /sys/class/power_supply/bq2589o-charger/online
>>> and then in the IRQ handler if Hi-Z mode was requested re-enable
>>> Hi-Z mode ?
>>
>> Uhhhhh, that sounds like the HiZ mode is unreliable .
> 
> I think it is working as designed (although this is not documented)
> the charger is designed to be able to operate autonomously, so it
> makes sense to clear Hi-Z mode when a charger is unplugged + re-plugged.

That does make sense, although I would've liked a bit which would set 
HiZ mode and ignore the charger replug, so the chip would guarantee no 
power draw from the charger until such bit is cleared.

>> Of course, there seems to be no way to completely inhibit the PG detection, is there ?
> 
> not that I have been able to find.
> 
>> I wonder whether we should support this kind of workaround at all ?
> 
> You mean Hi-z mode itself? That is definitely useful to have, necessary
> actually for the tablet I'm working on in my spare time now.

Yes, the HiZ mode itself, since it cannot be made persistent and resets 
itself on replug.

> Or do you mean the Android workaround to re-enable Hi-Z mode in the IRQ
> handler ?

I mean, either
- we drop the HiZ mode support completely
or
- we add HiZ mode + persistency workaround

I don't like the second option, but if you need it and we have no better 
options ... hum ...

[...]
