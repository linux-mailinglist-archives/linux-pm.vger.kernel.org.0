Return-Path: <linux-pm+bounces-27208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F621AB9186
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 23:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2441A4E569E
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AC289823;
	Thu, 15 May 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZU4IX+7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB2218AAA;
	Thu, 15 May 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344001; cv=none; b=m5WK2NsZZkhFqXZzeZPdCJEL0PzfAMS8425jfXIERSbC7lU8CIkkMTouvUps73TuadB9jkhHhg3DS9kBKlvGrv6CJT36tlDbrWR07uCf8ccUU4VZzhLhomf4kDKqlHTLpoO908HqnTvxUQfD4E4jgDEd5OlMNkpYn1nZ/mzASgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344001; c=relaxed/simple;
	bh=ZZPLPFekmqonJmYX/xbKyqOt43jN+w5eM5nlYX4e6+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzcqEbcskEi6uKbRLtJIs1E5ikjXXl+RLBkbw6NLKFw95hxYMN/xspJTlAu8XlqmppAeTs8b7RHXMsOqy0u4H9Krsgp41BgQnI4fQDELcaSBt69qgLqaKnHWHm3+wFxb67bkONo9U0yldFQ4mPHDozjmafhyVKnN+vNdKWzHr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZU4IX+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4233C4CEF1;
	Thu, 15 May 2025 21:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747344000;
	bh=ZZPLPFekmqonJmYX/xbKyqOt43jN+w5eM5nlYX4e6+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZU4IX+7uYEM2hSyE7J+xtar0A883pyCqJrN0dlvbuCaZ8j9rEzehCtw5ayUWIubl
	 iPHQEYJDowe0E8Emsxe61p36Cu8y6AArAJvXiEauQMB3/g0AFHbHxDE8qsLQUx1Vlf
	 MrfnegcAPmFPoPimZkmppKz7MmswwxvsTeC0sM3X7i22ednQySMa7W7NegvBV7Ddfc
	 +duaTlAGqfztPDHH44HSmaLMeDtjxKx1KPU+YxIsxiA6S4dkdO4/Xk0WZPUwbt63qL
	 xNOWlAO1oOhxdxB0tjhF5/hbhWciJl8ZKyqkOq4h6GPeP626JnsF37SWKLdQ9t6+th
	 pd2IZE1VXEjZA==
From: Mario Limonciello <superm1@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	platform-driver-x86@vger.kernel.org (open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER),
	Perry Yuan <Perry.Yuan@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v10 01/13] Documentation: x86: Add AMD Hardware Feedback Interface documentation
Date: Thu, 15 May 2025 16:19:38 -0500
Message-ID: <20250515211950.3102922-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515211950.3102922-1-superm1@kernel.org>
References: <20250515211950.3102922-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce a new documentation file, `amd_hfi.rst`, which delves into the
implementation details of the AMD Hardware Feedback Interface and its
associated driver, `amd_hfi`. This documentation describes how the
driver provides hint to the OS scheduling which depends on the capability
of core performance and efficiency ranking data.

This documentation describes
* The design of the driver
* How the driver provides hints to the OS scheduling
* How the driver interfaces with the kernel for efficiency ranking data.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/arch/x86/amd-hfi.rst | 133 +++++++++++++++++++++++++++++
 Documentation/arch/x86/index.rst   |   1 +
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst

diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
new file mode 100644
index 0000000000000..8c1799acb6fe6
--- /dev/null
+++ b/Documentation/arch/x86/amd-hfi.rst
@@ -0,0 +1,133 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================================
+Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
+======================================================================
+
+:Copyright: 2025 Advanced Micro Devices, Inc. All Rights Reserved.
+
+:Author: Perry Yuan <perry.yuan@amd.com>
+:Author: Mario Limonciello <mario.limonciello@amd.com>
+
+Overview
+--------
+
+AMD Heterogeneous Core implementations are comprised of more than one
+architectural class and CPUs are comprised of cores of various efficiency and
+power capabilities: performance-oriented *classic cores* and power-efficient
+*dense cores*. As such, power management strategies must be designed to
+accommodate the complexities introduced by incorporating different core types.
+Heterogeneous systems can also extend to more than two architectural classes
+as well. The purpose of the scheduling feedback mechanism is to provide
+information to the operating system scheduler in real time such that the
+scheduler can direct threads to the optimal core.
+
+The goal of AMD's heterogeneous architecture is to attain power benefit by
+sending background thread to the dense cores while sending high priority
+threads to the classic cores. From a performance perspective, sending
+background threads to dense cores can free up power headroom and allow the
+classic cores to optimally service demanding threads. Furthermore, the area
+optimized nature of the dense cores allows for an increasing number of
+physical cores. This improved core density will have positive multithreaded
+performance impact.
+
+AMD Heterogeneous Core Driver
+-----------------------------
+
+The ``amd_hfi`` driver delivers the operating system a performance and energy
+efficiency capability data for each CPU in the system. The scheduler can use
+the ranking data from the HFI driver to make task placement decisions.
+
+Thread Classification and Ranking Table Interaction
+----------------------------------------------------
+
+The thread classification is used to select into a ranking table that
+describes an efficiency and performance ranking for each classification.
+
+Threads are classified during runtime into enumerated classes. The classes
+represent thread performance/power characteristics that may benefit from
+special scheduling behaviors. The below table depicts an example of thread
+classification and a preference where a given thread should be scheduled
+based on its thread class. The real time thread classification is consumed
+by the operating system and is used to inform the scheduler of where the
+thread should be placed.
+
+Thread Classification Example Table
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
++----------+----------------+-------------------------------+---------------------+---------+
+| class ID | Classification | Preferred scheduling behavior | Preemption priority | Counter |
++----------+----------------+-------------------------------+---------------------+---------+
+| 0        | Default        | Performant                    | Highest             |         |
++----------+----------------+-------------------------------+---------------------+---------+
+| 1        | Non-scalable   | Efficient                     | Lowest              | PMCx1A1 |
++----------+----------------+-------------------------------+---------------------+---------+
+| 2        | I/O bound      | Efficient                     | Lowest              | PMCx044 |
++----------+----------------+-------------------------------+---------------------+---------+
+
+Thread classification is performed by the hardware each time that the thread is switched out.
+Threads that don't meet any hardware specified criteria will be classified as "default".
+
+AMD Hardware Feedback Interface
+--------------------------------
+
+The Hardware Feedback Interface provides to the operating system information
+about the performance and energy efficiency of each CPU in the system. Each
+capability is given as a unit-less quantity in the range [0-255]. A higher
+performance value indicates higher performance capability, and a higher
+efficiency value indicates more efficiency. Energy efficiency and performance
+are reported in separate capabilities in the shared memory based ranking table.
+
+These capabilities may change at runtime as a result of changes in the
+operating conditions of the system or the action of external factors.
+Power Management FW is responsible for detecting events that would require
+a reordering of the performance and efficiency ranking. Table updates would
+happen relatively infrequently and occur on the time scale of seconds or more.
+
+The following events trigger a table update:
+    * Thermal Stress Events
+    * Silent Compute
+    * Extreme Low Battery Scenarios
+
+The kernel or a userspace policy daemon can use these capabilities to modify
+task placement decisions. For instance, if either the performance or energy
+capabilities of a given logical processor becomes zero, it is an indication
+that the hardware recommends to the operating system to not schedule any tasks
+on that processor for performance or energy efficiency reasons, respectively.
+
+Implementation details for Linux
+--------------------------------
+
+The implementation of threads scheduling consists of the following steps:
+
+1. A thread is spawned and scheduled to the ideal core using the default
+   heterogeneous scheduling policy.
+2. The processor profiles thread execution and assigns an enumerated
+   classification ID.
+   This classification is communicated to the OS via logical processor
+   scope MSR.
+3. During the thread context switch out the operating system consumes the
+   workload(WL) classification which resides in a logical processor scope MSR.
+4. The OS triggers the hardware to clear its history by writing to an MSR,
+   after consuming the WL classification and before switching in the new thread.
+5. If due to the classification, ranking table, and processor availability,
+   the thread is not on its ideal processor, the OS will then consider
+   scheduling the thread on its ideal processor (if available).
+
+Ranking Table
+-------------
+The ranking table is a shared memory region that is used to communicate the
+performance and energy efficiency capabilities of each CPU in the system.
+
+The ranking table design includes rankings for each APIC ID in the system and
+rankings both for performance and efficiency for each workload classification.
+
+.. kernel-doc:: drivers/platform/x86/amd/hfi/hfi.c
+   :doc: amd_shmem_info
+
+Ranking Table update
+---------------------------
+The power management firmware issues an platform interrupt after updating the
+ranking table and is ready for the operating system to consume it. CPUs receive
+such interrupt and read new ranking table from shared memory which PCCT table
+has provided, then ``amd_hfi`` driver parse the new table to provide new
+consume data for scheduling decisions.
diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
index 58a006525ae81..cd9143d623872 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -28,6 +28,7 @@ x86-specific Documentation
    amd-debugging
    amd-memory-encryption
    amd_hsmp
+   amd-hfi
    tdx
    pti
    mds
-- 
2.43.0


