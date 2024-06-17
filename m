Return-Path: <linux-pm+bounces-9287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C047D90A656
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A221F23244
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C15719007F;
	Mon, 17 Jun 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wqRUmrUk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF91862B5;
	Mon, 17 Jun 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607647; cv=fail; b=Y9YR5E2LRehYQr8hCk/MRP32cHCi0jyjwbS2mjQrd+bYlB6Ob1ag7nxxCbadw8M2AMrH8il1+1lK+cE3tQckNUr7bnPlzD3RIlVMjU3tbmxnXlDbPipGMQROstx58/sLASDfg1EwMJrpI0xK3jxcY96E+qO9vDfogSY7gSoAYSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607647; c=relaxed/simple;
	bh=Rseb8GYai4ODUDEtVJwjYIKduE9m3tmWJkJEFgZ+wfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OinXj6IApj74i4UWwZuLpWfYiwSYjaVV0aOBew0GJkPnRBgqlU2EXwPaQDQdYJlaPYx5JYIpy8Hv/nQI62VvhWoHs7A3hGmTI6bKVttuXCLHzqFQ62zU97hgoWDAGfLhqpJfZ5DD8jDPdtDHawhEj/uh7SVSl0geEn25TTSYX2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wqRUmrUk; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep0xfVaXASA1j7HN4jfCAtvqyxodGnEg6twwgWPR2VGYxzz4J8wE/HFijO/p6qVchBNK8q2PI9nHe1Y4I52aFZt5h7J96aSwda0znB5O6cvXDZe8wJX/Yw0W23XCP8wBBK1zvH155eX2/9hK2nsBfonUGxbEVhWP34qre8n25QeZAOZ99VIF9BlpoX8OeySFkg/B9P61t4jjNLTfoG+8yrstzjTxa6p9F7Ul+36uMm3Rb9l6zB+HMpQOWmHAkR/fPfN0B1JZc4Aetx9ERnI2wTH8MeFUVy1cZp7JeMtk1zyueL4Wx/68z0tPRcj0BztMgqh6+f1Gebuav3HKm/OefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDGZpNJLvaiS3TV1L3UWY/2S1xGvN3MI56ottJqXuKY=;
 b=CNniUFuLiPsEvKNfL6SvsGXBXP1rhu17jLzytvh++teGjwWTJemgMDvO7rEjdQWXzw/yj6JlnzCZZ5hTU9Im08zAl9YvD0xy7fN9HwcLkB0TbI5SacHgwEOSojKEzIbJGALCmqwv1eDzZC/wx5Abn11z4oOOTMJ/LbxM9p9nNFkiY2i7Hbojj9eEm6xAzYDesp7yyP2dM0JzH4FP2Bcb2GYrv6alsFq+czMJrZLZv8qEFHgHbbO+1R2djio+y1XwYH8ZnaGe2zQgkpFQPrja0lHYZ0bn0PQHAngaIUv7O9Jz56OLW/a6PRUfmkMpE2lrEw77k2HTZtsopHVxEc/DQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDGZpNJLvaiS3TV1L3UWY/2S1xGvN3MI56ottJqXuKY=;
 b=wqRUmrUkrI1vHQSV63oGgGGFE6AwjDPqUNLP/8cMCb15UKfZub6PwL7JEJZsODfYqnyn5hJ6DJMSZxkDups33jSErHEUlL0/mGATBaTcI7tXF5CQbli4HoSTrd625WnVfEdrlerQ2wmZViOTLwiGh3jwNda3aJ6angPilFy2gBs=
Received: from DS7PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:2a::16) by
 DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Mon, 17 Jun 2024 07:00:41 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::28) by DS7PR06CA0002.outlook.office365.com
 (2603:10b6:8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:41 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:37 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/11] x86/cpufeatures: Add feature bits for AMD heterogeneous processor
Date: Mon, 17 Jun 2024 14:59:10 +0800
Message-ID: <4416ff72ea5a33173b69561803f1578073baccae.1718606975.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718606975.git.perry.yuan@amd.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a6d22f-252d-4bc4-6737-08dc8e9b3389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oCl6j6DBs2fGr+o320JkI7/BCy50t93gxRrw2PmAAsceiVffNcTRJQqDczSx?=
 =?us-ascii?Q?ds4pXJ8He1JbGGkUGWQH+P8d8V85lfdeJfjZGNZMYYd9wj9IvMvfAI1Zy7sW?=
 =?us-ascii?Q?Xd9gfK3JYZrUgRFWDOPIDMigXolKAHiAFskj4r5Pvj9k/5z/ZrCJ5OGFNp+h?=
 =?us-ascii?Q?kEFHxj0TvcJOi7GCVnB8COtVody1zjCbye/9f6HA29QlbbudgrYFEkh/gV86?=
 =?us-ascii?Q?nzrsX1IqJNtmCzb/X+q11lGiZYsxNHBDX78be2tBtMQ4ShJsNujC/pJv/R4A?=
 =?us-ascii?Q?u4zBZEaP/BvgBQfoBeDQPt5PwuDR1PUcCPwzjr2gU9/XBmMji93aU4A9DIqp?=
 =?us-ascii?Q?EoReIWcGnIWvHaKrX0B+8lFOTJ7jSMkZt9hLD13pjlj+ICilGNEX/bec+bbp?=
 =?us-ascii?Q?DTO91HceawHkYi1Gf9XntLC6T2r2G3acs49KNZLZAs0nMZ82foYvcJNUqoaS?=
 =?us-ascii?Q?MNYrHh16wqmN5Aka50voxS4hV8wULurA+wvT8l102/7VGS/wC2CxHfS7+CxE?=
 =?us-ascii?Q?zX25xqPoonJBsq+CNOvrTgiU8a7tA0XObiG/BzjEBo+ExhZqSueiKlW4jhu/?=
 =?us-ascii?Q?qwDn7Y8Xr9ZInIk3LftLsSBx7z5sE9KGs/04FENs3ttlsK3sKJKuvSjAdzq1?=
 =?us-ascii?Q?iYpb1FqnS+lVrM3kNQcjRfgVFXxPz2NhqccY2gGI2gK8rmkj7o1Dx6bp/uQ8?=
 =?us-ascii?Q?I8FxMWyp3RcPNmV2szS5gr+SJt32xmxrkAWW/UKB0AN/S9lNCmd6h25+YgKH?=
 =?us-ascii?Q?HaBSvbRH7Hbu64enPOrNoEyEt76/PEjc6nid5ntrUjsa9wotThGVKwjd1d9w?=
 =?us-ascii?Q?/S4vuRw2am1RRLMhshU1InhWU0UNHh1Ewm7s3+1HerrCbM5Bj/P97e4nSinA?=
 =?us-ascii?Q?4q/w1a0prsJ3SwIvjfYhCjlYGca/9iBYq2f9PVE0/bdpx76Jti2DDhCIXOYo?=
 =?us-ascii?Q?kxvOzZbFmpN0kVy9eJhghMUf6JFkzt0nuFlgZKEjiJSP9GUTNc91s7SJrWt4?=
 =?us-ascii?Q?cbS1DEPAXChxTqteEQR+kqO4aOiP4ct1rm4c2x6Nz57Qw6bWsZp//zzdW5YE?=
 =?us-ascii?Q?QR3HS/a7XDNzN7a9z/YQhmR3UXkGb2g1lKqBvAw5jE8Eh/pJ5NePCnVp5LKW?=
 =?us-ascii?Q?s6i9pKoWwV+33j3av9wBfNF3mqJ5FabDAgsLqsW8Mb/v0vJsKG0B3BrEKoE/?=
 =?us-ascii?Q?zzDygSqvdjbzbrssZ2b+FHYGGx6qVMF0c4a9jDvvI5hbUtM8rGlnHWkUji/o?=
 =?us-ascii?Q?B4pqmhXNPU8xZwJzsYtcyJZXfGRN+DYblkX1mIm0F/YEIoHF8hhuCZEZqwhP?=
 =?us-ascii?Q?g4SIQztp96W6I3o6iEXnQiBZoTMVsCGQ53a8QSQDNr/nbutuHUxQhh0AhvNn?=
 =?us-ascii?Q?YHdm9d/PUgbrwSgAKVbeeTC/yz3gyQANyYUYuc5ZSAMNZhonLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:41.4392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a6d22f-252d-4bc4-6737-08dc8e9b3389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

CPUID leaf 0x80000026 advertises core types with different efficiency rankings

Bit 30 indicates the heterogeneous core topology feature, if the bit
set, it means not all instances at the current hierarchical level have
the same core topology.

For better utilization of feature words and help to identify core type,
X86_FEATURE_HETERO_CORE_TOPOLOGY is added as a few scattered feature bits.

Reference:
See the page 119 of PPR for AMD Family 19h Model 61h B1, docID 56713

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6c128d463a14..eceaa0df0137 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -471,6 +471,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
+#define X86_FEATURE_HETERO_CORE_TOPOLOGY       (21*32+ 6) /* "" Heterogeneous Core Topology */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index c84c30188fdf..6b3477503dd0 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,     CPUID_EAX,  30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1


