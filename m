Return-Path: <linux-pm+bounces-25172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7393FA84CF4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 21:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AADC17A644
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16628F935;
	Thu, 10 Apr 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8jPz1cL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F128135E;
	Thu, 10 Apr 2025 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312897; cv=none; b=keOUR/SKgJ7QKZgIXhzKUGnrsgLG36Fj5rWiFP+YQ6sI+jheJP43oTYLohhzk7Cr1WbEH1QFnift7DFjdCRUbO749rLq4KdfW+1q3vihsD3Dyo9Wbgm/E8Q5Ivxvn3Z1Iez2CPX15OHmHazq9p323NbeAvHSDoDsLGOd2JVR8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312897; c=relaxed/simple;
	bh=KRHWqWj0VYYRRkw1qnA+nzxXeVN5/P5pQMCdQnOWd5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9V9/WOK6MnyKI9ZXMuSHHd8Re5Zf8miB2DDIpKTOqMtCfUbGMgccXSaka6RcHgAKRoeFp1VrJNxjAKTHV0DgyzL63vUdBvlM2OuHCKV3zxNUjXlV9vBiQc+i4KB93snzku/LTcPw7JJel9SBKSuWSh0f46JcQylYMCogNX6R2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8jPz1cL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578B3C4CEEE;
	Thu, 10 Apr 2025 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744312897;
	bh=KRHWqWj0VYYRRkw1qnA+nzxXeVN5/P5pQMCdQnOWd5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M8jPz1cL76p/7xV1C8QrwF9a91BD2t/FA/8At/Ibvs/MMcc3aMZ6GMKPDBOGroEbZ
	 FWetuVWw8czSZuHeD0l3FnC62RyCZkiAsDC7ul9Cg4RjAPdVg4AekNyKNoLvRM+ovz
	 tsdT9UXDl0xnI9Vmfnh2/DLja/NUgyyT+GjxSyOigzFhA+qhNyHz7gi0FXqJ2bBtKW
	 dIEvcp629e3kNGFLRbBOBrweAE6t6IHmgJcujPdtOzLiNbfpskoA2cRFesfLBEE1Mq
	 FYL0rwW0qXqqyBCPjTNu7lpFremRSzY5nXl9V3RTApSmEXeEbS+ZWSKfhLFzIRBUEk
	 FCgF/wA1YnceQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c7b2c14455so706733fac.2;
        Thu, 10 Apr 2025 12:21:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQtrsUIDW24PuAZMu8HDhnCzurB/f6D4UmuPL9I/rxkLSO7h+++kr3hOVZUJcn7gSyj2GxHGdSDfxp03Y=@vger.kernel.org, AJvYcCWju5tve4c59/qAft5y2tXaRAHOchwYK0t+D5oDPZNXb/+PKgeidbiDCXihFU+SC4lRvNAsXrt+4fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDokL87UP3yjCfuB1HFywJShoDiYAh47HZljTuRMwF2Xu8LtC4
	yHR3zXpKe9GlJBZrhg6nQk5GpxgD45h36Hg6GUp/p0Q5tScfZwPwbq/NEUtvYVXYyrhlPfTnxNT
	d0VcuiVBUrLROT1TCvvaL5b/xDzI=
X-Google-Smtp-Source: AGHT+IFEvMSzCJ6nLppcIaehR59mdXvT74IZeptmQp4HBuyHBH8SozcCZja9z7HdyvQKBHYYXFta7Su4MWXNm/7eOU8=
X-Received: by 2002:a05:6871:a10f:b0:297:2719:deb6 with SMTP id
 586e51a60fabf-2d0b35743aemr2252758fac.1.1744312896565; Thu, 10 Apr 2025
 12:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410024439.20859-1-sultan@kerneltoast.com>
 <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com>
 <Z_fru1i1OpAQ-hJq@sultan-box.localdomain> <CAJZ5v0iu_hMud6FRg6FiUVQ1cY6oYqrEmwpwPTeYJh5Yzh5Q8A@mail.gmail.com>
In-Reply-To: <CAJZ5v0iu_hMud6FRg6FiUVQ1cY6oYqrEmwpwPTeYJh5Yzh5Q8A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 21:21:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hOFjsS1KPZ=0KkCEuA58ken4qTfhnn5n5mcC5LkCCzRA@mail.gmail.com>
X-Gm-Features: ATxdqUGCPyDzsEJNEcRzZK-Ows8WeMV2BPKnu9MgtdiUDJ74X0ZZex3GkAujyBE
Message-ID: <CAJZ5v0hOFjsS1KPZ=0KkCEuA58ken4qTfhnn5n5mcC5LkCCzRA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't ignore limit changes when util
 is unchanged
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 8:47=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Apr 10, 2025 at 6:03=E2=80=AFPM Sultan Alsawaf <sultan@kerneltoas=
t.com> wrote:
> >
> > On Thu, Apr 10, 2025 at 05:34:39PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Apr 10, 2025 at 4:45=E2=80=AFAM Sultan Alsawaf <sultan@kernel=
toast.com> wrote:
> > > >
> > > > From: Sultan Alsawaf <sultan@kerneltoast.com>
> > > >
> > > > When utilization is unchanged, a policy limits update is ignored un=
less
> > > > CPUFREQ_NEED_UPDATE_LIMITS is set. This occurs because limits_chang=
ed
> > > > depends on the old broken behavior of need_freq_update to trigger a=
 call
> > > > into cpufreq_driver_resolve_freq() to evaluate the changed policy l=
imits.
> > > >
> > > > After fixing need_freq_update, limit changes are ignored without
> > > > CPUFREQ_NEED_UPDATE_LIMITS, at least until utilization changes enou=
gh to
> > > > make map_util_freq() return something different.
> > > >
> > > > Fix the ignored limit changes by preserving the value of limits_cha=
nged
> > > > until get_next_freq() is called, so limits_changed can trigger a ca=
ll to
> > > > cpufreq_driver_resolve_freq().
> > > >
> > > > Reported-and-tested-by: Stephan Gerhold <stephan.gerhold@linaro.org=
>
> > > > Link: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org
> > > > Fixes: 8e461a1cb43d6 ("cpufreq: schedutil: Fix superfluous updates =
caused by need_freq_update")
> > > > Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > > > ---
> > > >  kernel/sched/cpufreq_schedutil.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufre=
q_schedutil.c
> > > > index 1a19d69b91ed3..f37b999854d52 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov=
_policy *sg_policy, u64 time)
> > > >                 return false;
> > > >
> > > >         if (unlikely(sg_policy->limits_changed)) {
> > > > -               sg_policy->limits_changed =3D false;
> > > >                 sg_policy->need_freq_update =3D cpufreq_driver_test=
_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > >                 return true;
> > > >         }
> > > > @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov=
_policy *sg_policy,
> > > >         freq =3D get_capacity_ref_freq(policy);
> > > >         freq =3D map_util_freq(util, freq, max);
> > > >
> > > > -       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->n=
eed_freq_update)
> > > > +       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->l=
imits_changed &&
> > > > +           !sg_policy->need_freq_update)
> > > >                 return sg_policy->next_freq;
> > > >
> > > > +       sg_policy->limits_changed =3D false;
> > >
> > > AFAICS, after this code modification, a limit change may be missed du=
e
> > > to a possible race with sugov_limits() which cannot happen if
> > > sg_policy->limits_changed is only cleared when it is set before
> > > updating sg_policy->need_freq_update.
> >
> > I don't think that's the case because sg_policy->limits_changed is clea=
red
> > before the new policy limits are evaluated in cpufreq_driver_resolve_fr=
eq().
>
> sugov_limits() may be triggered by a scaling_max_freq update, for
> instance, so it is asynchronous with respect to the usual governor
> flow.  It updates sg_policy->limits_changed and assumes that next time
> the governor runs, it will call into the driver, for example via
> cpufreq_driver_fast_switch(), so the new limits take effect.  This is
> not about cpufreq_driver_resolve_freq().
>
> sugov_limits() runs after the driver's ->verify() callback has
> returned and it is conditional on that callback's return value, so the
> driver already knows the new limits when sugov_limits() runs, but it
> may still need to tell the hardware what the new limits are and that's
> why cpufreq_driver_fast_switch() may need to run.
>
> Now, if sugov_should_update_freq() sees sg_policy->limits_changed set,
> it will set sg_policy->need_freq_update which (for drivers with
> CPUFREQ_NEED_UPDATE_LIMITS set) guarantees that the driver will be
> invoked and so sg_policy->limits_changed can be cleared.
>
> If a new instance of sugov_limits() runs at this point, there are two
> possibilities.  Either it completes before the
> sg_policy->limits_changed update in sugov_should_update_freq(), in
> which case the driver already knows the new limits as per the above
> and so the subsequent invocation of cpufreq_driver_fast_switch() will
> pick them up, or it sets sg_policy->limits_changed again and the
> governor will see it set next time it runs.  In both cases the new
> limits will be picked up unless they are changed again in the
> meantime.
>
> After the above change, sg_policy->limits_changed may be cleared even
> if it has not been set before and that's problematic.  Namely, say it
> is unset when sugov_should_update_freq() runs, after being called by
> sugov_update_single_freq() via sugov_update_single_common(), and
> returns 'true' without setting sg_policy->need_freq_update.  Next,
> sugov_update_single_common() returns 'true' and get_next_freq() is
> called.  It sees that freq !=3D sg_policy->cached_raw_freq, so it clears
> sg_policy->limits_changed.  If sugov_limits() runs on a different CPU
> between the check and the sg_policy->limits_changed update in
> get_next_freq(), it may be missed and it is still not guaranteed that
> cpufreq_driver_fast_switch() will run because
> sg_policy->need_freq_update is unset and sugov_hold_freq() may return
> 'true'.
>
> For this to work, sg_policy->limits_changed needs to be cleared only
> when it is set and sg_policy->need_freq_update needs to be updated
> when sg_policy->limits_changed is cleared.
>
> It looks like you really want to set sg_policy->need_freq_update to
> 'true' in sugov_should_update_freq() when sg_policy->limits_changed is
> set, but that would render CPUFREQ_NEED_UPDATE_LIMITS unnecessary.

As I've just said in the original patch thread, it looks like using
sg_policy->policy->fast_switch_enabled instead of
cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS) in
sugov_should_update_freq() should do the trick and then (if this
works), CPUFREQ_NEED_UPDATE_LIMITS can be dropped.

