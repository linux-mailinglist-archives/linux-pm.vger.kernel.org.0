Return-Path: <linux-pm+bounces-16537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D949B2264
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B41E1F21090
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658FB18A6D5;
	Mon, 28 Oct 2024 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i5k7CTNn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD392188A08;
	Mon, 28 Oct 2024 02:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081001; cv=fail; b=ATis3GqpR9z+l824ES++H2c6iQYIoPW0h81ew/0A5NzLYAJ9N1LVdog2KPxGRfE06vbm/gQ363hxaQVq9JRxCA2oFOe8rrECwV65ELpQoafNeHeMlZHWl6Ov1kCxsk1Nh1jZKkrrrqrJfK03csC2MPOTdXEbEvH/NGh/7YgzXj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081001; c=relaxed/simple;
	bh=8HG1aI0ZH+69GiaPX1fCROITr6TmMRta77jCS37iELE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhvT9RgT5pQ7g9i1pVIVZY/1R7QktxQIeL+Q7y4xSLX4gMn7OwB/PMdLLFT78D7POUCkwQsHGIIF16/PlRWeJ3Jj4gzuj+YIgpo36QjO9se4M5ALA2UwK2kQjktwF4GVhOkKlV/mZ2Fg4istOFxkbyw/HU23ySvxYcBRM6f76Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i5k7CTNn; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFhmaY9dbqiDhWSQ8xArp+sMWGlxDJ5Y97QAXhB3bl4xpyKW/xOqSxPNSgrnapo6Ns4IPg5O4zgC3Yy76Lc0Li9bS0ciZhHVUZiKH5Wm6k2PQhs2SxzzhHunNrdYnc80gL/N186EBRGkbSEM+L9mnIOa6RvNmliJcQQWBxHs2h4VTrRrEC+Vnp0ksm2JNZfd7+tD5z1smnIG0RI41l3zBz4kMOlQrQWEAZbfmYngNOaqEL5m0LVmWJIM7S8U5Usok8zmmA/HYf7PQ6yQsLUUV6CeNC1+3lLXgy829/NisGVv4HHiiyr+0+AqHRZXjnWbjuC1szWO3Q/ZgbqLtufjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuCe+9169sOZvFFHYStLSQ95SM3TAhSPvmqLex9qHT8=;
 b=mNe7YTk6u7XziB7JQM4ISHJpOpi32VK/vP6dhUq6h8DWmJx8JQ8gyuXtBCBDy1mGjUCfudvmAQAm76wKf+PIm4Eh27YCZHyQ37c8tg4eH1ob9EB1zA+0pxldDhBX2ZMl6cUXQGcBO/6a343L3M6mLSECiTSLLuVbZbJ2tbSZlLPU2BTAlU4Ey8G1Adlo00CivRiYFchasmrz14VZ7c1WYrfCrml5y1HyT26QJ3g7TT4m+oKpnA8WcgZug5HX5MZeNBkCcFzEIiRvy0kfIK4vQDnlGvTLW2YFxod+oRDgvE2g56x6Up+WjagBOgZdiey46XbrqMoL50jgBkO3HSlBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuCe+9169sOZvFFHYStLSQ95SM3TAhSPvmqLex9qHT8=;
 b=i5k7CTNnJ8thTy0k7rTPZgGZOatjp+a7yyeCSGtHR3uulF2Ln801sGHFlHvB9GLx+UaPt8clu4KE79g7tKhVEOXBwAOnkEPkGa8LpYb3EMVgCBbOi83/XtnRh/39Cl988e7LeVRLNI05tjuWyb7mrTlYdcGHzIrkRpQfFpashuA=
Received: from MN2PR06CA0026.namprd06.prod.outlook.com (2603:10b6:208:23d::31)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 02:03:11 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::78) by MN2PR06CA0026.outlook.office365.com
 (2603:10b6:208:23d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:11 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:09 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
	"Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: [PATCH v5 01/13] Documentation: x86: Add AMD Hardware Feedback Interface documentation
Date: Sun, 27 Oct 2024 21:02:39 -0500
Message-ID: <20241028020251.8085-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020251.8085-1-mario.limonciello@amd.com>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 073a1b50-d638-4d60-a0a6-08dcf6f4acef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OCZy8FIdIzZ5JijPM12GdnuasNw7bFuDIW8lx6oscGNqGAokPr7/869ZGwnZ?=
 =?us-ascii?Q?TLX40XaBCTCc4fqtAZ1G8HJ0s+jcd1rm5zfz/4c2M/bqdV/He9z2PfUa26xs?=
 =?us-ascii?Q?cF9iAqyaI+JgGM9F3aVQnthVwU888m7C+N9o8b42UX3OAcqRTG0bHRwwEJFK?=
 =?us-ascii?Q?1DdLG4GmsaGh4DW6zjZxAMBCjemVzD2YReDhzSZtycuoj59pHWq0Rn7SG51A?=
 =?us-ascii?Q?BFOL35m8VDNXcUr9cQgvxknaSGrisqcaAyBBpcdbfC5SbeE4gRy35/zyifjN?=
 =?us-ascii?Q?0/3X1pA5u46KdyZRNVP3iKihevQTHMlezhZOZmvkLVp2A6oadtqoWeSL7iy0?=
 =?us-ascii?Q?Kh/vl3O+2RUYereem+Bk+s7971RCoJrVMr9EMKPagrUFlMpwaYGMBtVRyKsv?=
 =?us-ascii?Q?8da0S9fyjj+Rw2okjtbwhVQEQHaVHwdtz9OUA0K4uYDl+g+/gMDAV6o1ASKo?=
 =?us-ascii?Q?LoEqrjJZx1b4eAYZeU84NNk7bdgY0HJvoyTHbqZrbTWZg/Vm6TrVTliG81TW?=
 =?us-ascii?Q?lRe1y5A8g9tv35X0liIIoF95sdqk7LP2TkE24GaPKLMmhjM8uvusd7B6VsCh?=
 =?us-ascii?Q?YsU5ZriURMmf5G5YRHmd4i4w6MJrMc51VyKD8dfCSj1wrAW28sYQTitl4XJK?=
 =?us-ascii?Q?H/s3L1Ai1+K6R28KLXpHel+Mz9Lrp1i06KgnPEFIxp+X2HKS07etIX0qyeW0?=
 =?us-ascii?Q?2MCORRAEtuMxD23H7Hrb1TsAfwKF0N5eteWKP9SBjsR//IYyZhQXjPHpmTRq?=
 =?us-ascii?Q?w9Qb/NQhC39WUozjrggwuLNHKKIerORyWuRhQhkngjZa9Q48VcnDKxE71pOE?=
 =?us-ascii?Q?TT+94FQCQpQACdo1U1mI3YBWGRCQGAMV+NPgK+linVp48q+VG/IPJmBTb1Cy?=
 =?us-ascii?Q?lQ+LaqjWELXLWoldwVNkIIXjMztJVpkX5MJBg11nsFWHWQymVB1UG0qU1vqG?=
 =?us-ascii?Q?rhkTL3Iluj9IEAbUe+i3g9HjZfyjdyrR7mkQwSP3hasL179+OctnUJerhsgO?=
 =?us-ascii?Q?mUxHQliq5/wuSaxm+/Z3k+7Aq+GaFdKH9U07jQYJSBumAwkH9/WEB6g5F+tK?=
 =?us-ascii?Q?229kVM1hEGvApguUw9Dbt/nxI9SHP5ylZJQiHaKhnPhJfL9BHGw8lhcM1nYD?=
 =?us-ascii?Q?la22WB+AxSC0D1yKtKTOgppfHwUlNOSOZZCvE0rBFg9BYMveo6pBAlIELPJt?=
 =?us-ascii?Q?rkmDzZZvV03hOG65NUlmfA/F1LSPeKmTxuEconM78HofwcdcD/NiD8To8hOb?=
 =?us-ascii?Q?reAs4z4j6UU7rLmNMq4CNeP0lTSh2lFkDSolpSBnwRmDsFpVHxehoDR3zLqY?=
 =?us-ascii?Q?eCtRCzyjYMZdWVVT1qoYfqXDHrtFZ60OPibatyPH/BpOzb0rmzbhVlpdb4Ww?=
 =?us-ascii?Q?R57gTU7lgj9tiQc9KtKIWV0vwElnvWYHCPnirQ4ofgIG7Ahv0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:11.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 073a1b50-d638-4d60-a0a6-08dcf6f4acef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

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
 Documentation/arch/x86/amd-hfi.rst | 129 +++++++++++++++++++++++++++++
 Documentation/arch/x86/index.rst   |   1 +
 2 files changed, 130 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst

diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
new file mode 100644
index 0000000000000..b66ff083855f3
--- /dev/null
+++ b/Documentation/arch/x86/amd-hfi.rst
@@ -0,0 +1,129 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================================
+Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
+======================================================================
+
+:Copyright: 2024 Advanced Micro Devices, Inc. All Rights Reserved.
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
+Heterogeneous systems can also extend to more than two architectural classes as
+well. The purpose of the scheduling feedback mechanism is to provide
+information to the operating system scheduler in real time such that the
+scheduler can direct threads to the optimal core.
+
+The goal of AMD's heterogeneous architecture is to attain power benefit by sending
+background thread to the dense cores while sending high priority threads to the classic
+cores. From a performance perspective, sending background threads to dense cores can free
+up power headroom and allow the classic cores to optimally service demanding threads.
+Furthermore, the area optimized nature of the dense cores allows for an increasing
+number of physical cores. This improved core density will have positive multithreaded
+performance impact.
+
+AMD Heterogeneous Core Driver
+-----------------------------
+
+The ``amd_hfi`` driver delivers the operating system a performance and energy efficiency
+capability data for each CPU in the system. The scheduler can use the ranking data
+from the HFI driver to make task placement decisions.
+
+Thread Classification and Ranking Table Interaction
+----------------------------------------------------
+
+The thread classification is used to select into a ranking table that describes
+an efficiency and performance ranking for each classification.
+
+Threads are classified during runtime into enumerated classes. The classes represent
+thread performance/power characteristics that may benefit from special scheduling behaviors.
+The below table depicts an example of thread classification and a preference where a given thread
+should be scheduled based on its thread class. The real time thread classification is consumed
+by the operating system and is used to inform the scheduler of where the thread should be placed.
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
+capabilities of a given logical processor becomes zero, it is an indication that
+the hardware recommends to the operating system to not schedule any tasks on
+that processor for performance or energy efficiency reasons, respectively.
+
+Implementation details for Linux
+--------------------------------
+
+The implementation of threads scheduling consists of the following steps:
+
+1. A thread is spawned and scheduled to the ideal core using the default
+   heterogeneous scheduling policy.
+2. The processor profiles thread execution and assigns an enumerated classification ID.
+   This classification is communicated to the OS via logical processor scope MSR.
+3. During the thread context switch out the operating system consumes the workload(WL)
+   classification which resides in a logical processor scope MSR.
+4. The OS triggers the hardware to clear its history by writing to an MSR,
+   after consuming the WL classification and before switching in the new thread.
+5. If due to the classification, ranking table, and processor availability,
+   the thread is not on its ideal processor, the OS will then consider scheduling
+   the thread on its ideal processor (if available).
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
+The power management firmware issues an platform interrupt after updating the ranking
+table and is ready for the operating system to consume it. CPUs receive such interrupt
+and read new ranking table from shared memory which PCCT table has provided, then
+``amd_hfi`` driver parse the new table to provide new consume data for scheduling decisions.
+
+
diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
index 8ac64d7de4dc9..56f2923f52597 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -43,3 +43,4 @@ x86-specific Documentation
    features
    elf_auxvec
    xstate
+   amd-hfi
-- 
2.43.0


