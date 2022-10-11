Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080695FB852
	for <lists+linux-pm@lfdr.de>; Tue, 11 Oct 2022 18:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJKQf4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Oct 2022 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKQfu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2022 12:35:50 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA64A02DD
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 09:35:43 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6357284D8C;
        Tue, 11 Oct 2022 18:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665506141;
        bh=5e86cqFQtLamT+0YjJnWVc3JlOpU1ixZgJCuhC+5wp4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ybF+pLILf97sldSd+9YA7/uWgSkhjOkRzMgwACbFS6TuAr9kE8Sz9h2vK4HLpFakL
         cslxAxtC+/ttfP6zZ1vjVV0TuCq1AGKwSB7XMvfkKlsRoHPiahHKSCs3i0j16SDFDa
         RazaiqGrWowgJ9gS/TZyx4r7VL8ZiQ6LtRe2BANUCEtTIHGqN33EkxFcv9CHUDrmHh
         bzxw4lEaauQjUeRGsxarjtWZ21jWmp1Grh0LzZC6V+8dQMWWaMGUonotunZvJZJr7u
         RHA1heaVrDTB0HeFcVRcDawAFb0DJzncmSTkN0DcktZTHeRLhwYTjE/tnI3+/5bMLx
         pFb0s5n5UdVHA==
Message-ID: <0519057c-82f7-d7b7-af11-5137bfce3eca@denx.de>
Date:   Tue, 11 Oct 2022 18:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] power: supply: bq25890: Add CC voltage to ADC
 properties
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221009191839.102686-1-marex@denx.de>
 <Y0NUbeUae01t+UGa@qmqm.qmqm.pl>
 <dde63fea-04eb-c438-27d3-fe6ff5c174bc@redhat.com>
 <c528ae92-26bd-e6a9-a406-93a077d2fab7@denx.de>
 <e26abfe6-850a-32e5-fa2e-5dd633c72a62@redhat.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <e26abfe6-850a-32e5-fa2e-5dd633c72a62@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/11/22 09:38, Hans de Goede wrote:
> Hi,

Hi,

>>>> Though I think there is no proper property
>>>> for the VSYS value that is currently occupying VOLTAGE_NOW - this
>>>> might be better modelled as a separate regulator maybe?
>>>
>>> Ack, see above.
>>
>> We already do have a regulator in the bq25890 driver. The regulator is used as a switch to toggle OTG boost mode (supply from battery to VBUS), but I don't see any users of this functionality, and I cannot imagine how this would be modeled in DT. (Hans, can you clarify?)
> 
> Ah, with the Ack I meant ack for the "I think there is no proper property for the VSYS value" I did not meant to ack the regulator bit, I don't directly see how having registering a regulator device for Vsys would be useful, sorry. As mentioned in my original email I believe that just adding a new property for Vsys makes the most sense.

I disagree here, have a look at the new series I posted that adds the 
Vsys regulator, esp. patch 7/7 . I think the Vsys regulator does make 
sense, since it can be the supply for PMIC, which would let us model 
that hardware connection between the charger and PMIC properly, and even 
in DT.

> Note the OTG regulator is useful to enable/disable 5V boost output when used with e.g. a micro-usb connector and that micro-usb connector is used with an micro-USB OTG host-mode cable / dongle.
> 
>> There is the usb_work (usb_register_notifier()) which triggers workqueue which does the same, toggles OTG boost mode, but this is only used in case a valid USB PHY is found. I didn't find any users of this either.
> 
> This is used, but the use is hidden away pretty well I admit. Some X86 tablets from the Cherry Trail era have ACPI tables where the charging / fuel-gauge ICs are not handled in ACPI (as they typically are on x86) so we need to do it ourselves.
> 
> Specifically the charger IC is connected to a special I2c bus of the PMIC (which itself is an i2c-device so we have an i2c-attached i2c-controller, crazy ...) the driver for this special PMIC embedded i2c-controller is also responsible for instantiating the charger chip i2c-client and this setup uses the OTG regulator device, see: drivers/i2c/busses/i2c-cht-wc.c specifically these bits:

[...]

> And then the drivers/extcon/extcon-intel-cht-wc.c uses
> the vbus regulator to control the 5V out on the micro-USB.

Uh, now I understand, thanks for clarification.

> (also note these devices do not instantiate a usb_phy device anywhere, which is why the V5 boost is handled through the regulator framework)
> 
> TL;DR: the regulator device for the V5 boost output is used, please don't remove it :)

I won't, I only extended the current regulator registration in the end.

>> Anyway, maybe we can extend the regulator to report VBus and register another one to report VSys, where the VSys one can be plugged e.g. as supply for PMIC in DT ?
> 
> I'm not sure if a regulator device for Vsys is really useful, AFAIK Vsys can not be turned off, nor can the voltage level be controlled...

It can be used as a supply for system PMIC, so I think it is actually 
useful. Sure, you cannot turn the Vsys on/off, but that's not the sole 
purpose of the regulator. The PMIC can get its input voltage and 
configure itself accordingly, which without the Vsys regulator providing 
its current voltage is not possible.
