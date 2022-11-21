Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D542631AEF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Nov 2022 09:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKUIFf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 03:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKUIFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 03:05:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BCC20F5E
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 00:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669017873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YGOF7GQAXN3aJbn8jn2NVbd+hFF/RuYzE0Amj271TY=;
        b=hJeMlu8nNeDznmLseCPK/yPrY0O7IMU7joE6NBHy+OEMFtavse1d2m3+aIVu7LBIuU0yJb
        fTncJUHhlAvojA6oOSG9Rbav56iFJRWihPzQvNmn+Uyfamu6aO7V/t36zg5h2vBVO1406r
        nRJNujxx478kmx/gf5rOxIEVTQA0fRw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-tYnUGwPFPHWXSTDJhYHO-Q-1; Mon, 21 Nov 2022 03:04:29 -0500
X-MC-Unique: tYnUGwPFPHWXSTDJhYHO-Q-1
Received: by mail-ej1-f72.google.com with SMTP id oz34-20020a1709077da200b007adc8d68e90so6115084ejc.11
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 00:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YGOF7GQAXN3aJbn8jn2NVbd+hFF/RuYzE0Amj271TY=;
        b=rL4KprhaF/Ga55jSYaqhIFKxwHo3bShyL+vQFetV6XOmvB3kCVZ19V+XtqU8XfVPwA
         7Y3UGDOfekUMg/qw6irMOFfaYtWhBNj9LALl6ReVPb0tjFXuIg9O6g2dU7iJE9V/dXu7
         igkhBUVdPd1tfQi+To4+VByV8xJu/xhGHbTniIAZk1rICzL7WIyTNDkL2pWIOTrUqD29
         bKht/me8LpbfZgpR34H2gDkHLqKI44CBi5kCRdoYQNCWsLiFGOeh9Z/Xbnu2+hdSAx48
         EXIutlezMjfcXryKcNEyeYfcqKbTAmKP182ClTCGUKfFrVNG9CF7oocDZFZsLoazxBxQ
         cZSg==
X-Gm-Message-State: ANoB5plLtmNDR/y4ZhhMxB/h+Nw1p8M8nj/rzQrOB5bibID4nUDaJugd
        YXgVa0/VuP6smJEZ09xm6M+fT9UA5oDySmcra2Owf3I3bEqZiCuRiTqeRwjV6K5QR4AgkU5FhAT
        CyUkzAfSIS2ceqI5gWJI=
X-Received: by 2002:a05:6402:528f:b0:461:9cbd:8fba with SMTP id en15-20020a056402528f00b004619cbd8fbamr963611edb.19.1669017868563;
        Mon, 21 Nov 2022 00:04:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Hf/b6wCLi3P9kt6qb4myqp9CrLlBTUp+aEl0sByPyWL1fI6b9pjmjCmu44IKgHz/1hlUzUQ==
X-Received: by 2002:a05:6402:528f:b0:461:9cbd:8fba with SMTP id en15-20020a056402528f00b004619cbd8fbamr963592edb.19.1669017868340;
        Mon, 21 Nov 2022 00:04:28 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kz10-20020a17090777ca00b007933047f923sm4741438ejc.118.2022.11.21.00.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:04:27 -0800 (PST)
Message-ID: <2ae29632-58e9-4ee5-3d59-397bff4932fc@redhat.com>
Date:   Mon, 21 Nov 2022 09:04:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] power: supply: bq25890: Add HiZ mode support
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20221109221504.79562-1-marex@denx.de>
 <20221109221504.79562-2-marex@denx.de>
 <ffd849db-fdb5-8578-85c2-74a8e030d86a@redhat.com>
 <1cde6f13-c131-332f-44f2-9a6a80b72330@redhat.com>
 <c0cc1774-8373-ec5d-29c7-5f7d056821b3@denx.de>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c0cc1774-8373-ec5d-29c7-5f7d056821b3@denx.de>
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

On 11/21/22 01:50, Marek Vasut wrote:
> On 11/20/22 22:29, Hans de Goede wrote:
>>
>>
>> On 11/19/22 14:52, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 11/9/22 23:15, Marek Vasut wrote:
>>>> The bq25890 is capable of disconnecting itself from the external supply,
>>>> in which case the system is supplied only from the battery. This can be
>>>> useful e.g. to test the pure battery operation, or draw no power from
>>>> USB port.
>>>>
>>>> Implement support for this mode, which can be toggled by writing 0 or
>>>> non-zero to sysfs 'online' attribute, to select either offline or online
>>>> mode.
>>>>
>>>> The IRQ handler has to be triggered to update chip state, as switching
>>>> to and from HiZ mode does not generate an interrupt automatically.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>> Cc: Sebastian Reichel <sre@kernel.org>
>>>
>>> Thanks, patch looks good to me:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Also your timing is excellent :)  As a hobby project I'm working
>>> on a x86 Lenovo Android tablet which has 2 separate batteries and
>>> each battery has its own bq25892 chip.
>>>
>>> This requires putting the secondary bq25892 in Hi-Z mode when
>>> e.g. enabling the 5V USB/OTG boost regulator on the primary
>>> bq25892 to make the micro-usb output 5V.
>>>
>>> Which is functionality which I can nicely build on top of this
>>> series.
>>
>> So one thing which I noticed while working on my own stuff
>> on top of this, is that the charger IC resets (disables) Hi-Z
>> mode when its internal PG (power-good) signal goes from false
>> to true.
>>
>> The Android kernel fork for the tablet I'm working on detects
>> the PG false -> true transition in its IRQ handler and then
>> re-enabled Hi-Z mode if it was requested.
>>
>> I wonder if we should do something similar: remember the last
>> value written to /sys/class/power_supply/bq2589o-charger/online
>> and then in the IRQ handler if Hi-Z mode was requested re-enable
>> Hi-Z mode ?
> 
> Uhhhhh, that sounds like the HiZ mode is unreliable .

I think it is working as designed (although this is not documented)
the charger is designed to be able to operate autonomously, so it
makes sense to clear Hi-Z mode when a charger is unplugged + re-plugged.

> Of course, there seems to be no way to completely inhibit the PG detection, is there ?

not that I have been able to find.

> I wonder whether we should support this kind of workaround at all ?

You mean Hi-z mode itself? That is definitely useful to have, necessary
actually for the tablet I'm working on in my spare time now.

Or do you mean the Android workaround to re-enable Hi-Z mode in the IRQ
handler ?

Regards,

Hans

