Return-Path: <linux-pm+bounces-16124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E814A9A71B6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE6F1F20F4F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043741F9420;
	Mon, 21 Oct 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cWcEHMZq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603D1F7089;
	Mon, 21 Oct 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533803; cv=fail; b=FkWLMpocAbWz04LOpdtzhbNqLKopLOkKJs8PO59KVKu8Dcgc6g8HlqzmZVjB62QHJC232+LfU4Ps45OJ6GgOWaEIzR2+cnKai/bNZ0lD1cNAp8U5X5GATxgix7wku15ySzsDFv8XfZ6lKlIl7WSGLLjWuAIlMLXVahTLQTec/Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533803; c=relaxed/simple;
	bh=BZ37AiFR0qJAtGoTPHADBBdXnT5Ual54NaWDz4rtz/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfakaH03+cva+S3z49cAy2rcPl+xKbsKWIbN4MLnLJCePLJKAMKM4fzOnf0dDw9eUuIrnn9gNa3448cQUPQP8x1F/flXEzjKDG9v3jeAn9DVfTOUA5C4vGTncgwKtxXw0F8DTArnnIyKxeIIa14sWNWjDtgqm1+rkiNN6awZnWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cWcEHMZq; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjtSdhXH7TtawCvZxJllDKKN1AARolE4KyOsnu1hBbACGOhV6laOyk1KXfqevwEdT/Pt8XxIPt9PlQ9oRjfXh+DzENdAeFzQw9eLccNpmXzepcYmKxKvwlYSbjtZh6KrCLSBJoZw4G8CaIj9WWvsPsHb4cYdTCmfTuBvvJwm6Zx3HhdrheKAsuqeEIyeL6PHrb6veNclAu12nzSdM4vhoXYhswzUe/yZurx10yxTGa7D9Q39PqUIxtA05BN9NsUeHIND8zMYvmSOk7SNZrPDoA3HMOP72dtY8uAC8sg1jJ9zE+iQPGRIdV00fLcRaEe2aAQcYFvyFHk5P3/TRFhqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VzHjc5UbCiWk7vkBe7HoGKIMIMtsjnqRZ1TUsD9/jI=;
 b=lOCCpt3FbA0IkLuyS2PrA++GpLx3rx4p9hcQCZeuzeo38NPx4wQQ+EBdar0B6G6LIm1Rj3YuBpO6/tWoBax3IbOf1RYMmHwVciU7EXO4SI00XbJjttaJvNtZJXxEPVHmTRM74FKrByMjejZy1qn0MJ62iPZpesfDZhhDcRwuivhNoG9JFoymVQx/wu7d5G+UmlkGa6tRXwwiW2p4SdQC6/M+7jdw5cjXk8SmxXdQrSYb9wCkCRpdS8aEtSjNMJjT23F3cHaHbilr4Cv0AQvCdya+7a8FzY6Kf53qAoTVJZ9TufNfrfwD8jUrzyghekNeTHQipK6cD18cXxVIKk69xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VzHjc5UbCiWk7vkBe7HoGKIMIMtsjnqRZ1TUsD9/jI=;
 b=cWcEHMZqXv6dCUdnU84Wb3DKcZfhG1zYIpOIBSDT8CRm/cIZlh2j105ELiJ31VIuvyEz2abGn/MQavL2h5WsTvq9ilbSpY1FXeYj3aZH5+bQF29uYRmcNqBxzYdF4FWTUUpllOU4Xcrq9ePpPAStcdeXRko3oN+yA1PIEYF5Ggw=
Received: from BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Mon, 21 Oct
 2024 18:03:17 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::f) by BY3PR05CA0033.outlook.office365.com
 (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:17 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 01/13] Documentation: x86: Add AMD Hardware Feedback Interface documentation
Date: Mon, 21 Oct 2024 13:02:40 -0500
Message-ID: <20241021180252.3531-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021180252.3531-1-mario.limonciello@amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f616d1-eb09-4a9a-ff93-08dcf1faa421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HMmebuIaKZSpyT1/MDU7QWnbrvB5TC1BpN4YV2+mJwA29eYOmIVBRmci3Mg+?=
 =?us-ascii?Q?omCzGJwmirOfY0ana/ZEhheQODmC13Csuqv4FKPe62vBpWIxltPH6By7sVm+?=
 =?us-ascii?Q?Q+79RIEUv0p/WISFYR+1cnFRB/7p8iAiASxiQqJphA0qn1z0xayjtSidi2Bq?=
 =?us-ascii?Q?a4hjQhwEIPkiuJtaNqJft/jD55vXbblzvtyEy01/nHJcAhf5Dqbf7oUKTXAZ?=
 =?us-ascii?Q?uJCETzviozPw16mP89yQ2DXmrREaCIzvQLUiG8huynnQj/ZySlpM6lgLGiFc?=
 =?us-ascii?Q?NQFzHr+PZJhTDn4IYci8jJiChug0gklys/plQcmffK1ERk685X28VauWw1zV?=
 =?us-ascii?Q?6wCv9q9gd6A20rbMBll6qruZhY/88zcfPMod8s31z6EoBN8OnT8+R2rFr5s3?=
 =?us-ascii?Q?K92i6nPZWVQY1el4op/0LOdwkFLLr4VGTDPolZo1reb5ay31JimsQsD5bzZx?=
 =?us-ascii?Q?/AnnHVUKXlgVg0b2d6dN6h6xVRmTwRA+aHIjyQn3MMxZ0IV4GtPiBPT+t0Fo?=
 =?us-ascii?Q?cY+jHlZz5tnsOFuKYeIIsUyQrIjPYsYkXhiLVNihuqZLY7+8gDdo5sUmEFEi?=
 =?us-ascii?Q?duiJCJ2zzBnXrrW6DYUMaFKFYeh7Y57DsAF/LfrLL8IbVZQ3HrzAJSUVeltX?=
 =?us-ascii?Q?m1rpEbyJQomlWnTmuIoElCvHjuwV0FejEM4HQGDBUWOE7ffVlwpUl+DjLIbK?=
 =?us-ascii?Q?JwTBvuryYGZel7d8MRjfS9V95KgJq8RBchCtSDv/0tpvTUwK/akDJYebRdW1?=
 =?us-ascii?Q?Iqe1ZWkGfAEg3eVbunJcYo/ahWErTt4O/IBqRBmE0hBBlICsxDMZ4zCVmRYv?=
 =?us-ascii?Q?azGabEms5zUQbmQQuOtZe2aIWlGh9Mrsj6GNfpI9Ad1Jf58crL8RopGcB69F?=
 =?us-ascii?Q?KISwrhQo5Lm54i2Z4cNKyjdJM0RLYeS+n9oAqK9Ktic3VcNCYQDCHLJybMU/?=
 =?us-ascii?Q?nvHY0DhcEWDBqT4VZMP2et1zesi+NBiXOjf+2HNCbSnRfx5UrG0b95H3LP7p?=
 =?us-ascii?Q?a/DZLj7H/ONwMlkHMYTI+zuv9pSzQ2og0Vey83fIiHMvhibZshcDkD9b4+L7?=
 =?us-ascii?Q?pHLSX8iSxOnp8oLZMOC9I3XJh4QopGAMXs9/24MDARQPZ9BlVFuRH7peaMgt?=
 =?us-ascii?Q?wzWNo6R1jJXXaWltFrdlAhuzpdydYQZYFLbXoR480WdnmO0DEVFwRK/JJKFK?=
 =?us-ascii?Q?S/ABoSoH/RLgfY1wa5uk5ewmUBlH1YlFizXtla7QbmPICbDyypz/2F3gVkDi?=
 =?us-ascii?Q?yFHEv6Nn1Hw/Gw9hlQTu6nKkmSgRFqRDwukHI/oAed5VuLBQA6gQYMm4v9QV?=
 =?us-ascii?Q?VSyDK5LQpR7DFQFIXWcfBdeCtJVJ57lhOonDibKCa1YVUVRa9UEl6v2jCxMJ?=
 =?us-ascii?Q?QVqrPuM+yn8JYjcC03dxnHlaXVGtVFxJSYGfLMOCFRM35AAWDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:17.6171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f616d1-eb09-4a9a-ff93-08dcf1faa421
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262

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
v3->v4:
 * Add another sentence to classifications (Ricardo)
v2->v3:
 * Rewording (Bagas)
 * Fix toctree entry name (Bagas)
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


