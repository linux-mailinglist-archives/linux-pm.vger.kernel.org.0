Return-Path: <linux-pm+bounces-16123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D69A71B3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E508A282504
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58AF1F8909;
	Mon, 21 Oct 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TQekpJfe"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B51F4FD6;
	Mon, 21 Oct 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533802; cv=fail; b=tmEmWrccpQqEawZvUCOyFl/CVtDg//iVZwMfNrBAdewMhQPXTPOj1zaftywUY8LXdr4UAO8qM3gPXmdRvmnWU9IyL+qYPlpDZ87EgW5Fy5BWyqlvPZTrW/BB3/9wq/Xa0H8KpLx1nIRsmohnOwOZI3qQvPJYuvnS9v+BpTc0llU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533802; c=relaxed/simple;
	bh=TcE72H51112rsuxqwZJ9/qLreaUCWfdJ8f4q64Zdt9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULba+EaCq5ei2qmj3iVIx4qoFHqE6nGjuR8G2uPaHkiRAs9eZAKXv30ZAAtwei70oB/4F8Wst5XB1wnFJ35xWVRKKVuqP8vl23Dc/9wjEK5wh4m9vK+hMSckawF9FHh8iqLyrOTEMGIFuy07oXg6hgE0LuG4WkIA0GKto+QSiTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TQekpJfe; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmkieoyzReARBViI8yzOnOyqLTG8jCyR7e2Nr918LhuRrrtkH9KsjzfI7t6+4TUHBy0y59zVGrTU4y+5gdLLQBrCvr19MLxWRXugUO27dLquQfICqZZljLgFGt1WiN+fy8+CHM5subdX1hd9vRVFIa38mojadBoAVME4UOLrnjzZLtyXuQq0uecTKzvMBmNNbgyhN7FWGe0dr9Yrwrc4URMO7pyKnZ+V5GXvd+RMy+4d9kpUWf2CU3YPdUfrbVSYr0t9TXa+kDDmOnIIKEqru7Aeo7V8v7vsrICSe+gNwg4rdSFygFEIsRj4bh/1igVvsjhog4ZkDS6+b38FmzKa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RMYSAISIW/DTD5mor+vXYVazeSBxRBCYdrPCwe2Ltk=;
 b=qg0GRk7iNbVspSoIQn2Elde+RnZU+YI3wL17i/PmQK8VQKDoyGJj1EXQopuxPRh8/EFNcrnUyvLiMySytZ0Dl3URGK3SbfBTETkmddrkJ+Y/9KuW3c+r8Y866iSoHJFSmAa8TBdODssb4TZktTSR4ae7jELio1r4rXXKbMOZOQ2vteymHVzjfGZB+Bo+77qkAwfyK/PEPr7BMhv2IvRULkAACICSNfz88OAitL6QBXlrrO9pfF/I2pwqi74GrqtqHE+y6fXvPFElS1FFLQDEca2NiKO1KIJsxrIAdn3YESbGRRbRv+T+tnEqqSBGdXDAEnil4F8i85Wv56p0ZPnY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RMYSAISIW/DTD5mor+vXYVazeSBxRBCYdrPCwe2Ltk=;
 b=TQekpJfevgTZa6PiSpcBdjvXWuoNjE563trLPu/oEFT4nc8JoQA3Kt+5VnfaPsiZlPelZeP5SY0yxEvSEi89ZlibxOh4hK7xPoRe7HwQ4EBaNWYs91meuAb0JqvxV2/Qf0xtwI/uiKPtf4/VvYJ1Vuu3cWHOQM/a/lrCfRim0Sw=
Received: from BY3PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:39b::15)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 18:03:17 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::65) by BY3PR05CA0040.outlook.office365.com
 (2603:10b6:a03:39b::15) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:16 +0000
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
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 00/13] Add support for AMD hardware feedback interface
Date: Mon, 21 Oct 2024 13:02:39 -0500
Message-ID: <20241021180252.3531-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be306c8-fc8b-45c0-f3b7-08dcf1faa373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pv3XW3rSL/2tO1SmiP/43S1oeRTCGJoLMWh0orl+u4fFUJuphbf8F0IBF3AM?=
 =?us-ascii?Q?A/n2Uts6KEhu8NFyCMoqQc4OTHxxCeLP17MKYx2WsUqxuJ58Ypdm+kfNqr1S?=
 =?us-ascii?Q?dpGBgVyk+EC3ZngTN5N00IIU9T65jAJ+R79+14YCkVIH27QHYptiGxi801sA?=
 =?us-ascii?Q?YlayAxmv4nZfNVLN3/Wmd7zzPo860nrz33qcYxvzwOvDnu7KHWoHRkP3Pq7S?=
 =?us-ascii?Q?oN+9RPzsnBE1iwqhWZ8wq+nT8uXA00iRagmA4z7qxLdDanFAcZpkPbozfDSA?=
 =?us-ascii?Q?az5paFGNXCk5PXM2xY9U4QALAb408gNyaADMwOTCvhuq4c6KG5zm96uKRPkP?=
 =?us-ascii?Q?DxJKXUgiJvyLK0Nu9cFOV3qm2i3FDuzmybjIR+eFs+7JOx3U1sS7LWE22brV?=
 =?us-ascii?Q?V8Lall+o0jU9I1o0WnrfYXXt0l/pBUKVCuzX7sBxUr627LMkleZKrLHjto3L?=
 =?us-ascii?Q?X+hs/9tlIccJNfTNz23B82ABP1P+9H6sRYbBd95zkdI2BAvsjKAcwi+r/qpW?=
 =?us-ascii?Q?aRlj+nSiyg95yx09u3I+Y3qyaER4YgABJu+LCbBORbyF3eHOhLm0Y6bOSUIb?=
 =?us-ascii?Q?0p6DeDfUzorOJjPXLGL++wkqn6tb5tn6oCkxEm1YpbhTWwIP1CGIwnlwyspM?=
 =?us-ascii?Q?hLZT+0gW05hG00VyjKzf+04g+GYSzoKIIp54B27cju89eVUEh81ZxLJr0/HC?=
 =?us-ascii?Q?BDrZTHgrSOP7do2C2FMbqFtxUrLDZhz/X0DLeKfJWV85+0INIbgHi2sg8RhS?=
 =?us-ascii?Q?sedBXZsA51+i8lJbLYY3KQDqGeQ6cON2IEzzxmdeDo0mMTyuGSGAJo1G3ttX?=
 =?us-ascii?Q?3jI58oj9n8A+IU2DbEPvZFyEmBb3mjjMPDqYuwwFfi+Sia7Be7Q6Uy44meSG?=
 =?us-ascii?Q?mReev/4mmYRKob5Hwl43Wi5woKzGy/xj9uYIBoro6glcIr1CXcabx3RFG5yD?=
 =?us-ascii?Q?0UFZKwRVfde+U6NCtOQUg/kTjF2e0cqMqS7V5LqIL0qHejA7hTyovgG9zMxU?=
 =?us-ascii?Q?DzYfA1LMDWae8/baRxFPxwwPJ2tSxzY0SNCjqEwIkkx1WK6ObdZBW1y/koFJ?=
 =?us-ascii?Q?Oj1v/kGIAaAsfXSEyN4rUiZuLd7d2Iz8ncOdLWEjks9BgbTsSnkTTIOMUlT/?=
 =?us-ascii?Q?rUoW3FvpsbVlVBqpLt2XAtrJZTeDHNNd4bVEk054LDJRw3rAk9kTnztOmJHT?=
 =?us-ascii?Q?eEUxVtNr76hGyPTpB5BxB6Zfko62Ayk+kHMxPIKykw3/C42BlNlxzQ4h36OP?=
 =?us-ascii?Q?TpFvnUrV/W+d4GJD7V/RGmXz8EP+n5+t9PGo7UfvbJdd13oDzKRE/xM65nNf?=
 =?us-ascii?Q?FakF0M9OVMsA9f9vU7vREkF6LPmEyylaIMfAt9R1JWZhP+fDNuA+1WJOXG9Y?=
 =?us-ascii?Q?d52+LT/kLbfEp7sqbzX4i+GXCTnH60lMMKtZUFFdAT4uPSNwyUQpxlGFFzqz?=
 =?us-ascii?Q?sJCu14x8uS4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:16.4764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be306c8-fc8b-45c0-f3b7-08dcf1faa373
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
provide behavioral classification and a dynamically updated ranking table
for the scheduler to use when choosing cores for tasks.

Threads are classified during runtime into enumerated classes.
Currently, the driver supports 3 classes (0 through 2). These classes
represent thread performance/power characteristics that may benefit from
special scheduling behaviors. The real-time thread classification is
consumed by the operating system and is used to inform the scheduler of
where the thread should be placed for optimal performance or energy efficiency.

The thread classification helps to select CPU from a ranking table that describes
an efficiency and performance ranking for each classification from two dimensions.

The ranking data provided by the ranking table are numbers ranging from 0 to 255,
where a higher performance value indicates higher performance capability and a higher
efficiency value indicates greater efficiency. All the CPU cores are ranked into
different class IDs. Within each class ranking, the cores may have different ranking
values. Therefore, picking from each classification ID will later allow the scheduler
to select the best core while threads are classified into the specified workload class.

This series was originally submitted by Perry Yuan [1] but he is now doing a different
role and he asked me to take over.

Link: https://lore.kernel.org/all/cover.1724748733.git.perry.yuan@amd.com/

On applicable hardware this series has between a 2% and 5% improvement across various
benchmarks.

There is however a cost associated with clearing history on the process context switch.
On average it increases the delay by 119ns, and also has a wider range in delays
(the standard deviation is 25% greater).

Although this series most prominently has changes to platform-x86 it is based
off of https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=linux-next
due to changes queued up for 6.13-rc1 that are dependencies.

---
v3->v4:
 * Drop SD_ASYM_PACKING patch, it's been moved to another series: 
   https://lore.kernel.org/linux-pm/20241021175509.2079-1-mario.limonciello@amd.com/T/#mdd6530f8d77a3adf0f99bacd99e4c77fc1180f47
 * Mailing list feedback (see individual patches)

Mario Limonciello (4):
  MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
  cpufreq/amd-pstate: Disable preferred cores on designs with workload
    classification
  platform/x86/amd: hfi: Set ITMT priority from ranking data
  platform/x86/amd: hfi: Add debugfs support

Perry Yuan (9):
  Documentation: x86: Add AMD Hardware Feedback Interface documentation
  x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS feature bit
  x86/msr-index: define AMD heterogeneous CPU related MSR
  platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
  platform/x86: hfi: parse CPU core ranking data from shared memory
  platform/x86: hfi: init per-cpu scores for each class
  platform/x86: hfi: add online and offline callback support
  platform/x86: hfi: add power management callback
  x86/process: Clear hardware feedback history for AMD processors

 Documentation/arch/x86/amd-hfi.rst    | 129 ++++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/cpufeatures.h    |   1 +
 arch/x86/include/asm/hreset.h         |   6 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/cpu/common.c          |  15 +
 arch/x86/kernel/cpu/scattered.c       |   1 +
 arch/x86/kernel/process_32.c          |   3 +
 arch/x86/kernel/process_64.c          |   3 +
 drivers/cpufreq/amd-pstate.c          |   6 +
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  21 +
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 547 ++++++++++++++++++++++++++
 16 files changed, 756 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 arch/x86/include/asm/hreset.h
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

-- 
2.43.0


