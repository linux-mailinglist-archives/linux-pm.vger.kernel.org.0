Return-Path: <linux-pm+bounces-9747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728E911F42
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 10:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB7328BBFC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175616D9A3;
	Fri, 21 Jun 2024 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QMWGJGCG"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29416D4CB;
	Fri, 21 Jun 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959761; cv=none; b=k2YGB4EjdZPT4uAKXLvgZcJlvY/lj1UDY6L6TPnwnYBeev8nTVqXDoqdSw/uUr53jtAbK6hwptO3YCq+FpGD9gsrjT3FEg1+YNkpwhIVqO45Uq9UYzCfjoofhZyGAUhsGl+SBDDIY1VGj87a9Yc4DVnK21jMZIzvg4K1dZUWGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959761; c=relaxed/simple;
	bh=8f6Gt/ccsHXbvPGmc0Nsw1hUGWPrG6A2wReAK1sxUOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8UJOnMnR/orQ3ZRWLeql7BPsSpm58maXEsEHBxYrwTHC5wcLDU8EOK+3XSCoaEZFA9IwZIXM2+16yefYWZRLktJXelKTmJETCuniL+F3V3SvF8zlX8GzPftdYZSnZxU41dcFxO0ZgdENkgWnAV1rnzYczQAZhgOTZ2w1ns6cF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QMWGJGCG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-144-210.elisa-laajakaista.fi [91.158.144.210])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D1B08524;
	Fri, 21 Jun 2024 10:48:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718959734;
	bh=8f6Gt/ccsHXbvPGmc0Nsw1hUGWPrG6A2wReAK1sxUOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QMWGJGCGCqNae83SUzTD9qt5qsLgrbBdcJoVG9DwdEatTzkyifzCIk8qK2dpQDdh+
	 EON/CZm7wOeMMooTN5UQKsZ+fgg9ICOzmIiusz5NibvCu0WBQPOoz2tUhJU+QGL+3I
	 93yneWJqtphF26uLaf1sY6SATPNTQ8ufVICRjOUM=
Message-ID: <269b5ca8-8cff-4ff1-b627-f262b190fc80@ideasonboard.com>
Date: Fri, 21 Jun 2024 11:49:10 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 0/3] pmdomain: renesas: rmobile-sysc: Remove serial
 console handling
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Saravana Kannan <saravanak@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Devarsh Thakkar <devarsht@ti.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <cover.1716811405.git.geert+renesas@glider.be>
 <CAPDyKFpa4LZF3eN7x-NT+b9=dKB3Oe6RY8RAyetdRBSR1-LQoQ@mail.gmail.com>
 <0a025885-ed95-45d3-bf76-d2a043baaed7@ideasonboard.com>
 <CAPDyKFrxUDhnUUfz5wHpGVQfNYssxoWO5Eb2wtmZMTcMYhEjxQ@mail.gmail.com>
 <1bda8e8f-10df-4a10-a217-26cf50ef3577@ideasonboard.com>
 <CAGETcx-T54w=x=gv524dUJtnRGmOiXFA2CRYHE5Pawbux8_Tig@mail.gmail.com>
 <CAMuHMdUTGLSDv-zAun7tV2VnN0q08PibBT9B-MhxqdwmRTA_UQ@mail.gmail.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <CAMuHMdUTGLSDv-zAun7tV2VnN0q08PibBT9B-MhxqdwmRTA_UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/06/2024 10:07, Geert Uytterhoeven wrote:
> Hi Saravana,
> 
> On Fri, Jun 21, 2024 at 3:08 AM Saravana Kannan <saravanak@google.com> wrote:
>> On Wed, Jun 5, 2024 at 4:16 AM Tomi Valkeinen
>> <tomi.valkeinen@ideasonboard.com> wrote:
>>> On 05/06/2024 13:53, Ulf Hansson wrote:
>>>> On Wed, 5 Jun 2024 at 12:41, Tomi Valkeinen
>>>> <tomi.valkeinen@ideasonboard.com> wrote:
>>>>> On 05/06/2024 12:34, Ulf Hansson wrote:
>>>>>> On Mon, 27 May 2024 at 14:41, Geert Uytterhoeven
>>>>>> <geert+renesas@glider.be> wrote:
>>>>>>> Since commit a47cf07f60dcb02d ("serial: core: Call
>>>>>>> device_set_awake_path() for console port"), the serial driver properly
>>>>>>> handles the case where the serial console is part of the awake path, and
>>>>>>> it looked like we could start removing special serial console handling
>>>>>>> from PM Domain drivers like the R-Mobile SYSC PM Domain driver.
>>>>>>> Unfortunately the devil is in the details, as usual...
>>>>>>>
>>>>>>> Earlycon relies on the serial port to be initialized by the firmware
>>>>>>> and/or bootloader.  Linux is not aware of any hardware dependencies that
>>>>>>> must be met to keep the port working, and thus cannot guarantee they
>>>>>>> stay met, until the full serial driver takes over.
>>>>>>>
>>>>>>> E.g. all unused clocks and unused PM Domains are disabled in a late
>>>>>>> initcall.  As this happens after the full serial driver has taken over,
>>>>>>> the serial port's clock and/or PM Domain are no longer deemed unused,
>>>>>>> and this is typically not a problem.
> 
> Let's call this "Case A".
> 
>>>>>>>
>>>>>>> However, if the serial port's clock or PM Domain is shared with another
>>>>>>> device, and that other device is runtime-suspended before the full
>>>>>>> serial driver has probed, the serial port's clock and/or PM Domain will
>>>>>>> be disabled inadvertently.  Any subsequent serial console output will
>>>>>>> cause a crash or system lock-up.  E.g. on R/SH-Mobile SoCs, the serial
>>>>>>> ports share their PM Domain with several other I/O devices.  After the
>>>>>>> use of pwm (Armadillo-800-EVA) or i2c (KZM-A9-GT) during early boot,
>>>>>>> before the full serial driver takes over, the PM Domain containing the
>>>>>>> early serial port is powered down, causing a lock-up when booted with
>>>>>>> "earlycon".
> 
> Let's call this "Case B".
> 
>>>>>>
>>>>>> Thanks for the detailed description of the problem! As pointed out in
>>>>>> regards to another similar recent patch [1], this is indeed a generic
>>>>>> problem, not limited to the serial console handling.
>>>>>>
>>>>>> At Linaro Connect a few weeks ago I followed up with Saravana from the
>>>>>> earlier discussions at LPC last fall. We now have a generic solution
>>>>>> for genpd drafted on plain paper, based on fw_devlink and the
>>>>>> ->sync_state() callback. I am currently working on the genpd series,
>>>>>> while Saravana will re-spin the series (can't find the link to the
>>>>>> last version) for the clock framework. Ideally, we want these things
>>>>>> to work in a very similar way.
>>>>>>
>>>>>> That said, allow me to post the series for genpd in a week or two to
>>>>>> see if it can solve your problem too, for the serial console.
>>>>>
>>>>> Both the genpd and the clock solutions will make suppliers depend on all
>>>>> their consumers to be probed, right?
>>>>>
>>>>> I think it is a solution, and should be worked on, but it has the
>>>>> drawback that suppliers that have consumers that will possibly never be
>>>>> probed, will also never be able to turn off unused resources.
>>>>>
>>>>> This was specifically the case with the TI ti-sci pmdomain case I was
>>>>> looking at: the genpd driver (ti_sci_pm_domains.c) provides a lot of
>>>>> genpds for totally unrelated devices, and so if, e.g., you don't have or
>>>>> don't want to load a driver for the GPU, all PDs are affected.
>>>>>
>>>>> Even here the solutions you mention will help: instead of things getting
>>>>> broken because genpds get turned off while they are actually in use, the
>>>>> genpds will be kept enabled, thus fixing the breakage. Unfortunately,
>>>>> they'll be kept enabled forever.
>>>>>
>>>>> I've been ill for quite a while so I haven't had the chance to look at
>>>>> this more, but before that I was hacking around a bit with something I
>>>>> named .partial_sync_state(). .sync_state() gets called when all the
>>>>> consumers have probed, but .partial_sync_state() gets called when _a_
>>>>> consumer has been probed.
>>>>>
>>>>> For the .sync_state() things are easy for the driver, as it knows
>>>>> everything related has been probed, but for .partial_sync_state() the
>>>>> driver needs to track resources internally. .partial_sync_state() will
>>>>> tell the driver that a consumer device has probed, the driver can then
>>>>> find out which specific resources (genpds in my case) that consumer
>>>>> refers to, and then... Well, that's how far I got with my hacks =).
>>>>>
>>>>> So, I don't know if this .partial_sync_state() can even work, but I
>>>>> think we do need something more on top of the .sync_state().
>>>>
>>>> Thanks for the update!
>>>>
>>>> You certainly have a point, but rather than implementing some platform
>>>> specific method, I think we should be able enforce the call to
>>>> ->sync_state(), based upon some condition/timeout - and even if all
>>>> consumers haven't been probed.
>>>
>>> Hmm, I think that was already implemented in some of the serieses out
>>> there (or even in mainline already?), as I remember doing some
>>> experiments with it. I don't like it much, though.
>>>
>>> With a simple timeout, it'll always be just a bit too early for some
>>> user (nfs mount took a bit more time than expected -> board frozen).
>>>
>>> The only condition I can see that would somewhat work is a manual
>>> trigger from the userspace. The boot scripts could then signal the
>>> kernel when all the modules have been loaded and probably a suitable,
>>> platform/use case specific amount of time has passed to allow the
>>> drivers to probe.
>>
>> This is also already supported in mainline.
>>
>> Devices with sync_state() implementations (once Ulf adds it) will have
>> a state_synced file in sysfs. It shows where it has been called yet or
>> not. But you can also echo 1 into it to force the sync_state()
>> callback (only if it hasn't been called already). So, yeah, all
>> methods of handling this are available if you implement the
>> sync_state() callback.
>>
>> By default it's all strict (wait till all consumers probe
>> successfully). But you can set it to timeout (fw_devlink.sync_state).
>> And you also have the option I mentioned above that you can use with
>> both cases.
> 
> So the idea is to disable unused genpds and clocks from the genpd
> resp. clock's driver .sync_state() callback, instead of from a late
> initcall?  That would indeed solve issues related to "Case A".
> 
> However, how to solve "Case B"? Ignore disabling genpds or clocks
> before .sync_state() callback() has been called?
> That would cause issues for cases where the clock must be disabled,
> cfr.
>      "[PATCH RFC 0/3] Add clk_disable_unprepare_sync()"
>      https://lore.kernel.org/all/20240131160947.96171-1-biju.das.jz@bp.renesas.com/
>      "[PATCH v3 0/3] Add clk_poll_disable_unprepare()"
>      https://lore.kernel.org/linux-renesas-soc/20240318110842.41956-1-biju.das.jz@bp.renesas.com/
> 
>>> It just feels a bit too much of a "let's hope this work" approach.
>>>
>>> That said, the timeout/condition is probably acceptable for many cases,
>>> where turning off a resource forcefully will just result in, say, a
>>> temporarily blanked display, or something else that gets fixed if and
>>> when the proper driver is probed.
>>>
>>> Unfortunately, here with the case I have, the whole board gets halted if
>>> the display subsystem genpd is turned off and the display driver is
>>> loaded after that.
> 
> Tomi: Do you have more details? The genpd must be controlling something
> critical that must never be turned off, or perhaps the display driver
> lacks some initialization?

I don't know the exact HW level details. It may be a HW bug or possibly 
a firmware issue. But what I see is simple:

If the display subsystem is powered and a video output is enabled, 
turning off the PD causes the display subsystem to go to a bad state, 
after which the next register access will halt the cpu.

This happens quite easily if the bootloader has enabled a display: when 
the kernel's tidss driver probes, the device framework will make sure 
the PD is enabled (which is fine, it's basically a no-op). But if the 
tidss returns an error, like EPROBE_DEFER, the device framework will 
disable the PD. When the tidss driver probes again later, it will cause 
a halt at a register access.

  Tomi


