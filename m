Return-Path: <linux-pm+bounces-21978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CC3A32F32
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 20:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA173A368F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 19:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED07A260A3C;
	Wed, 12 Feb 2025 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgqc3Aef"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1825A622;
	Wed, 12 Feb 2025 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387078; cv=none; b=qvCYNOPgWkKhj0siFyNRs+FPtuoecYp2FLSNSmUFrhUg1q116qOPRl7b5rO7d3+uHCvRt2gvfuojTPZrIYPQXiUN0ccheRBSRGnsD9wdR6uN5BsUzzcLJhsWDaCDTqnz38t7GXirLhQgmsOJsIPizjzoZ2yh8iwR85MGSvYwFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387078; c=relaxed/simple;
	bh=OOx91OK90dBRzK1Krx+aCkg7brqwTQNNnN1ifpDFkwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZnO1TnSU9mQJ9PSOhj5lMjxIR5XCNRO6G8UQeRMLOSDfdAb4mSL4dmbwrgQEFjmEqOIJz6Ad9hhOw00MV8xJ2cpYfUV2G3qkb7a1cNotFuLDbBz/VYxZQUqHMahUDVToMIWb9Vr9rPhDj6VhjX3Cg5TvAkwf1br2eB7XCiN6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgqc3Aef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E21BC4CEE2;
	Wed, 12 Feb 2025 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739387078;
	bh=OOx91OK90dBRzK1Krx+aCkg7brqwTQNNnN1ifpDFkwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wgqc3AefJ6GQpgnVfObQYbREigvGnooP4V4M5beZZpqaleWg+4YRlOBZUemKGdzcH
	 z+9jco/lZOepuJWB7Gyd2H1gSi8e46PIyw4gKaDoUrjMcxtQq0rkPqnQpT7hb3v8I0
	 taPqn/Go4iSpE8QO4ABMLQJhJa3BtlRzO1XZDg0kmA6lleiHhziFFnbWLsxWe26TWD
	 S00t3eSQ0KTQTx4Kuvi7Omyfw8EdimvpQgis2LxjFGQaskQzN/Hy1xap4NV/JFIp4c
	 LrpDoMi+Y8aeZN5C26iNN6BOa6vZuslLa1/fofcPgMPtFlSbF7NIBkVer8Oacrmr4I
	 bplpqt7DlGkAw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b8a0c095cfso49432fac.0;
        Wed, 12 Feb 2025 11:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpfwRVkPsaEfoHa3foOTnAJ4Jl1zf+/NsglzNoDIr+ldAl4R1jFmd25D9ZhfdYXySHrHHoI6Cjp40=@vger.kernel.org, AJvYcCXiSmQjivscKJIbLV1Tf2i1s7fCSMEPBSpJgUXybQbM8cuKMzSZmrJ/UMMmGkjZ8/9q1yjCHc9wFbxB2I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukJE+BzM3SDY1U/66hpxgPjgeh3WVvp113E5jXXHgaG2X8/Zy
	BNMiOdeBFg8b3HsY8AQ+HDMIv4UanMRjp+4ln/RjtMy1SnjDHtxrbIwi3rmaTHjPO/zLEtw5Tyz
	anmIncfqoEwGEfOtRAx83Vwv/HlM=
X-Google-Smtp-Source: AGHT+IF+ySmEYxhRssqrKZFLJhrt6IQeJ1m1tNYYp+CyPGMCWkyfsglMOs56A470FGuz1JDSXWrpeJlF5ds+MF+XV+I=
X-Received: by 2002:a05:6871:6b0a:b0:29e:766d:e969 with SMTP id
 586e51a60fabf-2b8f8b63684mr256623fac.10.1739387077483; Wed, 12 Feb 2025
 11:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
 <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com>
 <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
 <CAPDyKFq91JnCFhEuitOJPZtq78-Y3CUy4p0bNE1wK+eYCste6g@mail.gmail.com> <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com>
In-Reply-To: <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 20:04:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gLDRhWySvoc6eLBTjQ_RdXL4AzOWGZrvUNaj_5ahxJwQ@mail.gmail.com>
X-Gm-Features: AWEUYZmxPnB5kAvg5FASieeEV-M-OFUQSTryDHdieGMNbZeHTalMO8tIdtnr330
Message-ID: <CAJZ5v0gLDRhWySvoc6eLBTjQ_RdXL4AzOWGZrvUNaj_5ahxJwQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 6:05=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Feb 12, 2025 at 4:15=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Wed, 12 Feb 2025 at 12:33, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Wed, Feb 12, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafael@ke=
rnel.org> wrote:
> > > >
> > > > On Wed, Feb 12, 2025 at 10:12=E2=80=AFAM Ulf Hansson <ulf.hansson@l=
inaro.org> wrote:
> > > > >
> > > > > On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
> > > > > >
> > > > > > Hi Everyone,
> > > > > >
> > > > > > This series is a result of the discussion on a recently reporte=
d issue
> > > > > > with device runtime PM status propagation during system resume =
and
> > > > > > the resulting patches:
> > > > > >
> > > > > > https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwysocki.=
net/
> > > > > > https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki.n=
et/
> > > > > >
> > > > > > Overall, due to restrictions related to pm_runtime_force_suspen=
d() and
> > > > > > pm_runtime_force_resume(), it was necessary to limit the RPM_AC=
TIVE
> > > > > > setting propagation to the parent of the first device in a depe=
ndency
> > > > > > chain that turned out to have to be resumed during system resum=
e even
> > > > > > though it was runtime-suspended before system suspend.
> > > > > >
> > > > > > Those restrictions are that (1) pm_runtime_force_suspend() atte=
mpts to
> > > > > > suspend devices that have never had runtime PM enabled if their=
 runtime
> > > > > > PM status is currently RPM_ACTIVE and (2) pm_runtime_force_resu=
me()
> > > > > > will skip device whose runtime PM status is currently RPM_ACTIV=
E.
> > > > > >
> > > > > > The purpose of this series is to eliminate the above restrictio=
ns and
> > > > > > get pm_runtime_force_suspend() and pm_runtime_force_resume() to=
 agree
> > > > > > more with what the core does.
> > > > >
> > > > > For my understanding, would you mind elaborating a bit more aroun=
d the
> > > > > end-goal with this?
> > > >
> > > > The end goal is, of course, full integration of runtime PM with sys=
tem
> > > > sleep for all devices.  Eventually.
> > > >
> > > > And it is necessary to make the core and
> > > > pm_runtime_force_suspend|resume() work together better for this
> > > > purpose.
> > > >
> > > > > Are you trying to make adaptations for
> > > > > pm_runtime_force_suspend|resume() and the PM core, such that driv=
ers
> > > > > that uses pm_runtime_force_suspend|resume() should be able to cop=
e
> > > > > with other drivers for child-devices that make use of
> > > > > DPM_FLAG_SMART_SUSPEND?
> > > >
> > > > Yes.
> > > >
> > > > This is a more general case, though, when a device that was
> > > > runtime-suspended before system suspend and is left in suspend duri=
ng
> > > > it, needs to be resumed during the system resume that follows.
> > > >
> > > > Currently, DPM_FLAG_SMART_SUSPEND can lead to this sometimes and it
> > > > cannot happen otherwise, but I think that it is a generally valid
> > > > case.
> > > >
> > > > > If we can make this work, it would enable the propagation of
> > > > > RPM_ACTIVE in the PM core for more devices, but still not for all=
,
> > > > > right?
> > > >
> > > > It is all until there is a known case in which it isn't.  So either
> > > > you know a specific case in which it doesn't work, or I don't see a
> > > > reason for avoiding it.
> > > >
> > > > ATM the only specific case in which it doesn't work is when
> > > > pm_runtime_force_suspend|resume() are used.
> > > >
> > > > > The point is, the other bigger issue that I pointed out in our ea=
rlier
> > > > > discussions; all those devices where their drivers/buses don't co=
pe
> > > > > with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will preve=
nt
> > > > > the PM core from *unconditionally* propagating the RPM_ACTIVE to
> > > > > parents. I guess this is the best we can do then?
> > > >
> > > > OK, what are they?
> > > >
> > > > You keep saying that they exist without giving any examples.
> > >
> > > To put it more bluntly, I'm not aware of any place other than
> > > pm_runtime_force_suspend|resume() that can be confused by changing th=
e
> > > runtime PM status of a device with runtime PM disabled (either
> > > permanently, or transiently during a system suspend-resume cycle) to
> > > RPM_ACTIVE, so if there are any such places, I would appreciate
> > > letting me know what they are.
> >
> > Well, sorry I thought you were aware. Anyway, I believe you need to do
> > your own investigation as it's simply too time consuming for me to
> > find them all. The problem is that it's not just a simple pattern to
> > search for, so we would need some clever scripting to move forward to
> > find them.
> >
> > To start with, we should look for drivers that enable runtime PM, by
> > calling pm_runtime_enable().
> >
> > Additionally, in their system suspend callback they should typically
> > *not* use pm_runtime_suspended(), pm_runtime_status_suspended() or
> > pm_runtime_active() as that is usually (but no always) indicating that
> > they got it right. Then there are those that don't have system
> > suspend/resume callbacks assigned at all (or uses some other subsystem
> > specific callback for this), but only uses runtime PM.
> >
> > On top of that, drivers that makes use of
> > pm_runtime_force_suspend|resume() should be disregarded, which has
> > reached beyond 300 as this point.
> >
> > Anyway, here is just one example that I found from a quick search.
> > drivers/i2c/busses/i2c-qcom-geni.c
>
> OK, I see.
>
> It sets the status to RPM_SUSPENDED in geni_i2c_suspend_noirq(), if
> not suspended already, and assumes it to stay this way across
> geni_i2c_resume_noirq() until someone resumes it via runtime PM.
>
> Fair enough, but somebody should tell them that they don't need to use
> pm_runtime_disable/enable() in _noirq.
>
> > >
> > > Note that rpm_active() could start producing confusing results if the
> > > runtime PM status of a device with runtime PM disabled is changed fro=
m
> > > RPM_ACTIVE to RPM_SUSPENDED because it will then start to return
> > > -EACCES instead of 1, but changing the status to RPM_ACTIVE will not
> > > confuse it the same way.
> >
> > Trust me, it will cause problems.
> >
> > Drivers may call pm_runtime_get_sync() to turn on the resources for
> > the device after the system has resumed, when runtime PM has been
> > re-enabled for the device by the PM core.
> >
> > Those calls to pm_runtime_get_sync() will then not end up invoking any
> > if ->runtime_resume() callbacks for the device since its state is
> > already RPM_ACTIVE. Hence, the device will remain in a low power state
> > even if the driver believes it has been powered on. In many cases,
> > accessing the device (like reading/writing a register) will often just
> > just hang in these cases, but in worst cases we could end up getting
> > even more difficult bugs to debug.
>
> Sure, that would be a problem.

We may be making a logical mistake here by assuming that any of these
devices will end up in dependency chains starting at the devices that
I'm concerned about.

> I think I need to find a different way to address the problem I'm
> seeing, that is to resume devices that were runtime-suspended before
> system suspend along with their superiors.

Well, maybe not.

So the "smart suspend" thing can be done only if all of the devices
above the given one in the dependency graph (including the parent,
suppliers etc) either opt in for "smart suspend" or are devices
without PM callbacks and the dependency graphs can be cut at devices
that don't support runtime PM.  This would require another flag in
struct dev_pm_info for the tracking of dependencies, but it should be
entirely doable because all of them are known at the device_prepare()
time.

That should avoid involving anyone who can be surprised.

