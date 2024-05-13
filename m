Return-Path: <linux-pm+bounces-7746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470C8C39FE
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CA5B20D5D
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D3D1272A5;
	Mon, 13 May 2024 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lRuT8ssF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FCF200BF;
	Mon, 13 May 2024 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566070; cv=fail; b=EHjj5d+iENkuJTJ9FSt7zsbyxYIqEwJze73KAS+m51tswErBdw724laSs4lReM/onXxOzjRDaUCmf24VA7mCBgiWQEhXMW4lyq/4uU4Jl/KPf/Iw58xf1dDSMVncxen3oxZBbDcaONre3DiMu2KwXqG6w1ZpN0u+zUsKaKeLNI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566070; c=relaxed/simple;
	bh=+SBpPM5GWYAEgMf0mcIVKJp9DBiFTpbQPx6DI6LXsWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kIN5ZNzJ95VP+KQOU+OuKQOjeD7bHO8EqT8geLt09LOEskVkRp2OFJ18TjJ9+R7ECvGjTDapE4Cluh9AFPI0837KcPagygv3qK+P19opSZxW18q7o6EV4LiugKrxjQp4rj44viAPbOuU89jl+my2tvoVu688UqiCzt084m7mqWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lRuT8ssF; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAoFy5d0W5VO9zOL1v2dB0xti/p5f7e1wD7TpVho5ZLTs1jVb5YPdzKl30+MfdZ6hNQ1ZOQgc86V2jkZtpwwT3uSVCgDfRyeufU4NmCeEAnUs3xWc/CvNsy/eMyTCYWo8+EZGj0QfoSHjuUKBzm8ZFy3mLjbVLL/nmrgujUMRIO9igoVqs3WBc8r13cmEteaNao3MbeIN4W+eqv3Fa3oKxA8Xt3elrjkbez6UZTbckneLlhzaDn7N+XTpoBnaoMgTnEShhsZXOsnFY6mtEx4/BT/JQCPklMntWmo+fSp0nimqLkzIN5E4fd4a6vyztcHTq9nn0x4hP6PDQdRuGupFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTAgT4H44zgFBnQPdtXzPz7T9ihCLApSydVfqy8VzhM=;
 b=aEwOUzeZPo/RtA7VD/1T+nLKd8flf92rddszpzrDn4auIpTL7Y6aa4onVfUSZYLc+f3YDh7DKWJ/wcrDstnkAnwaJh4yRCOBzYjs0PNZYWj8a76kDf8Sdx9d64AizCalcZW+wSSAifw48bEaPn/hsWlUT37SsPbX94jZMwlXJv+IJdAKzTV08JznNU+rNvuGiWdgKfmDAAtzSFOSl0Gi7YUJu5WyFN8oyNyoskkRcMnfNUFtAM2xztoaJhAhMZBmnqiYwmyszqMIYnBPM+716ld5rEdW/ahaf59sO9FCvCGKnqJH2rHBmpgDXbbswM43YQyH96I1lpnDMh+yrNBKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTAgT4H44zgFBnQPdtXzPz7T9ihCLApSydVfqy8VzhM=;
 b=lRuT8ssFoV2ziXBGpqc/8Iyt14eYTmDbjiJsk2COlsI/euaC5/GE4qUCm9dtRI7q7LUDQQzpmv1lUJlqG4Zw4BUmxK9drt9wrkNnpJyq72oE0/Y78Hrj5ZmeXiRMep5QBxq4UANragZWM3hKXruzmJDLyRjd2VUsQOx/y6N3KYM=
Received: from SJ0PR03CA0145.namprd03.prod.outlook.com (2603:10b6:a03:33c::30)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:07:44 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::8) by SJ0PR03CA0145.outlook.office365.com
 (2603:10b6:a03:33c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51 via Frontend
 Transport; Mon, 13 May 2024 02:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:07:43 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:07:40 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/10] AMD Pstate Driver Fixes and Improvements
Date: Mon, 13 May 2024 10:07:18 +0800
Message-ID: <cover.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e09be5-8fc8-49f8-1dbc-08dc72f179ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6AP2VTBSCOP0U/hv7VrmG2s+9h7E5Ukyql81kM3utGUbUdK3Qf2aE6u/iu9+?=
 =?us-ascii?Q?zXRY8rlYNkTKPrG8z9E2pOCWwMZPpFGO8cyngadcs2wtkqq62Gj5Ndx4lQkK?=
 =?us-ascii?Q?HFNuDjzqBjOagw+NHzYFCHYhOIWmTCZiY3byGPYkJTmv8SRZz26QgwY4Bpj/?=
 =?us-ascii?Q?lpjoRUkCKXwRm30gaxJeCJ0cVyvVdcCkhC0ORkOJ04EPFZSLnCWuwAkuNo6g?=
 =?us-ascii?Q?eWRlIigOl23qXNSMegBBaHdmbZsR/K3XmFA7AIrdvF2iOLGqgFFBME26C2O8?=
 =?us-ascii?Q?tkV3+YTEk9Nb6dXxARrsKnHfupvF24eaN05Uiu88kPLIORBWkk4XCXyGB33f?=
 =?us-ascii?Q?WckbMxe413mRoBV0rH0CfHMPozt3fMFyeEgG90lPvaEoVAhrmQ+E6x9LE7zZ?=
 =?us-ascii?Q?NJB2vLFBiBgax2zrPpEi+h+GXTuchA7Pd22U2G43XkCN3vm9Ok+WGtJBgdl1?=
 =?us-ascii?Q?tJX8JR/60ML4MRPwg8n2H1T5ShDJEKoyVUU4DMPEiAdiAtuldZOHNolqYtmg?=
 =?us-ascii?Q?PHDN2e+cGYS/uPVuUQie7usbzm28tNSqezxZOAMfZpEcVbSwdA1MqyzEGGfE?=
 =?us-ascii?Q?hljdcjMEUV9V1SppHwrTnogH6nuqjzAQCC/ezZ8mxUKUzZgHDmE5zA9ARbxf?=
 =?us-ascii?Q?wTYyd4ARJMvkmY29sakELhwp01NL4wesDzw/orDwaE1CByhIEOb3GoLIeB88?=
 =?us-ascii?Q?pcmiMzv38RqWF2A8Fsw12sAp6Sst/haB2Ab1AxauZbw5xJ6GbbX6r7bhLE2X?=
 =?us-ascii?Q?ry+OkoB+ha5xhYUUnd2s5Xrf4vAQkkChkU2q0G9RiOuVZDgdjrZcYk7rVj0V?=
 =?us-ascii?Q?MgwaE/qCaYVuSPbuB1u1WNu1X+USihzpKt6lHXeev2XrPGetTXJZUsWiUfbQ?=
 =?us-ascii?Q?qTqJGaAyDijZTLUjHzRjSLEcC1LJf9KzMjYLtbgPVCtoseoelR827W1I+XS4?=
 =?us-ascii?Q?lvOf+KRiQKI7ZMSoDJi5jxmn1TFWtQ3qH5zKmxCO2jXay4rBQGAbyRsYUa04?=
 =?us-ascii?Q?/RkZfjrh4J6/M3VxBH36y33eODW265hAz6l7mavmssYKx0h3i8z2MT9kXeiC?=
 =?us-ascii?Q?AiFN36Xdi5sCOOahgWoYkRaMI7xiAvGHGPlpSTS2VhwJeW//t/DU7C9aksXF?=
 =?us-ascii?Q?UPlw9WiEALFnYK6yaJnHXa3JCFJJF5WHhntLYqXCM/btXMPjck7jfDp29NDO?=
 =?us-ascii?Q?bwcUGN9aYjKQbHq4Yi/GaIZpXdUtrxiDJosbX9hPcvmV7RRqdnXcHylmtlS4?=
 =?us-ascii?Q?O5o79+OBG9yAbpMErdExOaCuJVXog9kA+xqDq/sHgNXv359TJXJ1c0eLwWib?=
 =?us-ascii?Q?3cgQiRAjoGgYPstPZvIFIBnAqVEvrd7s89FoWePFneikZjsR6P+z15yhKOHl?=
 =?us-ascii?Q?l64lvxe0GLmIRBsgoHM+MSN8QkAP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:07:43.6876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e09be5-8fc8-49f8-1dbc-08dc72f179ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

Hello everyone,

This patchset addresses critical issues and enhances performance settings for CPUs
with heterogeneous core types in the AMD pstate driver. 
Specifically, it resolves problems related to calculating the highest performance
and frequency on the latest CPUs with preferred cores. 
Additionally, the patchset includes documentation improvements in amd-pstate.rst,
offering a comprehensive guide covering topics such as recommended reboot requirements
during driver switching, debugging procedures for driver loading failures.

Your feedback and suggestions for improvement are highly appreciated. 
Please review the patches and provide your valuable input.

Thank you.

Best regards,
Perry.


Changes from V1:
 * drop patch 11 which has been merged in a separate patch. (Mario)
 * fix some typos in commit log and tile (Mario)
 * fix the patch 11 regression issue of kernel command line (Oleksandr Natalenko)
 * pick ack flag for patch 7 (Mario)
 * drop patch 4 which is not recommended for user(Mario)
 * rebase to linux-pm/bleeding-edge branch
 * fix some build warning
 * rework the patch 3 for CPU ID matching(Mario)
 * address feedback for patch 5 (Mario)
 * move the acpi pm profile after got default mode(Mario)


Perry Yuan (10):
  cpufreq: amd-pstate: optimize the initial frequency values
    verification
  cpufreq: amd-pstate: remove unused  variable nominal_freq
  cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
  cpufreq: amd-pstate: add debug message while CPPC is supported and
    disabled by SBIOS
  Documentation: PM: amd-pstate: add debugging section for driver
    loading failure
  Documentation: PM: amd-pstate: add guided mode to the Operation mode
  cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
  x86/cpufeatures: Add feature bits for AMD heterogeneous processor
  cpufreq: amd-pstate: implement heterogeneous core topology for highest
    performance initialization
  cpufreq: amd-pstate: automatically load pstate driver by default

 Documentation/admin-guide/pm/amd-pstate.rst |  15 +-
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/processor.h            |   2 +
 arch/x86/kernel/cpu/amd.c                   |  19 ++
 arch/x86/kernel/cpu/scattered.c             |   1 +
 drivers/cpufreq/amd-pstate.c                | 209 +++++++++++++-------
 include/linux/amd-pstate.h                  |   8 +
 7 files changed, 181 insertions(+), 74 deletions(-)

-- 
2.34.1


