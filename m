Return-Path: <linux-pm+bounces-38172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D065C6982F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 14:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E609A4F317C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160E527F005;
	Tue, 18 Nov 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4uE6HVw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4227464F
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470699; cv=none; b=SjnbTI44itLkREMCtl8nGS8nQgqFnpHULKBKALeTruTdOB8vprmMvQ+yC2K94CxG3oV24L3I/lKCAPRjS2sees8RkDS1ifaAgSmEINlPpuZ62fD+b8xyGhQKWE7k0kVhSe+enNE7BvpDZ0gVWVfake2yhLm0Ho9aCI0JALXFgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470699; c=relaxed/simple;
	bh=vunG3p49R3uL/D0Tt/iA3+TjnwZdFItykJHKlgb8h/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTaLA2EgAqqVrL4yMV+tmZx3zdtsiJRo2jX0+FD/S7pHn3Vqn65c728XDtkN29pyHYdYLEKymHuqb1DlI1n+2zznTtF+aEXkAYYmwB/WHo/neeJHzk3KA56f/jfAZbhXckaGfl4lsJ6Mz0Q0NpzGX76vswSC9F5EeZEk7AE+21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4uE6HVw; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcab69so46679147b3.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 04:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763470696; x=1764075496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHDPLEl16Ugwq6B02rj9o+d8nk15yY0zPwOk9KTdur8=;
        b=T4uE6HVwtZhIPJ9fIQB3uAopkb2pQnH83xrkHd7qfTNKPRub+odCuJjFGUwWsu8sGI
         HUbBuquIN4M1ASjK63iDrOhF4z+hqTtyisEgIMtHeA3SO6XzFGDgDj5gdRSG2mcBUlYV
         OXTtfVCOyT4eJ+8uRlqgztEzV7D0IdqOAbBuphoTvGeLndyvNkrIQPQtiNYzs3vz2QTo
         IdO69AdLIfdAVlzNkdWIHuNhNipWd5DiXUHVEFLBCQxV2MWwqlevWbDvK5sklbQ/BSXf
         /tef+cOag2B63SzavNQyG7FnQFMIFhKeDeq3/XQBBNgDDYkdfVP9jjgBmdSzXJQg6sbG
         59zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763470696; x=1764075496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MHDPLEl16Ugwq6B02rj9o+d8nk15yY0zPwOk9KTdur8=;
        b=ICnlMj1akHOgtvRtJUh3R78eslMRLhnNQIVXUAYLxEFWS4my5FEPLHsuKg695uiLaW
         J95qQ+bUPVUNwCG6CRzaIWNdqaQS19241TxpGGKzxOtzMGBfcBcS98tYSM2qFfaSV6zI
         axL1fMh8sJb91hgFYJvUUUd2hhiPVHTNHlnHYd966gL//UTK8ZwNJ4Zo9TxIa7VVfHad
         p6/iWViEW/tZBswRURIC0tm04iNpnA7NNpOZJhL+M5So9lLG3OVz+CLQBGlWBKlJY51l
         C1IaMRq+cBqpDY1ZWgH+mzbuJr2/hGEr7eTOy/X6Of2DL2TzTFFxqMIk6KI2+cU2F1xL
         y/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqi4NFO3IuC+XhH+NI9bMugoe9auBsxe2S93avtIO4V3bibMSnfVwxSaSEJb3AlRO2dHHnzR55cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQxF+ert2Nd2sJPkol84iTkF39XcqRENLMAkb5+SOFZO+28Kj3
	WN7aoAI/8FMXoGvIdXu7v8VYwIsjtlqsHhQxXyrM4uE8hUTQM+C/XLP2ptEZb6WBz8wNMF/bJNs
	tz31cIP3CuheOoxs3mAJ31bpce5qmzgRMhw6UsIDWaw==
X-Gm-Gg: ASbGnctFC8NCO65yVKqhi6arpN6WJj51p7X0UDTsLjNHNWkisxDTIxLZYRS1IKqmzYw
	1BMRgl0k0VgMHUzFhvBDpC/Etb9kKIb6gcN7NlDAKH2FLh9zV5k1Ms4M2p2QkGSW10WSnk1BhuU
	Gb/6jsIe4FdD573FEB7EQuhwy1ki+njkK7iJNrWAnz1gpFm1hrmUE15cwQlGkn4zGjzMWCNmFil
	2e6GAWCkp/Ng/VlA57iqZkDzb8PybbhDuMmg3sYw9TAs34cRs+yJ5hl97P5/iOz3k11Fmk4zD9r
	oH4BrBU=
X-Google-Smtp-Source: AGHT+IGUaVRogYY/RbWrwXu+vM8fj7R/fzWaN5dRzy1h60AIkHce0jX3fDgAQ37xwlVsCyGyuiMFRFdo1Yn/mBaE2Zc=
X-Received: by 2002:a05:690c:9218:10b0:787:fa8f:beac with SMTP id
 00721157ae682-78929f151d1mr120389357b3.46.1763470695975; Tue, 18 Nov 2025
 04:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <CAPDyKFqzt70rkHaRP62zErkMi2kFC1iY-NHPWjK0FWZSjZ00jA@mail.gmail.com>
 <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com> <5941318.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <5941318.DvuYhMxLoT@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Nov 2025 13:57:40 +0100
X-Gm-Features: AWmQ_bkALcTZ8SHotDoSduUQ_Xd_gA_888BZ3hciQvrrXdUj5aqrgjY-IgODggE
Message-ID: <CAPDyKFq9boy3xTZ0Zy55QMgNu9MFH50FQeJp8buu4q7WowgFLg@mail.gmail.com>
Subject: Re: [PATCH v3] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rose Wu <ya-jou.wu@mediatek.com>, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, wsd_upstream <wsd_upstream@mediatek.com>, 
	linux-mediatek@lists.infradead.org, "artis. chiu" <artis.chiu@mediatek.com>, 
	"Johnny-cc. Kao" <Johnny-cc.Kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2025 at 13:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tuesday, November 18, 2025 1:26:06 PM CET Rafael J. Wysocki wrote:
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
> In any case, below is a v3 that special-cases syscore devices.  Fortunate=
ly,
> it is not much more complicated than the v2.
>
> Thanks!
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Runtime PM should only be enabled in device_resume_early() if it has
> been disabled for the given device by device_suspend_late().  Otherwise,
> it may cause runtime PM callbacks to run prematurely in some cases
> which leads to further functional issues.
>
> Make two changes to address this problem.
>
> First, reorder device_suspend_late() to only disable runtime PM for a
> device when it is going to look for the device's callback or if the
> device is a "syscore" one.  In all of the other cases, disabling runtime
> PM for the device is not in fact necessary.  However, if the device's
> callback returns an error and the power.is_late_suspended flag is not
> going to be set, enable runtime PM so it only remains disabled when
> power.is_late_suspended is set.
>
> Second, make device_resume_early() only enable runtime PM for the
> devices with the power.is_late_suspended flag set.
>
> Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronou=
s")
> Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
> Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f4a7dee7e=
daaffc33.camel@mediatek.com/
> Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v2 -> v1:
>    * Also set is_late_suspended for syscore devices to avoid skipping run=
time PM
>      disabling for them (Ulf).
>    * Update the changelog to reflect the above.
>
> v1 -> v2:
>    * Add pm_runtime_enable() to device_suspend_late() error path (Rose).
>    * Update the changelog to reflect the above.
>
> ---
>  drivers/base/power/main.c |   25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -903,7 +903,10 @@ static void device_resume_early(struct d
>         TRACE_DEVICE(dev);
>         TRACE_RESUME(0);
>
> -       if (dev->power.syscore || dev->power.direct_complete)
> +       if (dev->power.syscore)
> +               goto Skip;

This will enable runtime PM for a syscore device, even if it wasn't
disabled when device_suspend_late() wasn't called for it.

> +
> +       if (dev->power.direct_complete)
>                 goto Out;
>
>         if (!dev->power.is_late_suspended)
> @@ -941,11 +944,11 @@ Run:
>
>  Skip:
>         dev->power.is_late_suspended =3D false;
> +       pm_runtime_enable(dev);
>
>  Out:
>         TRACE_RESUME(error);
>
> -       pm_runtime_enable(dev);
>         complete_all(&dev->power.completion);
>
>         if (error) {
> @@ -1630,12 +1633,6 @@ static void device_suspend_late(struct d
>         TRACE_DEVICE(dev);
>         TRACE_SUSPEND(0);
>
> -       /*
> -        * Disable runtime PM for the device without checking if there is=
 a
> -        * pending resume request for it.
> -        */
> -       __pm_runtime_disable(dev, false);
> -
>         dpm_wait_for_subordinate(dev, async);
>
>         if (READ_ONCE(async_error))
> @@ -1646,9 +1643,18 @@ static void device_suspend_late(struct d
>                 goto Complete;
>         }
>
> -       if (dev->power.syscore || dev->power.direct_complete)
> +       if (dev->power.direct_complete)
>                 goto Complete;
>
> +       /*
> +        * Disable runtime PM for the device without checking if there is=
 a
> +        * pending resume request for it.
> +        */
> +       __pm_runtime_disable(dev, false);
> +
> +       if (dev->power.syscore)
> +               goto Skip;
> +
>         if (dev->pm_domain) {
>                 info =3D "late power domain ";
>                 callback =3D pm_late_early_op(&dev->pm_domain->ops, state=
);
> @@ -1679,6 +1685,7 @@ Run:
>                 WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async late" : " late", e=
rror);
> +               pm_runtime_enable(dev);
>                 goto Complete;
>         }
>         dpm_propagate_wakeup_to_parent(dev);
>
>
>

Kind regards
Uffe

