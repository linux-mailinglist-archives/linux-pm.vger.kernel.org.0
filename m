Return-Path: <linux-pm+bounces-25732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29502A93E6E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 21:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FA41B644FC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DAF2248A8;
	Fri, 18 Apr 2025 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+KGLy1T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042B15F330;
	Fri, 18 Apr 2025 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005936; cv=none; b=F+fYlqKJWao8usARmiygEubabfePLNwFVJfrgB/1KGPw+aS/BjJvfl+tF18zchCky0kV66I2lS9mucD7ddPT3Zfj5MRFvhSMH7Oz/S4ThdAJE6ue0C0+czGsP4ep/Ytr5we4hW+U02l1ZnLDpuqWYkzVXqQ2oV2VGd83sAkWEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005936; c=relaxed/simple;
	bh=SLiXZwp7lNJH0Fneml4e+Y0TR5IuLuKRxp2u/MP1e3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/E5FIewBZKE7JdNQvHoNaV6ET5wQlhxLwhRsASv+SfH2aJDj3/RdY3JXXLdoH2QbHtZvJhdRcnfYuZvcZ3Lh8usUBB35Jvx+aajDpX1m2LcDYMaIiKqnrSxVLXixXUFu3Jqn/VV6V/9Q5dXeo15nhTNF/GN6BvblzsAW+03Mc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+KGLy1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58917C4CEEE;
	Fri, 18 Apr 2025 19:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745005935;
	bh=SLiXZwp7lNJH0Fneml4e+Y0TR5IuLuKRxp2u/MP1e3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g+KGLy1TqfUUwp80KsEs4S9BiYCOynHiLMNjJp+onfvG3tk2BQ7/s0Kc6Z0BrmPeG
	 xXVX2ljOGMf4blpPtvCuUHjlwNVrhQqsbo52KPTu2OD9kHKvxgLo0NA+2NNref0cKQ
	 DwPSYQYncUf4JV4OCg0+3w7orIGlYdiunzByXTCVknP45bY2F7911dwrVhl083AR4p
	 mws7CbtTOgRNVLz5A0QobaWl+Lrd03gipPBxG0we1SwVtDo5VE2r7co5SO5XjHLr9C
	 QBbzVdLOmNPFURImYyJ/aYnKbYMy3AqGyxhkH0PtiOfKL8GyO58qYqnWCy/T3IIf0G
	 7i/kVJKa2qrkQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c2ada8264aso1084123fac.2;
        Fri, 18 Apr 2025 12:52:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlcazRFaGmeo2BWTWZFPCZUHHih8QWxj45hGGS5mVSimwSt0tsNMkvQ89JGIc6kkHy+AHM7LSK/Ys=@vger.kernel.org, AJvYcCXxBiwg0ymHf+osadlstQl623Wce7u0087OSdkZArYdz7EwQXyA3bRz9CPXPvDQtpaM6LtuR7IvSI7Z4i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJboI+XV7i3wr8iUxfHRHEih/QWa/9o06Zs+VdPp5jgrAqdCCA
	VMnvoVYWe3I2luTgTYnaNN5giNHYYmsi1KtIk9TybifGmREEIwO0pu+grzcpWXkeg75oRIzcnui
	GTjg+XBoYX04wHBDaRdx8R1LMI4g=
X-Google-Smtp-Source: AGHT+IE3c21j5ZqCedKGQBBPv+HdvovTFrW0EIpEo6IkvkL4r9NTa0ulAfYpa/Vn+tl/2FHEQEpqmjWTgGMVaqN7sIc=
X-Received: by 2002:a05:6871:80c2:b0:2c2:588a:70a3 with SMTP id
 586e51a60fabf-2d526dba4e1mr2048050fac.24.1745005934525; Fri, 18 Apr 2025
 12:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3344336.aeNJFYEL58@rjwysocki.net> <12d630f9-e917-4b9f-ab27-621886c13334@arm.com>
In-Reply-To: <12d630f9-e917-4b9f-ab27-621886c13334@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Apr 2025 21:52:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixXM72xeosQoD0T-Dok67_wwEwV_mRr_0o1aRHQPxY3Q@mail.gmail.com>
X-Gm-Features: ATxdqUHD89hWaueoAsvTEd-89ziuHeiuyS9k8Bb39fdZL_phOOSHGUAffCpAYGU
Message-ID: <CAJZ5v0ixXM72xeosQoD0T-Dok67_wwEwV_mRr_0o1aRHQPxY3Q@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 0/8] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 11:58=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/16/25 18:44, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This is a new version of
> >
> > https://lore.kernel.org/linux-pm/22640172.EfDdHjke4D@rjwysocki.net/
> >
> > which is not regarded as RFC any more.  It appears to be better than
> >
> > https://lore.kernel.org/linux-pm/5861970.DvuYhMxLoT@rjwysocki.net/
> >
> > but still requires more testing, so I'd appreciate any help here.
> >
> > The following paragraph from the original cover letter still applies:
> >
> > "The underlying observation is that on the platforms targeted by these =
changes,
> > Lunar Lake at the time of this writing, the "small" CPUs (E-cores), whe=
n run at
> > the same performance level, are always more energy-efficient than the "=
big" or
> > "performance" CPUs (P-cores).  This means that, regardless of the scale=
-
> > invariant utilization of a task, as long as there is enough spare capac=
ity on
> > E-cores, the relative cost of running it there is always lower."
> >
> > The first 3 patches have been updated since v0.3 and they now depend on=
 the new
> > cpufreq material in linux-next.
> >
> > The next 2 patches (Energy Model code changes) have been reviewed in th=
e
> > meantime, but they are only needed for the last 3 patches.
> >
> > Patch [6/8] is essentially the same as before.  It causes perf domains =
to be
> > registered per CPU and in addition to the primary cost component, which=
 is
> > related to the CPU type, there is a small component proportional to per=
formance
> > whose role is to help balance the load between CPUs of the same type.
> >
> > This is done to avoid migrating tasks too much between CPUs of the same=
 type,
> > especially between E-cores, which has been observed in tests of
> >
> > https://lore.kernel.org/linux-pm/5861970.DvuYhMxLoT@rjwysocki.net/
> >
> > The expected effect is still that the CPUs of the "low-cost" type will =
be
> > preferred so long as there is enough spare capacity on any of them.
> >
> > The last 2 patches are new.
> >
> > Patch [7/8] looks at the cache topology to avoid creating per-CPU perf =
domains
> > for CPUs sharing an L2 cache.  Typically, on the chips that will be aff=
ected
> > by this patch, CPUs sharing an L2 cache also share a voltage regulator =
and a
> > clock, so they technically belong to the same OPP domain and they will =
be put
> > into a shared perf domain after this patch.
> >
> > Patch [8/8] makes CPUs sharing the L3 cache look slightly more expensiv=
e to
> > cause the scheduler to prefer placing tasks on CPUs that don't use the =
L3,
> > which in some cases should allow all of the CPUs sharing the L3 to stay=
 in
> > idle states and the energy usage should be reduced.
> >
> > Please refer to the individual patch changelogs for details.
> >
> > Since patches [7-8/8] also apply on top of the v0.3, I have created a g=
it branch at
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > experimental/intel_pstate/eas-take2-extended
> >
> > or
> >
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
/log/?h=3Dexperimental/intel_pstate/eas-take2-extended
> >
> > to allow the difference they make with respect to the v0.3 to be seen (=
if any).
> >
> > Later, I'm going to put this series as a whole into a new git branch on=
 top of
> > the mainline and the cpufreq material queued up for 6.16.
> >
> > Thanks!
> >
>
> Similar to the v0.3 tests done here:
> https://lore.kernel.org/linux-pm/6ab0531a-d6d8-46ac-9afc-23cf87f37905@arm=
.com/
> here are the results for the same raptor lake nosmt machine (now with
> 4 e-cores + 4 e-cores and 8x1 p-core PDs, 10 PDs in total).
>
> Firefox YouTube 4K video playback:
> EAS:
> 684.504 +-19.167841239372198
> CAS:
> 929.83 +-50.41498564690636
> (-26.3844% energy used with EAS)
> (cf. -43.1% energy used with EAS v0.3)
> (cf. -24.2% energy used with EAS v0.2)
>
> Firefox Web Aquarium 500 fish.
> EAS:
> 540.192 +-14.294833410089904
> CAS:
> 712.896 +-16.821304745272684
> (-24.2257% energy used with EAS)
> (cf. -35.6% energy used with EAS v0.3)
>
> Seems the per-CPU PD worked better, at least for this machine, which argu=
ably
> isn't the main target of the series.

But it is an interesting data point.

We still cannot get this much of a difference on other systems in our
labs, even with the same type of workload.

Thanks for the results, much appreciated!

> Feel free to add
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> to patches 1 to 7 (the tested system isn't affected by 8/8).

Thank you!

