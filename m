Return-Path: <linux-pm+bounces-24374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E205A6BC3E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FB23B1F0A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D813774D;
	Fri, 21 Mar 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRHJtSUF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143A757EA;
	Fri, 21 Mar 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565503; cv=none; b=PLJeBJdg+lkCLf4qxKZmEilQINxMaPrPl+/6VvADd6nTe7IIVxreVm5FqdSRmECj/eHxXyKES7QY4HAGb3rpK8IfWZJJkNvfwaRMjCet8qkWGyp1esRbMHJ494KLWAQucVZ5L+o+Z8lhjontT9vJD/KWLnPfZER0v6GTx0uPkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565503; c=relaxed/simple;
	bh=6vAspCAiAB3DexjwsaE6SX9ZPw4xPF5SiOIgQi+Be5E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s7m4gzx68GJM6yX3Rzw8u6cM9rDJb9bqpAtId7ChuwqEzYPf7iav6sE72FxR6UxxybdEYAL45frM+kbQndwXbgznr0oaUq3uuJi+hEcxTVCLKg4x+hCSUD/xbIIRT0rvuZ0biWZLgzCMkSfIUxz4VQT6FusuRMBA1RGd5kakhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRHJtSUF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742565501; x=1774101501;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6vAspCAiAB3DexjwsaE6SX9ZPw4xPF5SiOIgQi+Be5E=;
  b=DRHJtSUFSljQWcrDa3sBh9qSAezRn2FZR0Nkd7y+kmHLcG7m01rcNn+9
   urBwBnX9I1epbKZq11lYHIiZeUt13FdUzkJge8FhNJhdNqGpio8A7rQox
   yvFr4eC9ErN5+XH9bO6E2RjzLvVYzBzeMrHA9JhZqJ8pumE1JdGI30Uxf
   NAuYBEi6imEusOiuH/cVkXFaFlKjldWV8AeaqTA8AsXn1AdHIfDUTxi//
   qQOmf6+Va6zRA9hvMj18h/QG+nRFDQPDhOzMMVkx+sArIIFWXbK+a/wOD
   AZiRvDVk9lnT33uz8wqz+nKuMNOz08klV7S6BszadMzVrIyB9WdJR5FSC
   A==;
X-CSE-ConnectionGUID: nrOWR9qMTZqSNH6Daj0bKA==
X-CSE-MsgGUID: 5TjKzZMyQqS66HuFGAbMew==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43993393"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43993393"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 06:58:20 -0700
X-CSE-ConnectionGUID: Q+PrO1GQR+yDST8Ra7hiIA==
X-CSE-MsgGUID: JFJ/dsUnQ32ArMb4RPMMhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123426742"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 06:58:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Mar 2025 15:58:09 +0200 (EET)
To: Mario Limonciello <superm1@kernel.org>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, 
    "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, 
    Huang Rui <ray.huang@amd.com>, 
    "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Viresh Kumar <viresh.kumar@linaro.org>, 
    "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
    "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
    "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>, 
    Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v8 01/13] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
In-Reply-To: <a2e33d66-22ee-475b-817b-b52c6890859c@kernel.org>
Message-ID: <58c49901-24b2-2209-9583-09e6b080cc08@linux.intel.com>
References: <20250218190822.1039982-1-superm1@kernel.org> <20250218190822.1039982-2-superm1@kernel.org> <127a93b0-647f-bb0c-2bf4-649fc4d1f25e@linux.intel.com> <a2e33d66-22ee-475b-817b-b52c6890859c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1251599366-1742565489=:931"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1251599366-1742565489=:931
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 20 Mar 2025, Mario Limonciello wrote:

> On 3/19/2025 09:01, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 18 Feb 2025, Mario Limonciello wrote:
> >=20
> > > From: Perry Yuan <Perry.Yuan@amd.com>
> > >=20
> > > Introduce a new documentation file, `amd_hfi.rst`, which delves into =
the
> > > implementation details of the AMD Hardware Feedback Interface and its
> > > associated driver, `amd_hfi`. This documentation describes how the
> > > driver provides hint to the OS scheduling which depends on the capabi=
lity
> > > of core performance and efficiency ranking data.
> > >=20
> > > This documentation describes
> > > * The design of the driver
> > > * How the driver provides hints to the OS scheduling
> > > * How the driver interfaces with the kernel for efficiency ranking da=
ta.
> > >=20
> > > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   Documentation/arch/x86/amd-hfi.rst | 127 ++++++++++++++++++++++++++=
+++
> > >   Documentation/arch/x86/index.rst   |   1 +
> > >   2 files changed, 128 insertions(+)
> > >   create mode 100644 Documentation/arch/x86/amd-hfi.rst
> > >=20
> > > diff --git a/Documentation/arch/x86/amd-hfi.rst
> > > b/Documentation/arch/x86/amd-hfi.rst
> > > new file mode 100644
> > > index 0000000000000..5d204688470e3
> > > --- /dev/null
> > > +++ b/Documentation/arch/x86/amd-hfi.rst
> > > @@ -0,0 +1,127 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +Hardware Feedback Interface For Hetero Core Scheduling On AMD Platfo=
rm
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +:Copyright: 2024 Advanced Micro Devices, Inc. All Rights Reserved.
> > > +
> > > +:Author: Perry Yuan <perry.yuan@amd.com>
> > > +:Author: Mario Limonciello <mario.limonciello@amd.com>
> > > +
> > > +Overview
> > > +--------
> > > +
> > > +AMD Heterogeneous Core implementations are comprised of more than on=
e
> > > +architectural class and CPUs are comprised of cores of various effic=
iency
> > > and
> > > +power capabilities: performance-oriented *classic cores* and
> > > power-efficient
> > > +*dense cores*. As such, power management strategies must be designed=
 to
> > > +accommodate the complexities introduced by incorporating different c=
ore
> > > types.
> > > +Heterogeneous systems can also extend to more than two architectural
> > > classes as
> > > +well. The purpose of the scheduling feedback mechanism is to provide
> > > +information to the operating system scheduler in real time such that=
 the
> > > +scheduler can direct threads to the optimal core.
> > > +
> > > +The goal of AMD's heterogeneous architecture is to attain power bene=
fit
> > > by sending
> > > +background thread to the dense cores while sending high priority thr=
eads
> > > to the classic
> > > +cores. From a performance perspective, sending background threads to
> > > dense cores can free
> > > +up power headroom and allow the classic cores to optimally service
> > > demanding threads.
> > > +Furthermore, the area optimized nature of the dense cores allows for=
 an
> > > increasing
> > > +number of physical cores. This improved core density will have posit=
ive
> > > multithreaded
> > > +performance impact.
> >=20
> > Hi Mario,
> >=20
> > Please fold these paragraphs to 80 characters so that they're easier to
> > read as textfiles (the table can obviously exceed that but there should=
 be
> > no reason for the text paragraphs to have excessively long lines).
> >=20
> > My apologies for taking so long to get to review this series.=20
>=20
> No problem.  Thanks for looking.  I'll get a new version ready to put out
> after the next merge window.
>=20
> > Most of my
> > comments are quite minor but there's also 1-2 things that seem more
> > important. It seemed to me that there is some disconnetion between the
> > promises made in the Kconfig description and what is provided by the pa=
tch
> > series.
>=20
> Some of the series was pared down to go in multiple parts to make it easi=
er to
> review with follow ups for the dynamic stuff planned for the next iterati=
on.
>=20
> You see some artifacts of that comments and Kconfig.  I figured it was be=
tter
> to leave as is for those given they get to the intent, but I can change i=
f you
> think it's better to adjust them when the next part lands instead.

Okay, I thought that might be because such a split to multiple series. I=20
think you can leave those as is as I assume to intention is to immediately=
=20
follow up with the other parts (and not like wait a few kernel releases=20
or so)?

--=20
 i.

>=20
> >=20
> > --
> >   i.
> >=20
> > > +
> > > +AMD Heterogeneous Core Driver
> > > +-----------------------------
> > > +
> > > +The ``amd_hfi`` driver delivers the operating system a performance a=
nd
> > > energy efficiency
> > > +capability data for each CPU in the system. The scheduler can use th=
e
> > > ranking data
> > > +from the HFI driver to make task placement decisions.
> > > +
> > > +Thread Classification and Ranking Table Interaction
> > > +----------------------------------------------------
> > > +
> > > +The thread classification is used to select into a ranking table tha=
t
> > > describes
> > > +an efficiency and performance ranking for each classification.
> > > +
> > > +Threads are classified during runtime into enumerated classes. The
> > > classes represent
> > > +thread performance/power characteristics that may benefit from speci=
al
> > > scheduling behaviors.
> > > +The below table depicts an example of thread classification and a
> > > preference where a given thread
> > > +should be scheduled based on its thread class. The real time thread
> > > classification is consumed
> > > +by the operating system and is used to inform the scheduler of where=
 the
> > > thread should be placed.
> > > +
> > > +Thread Classification Example Table
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > ++----------+----------------+-------------------------------+-------=
--------------+---------+
> > > +| class ID | Classification | Preferred scheduling behavior | Preemp=
tion
> > > priority | Counter |
> > > ++----------+----------------+-------------------------------+-------=
--------------+---------+
> > > +| 0        | Default        | Performant                    | Highes=
t
> > > |         |
> > > ++----------+----------------+-------------------------------+-------=
--------------+---------+
> > > +| 1        | Non-scalable   | Efficient                     | Lowest
> > > | PMCx1A1 |
> > > ++----------+----------------+-------------------------------+-------=
--------------+---------+
> > > +| 2        | I/O bound      | Efficient                     | Lowest
> > > | PMCx044 |
> > > ++----------+----------------+-------------------------------+-------=
--------------+---------+
> > > +
> > > +Thread classification is performed by the hardware each time that th=
e
> > > thread is switched out.
> > > +Threads that don't meet any hardware specified criteria will be
> > > classified as "default".
> > > +
> > > +AMD Hardware Feedback Interface
> > > +--------------------------------
> > > +
> > > +The Hardware Feedback Interface provides to the operating system
> > > information
> > > +about the performance and energy efficiency of each CPU in the syste=
m.
> > > Each
> > > +capability is given as a unit-less quantity in the range [0-255]. A
> > > higher
> > > +performance value indicates higher performance capability, and a hig=
her
> > > +efficiency value indicates more efficiency. Energy efficiency and
> > > performance
> > > +are reported in separate capabilities in the shared memory based ran=
king
> > > table.
> > > +
> > > +These capabilities may change at runtime as a result of changes in t=
he
> > > +operating conditions of the system or the action of external factors=
=2E
> > > +Power Management FW is responsible for detecting events that would
> > > require
> > > +a reordering of the performance and efficiency ranking. Table update=
s
> > > would
> > > +happen relatively infrequently and occur on the time scale of second=
s or
> > > more.
> > > +
> > > +The following events trigger a table update:
> > > +    * Thermal Stress Events
> > > +    * Silent Compute
> > > +    * Extreme Low Battery Scenarios
> > > +
> > > +The kernel or a userspace policy daemon can use these capabilities t=
o
> > > modify
> > > +task placement decisions. For instance, if either the performance or
> > > energy
> > > +capabilities of a given logical processor becomes zero, it is an
> > > indication that
> > > +the hardware recommends to the operating system to not schedule any =
tasks
> > > on
> > > +that processor for performance or energy efficiency reasons,
> > > respectively.
> > > +
> > > +Implementation details for Linux
> > > +--------------------------------
> > > +
> > > +The implementation of threads scheduling consists of the following s=
teps:
> > > +
> > > +1. A thread is spawned and scheduled to the ideal core using the def=
ault
> > > +   heterogeneous scheduling policy.
> > > +2. The processor profiles thread execution and assigns an enumerated
> > > classification ID.
> > > +   This classification is communicated to the OS via logical process=
or
> > > scope MSR.
> > > +3. During the thread context switch out the operating system consume=
s the
> > > workload(WL)
> > > +   classification which resides in a logical processor scope MSR.
> > > +4. The OS triggers the hardware to clear its history by writing to a=
n
> > > MSR,
> > > +   after consuming the WL classification and before switching in the=
 new
> > > thread.
> > > +5. If due to the classification, ranking table, and processor
> > > availability,
> > > +   the thread is not on its ideal processor, the OS will then consid=
er
> > > scheduling
> > > +   the thread on its ideal processor (if available).
> > > +
> > > +Ranking Table
> > > +-------------
> > > +The ranking table is a shared memory region that is used to communic=
ate
> > > the
> > > +performance and energy efficiency capabilities of each CPU in the sy=
stem.
> > > +
> > > +The ranking table design includes rankings for each APIC ID in the s=
ystem
> > > and
> > > +rankings both for performance and efficiency for each workload
> > > classification.
> > > +
> > > +.. kernel-doc:: drivers/platform/x86/amd/hfi/hfi.c
> > > +   :doc: amd_shmem_info
> > > +
> > > +Ranking Table update
> > > +---------------------------
> > > +The power management firmware issues an platform interrupt after upd=
ating
> > > the ranking
> > > +table and is ready for the operating system to consume it. CPUs rece=
ive
> > > such interrupt
> > > +and read new ranking table from shared memory which PCCT table has
> > > provided, then
> > > +``amd_hfi`` driver parse the new table to provide new consume data f=
or
> > > scheduling decisions.
> > > diff --git a/Documentation/arch/x86/index.rst
> > > b/Documentation/arch/x86/index.rst
> > > index 8ac64d7de4dc9..56f2923f52597 100644
> > > --- a/Documentation/arch/x86/index.rst
> > > +++ b/Documentation/arch/x86/index.rst
> > > @@ -43,3 +43,4 @@ x86-specific Documentation
> > >      features
> > >      elf_auxvec
> > >      xstate
> > > +   amd-hfi
> > >=20
> >=20
>=20
>=20
--8323328-1251599366-1742565489=:931--

