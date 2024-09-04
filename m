Return-Path: <linux-pm+bounces-13556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5329096BAAC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 13:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE4C1F20FA1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27FB1D0174;
	Wed,  4 Sep 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDo+i+OD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791DE1CF7A6;
	Wed,  4 Sep 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449375; cv=none; b=lpuTWFUm31xw7VjaDUrKYzXzPSTRwzQo3OtYKOMroT5rSu2Uj7F0BRZeDTrn+jRYYjZ28Is3bQWPh0o8dYORhi2PUlSLTG8+oyciAm5fBQ/8cxQhG9AgulOTSLfT4BuEqy4gZqiQIckceVaM6h1o3Y9O37oWL8Tp8nQ2sN6WFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449375; c=relaxed/simple;
	bh=wDbZjpbh7d5SMohBU9tM7AEFFdcqXfex4l2JBIWINjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJWrRS2S3ZeMeEXew5RuFoATNy00blOK4lDgXuQ4wn5UnuIESKDhcTqiIYFTfTFLljdIw6UhxHfbzQtTD+CsWhVQiwTimsm6LA6tiEvfvYY+IHBebPJQa2nGpaD0A9T+dDrYDuePZrNhCWwzFsbE5fxQxfxgkKPWcsI8q3EKVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDo+i+OD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF39FC4CED1;
	Wed,  4 Sep 2024 11:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725449375;
	bh=wDbZjpbh7d5SMohBU9tM7AEFFdcqXfex4l2JBIWINjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uDo+i+OD7YcZQkH4Kf1blwRPvQN7ltIZ/3WWJnFJPWLnazkXlpoRoOPq66Epj1o7P
	 einOJeuiFQ00o/ndcc37yiEuTRjrdlq9dnlSaWHfW3GD0UvmvY4zF0xWc+OoirBUBQ
	 GiIhXD3qWLfSO2H2+Q47iWquktQQFayzDT0TY1TVp/Uo0cL7M9ndkIpJMS41QczNis
	 gOWUXYOWVSLJQl+mgRSzLsshjsjCeJtUf3hbg10YqheaHxw8efFGXdhvWoUFl9GHvQ
	 izzP9PBZgpvcHY705zblTbu1QHjk8PG+fVg+AD3OK4N/s+nVbcMVSWTB1cIcMRVYv7
	 G419Me+McWxfg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-27045e54272so2907678fac.0;
        Wed, 04 Sep 2024 04:29:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6ui9aDv9c99WacbGPK6O20dUOiUQzrJ0ZgMt+JbcueqNdPMht/so6Axw0/3cwT6KTvOuIOJnoOeMcvKc=@vger.kernel.org, AJvYcCViG49XcJViviSebdjPh+pCgaTq1CzsbkTKjsKKwm0hu6F9o7CI3NlA7VtDrEOhhl7qlbbdEaUVo3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jtKXhWEGAyLyrS7PRyr5fGeLOE7AG4eU+JZD10muY/VG5B7D
	J5JHkdUfDLJEwmpvAyoVarAhVv69pEAZPrClg0e8H5O92fBhU6I6Utlb8aHoPBNBFlNuRPZKxGn
	QoKuQg/GdpDeEC36bCjlfHts8V/c=
X-Google-Smtp-Source: AGHT+IFtcZkT9cYGlrZKkEBlTZjui+UE/KUyYk1iXSUfbJVI6UUv55LSXDlRPs6qeRksifDC2A1cH3pEyDoKGzCMCiM=
X-Received: by 2002:a05:6870:5cc7:b0:270:64ed:c125 with SMTP id
 586e51a60fabf-277c804bc6bmr15834642fac.16.1725449374219; Wed, 04 Sep 2024
 04:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3310447.aeNJFYEL58@rjwysocki.net> <1979653.PYKUYFuaPT@rjwysocki.net>
 <20240904063915.GA3674@ranerica-svr.sc.intel.com>
In-Reply-To: <20240904063915.GA3674@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Sep 2024 13:29:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h+kvT061n442G2Q4gyRzS_fj4yROTD-1APYvK2K4tagw@mail.gmail.com>
Message-ID: <CAJZ5v0h+kvT061n442G2Q4gyRzS_fj4yROTD-1APYvK2K4tagw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: intel_pstate: Set asymmetric CPU capacity
 on hybrid systems
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:33=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Wed, Aug 28, 2024 at 01:48:10PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make intel_pstate use the HWP_HIGHEST_PERF values from
> > MSR_HWP_CAPABILITIES to set asymmetric CPU capacity information
> > via the previously introduced arch_set_cpu_capacity() on hybrid
> > systems without SMT.
> >
> > Setting asymmetric CPU capacity is generally necessary to allow the
> > scheduler to compute task sizes in a consistent way across all CPUs
> > in a system where they differ by capacity.  That, in turn, should help
> > to improve scheduling decisions.  It is also necessary for the scheduti=
l
> > cpufreq governor to operate as expected on hybrid systems where tasks
> > migrate between CPUs of different capacities.
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
> >
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
> >
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
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> A few minor comments below...
>
> FWIW,
>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> # scale i=
nvariance
>
> [...]
>
> > +
> > +static void hybrid_init_cpu_scaling(void)
>
> Maybe renaming hybrid_init_cpu_scaling() as hybrid_init_cpu_capacity_scal=
ing(),
> __hybrid_init_cpu_scaling() as __hybrid_init_cpu_capacity_scaling(), and
> hybrid_update_cpu_scaling() as hybrid_update_cpu_capacity_scaling()?
>
> It would make the code easier to read.

Sure, if that helps.

> > +{
> > +     bool disable_itmt =3D false;
> > +
> > +     mutex_lock(&hybrid_capacity_lock);
> > +
> > +     /*
> > +      * If hybrid_max_perf_cpu is set at this point, the hybrid CPU ca=
pacity
> > +      * scaling has been enabled already and the driver is just changi=
ng the
> > +      * operation mode.
> > +      */
> > +     if (hybrid_max_perf_cpu) {
> > +             __hybrid_init_cpu_scaling();
> > +             goto unlock;
> > +     }
> > +
> > +     /*
> > +      * On hybrid systems, use asym capacity instead of ITMT, but beca=
use
> > +      * the capacity of SMT threads is not deterministic even approxim=
ately,
> > +      * do not do that when SMT is in use.
> > +      */
> > +     if (hwp_is_hybrid && !sched_smt_active() && arch_enable_hybrid_ca=
pacity_scale()) {
> > +             __hybrid_init_cpu_scaling();
> > +             disable_itmt =3D true;
> > +     }
> > +
> > +unlock:
> > +     mutex_unlock(&hybrid_capacity_lock);
> > +
> > +     if (disable_itmt)
> > +             sched_clear_itmt_support();
>
> It may be worth adding a comment here saying that the sched domains will
> rebuilt to disable asym packing and enable asym capacity.

Won't hurt I suppose.

