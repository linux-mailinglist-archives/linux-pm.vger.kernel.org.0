Return-Path: <linux-pm+bounces-25003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF880A8237A
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 13:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE273177A1A
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358925D556;
	Wed,  9 Apr 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTlNcUDW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129FEEC5;
	Wed,  9 Apr 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197925; cv=none; b=jiLwvzxbmJUYL/jHOzOEeVTz4zrSYu22azMHwcgszylsjpe9p7PAQaHXRxmNNQlouEx340AB5yyu1AsAVwS5ntALn+4dMs6xT2JDrVv9d/Q9IsS/arG70XzAfdy5BJ4AIuTjSjiyTr71fwXUueYv5sjO8yIIZMg5Sv2ZUOG9XOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197925; c=relaxed/simple;
	bh=RcNU03lrtQuhmutMROPCRXVWbRhoFLtCjP17Vu0QoVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQA21fErupzYvXw4cw7o0MGTbU96LuAAfbaLyIhWaj4ME8mZ45V6hxcJPHh1CIJSD555YArgQCJ3e0Wml6k9HRCvbEPyQzxM+Fn6LyjImh6sf5mNUUtaQaeALk436JL+F5xx14P1x8uKL0t3d66mbNSdqj2ZeBFgMrAClFVQqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTlNcUDW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4774d68c670so90331361cf.0;
        Wed, 09 Apr 2025 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744197923; x=1744802723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnyLqtBTNJZVUdoCJvAQWi3Um+ZI5CcOSV6TWLhi+rY=;
        b=nTlNcUDWPt5X2s4boA7bmzBYydDvo3RvadpZmq3ZqxzjwqAOgWsqTDOr3aosNMsMJx
         QKSWWDItB9obuuwnbXIe5LfTdiwi5OwzB4PeeP8a+33qwjjWFjOyBmPPMf65CmbYX5kU
         LkgFe76hg/ZziSfVwStT2HeUPkD0qR/2Eyp6KIztNze0T1d+BTT8YxG0fVP7+sW0lciP
         BTp4rNXIx0Awb3lGC9As1yzg00rqi11z+jLf/O4b/5Het3Uf0SeW6XnzqVN4KWGKmXK8
         BZWzsnUCKfhDvjWatAtNe132I+JMecKoefUQzySKehqgajxB64448HRGZDpl6Dkwpx35
         Cxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744197923; x=1744802723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnyLqtBTNJZVUdoCJvAQWi3Um+ZI5CcOSV6TWLhi+rY=;
        b=V6oHX5H0qtoBkBLH0qt9AGtOYEqOuh/L45GwbumvtCjJij0sU6Gg/ylK0bNfDfrjqv
         FpeK50dOu6P1ApeJFaAubFxqDFR+iEM/vZN1jEyymUBGcrbaq9Gc4Q8qhYJUffu2ERi7
         yxdVX7+7dPLXikVCloGoXl2wI6xn0Mqlf5BJ/Hd2GQwHOzcxk6l33ML/VVlKOuzhUYmJ
         lwasKCFH0GKuaizz2izMjwdfCyMPKifGIezt9vHI+4alG5g2xS9cUyJs/a9YBOgoyhwv
         LeH/QZJrzrl+EWagPN0QphWW3NEkjOW1jUvh94BhgMhi6DYHTKUph3nFLMjK1PtR7ZX6
         UTjw==
X-Forwarded-Encrypted: i=1; AJvYcCUeVH/ge6lgl8AsLvWwNz7DaQzy2yWZ0UMH7m3by9wIXs+hN9ta+NGGPTytfrgaHMreb7AA6Ncv13Q=@vger.kernel.org, AJvYcCUtBhQLFhH6D76mhw7GqgK2BRtGHtlqttqo7NE9HZu3NlUcGRNwF3MtFhst6W6tzYrcxjJ1Fx/DIop/FaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvCfDKt+/ccyyBEvZ156sptNItPuxSuAWHK5IQcbzgIrHulwi0
	8lX6U7s7YXFW6WO+8lXHIhcZInd7zI0HzM3v9IlTWGVYoy/3MgqlczENijdKs4PSoBcB3JA/GFe
	bpeGJ87cBfL98nEO10mTEZmJDQz+weuzy
X-Gm-Gg: ASbGncs6u7nrJsQnGUrKg5xumB+aq7pO7/0g5aEEmdT4HR0bhpVhsVqolnaygy0tAUW
	/6+5jrb+xDWOpoL81LCr70sIQqrN6MmBmD+t5s9NVSmtRoM5hnJz+NqEbi790po4+2nGFEDTymL
	lCgfmCPTgTOPQ9OzdiQf1cyKI=
X-Google-Smtp-Source: AGHT+IGdiIrEZJnGuWVnUKG4etRiEutplJRSBSm9MCLkg2DuvhKn3FBarw29Ide8aUJcGksVXizG9+RfvLzOTuWj2BA=
X-Received: by 2002:ac8:5dd1:0:b0:477:dcc:6c18 with SMTP id
 d75a77b69052e-479600a2faamr27545171cf.14.1744197922803; Wed, 09 Apr 2025
 04:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com> <Z_Tlc6Qs-tYpxWYb@linaro.org>
 <Z_U_LN0AtH_n4YtE@sultan-box.localdomain> <Z_VTRspvmOUfrawh@linaro.org>
In-Reply-To: <Z_VTRspvmOUfrawh@linaro.org>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 9 Apr 2025 19:25:10 +0800
X-Gm-Features: ATxdqUHOE1vmAS5iu3NM1Du1EdGsUY0tFO7YrFDtFnHMDS5wAjZf84trNC65A3g
Message-ID: <CAB8ipk8ARRdR8UPgLqJ3EcAzuE4KNEO=cmLNJLk6thTxdBSHWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused by need_freq_update
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sultan,

On Wed, Apr 9, 2025 at 12:50=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> Hi Sultan,
>
> On Tue, Apr 08, 2025 at 08:22:20AM -0700, Sultan Alsawaf wrote:
> > On Tue, Apr 08, 2025 at 10:59:31AM +0200, Stephan Gerhold wrote:
> > > On Wed, Dec 11, 2024 at 05:57:32PM -0800, Sultan Alsawaf wrote:
> > > > From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
> > > >
> > > > A redundant frequency update is only truly needed when there is a p=
olicy
> > > > limits change with a driver that specifies CPUFREQ_NEED_UPDATE_LIMI=
TS.
> > > >
> > > > In spite of that, drivers specifying CPUFREQ_NEED_UPDATE_LIMITS rec=
eive a
> > > > frequency update _all the time_, not just for a policy limits chang=
e,
> > > > because need_freq_update is never cleared.
> > > >
> > > > Furthermore, ignore_dl_rate_limit()'s usage of need_freq_update als=
o leads
> > > > to a redundant frequency update, regardless of whether or not the d=
river
> > > > specifies CPUFREQ_NEED_UPDATE_LIMITS, when the next chosen frequenc=
y is the
> > > > same as the current one.
> > > >
> > > > Fix the superfluous updates by only honoring CPUFREQ_NEED_UPDATE_LI=
MITS
> > > > when there's a policy limits change, and clearing need_freq_update =
when a
> > > > requisite redundant update occurs.
> > > >
> > > > This is neatly achieved by moving up the CPUFREQ_NEED_UPDATE_LIMITS=
 test
> > > > and instead setting need_freq_update to false in sugov_update_next_=
freq().
> > > >
> > > > Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
> > > > ---
> > > >  kernel/sched/cpufreq_schedutil.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufre=
q_schedutil.c
> > > > index 28c77904ea74..e51d5ce730be 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov=
_policy *sg_policy, u64 time)
> > > >
> > > >   if (unlikely(sg_policy->limits_changed)) {
> > > >           sg_policy->limits_changed =3D false;
> > > > -         sg_policy->need_freq_update =3D true;
> > > > +         sg_policy->need_freq_update =3D cpufreq_driver_test_flags=
(CPUFREQ_NEED_UPDATE_LIMITS);
> > > >           return true;
> > > >   }
> > > >
> > > > @@ -96,7 +96,7 @@ static bool sugov_update_next_freq(struct sugov_p=
olicy *sg_policy, u64 time,
> > > >                              unsigned int next_freq)
> > > >  {
> > > >   if (sg_policy->need_freq_update)
> > > > -         sg_policy->need_freq_update =3D cpufreq_driver_test_flags=
(CPUFREQ_NEED_UPDATE_LIMITS);
> > > > +         sg_policy->need_freq_update =3D false;
> > > >   else if (sg_policy->next_freq =3D=3D next_freq)
> > > >           return false;
> > > >
> > >
> > > This patch breaks cpufreq throttling (e.g. for thermal cooling) for
> > > cpufreq drivers that:
> > >
> > >  - Have policy->fast_switch_enabled/fast_switch_possible set, but
> > >  - Do not have CPUFREQ_NEED_UPDATE_LIMITS flag set
> > >
> > > There are several examples for this in the tree (search for
> > > "fast_switch_possible"). Of all those drivers, only intel-pstate and
> > > amd-pstate (sometimes) set CPUFREQ_NEED_UPDATE_LIMITS.
> > >
> > > I can reliably reproduce this with scmi-cpufreq on a Qualcomm X1E
> > > laptop:
> > >
> > >  1. I added some low temperature trip points in the device tree,
> > >     together with passive cpufreq cooling.
> > >  2. I run a CPU stress test on all CPUs and monitor the temperatures
> > >     and CPU frequencies.
> > >
> > > When using "performance" governor instead of "schedutil", the CPU
> > > frequencies are being throttled as expected, as soon as the temperatu=
re
> > > trip points are reached.
> > >
> > > When using "schedutil", the CPU frequencies stay at maximum as long a=
s
> > > the stress test is running. No throttling happens, so the device heat=
s
> > > up far beyond the defined temperature trip points. Throttling is appl=
ied
> > > only after stopping the stress test, since this forces schedutil to
> > > re-evaluate the CPU frequency.
> > >
> > > Reverting this commit fixes the problem.
> > >
> > > Looking at the code, I think the problem is that:
> > >  - sg_policy->limits_changed does not result in
> > >    sg->policy->need_freq_update without CPUFREQ_NEED_UPDATE_LIMITS
> > >    anymore, and
> > >  - Without sg->policy->need_freq_update, get_next_freq() skips callin=
g
> > >    cpufreq_driver_resolve_freq(), which would normally apply the poli=
cy
> > >    min/max constraints.
> > >
> > > Do we need to set CPUFREQ_NEED_UPDATE_LIMITS for all cpufreq drivers
> > > that set policy->fast_switch_possible? If I'm reading the documentati=
on
> > > comment correctly, that flag is just supposed to enable notifications=
 if
> > > the policy min/max changes, but the resolved target frequency is stil=
l
> > > the same. This is not the case here, the target frequency needs to be
> > > throttled, but schedutil isn't applying the new limits.
> > >
> > > Any suggestions how to fix this? I'm happy to test patches with my
> > > setup.
> >
> > Thank you for reporting this. As I see it, sg_policy->need_freq_update =
is
> > working correctly now; however, sg_policy->limits_changed relied on the=
 broken
> > behavior of sg_policy->need_freq_update and therefore sg_policy->limits=
_changed
> > needs to be fixed.
>
> Thanks for the quick reply and the patch!
>
> >
> > Can you try this patch:
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index 1a19d69b91ed3..f37b999854d52 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov_pol=
icy *sg_policy, u64 time)
> >               return false;
> >
> >       if (unlikely(sg_policy->limits_changed)) {
> > -             sg_policy->limits_changed =3D false;
> >               sg_policy->need_freq_update =3D cpufreq_driver_test_flags=
(CPUFREQ_NEED_UPDATE_LIMITS);
> >               return true;
> >       }
> > @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov_pol=
icy *sg_policy,
> >       freq =3D get_capacity_ref_freq(policy);
> >       freq =3D map_util_freq(util, freq, max);
> >
> > -     if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->need_fr=
eq_update)
> > +     if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->limits_=
changed &&
> > +         !sg_policy->need_freq_update)

We also should add the limits_changed in the sugov_update_single_freq().

> >               return sg_policy->next_freq;
> >
> > +     sg_policy->limits_changed =3D false;

Maybe this should be add in the sugov_update_next_freq()=EF=BC=8Cbecause, b=
oth
sugov_update_single_freq() and sugov_update_shared(),
the sugov_update_next_freq() is after the freq check.

> >       sg_policy->cached_raw_freq =3D freq;
> >       return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> >
>
> This is working correctly for me, CPU frequency is being throttled again
> when the temperature trip points are reached. If you send this, feel
> free to add:
>
> Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
>
> Thanks!
> Stephan
>

