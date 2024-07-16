Return-Path: <linux-pm+bounces-11184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBEE93345A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 00:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73351C22212
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 22:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70317143C40;
	Tue, 16 Jul 2024 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPwJlcIU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD487143899
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721170057; cv=none; b=eAjB8fMDfQkf9fYkV7Qvub1cmHto0isHLlJbmqSjSZUe7M8NUlmSi89hgj0aVJJlr/aT+uP2mWTyjP7cvEYghu4It33xxy0f8zE62UOPoN+sQtxN/Sl4/Dk/AXZW9NvYqXj5+UWIsvg+R/IY2Huo6Qn+4P/JrYnsVpzTo4eZl9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721170057; c=relaxed/simple;
	bh=9MaJofm+++Q68BNaCakwqLyHo3TZ9wFFHQ0DvoN+RYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtyKZxObvothmAbX3SOhMuc/H/xpO5kUO7FIGDpUl7LdehFyhy01vhSxzASUsYm3xtw4Kh86itjOVnKBn7vvEQkbO7nYKsJpd0A2HpZLy+ZJelnjrq5zI5QXedWXlhb4L46EDiEXn1YDsT05ikyiL3OSytg9VI5JUNpoLJw4O84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPwJlcIU; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3815ad8adc9so49435ab.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721170054; x=1721774854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqatXpCeOeeYRRYniUfxQaID24gWkHyIwmTyEpa9Osk=;
        b=HPwJlcIU00WhrhRhV8MOhDl/LYbWBmUQrFWecwrHLOQ2q+iD/UCdsXI63oANSc+Dh9
         S7i1oSjg/EIWsjsPQWdTeBKzNSX4F1XAqY8wN1ZUZBOGYucC9Qso6Q8kvGBSXKLS4gT+
         zrck4mEZgW/nLraMGj2WHqo1CU/7yAkNb6809HpEgqdassOMwSNYoNYqF4Kzery6zKBP
         zBD0hhuZHHm8P/zhklEDWm2g7i+F47G4vJhfNdQzrtEyXGM/lhegwKYYAkzqWbhJUKSU
         wvJbdvkwn9FRow3Nrx1vTdci6jkCJ/eYhe6Np99nUytsfsw6ciztk/AEBfIVlkxTPcLh
         yXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721170054; x=1721774854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqatXpCeOeeYRRYniUfxQaID24gWkHyIwmTyEpa9Osk=;
        b=s9fDJQEEC6YNUx4zhaVR2WlmcbhNZHssWe8zH5Qnl5sR+UyE8ZOpE9X4cRA10rpb4U
         2keEtYm7aQMq+cQ1yiqrJmUF6bVJk64saAYHaK7YiSeEhxMCSGSO1mnTXdHv6/Ji+zSM
         0n07KmNjKLNvQBxedxNKzqgG/kkENI74+vBxB/6vt1s33O5IMtdzycufaLbKB6Lzg2t3
         05j1OHf55k7TyzNbBYbSIqa7KGfv38TGpPvbNeKvTvMuwEobhhlLerufLmjnxhv7tdcc
         9HGt1rtIsODqocjodPKhpi7+Lk5+alOrtyGe/XIFl6ZwrXxjQ6fXgPcunuOT7cws/p+x
         WReg==
X-Forwarded-Encrypted: i=1; AJvYcCVJlggw4YQjZ7YB1EyZ5DiLXh/OD5tAJlpC1t4QI1IgGmy9CHVTtHFAE1NuXilxuUXZbUdwORTKs+lTvjsTugQUVcBTyLYbcZc=
X-Gm-Message-State: AOJu0Yz6918jGl+vyPUc3bITB0eC4gdqCSOd8PdEDRcS2hl+sbr5/K1O
	kAIGG6dSlMny1IBj+D6PnzthAzhQDTlh19gPc0j4g3Txj/VhJviaQZyyqw8fvsIlzHsNDJWAM/J
	PYGSeylaHn0CsPmd3w23Rl5zw70qNo1n4t8jE
X-Google-Smtp-Source: AGHT+IE30+A5+lNa3FYa2SP2MHH4fk60OXoX0aWIvrvIXGeOH+XbKkl+n+Lav00eYBsP2CVhSNRfXkkl4yqZEHA6oMA=
X-Received: by 2002:a05:6e02:184c:b0:375:ee62:5917 with SMTP id
 e9e14a558f8ab-3951364af1bmr1124465ab.6.1721170053573; Tue, 16 Jul 2024
 15:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
 <CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com>
 <05e96873-12a9-4b1f-b1b3-1db7647211ce@amd.com> <CAP-5=fVXi3Pdtjaw++oRkYgubh-MDkRYf=2k7dNqE8s+jyQ+Ew@mail.gmail.com>
 <2e7064c2-c769-41bb-a536-c6e75e8e5800@amd.com>
In-Reply-To: <2e7064c2-c769-41bb-a536-c6e75e8e5800@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jul 2024 15:47:22 -0700
Message-ID: <CAP-5=fXBYVH=qBJPm1d0-QEp8+HP3WtTLuukfF0g-2WU3gTofQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Add per-core RAPL energy counter support for AMD CPUs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	kees@kernel.org, gustavoars@kernel.org, rui.zhang@intel.com, 
	oleksandr@natalenko.name, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ananth.narayan@amd.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com, 
	ravi.bangoria@amd.com, sandipan.das@amd.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 1:42=E2=80=AFAM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
>
> Hello Ian,
>
> On 7/15/2024 8:52 PM, Ian Rogers wrote:
> > On Mon, Jul 15, 2024 at 2:36=E2=80=AFAM Dhananjay Ugwekar
> > <Dhananjay.Ugwekar@amd.com> wrote:
> >>
> >> Hello Ian,
> >>
> >> On 7/12/2024 3:53 AM, Ian Rogers wrote:
> >>> On Thu, Jul 11, 2024 at 3:25=E2=80=AFAM Dhananjay Ugwekar
> >>> <Dhananjay.Ugwekar@amd.com> wrote:
> >>>>
> >>>> Currently the energy-cores event in the power PMU aggregates energy
> >>>> consumption data at a package level. On the other hand the core ener=
gy
> >>>> RAPL counter in AMD CPUs has a core scope (which means the energy
> >>>> consumption is recorded separately for each core). Earlier efforts t=
o add
> >>>> the core event in the power PMU had failed [1], due to the differenc=
e in
> >>>> the scope of these two events. Hence, there is a need for a new core=
 scope
> >>>> PMU.
> >>>>
> >>>> This patchset adds a new "power_per_core" PMU alongside the existing
> >>>> "power" PMU, which will be responsible for collecting the new
> >>>> "energy-per-core" event.
> >>>
> >>> Sorry for being naive, is the only reason for adding the new PMU for
> >>> the sake of the cpumask? Perhaps we can add per event cpumasks like
> >>> say `/sys/devices/power/events/energy-per-core.cpumask` which contain=
s
> >>> the CPUs of the different cores in this case. There's supporting
> >>> hotplugging CPUs as an issue. Adding the tool support for this
> >>> wouldn't be hard and it may be less messy (although old perf tools on
> >>> new kernels wouldn't know about these files).
> >>
> >> I went over the two approaches and below are my thoughts,
> >>
> >> New PMU approach:
> >> Pros
> >> * It will work with older perf tools, hence these patches can be backp=
orted to an older kernel and the new per-core event will work there as well=
.
> >> Cons
> >> * More code changes in rapl.c
> >>
> >> Event specific cpumask approach:
> >> Pros
> >> * It might be easier to add diff scope events within the same PMU in f=
uture(although currently I'm not able to find such a usecase, apart from th=
e RAPL pkg and core energy counters)
> >> Cons
> >> * Both new kernel and perf tool will be required to use the new per-co=
re event.
> >>
> >> I feel that while the event-specific cpumask is a viable alternative t=
o the new PMU addition approach, I dont see any clear pros to select that o=
ver the current approach. Please let me know if you have any design related=
 concerns to the addition of new PMU or your concern is mostly about the am=
ount of code changes in this approach.
> >
> > Thanks Dhananjay, and thanks for taking the time for an objective
> > discussion on the mailing list. I'm very supportive of seeing the work
> > you are enabling land.
> >
> > My concern comes from the tool side. If every PMU starts to have
> > variants for the sake of the cpumask what does this mean for
> > aggregation in the perf tool? There is another issue around event
> > grouping, you can't group events across PMUs, but my feeling is that
> > event grouping needs to be rethought. By default the power_per_core
> > events are going to be aggregated together by the perf tool, which
> > then loses their per_core-ness.
>
> Yea right, maybe we need to fix this behavior.
>
> >
> > I was trying to think of the same problem but in other PMUs. One
> > thought I had was the difference between hyperthread and core events.
> > At least on Intel, some events can only count for the whole core not
> > per hyperthread. The events don't have a cpu_per_core PMU, they just
> > use the regular cpu one, and so the cpumask is set to all online
> > hyperthreads. When a per-core event is programmed it will get
> > programmed on every hyperthread and so counted twice for the core.
> > This at the least wastes a counter, but it probably also yields twice
> > the expected count as every event is counted twice then aggregated. So
> > this is just wrong and the user is expected to be smart and fix it
> > (checking the x86 events there is a convention to use a ".ALL" or
> > ".ANY" suffix for core wide events iirc). If we had a cpumask for
> > these events then we could avoid the double setting, free up a counter
> > and avoid double counting. Were we to fix things the way it is done in
> > this patch series we'd add another PMU.
>
> Yes, this seems like a valid usecase for event-specific cpumasks.
>
> >
> > My feeling is that in the longer term a per event cpumask looks
> > cleaner. I think either way you need a new kernel for the new RAPL
> > events. The problem with an old perf tool and a new kernel, this
> > doesn't normally happen with distributions as they match the perf tool
> > to the kernel version needlessly losing features and fixes along the
> > way. If the new PMU is going to get backported through fixes.. then we
> > can do similar for reading the per event cpumask. I'd be tempted not
> > to do this and focus on the next LTS kernel, getting the kernel and
> > tool fixes in as necessary.
>
> Makes sense, even though this approach will require more effort but it se=
ems
> to be worthwhile as it would help things down the line (make it easier to=
 have
> heterogenous-scope events within a PMU). I'll need to go through the perf=
 tool
> to see how we can design this. I'll get back with an RFC series probably =
once
> I have an initial design in mind.

Hi Dhananjay,

I can have a go at the perf tool side of this - I probably know the
way around the code best. Basically we need to do something similar to
how other "<event>.<setting>" values are parsed:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n335
The cpumask handling in the perf tool is a little weird as there is a
summary value in the evlist. Anyway, I can do that if you want to spin
the RAPL/power PMU side of things.

Thanks,
Ian

> Thanks,
> Dhananjay
>
> >
> > Thanks,
> > Ian
> >
> >
> >> Thanks,
> >> Dhananjay
> >>
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>
> >>>> Tested the package level and core level PMU counters with workloads
> >>>> pinned to different CPUs.
> >>>>
> >>>> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa
> >>>> machine:
> >>>>
> >>>> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- slee=
p 1
> >>>>
> >>>>  Performance counter stats for 'system wide':
> >>>>
> >>>> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-co=
re/
> >>>> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-co=
re/
> >>>> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-co=
re/
> >>>> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-co=
re/
> >>>> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-co=
re/
> >>>> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-co=
re/
> >>>> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-co=
re/
> >>>> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-co=
re/
> >>>> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-co=
re/
> >>>> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-co=
re/
> >>>> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-co=
re/
> >>>>
> >>>> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b1422886=
8d@linux.intel.com/
> >>>>
> >>>> This patchset applies cleanly on top of v6.10-rc7 as well as latest
> >>>> tip/master.
> >>>>
> >>>> v4 changes:
> >>>> * Add patch 11 which removes the unused function cpu_to_rapl_pmu()
> >>>> * Add Rui's rb tag for patch 1
> >>>> * Invert the pmu scope check logic in patch 2 (Peter)
> >>>> * Add comments explaining the scope check in patch 2 (Peter)
> >>>> * Use cpumask_var_t instead of cpumask_t in patch 5 (Peter)
> >>>> * Move renaming code to patch 8 (Rui)
> >>>> * Reorder the cleanup order of per-core and per-pkg PMU in patch 10 =
(Rui)
> >>>> * Add rapl_core_hw_unit variable to store the per-core PMU unit in p=
atch
> >>>>   10 (Rui)
> >>>>
> >>>> PS: Scope check logic is still kept the same (i.e., all Intel system=
s being
> >>>> considered as die scope), Rui will be modifying it to limit the die-=
scope
> >>>> only to Cascadelake-AP in a future patch on top of this patchset.
> >>>>
> >>>> v3 changes:
> >>>> * Patch 1 added to introduce the logical_core_id which is unique acr=
oss
> >>>>   the system (Prateek)
> >>>> * Use the unique topology_logical_core_id() instead of
> >>>>   topology_core_id() (which is only unique within a package on teste=
d
> >>>>   AMD and Intel systems) in Patch 10
> >>>>
> >>>> v2 changes:
> >>>> * Patches 6,7,8 added to split some changes out of the last patch
> >>>> * Use container_of to get the rapl_pmus from event variable (Rui)
> >>>> * Set PERF_EV_CAP_READ_ACTIVE_PKG flag only for pkg scope PMU (Rui)
> >>>> * Use event id 0x1 for energy-per-core event (Rui)
> >>>> * Use PERF_RAPL_PER_CORE bit instead of adding a new flag to check f=
or
> >>>>   per-core counter hw support (Rui)
> >>>>
> >>>> Dhananjay Ugwekar (10):
> >>>>   perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
> >>>>   perf/x86/rapl: Rename rapl_pmu variables
> >>>>   perf/x86/rapl: Make rapl_model struct global
> >>>>   perf/x86/rapl: Move cpumask variable to rapl_pmus struct
> >>>>   perf/x86/rapl: Add wrapper for online/offline functions
> >>>>   perf/x86/rapl: Add an argument to the cleanup and init functions
> >>>>   perf/x86/rapl: Modify the generic variable names to *_pkg*
> >>>>   perf/x86/rapl: Remove the global variable rapl_msrs
> >>>>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
> >>>>   perf/x86/rapl: Remove the unused function cpu_to_rapl_pmu
> >>>>
> >>>> K Prateek Nayak (1):
> >>>>   x86/topology: Introduce topology_logical_core_id()
> >>>>
> >>>>  Documentation/arch/x86/topology.rst   |   4 +
> >>>>  arch/x86/events/rapl.c                | 454 ++++++++++++++++++-----=
---
> >>>>  arch/x86/include/asm/processor.h      |   1 +
> >>>>  arch/x86/include/asm/topology.h       |   1 +
> >>>>  arch/x86/kernel/cpu/debugfs.c         |   1 +
> >>>>  arch/x86/kernel/cpu/topology_common.c |   1 +
> >>>>  6 files changed, 328 insertions(+), 134 deletions(-)
> >>>>
> >>>> --
> >>>> 2.34.1
> >>>>

