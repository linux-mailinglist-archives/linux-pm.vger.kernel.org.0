Return-Path: <linux-pm+bounces-19398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E19F57ED
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 21:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5ED16986A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D4E1F9431;
	Tue, 17 Dec 2024 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiG8s1dE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4C4A23;
	Tue, 17 Dec 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468068; cv=none; b=s1DRnANkCuF/0ei3zvNdhHZU2xqfAAziJdt88spgit4XJUFuwxIRu4RLdvggySL1/K78aMHd1HvFKvg52N0yZgVaJ6d5VX6XaCfWz6GxE9rMq2ZxwMKWcMeg+TKkQaT26VmCUZokGOq6s/8a60TSFsHpnHJ7Q/l3IPkgEmi3ltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468068; c=relaxed/simple;
	bh=wmhWeMx+gds3+4ecDMaKGnZvDldM5ni/4Zm1/MDMBrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8jWJhjo8kHzCl4yogKjCPrA5m/JRgbRrFT7SqG+ikY2o8lddsLISsE/fziw8TyMEyFcVDy70GMZ67XNpHladZiv+MukVMthQAI1wiloDfgaRcqMlIjVuQPziEi6buhtVZNm8gymq6IvvRyKYUmFUnSME0EGqo52pkkyCAircFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiG8s1dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793C3C4CED3;
	Tue, 17 Dec 2024 20:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734468067;
	bh=wmhWeMx+gds3+4ecDMaKGnZvDldM5ni/4Zm1/MDMBrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AiG8s1dEaRbb3EGfuyFpaiP+0Z+kT1RFdXb7QslHDjJV6yxqEanjbsCkXXSxxE2LA
	 +deBCGzY/O1417XVbHwfsNk1Hl9UwF6+uqd62rcfF/UKL1E1hajVfuIMJTo2oX0JpO
	 f13jj3RBqJbZ81TQQll4Z6g3h7itUHfId00mygAmMLAIOIc8osoR9cuZRly+x0aos/
	 a3h1W0i3Lnob02kjZwim8SBumyWcszr6+TvvJ4Y+DS8MMWJf+rKFYXwM5qmhGH4g9R
	 pfFPDGL5+prv+k59XW63p7xjUwZy10de38VpSTZWdwhFqEH94HWVj+BJRXlSI1ZmwD
	 Ri1FddHmE0YwA==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eb9a0a2089so3220633b6e.1;
        Tue, 17 Dec 2024 12:41:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOhlevhL/Ed6SSvBb1LTrYR6Ywe0GJZT8uWtVzGqku9M+xhyTWYQKqKdHdCEYGY1xIZ52SDsenjTPLLnU=@vger.kernel.org, AJvYcCXg18kHuParZsMXumXC2tk/L1guI2dSTuTN3dWBs2Kk6/nl5p/dq0m4EDJIuM3ayiqOTP88yt18t94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5AQaCHP3fekynVlaw3rV2Vj9UCkBtGGnMVlRGJUHMXFGFC/HV
	dvEDfo3dip2xk3Kdlc3hJSoYaZkDvtFfF3QBEXNbs3fPXIGQDVx4VRAAUrTXZDqK9HM0YxDA6Mm
	bYgr46AoTpepOCtLANVOUOuUiDTg=
X-Google-Smtp-Source: AGHT+IFOVEpT5HsqFqM4Ll0rAEIKFoyK6uzQUX8dHSgM2ZerqFUh/QCL+YmPaXDPjX62StDgn15y62deYLMSdEkQKCc=
X-Received: by 2002:a05:6808:1386:b0:3ea:5705:2a2f with SMTP id
 5614622812f47-3eccc09db24mr301076b6e.43.1734468066732; Tue, 17 Dec 2024
 12:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <3353401.44csPzL39Z@rjwysocki.net>
 <31c86834-273b-458f-9914-eff76c283cfb@arm.com>
In-Reply-To: <31c86834-273b-458f-9914-eff76c283cfb@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Dec 2024 21:40:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jus4bzeZhUK4WC7uypQkh-_MMuU1M54figsGV3+5OhUg@mail.gmail.com>
Message-ID: <CAJZ5v0jus4bzeZhUK4WC7uypQkh-_MMuU1M54figsGV3+5OhUg@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 5/9] PM: EM: Introduce em_dev_expand_perf_domain()
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:38=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 29/11/2024 17:02, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Introduce a helper function for adding a CPU to an existing EM perf
> > domain.
> >
> > Subsequently, this will be used by the intel_pstate driver to add new
> > CPUs to existing perf domains when those CPUs go online for the first
> > time after the initialization of the driver.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v0.1 -> v0.2: No changes
>
> Could you add information why this new EM interface is needed?

There is some of it in the changelog already.

In fact, it is only needed in a corner case when the system starts
with some CPUs offline and they only go online later (as a result of
an explicit request from user space).  That is the only case when a
new CPU may need to be added to an existing perf domain.

> IIRC, you can't use the existing way (cpufreq_driver::register_em) since
> it gets called to early (3) for the PD cpumasks to be ready. This issue
> will be there for any system in which uarch domains are not congruent
> with clock domains which we hadn't have to deal with Arm's heterogeneous
> CPUs so far.

Basically, yes.

> __init intel_pstate_init()
>
>   intel_pstate_register_driver()
>
>     cpufreq_register_driver()
>
>       subsys_interface_register()
>
>         sif->add_dev() -> cpufreq_add_dev()
>
>           cpufreq_online()
>
>             if (!new_policy && cpufreq_driver->online)
>
>             else
>
>               cpufreq_driver->init() -> intel_pstate_cpu_init()
>
>                 __intel_pstate_cpu_init()
>
>                   intel_pstate_init_cpu()
>
>                     intel_pstate_get_cpu_pstates()
>
>                       hybrid_add_to_domain()
>
>                         em_dev_expand_perf_domain()              <-- (1)
>
>                   intel_pstate_init_acpi_perf_limits()
>
>                     intel_pstate_set_itmt_prio()                 <-- (2)
>
>             if (new_policy)
>
>               cpufreq_driver->register_em()                      <-- (3)
>
>     hybrid_init_cpu_capacity_scaling()
>
>       hybrid_refresh_cpu_capacity_scaling()
>
>         __hybrid_refresh_cpu_capacity_scaling()                  <-- (4)
>
>         hybrid_register_all_perf_domains()
>
>           hybrid_register_perf_domain()
>
>             em_dev_register_perf_domain()                        <-- (5)
>
>       /* Enable EAS */
>       sched_clear_itmt_support()                                 <-- (6)
>
> Debugging this on a 'nosmt' i7-13700K (online mask =3D
> [0,2,4,6,8,10,12,14,16-23]
>
> (1) Add CPU to existing hybrid PD or create new hybrid PD.

Not exactly.

(1) is just to expand an existing perf domain if the CPU is new (was
offline all the time previously).

Likewise, the direct hybrid_register_perf_domain() call in
hybrid_add_to_domain() is to add a new perf domain if the given CPU is
new (was offline all the time previously) and is the first one of the
given type (say, the system is starting with all E-cores offline).
It won't succeed before (4).

For CPUs that are online to start with, hybrid_add_to_domain() assigns
them to hybrid domains and PDs are created for them in
hybrid_register_all_perf_domains().

> (2) Triggers sched domain rebuild (+ enabling EAS) already here during
>     startup ?

This is just to enable ITMT which is the default mechanism for Intel
hybrid platforms.  It also requires a rebuild of sched domains to be
enabled.

>     IMHO, reason is that max_highest_perf > min_highest_perf because of
>     different itmt prio

Yes (which means that the platform is at least not homogenous).

This really has been introduced for the handling of favored cores on
otherwise non-hybrid platforms (say Tiger Lake).

>     Happens for CPU8 on my machine (after CPU8 is added to hybrid PD
>     0,2,4,6,8) (itmt prio for CPU8=3D69 (1024) instead of 68 (1009)).
>     So it looks like EAS is enabled before (6) ?

No, it is ITMT because CPU8 is a favored core.

> (3) ARM's way to do (5)
> (4) Setting hybrid_max_perf_cpu
> (5) Register EM here
> (6) Actual call to initially triggers sched domain rebuild (+ enable
>     EAS) (done already in (2) on my machine)

This is the second rebuild of sched domains to turn off ITMT and
enable EAS.  The previous one is to enable ITMT.

The earlier enabling of ITMT could be avoided I think, but that would
be a complication on platforms that contain favored cores but
otherwise are not hybrid.

> So (3) is not possible for Intel hybrid since the policy's cpumask(s)

It is possible in principle, but not particularly convenient because
at that point it is not clear whether or not the platform is really
hybrid and SMT is off and so whether or not EAS is to be used.

> contain only one CPUs, i.e. CPUs are not sharing clock.
> And those cpumasks have to be build under (1) to be used in (5)?

They are built by the caller of (1) to be precise, but yes.

