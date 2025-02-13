Return-Path: <linux-pm+bounces-22017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E36F5A34080
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 14:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9150C7A2DB0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D19221721;
	Thu, 13 Feb 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjYEL3uG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19820B80D
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453916; cv=none; b=qQMsgpq84kRMLQ+83Aef7Kkj3R7OA2XcO1169HBnSumIR0sfcZj44ip+NxWJbgvhE+6is/C3n4leQ56u9jLlXlDpDC1HbUa5wu2Nsu6BiUIeJaitBuNvDi+ba2qUnNBjjZJPKWRajIVLGjzQ88dQxMydt08KxuIwvp+BtM9vve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453916; c=relaxed/simple;
	bh=6ihWHeLTXIo3JWrgrTos9tTujT92CEbYIYJ4dUN8r04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFbIhjw3uwDG4rUeLkxjmrMMmeJbrzosNyV/fsolx6I0mEN2rDHPb3Ih23nNXl7ruD0NwcFyQKns5IoIfcO/1xRODvq19CaM6EV8q9RBvQfEVxP/spnaMO/MuNeeaAT1pb/102sIxT54BcMWXFT0RtN+z3NHFrKv1QDQ/4CyKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjYEL3uG; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5b271efc64so791095276.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 05:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739453914; x=1740058714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSIA1g8dCvdQWwHOdRqoCKz8a95Er9ylHMZyQ9jLV7E=;
        b=bjYEL3uGcwRreyJAWSOgm7QBnunxI6wOw2alE+Dp/1Jqw7aLb98/2GjZiG+7ghefE6
         ELKP5f1bzL7y0Qhx3H5bIFXz7b5B5R6/YAYSerPhDyV90a63y4rrdtrxFcDOEQdZ6lz9
         79yu2TD1Q0A+lmXK0sxS0OEiRysxUbg0/hPNk9eYNpZPbKhitMQ5OFPOFzq7G0J8ztPt
         +9dKtaS5nF8VFfMdb1cbStSr1SmQL12MOTySZ+gSH9jBjCD0My0rpHo0O9u9WHLEBaBX
         6zNSriokzrK6eMx43ZUN74LL9Qhxfk3uRQEul1Yrtq9Ed2kNFH3njnNbwBC0L9CvkmY0
         qM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739453914; x=1740058714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSIA1g8dCvdQWwHOdRqoCKz8a95Er9ylHMZyQ9jLV7E=;
        b=Ey0naC/Npb404rKMFoU6xkcxQgLLfQkkU12OSoojTmEZeXz8lIaldvMG8UjNy6QqfZ
         /o76r904xFl8nPwz421OnseC9kY09/pBkcN5zUK0HpptHrGOmpMGe4nQYEnKOZc4T7Em
         BGUFanFMChH4pIojK5cYCmKgEBbVlFo6OMbW/zLz1jA5CrVOVDKLubgdaswfCrZ8gr91
         L+9hRLz46q8eg8xdxgRRj0WO3VIZBKotASs67DXO5XMVzZHmMw3WXX+D9LNUt1RWGgQh
         22nI1VjdFHx62HEomgkTBcVwHP6wYW1temhk2eACue4TNA8/LxNYzkuSEAaCTply5rnx
         Kx+g==
X-Forwarded-Encrypted: i=1; AJvYcCXu20vG3Rdm6qWqTBXloniT49zomL3z/yAFM81GHl1HHdm1nd6Oe8JfifwkE7E190qxoYTH/rFZSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEb9MSWdvQSzYJrPsR6wY270K8AFI+bmAnhYhsTwaFj4R/+sf7
	e5u4M4ciSPWHAMiAqBFJhrkLqKvUrpPq9vTJwKXY1HbLccDgBqySPH6yOSvJVW6yBBnTcU1TC09
	1boDYnBHf3GrN0jygTiyyKQbzUxIbyYnRQFlPLg==
X-Gm-Gg: ASbGncv7MXRuD0lJ8EAIDBiHWK8COBCGtY8R6gfMBcWsNDNxD2CNVfEB4FviZcYNJIP
	gNUSaF18pUNpfgUIJlqDNX20pjQEJdehoBDonDY89/JEd88DmdPAQnRLsRnASZ2jmIxrKiB/itg
	==
X-Google-Smtp-Source: AGHT+IES4jC6u8cVgly3oXZNikm6zVqPJSCWWJ4Fv7cbxlVl5CnHgf0XyRsqDmh6GzFMCOQ42GsT8Xk1YkvyPkpqBYA=
X-Received: by 2002:a05:6902:f10:b0:e5d:b542:f646 with SMTP id
 3f1490d57ef6-e5db542f992mr588160276.32.1739453913837; Thu, 13 Feb 2025
 05:38:33 -0800 (PST)
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
 <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com> <CAJZ5v0gLDRhWySvoc6eLBTjQ_RdXL4AzOWGZrvUNaj_5ahxJwQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gLDRhWySvoc6eLBTjQ_RdXL4AzOWGZrvUNaj_5ahxJwQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 13 Feb 2025 14:37:58 +0100
X-Gm-Features: AWEUYZk-W0hGa-gArD8WMGumRN_KUIYsXfodIIMGK87bmLdYGZghydBiEOAegb0
Message-ID: <CAPDyKFqYzv-5O3k51W4rG=Qm4T3Uu0CcP2taMTYGrGXBj1pYUA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Feb 2025 at 20:04, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 12, 2025 at 6:05=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Wed, Feb 12, 2025 at 4:15=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Wed, 12 Feb 2025 at 12:33, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Wed, Feb 12, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafael@=
kernel.org> wrote:
> > > > >
> > > > > On Wed, Feb 12, 2025 at 10:12=E2=80=AFAM Ulf Hansson <ulf.hansson=
@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> > > > > > >
> > > > > > > Hi Everyone,
> > > > > > >
> > > > > > > This series is a result of the discussion on a recently repor=
ted issue
> > > > > > > with device runtime PM status propagation during system resum=
e and
> > > > > > > the resulting patches:
> > > > > > >
> > > > > > > https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwysock=
i.net/
> > > > > > > https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki=
.net/
> > > > > > >
> > > > > > > Overall, due to restrictions related to pm_runtime_force_susp=
end() and
> > > > > > > pm_runtime_force_resume(), it was necessary to limit the RPM_=
ACTIVE
> > > > > > > setting propagation to the parent of the first device in a de=
pendency
> > > > > > > chain that turned out to have to be resumed during system res=
ume even
> > > > > > > though it was runtime-suspended before system suspend.
> > > > > > >
> > > > > > > Those restrictions are that (1) pm_runtime_force_suspend() at=
tempts to
> > > > > > > suspend devices that have never had runtime PM enabled if the=
ir runtime
> > > > > > > PM status is currently RPM_ACTIVE and (2) pm_runtime_force_re=
sume()
> > > > > > > will skip device whose runtime PM status is currently RPM_ACT=
IVE.
> > > > > > >
> > > > > > > The purpose of this series is to eliminate the above restrict=
ions and
> > > > > > > get pm_runtime_force_suspend() and pm_runtime_force_resume() =
to agree
> > > > > > > more with what the core does.
> > > > > >
> > > > > > For my understanding, would you mind elaborating a bit more aro=
und the
> > > > > > end-goal with this?
> > > > >
> > > > > The end goal is, of course, full integration of runtime PM with s=
ystem
> > > > > sleep for all devices.  Eventually.
> > > > >
> > > > > And it is necessary to make the core and
> > > > > pm_runtime_force_suspend|resume() work together better for this
> > > > > purpose.
> > > > >
> > > > > > Are you trying to make adaptations for
> > > > > > pm_runtime_force_suspend|resume() and the PM core, such that dr=
ivers
> > > > > > that uses pm_runtime_force_suspend|resume() should be able to c=
ope
> > > > > > with other drivers for child-devices that make use of
> > > > > > DPM_FLAG_SMART_SUSPEND?
> > > > >
> > > > > Yes.
> > > > >
> > > > > This is a more general case, though, when a device that was
> > > > > runtime-suspended before system suspend and is left in suspend du=
ring
> > > > > it, needs to be resumed during the system resume that follows.
> > > > >
> > > > > Currently, DPM_FLAG_SMART_SUSPEND can lead to this sometimes and =
it
> > > > > cannot happen otherwise, but I think that it is a generally valid
> > > > > case.
> > > > >
> > > > > > If we can make this work, it would enable the propagation of
> > > > > > RPM_ACTIVE in the PM core for more devices, but still not for a=
ll,
> > > > > > right?
> > > > >
> > > > > It is all until there is a known case in which it isn't.  So eith=
er
> > > > > you know a specific case in which it doesn't work, or I don't see=
 a
> > > > > reason for avoiding it.
> > > > >
> > > > > ATM the only specific case in which it doesn't work is when
> > > > > pm_runtime_force_suspend|resume() are used.
> > > > >
> > > > > > The point is, the other bigger issue that I pointed out in our =
earlier
> > > > > > discussions; all those devices where their drivers/buses don't =
cope
> > > > > > with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will pre=
vent
> > > > > > the PM core from *unconditionally* propagating the RPM_ACTIVE t=
o
> > > > > > parents. I guess this is the best we can do then?
> > > > >
> > > > > OK, what are they?
> > > > >
> > > > > You keep saying that they exist without giving any examples.
> > > >
> > > > To put it more bluntly, I'm not aware of any place other than
> > > > pm_runtime_force_suspend|resume() that can be confused by changing =
the
> > > > runtime PM status of a device with runtime PM disabled (either
> > > > permanently, or transiently during a system suspend-resume cycle) t=
o
> > > > RPM_ACTIVE, so if there are any such places, I would appreciate
> > > > letting me know what they are.
> > >
> > > Well, sorry I thought you were aware. Anyway, I believe you need to d=
o
> > > your own investigation as it's simply too time consuming for me to
> > > find them all. The problem is that it's not just a simple pattern to
> > > search for, so we would need some clever scripting to move forward to
> > > find them.
> > >
> > > To start with, we should look for drivers that enable runtime PM, by
> > > calling pm_runtime_enable().
> > >
> > > Additionally, in their system suspend callback they should typically
> > > *not* use pm_runtime_suspended(), pm_runtime_status_suspended() or
> > > pm_runtime_active() as that is usually (but no always) indicating tha=
t
> > > they got it right. Then there are those that don't have system
> > > suspend/resume callbacks assigned at all (or uses some other subsyste=
m
> > > specific callback for this), but only uses runtime PM.
> > >
> > > On top of that, drivers that makes use of
> > > pm_runtime_force_suspend|resume() should be disregarded, which has
> > > reached beyond 300 as this point.
> > >
> > > Anyway, here is just one example that I found from a quick search.
> > > drivers/i2c/busses/i2c-qcom-geni.c
> >
> > OK, I see.
> >
> > It sets the status to RPM_SUSPENDED in geni_i2c_suspend_noirq(), if
> > not suspended already, and assumes it to stay this way across
> > geni_i2c_resume_noirq() until someone resumes it via runtime PM.
> >
> > Fair enough, but somebody should tell them that they don't need to use
> > pm_runtime_disable/enable() in _noirq.
> >
> > > >
> > > > Note that rpm_active() could start producing confusing results if t=
he
> > > > runtime PM status of a device with runtime PM disabled is changed f=
rom
> > > > RPM_ACTIVE to RPM_SUSPENDED because it will then start to return
> > > > -EACCES instead of 1, but changing the status to RPM_ACTIVE will no=
t
> > > > confuse it the same way.
> > >
> > > Trust me, it will cause problems.
> > >
> > > Drivers may call pm_runtime_get_sync() to turn on the resources for
> > > the device after the system has resumed, when runtime PM has been
> > > re-enabled for the device by the PM core.
> > >
> > > Those calls to pm_runtime_get_sync() will then not end up invoking an=
y
> > > if ->runtime_resume() callbacks for the device since its state is
> > > already RPM_ACTIVE. Hence, the device will remain in a low power stat=
e
> > > even if the driver believes it has been powered on. In many cases,
> > > accessing the device (like reading/writing a register) will often jus=
t
> > > just hang in these cases, but in worst cases we could end up getting
> > > even more difficult bugs to debug.
> >
> > Sure, that would be a problem.
>
> We may be making a logical mistake here by assuming that any of these
> devices will end up in dependency chains starting at the devices that
> I'm concerned about.
>
> > I think I need to find a different way to address the problem I'm
> > seeing, that is to resume devices that were runtime-suspended before
> > system suspend along with their superiors.
>
> Well, maybe not.
>
> So the "smart suspend" thing can be done only if all of the devices
> above the given one in the dependency graph (including the parent,
> suppliers etc) either opt in for "smart suspend" or are devices
> without PM callbacks and the dependency graphs can be cut at devices
> that don't support runtime PM.  This would require another flag in
> struct dev_pm_info for the tracking of dependencies, but it should be
> entirely doable because all of them are known at the device_prepare()
> time.
>
> That should avoid involving anyone who can be surprised.

This would be an improvement, while it is questionable for how
valuable this would be in the end. As soon as there is a
parent/supplier that has PM callbacks, we would need to prevent the
propagation. I am also a bit worried about adding more corner cases to
the PM core, as it's not entirely easy to understand them, I think.

That said, maybe it's the best we can do.

Kind regards
Uffe

