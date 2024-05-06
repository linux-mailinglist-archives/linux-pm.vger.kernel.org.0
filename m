Return-Path: <linux-pm+bounces-7538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1D8BD076
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 16:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4781F223FA
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA541534E9;
	Mon,  6 May 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgDeKL0c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644381211;
	Mon,  6 May 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006396; cv=none; b=JTZkTpDyB9GmYytUgi2ZRhrHBshZLTymDNz8QvffLigbu7R0UTB51vuQ0dkksx24w1TQCznJ0dHFqPRgX/9Hs+rzcPXy78fCMLUrcB3fkmRNVzSFmepYaF+bJHngd0yxgEJF8FSe8HiouQC9oDAt1IyADxNsbfcc6sbFLJSb2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006396; c=relaxed/simple;
	bh=U89OZGncNJqtcKnTD8yZONNz0dl0mlPs8Onkjf2z9oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+ObCtyPD/Jomt3tDJxKUrkzMpSzefjAbzCFd+w/A1rtEP7b001UoYIEUhUWrSOxzbO6R0x/bnKKtKCSxH1HUzPhu68punONQlutXolW79etvyJ7IR2ohS1oB3T7VWIA6SBiFlajxbXoggqa2Vpmuvz7ck7PKqMzYb2EDrtKhWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgDeKL0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D173C4AF66;
	Mon,  6 May 2024 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715006396;
	bh=U89OZGncNJqtcKnTD8yZONNz0dl0mlPs8Onkjf2z9oU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IgDeKL0cpjzfJbaNPT86QJ0DsZk9TsOdyIiGBkI8F3OlF+I4N/LbY70guPQWYyTL6
	 hOuvrFsNl4leSRNNAES06vVxFlXqmfSBV5n+CdkFKBDSQ1jVHTrweNS5hXGJPuWOHe
	 Pf04vdXEaiOeWQ3jkd+iaBGCsEjeS9RdkluplZkv45lvbvdfQyKSrCGI4cw5jgQq2s
	 nwlOCMKFvrBfB5jUzWxcDeUb18xSgy/MaM405FkMcO7n0QYEUrk/qjoItmqq+f78BI
	 9tw+SB6aZceKlc2IxOnDZ/BV+aptewhvWTQzGncpD/Zs9zQ7bA+8lDXuzuPmv3HtRj
	 XxdcrcpDS71fQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b2013d0090so505165eaf.2;
        Mon, 06 May 2024 07:39:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvQli4jcVOGFKABqD5BlefXL9W9p5DKp10FDPMk6C9bStR94ncVgKceAPr2tMbs2meo2loYjZOpgjbYARY4C5J2LUhMTZqT4Acc/SHWZO4I89FJbiiXIUjzrFClJQMa+g7pKvm08I=
X-Gm-Message-State: AOJu0YxaUcqGcu8XyTHC6Ub3bGaIEmKiHYrRyM1z6mW/adR2FJqiyD19
	lQaIpj+f+oWl3YC3ZrK70Mgw2xFXmZ+wuw/K32cp7uxQakBr7HzW+XUKkL4z0SkAJTP1SF8wmQF
	2Pq2/fnJ2LyrK9l5EnR2seNhwznQ=
X-Google-Smtp-Source: AGHT+IHQb7ROo7x8++ilFyCxyeBFZ0R/kRLgV7Bruzs0BV/uieit4rIL8b2KIH0YXq2Vn6eog2needrZOQNDCw/o2+E=
X-Received: by 2002:a05:6820:3309:b0:5b1:ff38:5ee0 with SMTP id
 fd9-20020a056820330900b005b1ff385ee0mr6042005oob.1.1715006395650; Mon, 06 May
 2024 07:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7663799.EvYhyI6sBW@kreacher> <1799046.VLH7GnMWUR@kreacher> <050c561c-487e-4e89-a7b2-9752cebc9f46@arm.com>
In-Reply-To: <050c561c-487e-4e89-a7b2-9752cebc9f46@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 May 2024 16:39:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hGiwoytVmVr=h8JJ1yf5KTcr+p7BrRgSUM-L_X6fciUA@mail.gmail.com>
Message-ID: <CAJZ5v0hGiwoytVmVr=h8JJ1yf5KTcr+p7BrRgSUM-L_X6fciUA@mail.gmail.com>
Subject: Re: [RFC][PATCH v1 3/3] cpufreq: intel_pstate: Set asymmetric CPU
 capacity on hybrid systems
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ricardo Neri <ricardo.neri@intel.com>, 
	Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 12:43=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 25/04/2024 21:06, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make intel_pstate use the HWP_HIGHEST_PERF values from
> > MSR_HWP_CAPABILITIES to set asymmetric CPU capacity information
> > via the previously introduced arch_set_cpu_capacity() on hybrid
> > systems without SMT.
>
> Are there such systems around? My i7-13700K has P-cores (CPU0..CPU15)
> with SMT.

As Ricardo said, nosmt is one way to run without SMT.  Another one is
to disable SMT in the BIOS setup.

Anyway, the point here is that with SMT, accurate tracking of task
utilization is rather hopeless.

> > Setting asymmetric CPU capacity is generally necessary to allow the
> > scheduler to compute task sizes in a consistent way across all CPUs
> > in a system where they differ by capacity.  That, in turn, should help
> > to improve task placement and load balancing decisions.  It is also
> > necessary for the schedutil cpufreq governor to operate as expected
> > on hybrid systems where tasks migrate between CPUs of different
> > capacities.
> >
> > The underlying observation is that intel_pstate already uses
> > MSR_HWP_CAPABILITIES to get CPU performance information which is
> > exposed by it via sysfs and CPU performance scaling is based on it.
> > Thus using this information for setting asymmetric CPU capacity is
> > consistent with what the driver has been doing already.  Moreover,
> > HWP_HIGHEST_PERF reflects the maximum capacity of a given CPU including
> > both the instructions-per-cycle (IPC) factor and the maximum turbo
> > frequency and the units in which that value is expressed are the same
> > for all CPUs in the system, so the maximum capacity ratio between two
> > CPUs can be obtained by computing the ratio of their HWP_HIGHEST_PERF
> > values.  Of course, in principle that capacity ratio need not be
> > directly applicable at lower frequencies, so using it for providing the
> > asymmetric CPU capacity information to the scheduler is a rough
> > approximation, but it is as good as it gets.  Also, measurements
> > indicate that this approximation is not too bad in practice.
>
> So cpu_capacity has a direct mapping to itmt prio. cpu_capacity is itmt
> prio with max itmt prio scaled to 1024.

Right.

The choice to make the ITMT prio reflect the capacity is deliberate,
although this code works with values retrieved via CPPC (which are the
same as the HWP_CAP values in the majority of cases but not always).

> Running it on i7-13700K (while allowing SMT) gives:
>
> root@gulliver:~# dmesg | grep sched_set_itmt_core_prio
> [    3.957826] sched_set_itmt_core_prio() cpu=3D0 prio=3D68
> [    3.990401] sched_set_itmt_core_prio() cpu=3D1 prio=3D68
> [    4.015551] sched_set_itmt_core_prio() cpu=3D2 prio=3D68
> [    4.040720] sched_set_itmt_core_prio() cpu=3D3 prio=3D68
> [    4.065871] sched_set_itmt_core_prio() cpu=3D4 prio=3D68
> [    4.091018] sched_set_itmt_core_prio() cpu=3D5 prio=3D68
> [    4.116175] sched_set_itmt_core_prio() cpu=3D6 prio=3D68
> [    4.141374] sched_set_itmt_core_prio() cpu=3D7 prio=3D68
> [    4.166543] sched_set_itmt_core_prio() cpu=3D8 prio=3D69
> [    4.196289] sched_set_itmt_core_prio() cpu=3D9 prio=3D69
> [    4.214964] sched_set_itmt_core_prio() cpu=3D10 prio=3D69
> [    4.239281] sched_set_itmt_core_prio() cpu=3D11 prio=3D69

CPUs 8 - 10 appear to be "favored cores" that can turbo up higher than
the other P-cores.

> [    4.263438] sched_set_itmt_core_prio() cpu=3D12 prio=3D68
> [    4.283790] sched_set_itmt_core_prio() cpu=3D13 prio=3D68
> [    4.308905] sched_set_itmt_core_prio() cpu=3D14 prio=3D68
> [    4.331751] sched_set_itmt_core_prio() cpu=3D15 prio=3D68
> [    4.356002] sched_set_itmt_core_prio() cpu=3D16 prio=3D42
> [    4.381639] sched_set_itmt_core_prio() cpu=3D17 prio=3D42
> [    4.395175] sched_set_itmt_core_prio() cpu=3D18 prio=3D42
> [    4.425625] sched_set_itmt_core_prio() cpu=3D19 prio=3D42
> [    4.449670] sched_set_itmt_core_prio() cpu=3D20 prio=3D42
> [    4.479681] sched_set_itmt_core_prio() cpu=3D21 prio=3D42
> [    4.506319] sched_set_itmt_core_prio() cpu=3D22 prio=3D42
> [    4.523774] sched_set_itmt_core_prio() cpu=3D23 prio=3D42
>
> root@gulliver:~# dmesg | grep hybrid_set_cpu_capacity
> [    4.450883] hybrid_set_cpu_capacity() cpu=3D0 cap=3D1009
> [    4.455846] hybrid_set_cpu_capacity() cpu=3D1 cap=3D1009
> [    4.460806] hybrid_set_cpu_capacity() cpu=3D2 cap=3D1009
> [    4.465766] hybrid_set_cpu_capacity() cpu=3D3 cap=3D1009
> [    4.470730] hybrid_set_cpu_capacity() cpu=3D4 cap=3D1009
> [    4.475699] hybrid_set_cpu_capacity() cpu=3D5 cap=3D1009
> [    4.480664] hybrid_set_cpu_capacity() cpu=3D6 cap=3D1009
> [    4.485626] hybrid_set_cpu_capacity() cpu=3D7 cap=3D1009
> [    4.490588] hybrid_set_cpu_capacity() cpu=3D9 cap=3D1024
> [    4.495550] hybrid_set_cpu_capacity() cpu=3D10 cap=3D1024
> [    4.500598] hybrid_set_cpu_capacity() cpu=3D11 cap=3D1024

And the "favored cores" get the max capacity.

> [    4.505649] hybrid_set_cpu_capacity() cpu=3D12 cap=3D1009
> [    4.510701] hybrid_set_cpu_capacity() cpu=3D13 cap=3D1009
> [    4.515749] hybrid_set_cpu_capacity() cpu=3D14 cap=3D1009
> [    4.520802] hybrid_set_cpu_capacity() cpu=3D15 cap=3D1009
> [    4.525846] hybrid_set_cpu_capacity() cpu=3D16 cap=3D623
> [    4.530810] hybrid_set_cpu_capacity() cpu=3D17 cap=3D623
> [    4.535772] hybrid_set_cpu_capacity() cpu=3D18 cap=3D623
> [    4.540732] hybrid_set_cpu_capacity() cpu=3D19 cap=3D623
> [    4.545690] hybrid_set_cpu_capacity() cpu=3D20 cap=3D623
> [    4.550651] hybrid_set_cpu_capacity() cpu=3D21 cap=3D623
> [    4.555612] hybrid_set_cpu_capacity() cpu=3D22 cap=3D623
> [    4.560571] hybrid_set_cpu_capacity() cpu=3D23 cap=3D623
>
> > If the given system is hybrid and non-SMT, the new code disables ITMT
> > support in the scheduler (because it may get in the way of asymmetric C=
PU
> > capacity code in the scheduler that automatically gets enabled by setti=
ng
> > asymmetric CPU capacity) after initializing all online CPUs and finds
> > the one with the maximum HWP_HIGHEST_PERF value.  Next, it computes the
> > capacity number for each (online) CPU by dividing the product of its
> > HWP_HIGHEST_PERF and SCHED_CAPACITY_SCALE by the maximum HWP_HIGHEST_PE=
RF.
>
> SO either CAS at wakeup and in load_balance or SIS at wakeup and ITMT in
> load balance.

Yup, at least for this version of the patch.

> > When a CPU goes offline, its capacity is reset to SCHED_CAPACITY_SCALE
> > and if it is the one with the maximum HWP_HIGHEST_PERF value, the
> > capacity numbers for all of the other online CPUs are recomputed.  This
> > also takes care of a cleanup during driver operation mode changes.
> >
> > Analogously, when a new CPU goes online, its capacity number is updated
> > and if its HWP_HIGHEST_PERF value is greater than the current maximum
> > one, the capacity numbers for all of the other online CPUs are
> > recomputed.
> >
> > The case when the driver is notified of a CPU capacity change, either
> > through the HWP interrupt or through an ACPI notification, is handled
> > similarly to the CPU online case above, except that if the target CPU
> > is the current highest-capacity one and its capacity is reduced, the
> > capacity numbers for all of the other online CPUs need to be recomputed
> > either.
> >
> > If the driver's "no_trubo" sysfs attribute is updated, all of the CPU
> > capacity information is computed from scratch to reflect the new turbo
> > status.
>
> So if I do:
>
> echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
>
> I get:
>
> [ 1692.801368] hybrid_update_cpu_scaling() called
> [ 1692.801381] hybrid_update_cpu_scaling() max_cap_perf=3D44, max_perf_cp=
u=3D0
> [ 1692.801389] hybrid_set_cpu_capacity() cpu=3D1 cap=3D1024
> [ 1692.801395] hybrid_set_cpu_capacity() cpu=3D2 cap=3D1024
> [ 1692.801399] hybrid_set_cpu_capacity() cpu=3D3 cap=3D1024
> [ 1692.801402] hybrid_set_cpu_capacity() cpu=3D4 cap=3D1024
> [ 1692.801405] hybrid_set_cpu_capacity() cpu=3D5 cap=3D1024
> [ 1692.801408] hybrid_set_cpu_capacity() cpu=3D6 cap=3D1024
> [ 1692.801410] hybrid_set_cpu_capacity() cpu=3D7 cap=3D1024
> [ 1692.801413] hybrid_set_cpu_capacity() cpu=3D8 cap=3D1024
> [ 1692.801416] hybrid_set_cpu_capacity() cpu=3D9 cap=3D1024
> [ 1692.801419] hybrid_set_cpu_capacity() cpu=3D10 cap=3D1024
> [ 1692.801422] hybrid_set_cpu_capacity() cpu=3D11 cap=3D1024
> [ 1692.801425] hybrid_set_cpu_capacity() cpu=3D12 cap=3D1024
> [ 1692.801428] hybrid_set_cpu_capacity() cpu=3D13 cap=3D1024
> [ 1692.801431] hybrid_set_cpu_capacity() cpu=3D14 cap=3D1024
> [ 1692.801433] hybrid_set_cpu_capacity() cpu=3D15 cap=3D1024
> [ 1692.801436] hybrid_set_cpu_capacity() cpu=3D16 cap=3D605
> [ 1692.801439] hybrid_set_cpu_capacity() cpu=3D17 cap=3D605
> [ 1692.801442] hybrid_set_cpu_capacity() cpu=3D18 cap=3D605
> [ 1692.801445] hybrid_set_cpu_capacity() cpu=3D19 cap=3D605
> [ 1692.801448] hybrid_set_cpu_capacity() cpu=3D20 cap=3D605
> [ 1692.801451] hybrid_set_cpu_capacity() cpu=3D21 cap=3D605
> [ 1692.801453] hybrid_set_cpu_capacity() cpu=3D22 cap=3D605
> [ 1692.801456] hybrid_set_cpu_capacity() cpu=3D23 cap=3D605
>
> Turbo on this machine stands only for the cpu_capacity diff 1009 vs 1024?

Not really.

The capacity of the fastest CPU is always 1024 and the capacities of
all of the other CPUs are adjusted to that.

When turbo is disabled, the capacity of the "favored cores" is the
same as for the other P-cores (i.e. 1024) and the capacity of E-cores
is relative to that.

Of course, this means that task placement may be somewhat messed up
after disabling or enabling turbo (which is a global switch), but I
don't think that there is a way to avoid it.

