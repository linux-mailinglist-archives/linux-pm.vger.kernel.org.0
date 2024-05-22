Return-Path: <linux-pm+bounces-8036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B418CBAC7
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 07:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B202824E5
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 05:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B8C45016;
	Wed, 22 May 2024 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3itQw+nv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6018B1A;
	Wed, 22 May 2024 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357059; cv=fail; b=Eze/0vvCqOu9SqDK6EktJu+kpHqFPe8Llo/AszCH0QqWoD50ZpT1xgiq/77dAdrX/cp7TTUnhH0PFT1aOE2fKS2fxPRBVjdTPy62Pn+xxcvpb4VTwGM2AJ7CShq5kGLGcKyPSJXYUAhcuQxT42agtQegBtbl7omap3ftPtmWkg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357059; c=relaxed/simple;
	bh=lKOjHB47YJQ0aC5CQ1DH8BB3XhUSavRBhKJd9bjmFyM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RCPXcRKjO3KbQH2oDYkz/mn3PY8I/cVxRSCf6lzDT3EKF3of4TWpakziij/FRk4Jj+jzZJAjxZQtnugkGwI3I7B9MJgAnJtbRYrHu6jSfeewTNdjClaxyCuSaPHenhrsxEuY0a6q0P+3Wa090GbvkbFM5YYu6Z1YLIhLbC21U/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3itQw+nv; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy2hZSKrqDol1TBw9CwDt0Ip23f4jXX+BtYkfcst0ZChLqi8JWxSND3uEXmgtr8l7Y/BLNs/H2TfnrcF8edVpeS2AuwBy25HOUQJYp8A8upw0LncYzOwxPFkh9tp/JcWDlPv4l4K8G5VhGJlVYXIhsTPRxChl5pn9j+a1+jGvC3JtUxjQI9ZNMt7h6oHhh4V/qaAoVHVKDhrPdOkmFXOisElQT3ffuEScB6FR1X1dL0fJaFAx1zqIPYys4B2VgunUpoT/jsCb9i1JmY6Uq9WHU34XCKcgv4LurB/6dLiQ25okXdZ8lKcKKUbKzRaURAHryIFnQdRL+eRgUl/z4CFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y+uP4bKKvDJlWbg1vzjkpAC2r/ZZ4/3mqfjx2hJCOw=;
 b=jzSyQK9tnerwsRU6uck1zLXXTouB/btNc29MWbX/AN4eqCYwkpE+YxeWUiEDSPSjLs5gUkpLPoDy9I/Au7xzAIAQtEcKqTPHa33sam33sDlvNmMUoexqzZkt0L8npuipfnRzbLQnT3vA3j1JiA8kIKK5+FOA5XdNRwlLXH2hPSjN1wvy/xKmGjFoe8zr0Ks1/y2aLTnjqexGGP0gpONE7M442oTpaqzHSIxGLMX9HJtTQ0Lpzh2mVN5WXnBjYz0zNWnyGUXf6thgUZkiUOdXhpSzKrR+RdmgnJWpLJxbf+TvSZkrGLTYg+3Y5Hi6CJmFgH0zxk6ZC88Rg9OBEIxBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y+uP4bKKvDJlWbg1vzjkpAC2r/ZZ4/3mqfjx2hJCOw=;
 b=3itQw+nvui/W5bBAAvDDFROh0dzsOTcbo2t0bFpPf0I2V/EwXpUB9kb/63Yvbyt+l8ttAGpmEU+BfPEvL7sQQjjEE2B/jLfMIi557da3KXqZoCFI+ArpGByrElO9U8sh74/HHx2ihz58tARb2o2ZnUvTCp8PbgMEeIBzyKfzjgI=
Received: from BN9PR03CA0387.namprd03.prod.outlook.com (2603:10b6:408:f7::32)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 05:50:53 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f7:cafe::8b) by BN9PR03CA0387.outlook.office365.com
 (2603:10b6:408:f7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 05:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 05:50:48 +0000
Received: from jenkins-amdgpu-chagall.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 May 2024 00:50:44 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <perry.yuan@amd.com>, <x86@kernel.org>,
	<ray.huang@amd.com>, <rafael@kernel.org>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH v2 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Date: Wed, 22 May 2024 13:50:19 +0800
Message-ID: <691ec6cf79788e6db919965f787505434b072fac.1716356681.git.Xiaojian.Du@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ee80bc-f87d-473c-f0ad-08dc7a232160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SK82v3Gk+OQD5DdTBPfQHMuZ5shGcDe8/zLUcamegJYYI7jKTLgeQzfOTKJU?=
 =?us-ascii?Q?Q2rhyg5TD3InVGCqz9dH+BjYO3EUE0iWcxMRwU9xhYY14zaWsvFnmZfhc9bI?=
 =?us-ascii?Q?WABvRrNEPmRk2HXZsj7OfQ0e2oEmCoBgbKwRlcAHBOkf7qpulRZVohjODvXk?=
 =?us-ascii?Q?Rabwve+uLPGctupLQYFln8KduVlfyUsoV3wvP/68pLKd8P5zVZ72pUcNgvhC?=
 =?us-ascii?Q?eltoLAkLhxzqDVtsIcDesOzVVWplfovdmUHrn595Qg7PTPF+LTBh42R7PgAP?=
 =?us-ascii?Q?GhuVi9cg7Wrgufs2DDMXa7uIqcdSpce1EHpbzuJMWDf+SX5Z/8qsbW/8Sx5K?=
 =?us-ascii?Q?XQ47S2U8er21cRE1HDJAvSC4YtTxzFYd5D20AE5bTSeTDutukatvNzX3qOuX?=
 =?us-ascii?Q?w0HrnpAf6Msf8AtcchApgSy1MBfolvGoT8YjTWqEkfVk1dBgO1nTIeUvwMaD?=
 =?us-ascii?Q?+Wl62fJ5rsxggXIo4U3iEOt97x7PC3n88OyUYnfjdH6g0CO89f9Z/chZl8PC?=
 =?us-ascii?Q?nDWCpP+Jr98LdOHCNsyLzxBiHlYp3+VkETqPTQgXX0Ph58HVfAVviGfkxsT4?=
 =?us-ascii?Q?xUzcLUPm1iuC3Kh5qicIJi9AHpPkGH5qaBFxl3kwRvth/aPLra1mUElrQQiG?=
 =?us-ascii?Q?jA4pPjYokwj4ffFPkwwARl8AeNyqypPEzIMpYp0Fzcjy3jHitTPidBYKssAW?=
 =?us-ascii?Q?5T7nCopfxP81uOQmkkXlYi628SsmjbwTT5PheJmV+8YmuMKlWjnPLnQ2udHT?=
 =?us-ascii?Q?gsN7u5vFNQp3Gs1QqUbTVzo+EdM6uELhxrGA0/0Ok1QOpSUm2g/E7c258aBF?=
 =?us-ascii?Q?HGcBYeA6eHXCd6DCvUnkwdiZiU6kM+t8Rrzwy43Cq7K9shh17XAMUbjFzw+1?=
 =?us-ascii?Q?IGv1wfPApyOWzA4k/EfFkLq0maTfkd11UpXnWzvmf/gFxnC0J62MOD2+RDXp?=
 =?us-ascii?Q?SUe6wf5mNPk9rmfmpHCegVQ0FOJJo8OfSt2vdYO3VocivYbSA0WeCZV6Veeb?=
 =?us-ascii?Q?MEW+0zm0+uQFn5BSYRcNbtxyg/ZY2X+WrZBxDWTj9gmfRqNoqp/Mob0P4hjL?=
 =?us-ascii?Q?L3F19yJB0qqSXMzr5NqF17YK2cS4rnlRF0POwGDiLliaNKM7CkLr8WoWTiqp?=
 =?us-ascii?Q?IaT6/SXHTAA/rVa7PKvYG8UgwpiGxAE39NrdyCSyX0XvSRi1GJma7aL0DAEe?=
 =?us-ascii?Q?vIeQCMrIxakFWl+B3u+XKhBN9IRsH8bCmBnyqn5BOj7yZCq9G3dkh5rdLqSa?=
 =?us-ascii?Q?X0w6juJJlY2i0t6OWCJK36CkMrS9NNLJh6Xjb61TEI+wKWEZbj7N7wbiLwXL?=
 =?us-ascii?Q?C4yEv1LTgfcNv9U+w8jdOPcSDQr5suJCgDrW/ZizoemM+qZuYXb1Nrd4v0FP?=
 =?us-ascii?Q?b2dCm7+09GZcvaY546GChDGVRBpS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 05:50:48.1744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ee80bc-f87d-473c-f0ad-08dc7a232160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

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


