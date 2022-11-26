Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3846396BA
	for <lists+linux-pm@lfdr.de>; Sat, 26 Nov 2022 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiKZPPU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Nov 2022 10:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKZPPT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2022 10:15:19 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE117891
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2022 07:15:17 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 18BD184FFF;
        Sat, 26 Nov 2022 16:15:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669475715;
        bh=Dn3HdETtt/jIo3dvJzD/VYbS7OhyQT9AfoWk8upD/NE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J2NTiKkGNRvF/hiPNRawyy6P2T2yHiazYYsKw4mCspgjXuhN4ywyqXpsWVsiDZNuA
         OPgXqdIhVtECIDS/kbq5nGJxG/TWfDRHWJB0G4JWy6oWr4NKkbRyXEZLQgH0WLQCNk
         0RUSqRDjiEJcDfIwYcpwbUQp9qokZT/iIbfyFoPyc77xE3ldAretWTwy0lzDQMdArs
         HQ16XnUq3cZutiGz6Ujq8v6Sq/n7n0uo6CkY4I794TMbftmS4tJUAaJXJAYJ/yrLPi
         ftCBXekPlS8/gCx4VrWaH+DM73OZE0ONBzs406IS+C5SBWmwtZYyPPSxo/qKaNxvqP
         Z8TgVJAJY3rcg==
Message-ID: <96e20bf6-c5c0-fcce-901d-fd0a292aaf0b@denx.de>
Date:   Sat, 26 Nov 2022 16:15:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] power: supply: bq25890: Add HiZ mode support
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20221109221504.79562-1-marex@denx.de>
 <20221109221504.79562-2-marex@denx.de>
 <ffd849db-fdb5-8578-85c2-74a8e030d86a@redhat.com>
 <1cde6f13-c131-332f-44f2-9a6a80b72330@redhat.com>
 <c0cc1774-8373-ec5d-29c7-5f7d056821b3@denx.de>
 <2ae29632-58e9-4ee5-3d59-397bff4932fc@redhat.com>
 <7e2ee4f1-25d1-86db-7b8d-8785caef6c37@denx.de>
 <28aec5ab-53fb-4295-3859-6ab29b1cb3dd@redhat.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <28aec5ab-53fb-4295-3859-6ab29b1cb3dd@redhat.com>
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

On 11/26/22 16:03, Hans de Goede wrote:
> Hi Marek,

Hi,

> On 11/26/22 12:06, Marek Vasut wrote:
>> On 11/21/22 09:04, Hans de Goede wrote:
>>> Hi,
>>
>> Hi,
>>
>>> On 11/21/22 01:50, Marek Vasut wrote:
>>>> On 11/20/22 22:29, Hans de Goede wrote:
>>>>>
>>>>>
>>>>> On 11/19/22 14:52, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 11/9/22 23:15, Marek Vasut wrote:
>>>>>>> The bq25890 is capable of disconnecting itself from the external supply,
>>>>>>> in which case the system is supplied only from the battery. This can be
>>>>>>> useful e.g. to test the pure battery operation, or draw no power from
>>>>>>> USB port.
>>>>>>>
>>>>>>> Implement support for this mode, which can be toggled by writing 0 or
>>>>>>> non-zero to sysfs 'online' attribute, to select either offline or online
>>>>>>> mode.
>>>>>>>
>>>>>>> The IRQ handler has to be triggered to update chip state, as switching
>>>>>>> to and from HiZ mode does not generate an interrupt automatically.
>>>>>>>
>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>>> ---
>>>>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>>>>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>>>>> Cc: Sebastian Reichel <sre@kernel.org>
>>>>>>
>>>>>> Thanks, patch looks good to me:
>>>>>>
>>>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>
>>>>>> Also your timing is excellent :)  As a hobby project I'm working
>>>>>> on a x86 Lenovo Android tablet which has 2 separate batteries and
>>>>>> each battery has its own bq25892 chip.
>>>>>>
>>>>>> This requires putting the secondary bq25892 in Hi-Z mode when
>>>>>> e.g. enabling the 5V USB/OTG boost regulator on the primary
>>>>>> bq25892 to make the micro-usb output 5V.
>>>>>>
>>>>>> Which is functionality which I can nicely build on top of this
>>>>>> series.
>>>>>
>>>>> So one thing which I noticed while working on my own stuff
>>>>> on top of this, is that the charger IC resets (disables) Hi-Z
>>>>> mode when its internal PG (power-good) signal goes from false
>>>>> to true.
>>>>>
>>>>> The Android kernel fork for the tablet I'm working on detects
>>>>> the PG false -> true transition in its IRQ handler and then
>>>>> re-enabled Hi-Z mode if it was requested.
>>>>>
>>>>> I wonder if we should do something similar: remember the last
>>>>> value written to /sys/class/power_supply/bq2589o-charger/online
>>>>> and then in the IRQ handler if Hi-Z mode was requested re-enable
>>>>> Hi-Z mode ?
>>>>
>>>> Uhhhhh, that sounds like the HiZ mode is unreliable .
>>>
>>> I think it is working as designed (although this is not documented)
>>> the charger is designed to be able to operate autonomously, so it
>>> makes sense to clear Hi-Z mode when a charger is unplugged + re-plugged.
>>
>> That does make sense, although I would've liked a bit which would set HiZ mode and ignore the charger replug, so the chip would guarantee no power draw from the charger until such bit is cleared.
> 
> Well the re-enable Hi-Z mode on IRQ workaround you implemented gives
> this behavior. While also ensuring that if the device dies because
> of an empty battery it can still be recharged (since then the IRQ
> handler won't run).
> 
>>>> Of course, there seems to be no way to completely inhibit the PG detection, is there ?
>>>
>>> not that I have been able to find.
>>>
>>>> I wonder whether we should support this kind of workaround at all ?
>>>
>>> You mean Hi-z mode itself? That is definitely useful to have, necessary
>>> actually for the tablet I'm working on in my spare time now.
>>
>> Yes, the HiZ mode itself, since it cannot be made persistent and resets itself on replug.
>>
>>> Or do you mean the Android workaround to re-enable Hi-Z mode in the IRQ
>>> handler ?
>>
>> I mean, either
>> - we drop the HiZ mode support completely
>> or
>> - we add HiZ mode + persistency workaround
>>
>> I don't like the second option, but if you need it and we have no better options ... hum ...
> 
> I see that you have posted a v2 adding the workaround, thank you.
> 
> Note that in the mean time I did find a way to make things work
> without the workaround:
> 
> 1. Set current limit of Vboost output of main charger high enough
> that both the external usb device can use 500mA + the secondary
> charger can charge the secondary battery (from the main battery)
> with 500 mA
> 
> 2. Sleep 300 ms for the situation to stabilize
> 
> 3. Set Hi-Z mode on secondary charger so that it stops charging
> from the main battery.
> 
> I just finished running a whole bunch of tests with this setup and
> it works well.
> 
> I do like the v2 of your patches better because that really guarantees
> the second charger is "offline" when we want it to be offline and allows
> me to put it in Hi-Z mode before enabling the 5v boost output on the
> main charger instead of letting the secondary battery briefly charge
> from the main battery. It also allows me to remove a struct delayed_Work
> which I added for the 300ms delay ...

Pardon my ignorance here, but doesn't that implementation above work 
only in case you have two chargers ? Note that in my case, I have one 
charger and one battery.

> Can you please let me know if you want to move forward with your v2,
> or since that version is not strictly necessary if you would prefer
> to rollback to v1 ?

If we want to have HiZ mode support upstream, we might as well keep the 
workaround to retain the HiZ mode across replugs. So let's move forward 
with v2 ?

> Then I can adjust my patches accordingly before posting them
> 
> I was pretty much about to post them just now :)

Sorry about the delay this week.
