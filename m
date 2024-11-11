Return-Path: <linux-pm+bounces-17327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9F9C3FFC
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 14:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A8128607F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114A119E804;
	Mon, 11 Nov 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMeHDRPw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1B19E7F3;
	Mon, 11 Nov 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333299; cv=none; b=NIZQTJSgjTnY6Tbv2XNqqGNpk6bqcA5/lgcAjPtzBYGogXorGpbaA43xcmQeZj/NYKRaCRE9EBAy8yfKBhiKTO5CkmU1yeKA9l/NdhNEZx3cRbLSIujKyuTvsa+zAVgwan2RhCrPYidhkSYljUACxh660CCXv/XOWZ8giQJ+iSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333299; c=relaxed/simple;
	bh=Rjs1jrNMYmsLc1015VUvOXMFguCnVmldjZ3ChN/Xhk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNpZBgclwRFEJ/x7ogMxOLvLMSsbjqDdLR3UphRemM1C9V2JjqX9I/5SOUicoAzr4C4GRSlsX2ixbTutIk8Mhl9Zy/d/Lje/ixcHhhTIfnAPVaPynTQnHHDuLRRAw3OWYS28F0STlba05zHTXHJk6zF5Hc4sDWWqlV8ypGyCGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMeHDRPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674DCC4CED6;
	Mon, 11 Nov 2024 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731333298;
	bh=Rjs1jrNMYmsLc1015VUvOXMFguCnVmldjZ3ChN/Xhk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OMeHDRPwTo7a/NAgf/rNxNEb/9JmWkN0ZJPZWsq8oeWjE0JW85PLqcPVNU4xhC7Ww
	 sorpqyRlasDKxSUvlofXkO+FIjFtPmQEalPiFsSO/qQxfY5ZPkoSjUFaMWdQa6uFt6
	 UHwC2mtUS7DqH0qbZuy0YmRQZtRud5cZK1Fw1zSA6eZHwRn9YeUoH0LCNSZrJk5Xpw
	 IY4NS1d39qX0XIJDQI7KFbsQ6F5xBiHXBnyMMAEQD64HHNZchMhPa5acHPR4OjXHtc
	 50rDZzVWhl5UAKLK35i02DAg4WIOZwKsRmlu8qJm68IIMMPXz8koiTeI468IFk8sz7
	 Ijg+MwiRo+fQQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-288d4da7221so2437836fac.1;
        Mon, 11 Nov 2024 05:54:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJKGCjFl+8NcWXKi5z8D89AuLodW44pqhnOu2PbzPvLri1Sf7PtIyJIPA7gORLJlwKLmOYJ4+r8b8=@vger.kernel.org, AJvYcCW+/IG8EnrwCwQM1C4CVH8Pyr8BzR7b4YmjaUvrhtCPV4l1aGVGvNpsfuuf3UkvDcNX/4K6aqTNS/ycJwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdl0llbabmOcNInCta+7wF8t2g6IHVhC2Y4Hw8WKsALGZk2ldm
	B/m7XapSXxgdEz2I9v/5tNNvD4EsQDALwalfCvrXSP2jgsKOsdGX68dFL9u42fzRUuPiIM68qG2
	jFuldkbctKfMqQZ/ONebZnYGoPTs=
X-Google-Smtp-Source: AGHT+IFR+kLg1jK/nBNUD03fNNcBn24h36a1Kg6p1I0dLiKQdViNNgeVyLEdCLKYmkYhyu7OU3yzUKvA0rmDdZ6IKVI=
X-Received: by 2002:a05:6870:3312:b0:277:ecd2:7b7 with SMTP id
 586e51a60fabf-2955ffe9868mr10202835fac.7.1731333297633; Mon, 11 Nov 2024
 05:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3607404.iIbC2pHGDl@rjwysocki.net> <1889415.atdPhlSkOF@rjwysocki.net>
 <64a63f1c-088d-43dc-85c3-cecf8b59764f@arm.com>
In-Reply-To: <64a63f1c-088d-43dc-85c3-cecf8b59764f@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Nov 2024 14:54:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hrj0jQ9mi20XRK3bTfaMDgUS3HyGnk=2x0UfF26jN1pQ@mail.gmail.com>
Message-ID: <CAJZ5v0hrj0jQ9mi20XRK3bTfaMDgUS3HyGnk=2x0UfF26jN1pQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v0.1 5/6] sched/topology: Allow .setpolicy() cpufreq
 drivers to enable EAS
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 12:54=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/8/24 16:41, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Some cpufreq drivers, like intel_pstate, have built-in governors that
> > are used instead of regular cpufreq governors, schedutil in particular,
> > but they can work with EAS just fine, so allow EAS to be used with
> > those drivers.
> >
> > Also update the debug message printed when the cpufreq governor in
> > use is not schedutil and the related comment, to better match the
> > code after the change.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > I'm not sure how much value there is in refusing to enable EAS without
> > schedutil in general.  For instance, if there are no crossover points
> > between the cost curves for different perf domains, EAS may as well be
> > used with the performance and powersave governors AFAICS.
>
> Agreed, but having no cross-over points or no DVFS at all should be the
> only instances, right?

Not really.  This is the most obvious case, but there are other less
obvious ones.

Say there are two cross-over points: The  "performance" and
"powersave" governors should still be fine with EAS in that case.

Or what if somebody has a governor in user space that generally
behaves like schedutil?

Or what about ondemand?  Is it alway completely broken with EAS?

> For plain (non-intel_pstate) powersave and performance we could replace
> sugov_effective_cpu_perf()
> that determines the OPP of the perf-domain by the OPP they will be
> choosing, but for the rest?

I generally think that depending on schedutil for EAS is a mistake.

I would just print a warning that results may be suboptimal or
generally not as expected if the cpufreq governor is not schedutil
instead of preventing EAS from running at all.

> Also there is the entire uclamp thing, not sure what the best
> solution is there.
> Will intel_pstate just always ignore it? Might be better then to
> depend on !intel_pstate?

Well, it can be made dependent on policy->policy =3D=3D
CPUFREQ_POLICY_POWERSAVE if gov is NULL or similar, but honestly why
bother?

> > ---
> >  kernel/sched/topology.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/kernel/sched/topology.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/kernel/sched/topology.c
> > +++ linux-pm/kernel/sched/topology.c
> > @@ -251,7 +251,7 @@ static bool sched_is_eas_possible(const
> >               return false;
> >       }
> >
> > -     /* Do not attempt EAS if schedutil is not being used. */
> > +     /* Do not attempt EAS with a cpufreq governor other than scheduti=
l. */
> >       for_each_cpu(i, cpu_mask) {
> >               policy =3D cpufreq_cpu_get(i);
> >               if (!policy) {
> > @@ -263,9 +263,9 @@ static bool sched_is_eas_possible(const
> >               }
> >               gov =3D policy->governor;
> >               cpufreq_cpu_put(policy);
> > -             if (gov !=3D &schedutil_gov) {
> > +             if (gov && gov !=3D &schedutil_gov) {
> >                       if (sched_debug()) {
> > -                             pr_info("rd %*pbl: Checking EAS, scheduti=
l is mandatory\n",
> > +                             pr_info("rd %*pbl: Checking EAS, cpufreq =
governor is not schedutil\n",
> >                                       cpumask_pr_args(cpu_mask));
> >                       }
> >                       return false;
> >
> >
> >
> >
>
>

