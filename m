Return-Path: <linux-pm+bounces-8116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0398CEFAB
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2024 17:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8E81C20BC1
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C3657AE;
	Sat, 25 May 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xQlt1QYz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223263511;
	Sat, 25 May 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649753; cv=fail; b=Z4Fr61+7V4ngVYz1YOqObNTeaezm3HQ0dHFCQfkvv4V4kH8uyJjtg3goepOJ8fOcSrskj36Xk5o16IKRIxv+gZmnUWPTk+/OmX36FVS5Mf7Q0LDqrwZYt3PnZ1+LraaazgG2OQAbECJtaUndEpOZxOd7+5PDKI5WxrBawA0sNt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649753; c=relaxed/simple;
	bh=z42PCPTgR6kkZwq3AIfc2sdgterATTz3rS7NmCSy6GQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVrFyL5uoHocoqMcXEkF02gzg88VUA8kuzEnElz1y5SzvwWuJ74MvPV27/FIwa9soMcn6mkOJMkyTJ+bwCpzeJBfAkxLzAr86DtxB0916HBMeKQXL0sPaXdOTLf54wg4DY/N9zeVYhhQYoQ04CHPT1o8wwX+8sF5A1bp7jmMVe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xQlt1QYz; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2Fl3ZpsV0b772D4PB3nsY0T7LOAkvCSga/GQRyInV3N2OHrhjqC/R0GJvXdzwS5acaXb1Z2/ahWpU4kAbYcBDF/VFBTCz9miGsuovCIVptvCa6R461Yzb/gvq2DbO1cEW6xYmeW3DwJlYuU/sTQE7dHq6QrCKVlpzY6kbLs3m5AO5+qJYHt1XzpzNxi+wSOe7OyDk0a2PDV/2+n6TOUPnztF2HpKPZsove4VECTag2LhWTxAlhBJof2HrfOoq+k/q6uG3Owvlx6nnbNcytkrkvMsst1ZR/m+00uKUeY6L5hiMfspcd2EtXpmMFrgAu/TXq7KaFfXIvPjXLaluQmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjfupuBqvThwqT60Ng7knWgnSbYK1tIFFdheAfpv7u0=;
 b=Aa836QOIWOsZgVjPMBiwQ8tNOy3O5fH7CJaxEML27lVWLcp/dp/cWuSDYYwc3N9qf39irmJGd9K78Oru0DwisW/Ce4SO3vtKJE+AKS4lB20VyN+FlGiu3lESj4A1w3W+div1iX5OR2HU1QjRfY6loiMT13cFyDAVDD7CNfmXGXkksuhdavJCtzgxaxBtpTWS42X98sws1JvTUe1qtf6VyeftKGJNLaafiEW/pSVEzKYWZafRkDKvT7790w0zKKKQ5vLFSo1LKdyK/sVGBC1ycEfKu9CTVEL+d7IkKeTFGHb46WPyGKbryCpfY1bOrZas+JWTNiJxFgeMjszp6EHqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjfupuBqvThwqT60Ng7knWgnSbYK1tIFFdheAfpv7u0=;
 b=xQlt1QYzPYIi+KfrKk/LSSs6ggNm37YzKpJ1gaPFmicVDtaYkuWgZRxUF5WBA4w7SIAoB+LqNGaoL7i3ZFJ90zfRc8NOeDbXJC7X+o8U6GH0GkZog/gYjDG3lXI0w16bKdz6lYACjbmWLO5tD+4IiCjgGcY0H/nrU9ofSeqnhWU=
Received: from CH0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:610:e6::18)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Sat, 25 May
 2024 15:09:07 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::74) by CH0PR03CA0283.outlook.office365.com
 (2603:10b6:610:e6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Sat, 25 May 2024 15:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Sat, 25 May 2024 15:09:07 +0000
Received: from jenkins-amdgpu-chagall.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 25 May 2024 10:09:02 -0500
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
Subject: [PATCH v4 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Date: Sat, 25 May 2024 23:08:43 +0800
Message-ID: <e717feea3df0a178a9951491040a76c79a00556c.1716649578.git.Xiaojian.Du@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: bd23b300-d8f9-4b39-a1e3-08dc7ccc9fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lw+f7ByiyX1jFbL+GpsO0cfHUua3Gg/z07Rj1bBKELB1KhQMSh1WeeBwJzYz?=
 =?us-ascii?Q?aZvr4dF0wgknwT0eTLeO3QoJpQ6F6hI352YlrqhVdQRJoDEM3VSrk7jMErHC?=
 =?us-ascii?Q?8ocl0PSD6IOTh9CPaqieaFHq6KqWSWWMC0xwg1nosm+ZMHq6HP/LrVwDBehW?=
 =?us-ascii?Q?jJ5naOu/n6ycsbylXZTMI18/1/yBrMdg5+QQig14flaQ+3RUk0sYO1UkKtDr?=
 =?us-ascii?Q?KSsqFn1vFSWrQKWxYLo/UYgRgiS+u5ElRgggiFUfg7M/k7yNsGdUYpZ5N2FP?=
 =?us-ascii?Q?xeR/JBAUfFiihNQAmD3AH5mYROPta+QrseJJwRzeOEGogJNeV5aj/GegFSNe?=
 =?us-ascii?Q?T42uTNqgvtG0hxgb395njFEyXq/H1MhxAL/G4zdhgLjA0cLqzoHM0IH6Aug/?=
 =?us-ascii?Q?+AzU66ksbjB6EQk70QndG7asfhyN3pdCqGFAi9+NQJNb6OOqopCeSZcJxQr1?=
 =?us-ascii?Q?8vpjG/PBXTPjNp9tjf8EUrLZnn42Vt1KsoCF5vH5TYF2uMPaG2ue1QJnOAlD?=
 =?us-ascii?Q?D6Ih8x9N/45aV5DwBYfFA3yrQNQnxVanvMwBNVHnk5u1I5s7MPpu/v0LD3/l?=
 =?us-ascii?Q?7KT6CDrCZaLYQzYZ7UnD6fT86X3rkZA3cEYgkDNe9xCS8zEM1zKm2RVegu0r?=
 =?us-ascii?Q?K426cvOh2APHibBzP2eX2FjVNAaEMeyXdURCWlsYbJB9QwQiHi5demn+bmFN?=
 =?us-ascii?Q?vFpTImt+mD20QQA8Fkzp7J/FZIx9Y2PqBZhDvEyYAlcMuiNiS2NuVYVxO8my?=
 =?us-ascii?Q?IZnHghZFNX1pAPIZwLRypSzi7KfbJ/GjH5o43t37APnYWs9p+c5f6hVou8z3?=
 =?us-ascii?Q?wb63EGEDMMed7zwguDXMpcYyoj+FMnuKWRdibddcPNGGSJLpTSFaf4+tmDou?=
 =?us-ascii?Q?Ik6LMfNHgMVPQqpcKhUWg98R2GFa/IYmA6tVbC3Oz+guS3MTU1zd6pLo/Xjn?=
 =?us-ascii?Q?EVBvdUYYgs0BqeyZAqqZEBCui4IVsAwa0367x4WZI0AOPxsf0R62zrfVlCrA?=
 =?us-ascii?Q?1TSJBriHatbpTcTzIq3+cHzDq5h6BIT/Xsgd9j+xOeU4FaNWuYLluMjF26co?=
 =?us-ascii?Q?K8QbYL3a6prXx3NRuDcZo6qFbvg45Di2KlcZGbVHpxkq3X2FiHs3z6hoO7ir?=
 =?us-ascii?Q?xFrdUCmZ+lN02IoVx8d/IQrFTl7wqFcm3bIW3tIHNFzzxPFlnnDzWj5I+uN3?=
 =?us-ascii?Q?+t4eBbBkr7HUHLFjkY0FxNVZqcspxvIbj45TYTcB2zhrkNEvLyJgQ/0g6oRP?=
 =?us-ascii?Q?AZCQ3hcguP5dJbcLuDBCXkTdTRpdPZUvWbVAmEhZW5Z5WT/I8eYOwbBhcaAm?=
 =?us-ascii?Q?BJpO1/sFnYUzE8WZ299FQZ+GdZ2XB+bQOcdgzXNwmzb67LaDHKCz8EUzZfSd?=
 =?us-ascii?Q?hgFyvzpRwZiFvTW71z1yTjMBBPdo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2024 15:09:07.3942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd23b300-d8f9-4b39-a1e3-08dc7ccc9fbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336

From: Perry Yuan <perry.yuan@amd.com>

Some AMD Zen 4 processors support a new feature FAST CPPC which
allows for a faster CPPC loop due to internal architectural
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
index af5aa2c754c2..c84c30188fdf 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
+	{ X86_FEATURE_FAST_CPPC, 	CPUID_EDX, 15, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
-- 
2.34.1


