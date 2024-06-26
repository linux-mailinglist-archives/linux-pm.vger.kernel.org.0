Return-Path: <linux-pm+bounces-10000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78DF917743
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF70F1C20E29
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF9E8003B;
	Wed, 26 Jun 2024 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BbCaZIRE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478A175BE
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376094; cv=fail; b=idmhdcp/ASQzF287umiSdLLYB/uDQuL+f7ghuQRmcgFfNHbrbpqz4cv2EHLICRy/kjj2vkOu8z0CtX+Q9XV/eogz0kn2gC54sJeb1wZdi+WzUlkQSBjQbfexBacqYrIc3+z9GVpr94cQU2e9RgvYbVZWjxvriPwZfXcWfRMBBiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376094; c=relaxed/simple;
	bh=FG62AN8FTzqaKTRwz4RLfbE7ao1z4dopdrSPH2/8Xeg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tYQVE5drCnjXHzGxpoErDwyUou8VjH9YkKzvkZR9hC4vNQMAqFXWu/AkWwFYAbo2bspgR/R6vQodVoSIRrVffZyFEaWOUYmM9tgDpMonUSEKW9Rcdp4CuTRbMFLXdK5CTH6SqR5BeoQwFmBApwdXvLQmaBhkzolA2MBybuUyhw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BbCaZIRE; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb6oPRZwkbRyutfF74cDR7BDyiIP4RGjCIaZw+w6Wfa6/vUzVo5r5m4MNTV9zrshiKEQO++B2N0nRzetol7iJgqbjXrxG4UrOpgIAnjVCR4fsVkY9pQj4OHQHUyE0lmBxFcIsAbD6+7WFEF0ZKrzc3RDxhT7hWAm//POAbaLtltcAlRFaANjYyWe+B4In+U/0PaPofB3ZTVb8vT6YFynyuak69ZXHoMjartQ2I/nziCmqgEEkwkWOiMYiesth13woPJwYSsidCXdYKiAkyaK2eoVu2cMXtGwgwUbIDeeblbcDtQbRd6EvI29+JrXDtn7czsy3T3knBtscrDfoKRBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUF0QAihXefDGb7r7K9kgWVLtUWBO1rKzSOUBvbW43k=;
 b=C6ZIJbYPQET8txEmm5Q8Jt7bptaxnkxUtU77t1emj4FLsITr2xc0TScWJAlzQjXObXRgU8AfxPxZaGqy1p8WalolR8yKz5gWws4s9E3SMmtgWLDz7Gz1VGuORe33xszUCWPuiH1H24c0Smnwy5JyFQR2iDXe0dinexrn9n1CO1+JXnm9z++LgRqPA/T3TnIM7LxiVo51kD1wI2ZWYVvICOkPtLa7yrcytzvfnfC1ybx6B4okIF0z3A8Fcz4wHsrmAM4TTR7p00RRgl9sNlP0d+BpeqLLZ1kxbXE6Rg40jlFdhtay7bM9oEAHIIKlMyK5GPCwhz4YxenA0nuFSmYSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUF0QAihXefDGb7r7K9kgWVLtUWBO1rKzSOUBvbW43k=;
 b=BbCaZIREBnJjlifPokqr7bM7sO88WUpmc8PKsvh92dyIKpvqrlKrlH4VjfxYFi+bIHzOI1i+B5OYnXwbVcTRlTGHAT17HhvAKLgJwpkfittzXobhWtEZxEIkYHA9EiPU3UgjnFJUj64KDlTSNGOE6czLwlWkZwOpfXiT6y8vHvk=
Received: from SN6PR16CA0064.namprd16.prod.outlook.com (2603:10b6:805:ca::41)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 04:28:10 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::33) by SN6PR16CA0064.outlook.office365.com
 (2603:10b6:805:ca::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 04:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:28:09 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:28:09 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v15 0/4] AMD Pstate Driver Core Performance Boost
Date: Tue, 25 Jun 2024 23:27:29 -0500
Message-ID: <20240626042733.3747-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0d57ee-d18a-489c-7638-08dc9598628a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YhKPluqH1xcAGybp/U1kARt9InjjvVYACuD90+Zeya7YLVvTkGjYF0cPamMs?=
 =?us-ascii?Q?ATIxlnMA1zFuCmM80JP+yvTTZOeXIidgOJJi2uIIWUZtajVJpQeyF9mGYdHw?=
 =?us-ascii?Q?Xfbsw6pAiLBIDEAw8sqqE58WoNJY1eFqC4LWn7zHUe+EryqO1wU2BFKdIGHn?=
 =?us-ascii?Q?/HmVQtmjVruFcnH0fXh1BdoUL8RmGsUTcZfpZ7NEYQ+3rgllMbVZ6XWLivVZ?=
 =?us-ascii?Q?Jxs/BBjQSKKjPK/MZn9BreQcsaqns785tzYeFVAGS4VcW4WxQRu44V8vrOMr?=
 =?us-ascii?Q?PNSIaENgdJtf3GnP5r/omkJDs3hNxQjp/bBFzh69fOYtz+QLKKYmI1yCzpNp?=
 =?us-ascii?Q?uX8Rb9B6obDjcXPt0iFdqLRYupTGVAD57794f7ZDGn7DFsnp6V6sOAY5l/cl?=
 =?us-ascii?Q?j3UWEPO5cp9ZWOJDcpORZvRZQDqrfyN5hSxojNN/yP/QkjBQX0ICUnAa7lVn?=
 =?us-ascii?Q?aZbW2kPLWark2d+/olq8ZP57n4vD5rplc0zpTHUaWGGj9sS+7bMKAhYb6Mm3?=
 =?us-ascii?Q?vFW61vMKE9cOYP2SOHxt4ETv3LTPjdJppYtK6Vf9SNbu4K4lAa6rVGQuyOqK?=
 =?us-ascii?Q?8BZEueqqFF0VnRBScdv6xcWyfY8XSFiu9WMODCTHMvYqWlqAU9a68NhdW1gf?=
 =?us-ascii?Q?VvKOKpkpZAbIEBMo7dmlzkNyz9ufjQz0Fxa/VuJK0dxZ86zGSbp8JBKbdsxK?=
 =?us-ascii?Q?89QfeXPk6rOrFXH0YAbIMzRfzere5iMj3JI96Z8299WxeNsVORFtLKlgJMmu?=
 =?us-ascii?Q?bgtqGrUW35lP4csvYttEqDfR/8tZW5Id9o4xIyfOeB/q/by2bBSmqCHuHwwu?=
 =?us-ascii?Q?dZXY5b+NxchV7ZdwYTCLNLPKki5Wd2+2YxdU3/BjKL6HTf4yvwkZry9UKcLe?=
 =?us-ascii?Q?AxjgXKnESFyZscAzHyEA1GXwGzpnbvK4qYqbiF25MtGTkLYjIIqOutobOaFe?=
 =?us-ascii?Q?o3qAILuym7PaDpftkaPIaQ7SzoXrhebV7ilxqDZiWNBNetcbWGvuWAJLEOLd?=
 =?us-ascii?Q?wDpAYJQ8eLk/1GQmbB3PShxMF7v8EKKQHFjGZ++KUI4NIivNvlcwNukkb9od?=
 =?us-ascii?Q?LGX+6YyAvn0RBwM04Ao5/5j6Xf91ray9Oe7OwqK9cX1Ka9NySHkvEoz6vrNM?=
 =?us-ascii?Q?e4GrS3tAbLdt62NexBI4pThC66A2GAI1yNCzuPV8DW4YC6uwCxr+NDzzZDp3?=
 =?us-ascii?Q?gfeS3qx+FRlivM1Y0cd3TjyqkfDzQxBICqp3mRiN9m0GZemtPTZnZ4/03vBG?=
 =?us-ascii?Q?zGmGDsInzGQq/KJsSGoj41UNv3ILmpyBUQu2LUgXo0/msvVQKZ+tii36dawS?=
 =?us-ascii?Q?lUubLLVL7dwV1fr1TY97bXAkeL9cN52Rhv4T73Zqs/3sa4O0BljOtNnCwu5W?=
 =?us-ascii?Q?oqV1Mx9k43an3J5aYPsQp5zWeoGoeo+lCvVj1dvEau5HfQzv0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:28:09.9639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0d57ee-d18a-489c-7638-08dc9598628a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

This patch implements core-performance boost (CPB) for the amd-pstate
driver.

It's a follow on to v13 submitted by Perry:
https://lore.kernel.org/linux-pm/cover.1718988436.git.perry.yuan@amd.com/

v14->v15:
 * Pick up tag
 * Split out fixes to cpufreq.c to separate series
 * Modification for CPB patch to cover case of user setting max frequency
   below nominal while boosted and then turning off boost.

Perry Yuan (4):
  cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
  cpufreq: amd-pstate: initialize core precision boost state
  cpufreq: amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB is
    off
  Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
    control method

 Documentation/admin-guide/pm/amd-pstate.rst |  16 +++
 arch/x86/include/asm/msr-index.h            |   2 +
 drivers/cpufreq/acpi-cpufreq.c              |   2 -
 drivers/cpufreq/amd-pstate.c                | 122 ++++++++++++++++----
 drivers/cpufreq/amd-pstate.h                |   1 +
 5 files changed, 119 insertions(+), 24 deletions(-)

-- 
2.43.0


