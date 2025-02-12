Return-Path: <linux-pm+bounces-21958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC96A3250E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 12:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05FD168B87
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31944207667;
	Wed, 12 Feb 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Truvy0b2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E11E282D;
	Wed, 12 Feb 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360036; cv=none; b=MoNagXuaofyKQyCaTVwd/YUGUoO5soqfaAbNl2uwmD99FI0nbEQm2TISHJkIMshQ4kPbqpcz13K0YJ02x+T+vRx5NbS4lgs/6UMO4sZld9ApuO32Tmxu17XNjhwHyTZRVXCV9kG104fEf5RH0IpdP6LhuYlwkcYnH5YLq2l39ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360036; c=relaxed/simple;
	bh=5HAGCJZ+apnsaP84GdrPXudDrLSkzeikILx7xWyXWmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPeIcu3jx/UwTDTOyMYPPuRg+V1E/Fb9ebgusefPr8By0d6gqVvqqXdwTabW2l1OWzum6biD9JGrgsf/T9PPm4Vb086SrIklHVAMs+kvMHNdU8M3uIVxMyNiq/FGzXEMZJU8imp6nRZJx3s85YorTmJ9Lv9IAGI+sa6NWbPgm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Truvy0b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE46C4CEE8;
	Wed, 12 Feb 2025 11:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739360035;
	bh=5HAGCJZ+apnsaP84GdrPXudDrLSkzeikILx7xWyXWmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Truvy0b2xGMYCidsvsho3m8l9ypLntqRlaqF9yqrgKhDCPBnIa0UuBEi0oaklxYyB
	 UjYsiz0+C7baEpnDs1etzXMAcEJ+/3gKJ6nLVKeUCv/WzeSfqVa9ErRDTM9D4kRPsa
	 f1LWspgZ/OmwSOxT0g75Lu7VaGMSCEgge1vZ3uTyJ+EPV+B7jM5EKnEpefycKm+aHP
	 Z3ls1ftE/HOU34lhvOMssTogvGxbNI0Vgm0xrXnBa+Q/g/g6BGIbZQludEIheiaRZW
	 9qZzTyh8CGuxj8zCararb/JY1C3wfwzfzD4C5mr+sMISvLsTITd+p+4bcHvBE0Wt4e
	 UmDl1XH7rp9ow==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2b8f09669bdso760fac.0;
        Wed, 12 Feb 2025 03:33:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUu1K/zr2ofXNA77HCYvdwfMsmHvZvYub5y7GKaafx48Kq6Mjk1AjXA1lwcmgCF9nA7anRUgjhUDxk=@vger.kernel.org, AJvYcCWij3hNgq+zItzV3GJrV0Tq4/OxJbW5NngGD35YN9p00pVBoFT/fz6a7WWyfTWV/bKc9vhBNhWkz8r8E9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZBdwdIXj7i4vSl2fBZ6o7TiNhm4/B8PuRUqZuCPYGibfGYHs
	t6KlWk3HR7Vkw5KRps4RKyRlCHdHOwXUMmgk6Psk0QVZA0KTOrQx3bZQpY6rgsMAaazGfH145wb
	7kMMv6nn6uJdEsAD/UaPwabv70j0=
X-Google-Smtp-Source: AGHT+IGjDZne/DPD51rFdpsLWRYRr3/qxtNQMUBpiLHK34/D8eUTcZVdfM6BylVejKsr5/4vTWjZDhsNuyotK2DBqQQ=
X-Received: by 2002:a05:6870:c1d3:b0:29e:7603:be65 with SMTP id
 586e51a60fabf-2b8d6479d47mr1730953fac.1.1739360035125; Wed, 12 Feb 2025
 03:33:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
 <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com>
In-Reply-To: <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 12:33:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
X-Gm-Features: AWEUYZm72kdFsWQphupdGsEfFL5atXHWknw14-9QaRm06jYJfcnCEUviZNscasY
Message-ID: <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, Feb 12, 2025 at 10:12=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwysocki.net> wro=
te:
> > >
> > > Hi Everyone,
> > >
> > > This series is a result of the discussion on a recently reported issu=
e
> > > with device runtime PM status propagation during system resume and
> > > the resulting patches:
> > >
> > > https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwysocki.net/
> > > https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki.net/
> > >
> > > Overall, due to restrictions related to pm_runtime_force_suspend() an=
d
> > > pm_runtime_force_resume(), it was necessary to limit the RPM_ACTIVE
> > > setting propagation to the parent of the first device in a dependency
> > > chain that turned out to have to be resumed during system resume even
> > > though it was runtime-suspended before system suspend.
> > >
> > > Those restrictions are that (1) pm_runtime_force_suspend() attempts t=
o
> > > suspend devices that have never had runtime PM enabled if their runti=
me
> > > PM status is currently RPM_ACTIVE and (2) pm_runtime_force_resume()
> > > will skip device whose runtime PM status is currently RPM_ACTIVE.
> > >
> > > The purpose of this series is to eliminate the above restrictions and
> > > get pm_runtime_force_suspend() and pm_runtime_force_resume() to agree
> > > more with what the core does.
> >
> > For my understanding, would you mind elaborating a bit more around the
> > end-goal with this?
>
> The end goal is, of course, full integration of runtime PM with system
> sleep for all devices.  Eventually.
>
> And it is necessary to make the core and
> pm_runtime_force_suspend|resume() work together better for this
> purpose.
>
> > Are you trying to make adaptations for
> > pm_runtime_force_suspend|resume() and the PM core, such that drivers
> > that uses pm_runtime_force_suspend|resume() should be able to cope
> > with other drivers for child-devices that make use of
> > DPM_FLAG_SMART_SUSPEND?
>
> Yes.
>
> This is a more general case, though, when a device that was
> runtime-suspended before system suspend and is left in suspend during
> it, needs to be resumed during the system resume that follows.
>
> Currently, DPM_FLAG_SMART_SUSPEND can lead to this sometimes and it
> cannot happen otherwise, but I think that it is a generally valid
> case.
>
> > If we can make this work, it would enable the propagation of
> > RPM_ACTIVE in the PM core for more devices, but still not for all,
> > right?
>
> It is all until there is a known case in which it isn't.  So either
> you know a specific case in which it doesn't work, or I don't see a
> reason for avoiding it.
>
> ATM the only specific case in which it doesn't work is when
> pm_runtime_force_suspend|resume() are used.
>
> > The point is, the other bigger issue that I pointed out in our earlier
> > discussions; all those devices where their drivers/buses don't cope
> > with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will prevent
> > the PM core from *unconditionally* propagating the RPM_ACTIVE to
> > parents. I guess this is the best we can do then?
>
> OK, what are they?
>
> You keep saying that they exist without giving any examples.

To put it more bluntly, I'm not aware of any place other than
pm_runtime_force_suspend|resume() that can be confused by changing the
runtime PM status of a device with runtime PM disabled (either
permanently, or transiently during a system suspend-resume cycle) to
RPM_ACTIVE, so if there are any such places, I would appreciate
letting me know what they are.

Note that rpm_active() could start producing confusing results if the
runtime PM status of a device with runtime PM disabled is changed from
RPM_ACTIVE to RPM_SUSPENDED because it will then start to return
-EACCES instead of 1, but changing the status to RPM_ACTIVE will not
confuse it the same way.

