Return-Path: <linux-pm+bounces-17623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D59CDFDA
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 14:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E291F23AA6
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 13:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20D1BC9EB;
	Fri, 15 Nov 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC0yX8fb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC821B982C;
	Fri, 15 Nov 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677135; cv=none; b=moFH3xxL774e+r9xqCrXTblkhR7l2zIfdiAWqzquikBUQMSgy6Ou4vvXgfBPAucO71Z2nSht6isDwJ+viE9MQArYTQ0VFJSG5vJ58AVRXLjJoyPUeOz4oHwCPe74o5aNan8dwWJfkrB6lmPHhan+rTv7V5Y0fOWt7tU0+dinAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677135; c=relaxed/simple;
	bh=BL3Tpv75R4hvQ18hg8BtJMuAGC5hjhHQNc45yx+LNL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usYrzUnGXFOssxn0EqGgKUdBMo3l1auWsW+MKcQOsrbtbBkn0UYUVICgsfLR0Dbe2zglZYgPCAhqkpMkMzO1YHNviOMzuty+WEgnc2MT2Wvvu2M0dn5jjaKc/E0qoVWR2sOC0tZMPxqQ6a9vvSYw3Ms+zEkLhVQmNSiffCAU0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC0yX8fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ADFC4CED2;
	Fri, 15 Nov 2024 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731677135;
	bh=BL3Tpv75R4hvQ18hg8BtJMuAGC5hjhHQNc45yx+LNL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HC0yX8fbaDi5I8nXACw9gWso/4iIe/FGfk18Nla/MxQa4AtXj/Gjn44IEB8NpZwQl
	 oYoiSYcJ8ihY7SA48JArpxvjYwkf8z14/sLZONv4Odi6Xn3o2KHljPOjsiybz0aypA
	 mBq0TlApAHJ5H96fEJ4K+PyVEcs/R/ospeuWL3lnDYEGQYu/n6lJqu3NvftS+oeOYX
	 oYWOVsnqT3hKqsg2CeXW0V7CxoUVTgXIajO3VYObYZ3ub1eKBL7TOleCsDfkPgLXxE
	 aFV68qV0FL90NI6DvDZVOfIG4rvC/i1gVKkq/PUNOxBMqCDwmrdjTt2qDEy9vRuMRH
	 gfwwnTvaqH59g==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e5f533e1c2so952692b6e.3;
        Fri, 15 Nov 2024 05:25:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDL2uNiW7XD9Pl7RaagF3Z6dxAzoCNl0cGDX0EU2GUM/MV390UvHSN8uIUzvZP9xq8H+FPfAxbq4fHwaU=@vger.kernel.org, AJvYcCWsbB8toD7Yc8T7XDyA6EfleVZWYHFwVkBhJ9Hum/ZEq0WBVVwhlS1Ex6If/2gWEx1gLk7LThQvxRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi/3ntky++/oRIhoyeezNTNxNBzq8KonE5u2hCD8BuQQOGOj0i
	Zaku1WH9sSIxFUWH7emC6KGtXiKZ2Uyd1StENlIM5LrPfpjLJGtNqkaEZISUopYOz9zii7PpyZN
	L8t5sSNBGxBSjAKdGYz0TSqhxr78=
X-Google-Smtp-Source: AGHT+IE4BCg6Gtrza74kUI7kd+g5Z/tBNl1E3Un0fJ4JzBkhO2ZiVuBqEDMK41IdjqN9/QsGwsnBRLG/krM2IfDwfSc=
X-Received: by 2002:a05:6808:1250:b0:3e5:d093:d6e with SMTP id
 5614622812f47-3e7bc85054bmr3810946b6e.31.1731677134657; Fri, 15 Nov 2024
 05:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4992010.31r3eYUQgx@rjwysocki.net> <20241115101427.GA22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0gfSpzjD1PDhMOmqV_wcnCtr=m12noAqVpQkDsjetu+Ug@mail.gmail.com> <20241115125523.GD22801@noisy.programming.kicks-ass.net>
In-Reply-To: <20241115125523.GD22801@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Nov 2024 14:25:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jkPb-sgrMfk+KN19+R+ezucssHKUzfJZ74Qw1Ned6gaw@mail.gmail.com>
Message-ID: <CAJZ5v0jkPb-sgrMfk+KN19+R+ezucssHKUzfJZ74Qw1Ned6gaw@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: Do not return from cpuidle_play_dead() on
 callback failures
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>, 
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Nov 15, 2024 at 01:46:29PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Nov 15, 2024 at 11:14=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Thu, Nov 14, 2024 at 06:46:20PM +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > If the :enter_dead() idle state callback fails for a certain state,
> > > > there may be still a shallower state for which it will work.
> > > >
> > > > Because the only caller of cpuidle_play_dead(), native_play_dead(),
> > > > falls back to hlt_play_dead() if it returns an error, it should
> > > > better try all of the idle states for which :enter_dead() is presen=
t
> > > > before failing, so change it accordingly.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/cpuidle/cpuidle.c |    7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/cpuidle/cpuidle.c
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> > > > +++ linux-pm/drivers/cpuidle/cpuidle.c
> > > > @@ -70,9 +70,10 @@ int cpuidle_play_dead(void)
> > > >               return -ENODEV;
> > > >
> > > >       /* Find lowest-power state that supports long-term idle */
> > > > -     for (i =3D drv->state_count - 1; i >=3D 0; i--)
> > > > -             if (drv->states[i].enter_dead)
> > > > -                     return drv->states[i].enter_dead(dev, i);
> > > > +     for (i =3D drv->state_count - 1; i >=3D 0; i--) {
> > > > +             if (drv->states[i].enter_dead && !drv->states[i].ente=
r_dead(dev, i))
> > > > +                     return 0;
> > > > +     }
> > >
> > > Hmm, strictly speaking there is no 'success' return from play_dead().=
 On
> > > success, the CPU is dead :-)
> >
> > Well, would you prefer something like
> >
> > for (i =3D drv->state_count - 1; i >=3D 0; i--) {
> >         if (drv->states[i].enter_dead)
> >                 drv->states[i].enter_dead(dev, i);
> > }
> >
> > and adding a comment before the final return statement that
> > :enter_dead() only returns on failure?
>
> Yeah, but perhaps remove the return value entirely if we're going to
> ignore it anyway. And then assume that any return is a failure to die.
>
> I mean, something like:
>
>         if (drv->states[i].enter_dead && !drv->states[i].enter_dead(dev, =
i))
>                 panic("Dead CPU walking...");
>
> is 'fun' but not very useful.

The panic would be hard to debug if it ever triggers I'm afraid and
there is the fallback to HLT in the caller.

An error message could be printed here though:

    if (drv->states[i].enter_dead && !drv->states[i].enter_dead(dev, i))
            pr_err("CPU %d: Unexpectedly undead\n", dev->cpu);

