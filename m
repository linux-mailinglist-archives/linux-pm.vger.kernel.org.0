Return-Path: <linux-pm+bounces-15483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E19992A8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01FCB2687A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496AD1D0BA3;
	Thu, 10 Oct 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GSRCGepd"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFC1CEAA2;
	Thu, 10 Oct 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589070; cv=fail; b=el4YTNyMupXLsI58VmUm16EDWDylB5p9wGSOFaxQRBGAk5LeyW2JQkAqUCep+s9X4/I/Xi6YS3eM++oWgPOJvuoR9gPQQNhR8z1jJ0pstRW4m/D305wPxk1y1Zr3fCsmQIPxJbPZN8VNa/egrWxXHtqpLOdyGMZseAzlqSe8gp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589070; c=relaxed/simple;
	bh=AWbDTDSau2BHuzNZLwPqHYvKqTOvE4BEstGe+JxMSLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOksw9UHc6hQed2Ggl5UwA+OkW5qW0c5+OY9qb6HxhVNnKH4nmLeYQALgO2pPXn0tH0ZcGR4upE/g8yw9pcMqzj2FZ9JBOM2kqHGpUrSiXU/gZMJK6/HK8apiOxuYLLiscJkNfiTWlBNeG55Z7Od1EBnnTOFKqI9FrCn31g/gt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GSRCGepd; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPNkKoR+GLLogJ2eSgzLnFlxKwP7X3+m5N3eEFmkEKlb9VwDQujick9Lt3gErte34H0ErLm4aBtRxdhW/HT0bphf7sw4S+rzMCF9jnMW6TdnL3bAbY46pwC3dUHDTyld2rkJ9m6coC+BvCGyPDocH1IUmRkLMQ8/6nVZsshCpXmsEaI0hrBtfC1CsHve9nOxgB6htotIR50I8oJZpM+1wuwzWcGdHKrevya0K/fB7pV9KudSDy02txuQVcSZE65utFytKHR0OoO9amqJ/UU7hUvltCGEQObnX0OsQKCoyy66+/wgeAvDfPOZMwSaU+6kyZfuxjn+nb0jo9ljvzg4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQxLHj1QyU45DTblZmLEvEylSsQzIeiEQhqpOSufMgo=;
 b=MJy3SbS2DvBchvb+sfQTj94v+v9QdHoqP1jhilHDJM2n4kgrJjUEr+OqO2tnDrMJ9PdvLSw6tI2/yOGEN5beOU3VbHDttOZG7aYu2zYl6WhwucBapIFUj+Nlg7ZGiVkumVDSYXt6qTNMym3XhcJ1Bp196emAPzdT1tKx4ICvQggK89FYYVzVvcgNGcG1/QsVylnPYocpJ1vJ2lKu6olAymGYRf60Cclta8pjalT/Q4fgaB4CleknL0yJXR95n3flSJlWhZXDIkQelmb3Hip7NPqbXQCY74dPlyxTtCbduyDY7XRXMjEmMlVCjeLmeL277iY2QOqOHRXBMUzOgqd1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQxLHj1QyU45DTblZmLEvEylSsQzIeiEQhqpOSufMgo=;
 b=GSRCGepdBc2M+3CRTxgvGM7tXkBFVcvsFo+rV0uETySYbtqiNompVHsCBAM09YjZwcZOUxZHLOA1c2U2oYGC79C0hZS2cwa5rCWtQgbfDvFiEb7DHer3NU399fl4zf5QWROG4BHI/Z6fJTtVjajfIp3PyGMA6ywhvvKavpWXU7g=
Received: from SA1P222CA0153.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::17)
 by MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 19:37:42 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::47) by SA1P222CA0153.outlook.office365.com
 (2603:10b6:806:3c3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:39 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 01/13] Documentation: x86: Add AMD Hardware Feedback Interface documentation
Date: Thu, 10 Oct 2024 14:36:53 -0500
Message-ID: <20241010193705.10362-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010193705.10362-1-mario.limonciello@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MW4PR12MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb3a611-7dd1-4b7b-3f06-08dce9630115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WpuNFDpOawt8jRBgGNAyw7LMiERFRn5OAEyDUUF3NtPbLN/YAqIsFCEYamez?=
 =?us-ascii?Q?SIbHzJhwEIAsf5vHv0VU7gBUrMhfKu9wuP7vRV9FFNWBhXgLFjMktAnQewVy?=
 =?us-ascii?Q?WV0js+yWbwboX9Hnxv1PDPO+7UL0TRJV69iLiUz2aGjDgcoTWM50kWlfgaUl?=
 =?us-ascii?Q?QXVfF3MkqTxifdAyS8RBjbtAXf83kGldmzZkKFiBTqQNfler9j2vpSCRi4Pq?=
 =?us-ascii?Q?7ykW/mBzTvAVguPdhTceqowmFRmDPFv5CMHtBPLgWQ/iU5ysYo1dGgevbtNy?=
 =?us-ascii?Q?9dE8zENtoC4qIH/1jRggECSqtNxoIMG1RIxtw8gsJsXF5pUdMG9nutpkHWEH?=
 =?us-ascii?Q?z5fSE/27upxGR2CPCq5l4SrmgBxRyjcx+x549ol9cZx8cOs9M5G/0rrtEekl?=
 =?us-ascii?Q?oDiazaVkMC5JqDPJyrJgdJGh8V8JjgK+pgmKFB8A4lMdJFfAYqnVKnnFAqqH?=
 =?us-ascii?Q?InqIylzMC4Nw8QYTRYKDvyXGn/KTr8pVeDmSGlWXbAiHSaVN6ndoBC82Oa7z?=
 =?us-ascii?Q?wBBIjdVFJsfsrsH1xZ1YyBCZIgjSOuozSRhgL/9aaSZ+IntIrIGqGCmdsCSs?=
 =?us-ascii?Q?DmNg+g4e7Y1ZB3+YVX3yeEOBZ5ea8BNLy9MeHDCSMMB9R7fNOFKGsRVCJGLJ?=
 =?us-ascii?Q?llBvG9adi3iute8QrPDmCNSgW/4rB24/h9icT60drxk7kySPacUI/Vn4WK38?=
 =?us-ascii?Q?Iol0mZygIWoMB30eioDXCOR2ZUoxS6pyvwicDdqKlxwkqL13ZMzgxFDZUEdk?=
 =?us-ascii?Q?aSBaEVRFgGCo2HxpEq1MabsazijRgixFA7BrmvQdnBG4ucDV9kxNybHoWODo?=
 =?us-ascii?Q?PRgPtUE8acILY1dtXV0JBGamN2CEYkiGOdKNh9fq4e0noKB8bwaVSC6Gj1NV?=
 =?us-ascii?Q?WIRXoEP7/kgFmQUx/ELL7zLYpXUaa6TMP/9GtqZQic9YyVKl4L7VKfEXxTiH?=
 =?us-ascii?Q?aqb8gttVvij6ZvAd+xV2olfao8LRxJZYf8ple4A/TRPneFRvE6tUIAhB1xXC?=
 =?us-ascii?Q?q/SGZ4dJsZYfjyDKblLfaIwe34ipjgI52rJgZ+Sn3M6+KaphOEkkvR+mYq04?=
 =?us-ascii?Q?hmWcQ5ykPprL6tcB8wXCyEH+JxWFfdLivCLnjWHzf/BiAT12Ksg4UDk2JJP6?=
 =?us-ascii?Q?a8V0oW5g7BYJyO//jWNKrBcShyF8aXQiEAOhsL1vdC3h9dsKzEdZVYpgmonR?=
 =?us-ascii?Q?ViO+uo5hcpgUf6AcUHE2pnotZSfqh6NudQk9HsxR86Lx48Z6poIPpLLo8J80?=
 =?us-ascii?Q?Xn2mEMJa8Elicb9EkAngCkT4FLnTqhpvFCdgDtOhu5/EX3oWnUSlRHVBWTl5?=
 =?us-ascii?Q?3pOc62YOgU0XuwXKcOL8PkH5W6gGFjEWFG5EKqZOGFUJh4Vl8hgxw35A1bf4?=
 =?us-ascii?Q?3KjFMy8MyfwN3Bn1Vyf5VTk3vt4x?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:40.8190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb3a611-7dd1-4b7b-3f06-08dce9630115
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432

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

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/arch/x86/amd-hfi.rst | 116 +++++++++++++++++++++++++++++
 Documentation/arch/x86/index.rst   |   1 +
 2 files changed, 117 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst

diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
new file mode 100644
index 000000000000..351641ce2821
--- /dev/null
+++ b/Documentation/arch/x86/amd-hfi.rst
@@ -0,0 +1,116 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================================
+Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
+======================================================================
+
+:Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
+
+:Author: Perry Yuan <perry.yuan@amd.com>
+
+Overview
+--------
+
+AMD Heterogeneous Core implementations are comprised of more than one
+architectural class and CPUs are comprised of cores of various efficiency
+and power capabilities. Power management strategies must be designed to accommodate
+the complexities introduced by incorporating different core types.
+Heterogeneous systems can also extend to more than two architectural classes as well.
+The purpose of the scheduling feedback mechanism is to provide information to
+the operating system scheduler in real time such that the scheduler can direct
+threads to the optimal core.
+
+``Classic cores`` are generally more performant and ``Dense cores`` are generally more
+efficient.
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
+The mechanism used to trigger a table update like below events:
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
+Ranking Table update
+---------------------------
+The power management firmware issues an platform interrupt after updating the ranking
+table and is ready for the operating system to consume it. CPUs receive such interrupt
+and read new ranking table from shared memory which PCCT table has provided, then
+``amd_hfi`` driver parse the new table to provide new consume data for scheduling decisions.
+
+
diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
index 8ac64d7de4dc..7f47229f3104 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -43,3 +43,4 @@ x86-specific Documentation
    features
    elf_auxvec
    xstate
+   amd_hfi
-- 
2.43.0


