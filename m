Return-Path: <linux-pm+bounces-15486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9FB999290
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663811F221CE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311ED1E3785;
	Thu, 10 Oct 2024 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sXoP4GWe"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB41E1330;
	Thu, 10 Oct 2024 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589073; cv=fail; b=bE9+dZ2V/DuxpBa2NeV6UMv5hl54fR0f4ZGzjApTV99Rtbvdx9vY/sb4SGqon1p5y/9sdqLkSOHOKLYn2xfSuQhjlZbYWO79IWBWDKRpl0GgWwiFGshzDcQa+Oz2H31rph3NuDM2saVn5YsKkI5EI8o0kwFXNRHbrIR7vTu4lGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589073; c=relaxed/simple;
	bh=cc4FYa/Vuesa/XyVg3MKYbcElbdt0wJAvPFjdD24OWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e33efEkXxZEyw/zVeXbp2e4ebwgTvGIWsaxRQ5vayxELyTaUhCZCRE3yPpXf2hpduvH6XTfE7pvAjwKDKHhPrKzdRj4P8TVuKHYtf3KRoJ4WzyZK1WYxvaYonJZ1/xucbg7aQXRcm9E2ARY1+X7a6IYkQqv5N4VJZV1YGCB4zMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sXoP4GWe; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxVKNWjDC+2dhCdlKUogGhA/7Zcp+tB23u9qFBhn7gDOvle0AsTicqLOhLV3zIO7koywGB6+M++94+L5bMQyFqnnzF/R242/eClNtZxW/lWNx38XrRnOOteh8wADEv1Li7T0UjXY03/NqpYCMs+KK3OBqlVoAJ1K80TiFBlchLApxmKGZ6zNbuHVQgMSQg+yH1A3cRhLuDQV9t6mpJuPqyXV4UUSAtd00M+WXrI36RkqDFhy1pNPqH4Uj5pHvwhVdRbbwkcH/svhB5m5CJ6LTJ5bszjK75MTRjjCeHvUeyq0tWJl0WjluAA3DBNwWaeKX01Dpd6he0rMCt4GwtKG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfg4dBKIC3Zfil42gpuoofN+BPB+hdfEIuvwNTO4J74=;
 b=DQ2PQwCUzkFF1+6ci7vCVmhWNe7EJtPSiu3bQQNgSoo8xmKuRkxh+1diWFnjt3h6KEEJAq1zoYiXJA3anFjBZK2SwVEB6cA9lHad+HBNRZQ0xulFLE1S2pYvVi5eC8siTAFLx9a4dRWniQd87C600RkS4INbBMpzHjBukI6Br8yiTjmlE9GEPOcuxyNKrQDaAF5TqFSDEm8p9e+vtRTUil5NW9fMYVGw0W+vhKEgJEvAyr8s2ZxvvoPoCuOWZJQSuAWwMz4Bp00qFHokE082O2RB3BiRn7/93iC+G1rfcSvRxnqO/oeGQuonzKzSj71uNp+RbF5c9SWEppCfM5lCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfg4dBKIC3Zfil42gpuoofN+BPB+hdfEIuvwNTO4J74=;
 b=sXoP4GWehzpRabFB3c4MFH4H6jmJy7KnwmeoGUdgOvH9FU5TTpgF/KI6Umt+NbHkxGBB5sG4iOriWjUOHCojIj3DLLDoDdyiNqJJGpYsQhj381xvRxg3/lQztfyxlySiuDQfWdAb4kfvoLNDV3ZUdLyAKCzc3RW25GzqibknAek=
Received: from SA1P222CA0167.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::15)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:37:43 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::cf) by SA1P222CA0167.outlook.office365.com
 (2603:10b6:806:3c3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 03/13] x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS feature bit
Date: Thu, 10 Oct 2024 14:36:55 -0500
Message-ID: <20241010193705.10362-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b330fe6-0e08-4f34-c7db-08dce96302e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Jup9iaUe/+PRvznZ5mUpPO0+CxH8WTbEPvRYq+eltDhmxvm3fpTX7+Unea1?=
 =?us-ascii?Q?ZGyVq8B+n79cgb4AJZLPWJH5DyovI8vLEKNm0Zqyp/NU+IF3qNOaRg8TK8wp?=
 =?us-ascii?Q?2lkBlCAo3LoRYPMG1s/fZM2gdW/iM0Qcjs4MV5tzKC4+OCCevPYCGPx7cEEd?=
 =?us-ascii?Q?g/4bQ8cEXksk0ZuEDCEmZZM/yXp6IULzAcZPLuqmG15BMs4efJpjFS4zcjhm?=
 =?us-ascii?Q?oqSa0EG8OCo1KL4EfZBG7Miu2D44yO8Ep8aCkeTgRipeTemCkvi0xGatH423?=
 =?us-ascii?Q?gHNWy7cxdHF0ghlFeAz+4UZkLCYmw3PQryDJNF3cSIH2Y+WC/NKd0ZJgmybs?=
 =?us-ascii?Q?y34kv8+/w0RxM4YlqnxNo4/YfS+ncf+bA3Jz6T5h64nUb2cwugyiQlOZEnSM?=
 =?us-ascii?Q?vp2dnOya2e51x6uiLm9VrP/9KUXNYdDDuqYfGbddVChVqBXz57hNYYC6NrWF?=
 =?us-ascii?Q?xHx+VmbAOlw8MT3ihyv67JS307ZnidVqXyA4afVUFQY2P4P6b8kpkgXse3GD?=
 =?us-ascii?Q?RX9S2rpQy2pTP+lp4y5fsRTC2uMaPimoc1GjYAtqtQlW+SyC3oY5sUmwiY7w?=
 =?us-ascii?Q?Sb9ixK9IMZrP/SkHdjgybON680f8qKR1F2EsfoqF0tWnXdhnM6aMvngUF3RY?=
 =?us-ascii?Q?LhDpTBLUv84P2BH24xs0GzZLxV8I4pN4fLq7LbG4innLJOsY3K7u1YeCVhCo?=
 =?us-ascii?Q?FoKjHVBo+0SO4z8FqbQ4Ci4z+J++QlPpDQeY/c2kT/m9pk1nlKn/VOAX/ekT?=
 =?us-ascii?Q?sKHxI0e+M3XhFQLkDr7F6prMHypKz9yuyuQixzHoR2daFLp7Vxu8WWYA7jRK?=
 =?us-ascii?Q?GmffcHFTPX2i9LRHfG8PYkliOtuFf0T1GoIixtpvQ4hfgEviTwnWNooXXydF?=
 =?us-ascii?Q?krWFwznzBBOPR6OYZPYyLZhJyCHfVlstlINhMSf84yDLrxOJ81sato2uCia+?=
 =?us-ascii?Q?KAv44RIG1/5PXaZmKIHO5LlYBDjgm7PskytevltRJ7Sp8Ut+Gq0Klzmj20F2?=
 =?us-ascii?Q?tt5xq6PKXR49VZ3zalmNLqmljUwgggl8drJGK0/BTpE8PsSyMku3ywUM3yru?=
 =?us-ascii?Q?VXRcMlaqiryYcZudatwaQBkNS3Uy06fVym+fsaBU54ah+n0OhK2wpAjp0lvb?=
 =?us-ascii?Q?PQJe2lO+7rdC0TGiNTGTOQ+1LUmS3nFWU69rd1ryfo3tUEVaItY+dWI/4wnH?=
 =?us-ascii?Q?Enkw0dWkBgwSOVtesqmxYEesuXgwszgltVmQXU+lLAZP4mTufN/t8Ow9pVr6?=
 =?us-ascii?Q?4+LYzhjlxezO6PdJWdARBNg3hT+K1e9XVlAorYG9YqbYY4zJ73QSiDTeAS9A?=
 =?us-ascii?Q?lKw1aHnEu5nJeIa8m7mS0n8H3OkTGjKd2xADDmDO6ZbjKlY3ONH5WD9+bwEd?=
 =?us-ascii?Q?zX0lX0bD5Ttjom+7w1TSA/rDozDs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:43.8502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b330fe6-0e08-4f34-c7db-08dce96302e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

From: Perry Yuan <perry.yuan@amd.com>

Add new feature bit that indicates support for workload based
heuristic feedback to OS for scheduling decisions.
When the bit set, threads are classified during runtime into
enumerated classes. The classes represent thread performance/power
characteristics that may benefit from special scheduling behaviors.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cea1ed82aeb4..3e8e67b8ec7a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -474,6 +474,7 @@
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
 #define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 3bba55323163..b6547bab9e23 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_WORKLOAD_CLASS,   CPUID_EAX,  22, 0x80000021, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-- 
2.43.0


