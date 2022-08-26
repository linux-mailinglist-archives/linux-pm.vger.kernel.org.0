Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2BA5A2768
	for <lists+linux-pm@lfdr.de>; Fri, 26 Aug 2022 14:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiHZMHl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 08:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiHZMHk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 08:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BA5DCFEF
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 05:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661515658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9/CwmDtq1Of3AfWB1nTEpdK5mjodhqUPd+kCfaJyaI=;
        b=iZoXNDEJSdqB0fry7eUVkKkeSEDTRpf3KsgfpeLK4h7nRiZ5lTlBFHItO0HKgeJYzikSbk
        VRARj89ymAP/+HFiEWffQXGGDK7Nght7qICurSOGf/M5edKhdO5lPGlOM8lnn1URIZVBCT
        t99/0St8q7SbxgykO20zb4OpujwQPdc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-374-RGeBB0ScOxeI_8FPOfMnkA-1; Fri, 26 Aug 2022 08:07:37 -0400
X-MC-Unique: RGeBB0ScOxeI_8FPOfMnkA-1
Received: by mail-ej1-f70.google.com with SMTP id qf15-20020a1709077f0f00b0073d6dfb7556so533495ejc.12
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 05:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=e9/CwmDtq1Of3AfWB1nTEpdK5mjodhqUPd+kCfaJyaI=;
        b=yF+R24ZHlbPwrTFIY1Zzfbd5nUHU1lxcIPvQFod98Q1GL5gLAA1ZBE/3CeGNXJe+p/
         sLIy5OJ9oxGA/m5iPWfvY/FpMxctNAokaN2TD+l78OU0vXwwYpfl87P6VOKfimPxaPFK
         l8Apn5pnSLpQ0s1dzk1SHIYABPgEIWYLuXxWzy3h9ug5hehM5Hv+g0Kqxo3tXCrcvW7h
         NcUMOY0GY1WOVtBhE4mBUZyhCoWbeUqUkqHK+8/pfQ85D1wsQZhmEJhzD8wAHMM3HTm0
         035UbxuR0YQnxXJ92hd59Ucn7QoM+2si4zt6+h16GAdmTxz+xEtmKEiDGskSK/knVhol
         ZYDg==
X-Gm-Message-State: ACgBeo1md+f4OsstCYEGubthKgUc/g3eikNS9CN4exYHSF3MoKoHuTw/
        DOcoIPKtaIeYF8YDQEFUXFBaqGWP7GJeZRizwUt2/KQNnHelZbyHdxhiGZQnc7UXHjDfjvU3afB
        JxYpmu+7VkMKv/7na0Xc=
X-Received: by 2002:a05:6402:2802:b0:43a:9098:55a0 with SMTP id h2-20020a056402280200b0043a909855a0mr6584414ede.179.1661515656271;
        Fri, 26 Aug 2022 05:07:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5lDRxiLgcEVMZBTG6n3QzcW6euXrZRrakgpSuixzcJ6IKONcJmEHt1wuI8kIJ+4/xuEUzw5Q==
X-Received: by 2002:a05:6402:2802:b0:43a:9098:55a0 with SMTP id h2-20020a056402280200b0043a909855a0mr6584401ede.179.1661515655979;
        Fri, 26 Aug 2022 05:07:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ky11-20020a170907778b00b0072abb95eaa4sm800435ejc.215.2022.08.26.05.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 05:07:35 -0700 (PDT)
Message-ID: <123960a4-7a38-234b-24ca-dfe3655e32de@redhat.com>
Date:   Fri, 26 Aug 2022 14:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/2] [RFC] platform/x86: Fixes for Toshiba Z830
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc:     Azael Avalos <coproscefalo@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220821200821.1837460-1-lkml@vorpal.se>
 <2ddade8b-7260-8497-12f2-c8b13cf35e6a@redhat.com>
 <12a39cf6-1247-d2a3-bf07-51297e9b6640@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <12a39cf6-1247-d2a3-bf07-51297e9b6640@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/24/22 14:31, Arvid Norlander wrote:
> On 2022-08-22 13:39, Hans de Goede wrote:

<snip>

>> For 2. you can actually just copy and paste a lot of this email,
>> I believe that having the info in this email in a
>> Documentation/admin-guide/laptops/toshiba_acpi.rst file
>> will make it a lot easier to find in the future then only having
>> it in the mailinglist archives.
>>
>>> * For the hardware buttons I describe below, is a solution specific to
>>>   toshiba_acpi preferred, or should additional effort be spent on
>>>   investigating a generic solution?
>>
>> Ok, this is interesting there actually is a specification from
>> Microsoft for this:
>> http://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/dirapplaunch.docx
>>
>> And there was a previous attempt to add support for the PNP0C32 devices:
>> https://marc.info/?l=linux-acpi&m=120550727131007
>> https://lkml.org/lkml/2010/5/28/327
>>
>> And this even made it into drivers/staging for a while, if you do:
>> git revert 0be013e3dc2ee79ffab8a438bbb4e216837e3d52
>> you will get a: drivers/staging/quickstart/quickstart.c file.
>>
>> Note this is not great code:
>>
>> 1. If you do:
>>   ls /sys/bus/platform/devices
>>   You should already see a couple of PNP0C32 platform devices there and the
>>   driver should simply bind to those rather then creating its own platform device
>> 2. As mentioned this really should use the standard /dev/input/event interface
>>   for event reporting and allow userspace to change the scancode to EV_KEY*
>>   mapping. You can do this e.g. by using a sparse_keymap for the scancode to
>>   EV_KEY* mapping which will give you this for free.
> 
> I have yet to have time to look at it. However this seems to suggest that
> these buttons should work when the laptop is off. That is not the case on
> the Z830. They only do anything when the computer is on and I can't find
> any settings to change that.

Not necessarily fully off, but maybe when suspended ?

> Looking at the specification it also mentions several different
> notification codes for the button. The only one used on the Z830 is 0x80.
> That is, as far as I can tell from the decompilation of the DSDT.
> 
> Thus I worry I will not be able to test any sort of generic implementation
> very well, if the Z830 only implements a small subset of the functionality.

Right I understand still I think there should be a separate

drivers/platform/x86/acpi_pnp0c32_buttons.c 

driver for this IMHO. If it is only tested on your one model that
is fine (should be documented with a comment in the code though).

Then at least we have something to serve as a basis for if people
want to add support for this on more laptop models.

Does that sound reasonable ?

>>> Before I start coding on these more complex issues I would like advice in
>>> order to avoid wasting my time on bad designs. In particular, on how to
>>> proceed with the "Hardware buttons" section below.
>>
>> I believe that sending the magic command to make these keys generate events
>> should be part of toshiba_acpi, combined with a generic PNP0C32 driver
>> for actually reporting the key-presses.
> 
> I guess there is no way to figure out what the buttons are supposed to mean in
> this case, and we simply have to leave that to the user to map as they see fit
> (as long as the IDs are stable). I'm not sure how well that works with the event
> subsystem, as when I test evtest it seems to asign some sort of labels to the
> events (e.g. KEY_SLEEP, KEY_BLUETOOTH, ...).

Ack.

<snip>

>>> 4. Battery charge mode [implemented in patch 2]
>>> ======================
>>>
>>> This laptop supports not charging the battery fully in order to prolong
>>> battery life. Unlike for example ThinkPads where this control is granular
>>> here it is just off/on. When off it charges to 100%. When on it charges to
>>> about 80%.
>>>
>>> According to the Windows program used to control the feature the setting
>>> will not take effect until the battery has been discharged to around 50%.
>>> However, in my testing it takes effect as soon as the charge drops below
>>> 80%. On Windows Toshiba branded this feature as "Eco charging"
>>>
>>> In the following example ACPI calls I will use the following newly defined
>>> constants:
>>> #define HCI_BATTERY_CHARGE_MODE 0xba
>>> #define BATTERY_CHARGE_FULL 0
>>> #define BATTERY_CHARGE_80_PERCENT 1
>>>
>>> To set the feature:
>>>   {HCI_SET, HCI_BATTERY_CHARGE_MODE, charge_mode, 0, 0, 0}
>>> To query for the existence of the feature:
>>>   {HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 0}
>>> To read the feature:
>>>   {HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 1}
>>>
>>> The read may need to be retried if TOS_DATA_NOT_AVAILABLE is returned as
>>> the status code. This rarely happens (I have never observed it on Linux),
>>> but I have seen it happen under Windows once, and the software did retry
>>> it.
>>
>> Hmm, this is interesting if you look at:
>>
>> Documentation/ABI/testing/sysfs-class-power
>>
>> You will see there already is a standard API for this in the form of
>> adding a "charge_control_end_threshold" attribute to the standard
>> ACPI /sys/class/power_supply/BAT*/ sysfs interface. See e.g.
>> drivers/platform/x86/thinkpad_acpi.c
>>
>> For an example of how to add sysfs attributes to a battery
>> which is managed by the standard drivers/acpi/battery.c driver.
>>
>> I think you can use this standard attribute enabling eco charging
>> for any writes with a value <= 90 and disabling it for values
>>> 90 (90 being halfway between 80 and 100).
>>
>> While always showing 80 or 100 on read.
>>
>> You should then also write a patch for:
>>
>> Documentation/ABI/testing/sysfs-class-power
>>
>> Adding something like this to the "charge_control_end_threshold"
>> section:
>>
>> "not all hardware is capable of setting this to an arbitrary
>> percentage. Drivers will round written values to the nearest
>> supported value. Reading back the value will show the actual
>> threshold set by the driver."
>>
>> (feel free to copy verbatim, but maybe you can do better)
>>
>>
> 
> This makes perfect sense, but I don't know if it is guaranteed to be 80%
> on all Toshiba laptops. Do you know of any other Toshiba laptops that
> have/had this feature, and if so, what the limits are? The Windows driver
> for this laptop does not document exactly what the limit is. 80% is simply
> what I have observed in practice.

Right, the idea is to document that the hw/fw/driver may only
support some fixed values and that written values will be
rounded to one of the supported fixed values. There is no need
to document what those fixed values are.  The idea is that
userspace consumers will read back the value to see what
they actually got. 

Regards,

Hans

