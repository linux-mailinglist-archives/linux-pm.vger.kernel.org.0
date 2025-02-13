Return-Path: <linux-pm+bounces-22030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD3A34F3E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 21:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E369316DE36
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB2624BBEB;
	Thu, 13 Feb 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITrpU8iZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC42222DE;
	Thu, 13 Feb 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477849; cv=none; b=uu8bkbVHwXIpXFx7g6DM06+lH3ompQG9dcg8Is3CqC8CYBaBFe5WwS5ElOuTaM6Wp1Xpbtc1TYZVZswYD0f02fY8oV4kvD1tSbsuEYcxvvLPWbbXJE8Cg8Qv4o+ykmBRyxwxjzdt+So7wFugDaufVXi65cM1bx9IApzYIBrShTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477849; c=relaxed/simple;
	bh=u1/pjBD78ks+e5DlEUW1+q3dqkqV5ltRTCBwprBGbEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stG7Q55CdVvpwTYWWn1mqEBnwKnFluwwS6oKgPFEtp/ldqKyCLsQGJvwf+0RqMfs+XRPzUNrM33LH4/hJh+HIma4Scdito/bSwvTF1fFPcRITG9exQgGMrlXnry4ssu32/D7LWmIu+Z0B81cZ8Zg8gwiptNC0MPc4DOgayq71e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITrpU8iZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBB5C4CEE6;
	Thu, 13 Feb 2025 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739477848;
	bh=u1/pjBD78ks+e5DlEUW1+q3dqkqV5ltRTCBwprBGbEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ITrpU8iZEaje4R9staun7IiFjZ/98AApN/QGwgWHnYqLD/MDnbE411+EnrWAwU9lY
	 KnFAOzikLM5A9Cjx3uGRJg+reukCbFNNVl6HtELMBzZaxZ/s6SHv68DaVV/LhpthQH
	 TT+tBCpYhJ+AFkGSSZdhqLDoXBAdGg5k2HYIyYyjGrE4JOOcjA7cQKzLXTmuEZTneA
	 v0QxqY8PXWwJ3PiGmkoKCP8NnUCRc7FEDG/BXDhFgI18IK/Q4SByRqEn8Fw2YOlKpx
	 Yv8enAZDC4JafK4nKYR9LAaxNACMDA1IKIhLcUadAMEa6ZS0vIRDgXZlQCq84sSUeE
	 nxEHvR9dhPfgA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2bc56e74e75so424855fac.3;
        Thu, 13 Feb 2025 12:17:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWStQcN3coHrNbUgLFkjHu5MQo8g4o8ZIahwYSKF0uj9yrtt0BXS7xJaU0mby5KJ9ix1hcNRuWBDfQ=@vger.kernel.org, AJvYcCWs6yqXZvfnjjClFLjTWMKkt7RHpWDn9cXEVrJlDVSBVPc0Q748TA4wkqwrF2cD4W2POWf5jTZJat832BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUehVka3nyRiZRErJ4RC6dj8JgEZ/Y8toHot70R4qgXW1LME6N
	w4XLM1pRYaW90K01zdUA4RysXhqYOwfJATE0PGgQmC/2tux8UUz+k94SAhdKNlX84rra3LrNMBs
	ZfLGNRRcALjF/yFnEbZ3s4uJwb2A=
X-Google-Smtp-Source: AGHT+IFwRa7iwgsTaQLB+s0mwRzHaC+sJbA/387QAm/CH9HPmuf8wfWCLi12p75mdP3BDt0tG7rvgY0B47xpQyVVB+s=
X-Received: by 2002:a05:6870:1711:b0:297:2719:deb6 with SMTP id
 586e51a60fabf-2b8f8c0d454mr2645187fac.1.1739477847889; Thu, 13 Feb 2025
 12:17:27 -0800 (PST)
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
 <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com> <CAPDyKFr1LmYji1Yh=mrx03eeW8ukFr9rE0hk277iam174TjGig@mail.gmail.com>
In-Reply-To: <CAPDyKFr1LmYji1Yh=mrx03eeW8ukFr9rE0hk277iam174TjGig@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Feb 2025 21:17:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hsEg7eFRg2Q2sbn0DkUoBu0F08B+0yVGAicKyQ91NKuA@mail.gmail.com>
X-Gm-Features: AWEUYZlQ3D2M3Yiw-ePrM5zT-5byoiFaOjjXcdNjvtpGkMH6ORrX8dGhNt_QXPY
Message-ID: <CAJZ5v0hsEg7eFRg2Q2sbn0DkUoBu0F08B+0yVGAicKyQ91NKuA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:11=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 12 Feb 2025 at 18:05, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
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
> >
> > I think I need to find a different way to address the problem I'm
> > seeing, that is to resume devices that were runtime-suspended before
> > system suspend along with their superiors.
> >
> > One way to do it would be to just defer their resume to the point when
> > the core has enabled runtime PM for them, which means that it has also
> > enabled runtime PM for all of their superiors, and then call
> > pm_runtime_resume().
> >
> > This should work unless one of the superiors has runtime PM disabled
> > at that point, of course.
>
> Right, so typically users of pm_runtime_force_suspend|resume() from
> the regular ->suspend|resume() callbacks would not work, because they
> disable/enable runtime PM. Although, we could probably fix this quite
> easily by making some adaptations in
> pm_runtime_force_suspend|resume().
>
> I am not sure if this approach would have any other issue though, but
> it seems like it could make sense to explore this approach. In general
> drivers should cope with their devices being runtime resumed if
> runtime PM is enabled, right!?
>
> If this works, it seems like a generic and a good solution to me.

For PCI ports, though, it would require some tuning of
->runtime_resume(), so it is not as simple as it would seem to be in
the end.

