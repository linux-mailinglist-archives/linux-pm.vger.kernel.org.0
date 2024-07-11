Return-Path: <linux-pm+bounces-11010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C74B92F1D2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 00:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5FD1F21B33
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 22:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC42D1A0719;
	Thu, 11 Jul 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0K8zKent"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2F15CD79
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736651; cv=none; b=iG5Q9/QMQ2ux8p30Z87z0Rlzt0Q0VE2A9t3Kopp22x4N2LrMboGD+ptg+zEJ8cWA0yMl6zel5yAq0P7BXIdXSboSQpwW3jxQzKfl4kbkBsaBHftRXYS2mT00I9HEV+eDNiVP6Faa1husNCELAD3nmk36NZkE71fFjBptX+5TfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736651; c=relaxed/simple;
	bh=umz65CgamqI9woTw9I8lAdO2908JYg7ok02eaBGsWkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lwx2WwSkRrbB+zJuTBU/LzGjaLgosouyK0VkkX0EGaEna48VQ2fjBgpvrmOqUmEaBZNiLhs1jExOLwUjRv+EPGBBL5Xtg0Nvu8GrWf6ORPsLd2d34EGznpEneqTGxkzjZ8fycjhhgZjrc95GO9FDo4owrRomUx/Fwol9JUpWSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0K8zKent; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-447df43324fso48911cf.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720736648; x=1721341448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ikbsIYih3ehLlIfT5YoG7a0BVQ8XeYIK6rrLHADErw=;
        b=0K8zKent4k5GsWH1KQPj9oEjzCUYsfoNU7SHZQrlt2GtoD0LfCTi2MCIMmMjJ0aPaA
         aojFhlLvvMclR1/zsOmdBeGC1mjD5puCGZN1VoKGaHv2q3uvXf/k4F4tszCRIkBZBuP0
         SmB2f+b2SOR4PlRLElHZTSpQxFPNTGutQVbYLwgmGRe4Q5rP1SK0QbHqEYohRoI6zkAE
         XB5k45KcwYfYTsARQsQd2derr7ZT4UByHkR5vUxV0bH6c2Y3Fv5Hk+scwq7GFqfQmQsM
         IJhGEP7mx1POBgWnT1k9Wn8lZCU1GAzaWQlXnyHrnCZ76eYiiOR1bMNw3cvA9JiT8nj/
         kFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720736648; x=1721341448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ikbsIYih3ehLlIfT5YoG7a0BVQ8XeYIK6rrLHADErw=;
        b=VIr6yNB1mDdN0QFhcm9ssyL6iMb1XIX6a+DfQXXosLonMyuTc7sc6R2R98zNioLHRt
         OtrbESbDCG9IfTwVVJa46tQ8VVCifZ0T1m/5yIAkxAaX29uyZ50NA5rdicrtGwjzlP7y
         Q5PYQ7NQ/AXlFRGVidOdZDQWiJv0E4xCve6VUrdIkOYsmQzbxN5qWTOZzJ1on1vJ76zt
         jMb65yjBrvqegsc/KmGJvf5k/nR/W6Z21in5Sd3UfakT/P29OjM6f7clcCv+5G1cAKU4
         vlCDEpm0PwbsHrKQe1PW0x7iUVmE7bWvbFGKY689SjKmg3DPOkRMHn6wXQa4OKjYYKOC
         dfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvrSU3OnTHPowGmcnLi0/FZMVCpC1jfgpgHa2lOSZ4FHsMjEU51UXifXAAsZ9HuYL7AowNA3+XiyQWJTIwKe0kjkcqMHZ3geA=
X-Gm-Message-State: AOJu0YyqqK5ARkoaI0JT7eiPVhANlqNW0ZVhlVUvZjv7pANPM1rLREx7
	wyuk3w++Sfw5BigpILtGam01CVvd+N3X9CzuPV6+rNqP7k77LgMyGfUY0C0FAeIC9zBHTC+6VrI
	WsupMNBW69C3Zb9lF3+K8GIDHGWQfepoTi3xM
X-Google-Smtp-Source: AGHT+IGAc884CVEDTkvsd7h8jIYVN5c3I7pSJJVtiIZ6adS6zViqgnZWfojP5ub98vVg/kgQUmfRgXI+GvGBo0Nwylo=
X-Received: by 2002:a05:622a:289a:b0:447:f3ae:383b with SMTP id
 d75a77b69052e-44e9e556a99mr307391cf.19.1720736647474; Thu, 11 Jul 2024
 15:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jul 2024 15:23:56 -0700
Message-ID: <CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com>
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

On Thu, Jul 11, 2024 at 3:25=E2=80=AFAM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
>
> Currently the energy-cores event in the power PMU aggregates energy
> consumption data at a package level. On the other hand the core energy
> RAPL counter in AMD CPUs has a core scope (which means the energy
> consumption is recorded separately for each core). Earlier efforts to add
> the core event in the power PMU had failed [1], due to the difference in
> the scope of these two events. Hence, there is a need for a new core scop=
e
> PMU.
>
> This patchset adds a new "power_per_core" PMU alongside the existing
> "power" PMU, which will be responsible for collecting the new
> "energy-per-core" event.

Sorry for being naive, is the only reason for adding the new PMU for
the sake of the cpumask? Perhaps we can add per event cpumasks like
say `/sys/devices/power/events/energy-per-core.cpumask` which contains
the CPUs of the different cores in this case. There's supporting
hotplugging CPUs as an issue. Adding the tool support for this
wouldn't be hard and it may be less messy (although old perf tools on
new kernels wouldn't know about these files).

Thanks,
Ian


> Tested the package level and core level PMU counters with workloads
> pinned to different CPUs.
>
> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa
> machine:
>
> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1
>
>  Performance counter stats for 'system wide':
>
> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
>
> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@li=
nux.intel.com/
>
> This patchset applies cleanly on top of v6.10-rc7 as well as latest
> tip/master.
>
> v4 changes:
> * Add patch 11 which removes the unused function cpu_to_rapl_pmu()
> * Add Rui's rb tag for patch 1
> * Invert the pmu scope check logic in patch 2 (Peter)
> * Add comments explaining the scope check in patch 2 (Peter)
> * Use cpumask_var_t instead of cpumask_t in patch 5 (Peter)
> * Move renaming code to patch 8 (Rui)
> * Reorder the cleanup order of per-core and per-pkg PMU in patch 10 (Rui)
> * Add rapl_core_hw_unit variable to store the per-core PMU unit in patch
>   10 (Rui)
>
> PS: Scope check logic is still kept the same (i.e., all Intel systems bei=
ng
> considered as die scope), Rui will be modifying it to limit the die-scope
> only to Cascadelake-AP in a future patch on top of this patchset.
>
> v3 changes:
> * Patch 1 added to introduce the logical_core_id which is unique across
>   the system (Prateek)
> * Use the unique topology_logical_core_id() instead of
>   topology_core_id() (which is only unique within a package on tested
>   AMD and Intel systems) in Patch 10
>
> v2 changes:
> * Patches 6,7,8 added to split some changes out of the last patch
> * Use container_of to get the rapl_pmus from event variable (Rui)
> * Set PERF_EV_CAP_READ_ACTIVE_PKG flag only for pkg scope PMU (Rui)
> * Use event id 0x1 for energy-per-core event (Rui)
> * Use PERF_RAPL_PER_CORE bit instead of adding a new flag to check for
>   per-core counter hw support (Rui)
>
> Dhananjay Ugwekar (10):
>   perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
>   perf/x86/rapl: Rename rapl_pmu variables
>   perf/x86/rapl: Make rapl_model struct global
>   perf/x86/rapl: Move cpumask variable to rapl_pmus struct
>   perf/x86/rapl: Add wrapper for online/offline functions
>   perf/x86/rapl: Add an argument to the cleanup and init functions
>   perf/x86/rapl: Modify the generic variable names to *_pkg*
>   perf/x86/rapl: Remove the global variable rapl_msrs
>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
>   perf/x86/rapl: Remove the unused function cpu_to_rapl_pmu
>
> K Prateek Nayak (1):
>   x86/topology: Introduce topology_logical_core_id()
>
>  Documentation/arch/x86/topology.rst   |   4 +
>  arch/x86/events/rapl.c                | 454 ++++++++++++++++++--------
>  arch/x86/include/asm/processor.h      |   1 +
>  arch/x86/include/asm/topology.h       |   1 +
>  arch/x86/kernel/cpu/debugfs.c         |   1 +
>  arch/x86/kernel/cpu/topology_common.c |   1 +
>  6 files changed, 328 insertions(+), 134 deletions(-)
>
> --
> 2.34.1
>

