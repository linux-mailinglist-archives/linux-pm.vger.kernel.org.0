Return-Path: <linux-pm+bounces-25175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C886CA84D84
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 21:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9654C41BC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990BD1EB197;
	Thu, 10 Apr 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxQpykV+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E21AA786;
	Thu, 10 Apr 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744314638; cv=none; b=ZtUzooQw5uXsEc0nroNuxbUPZsNDMAcenqw+qMfpSabIezlCCG3PotFw8HsLy8wmExoY8LHX0FwxzujNfaDUt/jT5qaKv1MexXtglVQmXnTTswDEigPRtn9OZD8dHakapDTZwM6emZTkQx4OZIkbp+izRxh6X/d3jmIEDpY7zlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744314638; c=relaxed/simple;
	bh=bVBfUktrUdOJlp/OnHZsI4rqlqsPWE+m4vCV3pcA6gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNc8/oAki2kJ0O40uL08lOC3XZPoQCkO9OMRv30aenUbxo69m09U9rYlzBEKW5hWXiT0wrGrEvCkYv1uVin0zp120IGky44UBTOT9wMDcKXZZczfgFqxo5D+KyGJv6tOe3+wfaT4skx+mHR2wJmdNQvyWCYMG/UxH5bYz5dSJs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxQpykV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7DFC4CEEB;
	Thu, 10 Apr 2025 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744314637;
	bh=bVBfUktrUdOJlp/OnHZsI4rqlqsPWE+m4vCV3pcA6gM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SxQpykV+qz6+A61h5X1jOeNV9D6l7UeLDv1clxSa8NEIuUSSGNJSxSmGeREMbS4tX
	 ujumaUXUHawr9B0uqxW0R9h3gcdWpHGLli+Si3blczx52bPOsfIbadzmIEEBsLP4dr
	 rnc+x1YknH5Tg5tUBFLh57WGzP00KTWN25wHi3IMfOTONT+s/E6fdg2aA3kfnb339F
	 BdMz+zBx/FqsgLijNCICoPVY13F59S9npOHCaaB8umKVeyd95gh5BK7QMfhNvNfRDE
	 F4UrXl49jsBqoKGHMBHMaHZ1t59JDauCKwh9WCcRyDypqf/bCwhCFo1Qi1v7Z0HsHz
	 WkhADXa+N8B4A==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6041e84715eso863217eaf.1;
        Thu, 10 Apr 2025 12:50:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJ7CjWHg81u/rxNWjb9w9MjYTARoB7qk0h9lQ245tkDAdLcjhBYi75kx+w2pnYDfvaPV17G0e6nt4=@vger.kernel.org, AJvYcCWtEkvBWTrQqgmb41JGymwKCtcxvIV2V9ElQdmJQA6glyUG92D23iYSvbbLDvQ9gJ4OnF5PTGn4sW3EwVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcOrqnog3wczwLh7zGIrbicXCYBGN08buRartNOlgiUkCk3ak
	axjs5ApQzPDXmh4fn3F858NDt4wRXq4ZTHA9uM0yihGXhD6D9tQR5GnVJgSQW1scrlI8K3VEPhd
	Dmc33ldBzaRQNnB3rFA/XWo5foak=
X-Google-Smtp-Source: AGHT+IEnRyZMcEnEngjupi2Iv08MemM1v/LCCHn4lLT99GBXU/RM5sK62/2fGxqVSb0v6GLY6ynBrrjVzeyteLPtrW0=
X-Received: by 2002:a05:6870:af96:b0:2b8:e6f2:ba7e with SMTP id
 586e51a60fabf-2d0b5b5464fmr2118048fac.12.1744314637074; Thu, 10 Apr 2025
 12:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410024439.20859-1-sultan@kerneltoast.com>
 <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com>
 <Z_fru1i1OpAQ-hJq@sultan-box.localdomain> <CAJZ5v0iu_hMud6FRg6FiUVQ1cY6oYqrEmwpwPTeYJh5Yzh5Q8A@mail.gmail.com>
 <Z_gbXSeo6kjOXhwE@sultan-box.localdomain>
In-Reply-To: <Z_gbXSeo6kjOXhwE@sultan-box.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 21:50:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7dsL+tQAEtJ_t-_p2Uxkaz=Kf-fUCKTvs7F7BLgqCiw@mail.gmail.com>
X-Gm-Features: ATxdqUGQ10HrFzdcespYbmnRY-0qkI-bjt0hdJ0yUaX3Q5TA2BXNmwFce1BdaEk
Message-ID: <CAJZ5v0h7dsL+tQAEtJ_t-_p2Uxkaz=Kf-fUCKTvs7F7BLgqCiw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't ignore limit changes when util
 is unchanged
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 9:26=E2=80=AFPM Sultan Alsawaf <sultan@kerneltoast.=
com> wrote:
>
> On Thu, Apr 10, 2025 at 08:47:38PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 10, 2025 at 6:03=E2=80=AFPM Sultan Alsawaf <sultan@kernelto=
ast.com> wrote:
> > >
> > > On Thu, Apr 10, 2025 at 05:34:39PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, Apr 10, 2025 at 4:45=E2=80=AFAM Sultan Alsawaf <sultan@kern=
eltoast.com> wrote:
> > > > >
> > > > > From: Sultan Alsawaf <sultan@kerneltoast.com>
> > > > >
> > > > > When utilization is unchanged, a policy limits update is ignored =
unless
> > > > > CPUFREQ_NEED_UPDATE_LIMITS is set. This occurs because limits_cha=
nged
> > > > > depends on the old broken behavior of need_freq_update to trigger=
 a call
> > > > > into cpufreq_driver_resolve_freq() to evaluate the changed policy=
 limits.
> > > > >
> > > > > After fixing need_freq_update, limit changes are ignored without
> > > > > CPUFREQ_NEED_UPDATE_LIMITS, at least until utilization changes en=
ough to
> > > > > make map_util_freq() return something different.
> > > > >
> > > > > Fix the ignored limit changes by preserving the value of limits_c=
hanged
> > > > > until get_next_freq() is called, so limits_changed can trigger a =
call to
> > > > > cpufreq_driver_resolve_freq().
> > > > >
> > > > > Reported-and-tested-by: Stephan Gerhold <stephan.gerhold@linaro.o=
rg>
> > > > > Link: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org
> > > > > Fixes: 8e461a1cb43d6 ("cpufreq: schedutil: Fix superfluous update=
s caused by need_freq_update")
> > > > > Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > > > > ---
> > > > >  kernel/sched/cpufreq_schedutil.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpuf=
req_schedutil.c
> > > > > index 1a19d69b91ed3..f37b999854d52 100644
> > > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > > @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sug=
ov_policy *sg_policy, u64 time)
> > > > >                 return false;
> > > > >
> > > > >         if (unlikely(sg_policy->limits_changed)) {
> > > > > -               sg_policy->limits_changed =3D false;
> > > > >                 sg_policy->need_freq_update =3D cpufreq_driver_te=
st_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > > >                 return true;
> > > > >         }
> > > > > @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sug=
ov_policy *sg_policy,
> > > > >         freq =3D get_capacity_ref_freq(policy);
> > > > >         freq =3D map_util_freq(util, freq, max);
> > > > >
> > > > > -       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy-=
>need_freq_update)
> > > > > +       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy-=
>limits_changed &&
> > > > > +           !sg_policy->need_freq_update)
> > > > >                 return sg_policy->next_freq;
> > > > >
> > > > > +       sg_policy->limits_changed =3D false;
> > > >
> > > > AFAICS, after this code modification, a limit change may be missed =
due
> > > > to a possible race with sugov_limits() which cannot happen if
> > > > sg_policy->limits_changed is only cleared when it is set before
> > > > updating sg_policy->need_freq_update.
> > >
> > > I don't think that's the case because sg_policy->limits_changed is cl=
eared
> > > before the new policy limits are evaluated in cpufreq_driver_resolve_=
freq().
> >
> > sugov_limits() may be triggered by a scaling_max_freq update, for
> > instance, so it is asynchronous with respect to the usual governor
> > flow.  It updates sg_policy->limits_changed and assumes that next time
> > the governor runs, it will call into the driver, for example via
> > cpufreq_driver_fast_switch(), so the new limits take effect.  This is
> > not about cpufreq_driver_resolve_freq().
>
> OK, though I think there's still a race in cpufreq_driver_resolve_freq().
>
> > sugov_limits() runs after the driver's ->verify() callback has
> > returned and it is conditional on that callback's return value, so the
> > driver already knows the new limits when sugov_limits() runs, but it
> > may still need to tell the hardware what the new limits are and that's
> > why cpufreq_driver_fast_switch() may need to run.
>
> Which is why CPUFREQ_NEED_UPDATE_LIMITS exists, right.
>
> > Now, if sugov_should_update_freq() sees sg_policy->limits_changed set,
> > it will set sg_policy->need_freq_update which (for drivers with
> > CPUFREQ_NEED_UPDATE_LIMITS set) guarantees that the driver will be
> > invoked and so sg_policy->limits_changed can be cleared.
> >
> > If a new instance of sugov_limits() runs at this point, there are two
> > possibilities.  Either it completes before the
> > sg_policy->limits_changed update in sugov_should_update_freq(), in
> > which case the driver already knows the new limits as per the above
> > and so the subsequent invocation of cpufreq_driver_fast_switch() will
> > pick them up, or it sets sg_policy->limits_changed again and the
> > governor will see it set next time it runs.  In both cases the new
> > limits will be picked up unless they are changed again in the
> > meantime.
> >
> > After the above change, sg_policy->limits_changed may be cleared even
> > if it has not been set before and that's problematic.  Namely, say it
> > is unset when sugov_should_update_freq() runs, after being called by
> > sugov_update_single_freq() via sugov_update_single_common(), and
> > returns 'true' without setting sg_policy->need_freq_update.  Next,
> > sugov_update_single_common() returns 'true' and get_next_freq() is
> > called.  It sees that freq !=3D sg_policy->cached_raw_freq, so it clear=
s
> > sg_policy->limits_changed.  If sugov_limits() runs on a different CPU
> > between the check and the sg_policy->limits_changed update in
> > get_next_freq(), it may be missed and it is still not guaranteed that
> > cpufreq_driver_fast_switch() will run because
> > sg_policy->need_freq_update is unset and sugov_hold_freq() may return
> > 'true'.
> >
> > For this to work, sg_policy->limits_changed needs to be cleared only
> > when it is set and sg_policy->need_freq_update needs to be updated
> > when sg_policy->limits_changed is cleared.
>
> Ah I see, thank you for the detailed explanation. So if I am understandin=
g it
> correctly: the problem with my patch is that CPUFREQ_NEED_UPDATE_LIMITS m=
ight
> not be honored after a limits change, because CPUFREQ_NEED_UPDATE_LIMITS =
is only
> honored when sg_policy->limits_changed is set. So there is the following =
race:
>
>            CPU-A                    CPU-B
>   sugov_should_update_freq()                    // sg_policy->limits_chan=
ged =3D=3D false, sg_policy->need_freq_update =3D=3D false
>                                 sugov_limits()  // sg_policy->limits_chan=
ged =3D=3D true,  sg_policy->need_freq_update =3D=3D false
>   get_next_freq()                               // sg_policy->limits_chan=
ged =3D=3D false, sg_policy->need_freq_update =3D=3D false
>
>   // cpufreq driver won't be invoked for the limits change if:
>   // next_f =3D=3D sg_policy->next_freq || (sugov_hold_freq() =3D=3D true=
 && next_f < sg_policy->next_freq)
>
> Does that look right?

Yes, it does.

> > It looks like you really want to set sg_policy->need_freq_update to
> > 'true' in sugov_should_update_freq() when sg_policy->limits_changed is
> > set, but that would render CPUFREQ_NEED_UPDATE_LIMITS unnecessary.
> >
> > > Granted, if we wanted to be really certain of this, we'd need release=
 semantics.
> >
> > I don't think so, but feel free to prove me wrong.
>
> Well, it appears that there really is synchronization missing between
> cpufreq_set_policy() and schedutil, since cpufreq_set_policy() changes th=
e live
> policy->min and policy->max, and schedutil may observe either the old val=
ues in
> there or garbage values due to load/store tearing.

schedutil itself doesn't really read policy->min and policy->max.
cpufreq_driver_resolve_freq() does this and drivers do, but since
policy->min and policy->max are integers, no garbage values will be
observed AFAICS.

Stale values can be observed, but in that case the new values will be
seen next time and limits_changed enforces picking them up.

Of course, if the limits change sufficiently often, schedutil will
fall behind, but then there is just too much noise anyway.

WRITE_ONCE() and READ_ONCE() could be used there, though, because the
compiler can do some damage in principle.

