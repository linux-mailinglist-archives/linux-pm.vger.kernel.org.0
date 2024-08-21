Return-Path: <linux-pm+bounces-12633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFBA959A8B
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A6C1C211E1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DAB1CDFD0;
	Wed, 21 Aug 2024 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2WHV8eX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E31B5EB3;
	Wed, 21 Aug 2024 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239543; cv=none; b=UBSVw/YXGoFCXYnmmComx7p2P1NFuaytdg0D3oPOVx3BJIfr+D4aoMXoY+G+hMD448GEHiv6mk+y/eoDuFPXzptichT5rQ/rNh3A5T5oraWxhyweHYXT0plFe7tKvYbUIr+0t2eauKoDeHXnlkLt5W7moUc925EHNdw7eUsLRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239543; c=relaxed/simple;
	bh=Kvnq32RuIPSuDttZFxycxxFwGZsj2tN0L7uucROnTsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJlz811GqyG/BQ8MR5xIJ6aDcqRnExv3WAKmYGy6ImOReOLVu4m1WjzlS0E4qpZBZynmilOJf13CFs53cxqoa7UjUDgGsaaOHV49vtoGFY+Yk7J525o6NrTPHZTEUR0UyKjjrhMGnLJVxSL9OotcGxKJKsk/D+fdQq/YOxqKACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2WHV8eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE1FC4AF0E;
	Wed, 21 Aug 2024 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724239542;
	bh=Kvnq32RuIPSuDttZFxycxxFwGZsj2tN0L7uucROnTsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P2WHV8eXl40ui6SvNMnSJ8zOyqgVlR3PFHvEFOdA9bX27iABpk6Jbuo6Iv/WnWVrR
	 7FIbSap6O0WGxgTBZ9eMmw1MkrepM5YKiis+IVzbVUrIH5m4N/SnlOF9JAPg9o8DI2
	 bHtrpyiINgyw8aKmFVsWKoBc7G+zPbOtR43jy/fxIePORpTW976lsGl11dlAmVK16I
	 qRWF8QdJ13sNnAHDOcQyQ3LjMaorodzsdD9u4+fRujqqn7V0OHH2uSieYoTS8tqAFv
	 KSTkZujNwPrdJyCUDuTB01XTvaGY3wsqL6ndIOnbXKYkKhcK7cvOgNRsBfAX25SRU3
	 h08RNlza0caKw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-26fde6117cfso3803860fac.1;
        Wed, 21 Aug 2024 04:25:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+2yC03Pvi8mHhgvP1YRrT4W6cm/95g5Sw9p0/UKAe1hsVSyt9x1FpjIQiS9IGFoDey8u+1ZVGtgpohQs=@vger.kernel.org, AJvYcCUuGQSAx6cMKkV5KWB4aKaQHJQfrANLStkunyp/J/pPLXZXQMZUO4qbLcLYIWpMaoo0jNctygb9rjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJWIwExju1AL91UvmlRjnj9jQlV1qCIpzF1kxa7JJ5HiSerHob
	OUyujawyX1xD608up2IDmydBuu6jF3s7K3zP+X3yla/JBDFjJvYjlY/yaGMUoQdloDDA+nXl+AN
	iiugGydDnIGSTnjIzz/EP+4ez45w=
X-Google-Smtp-Source: AGHT+IFVdFpMCmhvEZl2SiUCUpvAzShvYrajztdIQqWdUOBjADmD3QfBXRYsCx5Wxvqm+EPkiAE/26vAZQZCFMBa/rU=
X-Received: by 2002:a05:6871:5824:b0:254:a811:6c75 with SMTP id
 586e51a60fabf-2737eeb0c79mr2009436fac.7.1724239542021; Wed, 21 Aug 2024
 04:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <3161640.llJtBoKCBr@vostro.rjw.lan> <8965830.CMQzZzsqm0@vostro.rjw.lan>
 <4652506.tkuQIhnkdH@vostro.rjw.lan> <20240821095105.xuf2a5xe3yxqqewj@lcpd911>
In-Reply-To: <20240821095105.xuf2a5xe3yxqqewj@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 13:25:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0goEQC3xF11wOm7q3TA51WfaM_g1zBV+nKpVYyvH5fmag@mail.gmail.com>
Message-ID: <CAJZ5v0goEQC3xF11wOm7q3TA51WfaM_g1zBV+nKpVYyvH5fmag@mail.gmail.com>
Subject: Re: [PATCH 3/3] cpuidle: Select a different state on
 tick_broadcast_enter() failures
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, peterz@infradead.org, 
	rlippert@google.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linus.walleij@linaro.org, rafael.j.wysocki@intel.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com, 
	tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, khilman@ti.com, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:15=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi,
>
> On May 10, 2015 at 01:19:52 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If tick_broadcast_enter() fails in cpuidle_enter_state(),
> > try to find another idle state to enter instead of invoking
> > default_idle_call() immediately and returning -EBUSY which
> > should increase the chances of saving some energy in those
> > cases.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> Found this during code review, hence dug up this old thread again,
>
> >  drivers/cpuidle/cpuidle.c |   20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/cpuidle.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> > +++ linux-pm/drivers/cpuidle/cpuidle.c
> > @@ -73,7 +73,10 @@ int cpuidle_play_dead(void)
> >  }
> >
> >  static int find_deepest_state(struct cpuidle_driver *drv,
> > -                           struct cpuidle_device *dev, bool freeze)
> > +                           struct cpuidle_device *dev,
> > +                           unsigned int max_latency,
> > +                           unsigned int forbidden_flags,
> > +                           bool freeze)
> >  {
> >       unsigned int latency_req =3D 0;
> >       int i, ret =3D freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
> > @@ -83,6 +86,8 @@ static int find_deepest_state(struct cpu
> >               struct cpuidle_state_usage *su =3D &dev->states_usage[i];
> >
> >               if (s->disabled || su->disable || s->exit_latency <=3D la=
tency_req
> > +                 || s->exit_latency > max_latency
> > +                 || (s->flags & forbidden_flags)
> >                   || (freeze && !s->enter_freeze))
> >                       continue;
> >
> > @@ -100,7 +105,7 @@ static int find_deepest_state(struct cpu
> >  int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> >                              struct cpuidle_device *dev)
> >  {
> > -     return find_deepest_state(drv, dev, false);
> > +     return find_deepest_state(drv, dev, UINT_MAX, 0, false);
> >  }
> >
> >  static void enter_freeze_proper(struct cpuidle_driver *drv,
> > @@ -139,7 +144,7 @@ int cpuidle_enter_freeze(struct cpuidle_
> >        * that interrupts won't be enabled when it exits and allows the =
tick to
> >        * be frozen safely.
> >        */
> > -     index =3D find_deepest_state(drv, dev, true);
> > +     index =3D find_deepest_state(drv, dev, UINT_MAX, 0, true);
> >       if (index >=3D 0)
> >               enter_freeze_proper(drv, dev, index);
> >
> > @@ -168,8 +173,13 @@ int cpuidle_enter_state(struct cpuidle_d
> >        * CPU as a broadcast timer, this call may fail if it is not avai=
lable.
> >        */
> >       if (broadcast && tick_broadcast_enter()) {
> > -             default_idle_call();
> > -             return -EBUSY;
> > +             index =3D find_deepest_state(drv, dev, target_state->exit=
_latency,
> > +                                        CPUIDLE_FLAG_TIMER_STOP, false=
);
> > +             if (index < 0) {
>
> Would this condition ever meet?
> If you see, the ret inside find_deepest_state is always starting with a 0=
 and
> then nobody is ever really making it negative again. So the func either
> returns a 0 or some positive value right?
>
> Since nobody has probably raised an issue about this in 9 years, is this
> basically dead code inside the if?

Yes, it is dead code now.

> Let me know what needs to be done here, I'd be happy to patch this up.

Please feel free to send a patch removing the redundant check.

> > +                     default_idle_call();
> > +                     return -EBUSY;
> > +             }
> > +             target_state =3D &drv->states[index];
> >       }
> >
> >       /* Take note of the planned idle state. */
> >
>
> --

