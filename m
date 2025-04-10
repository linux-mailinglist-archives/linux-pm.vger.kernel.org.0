Return-Path: <linux-pm+bounces-25177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83802A84DF3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 22:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFE49A68C9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD40628C5CE;
	Thu, 10 Apr 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN0IVSA3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD41DF965;
	Thu, 10 Apr 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315787; cv=none; b=HH6HMUvhmd+54aQSc3A/wy3ehF/o7Ya+cZzqEygZBNLRJjqthK29zC30gjSI/RSJo3SaVQONQf4zV7RVEOKEMnC6wXhTly1NjUlvgygPWKaRx7W+tsVRjfcZtBRu2hly8pul/JOQ8PKJTjQi6cumDSOsgWayBP6yZJYqve7sD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315787; c=relaxed/simple;
	bh=VCLSk9fBslPdp1dUYtYC1hn/7AWRL+qOOaiAOMAVPe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUmQr+qOCLiimb2L21x2/WW/hTMCNJyKnot35slcC/f/3+3nooyXBrJ6itTG9t8tMmkc84BnaRQcgHlD+s11xpCBFIXGw95WgadYIef+ijCY/RP4xM1raXalAe6aZTYZC2k9oUFP+W+pIyAoen/nqsihkqpCnRYXDP+CwyhthrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN0IVSA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FF8C4CEDD;
	Thu, 10 Apr 2025 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744315787;
	bh=VCLSk9fBslPdp1dUYtYC1hn/7AWRL+qOOaiAOMAVPe8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BN0IVSA37HbLCrfSKl/Cp7zcTABYsHdvuglZZ3EVFIzI3UOPsmDDJ5I3l5GxwisaS
	 vPCW2/KxNdRVzYsi5jPMw/pEVubL2oBM1USZn/fzAUrFPV2/6TSaWgyrRAq/ydcNcU
	 4QmZkcsdD648WXN15wJBlgPDrDL1V04ApP14yXRjVZ6TWk7MxlgMmqwKn9z+8lHG1b
	 w5oCNiq0kXzu5DbkTrwhxUeRcvcLDeUws/gh1j9vgrP4yXzznmKiqEKedcgTwG6IMb
	 AqbArnWzFzpVePn9JNaddQEsgFVt6LMxXhVk4cbsyCRds97x5VENAdrWQazOcSJYvW
	 avC6paggLvw2w==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72a0a9cb29fso767292a34.0;
        Thu, 10 Apr 2025 13:09:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3BmUXCfrMw9Usu+YM8JGBu5u4gj2GkuAmlDaN7UjHLYH8ITM6d/knERQB+z6b2A28qY8NgEmeS74=@vger.kernel.org, AJvYcCWqqPSppATTTFZ7fhf29XbNHsd4AdXy8LFE3nKOJLp2mQNUPsgnSlyUdPTFpu/joo2eLGkSMpt12mr8f/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HWe1f7aGkHxXQMPeQLgLbHNCqKGsa24/HDCUr9xScAxPY8Oe
	FnJIi5QDYiTl+RVmJj2UbGjpf0SOl/2FcerXzUHBxn04bM6FchG7hDGTPD0bk9zxmbg3kJJaYOv
	l0VOh433MkvIhMk8Q4+UtQ+yhxts=
X-Google-Smtp-Source: AGHT+IGpl09bG3hSDi7YiAND88W++ptwDhL1paNDcaoRQmKfpuVt5OiQgwrWQ2Vhkn/AtgQqshWkpcrb7JiSMSxEKYQ=
X-Received: by 2002:a05:6830:6713:b0:72b:9bb3:67cd with SMTP id
 46e09a7af769-72e863da72emr193893a34.12.1744315786405; Thu, 10 Apr 2025
 13:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410024439.20859-1-sultan@kerneltoast.com>
 <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com>
 <Z_fru1i1OpAQ-hJq@sultan-box.localdomain> <CAJZ5v0iu_hMud6FRg6FiUVQ1cY6oYqrEmwpwPTeYJh5Yzh5Q8A@mail.gmail.com>
 <Z_gbXSeo6kjOXhwE@sultan-box.localdomain> <CAJZ5v0h7dsL+tQAEtJ_t-_p2Uxkaz=Kf-fUCKTvs7F7BLgqCiw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h7dsL+tQAEtJ_t-_p2Uxkaz=Kf-fUCKTvs7F7BLgqCiw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 22:09:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gZX55=VncNSk6xfar5t4bTF0b=kOi6AGuNvbg1HRB+DA@mail.gmail.com>
X-Gm-Features: ATxdqUH7FPA2r2zjKsKfz4e8mx22A83lNWkvTRhIlWsk6-nQ1fONHCRDmxWt1oE
Message-ID: <CAJZ5v0gZX55=VncNSk6xfar5t4bTF0b=kOi6AGuNvbg1HRB+DA@mail.gmail.com>
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

On Thu, Apr 10, 2025 at 9:50=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Apr 10, 2025 at 9:26=E2=80=AFPM Sultan Alsawaf <sultan@kerneltoas=
t.com> wrote:
> >
> > On Thu, Apr 10, 2025 at 08:47:38PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Apr 10, 2025 at 6:03=E2=80=AFPM Sultan Alsawaf <sultan@kernel=
toast.com> wrote:
> > > >
> > > > On Thu, Apr 10, 2025 at 05:34:39PM +0200, Rafael J. Wysocki wrote:
> > > > > On Thu, Apr 10, 2025 at 4:45=E2=80=AFAM Sultan Alsawaf <sultan@ke=
rneltoast.com> wrote:
> > > > > >
> > > > > > From: Sultan Alsawaf <sultan@kerneltoast.com>
> > > > > >
> > > > > > When utilization is unchanged, a policy limits update is ignore=
d unless
> > > > > > CPUFREQ_NEED_UPDATE_LIMITS is set. This occurs because limits_c=
hanged
> > > > > > depends on the old broken behavior of need_freq_update to trigg=
er a call
> > > > > > into cpufreq_driver_resolve_freq() to evaluate the changed poli=
cy limits.
> > > > > >
> > > > > > After fixing need_freq_update, limit changes are ignored withou=
t
> > > > > > CPUFREQ_NEED_UPDATE_LIMITS, at least until utilization changes =
enough to
> > > > > > make map_util_freq() return something different.
> > > > > >
> > > > > > Fix the ignored limit changes by preserving the value of limits=
_changed
> > > > > > until get_next_freq() is called, so limits_changed can trigger =
a call to
> > > > > > cpufreq_driver_resolve_freq().
> > > > > >
> > > > > > Reported-and-tested-by: Stephan Gerhold <stephan.gerhold@linaro=
.org>
> > > > > > Link: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org
> > > > > > Fixes: 8e461a1cb43d6 ("cpufreq: schedutil: Fix superfluous upda=
tes caused by need_freq_update")
> > > > > > Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > > > > > ---
> > > > > >  kernel/sched/cpufreq_schedutil.c | 5 +++--
> > > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cp=
ufreq_schedutil.c
> > > > > > index 1a19d69b91ed3..f37b999854d52 100644
> > > > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > > > @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct s=
ugov_policy *sg_policy, u64 time)
> > > > > >                 return false;
> > > > > >
> > > > > >         if (unlikely(sg_policy->limits_changed)) {
> > > > > > -               sg_policy->limits_changed =3D false;
> > > > > >                 sg_policy->need_freq_update =3D cpufreq_driver_=
test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > > > >                 return true;
> > > > > >         }
> > > > > > @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct s=
ugov_policy *sg_policy,
> > > > > >         freq =3D get_capacity_ref_freq(policy);
> > > > > >         freq =3D map_util_freq(util, freq, max);
> > > > > >
> > > > > > -       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_polic=
y->need_freq_update)
> > > > > > +       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_polic=
y->limits_changed &&
> > > > > > +           !sg_policy->need_freq_update)
> > > > > >                 return sg_policy->next_freq;
> > > > > >
> > > > > > +       sg_policy->limits_changed =3D false;
> > > > >
> > > > > AFAICS, after this code modification, a limit change may be misse=
d due
> > > > > to a possible race with sugov_limits() which cannot happen if
> > > > > sg_policy->limits_changed is only cleared when it is set before
> > > > > updating sg_policy->need_freq_update.
> > > >
> > > > I don't think that's the case because sg_policy->limits_changed is =
cleared
> > > > before the new policy limits are evaluated in cpufreq_driver_resolv=
e_freq().
> > >
> > > sugov_limits() may be triggered by a scaling_max_freq update, for
> > > instance, so it is asynchronous with respect to the usual governor
> > > flow.  It updates sg_policy->limits_changed and assumes that next tim=
e
> > > the governor runs, it will call into the driver, for example via
> > > cpufreq_driver_fast_switch(), so the new limits take effect.  This is
> > > not about cpufreq_driver_resolve_freq().
> >
> > OK, though I think there's still a race in cpufreq_driver_resolve_freq(=
).
> >
> > > sugov_limits() runs after the driver's ->verify() callback has
> > > returned and it is conditional on that callback's return value, so th=
e
> > > driver already knows the new limits when sugov_limits() runs, but it
> > > may still need to tell the hardware what the new limits are and that'=
s
> > > why cpufreq_driver_fast_switch() may need to run.
> >
> > Which is why CPUFREQ_NEED_UPDATE_LIMITS exists, right.
> >
> > > Now, if sugov_should_update_freq() sees sg_policy->limits_changed set=
,
> > > it will set sg_policy->need_freq_update which (for drivers with
> > > CPUFREQ_NEED_UPDATE_LIMITS set) guarantees that the driver will be
> > > invoked and so sg_policy->limits_changed can be cleared.
> > >
> > > If a new instance of sugov_limits() runs at this point, there are two
> > > possibilities.  Either it completes before the
> > > sg_policy->limits_changed update in sugov_should_update_freq(), in
> > > which case the driver already knows the new limits as per the above
> > > and so the subsequent invocation of cpufreq_driver_fast_switch() will
> > > pick them up, or it sets sg_policy->limits_changed again and the
> > > governor will see it set next time it runs.  In both cases the new
> > > limits will be picked up unless they are changed again in the
> > > meantime.
> > >
> > > After the above change, sg_policy->limits_changed may be cleared even
> > > if it has not been set before and that's problematic.  Namely, say it
> > > is unset when sugov_should_update_freq() runs, after being called by
> > > sugov_update_single_freq() via sugov_update_single_common(), and
> > > returns 'true' without setting sg_policy->need_freq_update.  Next,
> > > sugov_update_single_common() returns 'true' and get_next_freq() is
> > > called.  It sees that freq !=3D sg_policy->cached_raw_freq, so it cle=
ars
> > > sg_policy->limits_changed.  If sugov_limits() runs on a different CPU
> > > between the check and the sg_policy->limits_changed update in
> > > get_next_freq(), it may be missed and it is still not guaranteed that
> > > cpufreq_driver_fast_switch() will run because
> > > sg_policy->need_freq_update is unset and sugov_hold_freq() may return
> > > 'true'.
> > >
> > > For this to work, sg_policy->limits_changed needs to be cleared only
> > > when it is set and sg_policy->need_freq_update needs to be updated
> > > when sg_policy->limits_changed is cleared.
> >
> > Ah I see, thank you for the detailed explanation. So if I am understand=
ing it
> > correctly: the problem with my patch is that CPUFREQ_NEED_UPDATE_LIMITS=
 might
> > not be honored after a limits change, because CPUFREQ_NEED_UPDATE_LIMIT=
S is only
> > honored when sg_policy->limits_changed is set. So there is the followin=
g race:
> >
> >            CPU-A                    CPU-B
> >   sugov_should_update_freq()                    // sg_policy->limits_ch=
anged =3D=3D false, sg_policy->need_freq_update =3D=3D false
> >                                 sugov_limits()  // sg_policy->limits_ch=
anged =3D=3D true,  sg_policy->need_freq_update =3D=3D false
> >   get_next_freq()                               // sg_policy->limits_ch=
anged =3D=3D false, sg_policy->need_freq_update =3D=3D false
> >
> >   // cpufreq driver won't be invoked for the limits change if:
> >   // next_f =3D=3D sg_policy->next_freq || (sugov_hold_freq() =3D=3D tr=
ue && next_f < sg_policy->next_freq)
> >
> > Does that look right?
>
> Yes, it does.
>
> > > It looks like you really want to set sg_policy->need_freq_update to
> > > 'true' in sugov_should_update_freq() when sg_policy->limits_changed i=
s
> > > set, but that would render CPUFREQ_NEED_UPDATE_LIMITS unnecessary.
> > >
> > > > Granted, if we wanted to be really certain of this, we'd need relea=
se semantics.
> > >
> > > I don't think so, but feel free to prove me wrong.
> >
> > Well, it appears that there really is synchronization missing between
> > cpufreq_set_policy() and schedutil, since cpufreq_set_policy() changes =
the live
> > policy->min and policy->max, and schedutil may observe either the old v=
alues in
> > there or garbage values due to load/store tearing.
>
> schedutil itself doesn't really read policy->min and policy->max.
> cpufreq_driver_resolve_freq() does this and drivers do, but since
> policy->min and policy->max are integers, no garbage values will be
> observed AFAICS.

Well, I've just realized that this is not exactly the case because of
the way in which __resolve_freq() is used in cpufreq_set_policy().
That needs to be fixed.

