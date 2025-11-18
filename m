Return-Path: <linux-pm+bounces-38170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE94C697A1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6144F3681F1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E99523F413;
	Tue, 18 Nov 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShVeyywq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08F23EAAB
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470339; cv=none; b=Mg4V+X2bEaZw79uH3zW6L3xyTATEb/RpYTlCPFYVjVAD9Z5QGpHSOnXN3QHqUssjbva220LJ8qT9lwqqepfcBNxtLWsHXc9BkN7+6gc6cZLsjU8Bjhib0KtDoYGnovaJRkC+68aWGbOAtECBNZPO8u96puro7C8vaz/D9FmKkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470339; c=relaxed/simple;
	bh=oCdeyDre9H8fm43h64LOpJvCiKkwI8nR8Ldh8b2BFt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwvDTnuNFUksih2S+0izZEUXYezxa54p5nNOAIaw649j3XGVfsTu7ZCjkYZu6+eeCY+y2Gr/Q0pxUIJAjH3ew8iIdD/EXX/vj3NcfXo2ze2VolD9/xzcCrvFh+DD+v7ogEObJ4CKmW/ggG1dJiiXvG8SB6UnYqLMyxOWzxgld2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShVeyywq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950C8C2BC86
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763470338;
	bh=oCdeyDre9H8fm43h64LOpJvCiKkwI8nR8Ldh8b2BFt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ShVeyywq9IuOztIsisUUOtg9EXEJPNZyWi/ZAdEaJTqDqamaalSjbgujKE2ZsYRDd
	 ayP8ikz39bdP3yuh2fddholn7hSea5CDbJ3b4Vm/6aPpz1A4UFZRm590Wrz/MyBEDE
	 6fJ1xZC5MIUI2gOORfXHzqkWh37FEdPT2S6AE9SnHsOqGzZPPQFo029Q/ZYqmTEybw
	 IZixPfWcREGaJ9zhL8kF1LzNPeKSZ2LdA0Uh8NcqgphqPktjVW5ibrhplzZJwAjxQU
	 0tELkypIIQEd8xGnUHjZ5mGrFUBCndUik2kGLKWN1nOFygrGI5TBwlTU/cTZZ91tjp
	 L1WA4kSevIcZg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-657464a9010so503132eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 04:52:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQGc0+JOjr1dfkV0KHwjq/fS4QkQwDdRxFVIcmzht/nb3liaIBlLaQ+xi7/keSBzALDALIJllh5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkPk6FLzj8AnRBu0Mn6i8seuV43ZJR7N0FMVT1dtfytuySf0S
	jVAxBQT1wfeapew0ZAJOevS2ATIzgBZn1xNe7AhUSi6TuwmfhwTdRqhqJ3rmDLinVbsLteJV9dj
	qHpuenz/yIZbOy4hiV/hYuuDCv23sKP8=
X-Google-Smtp-Source: AGHT+IFR9OXgw8pdu2VohXhDiYPEXXRiTOcSaz6Nri5uJ2ZcrY59pOb20QHoWV8RJiFgyqIXMaC8MvHbYjtgu37moYE=
X-Received: by 2002:a05:6820:1b1a:b0:657:6678:1b48 with SMTP id
 006d021491bc7-65766782056mr650639eaf.3.1763470336991; Tue, 18 Nov 2025
 04:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <5940388.DvuYhMxLoT@rafael.j.wysocki> <119e2410ca32a0d55fa6febf93c7a3164b391db0.camel@mediatek.com>
 <12782716.O9o76ZdvQC@rafael.j.wysocki> <CAPDyKFqzt70rkHaRP62zErkMi2kFC1iY-NHPWjK0FWZSjZ00jA@mail.gmail.com>
 <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com> <CAPDyKFqBB7gDXSDV-GbMqWDBbT8RMVdc-9+iDOvEdpVV5TACyw@mail.gmail.com>
In-Reply-To: <CAPDyKFqBB7gDXSDV-GbMqWDBbT8RMVdc-9+iDOvEdpVV5TACyw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Nov 2025 13:52:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i_-i1EpF0KVforu7gPy_YJ6SzTCaj-1uxFx0sBBzCgbg@mail.gmail.com>
X-Gm-Features: AWmQ_bnwFW9-RQp7EQ4BLzQBfRWOIGfweqvelbeU9JtfNnvwDjK7XUJz7I3QB_E
Message-ID: <CAJZ5v0i_-i1EpF0KVforu7gPy_YJ6SzTCaj-1uxFx0sBBzCgbg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Rose Wu <ya-jou.wu@mediatek.com>, rafael.j.wysocki@intel.com, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	wsd_upstream <wsd_upstream@mediatek.com>, linux-mediatek@lists.infradead.org, 
	"artis. chiu" <artis.chiu@mediatek.com>, "Johnny-cc. Kao" <Johnny-cc.Kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 1:49=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Tue, 18 Nov 2025 at 13:26, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Tue, Nov 18, 2025 at 1:18=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Tue, 18 Nov 2025 at 12:48, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Tuesday, November 18, 2025 9:31:08 AM CET Rose Wu wrote:
> > > > > Hi,
> > > > >
> > > > > On Mon, 2025-11-17 at 19:57 +0100, Rafael J. Wysocki wrote:
> > > > > >
> > > > > > Make two changes to address this problem.
> > > > > >
> > > > > > First, reorder device_suspend_late() to only disable runtime PM=
 for a
> > > > > > device if the power.is_late_suspended flag is going to be set f=
or it.
> > > > > > In all of the other cases, disabling runtime PM for the device =
is not
> > > > > > in fact necessary.
> > > > > >
> > > > > > Second, make device_resume_early() only enable runtime PM for t=
he
> > > > > > devices with the power.is_late_suspended flag set.
> > > > > >
> > > > >
> > > > > My concern is with the error path in device_suspend_late().
> > > > > If a device fails its dpm_run_callback(), it appears that its
> > > > > power.is_late_suspended flag is not set, potentially leaving its =
runtime
> > > > > PM disabled during the resume sequence.
> > > >
> > > > Right, pm_runtime_enable() is missing in the error path after calli=
ng
> > > > dpm_run_callback().
> > > >
> > > > ---
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Runtime PM should only be enabled in device_resume_early() if it ha=
s
> > > > been disabled for the given device by device_suspend_late().  Other=
wise,
> > > > it may cause runtime PM callbacks to run prematurely in some cases
> > > > which leads to further functional issues.
> > > >
> > > > Make two changes to address this problem.
> > > >
> > > > First, reorder device_suspend_late() to only disable runtime PM for=
 a
> > > > device when it is going to look for the device's callback.  In all =
of
> > > > the other cases, disabling runtime PM for the device is not in fact
> > > > necessary.  However, if the device's callback returns an error and =
the
> > > > power.is_late_suspended flag is not going to be set, enable runtime
> > > > PM so it only remains disabled when power.is_late_suspended is set.
> > > >
> > > > Second, make device_resume_early() only enable runtime PM for the
> > > > devices with the power.is_late_suspended flag set.
> > > >
> > > > Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more async=
hronous")
> > > > Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
> > > > Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f4a=
7dee7edaaffc33.camel@mediatek.com/
> > > > Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > v1 -> v2: Add pm_runtime_enable() to device_suspend_late() error pa=
th (Rose).
> > > >
> > > > ---
> > > >  drivers/base/power/main.c |   15 ++++++++-------
> > > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > >
> > > > --- a/drivers/base/power/main.c
> > > > +++ b/drivers/base/power/main.c
> > > > @@ -941,11 +941,11 @@ Run:
> > > >
> > > >  Skip:
> > > >         dev->power.is_late_suspended =3D false;
> > > > +       pm_runtime_enable(dev);
> > > >
> > > >  Out:
> > > >         TRACE_RESUME(error);
> > > >
> > > > -       pm_runtime_enable(dev);
> > > >         complete_all(&dev->power.completion);
> > > >
> > > >         if (error) {
> > > > @@ -1630,12 +1630,6 @@ static void device_suspend_late(struct d
> > > >         TRACE_DEVICE(dev);
> > > >         TRACE_SUSPEND(0);
> > > >
> > > > -       /*
> > > > -        * Disable runtime PM for the device without checking if th=
ere is a
> > > > -        * pending resume request for it.
> > > > -        */
> > > > -       __pm_runtime_disable(dev, false);
> > > > -
> > > >         dpm_wait_for_subordinate(dev, async);
> > > >
> > > >         if (READ_ONCE(async_error))
> > > > @@ -1649,6 +1643,12 @@ static void device_suspend_late(struct d
> > > >         if (dev->power.syscore || dev->power.direct_complete)
> > > >                 goto Complete;
> > > >
> > > > +       /*
> > > > +        * Disable runtime PM for the device without checking if th=
ere is a
> > > > +        * pending resume request for it.
> > > > +        */
> > > > +       __pm_runtime_disable(dev, false);
> > > > +
> > >
> > > Moving this here means we are going to keep runtime pm enabled for
> > > syscore devices during system wide suspend/resume. That's quite a
> > > change in behaviour for a fix for a regression, I think. Not saying
> > > that it can't work though.
> >
> > syscore devices can be a special case, but I thought it wouldn't be
> > necessary to special-case them.
> >
> > Do you actually know about any of them needing special casing?
>
> There are a couple of clocksource drivers, cpuidle-psci,
> cpuidle-riscv-sbi and a usb driver that marks their devices as syscore
> devices.
>
> It *probably* works to keep runtime pm enabled for all of them, but I
> am not sure.

Well, all of the syscore devices with enabled runtime PM are potentially bu=
ggy.

Anyway, please see the v3:
https://lore.kernel.org/linux-pm/5941318.DvuYhMxLoT@rafael.j.wysocki/

