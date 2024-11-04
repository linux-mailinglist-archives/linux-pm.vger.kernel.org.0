Return-Path: <linux-pm+bounces-16981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A59BBC75
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BC61F226B4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC841C8787;
	Mon,  4 Nov 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MGishXpx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006913D53B;
	Mon,  4 Nov 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742884; cv=fail; b=lcIf5HamuHam51wgpXv/DvpxK8RX6o6fepB24xu+IaTH2pmXXpk8U5kaSFmyW0kCR+dKvn5Xoa97OlJLDc66JMBELAcTcTDbnrz6ltJfA6JuiqVEa7fZz/F0ozlyP+RG86pzjm9hzD5dQ0nZbjO7M3LJqCRnv6wOYuoSQgB/PIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742884; c=relaxed/simple;
	bh=abKHVqcob6MsIVrzPFq/wVW672akzDEtsTRrcF6OSp4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RK5IYzjIDCnhoDxZIQmA6jgiMiMn/YsLamtSGYagJPkk9jshnL+OgUPEwIzx83jIrMEafeO42S909u1eurqQztiiRM+bvVsf7nzaQ0FNJgU1nSZfcqTg+r/pkFcZ6XFCdwByr9ptzx3KGtlPZCFWqRYbqASoDXclQ5EqkuS/yvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MGishXpx; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOSbrAD8xM62Z/R3r3e5bw7IwH20wdXwyjZP/PDx44FQKbmO9LfOfu9D4NB8b0SQhWJDthBKv+nw5n2cBPCEW3uLmTMKP04qePSA5TgTYE6OjCVL8xIp6I6FefJceCKsNFp3aJiwnTztf5HvyuKInpEq4xusrDE99wlAWBIdsfeniRuibXGoAPK5J53X0cqFFXN6VpjDVxrqPun43owoCXgIUs4kcYMkMBrUCrCe4Jc51IhhbyID2JwRwRHMl034yXShZB8TsSLV4uBcYSkbsP1Cu8fsYS4yCggccrUgo4PtriN30kjwtiicJoWFUGz4QcmgrTMXoStQk6G0c3sGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPEsvSbtO+aCrSCL56aEafSf0p+uCfEbbfU2zowipnU=;
 b=FLMq27fqeZ5ie77AK5/EcfGNr8CohwoeOipProRkWXwY7/Npxno50ijjU/E5ztHwC8qOCSLMy7bVxKVFVHqxitMH0AdFLII9IdXqnkn0ISfOG8WpRpP2Kk/dWMvlcPqwQb9cy1wQ8a1/oICa3/8ze9EhynhqCl4+Kz6SWKKS3SeUihzJucN0d8cQclgZHdB+mt9Jir//1N69fUrGrrsQM3knKwPPaeClOhLFWN6yRXXa23zLGXm5poPxaDZbpv195LHxB2TEIhOzJpWs2mz2QtMbxk9tsP/WlXH1D5dWPF1W6SwtzrdcpjvGgLFvzHAWB8LWWQgbzYknh01RFqH88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPEsvSbtO+aCrSCL56aEafSf0p+uCfEbbfU2zowipnU=;
 b=MGishXpx2nAZItHiv+M5XcyVduTxKgOSLtp+O7MMSqGeSBNFMOrj0KuD1jtI/vXb/6Jw6Nz02ECub2dr+OndVtcv8dM6xylQHo89ED85wY3pXrhGpWqGdUXLv0yy12ni8ncViUtqaDMw/UI1QfwEkZsfLMkOwjEJ8ulbJK5n6gQ=
Received: from BY3PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:39a::33)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 17:54:40 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::67) by BY3PR03CA0028.outlook.office365.com
 (2603:10b6:a03:39a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:37 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v6 00/12] Add support for AMD hardware feedback interface
Date: Mon, 4 Nov 2024 11:53:55 -0600
Message-ID: <20241104175407.19546-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: f55094fe-a8d0-43d1-9a67-08dcfcf9c0f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+pjS2VuozRSfRuoKRc4x2Qvxihp8IXXEt0aBlIWeZwMSzrdgXgL839rcYM+L?=
 =?us-ascii?Q?iOJjYp8IfgX4SV9lRyI6b/kh6WF6JmY4RWT/UfRyws+THRfw6GL9FNJnOLPE?=
 =?us-ascii?Q?i/yDZJtm3nUZiOI/DUGQY8YynD+VlDIhIl1NZPIvMZxBCh9XqyjeOC8r8kjt?=
 =?us-ascii?Q?IhJ9KJi6r9J+E8JR7Tsl7XxJhNB7PCvnmfyOqW2tDH9yIw6MyVcrYnlKiYJg?=
 =?us-ascii?Q?Z0ypgs8AvrmTM9NkEAEotps2IXoaJdvxmoiW55KGeI1iNKSlqdqGDOuz07kI?=
 =?us-ascii?Q?ouSKrYJ8In2Qu7Q1bnz5OEDvu8q8/DqkKA7APEEH3Nbx0W5uMMJdEsdFBkoJ?=
 =?us-ascii?Q?mYxeSsIZMM7pu96M7SOBvrlX25QabYq/9mdlOlU/ACNfTYvkjQ+FgAIWFzFJ?=
 =?us-ascii?Q?emUlO75K1wXibYR3pfF8a/zj5+Ci8TWyAE5VaCfOyCILRpt1PLP0iMLzOxst?=
 =?us-ascii?Q?JjjcypPytxeOUrjV0yoCY1fYmJDxk/dF2lZ+DEAiLJff5UgIf7ZIhUhCm356?=
 =?us-ascii?Q?gK2iCJwaj7CezAKbJejv8AeZUBVSdGAMC3LRPdr27SCesnomhxG473kKKExN?=
 =?us-ascii?Q?WW0lEEtT1Q3OFu29RPLbvxwId/Pf6YbT38SMpnOy8spywSZ9z+80NCiA3UDp?=
 =?us-ascii?Q?EbUfuVoTF8eYNZa9Ya0+m413zAjqAImluULmDLbUMTeXTSkPCqWN8KRM5xyj?=
 =?us-ascii?Q?AOLAnlDSEa36k7mNtCE8x+ZxOmEEOvMst7wre4/5QaIE0ktiknHHgS6INl80?=
 =?us-ascii?Q?sTxihkBe+0haxyJTPEw/iAye+t3TbLT2YxZlz9xCrH6gIxQfmI2FbheWwrN7?=
 =?us-ascii?Q?W11ZhGdha3IQsDLB7dA/9rQqK73emuTBZ6uHlbgCXGBlcc987zp3Aq4LyYqx?=
 =?us-ascii?Q?7cDwj/1XdiZAso+lPpmFPBGbU/HnrPQ2oLAjlhFclWkEWYSroo5v7cn+ULtK?=
 =?us-ascii?Q?80E4V7kEgQHSedE4vEEZMuh7E1RBskDw/X9wMlAHQNHoFYxxhk/LkNXo+72w?=
 =?us-ascii?Q?L2g04WEDZD6V/rC+YcGSf7AHf4q6oRLJEbPYYMSpC8p/9amP9NISzTD+3szm?=
 =?us-ascii?Q?nCYn5yuH+hd0oqn4Ln+IK3yIxiDc7PLrGz+pHTxYvicwHT2Bfr5QKXpIK4PR?=
 =?us-ascii?Q?uPMTpJikyXNeIApFwQa6wupmdA9kBgMDK1jSb568j1fszx2vPF5tYApwAC9Y?=
 =?us-ascii?Q?/KlvfLopqxtWTDvONmDPT8EAKobBMiGDiGT2mEqeJe++dUPPGXAIL2vP/AoF?=
 =?us-ascii?Q?HyfBPoKRi37dk0Br5XOwhCVP3Y56vtE9N5sNt4fMXW1vNudmBpoVfpCB3Mxb?=
 =?us-ascii?Q?y2t34mAHFrUUta9dWY4LLYLeuxmVxl/RcgH0KVmBZvNziJ9xs7h9PBQeKu3p?=
 =?us-ascii?Q?darG2/kqbAJ3TvDqRZrRMVIwiDlYKpXMwFw8WDsN7jGpUhKeiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:39.2255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f55094fe-a8d0-43d1-9a67-08dcfcf9c0f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294

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
off of tip x86/cpu due to changes queued up for 6.13-rc1 that are dependencies.

v5->v6:
 * boot_cpu_has() -> cpu_feature_enabled()
 * Simplify process switch patch
 * Use managed resources

Mario Limonciello (4):
  MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
  cpufreq/amd-pstate: Disable preferred cores on designs with workload
    classification
  platform/x86/amd: hfi: Set ITMT priority from ranking data
  platform/x86/amd: hfi: Add debugfs support

Perry Yuan (8):
  Documentation: x86: Add AMD Hardware Feedback Interface documentation
  x86/msr-index: define AMD heterogeneous CPU related MSR
  platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
  platform/x86: hfi: parse CPU core ranking data from shared memory
  platform/x86: hfi: init per-cpu scores for each class
  platform/x86: hfi: add online and offline callback support
  platform/x86: hfi: add power management callback
  x86/process: Clear hardware feedback history for AMD processors

 Documentation/arch/x86/amd-hfi.rst    | 127 ++++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/process_32.c          |   3 +
 arch/x86/kernel/process_64.c          |   4 +
 drivers/cpufreq/amd-pstate.c          |   6 +
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  19 +
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 546 ++++++++++++++++++++++++++
 12 files changed, 729 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c


base-commit: 110213b8f0e7021819d4db273facb27701bc3381
-- 
2.43.0


