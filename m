Return-Path: <linux-pm+bounces-9717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759619117DD
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 03:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992591C20FBE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 01:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3664D10F2;
	Fri, 21 Jun 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKgKb3v6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6DB65E
	for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718932082; cv=none; b=iPno01HBEYuE+tdwCgZJapIBPbQnrvAKDB/LOcrszJB5hIz9CmIY4q+06PwuHPJi1yOAgbSQk7i/0daYPsgMqDlotLROLPvTO0oEz0wjWS9CTIsAPJlUlXinli91jtp2sJw83TWi9SGjvZS8yZCCbUinFo4a8PjWbvbMUtu9Vik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718932082; c=relaxed/simple;
	bh=jalegPIbn+AP7VNc2KA+5u5x9/D9v5CerlM8o45H0lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHHg+l9D/wN5gWKEm+/RHNt9Kt6iAw7uAmOxIZARjPjfYnGnOT8XIfLxC14ol+94w3OKjkdonn3Fk0od7BNDzSWGLayvs4nMILGW33s9XFClVusnXixUwfjslRkx4PwmkBC7LT83Yycui94TsUnVpJ0eKlLFz5wV7zhF2UJhTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKgKb3v6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-443586c2091so222771cf.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 18:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718932079; x=1719536879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdQ0lVDvBBPg2VjlcnH8vb7UwZ7F+RAkB6K0VjIZf5A=;
        b=GKgKb3v6B6ISt4BoB/ttcopvptm7hN+3kCw9GEOJcwVHdcQXCISLZ/pJt9JRQBh9rb
         fvwzAubV20PeMAU2x4ezQ0cMwea6L7iFopb07NsOJ04eO+XVz17bFbsxgwbJdznvrgvf
         PJ2pQFme920lIYBVzdpAaj+atV7D60RM4PccF6qZW1b4Gs9KlwCEYkdCaqNOc4+xc/T9
         L8MxaWWWGRiN16tMLRmjgkCfhAKxIqBov8d9hY7FdMwJO8PYOOJsoGFi9eddBWq9/OEk
         z49Q6L88q/CAZRYd82oTSrUxiN8hcWJ8S9p+hhfzQystt2i9lBCNLf7FzYk8KOBPTMkf
         fpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718932079; x=1719536879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdQ0lVDvBBPg2VjlcnH8vb7UwZ7F+RAkB6K0VjIZf5A=;
        b=awbwD7GbRMBN6pJttO2bQbaJsYLnsOgFhX17P8/VmAnvRl6/wzV+zzwsX66dTFBv2L
         hr7O+ZNsdTqMEtfwbpgIHy0uikf7Eav37uEf/VBaXmHPKYOllWH17hQa61HwtimcadkC
         ijEgV+3w1yjkITfvMe/LKLDeyhhuDbOAd0OWPIiQc83TXSUybGi8Cu1FVJCuDCEshegV
         X4cYqKV3UiMAbywHexs7s1WZj1UO0MMDUIGBHJB1PwDYREEAC+SXxVzOXLKgp/uQhUfl
         wGrrPi/69/weZmvMlgCyFzQwvXa1+l9do4cAMLJ3a1Oec8BNUepWw3XwmYQtiEGROVyN
         HDEg==
X-Forwarded-Encrypted: i=1; AJvYcCWFfVGmxLRyfYUGvclqK/BsEAWYsH20WM8dcmqBG4eG0Go9vDYIzcgfHZuRm5IjJdjqQzn0yITQ/WzXqU10yS4xtwIUgJwkpSU=
X-Gm-Message-State: AOJu0Yzb4Gk1onQXRkdxL42lDXRhKiQzliwqeOsr05V8IPdDqAv2Qa3z
	4JqowLyyAgOIRn/8l66Hyr4f3ZnURb9HRWFvjuP0LkqsfkLO4mJHlFj0frnU5XpTzEAbtznnDbz
	eFOa52rNnFBmHXSTd6iqm3Syb4N3rJsocyW71
X-Google-Smtp-Source: AGHT+IHNKO5qr2WTmG1Oxs7Fv63Gwg/dT8tseRKkrxi6AKbLZajjRe3K0QfYDRO/F5TDQy2urTyYGLj+kwmP0/ISKjY=
X-Received: by 2002:ac8:57cf:0:b0:43f:fbb0:b74 with SMTP id
 d75a77b69052e-444c362afdemr839581cf.29.1718932079140; Thu, 20 Jun 2024
 18:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716811405.git.geert+renesas@glider.be> <CAPDyKFpa4LZF3eN7x-NT+b9=dKB3Oe6RY8RAyetdRBSR1-LQoQ@mail.gmail.com>
 <0a025885-ed95-45d3-bf76-d2a043baaed7@ideasonboard.com> <CAPDyKFrxUDhnUUfz5wHpGVQfNYssxoWO5Eb2wtmZMTcMYhEjxQ@mail.gmail.com>
 <1bda8e8f-10df-4a10-a217-26cf50ef3577@ideasonboard.com>
In-Reply-To: <1bda8e8f-10df-4a10-a217-26cf50ef3577@ideasonboard.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 20 Jun 2024 18:07:20 -0700
Message-ID: <CAGETcx-T54w=x=gv524dUJtnRGmOiXFA2CRYHE5Pawbux8_Tig@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] pmdomain: renesas: rmobile-sysc: Remove serial
 console handling
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:16=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> On 05/06/2024 13:53, Ulf Hansson wrote:
> > On Wed, 5 Jun 2024 at 12:41, Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> >>
> >> Hi Ulf,
> >>
> >> On 05/06/2024 12:34, Ulf Hansson wrote:
> >>> + Tomi
> >>>
> >>> On Mon, 27 May 2024 at 14:41, Geert Uytterhoeven
> >>> <geert+renesas@glider.be> wrote:
> >>>>
> >>>>           Hi all,
> >>>>
> >>>> Since commit a47cf07f60dcb02d ("serial: core: Call
> >>>> device_set_awake_path() for console port"), the serial driver proper=
ly
> >>>> handles the case where the serial console is part of the awake path,=
 and
> >>>> it looked like we could start removing special serial console handli=
ng
> >>>> from PM Domain drivers like the R-Mobile SYSC PM Domain driver.
> >>>> Unfortunately the devil is in the details, as usual...
> >>>>
> >>>> Earlycon relies on the serial port to be initialized by the firmware
> >>>> and/or bootloader.  Linux is not aware of any hardware dependencies =
that
> >>>> must be met to keep the port working, and thus cannot guarantee they
> >>>> stay met, until the full serial driver takes over.
> >>>>
> >>>> E.g. all unused clocks and unused PM Domains are disabled in a late
> >>>> initcall.  As this happens after the full serial driver has taken ov=
er,
> >>>> the serial port's clock and/or PM Domain are no longer deemed unused=
,
> >>>> and this is typically not a problem.
> >>>>
> >>>> However, if the serial port's clock or PM Domain is shared with anot=
her
> >>>> device, and that other device is runtime-suspended before the full
> >>>> serial driver has probed, the serial port's clock and/or PM Domain w=
ill
> >>>> be disabled inadvertently.  Any subsequent serial console output wil=
l
> >>>> cause a crash or system lock-up.  E.g. on R/SH-Mobile SoCs, the seri=
al
> >>>> ports share their PM Domain with several other I/O devices.  After t=
he
> >>>> use of pwm (Armadillo-800-EVA) or i2c (KZM-A9-GT) during early boot,
> >>>> before the full serial driver takes over, the PM Domain containing t=
he
> >>>> early serial port is powered down, causing a lock-up when booted wit=
h
> >>>> "earlycon".
> >>>
> >>> Hi Geert,
> >>>
> >>> Thanks for the detailed description of the problem! As pointed out in
> >>> regards to another similar recent patch [1], this is indeed a generic
> >>> problem, not limited to the serial console handling.
> >>>
> >>> At Linaro Connect a few weeks ago I followed up with Saravana from th=
e
> >>> earlier discussions at LPC last fall. We now have a generic solution
> >>> for genpd drafted on plain paper, based on fw_devlink and the
> >>> ->sync_state() callback. I am currently working on the genpd series,
> >>> while Saravana will re-spin the series (can't find the link to the
> >>> last version) for the clock framework. Ideally, we want these things
> >>> to work in a very similar way.
> >>>
> >>> That said, allow me to post the series for genpd in a week or two to
> >>> see if it can solve your problem too, for the serial console.
> >>
> >> Both the genpd and the clock solutions will make suppliers depend on a=
ll
> >> their consumers to be probed, right?
> >>
> >> I think it is a solution, and should be worked on, but it has the
> >> drawback that suppliers that have consumers that will possibly never b=
e
> >> probed, will also never be able to turn off unused resources.
> >>
> >> This was specifically the case with the TI ti-sci pmdomain case I was
> >> looking at: the genpd driver (ti_sci_pm_domains.c) provides a lot of
> >> genpds for totally unrelated devices, and so if, e.g., you don't have =
or
> >> don't want to load a driver for the GPU, all PDs are affected.
> >>
> >> Even here the solutions you mention will help: instead of things getti=
ng
> >> broken because genpds get turned off while they are actually in use, t=
he
> >> genpds will be kept enabled, thus fixing the breakage. Unfortunately,
> >> they'll be kept enabled forever.
> >>
> >> I've been ill for quite a while so I haven't had the chance to look at
> >> this more, but before that I was hacking around a bit with something I
> >> named .partial_sync_state(). .sync_state() gets called when all the
> >> consumers have probed, but .partial_sync_state() gets called when _a_
> >> consumer has been probed.
> >>
> >> For the .sync_state() things are easy for the driver, as it knows
> >> everything related has been probed, but for .partial_sync_state() the
> >> driver needs to track resources internally. .partial_sync_state() will
> >> tell the driver that a consumer device has probed, the driver can then
> >> find out which specific resources (genpds in my case) that consumer
> >> refers to, and then... Well, that's how far I got with my hacks =3D).
> >>
> >> So, I don't know if this .partial_sync_state() can even work, but I
> >> think we do need something more on top of the .sync_state().
> >
> > Thanks for the update!
> >
> > You certainly have a point, but rather than implementing some platform
> > specific method, I think we should be able enforce the call to
> > ->sync_state(), based upon some condition/timeout - and even if all
> > consumers haven't been probed.
>
> Hmm, I think that was already implemented in some of the serieses out
> there (or even in mainline already?), as I remember doing some
> experiments with it. I don't like it much, though.
>
> With a simple timeout, it'll always be just a bit too early for some
> user (nfs mount took a bit more time than expected -> board frozen).
>
> The only condition I can see that would somewhat work is a manual
> trigger from the userspace. The boot scripts could then signal the
> kernel when all the modules have been loaded and probably a suitable,
> platform/use case specific amount of time has passed to allow the
> drivers to probe.

This is also already supported in mainline.

Devices with sync_state() implementations (once Ulf adds it) will have
a state_synced file in sysfs. It shows where it has been called yet or
not. But you can also echo 1 into it to force the sync_state()
callback (only if it hasn't been called already). So, yeah, all
methods of handling this are available if you implement the
sync_state() callback.

By default it's all strict (wait till all consumers probe
successfully). But you can set it to timeout (fw_devlink.sync_state).
And you also have the option I mentioned above that you can use with
both cases.

-Saravana

>
> It just feels a bit too much of a "let's hope this work" approach.
>
> That said, the timeout/condition is probably acceptable for many cases,
> where turning off a resource forcefully will just result in, say, a
> temporarily blanked display, or something else that gets fixed if and
> when the proper driver is probed.
>
> Unfortunately, here with the case I have, the whole board gets halted if
> the display subsystem genpd is turned off and the display driver is
> loaded after that.
>
>   Tomi
>

