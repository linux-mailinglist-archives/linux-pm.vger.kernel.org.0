Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D366396EC
	for <lists+linux-pm@lfdr.de>; Sat, 26 Nov 2022 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiKZPvg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Nov 2022 10:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZPvf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2022 10:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA5413F94
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2022 07:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669477840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPlcjPRtHYSf+iUTTIYCWcK/Bop420GNcnwCF7qxZzs=;
        b=VGHI6oiTtA3GoFYGHR+Ili7KAA47rn34dVa5SVDXlQifj5Ka9BA80YmSP4oMGoyC1llYuo
        51chX9PdgwqccYEIHUBcJGRKdKNgt+GYzhpzbMPFO5fvusUcV6F8d7UyWPX1PZxdpiGScG
        97ZD6BS+IxLcTQCULB9h5tp/U4hSNjo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-Gd86kfd0NcWdn8a5BUniyA-1; Sat, 26 Nov 2022 10:50:39 -0500
X-MC-Unique: Gd86kfd0NcWdn8a5BUniyA-1
Received: by mail-ej1-f72.google.com with SMTP id qf25-20020a1709077f1900b0078c02a23da3so2862951ejc.0
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2022 07:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPlcjPRtHYSf+iUTTIYCWcK/Bop420GNcnwCF7qxZzs=;
        b=C5dbTcEKAOpj816Yiq+m1ND+CbvN2HfrBuuNXtvaZpXKduXuq74ZlhIrxqBi5QhpCn
         qLBkkknD23+3hYXQ+z5BYeYT0M4WzB3Cc8N4oyo6CkrQ5kOY2pFYOvK89tTEIOeM/dow
         Oh6kke35zXjdBJjtRtV4zsi6qApV+32Eae7b4Gt+400667ylhE9VZSkmN8JlEx0Hduc2
         BlqWRF0/w5URatKOUv+r232mrDJirYOSu0LNiZ2p1LYoiwuYA7X1DTGTbp9CIJBYwlHY
         ymbkK2rN6Ze95digG0UsEOfGER16/EAdEt2D+uZGJ74l4JYBz2XfO2YurSIMBqSyxSLD
         Gcww==
X-Gm-Message-State: ANoB5plWkvq6BH1xbGQ7vMqMIR59O9rnE1wtmi3+xxbNsscJCZJHd49U
        X0H86xgmTAebR6FKPgNa+4U6dJWW7OuJuGHfli8ipPDQTLN/GjbjOX3qWXBgG/W/DBxhparQbJ2
        Q+/dhPiQKsdz4uqrWDcA=
X-Received: by 2002:a17:907:d40e:b0:7bb:f10c:9282 with SMTP id vi14-20020a170907d40e00b007bbf10c9282mr9644799ejc.325.1669477837801;
        Sat, 26 Nov 2022 07:50:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ZJEY9Ex7FUdubS/5t303RufiJwbG5+27V/U5YKSW9TXR24hG9wE/A8ahQBD5S4eDGq7DK7A==
X-Received: by 2002:a17:907:d40e:b0:7bb:f10c:9282 with SMTP id vi14-20020a170907d40e00b007bbf10c9282mr9644793ejc.325.1669477837574;
        Sat, 26 Nov 2022 07:50:37 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id cx27-20020a05640222bb00b0045d74aa401fsm3103856edb.60.2022.11.26.07.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 07:50:37 -0800 (PST)
Message-ID: <34f1010f-3f6d-b243-ad56-043ab3a7ed04@redhat.com>
Date:   Sat, 26 Nov 2022 16:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] power: supply: bq25890: Add HiZ mode support
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
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
 <96e20bf6-c5c0-fcce-901d-fd0a292aaf0b@denx.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <96e20bf6-c5c0-fcce-901d-fd0a292aaf0b@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/26/22 16:15, Marek Vasut wrote:
> On 11/26/22 16:03, Hans de Goede wrote:
>> Hi Marek,
> 
> Hi,
> 
>> On 11/26/22 12:06, Marek Vasut wrote:
>>> On 11/21/22 09:04, Hans de Goede wrote:
>>>> Hi,
>>>
>>> Hi,
>>>
>>>> On 11/21/22 01:50, Marek Vasut wrote:
>>>>> On 11/20/22 22:29, Hans de Goede wrote:
>>>>>>
>>>>>>
>>>>>> On 11/19/22 14:52, Hans de Goede wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 11/9/22 23:15, Marek Vasut wrote:
>>>>>>>> The bq25890 is capable of disconnecting itself from the external supply,
>>>>>>>> in which case the system is supplied only from the battery. This can be
>>>>>>>> useful e.g. to test the pure battery operation, or draw no power from
>>>>>>>> USB port.
>>>>>>>>
>>>>>>>> Implement support for this mode, which can be toggled by writing 0 or
>>>>>>>> non-zero to sysfs 'online' attribute, to select either offline or online
>>>>>>>> mode.
>>>>>>>>
>>>>>>>> The IRQ handler has to be triggered to update chip state, as switching
>>>>>>>> to and from HiZ mode does not generate an interrupt automatically.
>>>>>>>>
>>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>>>> ---
>>>>>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>>>>>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>>>>>> Cc: Sebastian Reichel <sre@kernel.org>
>>>>>>>
>>>>>>> Thanks, patch looks good to me:
>>>>>>>
>>>>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>>
>>>>>>> Also your timing is excellent :)  As a hobby project I'm working
>>>>>>> on a x86 Lenovo Android tablet which has 2 separate batteries and
>>>>>>> each battery has its own bq25892 chip.
>>>>>>>
>>>>>>> This requires putting the secondary bq25892 in Hi-Z mode when
>>>>>>> e.g. enabling the 5V USB/OTG boost regulator on the primary
>>>>>>> bq25892 to make the micro-usb output 5V.
>>>>>>>
>>>>>>> Which is functionality which I can nicely build on top of this
>>>>>>> series.
>>>>>>
>>>>>> So one thing which I noticed while working on my own stuff
>>>>>> on top of this, is that the charger IC resets (disables) Hi-Z
>>>>>> mode when its internal PG (power-good) signal goes from false
>>>>>> to true.
>>>>>>
>>>>>> The Android kernel fork for the tablet I'm working on detects
>>>>>> the PG false -> true transition in its IRQ handler and then
>>>>>> re-enabled Hi-Z mode if it was requested.
>>>>>>
>>>>>> I wonder if we should do something similar: remember the last
>>>>>> value written to /sys/class/power_supply/bq2589o-charger/online
>>>>>> and then in the IRQ handler if Hi-Z mode was requested re-enable
>>>>>> Hi-Z mode ?
>>>>>
>>>>> Uhhhhh, that sounds like the HiZ mode is unreliable .
>>>>
>>>> I think it is working as designed (although this is not documented)
>>>> the charger is designed to be able to operate autonomously, so it
>>>> makes sense to clear Hi-Z mode when a charger is unplugged + re-plugged.
>>>
>>> That does make sense, although I would've liked a bit which would set HiZ mode and ignore the charger replug, so the chip would guarantee no power draw from the charger until such bit is cleared.
>>
>> Well the re-enable Hi-Z mode on IRQ workaround you implemented gives
>> this behavior. While also ensuring that if the device dies because
>> of an empty battery it can still be recharged (since then the IRQ
>> handler won't run).
>>
>>>>> Of course, there seems to be no way to completely inhibit the PG detection, is there ?
>>>>
>>>> not that I have been able to find.
>>>>
>>>>> I wonder whether we should support this kind of workaround at all ?
>>>>
>>>> You mean Hi-z mode itself? That is definitely useful to have, necessary
>>>> actually for the tablet I'm working on in my spare time now.
>>>
>>> Yes, the HiZ mode itself, since it cannot be made persistent and resets itself on replug.
>>>
>>>> Or do you mean the Android workaround to re-enable Hi-Z mode in the IRQ
>>>> handler ?
>>>
>>> I mean, either
>>> - we drop the HiZ mode support completely
>>> or
>>> - we add HiZ mode + persistency workaround
>>>
>>> I don't like the second option, but if you need it and we have no better options ... hum ...
>>
>> I see that you have posted a v2 adding the workaround, thank you.
>>
>> Note that in the mean time I did find a way to make things work
>> without the workaround:
>>
>> 1. Set current limit of Vboost output of main charger high enough
>> that both the external usb device can use 500mA + the secondary
>> charger can charge the secondary battery (from the main battery)
>> with 500 mA
>>
>> 2. Sleep 300 ms for the situation to stabilize
>>
>> 3. Set Hi-Z mode on secondary charger so that it stops charging
>> from the main battery.
>>
>> I just finished running a whole bunch of tests with this setup and
>> it works well.
>>
>> I do like the v2 of your patches better because that really guarantees
>> the second charger is "offline" when we want it to be offline and allows
>> me to put it in Hi-Z mode before enabling the 5v boost output on the
>> main charger instead of letting the secondary battery briefly charge
>> from the main battery. It also allows me to remove a struct delayed_Work
>> which I added for the 300ms delay ...
> 
> Pardon my ignorance here, but doesn't that implementation above work only in case you have two chargers ? Note that in my case, I have one charger and one battery.

Right the workaround above is specifically for the tablet with
2 chargers which I'm working on. Iy is not a generic fix/WA for
the auto-reset of Hi-Z mode issue.

>> Can you please let me know if you want to move forward with your v2,
>> or since that version is not strictly necessary if you would prefer
>> to rollback to v1 ?
> 
> If we want to have HiZ mode support upstream, we might as well keep the workaround to retain the HiZ mode across replugs. So let's move forward with v2 ?

Ack, sounds good to me, thanks.

>> Then I can adjust my patches accordingly before posting them
>>
>> I was pretty much about to post them just now :)
> 
> Sorry about the delay this week.

No problem and thank you for your work on this.

Regards,

Hans


> 

