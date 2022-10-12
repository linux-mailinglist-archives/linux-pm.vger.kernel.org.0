Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDF5FCE19
	for <lists+linux-pm@lfdr.de>; Thu, 13 Oct 2022 00:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJLWGr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 18:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJLWGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 18:06:22 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480CB127902
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 15:03:44 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 38B4B84966;
        Thu, 13 Oct 2022 00:02:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665612173;
        bh=dOy1D4939LqzeTTmi98CyZzfA9NtwxKwWlbqkRfn4aE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qJcYyaGpPzs5UptiPKV+aWvDJbXrw+sfZbF/iSI7sKz+TPGJcnSWilmlmu7gzqq2E
         rfBaUBTapxM+UcbPGfxzIoUSSBW+EvBH74HR5AHFvBEjW3X3abYxVFJjmAHzG+iMPc
         QJqrH0QtIOlUoC6llmDyUHvlLtjobRq0T4aR7ooGhocTB0/nlebNNMd3C7UWMsar06
         jAUgPT3WYBbYOVRxcUVBEky7JsMipIaH9EJhmllzRTIaMY+q7QtHEt565Byw5SQM2D
         5VpdxrMN30W7R8++lkNRnJ0FSfSVzVppt/Jvjz/JjcYaqtCl1hTU++GGUvxBPY1luD
         ZOiR+wSnsL7iQ==
Message-ID: <021a1dfc-eb05-77ad-644c-f967a5bf7799@denx.de>
Date:   Thu, 13 Oct 2022 00:02:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/7] power: supply: bq25890: Factor out regulator
 registration code
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-5-marex@denx.de>
 <e0659fb1-7e1e-de5c-de6a-99a8f180bd3f@redhat.com>
 <00e6b9b0-ddef-6e2f-0603-9a25fd3b9e0d@denx.de>
 <848ada38-00a1-0631-871f-926bb33a166f@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <848ada38-00a1-0631-871f-926bb33a166f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/12/22 12:10, Hans de Goede wrote:
> Hi Marek,

Hello Hans,

>>> On 10/10/22 23:03, Marek Vasut wrote:
>>>> Pull the regulator registration code into separate function, so it can
>>>> be extended to register more regulators later. Currently this is only
>>>> moving ifdeffery into one place and other preparatory changes. The
>>>> dev_err_probe() output string is changed to explicitly list vbus
>>>> regulator failure, so that once more regulators are registered, it
>>>> would be clear which one failed.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>
>>> First of all thank you for your work on this series. Based purely
>>> on reading the commit messages patches 1-4 sound good to me. I will
>>> do a more detailed review tomorrow.
>>>
>>> As for patch 5-7 thinking some more about adding a Vsys regulator
>>> just to report the Vsys reading feels wrong to me.
>>>
>>> A regulator device's voltage in sysfs is about the value the regulator
>>> is supposed to try and regulate its outputted voltage to, while here
>>> we are talking about an ADC reading of the actual outputted voltage.
>>>
>>> This really should *not* be modeled as a regulator if anything the
>>> hwmon interface would be applicable for this ADC reading and
>>> the power_supply core has support for exporting some of
>>> the psy info through hwmon now.
>>>
>>> So what should happen for Vsys IMHO is make it a new
>>> POWER_SUPPLY_PROP_SYSTEM_VOLTAGE property and while adding support
>>> for this new property to the power-supply core, also make the core's
>>> hwmon glue code export this in the registered hwmon device so that
>>> e.g. a sensors applet on the desktop can easily show it (*).
>>>
>>> Sorry for the confusion with my ack in the other thread which
>>> only meant to agree with a part of the alinea/sentence I put
>>> the ack under.
>>
>> I'm not sure that's all there is to the Vsys regulator, it would let us model the connection between the charger chip and PMIC, where the charger would be the supply and the PMIC the regulator consumer. If the PMIC can determine its input voltage, it might be able to configure itself to some more optimal mode of operation. With the Vsys regulator, the PMIC can determine its voltage. So I think the Vsys regulator would be useful in that scenario (that's how it is wired on my board btw.).
> 
> You are right that theoretically there is nothing wrong with
> the model of having the charger-IC's Vsys output being
> a perent regulator for the PMIC.
> 
> As for this being useful to actually have I have my doubts
> though. All the PMICs I know automatically select the
> optimal mode/parameters for their buck convertors based
> on the detected input voltage. So they basically always
> work optimally as long as the input voltage is within
> their supported range. So having Vsys moduled as
> a regulator is only theoretically useful which is not
> a good argument for adding this to the kernel in this
> way IMHO.

I would be careful with "All the PMICs" , not all of them are fully 
automatic, some are just broken or partly automatic. i.MX28 POWER unit 
and one of the Dialog 9062 I think come to mind.

I also think if we have a supplier (bq25890) -> consumer (pmic input) 
relationship in hardware between two chips, we should model it using 
regulators. This is the common approach on embedded systems, so I don't 
see why we shouldn't do it here the same way?

> I believe it is important to go back to the original
> problem / question which we are trying to solve / answer
> here, which is:
> 
> "what is the best way to make the readings from
> the Vsys ADC available to userspace?"

Actually, I don't particularly care about exposing Vsys to user space. 
We are already changing the ABI with these first four patches, and the 
Vsys is no longer reported with 1..4 applied, so shall we change the 
question to:
"
Do we care about making Vsys reading available to userspace at all ?
"

> Looking at standard Linux userspace (Debian/Fedora/etc.)
> all the userspace tools capable of reporting voltages
> of various voltage rails inside the system to the user
> use the hwmon interface for this. This is also why
> the power-supply class core recently got support for
> proxying some psy properties to a hwmon class device.
> 
> So the way I see it is that if we want to report Vsys to
> userspace, that we then clearly need to report it through
> the hwmon interface.

For regulators, you can read their values via /sys/class/regulators/* , 
if the user is interesting in Vsys .

Maybe that is where we disagree -- I'm not particularly interested in 
exposing Vsys to user space, but since it was exposed before, I tried to 
retain that exposure, although via different channel. And the regulator 
also makes the Vsys useful, since it can be used as a supply on the 
kernel level.

> And my previous proposal:
> 
> make it a new POWER_SUPPLY_PROP_SYSTEM_VOLTAGE property and while
> adding support for this new property to the power-supply core,
> also make the core's hwmon glue code export this in
> the registered hwmon device.
> 
> Still seems the best solution to me here.

[...]
