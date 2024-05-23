Return-Path: <linux-pm+bounces-8068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F3F8CCC26
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 08:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE22283955
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 06:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447513B59B;
	Thu, 23 May 2024 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kFzxU4d1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559513B587;
	Thu, 23 May 2024 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445062; cv=fail; b=Tgc2LTzb9T0fivOaiMkj9o0RGWyJiVN5V3HQg+hAz0Nn+egXEtGfrj1/f7gN7/GXdXsM9A3uTVrHsN8Lh/YRjQoCNWBzVxZeJktABi5g2kDKGX5WFv8Cje45926svG8AI+DKXVmu/wOsyP+XTSSL/UkA3w3E2jW+f+PvpEMMdrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445062; c=relaxed/simple;
	bh=lKOjHB47YJQ0aC5CQ1DH8BB3XhUSavRBhKJd9bjmFyM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j9vQqYzWOOJ56WU8/4WZhp5fPhyXXCBH8yacYO6NxTXHwmRHctpWIEjkuyeFP1zsama9o4t/fcUc0RxGdBIKt+TLoACjrv9UJ5hyEDT+f5ae6r6nmyFTbQxFfMU4hO7FHPGDqRF7cwoXcbNMxDZXNC9j7s6JQkivk2rz2gVPsLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kFzxU4d1; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVsAyvy8gQKK99w86kQwp5nF/TRS9AfUAVHW4iN9DI1iRbvgmAaziNT09syW1Rkv86A8pgFrpirIA7/aY4eHwP2IuOKeHreJ2OJi/ApekUTDVNNRuzF0AHnuii94PlGyT1IeKmHRbAD2aA/ay068J21RBiUdCduTaCOeq+04tYCq0K9FcAr//EeXtdq8zf/q+jjiv3u2o2fHpCij8jQV5QDU0pTCWQiHoZSqyOqDSHLTCCzgiTYqmnRMzhNUNMJGc30zDUzo3hRN+74P52JoP94uJ5PZgm2e3GCtK4AH8tmb1tOu6nHXoZbi+2ow0cReEO/pXn61LxyLvNfsGj+sAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y+uP4bKKvDJlWbg1vzjkpAC2r/ZZ4/3mqfjx2hJCOw=;
 b=LBVNVAdefPuRDA4Pjd5aEFulgg5sc3GwqJT5IauyyakBs5RamiB1bcb5mVEWnO8cWL6tZL3QUmOmJ7oP4WJvuNp1bkMD1oMF0LKAN93e3iSyeANYEkx5mOuHJpvFzhmjK7DR9x3RdbaMcJ7hDF7iFf2ZVXIjzRRkQ5qEE5d3NSwtoxynnWaeaj/P4JwiM+sGPRXIQTH/nXG3qmtX8PQ8R4fN1aINm3OoJKcerElUh2dKfSHOJrrxg0khVwtTFIO8uyQJsipRC6SrmuYw6xq96YmtZH4ttwp+IKaLk+LqRJnpOU5Hc9cA2eB1SHSlHKtQY74Gu3UBgSwjkIzupJd+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y+uP4bKKvDJlWbg1vzjkpAC2r/ZZ4/3mqfjx2hJCOw=;
 b=kFzxU4d1MxWXeR8vzUohx34f0xnBPNNnjsA2LCXrRQPnZkd40MonfV58Oa3OQCRxFmP4aB8L8NUw50zej19Hmf7/DAkmBqlVmQKu+gnieMvztPWZqXKbHYO5z2P+XCJHXJ9PoZqn3AUSMwEFVgz8dHhcOytb0fy3cEQdwBv1umA=
Received: from SA0PR11CA0093.namprd11.prod.outlook.com (2603:10b6:806:d1::8)
 by DS0PR12MB9423.namprd12.prod.outlook.com (2603:10b6:8:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 06:17:32 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::68) by SA0PR11CA0093.outlook.office365.com
 (2603:10b6:806:d1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 23 May 2024 06:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 06:17:30 +0000
Received: from jenkins-amdgpu-chagall.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 01:17:22 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <ray.huang@amd.com>, <rafael@kernel.org>,
	<Perry.Yuan@amd.com>, <gautham.shenoy@amd.com>, <Borislav.Petkov@amd.com>,
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, Xiaojian Du
	<Xiaojian.Du@amd.com>
Subject: [PATCH v3 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Date: Thu, 23 May 2024 14:16:57 +0800
Message-ID: <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS0PR12MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: cb61024c-c7a1-4e9c-c54d-08dc7af006b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hEqbtocABtSE6Njk+lMbj0TdTRdk2ikw7hBqtxR9jcq1d/pHgXuRPeGXeIQC?=
 =?us-ascii?Q?7wS8FVrKbRyhqjBIzTPdp+4fjyOZZ5wYBL2/b3iXAcbWOfV8EhbLMUDGMbFp?=
 =?us-ascii?Q?5+DGlqnpDscddJUwI2zrRPj0hQ22VxjgLbecGYD/Abf6aoKqNtr3igsS3hlH?=
 =?us-ascii?Q?3glF6tkQAPre31M9E4rHPHZrVN2LoCr4J3RzfrlNX5CMFL7IiUg5RXQmibNQ?=
 =?us-ascii?Q?h2q/dGl40+z1DRkDu1vDWwlYZT0Cf/TE5yCdiIsS2ltVUouopIKzXLhpZKaU?=
 =?us-ascii?Q?4LgBK+e1I2E/RNqfpb0CKpxIUc2KfPdlsIx6xhbfAbLv1rVZ94w928X57kVM?=
 =?us-ascii?Q?PH74yT/d/PA71AOehoFk7ucJIFe5xBqs9YRlPeTqzW0p8T5SbWkvQWoLqmo8?=
 =?us-ascii?Q?h5L+PwBS4Kf0GqvWGGRXl7Oyt2/MiM91sJEek78/Xgi/rmZhEaJkGsNGaMv6?=
 =?us-ascii?Q?/ZrAwJxWypV0jXFXVRQAWgphv/X0fPLhjmyPYDJ/WpdtHygPtSgHJrFeZmFQ?=
 =?us-ascii?Q?hx04kWE4i2kM3sjN0lCzdC0F6wytqtSCrqYAd6xscVbjrk4t7OABkagsqehU?=
 =?us-ascii?Q?XczmMMQngSjfYqJ9U3VYKH+YcJaNGE5WqzJRqvSLOqHkOQ8C/MYqzidI8p0G?=
 =?us-ascii?Q?ls+m5alpLCSRvgAe3wFh7BwH82TlNbdc3SG9ABY0rbg2UWpEZA/YVyqaoJC9?=
 =?us-ascii?Q?HUBbkPOtXHzeJn5mMwuYb1fOoABBrrp9XJDgZPzKittFzBNUR4nmbhSNwYGS?=
 =?us-ascii?Q?zsN1/KopQccyY1Ra9hg9TESl7JcMvgrWAjFBWqcLWxRnWSmEBG+0H3va2dbg?=
 =?us-ascii?Q?iDZDW4424+PMtDIP9m6UWN2DRQfOQeYq+zwCEI4QLVgDXdM8emnfOV3UM870?=
 =?us-ascii?Q?Sui4Kfr5OzLpQ+TPBdbawS9ADU2iC9ELtBckvHhkGTrKv4VGhGc9oR7HL8jz?=
 =?us-ascii?Q?lw5kycAREBbN84eEUb1uhxQnBIpFlbVUHVP/tVukdOcxAvYLdwIyP+UbjR+V?=
 =?us-ascii?Q?/Geqk8VwxFZj9hy3qNiv0FIrALmW28er8rq7CJCd834+yHfocK3QMDz4UOAW?=
 =?us-ascii?Q?siunM9UD502Q4PC26zwtmeAjtrLAhyTgZSQvN1qomWDQhHkCZ+JrXetbJ9Ke?=
 =?us-ascii?Q?3WipjhroYDY27r2+DNAFJrlITMurOpQFcRxR52gvMlf5X3IE2iKKf1hu6MMa?=
 =?us-ascii?Q?sJpJ5TWueYgkjdH6batYlYNvUPVCKRy8t5LajNha/bS9Exh89bSHuWYHyc+s?=
 =?us-ascii?Q?KKbqfT3ceae8LctVeSMPQzemqhcXfQUD41dnPL4usqH027zO08DTyPPrMdmX?=
 =?us-ascii?Q?R5g6cn/aREzQYIe2e+/+Z4HnSkBQBK8g3Wlh7MxsWQLzJjZPHk1fDxQ7GDgF?=
 =?us-ascii?Q?1880yDWAyFE1nZAVID7uLyBIyFHS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:17:30.2352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb61024c-c7a1-4e9c-c54d-08dc7af006b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423

From: Perry Yuan <perry.yuan@amd.com>

Some AMD Zen 4 processors support a new feature FAST CPPC which
allows for a faster CPPC loop due to internal architectual
enhancements. The goal of this faster loop is higher performance
at the same power consumption.

Reference:
See the page 99 of PPR for AMD Family 19h Model 61h rev.B1, docID 56713

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..6c128d463a14 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index af5aa2c754c2..9c273c231f56 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_FAST_CPPC,	CPUID_EDX,  15, 0x80000007, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1


