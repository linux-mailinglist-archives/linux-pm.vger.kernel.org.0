Return-Path: <linux-pm+bounces-15480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875499927A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FED285B64
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0171C9B67;
	Thu, 10 Oct 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DAMIPMIJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CC1990C1;
	Thu, 10 Oct 2024 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589067; cv=fail; b=sURv1TmXNfJqv0weFAByWkDGsTqYk81oRP5m66Cy54m+l7yKeI0L7SSM1fo3a0HxiF1JnDGuJzHxsWOYFBU123EE/nqBD1KqYg247+PRTwcl709V/IecwgWWVKa055vXSmmfm88fknrMo+ZYrnAGjuR06mjiYjh5nmWcItvRXLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589067; c=relaxed/simple;
	bh=y9mfPG6FgIAGSjVTgT60QA/AkwmIN82lVB1LUEWqbSg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nLQQav8RglMIcfITzOWKOk2btKRN5WbQAA9oo56n+uAv+crS4a2ieHSG3c44jXZxyNynw0WswzA2hgtQcN9qhC8um6X6cvq55ZgIdVr73EXRiEMa5XGGV3kRrB30WJqiqyAnQ0kUZsfkzQYIXk09UJYfP3OJ8QVU6m8zL6xpg4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DAMIPMIJ; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaChEyQpf098HfWg/8M93UJAr3ibSSFAAsWunho9T/FU3VJHYcE4tYDaKkzuJ+iUtpWtYpfuksado+EkpDpqHaic5JfaNdRw4x4YPZet2QZDP1hB/4YJdYsUyiU9MnN+uSkE3QHUodPJgbtQcFRG7VmkhQZz8CXSFXyJtZ3mgQDTnDjAuIg4dVu8XG/eIdwAPKGneteMP1H5eZCm1+NxYz8084kq6/yspAvNMp44My9y67z6FWfXepQGiZgc9bH1RNoa2+am99wDq98yB9r7RiA2IPnt6ZEJ6SeGPSl2RSLc4t5gKW9cuVUuJIogI2lfAqkRp6tzCBpjx/CIOEEEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxh/SDatNR54ps6jdDc5e/qtwWJpJfE0hrpI6s4KROE=;
 b=LnNtYkt5m/mZ6BjEhYDEMTBgDtc3Qd4TWhkVS7YPyKZ7DCu7g3qbiZiryq9HbZr+fFis4VVN0Z7kmdBdABmxCaFeaqvBilgUix0AmFLhKnzh+wVGiyX5xWW0psvZQmGUTJNPGdksC1eedI6dzsQ86pDgx8+JjSvHbHb/l5FxoO3lJPpJVRUjrqwNCg1rV5QfLSj3jbSy9EMTxhTihEkEVR9GllwW3sjTEU+D9fDQ45qRKYxiSyEwbxREK9q+uXF1GfZz8eyXNfOuXSWIOn3UDvisoKeYAcNMrsOhhLulOQOyN1964Y5XVHtLL3FhJRjvxzIzzUtX+IjcfWFk/2dBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxh/SDatNR54ps6jdDc5e/qtwWJpJfE0hrpI6s4KROE=;
 b=DAMIPMIJlvpb4fSJgk2vMmJduzj505WJlur+W8K/LYfXzFcGpWhI6wvgEY4p5G/AHFh0M8jJTBLsaAINOyKxShKH51ObzdMf39z42k4DJFncWQ//hfdFVovQdPsB+24cMG+elFhToGVK/DnfM/DT0MDrAantdEZToruTT530IpY=
Received: from SA0PR11CA0070.namprd11.prod.outlook.com (2603:10b6:806:d2::15)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:37:40 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::30) by SA0PR11CA0070.outlook.office365.com
 (2603:10b6:806:d2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:38 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 00/13] Add support for AMD hardware feedback interface
Date: Thu, 10 Oct 2024 14:36:52 -0500
Message-ID: <20241010193705.10362-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1705df-1751-4b72-f288-08dce963007c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/xRVjzpjv5poZ/Mg1hnSm6N2xOMN2zHLQxW/rgRVEyCl+Vrac1R+4KT60ahT?=
 =?us-ascii?Q?5gxKTq5HS5iz5F1yCLZ5FXAzXDgCnP8mW4LiLzLD8vurK19qb2/CGs4CqLyr?=
 =?us-ascii?Q?nu+zmhoNsb/qLk9CtiHwRlhk1c0XeAHkcWaszN1nulN2sckGC0OGrM10naLi?=
 =?us-ascii?Q?KELfVYleizowYeCGnKgAoVEUbdUwhVEj+5LNxQz/M5AJS5oPfA/tp8GM9L7Z?=
 =?us-ascii?Q?SIuqdhUSF3nfmPCYPUVHlgP/1tuM67kdkRix3NXRQbogJ18D/e0JReDxHrAL?=
 =?us-ascii?Q?AOEb2d99ERW3q6k+deuBq450qjPXDDaR6mfNGXbl2kDXs9kQWa1MZ8TaHIW0?=
 =?us-ascii?Q?yzIiuMYK5Bu/3OJKO9z/Zs9s451EkKwbssTjjXTOKFFWxBM4B5mbIBKGF1IM?=
 =?us-ascii?Q?RuDbm4K6QcLGMD9aT8slyy5MUzsmUItlMj8Wu4aHaTlhWGYJjsGQFeccsT3S?=
 =?us-ascii?Q?L7JWOSoU7utF9SIwsg45ZNUjaduGKFDfa+yO2GyywQKbK5vg0S3phjlXDET0?=
 =?us-ascii?Q?2RfT3uA5zUeW5eRLmWzn0PpysQfpREg8acFal+wEl9JO8B4LfpaFeYIoNW2y?=
 =?us-ascii?Q?Ei4q+aqQ2EcxWtYyVrPhtnOWXjPOzAnFmiZQdVYjuo1qTGqpaQzUdTzRLEjt?=
 =?us-ascii?Q?x4KK4ennlCPhlkWo+Ey1evCTKAUgNOUzMdrayAHAFAyw8Oo3d8RkxRyb/Snw?=
 =?us-ascii?Q?rPPx0ox1VpFqjKY1mATVgfChKbkedmViwWJJcZouZ7tv0nuTWf7ZIUCKUWQ9?=
 =?us-ascii?Q?9eG6+E9X6zKmVcKm/ullBBq17fjRiFOXHFD/mJDsfpo/M+D9rUjKaxYoWjQJ?=
 =?us-ascii?Q?rshbiHx0/6GjcuKZOKChN7K58UlW/lG0amefFJJydARPaXhqRa1n0qPj0by8?=
 =?us-ascii?Q?5zSQHja4VKal6l0TfmsqMb0DpGKmvmun2t5EyxDQu7dBFpCP2QHepI/yWy3U?=
 =?us-ascii?Q?OWUiIR/nGZSIq9BLGGO53oxpDE83oAiKgcb1a7PPESI7v12ThbFsjJzs7HLN?=
 =?us-ascii?Q?jhZKWtfR4kp8IKeovz/WBwMOH7XCW2ZLqGtE/qhXuqwHEX43B+gWjr/6Km16?=
 =?us-ascii?Q?QOtdCRbkryguwguzm4sFACsx7n7EPrW6JiD5oN1DZR/kumMdN981WpMS1N1m?=
 =?us-ascii?Q?aADnh4Ig3p1kZYQFgT+8G5yvArFTCvDRPv2FDhkH2t5BhK1MRe7hxC516psV?=
 =?us-ascii?Q?TvyXrwKsvjFtgeaf14ZdF3K3iJNeCHyck+w8xY8N+dbiDai/rUXTl5J0kCO3?=
 =?us-ascii?Q?19rBZ0a02pV5lyoPHF29kjCuIZYdqihhxcofGjSQE3M1P3TCYR0U/cqRA35B?=
 =?us-ascii?Q?62hG/jUyqYhf++JHFnJF2WcahBBtq/O9UVEJP6yemEYBmStxXVFwfecRbQCZ?=
 =?us-ascii?Q?LQhnQz+7886Viu4dVkNoqTL5n6W/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:39.8052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1705df-1751-4b72-f288-08dce963007c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132

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

Mario Limonciello (3):
  MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
  cpufreq/amd-pstate: Disable preferred cores on designs with workload
    classification
  platform/x86/amd: hfi: Set ITMT priority from ranking data

Perry Yuan (10):
  Documentation: x86: Add AMD Hardware Feedback Interface documentation
  x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS feature bit
  x86/msr-index: define AMD heterogeneous CPU related MSR
  platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
  platform/x86: hfi: parse CPU core ranking data from shared memory
  platform/x86: hfi: init per-cpu scores for each class
  platform/x86: hfi: add online and offline callback support
  platform/x86: hfi: add power management callback
  x86/cpu: Enable SD_ASYM_PACKING for DIE Domain on AMD Processors
  x86/process: Clear hardware feedback history for AMD processors

 Documentation/arch/x86/amd-hfi.rst    | 116 ++++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/cpufeatures.h    |   1 +
 arch/x86/include/asm/hreset.h         |   6 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/cpu/common.c          |  15 +
 arch/x86/kernel/cpu/scattered.c       |   1 +
 arch/x86/kernel/process_32.c          |   3 +
 arch/x86/kernel/process_64.c          |   3 +
 arch/x86/kernel/smpboot.c             |   5 +-
 drivers/cpufreq/amd-pstate.c          |   4 +
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  21 +
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 541 ++++++++++++++++++++++++++
 17 files changed, 738 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 arch/x86/include/asm/hreset.h
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

-- 
2.43.0


