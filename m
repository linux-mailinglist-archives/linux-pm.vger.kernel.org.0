Return-Path: <linux-pm+bounces-25170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84ECA84C63
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DEA9C207D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1144C1F0998;
	Thu, 10 Apr 2025 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBL5wBMS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8001372;
	Thu, 10 Apr 2025 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310871; cv=none; b=TVOW5ifAqtJhhR5yzm0ft/5E8/WOKkZwzAkPOg3h1vKg2lmdoN5ItWlrQkxgVPrRqf4tBaeEv5AgsQOAFatXU12NiXAxp1HNqIwQpBc3k+TZzMJI6sGqnbqwainqyMTeRDzhQYt8n5D/sEjc9viQgc4ggXzI+c7E4nyi3zd0S6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310871; c=relaxed/simple;
	bh=lh13D5eOjggZORnuqzGXKHELLhtB7BDv7goIzC46kyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CY+ldRAujt+5m6MFolpndgEPUBJBG6INTrwVm/4Iop4F+PdJ0eexyaAzjoS+CV6b6vMuF1uc+GB5sz0dU69baLRh/6IojAiV4VKO/Tfa3G6cA2xid5xKGGft5pi5ADzZyOLu0+L+jdZtQDx2rsI4IIDMMEzqKG5J2e6SFQfvykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBL5wBMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FD1C4CEEB;
	Thu, 10 Apr 2025 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744310870;
	bh=lh13D5eOjggZORnuqzGXKHELLhtB7BDv7goIzC46kyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aBL5wBMSKzk5BURfTniOR58wQWl/XR91v0iIgJo7nGi66CrBr9MKbwZ2Pzv9pRtl3
	 p8dkeli6Vio3/qi6+ZxfvMg8FZnko5FKrfcWmruZhND4/z1IlGb9cucWyW3EMPR40T
	 B/zgdCuMAqPFsibu/tTNoa84Moq3wyqyad6NUyu8udehJiZsT3djNA7fju7TI5qDIg
	 RFw751o0ucjYJNjJIhuVytS9Zjm9Ajqb7Q+P6EY+aaTf9VcmyeHwDsbQLA3/kqiOZu
	 yEiPT3m0laF3NtSRkPANqDYigb7Q8ZS/rodh9sv61YxLKTf5Jx+iruIaKbt4e/QKvG
	 45lJiY8TRw38w==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60288fd4169so547893eaf.3;
        Thu, 10 Apr 2025 11:47:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxZFaNCXE9LI2TH/RhW0FUGu7mvxqD0l5yd/61NyWNeIdXXIYSnYd8HbNOFf0/tI1nHo+5JHUFGAdNziY=@vger.kernel.org, AJvYcCWnQ/csNOx4FJWL9U2ixFI+8DyOqxaHd8eC3n8FeHHS8viEau5oyBlZBRtfjGcRYXM/kk1Dqc/A4vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvP2x5QdEQNkMBV2xzO58unwN4YIKgSuH+qCDG5M61XHF9wqAI
	isGCsA5gX6g9gw8LlAo6z+44pAsqPKmV4XWYIsaK85KpvCm2sE/mzTThyB+ycM+V2pXlu/S/c85
	MxLw4aNBrfIodXOFYW570iKeV5Rk=
X-Google-Smtp-Source: AGHT+IH7tMOhVjXKtvPXAnN/Jvi+jOM2HVGY76nBhlBkM2NcMAm9z+Bf6vtlLFLPDsKJlXEXb8mLBjoMt/aDOXyf0RY=
X-Received: by 2002:a05:6871:a508:b0:2bc:7e72:2110 with SMTP id
 586e51a60fabf-2d0b3643e2emr2042826fac.13.1744310869560; Thu, 10 Apr 2025
 11:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410024439.20859-1-sultan@kerneltoast.com>
 <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com> <Z_fru1i1OpAQ-hJq@sultan-box.localdomain>
In-Reply-To: <Z_fru1i1OpAQ-hJq@sultan-box.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 20:47:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iu_hMud6FRg6FiUVQ1cY6oYqrEmwpwPTeYJh5Yzh5Q8A@mail.gmail.com>
X-Gm-Features: ATxdqUEtAldOeY9RkK0nivdkGKJjyMHucWXMo7LktKbOHwKacrjSjsGhTC-dwxk
Message-ID: <CAJZ5v0iu_hMud6FRg6FiUVQ1cY6oYqrEmwpwPTeYJh5Yzh5Q8A@mail.gmail.com>
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

On Thu, Apr 10, 2025 at 6:03=E2=80=AFPM Sultan Alsawaf <sultan@kerneltoast.=
com> wrote:
>
> On Thu, Apr 10, 2025 at 05:34:39PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 10, 2025 at 4:45=E2=80=AFAM Sultan Alsawaf <sultan@kernelto=
ast.com> wrote:
> > >
> > > From: Sultan Alsawaf <sultan@kerneltoast.com>
> > >
> > > When utilization is unchanged, a policy limits update is ignored unle=
ss
> > > CPUFREQ_NEED_UPDATE_LIMITS is set. This occurs because limits_changed
> > > depends on the old broken behavior of need_freq_update to trigger a c=
all
> > > into cpufreq_driver_resolve_freq() to evaluate the changed policy lim=
its.
> > >
> > > After fixing need_freq_update, limit changes are ignored without
> > > CPUFREQ_NEED_UPDATE_LIMITS, at least until utilization changes enough=
 to
> > > make map_util_freq() return something different.
> > >
> > > Fix the ignored limit changes by preserving the value of limits_chang=
ed
> > > until get_next_freq() is called, so limits_changed can trigger a call=
 to
> > > cpufreq_driver_resolve_freq().
> > >
> > > Reported-and-tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > Link: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org
> > > Fixes: 8e461a1cb43d6 ("cpufreq: schedutil: Fix superfluous updates ca=
used by need_freq_update")
> > > Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > > ---
> > >  kernel/sched/cpufreq_schedutil.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_=
schedutil.c
> > > index 1a19d69b91ed3..f37b999854d52 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov_p=
olicy *sg_policy, u64 time)
> > >                 return false;
> > >
> > >         if (unlikely(sg_policy->limits_changed)) {
> > > -               sg_policy->limits_changed =3D false;
> > >                 sg_policy->need_freq_update =3D cpufreq_driver_test_f=
lags(CPUFREQ_NEED_UPDATE_LIMITS);
> > >                 return true;
> > >         }
> > > @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov_p=
olicy *sg_policy,
> > >         freq =3D get_capacity_ref_freq(policy);
> > >         freq =3D map_util_freq(util, freq, max);
> > >
> > > -       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->nee=
d_freq_update)
> > > +       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->lim=
its_changed &&
> > > +           !sg_policy->need_freq_update)
> > >                 return sg_policy->next_freq;
> > >
> > > +       sg_policy->limits_changed =3D false;
> >
> > AFAICS, after this code modification, a limit change may be missed due
> > to a possible race with sugov_limits() which cannot happen if
> > sg_policy->limits_changed is only cleared when it is set before
> > updating sg_policy->need_freq_update.
>
> I don't think that's the case because sg_policy->limits_changed is cleare=
d
> before the new policy limits are evaluated in cpufreq_driver_resolve_freq=
().

sugov_limits() may be triggered by a scaling_max_freq update, for
instance, so it is asynchronous with respect to the usual governor
flow.  It updates sg_policy->limits_changed and assumes that next time
the governor runs, it will call into the driver, for example via
cpufreq_driver_fast_switch(), so the new limits take effect.  This is
not about cpufreq_driver_resolve_freq().

sugov_limits() runs after the driver's ->verify() callback has
returned and it is conditional on that callback's return value, so the
driver already knows the new limits when sugov_limits() runs, but it
may still need to tell the hardware what the new limits are and that's
why cpufreq_driver_fast_switch() may need to run.

Now, if sugov_should_update_freq() sees sg_policy->limits_changed set,
it will set sg_policy->need_freq_update which (for drivers with
CPUFREQ_NEED_UPDATE_LIMITS set) guarantees that the driver will be
invoked and so sg_policy->limits_changed can be cleared.

If a new instance of sugov_limits() runs at this point, there are two
possibilities.  Either it completes before the
sg_policy->limits_changed update in sugov_should_update_freq(), in
which case the driver already knows the new limits as per the above
and so the subsequent invocation of cpufreq_driver_fast_switch() will
pick them up, or it sets sg_policy->limits_changed again and the
governor will see it set next time it runs.  In both cases the new
limits will be picked up unless they are changed again in the
meantime.

After the above change, sg_policy->limits_changed may be cleared even
if it has not been set before and that's problematic.  Namely, say it
is unset when sugov_should_update_freq() runs, after being called by
sugov_update_single_freq() via sugov_update_single_common(), and
returns 'true' without setting sg_policy->need_freq_update.  Next,
sugov_update_single_common() returns 'true' and get_next_freq() is
called.  It sees that freq !=3D sg_policy->cached_raw_freq, so it clears
sg_policy->limits_changed.  If sugov_limits() runs on a different CPU
between the check and the sg_policy->limits_changed update in
get_next_freq(), it may be missed and it is still not guaranteed that
cpufreq_driver_fast_switch() will run because
sg_policy->need_freq_update is unset and sugov_hold_freq() may return
'true'.

For this to work, sg_policy->limits_changed needs to be cleared only
when it is set and sg_policy->need_freq_update needs to be updated
when sg_policy->limits_changed is cleared.

It looks like you really want to set sg_policy->need_freq_update to
'true' in sugov_should_update_freq() when sg_policy->limits_changed is
set, but that would render CPUFREQ_NEED_UPDATE_LIMITS unnecessary.

> Granted, if we wanted to be really certain of this, we'd need release sem=
antics.

I don't think so, but feel free to prove me wrong.

> Looking closer at cpufreq.c actually, isn't there already a race on the u=
pdated
> policy limits (policy->min and policy->max) since they can be updated aga=
in
> while schedutil reads them via cpufreq_driver_resolve_freq()?

That can happen, but it is a different thing.

