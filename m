Return-Path: <linux-pm+bounces-18287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0089DF17E
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3102816BD
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4B1A0BF1;
	Sat, 30 Nov 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Te4nnZoN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C58199FAC;
	Sat, 30 Nov 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980055; cv=fail; b=Gu6H1RNO/z/YOBTSDzx73q5ZsW33j7EDvrFCcRvgMog12G2ubb6EofHg1YO4Q9iq2CU0qi05WgTRRQntHygqnhFYJZeNjYb00nZ3524ZA4JcyBzqdEubPc/2MBu4/JDkqssOcUdj6xWkIZwu2yKN4NImOt8bfzqYFJIpM52G1qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980055; c=relaxed/simple;
	bh=DMjuuDJSJxfHSpL4ibtc9T2fw/bT7ago7AntzlFc7a4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KseXXSHFoWS6UPqr6UhrtG5QGjE5IHvkdk9TRbW85dwFlOJ5InCIQafpwXQJOCKDxwGzDSTz/l7Eur+hWrXZf+Rq9sWp2jAWbQ0ideAs42eZxySCfgjrQbw7N/zPoz1HjjvoNax/8O4dgpkrvvmG6OOfduu+uGy7iVurrkxK6og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Te4nnZoN; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZhngobgt0ICRODqCCh5WtufcjJOGH8Z31xLTQX/rydWZ4vpL8LJKeC1ryAtG3DXA7Dveaa0wlLHShEn1FSGI97jTZf5dQl9Q9XiAvUbXhD/w+ewt93//43lX9rhkxqbGvZpoU8KWgjVjKv+hW84z25yWeDhAueDezm5KNQyY7JL5ujffVcsMwEskEJ3v6/omx/sTPuI9sRtjNy1aGujpq4n1F5BW9xXVeFuYWEtI09BKvUvpBV0n1bj//IjKpzC6QnGoYorG0a4IQKnUUYbmcWKGGaeQzE0LUdvCeO6EI+AO9IfqM4uPyRCYLswP30SgGR6he2J0qe+Xhjm0146Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMJT/T88UaQRulFTCrjZGsRHX2tB2kPq7JxN+LCfSgE=;
 b=opms+vMDx4rmogmIr+sHfSdaGbZxkYR4wTKIHQB9w6y01PtNNaEnz+TIrEOD2vyHfqBrewqlnei9BdxRsrWtqPB6e2iPf4rHZCWAy6WEO99r7mZsNSWZpV7efP0PMojhNBOxmgccL7lvfqo9vNYvLa1Ur/TxcehEc7eqeH2jQg+g9rPTA9rq6v7Uo7FO7FUvlrkM8e4Da0SN3AwqgyKrXd1fUP7r0Bof3RpVX7iV9GaazTgxGc2k20iBW5Wybm7JPu2OF599Eqhun5f2ovudrcxrS9YrPrwXxV0ZeEQxfOL6jlRJjBkwg+trGnG9U7EVdsopCfnN1tewEaE/Pvlikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMJT/T88UaQRulFTCrjZGsRHX2tB2kPq7JxN+LCfSgE=;
 b=Te4nnZoNIMR/bqYc0z2GeAOMRxJjG8Pv+KYnATYs8CL8nQZV1b5KDczv+/H0VnRSzPOzlUaxbTZYpmJS7BR3eXxvmqu8HoGnCSH8OpLwXxckJWklYGql7Duw9ql5nz7FBTCANqgk+CEb+rMIW9wvotPlEsE5Y3v2jMmNBVNGi6A=
Received: from CH0PR03CA0315.namprd03.prod.outlook.com (2603:10b6:610:118::15)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sat, 30 Nov
 2024 15:20:47 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::81) by CH0PR03CA0315.outlook.office365.com
 (2603:10b6:610:118::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 15:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:44 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
	"Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: [PATCH v7 01/12] Documentation: x86: Add AMD Hardware Feedback Interface documentation
Date: Sat, 30 Nov 2024 09:20:12 -0600
Message-ID: <20241130152023.684-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130152023.684-1-mario.limonciello@amd.com>
References: <20241130152023.684-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f059d32-84b4-4a53-0f2f-08dd11529123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2sqiyneMZNtTNVRtjnaDxOVb3GDlxmDq56sHW+veMjs9GyapHzPONPr+khJt?=
 =?us-ascii?Q?R2vGNvh8Ldwa3ionibeN1Y/0dg6weoY2BpxThUxbEvOtceaKsdu7Nr0HN29z?=
 =?us-ascii?Q?l8moYlP3XIjLwbxyNl2/SCO6i660+yzyRrMZ1KXoDfOin6nnqjJViXtypBp6?=
 =?us-ascii?Q?5sd9OrJu8QJ2C+kqNNB5TRgNoeNJK16h1+Xow2M6YRhVThkXCIlv5B9Wlaf4?=
 =?us-ascii?Q?Ir543On6nuOCRigMtAJiSf/t45J7yK6achpTP3CnyflCapTdomevNdOI0BsJ?=
 =?us-ascii?Q?4GXykqWmkm4Mn6WBWQt0LDNYwGb3aogYQZNRSCwYan6lGHaUB+usNyZ/yyyM?=
 =?us-ascii?Q?/lk+C/qxBqfsmCFkkoOtw+iwJ7SZDT6tEV/IL7ygl2ATJOe7HC4H+f0UxWgX?=
 =?us-ascii?Q?Z9cHsP36XyUUJyGQ/jD1voW6Uar3HtTgYjDv32AeEsuAce6z251AIKnf5vR+?=
 =?us-ascii?Q?qdI+uEQccNd7Z0uqNyAw+nep8K2c2VeQ6evWw9x7Jl9CuaUx/toRxVmVWmSa?=
 =?us-ascii?Q?TVfBfeTGnwQRfnk3lTxT+K+GL/uSAaTR7eohNaCmRlxSqfAJ694EC3NYwBn0?=
 =?us-ascii?Q?JfHw6WbJjFGSjh0ifhSgjU9dyHzkRU7JcIepm857mBorF3pvaoqq7hcsfJD0?=
 =?us-ascii?Q?JdjODb85nxPSCsJ3Vmzu5h6N3l13Hrul3HnXvPcXIhzWqK1on1WUQ3OVyoWN?=
 =?us-ascii?Q?6kcdjrtzPGCAP35gvbvdV1SYDe+PlFGDJkXnPBCIZ35Td66RDVVrgvY5u89o?=
 =?us-ascii?Q?rnlqwjRePV9Mon14l+Auq8isKrKHNgiWqIN5I7/en2PxypJvgyU1qh/ubflP?=
 =?us-ascii?Q?IN1+11u68nFh6D+uHv6NUzzWVFUysL7ZyOvS1Ybhp9XiZL8TUAIJbEJ8/mpV?=
 =?us-ascii?Q?Lq/bPP71/VVQbyQ8GYQtqyBmoGdXeS8xA+zvTdJbEFIaUlYT6rmxIQweBOU9?=
 =?us-ascii?Q?+iQ/DIPmPnsJ/9g8Nq0v+duvvg/eOZTVd5lWmT2GVwWjvTU2yYIoPNgGVwxp?=
 =?us-ascii?Q?EuPSdpeZfp8HtzMxxmYEBZWAIQ33jcGXC1QvkulBYjK4m89g8o9kOCDbquOF?=
 =?us-ascii?Q?nMu0sqcEpA0iJm8jXNyoXbyHlH7SIQW07mjtYhPF6LbWSTylc7nqg0YfGVvU?=
 =?us-ascii?Q?0p76+xGr+uskp/ntavIq1tr4lrDzpjHlwI5QrjPndpLMNCHzg4eIrEXnXlxr?=
 =?us-ascii?Q?ajKdH0ICRh4a7wAkY0mrhkjBLtsW1wiYAU2UTg+FtsX+f00lED5RUbJTiu/w?=
 =?us-ascii?Q?JqD+AfTVBM9P4oYAJGE/gjyXrQ0k3GgQw+I3kg2b8jPjHyohJe1hlqPW5MPz?=
 =?us-ascii?Q?Ku8SbDE02whHKgdRgl5S4WaKy6Bv03phRzh9kZ2Z/BFUQ6WVV6SpptrZXuGd?=
 =?us-ascii?Q?Wsjd/wdBFSS7F37xYpuCbVVuL8pBwf0hd6J1Z+3RSFylDMneudBsX20nhkzL?=
 =?us-ascii?Q?4T5MkPoxFOwBbej28vJqKV+W4MfvuQ5t?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:47.5525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f059d32-84b4-4a53-0f2f-08dd11529123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073

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
 Documentation/arch/x86/amd-hfi.rst | 127 +++++++++++++++++++++++++++++
 Documentation/arch/x86/index.rst   |   1 +
 2 files changed, 128 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst

diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
new file mode 100644
index 0000000000000..5d204688470e3
--- /dev/null
+++ b/Documentation/arch/x86/amd-hfi.rst
@@ -0,0 +1,127 @@
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


