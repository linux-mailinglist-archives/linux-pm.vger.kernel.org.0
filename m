Return-Path: <linux-pm+bounces-16984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A799BBC82
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EC7281239
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B971CBA1E;
	Mon,  4 Nov 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mISZ0L+c"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10291CACD0;
	Mon,  4 Nov 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742887; cv=fail; b=tCFAqhU7sNGmJw/RdjUy5jBGEW8VdYbjYhlPedIU/2/zePQCQkqTbJivU/IRlg7QBdy8vDVFgbFn9VLfmW4bLmuE09HUlAMft8eqs1pqtgRDa2z80MOt2kShDXXCnD8kLl/sVe0bEV9qI6yWKrY3JQASNwBlUtcmDw1rUzeK3GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742887; c=relaxed/simple;
	bh=tETJvBrZxG8mdYwOIlQb1JDboHB6ber235TluyJ116k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYGcOyxmc9T3OpgDsNEfn2o/kAwiqkKqIP6K4Robl40mrGL0ZRSYLZkkeotTUTS5dZk+4lGSY+aywQ/CHoWH34IijPOao0M5M/cbV0Oh9j7qssegczbNAIUa8fNxUzg2FX7CEvD7YH3CYKIsQM/EMGh8xvGCtQD0ehLZWd5lDBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mISZ0L+c; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lbn/3Nm03FH/CGNuJtigtvWPugqqSowvWQINmkHL17amC5CJgX+Vtw5IqsNxlyYuknBxZdyl+3tExlJxcGidD6w5oKbslzkf8VNw5mBqx5mKhL+ivO1lPOq+JQ9yO2fgVRcWWq/jZEUCUgedGiGd2t/tlGs8wwdVOGyZHiKQpQJlGSGKLyEgg/b3pvd97yCYkYKOmYXDMlBTnbCshJs2l2tCxFby5NNNq4WtrpZ1PM6eSl12pKvTL6T5n5VIDK8NyUbU9yarmZsD+Y4iS0jqB/7Ttiz1xNOHxIckpUs5BVN5FMmHg0JjhKj7q60DZ9lt3PWi+aTd8JUHpWCHIaLOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFjTqk4aJtehHpi3YxR8SgFYdkShFqv2troH10OZ2m0=;
 b=aQGodcaZtrV3Is8ACAwlNbmXIB10c2Vfh3G1WJlUfUW6ztJoMVv/aggsRka3cDVC6MW/zYWB0w/9KJxAt/zaDfQzQbuzgHxfNj7+TN7fKZn/SnakJB/PUxRaK0T3+ZowrTAAIlwl9QBBQN/JUfQB4SgKDxrqoWZvScqJMqsKatLZ/W1VC9ivUvdvxhWo+yaJM5qONhy7Q5JOrIWMVMT7d9Q/BXfBo9r2H3eMJbSdNE2HqMSaUWY4akcZGFPg86cPhxFdVNDBoZZks5dtfFR1XR5suwfERl2/1hm77yw58w1GckiaYPOlWprSEdc3lJXTb++uj+hZdBpFEytNC+Sy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFjTqk4aJtehHpi3YxR8SgFYdkShFqv2troH10OZ2m0=;
 b=mISZ0L+cYTIT5XFaOoaSCki3hGLylZi5F/zkVaDvioCxyZrmMwsHJJu2tpA8b4E/S8KRUhqEtThCa1Q+TUKeWiHw8YtFRTogYCLgbS6E6t9fMhVwYJ099/LKjjltW/PrZuXfBHqbITLDtr0x4tfRVROOKijMzcCra2s/nSwdLj0=
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 17:54:40 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::6d) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
	"Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: [PATCH v6 01/12] Documentation: x86: Add AMD Hardware Feedback Interface documentation
Date: Mon, 4 Nov 2024 11:53:56 -0600
Message-ID: <20241104175407.19546-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175407.19546-1-mario.limonciello@amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e83046c-28d5-44bb-f52b-08dcfcf9c1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2D/kVzNb0tIcZ6UX7FZ+6fdE9ePrU248kvt8tKqwdxvHzuYXFKKz+/qf0FDc?=
 =?us-ascii?Q?1vWPrsY4Dop8Zo66ojHwyhr4q4SaCPyAlPXjGdBt2tJAdHOeD50KdWBdIcOS?=
 =?us-ascii?Q?nlZRSXnjTuL+6Uz5V64ZMFrVDI4GS9fq2+nr9wUKvqIkbFbFbDikkpSeOv1w?=
 =?us-ascii?Q?1ZlXDjO7jyIl8N8YUm5Sv9zQjE5VGt49lms6MQmz+42Dsgjia25scsP/+0EV?=
 =?us-ascii?Q?IgiyliqaT84nQRXoJGKWKBMNaCGes088RSij2Z0GcCgfEUSa1vegY5voXLDy?=
 =?us-ascii?Q?F3jvPjNFD78ZT978Zwtseb8HrVjVNoP8W1qO2zfEZvnqpZ/NAnjbeJtP/yYK?=
 =?us-ascii?Q?nHqrBQzJYKVwp/v+IlozHq0LkdGbcmiRERMUvIYF0+dVBiCeng3VeQUIMQpw?=
 =?us-ascii?Q?fc7Z5vckqkt9YnYqTqPvZR+yzCagcqz1jeTWK5xjW5guYXyHb+cAiJ/qWqD+?=
 =?us-ascii?Q?9z5jArFc0Zkilw9yL0yKCZHPGfxJDuHZt1v0rwzRXTkiHgrr4RIaGTftD2Pe?=
 =?us-ascii?Q?5hC3sycEhToDZH83b8cK4TRLW30TgSnbY0qdW6FmCJ6ddliF/JDceWEOX88K?=
 =?us-ascii?Q?7jF35Vx4aG7Hv6bP33sxNusN5vkvRgVkaiWZlYvc7XmK8TjzFIQHgieypTRt?=
 =?us-ascii?Q?w6YDbyFTQiOu7tA2ixI1SkxSnizOGAYl/IXJvSldcoE7yBR/e9hnXrolRY1T?=
 =?us-ascii?Q?Sg51lxbDCgAF4cjPfZazfhGoHb/Avg/mzqrCedkvy+r2DcH+i3ADlfPwVXp6?=
 =?us-ascii?Q?nUHQAAuINJu+v4F+bxdwnKpfugpulifxjrs1nuFlObm50Xem16spIJEYuO//?=
 =?us-ascii?Q?3F7Zw44Urx2LwKoDuVAwzNt+5Flh9a4f/SIVN1R4Q28OgGTxLgC0q3vwF0KX?=
 =?us-ascii?Q?1a6CauPdjSKQMMj9LxtehTTXATNGdKBf5BPIRnsyANeSIHn0zHvrIPR5N4nc?=
 =?us-ascii?Q?GtIGn0MkS15ui0HcGoJS3Rha7uh9rAAgA1DgnKkAotvtrLf/MZqXG4vcqUWN?=
 =?us-ascii?Q?qU5LGRukkm+tjmTmtdex1sMjLiDkD4BrGsYdZjvkAiewyoba6a2TQZ/0zlFR?=
 =?us-ascii?Q?iKAduhDZy8uO6U17YD+m42I8IBwaZU5N1dOHEU84RqxfA/Gt8F+ZC9Vh5OO3?=
 =?us-ascii?Q?0oLaLjlllH9Mb1kDdKmSyDRyHlpNq4TIYvAt6yiajKl1y1IXBzLz+j+I8dJH?=
 =?us-ascii?Q?U4fQ1gG4BU1QkGvNjPM9i6PDoZgzo/4tDiXvDtFhxyVWWPW53W86Lcz98UKL?=
 =?us-ascii?Q?ZZwZVa4nMXN9iXljMzffMu6lj/N4EKw5dSKlXhqYS/pxPjppqQs5QdMJfX6V?=
 =?us-ascii?Q?fveKgG4h7Kg7JOaQcZnbmj8fTU8D743jpHwK8hmk1drOjXsvr8JgBKNryDZF?=
 =?us-ascii?Q?V8ZPtYldc7zrdEtUtx4HtcI5Qq7YSW4llLALiQMhJyg80SXAxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:40.4599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e83046c-28d5-44bb-f52b-08dcfcf9c1ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635

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
v6:
 * Fix EOF newline
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

base-commit: 110213b8f0e7021819d4db273facb27701bc3381
-- 
2.43.0


