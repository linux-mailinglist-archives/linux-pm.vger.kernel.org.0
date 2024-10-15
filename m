Return-Path: <linux-pm+bounces-15698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE71699FA33
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889F8284090
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB3B1FAEED;
	Tue, 15 Oct 2024 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tru1rjIK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C101146A9B;
	Tue, 15 Oct 2024 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028250; cv=fail; b=PeOnKEAgPzcIAht9tUXyIjrKpImCDiSlkVST/01cqcJGdr7Kvb3V1VLwLMkmZux3PaEiVTL9uujQbDebpQEQVBPekZt0ftDJErbT9W0RvhKfAfV7ft17bF+Ui/7v6io2im0W8Umr/vfKQGR+uxVYSJ4b7CpTxd4ME7hve7kL2L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028250; c=relaxed/simple;
	bh=JVaAMc3NKAH+ogx6hOMvRNIyg0m7Iq6iQcvdWQfixm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKchDi+VLKTYvfZo4Qzhe1USR9IGW2yUNpjIeQC+kUq+t55UEGnwPBWaEPgy70v2YpD9QIhdmzib36iRI+8mNInbQCG5R/KN+s1ui0kPlbnf4Jgsa7bhCuc1yelZrND8M/SRxIJUwvuJ+I0jiqV+ZX1T68WIsDi+OzgZxVRxU6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tru1rjIK; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhtxqDk3O7k6iZCPu1hDy18ctgtka4xOc+PbFFYybjXla0lSUnLgcITAV47hTURsnr6hEQPgO/xU4tdWqBcQ4EmsnOgA+mB1N02J1QGzOMGiVFBEikbHi19l4M2buqxJJzbrwX4HkuiA++Vbjg+v1LGWJH9S4X4m/M3o+mNxsZO97vXlfnx6BooqDoJPr2Ek1JxQ3l9/lXRbaS6j3IbTaNs6SmD6dz6N03A2unzZ980XxwEBhVCFP8QTrGXxxyfLZ5XqgNT5R1tE53UjSDgXHsgk1SFMvAyTKCWYigsUBSvoHnlAmgU6XEvBOOIlYkrhYCKOKTCSqijOgssz4OOmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIIgTo5XY8T0QIZHwi7L+nzf1d5dFoNq+W9rpiL9sOM=;
 b=OmigUb8Y1Eq5zYMkq7L1fYc2nYY96Ogb//SpekD+o/N8T90U6lMmnX5Jtwxhbd0txDjTfIySIrB3JpLJ5X3cyo2oadqPe8NLQ1pNy1jnSWLQX80bmPzMsvvT3Lcs+N1W8o9Vdw7UZnEZjCQ1nmgJQpIGZS3MIMz/KMhgxmhMgY6WGttGLB80wc3zUl22Gauqz3iQGKKNVr61MqHEqmJIyEEgyfmczij4b3a0KS0XcOXuZG3MeamofddW5EaMnNcfhIdK4S0ZCzwKVyxC53L3mqGKybBWrQ4aWmdZKQmPJAn7ayLAmjG33qtFZEL1kcehPcAe6E7/2gkThfcMe99XvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIIgTo5XY8T0QIZHwi7L+nzf1d5dFoNq+W9rpiL9sOM=;
 b=Tru1rjIKYO5C7IPAbGhOjp+GaF4eFLSUmpk0gm+IvUc2ENVFQ9GnLtn+HpWF1+/e/KMt70oFwG6NXxd4SM8bNflPO2aDZJbDHYByjX9wqMh00qA+dNG9QoUyHlkMHdoeS2OJBJ2xcv607iES9Ea8AUsJBMfLIc722nszqhxv83Y=
Received: from BL0PR01CA0023.prod.exchangelabs.com (2603:10b6:208:71::36) by
 SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Tue, 15 Oct 2024 21:37:23 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::93) by BL0PR01CA0023.outlook.office365.com
 (2603:10b6:208:71::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:21 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 01/14] Documentation: x86: Add AMD Hardware Feedback Interface documentation
Date: Tue, 15 Oct 2024 16:36:32 -0500
Message-ID: <20241015213645.1476-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: e44dc336-98ee-400e-c27e-08dced618df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4wbuStg0/upskgQTR146uDdCjtJr2Kvhu8zUTbcDevyldwDabHSsRmBz2UFY?=
 =?us-ascii?Q?C0mc5nxkSjDpFWol8iB5qBb5ksG1iojtCQGv4QvssOr2rLglrJYTVKGfPX3Z?=
 =?us-ascii?Q?3tPtwHidWR5QIa/d8zruot3GxPLReiRpDBcdt0uEnYBHAGXOPHkKrz4fKjYX?=
 =?us-ascii?Q?rPnzLG+DnSV+/R4WXpyi94+YQjVRMBRLTrV5/sUjsHMen+d6mReMQOrcl38n?=
 =?us-ascii?Q?HcN+q+99DZFE6KFcLo55+FTcQ+PPlaHpEjrVAp60/6+qzhQcPMNSrlBlAfLi?=
 =?us-ascii?Q?KCF3pNWOkh243pO3baWRBYlKr0a1+pAJYP3zGjJ4rBrFJB2Rt3fHXK5UFEpo?=
 =?us-ascii?Q?DxWGPbTwuALSRKsqF+yIBAeaRMXLQP7rx96z/MnfVE+FV5cTIrltVRSic5Gp?=
 =?us-ascii?Q?AEeLsxSh70g3pbhIXL/5d9YJfaEomEzEF4zp7ioL33j7x/UV0CQK/BhfQl61?=
 =?us-ascii?Q?1xNfOWxjGC6wjjgNgMGctzZtF/4GDlZxLlcUwi/ILhdwOp8M1RTLcomZvBZ4?=
 =?us-ascii?Q?dWX+FEcqWB8ojQ3cP0qoPvDfS/tleXvJ/iI1wqYppXsKehpg0SkqsOOOBJeo?=
 =?us-ascii?Q?o/t705cQI75mH5/qreB1eFqxU1RCXoFU/6gsl7mA69o0Qi1yWMieRY54/KHy?=
 =?us-ascii?Q?YpEgGS0m6pCFLKv5jiNTdBFgZ0ViyOly7pOs9kcvCVZboncugTY/stMH1ZGO?=
 =?us-ascii?Q?2KuLzwyHMrwKQjvVX3YSpYpm/hADjqcPDIrrr+Rvb1fvSRLB0dtFUQnKWaIK?=
 =?us-ascii?Q?gviM2YASjTksHzmIgPAWrOG0JXSzcJc/vtLzrBxoXWR1TeYvk9xQQ4yWYV2B?=
 =?us-ascii?Q?k+/lLoHQWg08GG0WpB/VDjzzCZdIMIcY1aFDRsVyj0n8SKMhBQkVBB+vx9yB?=
 =?us-ascii?Q?Od1cPF5EM3m3GeNXAXS8RAtVJxGyUMgVrzJbtWvC4wDwxOLgPmMLo4YeS5HR?=
 =?us-ascii?Q?LThjfYFW/jhCVBTTf5fD9jyTsV/M3x3uOAe2h2mGvQmDGKOVzLdBumL8d8/k?=
 =?us-ascii?Q?w6ModG9P9VK7FKtDgBOiv5y8tkIhVj+Hq5af8aITn/zUvDS+oXSscGm+OvBv?=
 =?us-ascii?Q?BCOEQNgBmLMu4vXFkXHlpnAtrpLJezyqVvdu+57VKvtV078JXPsqSoe6uThl?=
 =?us-ascii?Q?ZJpldp2klQ3QRY/QA1uwp1cfeDs6OI6gxESIpZ/goh26JioVSJU2gjWdvgrZ?=
 =?us-ascii?Q?XKb/5ulqWun2gut0bYBfDc6jpYHu3zq5AhGPIpb+DKeqlJxmXlDWD6gDwXxH?=
 =?us-ascii?Q?FyJkDPt/cCZPAd3KfyI5yLJdZWFAVNGp+xsU31zkG7Wqyz+n+u3HJa4zkjbU?=
 =?us-ascii?Q?8tt9NsJEazrCxXRdarfHm3HjaVJg4AXXB4vxdD81aaZM0GdUpBu56V/DjZP/?=
 =?us-ascii?Q?uGP9QQiJ+OJQaO1n3tfjGbls6pOk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:22.8487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44dc336-98ee-400e-c27e-08dced618df8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048

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
v2->v3:
 * Rewording (Bagas)
 * Fix toctree entry name (Bagas)
---
 Documentation/arch/x86/amd-hfi.rst | 115 +++++++++++++++++++++++++++++
 Documentation/arch/x86/index.rst   |   1 +
 2 files changed, 116 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst

diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
new file mode 100644
index 000000000000..2f0d493135c1
--- /dev/null
+++ b/Documentation/arch/x86/amd-hfi.rst
@@ -0,0 +1,115 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================================
+Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
+======================================================================
+
+:Copyright: 2024 Advanced Micro Devices, Inc. All Rights Reserved.
+
+:Author: Perry Yuan <perry.yuan@amd.com>
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
+Ranking Table update
+---------------------------
+The power management firmware issues an platform interrupt after updating the ranking
+table and is ready for the operating system to consume it. CPUs receive such interrupt
+and read new ranking table from shared memory which PCCT table has provided, then
+``amd_hfi`` driver parse the new table to provide new consume data for scheduling decisions.
+
+
diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
index 8ac64d7de4dc..56f2923f5259 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -43,3 +43,4 @@ x86-specific Documentation
    features
    elf_auxvec
    xstate
+   amd-hfi
-- 
2.43.0


