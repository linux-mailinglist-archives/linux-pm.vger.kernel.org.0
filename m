Return-Path: <linux-pm+bounces-22034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C09EA34F9B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 21:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14837169EC0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C52661A8;
	Thu, 13 Feb 2025 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY9EpC9O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4586221720;
	Thu, 13 Feb 2025 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479372; cv=none; b=RBEFZEpf2jpXEMmSNHj9tw29KDKINpZdwZFM1wmzcwqJdTPWCkL4UZccE0DRSLpU3TfC6PSixQoZlGVB14oXMS/sHDyNHo+Oe6d9QPx4CLoWWf4g39eNb9a7PIKvHti7tS/6DA2cmbt+rMnPYHaU8wz7vONoMtf3JeIRU7Byzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479372; c=relaxed/simple;
	bh=u4Cb1Mm78P3ZVkhMRAoV68PKQ06OET2BeKatkr9yuU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoCWSsvtLi+Py2ABM2kbcl3tYauSg9g11R44QPg6LQ6Qq9JLAdK8Jy3i2JVvujdEMn+k+83cj+w6VMHTwZEV7C0MKFf8SEAZwox8pyVbb2c4eTdGR1yV86Ikmzs6ZgbE1tVb0O0d3Q1N0pYfJ6XDnuBpo5UTPEmsOgzOQh8ZssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY9EpC9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D6C4CEE5;
	Thu, 13 Feb 2025 20:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739479372;
	bh=u4Cb1Mm78P3ZVkhMRAoV68PKQ06OET2BeKatkr9yuU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dY9EpC9OIV0no2NcOAtrxCoFUktccAkFTVsWXrkZuinkw2kyrgKBlqsdogAZrqeCE
	 FDY5zA5dr18/PzYDeqQeIHxfEIQ1cpAE6D3KtFEWlFwZZj9iQv3n0ui/W48U2b/3Fl
	 iaFc7sZbxBwPItKaVSpdrdE2VQLm59BDjQTRhEv1HtO99a/lPHSrXzgqMcLSvayikp
	 qb/FILqzdks1gGe3g6Fya3aFn4kDiPxmiCVle8D7F2ooQy+e8hd+D8StgR7I0FRoo3
	 2JcMJ+Bcd/0/Y77GQSKcT4fvy5R4EWAx24qJnOEy4amGKySWSY8YkJYTEXY1+msQ78
	 bohqklTZEv4Nw==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-724d1724657so1383184a34.0;
        Thu, 13 Feb 2025 12:42:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtj5LWeG21+F/3nAVf8ZjzUs44EkJ6k7zqQRU28Lwac9XTu6lu/o/WYvGBnEshnvQPUwV+pMU7Tl2YQ/o=@vger.kernel.org, AJvYcCWrzZx1WNRNF1f5LIGIppYWShcLw4akBina8A385OwEScLT7aHzfRRPb8o5zlf4cB+uM7dqdSM2AKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzF7+ph+RsbzaSeYxHd3PP4MFX04nzUXwagZW05O5UDjOVMjXI
	IUXYI39uXBtKo96/mUWHeui/S4pxsH7OZDeh48OQwP9+SaN8gD1fjY6wgrZHCrntIseloKCeJe5
	qVqt+KIh7VF/jZ22YQWUsS1q8xME=
X-Google-Smtp-Source: AGHT+IGSpgJ6Bpl2rN6eFYhR1HS3TnJH0PC87GoxWC/7ZiYe+R+1Aotg5EJrmLYWcYUQoNijd0r2mNM1zZfrY9NT9YI=
X-Received: by 2002:a05:6808:1794:b0:3f3:beb4:49ec with SMTP id
 5614622812f47-3f3d925f6d7mr2923278b6e.7.1739479371267; Thu, 13 Feb 2025
 12:42:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
 <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com>
 <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
 <CAPDyKFq91JnCFhEuitOJPZtq78-Y3CUy4p0bNE1wK+eYCste6g@mail.gmail.com>
 <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com>
 <CAJZ5v0gLDRhWySvoc6eLBTjQ_RdXL4AzOWGZrvUNaj_5ahxJwQ@mail.gmail.com> <CAPDyKFqYzv-5O3k51W4rG=Qm4T3Uu0CcP2taMTYGrGXBj1pYUA@mail.gmail.com>
In-Reply-To: <CAPDyKFqYzv-5O3k51W4rG=Qm4T3Uu0CcP2taMTYGrGXBj1pYUA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Feb 2025 21:42:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gsq5XDW8CW2My60Fn94F8h4XBFFUhKb19LcCwXLWvEfg@mail.gmail.com>
X-Gm-Features: AWEUYZlCdhi7Bh1riX3LX640whouX3fCqpy06Brya6nod8jT1iSJMqKaIN9LlFE
Message-ID: <CAJZ5v0gsq5XDW8CW2My60Fn94F8h4XBFFUhKb19LcCwXLWvEfg@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:38=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 12 Feb 2025 at 20:04, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Wed, Feb 12, 2025 at 6:05=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Wed, Feb 12, 2025 at 4:15=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Wed, 12 Feb 2025 at 12:33, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > On Wed, Feb 12, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafae=
l@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Feb 12, 2025 at 10:12=E2=80=AFAM Ulf Hansson <ulf.hanss=
on@linaro.org> wrote:
> > > > > > >
> > > > > > > On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwysock=
i.net> wrote:
> > > > > > > >
> > > > > > > > Hi Everyone,
> > > > > > > >
> > > > > > > > This series is a result of the discussion on a recently rep=
orted issue
> > > > > > > > with device runtime PM status propagation during system res=
ume and
> > > > > > > > the resulting patches:
> > > > > > > >
> > > > > > > > https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwyso=
cki.net/
> > > > > > > > https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysoc=
ki.net/
> > > > > > > >
> > > > > > > > Overall, due to restrictions related to pm_runtime_force_su=
spend() and
> > > > > > > > pm_runtime_force_resume(), it was necessary to limit the RP=
M_ACTIVE
> > > > > > > > setting propagation to the parent of the first device in a =
dependency
> > > > > > > > chain that turned out to have to be resumed during system r=
esume even
> > > > > > > > though it was runtime-suspended before system suspend.
> > > > > > > >
> > > > > > > > Those restrictions are that (1) pm_runtime_force_suspend() =
attempts to
> > > > > > > > suspend devices that have never had runtime PM enabled if t=
heir runtime
> > > > > > > > PM status is currently RPM_ACTIVE and (2) pm_runtime_force_=
resume()
> > > > > > > > will skip device whose runtime PM status is currently RPM_A=
CTIVE.
> > > > > > > >
> > > > > > > > The purpose of this series is to eliminate the above restri=
ctions and
> > > > > > > > get pm_runtime_force_suspend() and pm_runtime_force_resume(=
) to agree
> > > > > > > > more with what the core does.
> > > > > > >
> > > > > > > For my understanding, would you mind elaborating a bit more a=
round the
> > > > > > > end-goal with this?
> > > > > >
> > > > > > The end goal is, of course, full integration of runtime PM with=
 system
> > > > > > sleep for all devices.  Eventually.
> > > > > >
> > > > > > And it is necessary to make the core and
> > > > > > pm_runtime_force_suspend|resume() work together better for this
> > > > > > purpose.
> > > > > >
> > > > > > > Are you trying to make adaptations for
> > > > > > > pm_runtime_force_suspend|resume() and the PM core, such that =
drivers
> > > > > > > that uses pm_runtime_force_suspend|resume() should be able to=
 cope
> > > > > > > with other drivers for child-devices that make use of
> > > > > > > DPM_FLAG_SMART_SUSPEND?
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > This is a more general case, though, when a device that was
> > > > > > runtime-suspended before system suspend and is left in suspend =
during
> > > > > > it, needs to be resumed during the system resume that follows.
> > > > > >
> > > > > > Currently, DPM_FLAG_SMART_SUSPEND can lead to this sometimes an=
d it
> > > > > > cannot happen otherwise, but I think that it is a generally val=
id
> > > > > > case.
> > > > > >
> > > > > > > If we can make this work, it would enable the propagation of
> > > > > > > RPM_ACTIVE in the PM core for more devices, but still not for=
 all,
> > > > > > > right?
> > > > > >
> > > > > > It is all until there is a known case in which it isn't.  So ei=
ther
> > > > > > you know a specific case in which it doesn't work, or I don't s=
ee a
> > > > > > reason for avoiding it.
> > > > > >
> > > > > > ATM the only specific case in which it doesn't work is when
> > > > > > pm_runtime_force_suspend|resume() are used.
> > > > > >
> > > > > > > The point is, the other bigger issue that I pointed out in ou=
r earlier
> > > > > > > discussions; all those devices where their drivers/buses don'=
t cope
> > > > > > > with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will p=
revent
> > > > > > > the PM core from *unconditionally* propagating the RPM_ACTIVE=
 to
> > > > > > > parents. I guess this is the best we can do then?
> > > > > >
> > > > > > OK, what are they?
> > > > > >
> > > > > > You keep saying that they exist without giving any examples.
> > > > >
> > > > > To put it more bluntly, I'm not aware of any place other than
> > > > > pm_runtime_force_suspend|resume() that can be confused by changin=
g the
> > > > > runtime PM status of a device with runtime PM disabled (either
> > > > > permanently, or transiently during a system suspend-resume cycle)=
 to
> > > > > RPM_ACTIVE, so if there are any such places, I would appreciate
> > > > > letting me know what they are.
> > > >
> > > > Well, sorry I thought you were aware. Anyway, I believe you need to=
 do
> > > > your own investigation as it's simply too time consuming for me to
> > > > find them all. The problem is that it's not just a simple pattern t=
o
> > > > search for, so we would need some clever scripting to move forward =
to
> > > > find them.
> > > >
> > > > To start with, we should look for drivers that enable runtime PM, b=
y
> > > > calling pm_runtime_enable().
> > > >
> > > > Additionally, in their system suspend callback they should typicall=
y
> > > > *not* use pm_runtime_suspended(), pm_runtime_status_suspended() or
> > > > pm_runtime_active() as that is usually (but no always) indicating t=
hat
> > > > they got it right. Then there are those that don't have system
> > > > suspend/resume callbacks assigned at all (or uses some other subsys=
tem
> > > > specific callback for this), but only uses runtime PM.
> > > >
> > > > On top of that, drivers that makes use of
> > > > pm_runtime_force_suspend|resume() should be disregarded, which has
> > > > reached beyond 300 as this point.
> > > >
> > > > Anyway, here is just one example that I found from a quick search.
> > > > drivers/i2c/busses/i2c-qcom-geni.c
> > >
> > > OK, I see.
> > >
> > > It sets the status to RPM_SUSPENDED in geni_i2c_suspend_noirq(), if
> > > not suspended already, and assumes it to stay this way across
> > > geni_i2c_resume_noirq() until someone resumes it via runtime PM.
> > >
> > > Fair enough, but somebody should tell them that they don't need to us=
e
> > > pm_runtime_disable/enable() in _noirq.

BTW, I'm wondering how this driver handles the case in which someone
runs pm_runtime_get*() on its device and doesn't release the reference
throughout a system suspend-resume cycle, which is a valid thing to do
albeit unusual.

> > > > >
> > > > > Note that rpm_active() could start producing confusing results if=
 the
> > > > > runtime PM status of a device with runtime PM disabled is changed=
 from
> > > > > RPM_ACTIVE to RPM_SUSPENDED because it will then start to return
> > > > > -EACCES instead of 1, but changing the status to RPM_ACTIVE will =
not
> > > > > confuse it the same way.
> > > >
> > > > Trust me, it will cause problems.
> > > >
> > > > Drivers may call pm_runtime_get_sync() to turn on the resources for
> > > > the device after the system has resumed, when runtime PM has been
> > > > re-enabled for the device by the PM core.
> > > >
> > > > Those calls to pm_runtime_get_sync() will then not end up invoking =
any
> > > > if ->runtime_resume() callbacks for the device since its state is
> > > > already RPM_ACTIVE. Hence, the device will remain in a low power st=
ate
> > > > even if the driver believes it has been powered on. In many cases,
> > > > accessing the device (like reading/writing a register) will often j=
ust
> > > > just hang in these cases, but in worst cases we could end up gettin=
g
> > > > even more difficult bugs to debug.
> > >
> > > Sure, that would be a problem.
> >
> > We may be making a logical mistake here by assuming that any of these
> > devices will end up in dependency chains starting at the devices that
> > I'm concerned about.
> >
> > > I think I need to find a different way to address the problem I'm
> > > seeing, that is to resume devices that were runtime-suspended before
> > > system suspend along with their superiors.
> >
> > Well, maybe not.
> >
> > So the "smart suspend" thing can be done only if all of the devices
> > above the given one in the dependency graph (including the parent,
> > suppliers etc) either opt in for "smart suspend" or are devices
> > without PM callbacks and the dependency graphs can be cut at devices
> > that don't support runtime PM.  This would require another flag in
> > struct dev_pm_info for the tracking of dependencies, but it should be
> > entirely doable because all of them are known at the device_prepare()
> > time.
> >
> > That should avoid involving anyone who can be surprised.
>
> This would be an improvement, while it is questionable for how
> valuable this would be in the end. As soon as there is a
> parent/supplier that has PM callbacks, we would need to prevent the
> propagation.

One without "smart suspend" that is.  Yes.

For the current users of DPM_FLAG_SMART_SUSPEND this shouldn't
actually matter because it is the case already AFAICS, so I'm not
worried about this.

> I am also a bit worried about adding more corner cases to
> the PM core, as it's not entirely easy to understand them, I think.

That is always a valid concern, but sometimes there is no other way to
make progress.

> That said, maybe it's the best we can do.

