Return-Path: <linux-pm+bounces-10191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018091BE7C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 14:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D2A28454E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C92E64B;
	Fri, 28 Jun 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+GSyzTZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91F27733
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577580; cv=none; b=P9vzPxFHIHJqW1Fz73XN7k4SznTYQTHcOzK2/ZkrpyXHtOj/zXZ9VfuK7GplKO/Yj5GrOo1lCQmp519kDEDY+YmCtz9/1uyKAUuL7zg7RWV28oOkuNcQ7TG77CfPwX9EteNPPo9/U9J49hWVgx0fLq+vbfmQsgKYoPNEf6i3Lrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577580; c=relaxed/simple;
	bh=uriEDp5kURer/oTGqFUAOjiFj5d9lT4feIWd6i8P6mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEjDVc+Qzco3pNu0m/4X5iy6oTHbbKjZm9Fkj1bR0myTBjeIHMjxAXD5YiBrv5htZeGSahDAm334eDjQ+dCrNlhBEfFg1bVqBSZlTvj0tHOPdBRWCag3K8Q6zCdDzA1QADB9cJd25eksHl6m4LnguLMgaqFnPdbLVDZ/F2BmvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+GSyzTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F68DC32781
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 12:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719577579;
	bh=uriEDp5kURer/oTGqFUAOjiFj5d9lT4feIWd6i8P6mw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s+GSyzTZbA2vtetcdPpveotuMFu9YNJ+a24X+1EfmRmxOCdGJ9GNjLYuiCTzfMe6x
	 UVnQStR5OlS4Wq+2zRg0qFATBGycVv0pnlbsgsNbgghaNOyn6qsgNrsRs9+Z8z0uz8
	 X3XsMyZzHP3yKW+zl0wg3Jd8WHhnY7mSjAU+xNd6MdZXqfe6Cu4wSVadSPUgEnC3SS
	 k5ejGxTedWnQ23c7R+8nX6H/l34YjfxeWr+r93CWTXzbkcxkfxi89r0zGG3Jt/XSM8
	 rnp93o/LMa7T1j0LyYsyMZ2Zb72pl90ZsHKDkz/6icWEUG4okh4BQ8QCHlIa9lNhLa
	 YG+sGfoxwpCrg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25cd2b51fd3so67158fac.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 05:26:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YyIb5OMACl7ee50iiyjztSpcMbHbGA9ZuC1eiyvpPqaHyWe6rsk
	DhybQRqU9EKUT4HRg9Cf2NpwcNaq1AcRxKN2RWmLmDFQoBwGhbBvNFeMvUVToRInAK87ceTAVTU
	G5hp1N+UdgCF3FmRqzXKj9j1lM9A=
X-Google-Smtp-Source: AGHT+IEHB2CoCRlfNbLNbl8yNdDHSIQdFe5WdBnZ1H7ozX+0FjJPqr9Ss3URi3tFXW3OqP4ZYgKL2qR6WGL3DWXOSIc=
X-Received: by 2002:a05:6870:8a24:b0:254:cae6:a812 with SMTP id
 586e51a60fabf-25cf3f17d37mr19790884fac.3.1719577578833; Fri, 28 Jun 2024
 05:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org>
 <CAJZ5v0iu9dg-tzfzZH5vfDZAv_OD1PKiZwaU-Q07Jz0-ULjtYg@mail.gmail.com>
 <a1600a02-18e1-4e5c-bb64-6b1058a09fe5@linaro.org> <025ac119-e940-4dfb-aff6-9bd6121eb5c6@linaro.org>
 <CAJZ5v0htedijN5V9NFY8JXejuvvEASrGTpz=NG_5uBYnK0soCg@mail.gmail.com>
 <43ded807-be8d-4673-ab8c-1ed2a5a32077@linaro.org> <CAJZ5v0g0=k4HZhKhs=2iwO8zc=jkng898wF-nn_bUT-xA_iu6w@mail.gmail.com>
 <ff495355-3a9f-422b-b9c8-707f7e35ba43@linaro.org> <CAJZ5v0hh0whAL7BEUf=C=q6frcb1xROsBfRinVLdndGCpkddXQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hh0whAL7BEUf=C=q6frcb1xROsBfRinVLdndGCpkddXQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Jun 2024 14:26:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gx-s-uvTX8RibSETgQoLGWOVud6ErC14Fki56gNtX0ag@mail.gmail.com>
Message-ID: <CAJZ5v0gx-s-uvTX8RibSETgQoLGWOVud6ErC14Fki56gNtX0ag@mail.gmail.com>
Subject: Re: Trip points crossed not detected when no cooling device bound
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Lukasz Luba <Lukasz.Luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 12:49=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Fri, Jun 28, 2024 at 10:04=E2=80=AFAM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 27/06/2024 20:23, Rafael J. Wysocki wrote:
> > > On Thu, Jun 27, 2024 at 6:30=E2=80=AFPM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > >>
> > >> On 27/06/2024 11:54, Rafael J. Wysocki wrote:
> > >>> On Thu, Jun 27, 2024 at 12:24=E2=80=AFAM Daniel Lezcano
> > >>> <daniel.lezcano@linaro.org> wrote:
> > >>>>
> > >>>> On 26/06/2024 23:21, Daniel Lezcano wrote:
> > >>>>
> > >>>> [ ... ]
> > >>>>
> > >>>>>> Oh, I see where the problem can be.  If the zone is polling only=
, it
> > >>>>>> will not rearm the timer when the current zone temperature is in=
valid
> > >>>>>> after the above commit, so does the attached patch help?
> > >>>>>
> > >>>>> At this point, I went far when bisecting another problem and I en=
ded up
> > >>>>> screwing my config file. So I had to generate a new one from the =
default
> > >>>>> config. Since then the issue is no longer happening which sounds =
very
> > >>>>> strange to me.
> > >>>>>
> > >>>>> I'm still investigating but if you have a suggestion coming in mi=
nd, it
> > >>>>> would be welcome because I'm failing to find out what is going on=
 ... :/
> > >>>>
> > >>>> I finally reproduced the issue. That happens when there is *no* co=
oling
> > >>>> device bound on *any* thermal zones.
> > >>>
> > >>> Interesting.
> > >>>
> > >>>> Your patch seems to fix the problem but I'm not sure to understand=
 the
> > >>>> conditions of the bug
> > >>>
> > >>> It's probably the same as for commit 202aa0d4bb53:
> > >>> thermal_zone_device_init() sets tz->temperature to
> > >>> THERMAL_TEMP_INVALID and if the first invocation of
> > >>> __thermal_zone_get_temp() returns an error (because the .get_temp()
> > >>> callback returns an error), monitor_thermal_zone().  If polling is =
the
> > >>> only way in which the zone temperature can be updated, things go so=
uth
> > >>> because the timer is not set and there is no other way to set it.  =
No
> > >>> updates will be coming
> > >>
> > >> If there is no polling delay (aka interrupt driven), the routine wil=
l
> > >> skip the _set_trips function and the monitor_thermal_zone() will do
> > >> nothing in this case, right ?
> > >
> > > _set_trips() looks at tz->temperature, however, and it doesn't make
> > > sense to call it if the latter is invalid.
> > >
> > > Same for handle_thermal_trip() and governor callbacks.
> > >
> > >> Even setting a label jump to "monitor:" the routine is broken AFAICT
> > >
> > > I beg to differ.
> > >
> > > Yes, monitor_thermal_zone() does nothing if there is no polling, but
> > > it needs to be called anyway because it checks whether or not polling
> > > is there in the first place.
> > >
> > > And if there is no polling, it is assumed that
> > > __thermal_zone_device_update() will be called by other means.
> >
> > AFAICT, the interrupt can fire and it will result in a
> > thermal_zone_device_update() but the interrupt must be setup by
> > __set_trips() which is skipped because of the invalid temperature.
>
> Say the zone temperature is invalid and __set_trips() is not skipped.
>
> You'll end up with nonsensical values of "low"  and "high".  Is this OK?
>
> If you rely on __set_trips() to set up the interrupts for you, it
> needs to be given a valid zone temperature and trip thresholds.
>
> Some special handling of invalid tz->temperature may be added to it, thou=
gh.

Well, that's rather tricky because it is unclear what to do in this
case.  If the zone temperature is unknown, the boundaries to pass to
the .set_trips() callbacks are unknown too.

One possible choice would be to make the interrupt trigger right away,
but that's equivalent to putting thermal_zone_device_update() on a
runqueue (with some extra overhead).

Another possible choice would be to set the lower boundary to the
possible minimum and the upper boundary to the temperature of the
first trip, but in that case tz->temperature may be equal to
THERMAL_TEMP_INVALID for a long time (basically until the first trip
is crossed on the way up) which seems a bit odd to me, so I'd rather
not do this either.

Instead, the new patch simply schedules another temperature check with
a delay if the zone temperature turns out to be invalid.

> > I've confirmed that with my evb board.
> >
> >   - trips point
> >   - no polling delay (interrupt based)
> >   - no cooling device
> >
> > That does not work, there is no trip crossed notification.
>
> Yes, if the first zone temperature read fails and there are no
> interrupts coming to trigger next temperature updates, this is what's
> going to happen.
>
> I gather that the fix I sent doesn't help in this case?
>
> I'll send a v2 of it with .set_trips() taken into account.

Here: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net/

