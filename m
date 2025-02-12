Return-Path: <linux-pm+bounces-21959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F1EA3251B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 12:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3820118887C6
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAFB2080F4;
	Wed, 12 Feb 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQx79RXw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FA271839;
	Wed, 12 Feb 2025 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360178; cv=none; b=rxlbkuigUrBGY9+lczP2Tm0mf0DJsmNZnsI3olYLMOI5VKbPx2TQs32OxgX5RQm3W5tQ8Zv23nmCVvEteaJijaFL36isLXjxG5N0LnJJ+ejIBsfeFD54M2JqPqBT78d0m/360xkIcw7F3YlusTHrmbxZeem8mD2Rxcughyhh3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360178; c=relaxed/simple;
	bh=ZKcrOI3pERy8yLojpesKO2x+RRP0k270Ljik5yZpI8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBKfTZjInO6ea1mEadnIIhrF4zoyAmjfeVXHiEiiw+oFts+X4To/8yu1uFF4GzWt0pa44h1ocsB0fB6UV1KSSryUdtgCDXuDN4nOYDXVSX/gE4AcaGqmkc1fFRXdGHb3EQuQg5jXmUIadPUir0lEO3fTloXVhlRMIn3JWd38FPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQx79RXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA3EC4CEE7;
	Wed, 12 Feb 2025 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739360176;
	bh=ZKcrOI3pERy8yLojpesKO2x+RRP0k270Ljik5yZpI8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aQx79RXwnm1GX3W7ud0guEKhqNsycg4bU3ukitowEOgM/j0Z5gVdAWGZW27DSMRlH
	 KhQEqb2W4UFC3b5CYazYnm3oVqRRqSCWgCruqqV0AKXIfp4lFgfJvCWyequhRhWAER
	 CjLUfZcX24WTAzW8l6FXmAVOfxLAVaisYSQPJVkgz0ipTXx8RC0K9oaEZ67wcHi638
	 PEXBpamL4Pj5/Q3ORk2aT9gp0ywbRZSQuk8qYrvdsCi30yuIRMemjM4DQBrDdyGboS
	 A03yqh5l0dvcrFov6oEy+xW3Qg0OKO6/ycu4DfWVyB8vBWzSdEpDzZb4GGbGYXQVgG
	 cEsSIYI5/MGZg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f3ace3d30eso2125024b6e.3;
        Wed, 12 Feb 2025 03:36:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWAck1rzvii1fr8B8gp6Xknqkw8s997XFcyOVoVjLRSYoXZh4smffidDq8zxOkG8x7I6JptAANyUE=@vger.kernel.org, AJvYcCVZuoVVXN3F6xEcm4q8HKXVaFPPICyhDGEldT7vuOw3ukxlDL6lQSA6WAl99vCbdNQbpGr4Jwo2t6Zotgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuIR98k8qvsAyScXYnyveG5c1R5JoKq9p6k3wUAlE8dSEVRfe
	Fmlu6nklTxcIhEVatGGN1Khq4n3hBIrJdXRlheyP8wzVLbgCfIEYQnYdWqVImCyj95Mp9ywAACy
	Dymuq1oRYHDbLrGz89C5dAdkkgSg=
X-Google-Smtp-Source: AGHT+IHXcllIU2kCynwCKypDZbzpoD5UByuvz2E1U8a8Fw+1m8SwUM0Js0NLAQLNHsU6S+W9lTnHA3x6rbNSyik5WC4=
X-Received: by 2002:a05:6870:3311:b0:29e:7a09:d92a with SMTP id
 586e51a60fabf-2b8d646fcd3mr1928904fac.5.1739360176085; Wed, 12 Feb 2025
 03:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
 <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com> <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 12:36:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hs7brJ_kDm6zTUzjn8pK1BVZZFW9H2AfVx4DwTd8Mh_A@mail.gmail.com>
X-Gm-Features: AWEUYZkPXAN4988wP0qKkO9TOednRR3mfRJLrkpgoKs2VDWi28CpuD3FwYUjkXA
Message-ID: <CAJZ5v0hs7brJ_kDm6zTUzjn8pK1BVZZFW9H2AfVx4DwTd8Mh_A@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 12:33=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
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
>
> Note that rpm_active() could start producing confusing results if the

rpm_resume() rather, sorry.

> runtime PM status of a device with runtime PM disabled is changed from
> RPM_ACTIVE to RPM_SUSPENDED because it will then start to return
> -EACCES instead of 1, but changing the status to RPM_ACTIVE will not
> confuse it the same way.

