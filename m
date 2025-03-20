Return-Path: <linux-pm+bounces-24338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A367A6AB3E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 17:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F41898026
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2E021CA00;
	Thu, 20 Mar 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxDa0VAR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDB17591;
	Thu, 20 Mar 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488878; cv=none; b=BYfST17J7jhOhhPz2B/7XUg/ZtBxlGQprLmznXWWwOYaTgzqkQMVFn+86P/Las6R0vfVHgpzoj/KGHN8Ogb7L4yljd/ZF20GdWKtaRumxbA4KPowV3n7dOaoJWpkN4CtLKkyuxTnt3P/9A+FphOwENTlBqWWtbyqNRpAqhkopgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488878; c=relaxed/simple;
	bh=qIRZ0qTaew+CUAIPbfZmaL9vAfGx/qP1dB6OlqhWKXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdlUX1jLWrUqp3dYKHe9VbDzADYcFYz9YAMy8MYx7X2+AUbDe6bTqXKoEzkP2IGSuOA9XbCB2e19fDxRDN0+TykgQ558qEVwK5WMbL4fSiCr6LTGWAvKEvwR3zzz9hceZYmWG6Q0NicEzM6Vkyk5uILkAldPl8aiJAFsYUZvhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxDa0VAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9246CC4CEDD;
	Thu, 20 Mar 2025 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742488878;
	bh=qIRZ0qTaew+CUAIPbfZmaL9vAfGx/qP1dB6OlqhWKXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KxDa0VAREDHlo/i49o7eH+gMgXcP2OWzKC3DCY1PUe1aqv0dNm+bOXD34vcLbznoF
	 5D9OuTuPBEzNTsJ5/NVTjDYhixAnWxkUd6m35rsD1rILA6fMbseDpoRKrQne5Ab9/0
	 Dot/HUbqdcuJ4cnDwHShHkXsc8QSa7iEa6Ajm95K/jOadvrvRYBZXxq2w5TmmVKEZx
	 Z+sB2Idb+qFosvdAaLEo1CSd3/zHoyyZUbvtkkR/ym7yk1qe/XHU6px9ee84ldE2d/
	 Xvx3i/9F+g1N++CqYYNIeedCDRfKJZkoyxU4fEWHrJVYtIaVsprFwXeguNrl9OB5EA
	 YFcLrElnuzqOA==
Message-ID: <a2e33d66-22ee-475b-817b-b52c6890859c@kernel.org>
Date: Thu, 20 Mar 2025 11:41:15 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/13] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
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
References: <20250218190822.1039982-1-superm1@kernel.org>
 <20250218190822.1039982-2-superm1@kernel.org>
 <127a93b0-647f-bb0c-2bf4-649fc4d1f25e@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <127a93b0-647f-bb0c-2bf4-649fc4d1f25e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/19/2025 09:01, Ilpo Järvinen wrote:
> On Tue, 18 Feb 2025, Mario Limonciello wrote:
> 
>> From: Perry Yuan <Perry.Yuan@amd.com>
>>
>> Introduce a new documentation file, `amd_hfi.rst`, which delves into the
>> implementation details of the AMD Hardware Feedback Interface and its
>> associated driver, `amd_hfi`. This documentation describes how the
>> driver provides hint to the OS scheduling which depends on the capability
>> of core performance and efficiency ranking data.
>>
>> This documentation describes
>> * The design of the driver
>> * How the driver provides hints to the OS scheduling
>> * How the driver interfaces with the kernel for efficiency ranking data.
>>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   Documentation/arch/x86/amd-hfi.rst | 127 +++++++++++++++++++++++++++++
>>   Documentation/arch/x86/index.rst   |   1 +
>>   2 files changed, 128 insertions(+)
>>   create mode 100644 Documentation/arch/x86/amd-hfi.rst
>>
>> diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
>> new file mode 100644
>> index 0000000000000..5d204688470e3
>> --- /dev/null
>> +++ b/Documentation/arch/x86/amd-hfi.rst
>> @@ -0,0 +1,127 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======================================================================
>> +Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
>> +======================================================================
>> +
>> +:Copyright: 2024 Advanced Micro Devices, Inc. All Rights Reserved.
>> +
>> +:Author: Perry Yuan <perry.yuan@amd.com>
>> +:Author: Mario Limonciello <mario.limonciello@amd.com>
>> +
>> +Overview
>> +--------
>> +
>> +AMD Heterogeneous Core implementations are comprised of more than one
>> +architectural class and CPUs are comprised of cores of various efficiency and
>> +power capabilities: performance-oriented *classic cores* and power-efficient
>> +*dense cores*. As such, power management strategies must be designed to
>> +accommodate the complexities introduced by incorporating different core types.
>> +Heterogeneous systems can also extend to more than two architectural classes as
>> +well. The purpose of the scheduling feedback mechanism is to provide
>> +information to the operating system scheduler in real time such that the
>> +scheduler can direct threads to the optimal core.
>> +
>> +The goal of AMD's heterogeneous architecture is to attain power benefit by sending
>> +background thread to the dense cores while sending high priority threads to the classic
>> +cores. From a performance perspective, sending background threads to dense cores can free
>> +up power headroom and allow the classic cores to optimally service demanding threads.
>> +Furthermore, the area optimized nature of the dense cores allows for an increasing
>> +number of physical cores. This improved core density will have positive multithreaded
>> +performance impact.
> 
> Hi Mario,
> 
> Please fold these paragraphs to 80 characters so that they're easier to
> read as textfiles (the table can obviously exceed that but there should be
> no reason for the text paragraphs to have excessively long lines).
> 
> My apologies for taking so long to get to review this series. 

No problem.  Thanks for looking.  I'll get a new version ready to put 
out after the next merge window.

> Most of my
> comments are quite minor but there's also 1-2 things that seem more
> important. It seemed to me that there is some disconnetion between the
> promises made in the Kconfig description and what is provided by the patch
> series.

Some of the series was pared down to go in multiple parts to make it 
easier to review with follow ups for the dynamic stuff planned for the 
next iteration.

You see some artifacts of that comments and Kconfig.  I figured it was 
better to leave as is for those given they get to the intent, but I can 
change if you think it's better to adjust them when the next part lands 
instead.

> 
> --
>   i.
> 
>> +
>> +AMD Heterogeneous Core Driver
>> +-----------------------------
>> +
>> +The ``amd_hfi`` driver delivers the operating system a performance and energy efficiency
>> +capability data for each CPU in the system. The scheduler can use the ranking data
>> +from the HFI driver to make task placement decisions.
>> +
>> +Thread Classification and Ranking Table Interaction
>> +----------------------------------------------------
>> +
>> +The thread classification is used to select into a ranking table that describes
>> +an efficiency and performance ranking for each classification.
>> +
>> +Threads are classified during runtime into enumerated classes. The classes represent
>> +thread performance/power characteristics that may benefit from special scheduling behaviors.
>> +The below table depicts an example of thread classification and a preference where a given thread
>> +should be scheduled based on its thread class. The real time thread classification is consumed
>> +by the operating system and is used to inform the scheduler of where the thread should be placed.
>> +
>> +Thread Classification Example Table
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> ++----------+----------------+-------------------------------+---------------------+---------+
>> +| class ID | Classification | Preferred scheduling behavior | Preemption priority | Counter |
>> ++----------+----------------+-------------------------------+---------------------+---------+
>> +| 0        | Default        | Performant                    | Highest             |         |
>> ++----------+----------------+-------------------------------+---------------------+---------+
>> +| 1        | Non-scalable   | Efficient                     | Lowest              | PMCx1A1 |
>> ++----------+----------------+-------------------------------+---------------------+---------+
>> +| 2        | I/O bound      | Efficient                     | Lowest              | PMCx044 |
>> ++----------+----------------+-------------------------------+---------------------+---------+
>> +
>> +Thread classification is performed by the hardware each time that the thread is switched out.
>> +Threads that don't meet any hardware specified criteria will be classified as "default".
>> +
>> +AMD Hardware Feedback Interface
>> +--------------------------------
>> +
>> +The Hardware Feedback Interface provides to the operating system information
>> +about the performance and energy efficiency of each CPU in the system. Each
>> +capability is given as a unit-less quantity in the range [0-255]. A higher
>> +performance value indicates higher performance capability, and a higher
>> +efficiency value indicates more efficiency. Energy efficiency and performance
>> +are reported in separate capabilities in the shared memory based ranking table.
>> +
>> +These capabilities may change at runtime as a result of changes in the
>> +operating conditions of the system or the action of external factors.
>> +Power Management FW is responsible for detecting events that would require
>> +a reordering of the performance and efficiency ranking. Table updates would
>> +happen relatively infrequently and occur on the time scale of seconds or more.
>> +
>> +The following events trigger a table update:
>> +    * Thermal Stress Events
>> +    * Silent Compute
>> +    * Extreme Low Battery Scenarios
>> +
>> +The kernel or a userspace policy daemon can use these capabilities to modify
>> +task placement decisions. For instance, if either the performance or energy
>> +capabilities of a given logical processor becomes zero, it is an indication that
>> +the hardware recommends to the operating system to not schedule any tasks on
>> +that processor for performance or energy efficiency reasons, respectively.
>> +
>> +Implementation details for Linux
>> +--------------------------------
>> +
>> +The implementation of threads scheduling consists of the following steps:
>> +
>> +1. A thread is spawned and scheduled to the ideal core using the default
>> +   heterogeneous scheduling policy.
>> +2. The processor profiles thread execution and assigns an enumerated classification ID.
>> +   This classification is communicated to the OS via logical processor scope MSR.
>> +3. During the thread context switch out the operating system consumes the workload(WL)
>> +   classification which resides in a logical processor scope MSR.
>> +4. The OS triggers the hardware to clear its history by writing to an MSR,
>> +   after consuming the WL classification and before switching in the new thread.
>> +5. If due to the classification, ranking table, and processor availability,
>> +   the thread is not on its ideal processor, the OS will then consider scheduling
>> +   the thread on its ideal processor (if available).
>> +
>> +Ranking Table
>> +-------------
>> +The ranking table is a shared memory region that is used to communicate the
>> +performance and energy efficiency capabilities of each CPU in the system.
>> +
>> +The ranking table design includes rankings for each APIC ID in the system and
>> +rankings both for performance and efficiency for each workload classification.
>> +
>> +.. kernel-doc:: drivers/platform/x86/amd/hfi/hfi.c
>> +   :doc: amd_shmem_info
>> +
>> +Ranking Table update
>> +---------------------------
>> +The power management firmware issues an platform interrupt after updating the ranking
>> +table and is ready for the operating system to consume it. CPUs receive such interrupt
>> +and read new ranking table from shared memory which PCCT table has provided, then
>> +``amd_hfi`` driver parse the new table to provide new consume data for scheduling decisions.
>> diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
>> index 8ac64d7de4dc9..56f2923f52597 100644
>> --- a/Documentation/arch/x86/index.rst
>> +++ b/Documentation/arch/x86/index.rst
>> @@ -43,3 +43,4 @@ x86-specific Documentation
>>      features
>>      elf_auxvec
>>      xstate
>> +   amd-hfi
>>
> 


