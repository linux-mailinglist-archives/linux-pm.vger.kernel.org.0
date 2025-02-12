Return-Path: <linux-pm+bounces-21976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED447A32CF8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 18:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BA916A454
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869B725A2D3;
	Wed, 12 Feb 2025 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMZicH/i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E321506D;
	Wed, 12 Feb 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379918; cv=none; b=YRvSqZuulsefkG1LECSOPXEZJlasNYNEk3E7m06MsEC/R0DBabJeu4GjmsU2EWeN2nbO+/agxTuD4LtvNWp0aL0UPqP8/LknotIh93QRigEDiy8U7tO10xvcE0jAr6wjH7ZMNM0dLhhvf9az0cBbMBSXHAkwsqmdzISDz8ztjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379918; c=relaxed/simple;
	bh=OOphGY58A73wzPUp/hoO6eFXEV5qdt7mxWHBLh0zvOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1LJqSBO2I+M3C1x/toUtNtgfRqk9mLU8R9dC9IE0gBalP7JQb2aGu1p0p2Zi72bT13PV0cQRX1s38ZY3AJ79PK5IvqvXTlBHkt6hpXF3KfVfOGxm880AG5lBcWgOcoXRRhM1lnGegerwoW55Ywu6mz7s/EQHRuAL51HW9ON4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMZicH/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC77CC4CEE4;
	Wed, 12 Feb 2025 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379916;
	bh=OOphGY58A73wzPUp/hoO6eFXEV5qdt7mxWHBLh0zvOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XMZicH/iX7O2/d4jTqBFrYkk4JnmlfgFWdlv5P/LkMK9cS8IorLfLQJ1I4/FCjqgn
	 VRPVUYmLdCsbLq9KtpZcl79koQKrfXwi0du2gCvC685cyLQ26F3Mckr9S4abo3ospP
	 RVJwBZYJrrkhX0exnp93tCBePqEFWOZz7kD2cFCKCOHjcc/4TJafSnifjiXAQ66ZDI
	 wVzxzoZFUn0WRo/c3v88VO+Nosca+5SgL4HhJWfIH4+sF29tg5o0nMZdxVdikXKXIA
	 a2hrJ3Tic14JAmF31ogZBzsQAlQs7e5QvBxQnCpSnKLWZ95q01PRJrIX8Omc7EMEXu
	 p3nI1sGYzUwXg==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-726cdcec232so2054244a34.1;
        Wed, 12 Feb 2025 09:05:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOf470ZBpy12fWZhOgxElakwO9oU/jWNZVmosqLOrA1wMwcwu4rU7qwf7ORzYppx9hWjRjNTU/m1jmtaI=@vger.kernel.org, AJvYcCXHwxnb82VQWR+xUcZHHV6YDdmorQ+rIVjSSzj0FDfNIlSfzv0QCOqPv2zU4kthH5HVcCJVIiK7vZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziN5sZVRCug1+h2duiorxEY+VwweHvq8h/dD0R+l7hY6EbFL2a
	jvlTvKnX9ECLqhjAPmZigadcvY5WKR+EgEEiLeZtZqkMPo8G6MYYNz/GKloOZ9wuu2R8MoNoyXp
	7jwH9cLqt1GygJpangLaVsybxA4Q=
X-Google-Smtp-Source: AGHT+IGUz9+NnKxTsJr3SkJXSq55rUPHvDHM6I+x1V/qceMRyG9F3Q82N7yezlzIGfshDIKUQI/YlJbuVZbzYJ4ny5c=
X-Received: by 2002:a05:6870:819e:b0:2b7:fa6f:9672 with SMTP id
 586e51a60fabf-2b8d69460e0mr2546882fac.38.1739379915938; Wed, 12 Feb 2025
 09:05:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
 <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com>
 <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com> <CAPDyKFq91JnCFhEuitOJPZtq78-Y3CUy4p0bNE1wK+eYCste6g@mail.gmail.com>
In-Reply-To: <CAPDyKFq91JnCFhEuitOJPZtq78-Y3CUy4p0bNE1wK+eYCste6g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 18:05:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com>
X-Gm-Features: AWEUYZk3i_DCfMUdCRB2ktAYzTCS-9IJYh9sUR7y_wCTzS-VE7oqQPFNFa-PCCY
Message-ID: <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 4:15=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 12 Feb 2025 at 12:33, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Wed, Feb 12, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > >
> > > On Wed, Feb 12, 2025 at 10:12=E2=80=AFAM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > > >
> > > > On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwysocki.net>=
 wrote:
> > > > >
> > > > > Hi Everyone,
> > > > >
> > > > > This series is a result of the discussion on a recently reported =
issue
> > > > > with device runtime PM status propagation during system resume an=
d
> > > > > the resulting patches:
> > > > >
> > > > > https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwysocki.ne=
t/
> > > > > https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki.net=
/
> > > > >
> > > > > Overall, due to restrictions related to pm_runtime_force_suspend(=
) and
> > > > > pm_runtime_force_resume(), it was necessary to limit the RPM_ACTI=
VE
> > > > > setting propagation to the parent of the first device in a depend=
ency
> > > > > chain that turned out to have to be resumed during system resume =
even
> > > > > though it was runtime-suspended before system suspend.
> > > > >
> > > > > Those restrictions are that (1) pm_runtime_force_suspend() attemp=
ts to
> > > > > suspend devices that have never had runtime PM enabled if their r=
untime
> > > > > PM status is currently RPM_ACTIVE and (2) pm_runtime_force_resume=
()
> > > > > will skip device whose runtime PM status is currently RPM_ACTIVE.
> > > > >
> > > > > The purpose of this series is to eliminate the above restrictions=
 and
> > > > > get pm_runtime_force_suspend() and pm_runtime_force_resume() to a=
gree
> > > > > more with what the core does.
> > > >
> > > > For my understanding, would you mind elaborating a bit more around =
the
> > > > end-goal with this?
> > >
> > > The end goal is, of course, full integration of runtime PM with syste=
m
> > > sleep for all devices.  Eventually.
> > >
> > > And it is necessary to make the core and
> > > pm_runtime_force_suspend|resume() work together better for this
> > > purpose.
> > >
> > > > Are you trying to make adaptations for
> > > > pm_runtime_force_suspend|resume() and the PM core, such that driver=
s
> > > > that uses pm_runtime_force_suspend|resume() should be able to cope
> > > > with other drivers for child-devices that make use of
> > > > DPM_FLAG_SMART_SUSPEND?
> > >
> > > Yes.
> > >
> > > This is a more general case, though, when a device that was
> > > runtime-suspended before system suspend and is left in suspend during
> > > it, needs to be resumed during the system resume that follows.
> > >
> > > Currently, DPM_FLAG_SMART_SUSPEND can lead to this sometimes and it
> > > cannot happen otherwise, but I think that it is a generally valid
> > > case.
> > >
> > > > If we can make this work, it would enable the propagation of
> > > > RPM_ACTIVE in the PM core for more devices, but still not for all,
> > > > right?
> > >
> > > It is all until there is a known case in which it isn't.  So either
> > > you know a specific case in which it doesn't work, or I don't see a
> > > reason for avoiding it.
> > >
> > > ATM the only specific case in which it doesn't work is when
> > > pm_runtime_force_suspend|resume() are used.
> > >
> > > > The point is, the other bigger issue that I pointed out in our earl=
ier
> > > > discussions; all those devices where their drivers/buses don't cope
> > > > with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will prevent
> > > > the PM core from *unconditionally* propagating the RPM_ACTIVE to
> > > > parents. I guess this is the best we can do then?
> > >
> > > OK, what are they?
> > >
> > > You keep saying that they exist without giving any examples.
> >
> > To put it more bluntly, I'm not aware of any place other than
> > pm_runtime_force_suspend|resume() that can be confused by changing the
> > runtime PM status of a device with runtime PM disabled (either
> > permanently, or transiently during a system suspend-resume cycle) to
> > RPM_ACTIVE, so if there are any such places, I would appreciate
> > letting me know what they are.
>
> Well, sorry I thought you were aware. Anyway, I believe you need to do
> your own investigation as it's simply too time consuming for me to
> find them all. The problem is that it's not just a simple pattern to
> search for, so we would need some clever scripting to move forward to
> find them.
>
> To start with, we should look for drivers that enable runtime PM, by
> calling pm_runtime_enable().
>
> Additionally, in their system suspend callback they should typically
> *not* use pm_runtime_suspended(), pm_runtime_status_suspended() or
> pm_runtime_active() as that is usually (but no always) indicating that
> they got it right. Then there are those that don't have system
> suspend/resume callbacks assigned at all (or uses some other subsystem
> specific callback for this), but only uses runtime PM.
>
> On top of that, drivers that makes use of
> pm_runtime_force_suspend|resume() should be disregarded, which has
> reached beyond 300 as this point.
>
> Anyway, here is just one example that I found from a quick search.
> drivers/i2c/busses/i2c-qcom-geni.c

OK, I see.

It sets the status to RPM_SUSPENDED in geni_i2c_suspend_noirq(), if
not suspended already, and assumes it to stay this way across
geni_i2c_resume_noirq() until someone resumes it via runtime PM.

Fair enough, but somebody should tell them that they don't need to use
pm_runtime_disable/enable() in _noirq.

> >
> > Note that rpm_active() could start producing confusing results if the
> > runtime PM status of a device with runtime PM disabled is changed from
> > RPM_ACTIVE to RPM_SUSPENDED because it will then start to return
> > -EACCES instead of 1, but changing the status to RPM_ACTIVE will not
> > confuse it the same way.
>
> Trust me, it will cause problems.
>
> Drivers may call pm_runtime_get_sync() to turn on the resources for
> the device after the system has resumed, when runtime PM has been
> re-enabled for the device by the PM core.
>
> Those calls to pm_runtime_get_sync() will then not end up invoking any
> if ->runtime_resume() callbacks for the device since its state is
> already RPM_ACTIVE. Hence, the device will remain in a low power state
> even if the driver believes it has been powered on. In many cases,
> accessing the device (like reading/writing a register) will often just
> just hang in these cases, but in worst cases we could end up getting
> even more difficult bugs to debug.

Sure, that would be a problem.

I think I need to find a different way to address the problem I'm
seeing, that is to resume devices that were runtime-suspended before
system suspend along with their superiors.

One way to do it would be to just defer their resume to the point when
the core has enabled runtime PM for them, which means that it has also
enabled runtime PM for all of their superiors, and then call
pm_runtime_resume().

This should work unless one of the superiors has runtime PM disabled
at that point, of course.

