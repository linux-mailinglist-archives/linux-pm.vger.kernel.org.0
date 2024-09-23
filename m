Return-Path: <linux-pm+bounces-14588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1711A97EFB6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 19:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B2C1C21621
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33019E99B;
	Mon, 23 Sep 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="W2q3dPf1"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05899197A97;
	Mon, 23 Sep 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110932; cv=none; b=Bv/Q7rIIvrPVw+q3D7WB0IcUTQ4qwsKZTbDxms2NJXx06Ewq0ui7aT+NmvLgj9xaDqBeSZwSkXpWSpxUdD4YzPywmn2MDFUy0lX7NIq4epgWfPnfSfXp9dovjqlvoow20V11cowLWI4vSeWCR2M7aC/gO3Hz87ggXEInx/O/5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110932; c=relaxed/simple;
	bh=lvgmLZxYhCmVB7pq80qJENcOsyEl4GzyQ5Wm0/Yx1Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwDQKnujEtX2rO8vvBR/ZZ7CxA020Q1IX4Iwwh1xXJ1gb1Um0QrvZe39tbPFAphs1JtHnUUVGepPO2pHi1Jj6XUl3mh0eSqgYZsc+PoUun4XtcgX3bXy2cvqgPZgaNZx92T6FY/szPuiIHA4zJ+RQwrZHdDc98QlLIaDlhnXRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=W2q3dPf1; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3855F2E03433;
	Mon, 23 Sep 2024 20:02:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727110926;
	bh=QVTFu8TbMYcEfJeTkBbY29SOm453LF+epw36MMSCM9k=;
	h=Received:From:Subject:To;
	b=W2q3dPf17oXBWTw0wK6RNXr5Vp2G34bpuMQyF/SDpHnRD3w5OzM6pQAPaq/AeI3BZ
	 OPCMBiEV5JEdL7/BGOsmHjzZyZb10x7pSI2eytGkl16MiO9CaNh0AEGzA2R0AC85Ds
	 TJUsXF+XBR/WKTfIC6TpLuRvdSPNUhNn6zlLCwY4=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2f759b87f83so47593361fa.2;
        Mon, 23 Sep 2024 10:02:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVbG60y2PW/p5v0Sa/a9SBZJIdw9xQaDbaOl3NWR0hCKgI8T3lPSy96LRri371iRGMStOYeialrMCfGjQbcD1dknd2y@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4e1AFC27af865pI91nqowJCZ2v3/Y7zCKSwtLhDpWim7PUnip
	+0TjgcQXo2G27OybyStnO+uwf+p9RpilckWUQ032T1Bjyqg2NXvIEi2OmMDd12MaGZA08vcshP7
	h+4mlK04CzgJKVt3dfozNdRzixmk=
X-Google-Smtp-Source: 
 AGHT+IEY4xY/TUAT45uRxdyb4AR46kNHOV3mrH3H1W2EiAWF+PTvfPM+N7H97UGePApOHlyFvpHThb9ksBza2TDOg5I=
X-Received: by 2002:a05:651c:221b:b0:2f6:5f0a:9d00 with SMTP id
 38308e7fff4ca-2f7cc3578ffmr59473911fa.1.1727110925444; Mon, 23 Sep 2024
 10:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922172258.48435-3-lkml@antheas.dev>
 <1a9b611c-51f0-4c3d-8bc2-62c6b6104fd2@amd.com>
 <CAGwozwFwU=KMgDUmKsYRu323dsuUfQYa8e-aXV3JGGSkgF-RkQ@mail.gmail.com>
 <1eff4036-b785-4737-b919-d67c52efea65@amd.com>
 <CAGwozwHbt8+hVDpyz8GM=Lwg8o=oLZDgCJ9JZN_HRzHLuwuknA@mail.gmail.com>
In-Reply-To: 
 <CAGwozwHbt8+hVDpyz8GM=Lwg8o=oLZDgCJ9JZN_HRzHLuwuknA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Sep 2024 19:01:54 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHR-LgXbO+3Ot7AwVnEwmSR70gtfERSdt47ZbW62yX3Bw@mail.gmail.com>
Message-ID: 
 <CAGwozwHR-LgXbO+3Ot7AwVnEwmSR70gtfERSdt47ZbW62yX3Bw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] acpi/x86: s2idle: handle Display On/Off calls
 outside of suspend sequence
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	luke@ljones.dev, me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <172711092663.16734.1525279245002187014@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Here I should note that I will not wait for systemd.

As part of adding support for these devices with Handheld Daemon, I
snag the powerbutton already and I only have one userspace app running
anyway, Steam. The idea here would be double tap the powerbutton to
enter a "Download Assistant", custom lockscreen pops up, and two
seconds later DPMS triggers, system enters Sleep state and either when
a battery target is reached or the download finishes, it transitions
to actual suspend.

The challenges here would be if the _DSM calls for Display Off and
Sleep Entry are a nothingburger and do not save much battery and that
Steam uses very heavy compression that does a lot of CPU.

If I find it not useful, maybe I will skip it.

Antheas

On Mon, 23 Sept 2024 at 18:43, Antheas Kapenekakis <lkml@antheas.dev> wrote=
:
>
> > On 9/23/2024 11:15, Antheas Kapenekakis wrote:
> > > Does DRM core handle virtual displays like VNC?
> > >
> >
> > You can make use of virtual display connectors in amdgpu.  This is how
> > drivers for new ASICs are first developed in emulation and also what's
> > used for early hardware bring up.
>
> Microsoft specificies all displays "state where all displays=E2=80=94loca=
l and
> remote, if any=E2=80=94have been turned off"
>
> If any means that no displays =3D no call perhaps. Would be interesting
> when designing a system for disabled people though. Given how it
> interacts in Windows, I want to say the target here is inactivity.
>
> > > As mentioned in the cover letter, the _DSM specifies both virtual and
> > > actual displays.
> > >
> > > Also, Windows behavior is like a lockscreen. 5 seconds after screen
> > > turns off after inactivity, instantly when you press the power button=
.
> > >
> > > I tend towards making a sysfs entry. Not sure.
> > >
> >
> > Who would call this sysfs file?  Systemd?  The compositor?  When?
> >
> > In Linux the compositor is in charge of doing the modesets that involve
> > turning on/off the screen.  In most cases if you press the power button
> > in Linux systemd-logind picks up the event.  It triggers a behavior
> > that's controlled by the logind configuration.  Typically that's turnin=
g
> > on a lockscreen and/or starting the suspend sequence.
>
> That's where it gets hairy and an area WIndows uniquely does not have
> a problem with because the OS is monolithic.
>
> If it were me, yes, systemd would switch the system to the inactive
> "Screen Off" state 5 seconds after the system displays are off due to
> inactivity. If we are talking about implementing something Modern
> Standby-like, then pressing the powerbutton would no longer suspend
> the device. Instead systemd would use two tiers of activators like
> windows (first tier for "Screen Off", second tier for "Sleep"; right
> now there is only one tier that mirrors screen off) and once all those
> activators are released, suspend the kernel.
>
> Then it would handle the transition from "Active" to "Screen Off" to
> "Sleep" through a sysfs endpoint, with the platform responding by
> e.g., lowering TDP and using a different fan curve.
>
> If the kernel is asked to suspend outside of the Sleep state, then it
> does the transitions to reach that state and references the quirk
> table to avoid racing conditions in manufacturer firmware (not with
> the kernel), before it suspends.
>
> > Important to note; it DOESN'T explicitly turn off displays.  If you
> > configured it to suspend then displays get turned off as part of the
> > kernel suspend sequence (drm_atomic_helper_disable_all).
> >
> > If it is configured to trigger a lockscreen then the compositor will
> > turn off displays after whatever the DPMS configuration is set to.
>
> The problem with a DRM atomic helper is that we cannot control how it
> is called and do debouncing. WIndows does debouncing (part of that is
> waiting for 5 seconds so that if you move the mouse the call is
> skipped). You could have edge conditions that spam the calls.
>
> Antheas

