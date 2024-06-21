Return-Path: <linux-pm+bounces-9738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36176911C68
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 09:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B3B1C21B38
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 07:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6916B3AE;
	Fri, 21 Jun 2024 07:07:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B716B39C;
	Fri, 21 Jun 2024 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953657; cv=none; b=ge0UTqNP2IyRlyXnIUk+LXh8P8uFF2Nn2WNFYUmqCRXxI9/TMF0Pf2rpoMNCx4NO5g6OWYQny0hNhbYDcqq5LKsSAA+MGVkYgzds9GCqcM1oMvgqAibR05cnX/CUy7YVmQkQndZ0dVMDaJ294soyx/9P9XpTYWglDA2zoOuc3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953657; c=relaxed/simple;
	bh=7tkF5DoG1mNyxCDvKqAsREysYynts5LZQaOGCf04ZBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/ETKFZhJrdWd0+yNqxdSZe9U4Y9aC/ik40cmSBhBegiYUK3Yeb2aHE9aO1I+unEx/HXuCEhCrjvEgQKVY/IiAmvETqhi7NfO8Kd+rQIwroBDUKFdzZPFrI9hAXctUF3WfLZXeJOwfG5t5ct5V9+0LLG1clG0Jngkw5GVxqx+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e02b571b0f6so1755514276.0;
        Fri, 21 Jun 2024 00:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718953653; x=1719558453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCeBy6m9Ikgkd0V6AmZHrrVdN8+2k5wHMXK+JUn37Us=;
        b=dwgkxqYlcbVunXfq1bmRBfQcrYpSyk7teLpDdkQz+8PcnGcblLl6UzxYjk9+ENlGBs
         0rA9Dj7jwlfZDMW9l3jRmcqoX2NCiHPsK/l7n/YPVEKAT6fa1CahJeEci1xX1x29Tjg+
         3JvM3ybTvuQK1bLA3dm1RRr9vBoXSbfVDqyDnDoLU2MD4SYTqgFhB1HDZsaBkXyhb7ZP
         pcwDPR+KFPy4kZuXnMsBC4b6aSF3kuJErJVRseMjU5/ld4wK0ckqe6Y5K0mqqc3EZKaS
         3ZyxLPK214L9/4KJIlKAx8tQv26Jy6Mdghc9TSa5pbZMrEa9PUWtA6lw3zQRP68k1RiB
         zPxA==
X-Forwarded-Encrypted: i=1; AJvYcCUtQXD0n7fQXBEuVFPNONTVYXqOpPpwJ7oJR/PREcR35NcYKCdvSbL6xicvOfjFgZmleCoCNR8vmy8o7R2StC12IQlUC0Kaj492eRJZ84dfcgcaDPuY1gVdSpanwTOPWpcmgzzfXlvnxXOlai+UkE+NVUfZCf+qa9nYRANgdAbspQMhSla3LTqKph/SwqYowrtKL8LzizTh9G3/AEtaVTpVEmr6cD1VECa2VIgUvAvF96p7JUQ/nqjU/ZqBHSAcaXkisqQ=
X-Gm-Message-State: AOJu0Yys0VMIWxsfl2lRH+vzD66Kpf/tgn2kt0JM1ZN7L3mN00vusXji
	CUnjTNwFE6bkIDmeZ7jjdfpjz6C0ivKTwE2N/gcDEHr9NQRAAXlICGhw3D3U
X-Google-Smtp-Source: AGHT+IEwQSLVg32R6LnNxhCts3FFOjppOMNhjb1LPkVVaD61bLTb4+b5+eet7DNLk5aIWMUC9tWc0A==
X-Received: by 2002:a25:bc8b:0:b0:e02:8d40:98ad with SMTP id 3f1490d57ef6-e02be10a9aamr8046578276.13.1718953653123;
        Fri, 21 Jun 2024 00:07:33 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e02e61168b3sm243511276.6.2024.06.21.00.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 00:07:32 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6327e303739so16311557b3.2;
        Fri, 21 Jun 2024 00:07:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbZh/NiVNtdZwRAy+L5NdysXpJBH3C1lM/y3uRIzgprhXG7AIUUjPZI1Ctx/EWOlYiqrJTm8BWhePFoG3lha6+MNvp19Siq4yJMMgN9kaKS+YISuzUGKeDOEFa9d6YgcSfm0UKx5xkrUsaxvEK+VEgofem8kmMZsqhicHOXmzYWWHIzdZuUOgNkYcre156pKZ3jA1c0vGz74Owx96Ih2y6DwGrOj7mKAoTOQR12E+aQcGSEXLEYkU2MnsJ+3LphxQ1R5c=
X-Received: by 2002:a0d:d7d2:0:b0:62c:fcba:cfeb with SMTP id
 00721157ae682-63a8f339693mr74571937b3.34.1718953651367; Fri, 21 Jun 2024
 00:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716811405.git.geert+renesas@glider.be> <CAPDyKFpa4LZF3eN7x-NT+b9=dKB3Oe6RY8RAyetdRBSR1-LQoQ@mail.gmail.com>
 <0a025885-ed95-45d3-bf76-d2a043baaed7@ideasonboard.com> <CAPDyKFrxUDhnUUfz5wHpGVQfNYssxoWO5Eb2wtmZMTcMYhEjxQ@mail.gmail.com>
 <1bda8e8f-10df-4a10-a217-26cf50ef3577@ideasonboard.com> <CAGETcx-T54w=x=gv524dUJtnRGmOiXFA2CRYHE5Pawbux8_Tig@mail.gmail.com>
In-Reply-To: <CAGETcx-T54w=x=gv524dUJtnRGmOiXFA2CRYHE5Pawbux8_Tig@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Jun 2024 09:07:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTGLSDv-zAun7tV2VnN0q08PibBT9B-MhxqdwmRTA_UQ@mail.gmail.com>
Message-ID: <CAMuHMdUTGLSDv-zAun7tV2VnN0q08PibBT9B-MhxqdwmRTA_UQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] pmdomain: renesas: rmobile-sysc: Remove serial
 console handling
To: Saravana Kannan <saravanak@google.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Fri, Jun 21, 2024 at 3:08=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
> On Wed, Jun 5, 2024 at 4:16=E2=80=AFAM Tomi Valkeinen
> <tomi.valkeinen@ideasonboard.com> wrote:
> > On 05/06/2024 13:53, Ulf Hansson wrote:
> > > On Wed, 5 Jun 2024 at 12:41, Tomi Valkeinen
> > > <tomi.valkeinen@ideasonboard.com> wrote:
> > >> On 05/06/2024 12:34, Ulf Hansson wrote:
> > >>> On Mon, 27 May 2024 at 14:41, Geert Uytterhoeven
> > >>> <geert+renesas@glider.be> wrote:
> > >>>> Since commit a47cf07f60dcb02d ("serial: core: Call
> > >>>> device_set_awake_path() for console port"), the serial driver prop=
erly
> > >>>> handles the case where the serial console is part of the awake pat=
h, and
> > >>>> it looked like we could start removing special serial console hand=
ling
> > >>>> from PM Domain drivers like the R-Mobile SYSC PM Domain driver.
> > >>>> Unfortunately the devil is in the details, as usual...
> > >>>>
> > >>>> Earlycon relies on the serial port to be initialized by the firmwa=
re
> > >>>> and/or bootloader.  Linux is not aware of any hardware dependencie=
s that
> > >>>> must be met to keep the port working, and thus cannot guarantee th=
ey
> > >>>> stay met, until the full serial driver takes over.
> > >>>>
> > >>>> E.g. all unused clocks and unused PM Domains are disabled in a lat=
e
> > >>>> initcall.  As this happens after the full serial driver has taken =
over,
> > >>>> the serial port's clock and/or PM Domain are no longer deemed unus=
ed,
> > >>>> and this is typically not a problem.

Let's call this "Case A".

> > >>>>
> > >>>> However, if the serial port's clock or PM Domain is shared with an=
other
> > >>>> device, and that other device is runtime-suspended before the full
> > >>>> serial driver has probed, the serial port's clock and/or PM Domain=
 will
> > >>>> be disabled inadvertently.  Any subsequent serial console output w=
ill
> > >>>> cause a crash or system lock-up.  E.g. on R/SH-Mobile SoCs, the se=
rial
> > >>>> ports share their PM Domain with several other I/O devices.  After=
 the
> > >>>> use of pwm (Armadillo-800-EVA) or i2c (KZM-A9-GT) during early boo=
t,
> > >>>> before the full serial driver takes over, the PM Domain containing=
 the
> > >>>> early serial port is powered down, causing a lock-up when booted w=
ith
> > >>>> "earlycon".

Let's call this "Case B".

> > >>>
> > >>> Thanks for the detailed description of the problem! As pointed out =
in
> > >>> regards to another similar recent patch [1], this is indeed a gener=
ic
> > >>> problem, not limited to the serial console handling.
> > >>>
> > >>> At Linaro Connect a few weeks ago I followed up with Saravana from =
the
> > >>> earlier discussions at LPC last fall. We now have a generic solutio=
n
> > >>> for genpd drafted on plain paper, based on fw_devlink and the
> > >>> ->sync_state() callback. I am currently working on the genpd series=
,
> > >>> while Saravana will re-spin the series (can't find the link to the
> > >>> last version) for the clock framework. Ideally, we want these thing=
s
> > >>> to work in a very similar way.
> > >>>
> > >>> That said, allow me to post the series for genpd in a week or two t=
o
> > >>> see if it can solve your problem too, for the serial console.
> > >>
> > >> Both the genpd and the clock solutions will make suppliers depend on=
 all
> > >> their consumers to be probed, right?
> > >>
> > >> I think it is a solution, and should be worked on, but it has the
> > >> drawback that suppliers that have consumers that will possibly never=
 be
> > >> probed, will also never be able to turn off unused resources.
> > >>
> > >> This was specifically the case with the TI ti-sci pmdomain case I wa=
s
> > >> looking at: the genpd driver (ti_sci_pm_domains.c) provides a lot of
> > >> genpds for totally unrelated devices, and so if, e.g., you don't hav=
e or
> > >> don't want to load a driver for the GPU, all PDs are affected.
> > >>
> > >> Even here the solutions you mention will help: instead of things get=
ting
> > >> broken because genpds get turned off while they are actually in use,=
 the
> > >> genpds will be kept enabled, thus fixing the breakage. Unfortunately=
,
> > >> they'll be kept enabled forever.
> > >>
> > >> I've been ill for quite a while so I haven't had the chance to look =
at
> > >> this more, but before that I was hacking around a bit with something=
 I
> > >> named .partial_sync_state(). .sync_state() gets called when all the
> > >> consumers have probed, but .partial_sync_state() gets called when _a=
_
> > >> consumer has been probed.
> > >>
> > >> For the .sync_state() things are easy for the driver, as it knows
> > >> everything related has been probed, but for .partial_sync_state() th=
e
> > >> driver needs to track resources internally. .partial_sync_state() wi=
ll
> > >> tell the driver that a consumer device has probed, the driver can th=
en
> > >> find out which specific resources (genpds in my case) that consumer
> > >> refers to, and then... Well, that's how far I got with my hacks =3D)=
.
> > >>
> > >> So, I don't know if this .partial_sync_state() can even work, but I
> > >> think we do need something more on top of the .sync_state().
> > >
> > > Thanks for the update!
> > >
> > > You certainly have a point, but rather than implementing some platfor=
m
> > > specific method, I think we should be able enforce the call to
> > > ->sync_state(), based upon some condition/timeout - and even if all
> > > consumers haven't been probed.
> >
> > Hmm, I think that was already implemented in some of the serieses out
> > there (or even in mainline already?), as I remember doing some
> > experiments with it. I don't like it much, though.
> >
> > With a simple timeout, it'll always be just a bit too early for some
> > user (nfs mount took a bit more time than expected -> board frozen).
> >
> > The only condition I can see that would somewhat work is a manual
> > trigger from the userspace. The boot scripts could then signal the
> > kernel when all the modules have been loaded and probably a suitable,
> > platform/use case specific amount of time has passed to allow the
> > drivers to probe.
>
> This is also already supported in mainline.
>
> Devices with sync_state() implementations (once Ulf adds it) will have
> a state_synced file in sysfs. It shows where it has been called yet or
> not. But you can also echo 1 into it to force the sync_state()
> callback (only if it hasn't been called already). So, yeah, all
> methods of handling this are available if you implement the
> sync_state() callback.
>
> By default it's all strict (wait till all consumers probe
> successfully). But you can set it to timeout (fw_devlink.sync_state).
> And you also have the option I mentioned above that you can use with
> both cases.

So the idea is to disable unused genpds and clocks from the genpd
resp. clock's driver .sync_state() callback, instead of from a late
initcall?  That would indeed solve issues related to "Case A".

However, how to solve "Case B"? Ignore disabling genpds or clocks
before .sync_state() callback() has been called?
That would cause issues for cases where the clock must be disabled,
cfr.
    "[PATCH RFC 0/3] Add clk_disable_unprepare_sync()"
    https://lore.kernel.org/all/20240131160947.96171-1-biju.das.jz@bp.renes=
as.com/
    "[PATCH v3 0/3] Add clk_poll_disable_unprepare()"
    https://lore.kernel.org/linux-renesas-soc/20240318110842.41956-1-biju.d=
as.jz@bp.renesas.com/

> > It just feels a bit too much of a "let's hope this work" approach.
> >
> > That said, the timeout/condition is probably acceptable for many cases,
> > where turning off a resource forcefully will just result in, say, a
> > temporarily blanked display, or something else that gets fixed if and
> > when the proper driver is probed.
> >
> > Unfortunately, here with the case I have, the whole board gets halted i=
f
> > the display subsystem genpd is turned off and the display driver is
> > loaded after that.

Tomi: Do you have more details? The genpd must be controlling something
critical that must never be turned off, or perhaps the display driver
lacks some initialization?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

