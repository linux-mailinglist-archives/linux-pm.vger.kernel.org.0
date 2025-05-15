Return-Path: <linux-pm+bounces-27222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B05AB92B6
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 01:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A07E174F28
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 23:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A946E28C85B;
	Thu, 15 May 2025 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEJD+/+i"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B8289350;
	Thu, 15 May 2025 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747350843; cv=none; b=SXpSwf0LqeLGw8SQaKlFgu//KnH6Y4tr79jK1VJD1co+nqxDCRb/skWlT2ua59gKg+RlMGDvMiL5XoMEl/eqQ6IkksQFd/Aom6swMrKHdqo4H3z/IAdgn9ltZq6p4qbCVY48tg3MwyLkcLfS53aAUJlZ08hLD0IsO8J7NNMqQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747350843; c=relaxed/simple;
	bh=KqMuxf9SaKWHq2sSCg2ifS1SPQDPbNmvhFTbFsJ80aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHi++mEN48c1U4H1Zqt4Qf4tahv/eUHBOLmgL7anj3WD2B7wz/0JKoXNwi+h5T+yOGgxWmgl/0tbWVXZvtjnv8s9BJduwLcm9R8aSF8gPtIx0Sw6kfCgGJvJ43pEY+PiPfGGyWO1sJoxnEXdiB4LuHa0mXWAJpSRUKAWJa7gDWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oEJD+/+i; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=l2HTjJLXCkXP9njX/Q5a/gHMnA3q+ubjVW5ykhl9oWI=; b=oEJD+/+ivxS5ZnxMiRO3xEvLuK
	sZ+vLy8qZArr8TTsXZS509uANu+4A16KAEc0ROcLCe83KbXiMnNhxpW5lstEsXgrAIJJie3ZgVjt8
	PM60dkM9bevTKEBQ+UYye/perG3OQwDFZGo4XgvKtTGdfjRJkIYAqBl+8RTZ5fNFHfCd7TXP/IgoH
	vqmH2tU6VXbYz/tK5Fl4fCqNpIoa5viMf2mySByX05s/2//nFTFEvAnoIHXzAJP3GWh3X472LrF2l
	u5tPCxgW144uZsOufE8RS1CcN846R0lL6gt1T/I9ZeTNYjJeuo6dRAMnryseIjFszECXASDUeZK8+
	BZjavgPQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uFhlo-000000000Tl-0jCW;
	Thu, 15 May 2025 23:13:46 +0000
Message-ID: <f79ad154-2bbe-4d21-8cd2-6ae3e5be2ed7@infradead.org>
Date: Thu, 15 May 2025 16:13:39 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/13] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
To: Mario Limonciello <superm1@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
 Huang Rui <ray.huang@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20250515211950.3102922-1-superm1@kernel.org>
 <20250515211950.3102922-2-superm1@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250515211950.3102922-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/15/25 2:19 PM, Mario Limonciello wrote:
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
>  Documentation/arch/x86/amd-hfi.rst | 133 +++++++++++++++++++++++++++++
>  Documentation/arch/x86/index.rst   |   1 +
>  2 files changed, 134 insertions(+)
>  create mode 100644 Documentation/arch/x86/amd-hfi.rst
> 
> diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
> new file mode 100644
> index 0000000000000..8c1799acb6fe6
> --- /dev/null
> +++ b/Documentation/arch/x86/amd-hfi.rst
> @@ -0,0 +1,133 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================================================
> +Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
> +======================================================================
> +
> +:Copyright: 2025 Advanced Micro Devices, Inc. All Rights Reserved.
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
> +Heterogeneous systems can also extend to more than two architectural classes
> +as well. The purpose of the scheduling feedback mechanism is to provide
> +information to the operating system scheduler in real time such that the
> +scheduler can direct threads to the optimal core.
> +
> +The goal of AMD's heterogeneous architecture is to attain power benefit by
> +sending background thread to the dense cores while sending high priority

                      threads

> +threads to the classic cores. From a performance perspective, sending
> +background threads to dense cores can free up power headroom and allow the
> +classic cores to optimally service demanding threads. Furthermore, the area
> +optimized nature of the dense cores allows for an increasing number of
> +physical cores. This improved core density will have positive multithreaded
> +performance impact.
> +
> +AMD Heterogeneous Core Driver
> +-----------------------------
> +
> +The ``amd_hfi`` driver delivers the operating system a performance and energy
> +efficiency capability data for each CPU in the system. The scheduler can use
> +the ranking data from the HFI driver to make task placement decisions.
> +
> +Thread Classification and Ranking Table Interaction
> +----------------------------------------------------
> +
> +The thread classification is used to select into a ranking table that
> +describes an efficiency and performance ranking for each classification.
> +
> +Threads are classified during runtime into enumerated classes. The classes
> +represent thread performance/power characteristics that may benefit from
> +special scheduling behaviors. The below table depicts an example of thread
> +classification and a preference where a given thread should be scheduled
> +based on its thread class. The real time thread classification is consumed
> +by the operating system and is used to inform the scheduler of where the
> +thread should be placed.
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

                        I would say                        are classified

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

s/FW/firmware/                                                s/would//

> +a reordering of the performance and efficiency ranking. Table updates would

                                                                       s/would//

> +happen relatively infrequently and occur on the time scale of seconds or more.
> +
> +The following events trigger a table update:
> +    * Thermal Stress Events
> +    * Silent Compute
> +    * Extreme Low Battery Scenarios
> +
> +The kernel or a userspace policy daemon can use these capabilities to modify
> +task placement decisions. For instance, if either the performance or energy
> +capabilities of a given logical processor becomes zero, it is an indication
> +that the hardware recommends to the operating system to not schedule any tasks
> +on that processor for performance or energy efficiency reasons, respectively.
> +
> +Implementation details for Linux
> +--------------------------------
> +
> +The implementation of threads scheduling consists of the following steps:
> +
> +1. A thread is spawned and scheduled to the ideal core using the default
> +   heterogeneous scheduling policy.
> +2. The processor profiles thread execution and assigns an enumerated
> +   classification ID.
> +   This classification is communicated to the OS via logical processor
> +   scope MSR.
> +3. During the thread context switch out the operating system consumes the
> +   workload(WL) classification which resides in a logical processor scope MSR.

      workload (WL)

> +4. The OS triggers the hardware to clear its history by writing to an MSR,
> +   after consuming the WL classification and before switching in the new thread.
> +5. If due to the classification, ranking table, and processor availability,
> +   the thread is not on its ideal processor, the OS will then consider
> +   scheduling the thread on its ideal processor (if available).
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
> +The power management firmware issues an platform interrupt after updating the
> +ranking table and is ready for the operating system to consume it. CPUs receive
> +such interrupt and read new ranking table from shared memory which PCCT table
> +has provided, then ``amd_hfi`` driver parse the new table to provide new

                                         parses

> +consume data for scheduling decisions.


-- 
~Randy


