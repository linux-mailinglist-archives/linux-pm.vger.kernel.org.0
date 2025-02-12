Return-Path: <linux-pm+bounces-21969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D071A329B0
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 16:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2831886EC1
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 15:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2B121149C;
	Wed, 12 Feb 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2EJUvXk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDAB20B215
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373320; cv=none; b=gMUa0YQyFHx25CEz7qsyVC7j79IbQp9ToAQw/ZV2XbfrPpZbkJK7183jqaT20iNCx0Jz6R3WgHJ34cdx9v6QN48IjASiGUEqW8JOP+LLp2SP2NmsrIjDZosv51ElYvjNOtCn3mREkktq+AdhRIyyFpJ5scwgemdN1rlZTXzwrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373320; c=relaxed/simple;
	bh=BUm2Zap/RF2/JfmCsYLH9p4o0ufnU8QKAPpBKlTTB4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTNyp9GiR9kctI6sBAwi4C++Vy9frP2QrD4fxJIWedLXR9+8VLNQGUaH9aH0s9aGG35Las4pcHoDURjjgJKFBh5i9iUz6q/7OL08Vet94p+UtpxPQ/gy9OxmbFjD6AGt0SbFKouLakwAp0QA+8O7rbnKerGFA2k/OkvWrSCQSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2EJUvXk; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e4419a47887so5356361276.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 07:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739373316; x=1739978116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YIpGBtMZitl6oEYph0lTTw+LZiGhyRXcVjUuyB+Xm8=;
        b=L2EJUvXkBTT+ctHaIzM9viXy8QlMvAidV4w9Ud99CO9BzVALKe2L0nKKHMmyRlZMhi
         KnSWix78rwsGvUJVSwW3O2JsFP5P+sT4Pj7mPq8rzs/Wli9gADjwUX9nLjjyocHXIjU4
         vCxHaTpk0CUMdtqddEKEm5cjmmtVQS0nMpE80rdkV1/k3wgCrpVC+IZBhnca15P9sVQQ
         npVGBHPZYcOW0A3R4eMDs/++GqxWSW1N6kcfgItn9RlD8YT7zG3Bd6PM48LJdtfH1jo6
         xD7MWEpjr3Jh69/qADa78J5wwdEksGetm4x2Byog1Ji92jsaEJpMtN0qFQtgocSHaW35
         4e0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373316; x=1739978116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YIpGBtMZitl6oEYph0lTTw+LZiGhyRXcVjUuyB+Xm8=;
        b=BgPV3ORhGZMytTYR45DbmGZuApfPAYATXF6cJTYzKwndAa1fvvPSlOZxMIxrKTEwS9
         uGSPpv1XByWtuBfM2BpnbybS4cMuWSWf/F2TQZvPYfa85twcGmc1Mjpci+8DXo9CiQjA
         0gvUatbWvAx/4NjYgXmzFForOFSAFwIQEMgb4GiwmqN2wI9yihSF32m9VclfOB5wtVXQ
         B6wTU4VGVbKn3iWDbIB4As1SIDuHY7UgwFoGPKjU0Q51G5o1PYpsimnpW9G9ZQBPBr/Z
         Kq5cuE34utE6jliYftw42+yPzSBIbSAufpdR2Ygtpew5SHLoqQcCcHShbPSsxH9HZHDq
         GWRA==
X-Forwarded-Encrypted: i=1; AJvYcCWrH87t5pHgyXOEgsdn3Dl6RedQqR88Ny8QaKMVDAKB2tUg5MnMAtmQIin13fAg4ZVSNSUQONdBxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3/0Al07QDDHt8FPm1KaP7SRekhx3s8se5keeigiA92voBS15
	JsDXXBPxXu5KS1ywKT/noPjNfj55sxkJwUNPCX9Ndbn2SXe4ji5Wd/KWJCWIUmIviu/Xcc72xqo
	0E0HUZw7Uu+aDPpFTCViDLzWkUXdnG/sM0qQCqratk5atRAEbbRY=
X-Gm-Gg: ASbGncsCZLM+P7UHfWoF8gdnTMP/e8OU41vUtcJuKkxix2QWVOYRl77+c+aFuYosIG9
	8UPVU/apK62vDX6MoB4ch7tnhPkxXo8KC5OCctRnr0VYjDYeGm0L2K3BfyRfl3WgGsN1tDNs24w
	==
X-Google-Smtp-Source: AGHT+IHxai81f2SI+SV8N7Os/hKhKDSmwdp/r4ugFj0WWmqweXF4GapOJBoqeJMP8fHbTzBUc17iRvJUfAPGDckBgaA=
X-Received: by 2002:a05:6902:2d06:b0:e5b:158c:56cf with SMTP id
 3f1490d57ef6-e5d9f0ccc00mr3383951276.5.1739373315992; Wed, 12 Feb 2025
 07:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
 <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com> <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Feb 2025 16:14:40 +0100
X-Gm-Features: AWEUYZmkxKfHuLhmdUsElz1kuhgiphYNGOZu1DQbUnebvjnBTU-cy8NFBu0JkAY
Message-ID: <CAPDyKFq91JnCFhEuitOJPZtq78-Y3CUy4p0bNE1wK+eYCste6g@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Feb 2025 at 12:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 12, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Wed, Feb 12, 2025 at 10:12=E2=80=AFAM Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> > >
> > > On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwysocki.net> w=
rote:
> > > >
> > > > Hi Everyone,
> > > >
> > > > This series is a result of the discussion on a recently reported is=
sue
> > > > with device runtime PM status propagation during system resume and
> > > > the resulting patches:
> > > >
> > > > https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwysocki.net/
> > > > https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki.net/
> > > >
> > > > Overall, due to restrictions related to pm_runtime_force_suspend() =
and
> > > > pm_runtime_force_resume(), it was necessary to limit the RPM_ACTIVE
> > > > setting propagation to the parent of the first device in a dependen=
cy
> > > > chain that turned out to have to be resumed during system resume ev=
en
> > > > though it was runtime-suspended before system suspend.
> > > >
> > > > Those restrictions are that (1) pm_runtime_force_suspend() attempts=
 to
> > > > suspend devices that have never had runtime PM enabled if their run=
time
> > > > PM status is currently RPM_ACTIVE and (2) pm_runtime_force_resume()
> > > > will skip device whose runtime PM status is currently RPM_ACTIVE.
> > > >
> > > > The purpose of this series is to eliminate the above restrictions a=
nd
> > > > get pm_runtime_force_suspend() and pm_runtime_force_resume() to agr=
ee
> > > > more with what the core does.
> > >
> > > For my understanding, would you mind elaborating a bit more around th=
e
> > > end-goal with this?
> >
> > The end goal is, of course, full integration of runtime PM with system
> > sleep for all devices.  Eventually.
> >
> > And it is necessary to make the core and
> > pm_runtime_force_suspend|resume() work together better for this
> > purpose.
> >
> > > Are you trying to make adaptations for
> > > pm_runtime_force_suspend|resume() and the PM core, such that drivers
> > > that uses pm_runtime_force_suspend|resume() should be able to cope
> > > with other drivers for child-devices that make use of
> > > DPM_FLAG_SMART_SUSPEND?
> >
> > Yes.
> >
> > This is a more general case, though, when a device that was
> > runtime-suspended before system suspend and is left in suspend during
> > it, needs to be resumed during the system resume that follows.
> >
> > Currently, DPM_FLAG_SMART_SUSPEND can lead to this sometimes and it
> > cannot happen otherwise, but I think that it is a generally valid
> > case.
> >
> > > If we can make this work, it would enable the propagation of
> > > RPM_ACTIVE in the PM core for more devices, but still not for all,
> > > right?
> >
> > It is all until there is a known case in which it isn't.  So either
> > you know a specific case in which it doesn't work, or I don't see a
> > reason for avoiding it.
> >
> > ATM the only specific case in which it doesn't work is when
> > pm_runtime_force_suspend|resume() are used.
> >
> > > The point is, the other bigger issue that I pointed out in our earlie=
r
> > > discussions; all those devices where their drivers/buses don't cope
> > > with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will prevent
> > > the PM core from *unconditionally* propagating the RPM_ACTIVE to
> > > parents. I guess this is the best we can do then?
> >
> > OK, what are they?
> >
> > You keep saying that they exist without giving any examples.
>
> To put it more bluntly, I'm not aware of any place other than
> pm_runtime_force_suspend|resume() that can be confused by changing the
> runtime PM status of a device with runtime PM disabled (either
> permanently, or transiently during a system suspend-resume cycle) to
> RPM_ACTIVE, so if there are any such places, I would appreciate
> letting me know what they are.

Well, sorry I thought you were aware. Anyway, I believe you need to do
your own investigation as it's simply too time consuming for me to
find them all. The problem is that it's not just a simple pattern to
search for, so we would need some clever scripting to move forward to
find them.

To start with, we should look for drivers that enable runtime PM, by
calling pm_runtime_enable().

Additionally, in their system suspend callback they should typically
*not* use pm_runtime_suspended(), pm_runtime_status_suspended() or
pm_runtime_active() as that is usually (but no always) indicating that
they got it right. Then there are those that don't have system
suspend/resume callbacks assigned at all (or uses some other subsystem
specific callback for this), but only uses runtime PM.

On top of that, drivers that makes use of
pm_runtime_force_suspend|resume() should be disregarded, which has
reached beyond 300 as this point.

Anyway, here is just one example that I found from a quick search.
drivers/i2c/busses/i2c-qcom-geni.c

>
> Note that rpm_active() could start producing confusing results if the
> runtime PM status of a device with runtime PM disabled is changed from
> RPM_ACTIVE to RPM_SUSPENDED because it will then start to return
> -EACCES instead of 1, but changing the status to RPM_ACTIVE will not
> confuse it the same way.

Trust me, it will cause problems.

Drivers may call pm_runtime_get_sync() to turn on the resources for
the device after the system has resumed, when runtime PM has been
re-enabled for the device by the PM core.

Those calls to pm_runtime_get_sync() will then not end up invoking any
if ->runtime_resume() callbacks for the device since its state is
already RPM_ACTIVE. Hence, the device will remain in a low power state
even if the driver believes it has been powered on. In many cases,
accessing the device (like reading/writing a register) will often just
just hang in these cases, but in worst cases we could end up getting
even more difficult bugs to debug.

Kind regards
Uffe

