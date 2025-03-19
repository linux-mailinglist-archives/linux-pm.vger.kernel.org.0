Return-Path: <linux-pm+bounces-24282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF47A68E61
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 15:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0427176F0C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31566192D70;
	Wed, 19 Mar 2025 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="guI65zrP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA53CF58;
	Wed, 19 Mar 2025 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392903; cv=none; b=TIhD4Mwdo+T9JCaEpiXRW4913O+3i8k2Yh734CMM4OO0KV9KZ4x8DyFQ6jwd2XFVk8cz6VceOUy9T8MCLZD+3wJNXP2BeIOWcXOW3mwUMp953HS/bjfjhVD0cHZk/hIz0Q7ZRwNsbWUbzlSzL3Csw4MBzMearQuYZ8aQCR239dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392903; c=relaxed/simple;
	bh=Cxfy3d8S24ex7ouwQehd3bv8bVD26RHC43WD15fDdoE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nT9NTZFAPyogGBbyUzqyFiaD7NK/hMvC/bbC4MzxF7t42GRgcPPTI8xw/h+3+zVoPD/HiVhFHD0IrIWpFfLhWYpfDi1bITJ1HWe6XpHzWfg0X8syPdor4+k973ctyjEAT8xqYU4mJLVs/EURewIsXU0abAdyZbw+HSCV6ZzPvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=guI65zrP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742392901; x=1773928901;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Cxfy3d8S24ex7ouwQehd3bv8bVD26RHC43WD15fDdoE=;
  b=guI65zrP5E3xgySwozR6OFPPS/4b+3f7d2l2CKD86oNdqrcp09SfK3RR
   G0tNHhAM1IM4ppYggMV6RqPYN2SzVWVMbdnEoFlowQTiGw8WkA2mgyG2i
   itr+HOPxQ/BhHHa3cQOhrM7BMaLhH8k3SY13buobqAhAEBPN0SxcjVtH5
   rEklcILppkxcE8JZe963jbhV6Ul4icX3BrMxu4wRkndUkf4bCP2cdO993
   tJ9tiufg9MxbJGevZ4YlBSSo+NKNGp8xCKdJ+9ReL49sgLbQiFPM6Ezsb
   /o+473uDQXHhtDSwHklyIvvuj8cGp2XcXgSpDgjIocYW9nNLbmWp8FI9B
   Q==;
X-CSE-ConnectionGUID: TTglCm9sRx2UuVq/dt9plQ==
X-CSE-MsgGUID: v3k77RP6TXK0B583RQ4w1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43598702"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43598702"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:01:39 -0700
X-CSE-ConnectionGUID: NjJY2e4/TBCzYpzX1mxF9Q==
X-CSE-MsgGUID: BP6enlkOTFeM7vBIP0hAFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123120013"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:01:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Mar 2025 16:01:29 +0200 (EET)
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
    Perry Yuan <Perry.Yuan@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v8 01/13] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
In-Reply-To: <20250218190822.1039982-2-superm1@kernel.org>
Message-ID: <127a93b0-647f-bb0c-2bf4-649fc4d1f25e@linux.intel.com>
References: <20250218190822.1039982-1-superm1@kernel.org> <20250218190822.1039982-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Feb 2025, Mario Limonciello wrote:

> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Introduce a new documentation file, `amd_hfi.rst`, which delves into the
> implementation details of the AMD Hardware Feedback Interface and its
> associated driver, `amd_hfi`. This documentation describes how the
> driver provides hint to the OS scheduling which depends on the capability
> of core performance and efficiency ranking data.
> 
> This documentation describes
> * The design of the driver
> * How the driver provides hints to the OS scheduling
> * How the driver interfaces with the kernel for efficiency ranking data.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/arch/x86/amd-hfi.rst | 127 +++++++++++++++++++++++++++++
>  Documentation/arch/x86/index.rst   |   1 +
>  2 files changed, 128 insertions(+)
>  create mode 100644 Documentation/arch/x86/amd-hfi.rst
> 
> diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
> new file mode 100644
> index 0000000000000..5d204688470e3
> --- /dev/null
> +++ b/Documentation/arch/x86/amd-hfi.rst
> @@ -0,0 +1,127 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================================================
> +Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
> +======================================================================
> +
> +:Copyright: 2024 Advanced Micro Devices, Inc. All Rights Reserved.
> +
> +:Author: Perry Yuan <perry.yuan@amd.com>
> +:Author: Mario Limonciello <mario.limonciello@amd.com>
> +
> +Overview
> +--------
> +
> +AMD Heterogeneous Core implementations are comprised of more than one
> +architectural class and CPUs are comprised of cores of various efficiency and
> +power capabilities: performance-oriented *classic cores* and power-efficient
> +*dense cores*. As such, power management strategies must be designed to
> +accommodate the complexities introduced by incorporating different core types.
> +Heterogeneous systems can also extend to more than two architectural classes as
> +well. The purpose of the scheduling feedback mechanism is to provide
> +information to the operating system scheduler in real time such that the
> +scheduler can direct threads to the optimal core.
> +
> +The goal of AMD's heterogeneous architecture is to attain power benefit by sending
> +background thread to the dense cores while sending high priority threads to the classic
> +cores. From a performance perspective, sending background threads to dense cores can free
> +up power headroom and allow the classic cores to optimally service demanding threads.
> +Furthermore, the area optimized nature of the dense cores allows for an increasing
> +number of physical cores. This improved core density will have positive multithreaded
> +performance impact.

Hi Mario,

Please fold these paragraphs to 80 characters so that they're easier to 
read as textfiles (the table can obviously exceed that but there should be 
no reason for the text paragraphs to have excessively long lines).

My apologies for taking so long to get to review this series. Most of my 
comments are quite minor but there's also 1-2 things that seem more 
important. It seemed to me that there is some disconnetion between the 
promises made in the Kconfig description and what is provided by the patch 
series.

--
 i.

> +
> +AMD Heterogeneous Core Driver
> +-----------------------------
> +
> +The ``amd_hfi`` driver delivers the operating system a performance and energy efficiency
> +capability data for each CPU in the system. The scheduler can use the ranking data
> +from the HFI driver to make task placement decisions.
> +
> +Thread Classification and Ranking Table Interaction
> +----------------------------------------------------
> +
> +The thread classification is used to select into a ranking table that describes
> +an efficiency and performance ranking for each classification.
> +
> +Threads are classified during runtime into enumerated classes. The classes represent
> +thread performance/power characteristics that may benefit from special scheduling behaviors.
> +The below table depicts an example of thread classification and a preference where a given thread
> +should be scheduled based on its thread class. The real time thread classification is consumed
> +by the operating system and is used to inform the scheduler of where the thread should be placed.
> +
> +Thread Classification Example Table
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| class ID | Classification | Preferred scheduling behavior | Preemption priority | Counter |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| 0        | Default        | Performant                    | Highest             |         |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| 1        | Non-scalable   | Efficient                     | Lowest              | PMCx1A1 |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +| 2        | I/O bound      | Efficient                     | Lowest              | PMCx044 |
> ++----------+----------------+-------------------------------+---------------------+---------+
> +
> +Thread classification is performed by the hardware each time that the thread is switched out.
> +Threads that don't meet any hardware specified criteria will be classified as "default".
> +
> +AMD Hardware Feedback Interface
> +--------------------------------
> +
> +The Hardware Feedback Interface provides to the operating system information
> +about the performance and energy efficiency of each CPU in the system. Each
> +capability is given as a unit-less quantity in the range [0-255]. A higher
> +performance value indicates higher performance capability, and a higher
> +efficiency value indicates more efficiency. Energy efficiency and performance
> +are reported in separate capabilities in the shared memory based ranking table.
> +
> +These capabilities may change at runtime as a result of changes in the
> +operating conditions of the system or the action of external factors.
> +Power Management FW is responsible for detecting events that would require
> +a reordering of the performance and efficiency ranking. Table updates would
> +happen relatively infrequently and occur on the time scale of seconds or more.
> +
> +The following events trigger a table update:
> +    * Thermal Stress Events
> +    * Silent Compute
> +    * Extreme Low Battery Scenarios
> +
> +The kernel or a userspace policy daemon can use these capabilities to modify
> +task placement decisions. For instance, if either the performance or energy
> +capabilities of a given logical processor becomes zero, it is an indication that
> +the hardware recommends to the operating system to not schedule any tasks on
> +that processor for performance or energy efficiency reasons, respectively.
> +
> +Implementation details for Linux
> +--------------------------------
> +
> +The implementation of threads scheduling consists of the following steps:
> +
> +1. A thread is spawned and scheduled to the ideal core using the default
> +   heterogeneous scheduling policy.
> +2. The processor profiles thread execution and assigns an enumerated classification ID.
> +   This classification is communicated to the OS via logical processor scope MSR.
> +3. During the thread context switch out the operating system consumes the workload(WL)
> +   classification which resides in a logical processor scope MSR.
> +4. The OS triggers the hardware to clear its history by writing to an MSR,
> +   after consuming the WL classification and before switching in the new thread.
> +5. If due to the classification, ranking table, and processor availability,
> +   the thread is not on its ideal processor, the OS will then consider scheduling
> +   the thread on its ideal processor (if available).
> +
> +Ranking Table
> +-------------
> +The ranking table is a shared memory region that is used to communicate the
> +performance and energy efficiency capabilities of each CPU in the system.
> +
> +The ranking table design includes rankings for each APIC ID in the system and
> +rankings both for performance and efficiency for each workload classification.
> +
> +.. kernel-doc:: drivers/platform/x86/amd/hfi/hfi.c
> +   :doc: amd_shmem_info
> +
> +Ranking Table update
> +---------------------------
> +The power management firmware issues an platform interrupt after updating the ranking
> +table and is ready for the operating system to consume it. CPUs receive such interrupt
> +and read new ranking table from shared memory which PCCT table has provided, then
> +``amd_hfi`` driver parse the new table to provide new consume data for scheduling decisions.
> diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
> index 8ac64d7de4dc9..56f2923f52597 100644
> --- a/Documentation/arch/x86/index.rst
> +++ b/Documentation/arch/x86/index.rst
> @@ -43,3 +43,4 @@ x86-specific Documentation
>     features
>     elf_auxvec
>     xstate
> +   amd-hfi
> 

-- 
 i.


