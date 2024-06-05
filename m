Return-Path: <linux-pm+bounces-8634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D0B8FCA10
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 13:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215FFB2394D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 11:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A178C192B6E;
	Wed,  5 Jun 2024 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iwVmDsmJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7EF19148A;
	Wed,  5 Jun 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586217; cv=none; b=RJ63TVduXtjpoUhfjT0QeQikQ+I0zKQ1yLwVyowMCuUtAGhGm8gjCWd/Ay/xrepzuXLaUzBDkWqsOUuOta9T2K4xrvK9PFYumOE1m9k0RPHgaBMJR2jv4X0Z1y79bc35ipBp/3xJUThbZK9wrlohz6puKixd2QNrKTmRGrNZmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586217; c=relaxed/simple;
	bh=Nw4TuTn8T9u6w3MKkm95ylAux/0A8d8I9RYsH5nAQkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdZ19r6Y/QnVHLPUNv1rDCDSugk4rzVK//U3R94ZKdqqYyC8MQQkOsI+fWdQnCu1jlc93uesqunUM8FDaBrAV4B5eZCPaLvfAI6N3jIm04A4Z6PmjF4z4r4NACpqsqSxh2fhALtqz5VqDY10r5JQQIY1O4MEw2bu+rEeQdJtKrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iwVmDsmJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-144-210.elisa-laajakaista.fi [91.158.144.210])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 71C1B14B0;
	Wed,  5 Jun 2024 13:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1717586205;
	bh=Nw4TuTn8T9u6w3MKkm95ylAux/0A8d8I9RYsH5nAQkc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iwVmDsmJYn5iM3wEnS40fPevLew572amUg3D0OR0nYDV0xFyx6ep2upOGeSDF87m4
	 jHXH5UBTfatMFPcsvclBz0SbQjM0VjK9Ci0nurt0bfSdqWu8Pp9z8mEvugVyMaeuTB
	 A2mBcs27W8KDlzaCSQE+oDXRrnGl8UJyl2lAhUH0=
Message-ID: <1bda8e8f-10df-4a10-a217-26cf50ef3577@ideasonboard.com>
Date: Wed, 5 Jun 2024 14:16:49 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 0/3] pmdomain: renesas: rmobile-sysc: Remove serial
 console handling
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
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
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <CAPDyKFrxUDhnUUfz5wHpGVQfNYssxoWO5Eb2wtmZMTcMYhEjxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/06/2024 13:53, Ulf Hansson wrote:
> On Wed, 5 Jun 2024 at 12:41, Tomi Valkeinen
> <tomi.valkeinen@ideasonboard.com> wrote:
>>
>> Hi Ulf,
>>
>> On 05/06/2024 12:34, Ulf Hansson wrote:
>>> + Tomi
>>>
>>> On Mon, 27 May 2024 at 14:41, Geert Uytterhoeven
>>> <geert+renesas@glider.be> wrote:
>>>>
>>>>           Hi all,
>>>>
>>>> Since commit a47cf07f60dcb02d ("serial: core: Call
>>>> device_set_awake_path() for console port"), the serial driver properly
>>>> handles the case where the serial console is part of the awake path, and
>>>> it looked like we could start removing special serial console handling
>>>> from PM Domain drivers like the R-Mobile SYSC PM Domain driver.
>>>> Unfortunately the devil is in the details, as usual...
>>>>
>>>> Earlycon relies on the serial port to be initialized by the firmware
>>>> and/or bootloader.  Linux is not aware of any hardware dependencies that
>>>> must be met to keep the port working, and thus cannot guarantee they
>>>> stay met, until the full serial driver takes over.
>>>>
>>>> E.g. all unused clocks and unused PM Domains are disabled in a late
>>>> initcall.  As this happens after the full serial driver has taken over,
>>>> the serial port's clock and/or PM Domain are no longer deemed unused,
>>>> and this is typically not a problem.
>>>>
>>>> However, if the serial port's clock or PM Domain is shared with another
>>>> device, and that other device is runtime-suspended before the full
>>>> serial driver has probed, the serial port's clock and/or PM Domain will
>>>> be disabled inadvertently.  Any subsequent serial console output will
>>>> cause a crash or system lock-up.  E.g. on R/SH-Mobile SoCs, the serial
>>>> ports share their PM Domain with several other I/O devices.  After the
>>>> use of pwm (Armadillo-800-EVA) or i2c (KZM-A9-GT) during early boot,
>>>> before the full serial driver takes over, the PM Domain containing the
>>>> early serial port is powered down, causing a lock-up when booted with
>>>> "earlycon".
>>>
>>> Hi Geert,
>>>
>>> Thanks for the detailed description of the problem! As pointed out in
>>> regards to another similar recent patch [1], this is indeed a generic
>>> problem, not limited to the serial console handling.
>>>
>>> At Linaro Connect a few weeks ago I followed up with Saravana from the
>>> earlier discussions at LPC last fall. We now have a generic solution
>>> for genpd drafted on plain paper, based on fw_devlink and the
>>> ->sync_state() callback. I am currently working on the genpd series,
>>> while Saravana will re-spin the series (can't find the link to the
>>> last version) for the clock framework. Ideally, we want these things
>>> to work in a very similar way.
>>>
>>> That said, allow me to post the series for genpd in a week or two to
>>> see if it can solve your problem too, for the serial console.
>>
>> Both the genpd and the clock solutions will make suppliers depend on all
>> their consumers to be probed, right?
>>
>> I think it is a solution, and should be worked on, but it has the
>> drawback that suppliers that have consumers that will possibly never be
>> probed, will also never be able to turn off unused resources.
>>
>> This was specifically the case with the TI ti-sci pmdomain case I was
>> looking at: the genpd driver (ti_sci_pm_domains.c) provides a lot of
>> genpds for totally unrelated devices, and so if, e.g., you don't have or
>> don't want to load a driver for the GPU, all PDs are affected.
>>
>> Even here the solutions you mention will help: instead of things getting
>> broken because genpds get turned off while they are actually in use, the
>> genpds will be kept enabled, thus fixing the breakage. Unfortunately,
>> they'll be kept enabled forever.
>>
>> I've been ill for quite a while so I haven't had the chance to look at
>> this more, but before that I was hacking around a bit with something I
>> named .partial_sync_state(). .sync_state() gets called when all the
>> consumers have probed, but .partial_sync_state() gets called when _a_
>> consumer has been probed.
>>
>> For the .sync_state() things are easy for the driver, as it knows
>> everything related has been probed, but for .partial_sync_state() the
>> driver needs to track resources internally. .partial_sync_state() will
>> tell the driver that a consumer device has probed, the driver can then
>> find out which specific resources (genpds in my case) that consumer
>> refers to, and then... Well, that's how far I got with my hacks =).
>>
>> So, I don't know if this .partial_sync_state() can even work, but I
>> think we do need something more on top of the .sync_state().
> 
> Thanks for the update!
> 
> You certainly have a point, but rather than implementing some platform
> specific method, I think we should be able enforce the call to
> ->sync_state(), based upon some condition/timeout - and even if all
> consumers haven't been probed.

Hmm, I think that was already implemented in some of the serieses out 
there (or even in mainline already?), as I remember doing some 
experiments with it. I don't like it much, though.

With a simple timeout, it'll always be just a bit too early for some 
user (nfs mount took a bit more time than expected -> board frozen).

The only condition I can see that would somewhat work is a manual 
trigger from the userspace. The boot scripts could then signal the 
kernel when all the modules have been loaded and probably a suitable, 
platform/use case specific amount of time has passed to allow the 
drivers to probe.

It just feels a bit too much of a "let's hope this work" approach.

That said, the timeout/condition is probably acceptable for many cases, 
where turning off a resource forcefully will just result in, say, a 
temporarily blanked display, or something else that gets fixed if and 
when the proper driver is probed.

Unfortunately, here with the case I have, the whole board gets halted if 
the display subsystem genpd is turned off and the display driver is 
loaded after that.

  Tomi


