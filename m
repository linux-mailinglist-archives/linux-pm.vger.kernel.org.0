Return-Path: <linux-pm+bounces-7560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E568BDC48
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E851F24D81
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4E13D24A;
	Tue,  7 May 2024 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zvRnzfqP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A5D13CAB5;
	Tue,  7 May 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066182; cv=fail; b=q5U+2SK3PLivxkKu3APK+98ON/dcn5v+UBLP7yglx3ZtfBfzmAvG7xtV4DwCHCuXMd7RSsolGD1TmXp3DEdUj+QUgxejlSHJwcWwczl9ppplX7fWx+12S+m6GsgKKBJN4HT/sHC0Ap52ITJmJiX9VeVaHs/On93jmqeQCkiW69o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066182; c=relaxed/simple;
	bh=nJ9cx9bDKy29WZBCgELY0XT2ZBaN0k8Q7mQhwVLq4g4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOnxYQrrFeBStF2YiLIB1eiRwltNewqb0Im5qcN9s2fjr7CHcPfdFTHX3B4EQyPpQnuFrPb2yTlqh6EjAeowEmSxkNSHpyvq8WV5MABnWuvXxYalJsDdk7xLadTpO5pip6QIzS2icoVoTqUYSe6riJhg1yLjkAsh3mf1RDP8ww8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zvRnzfqP; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsTOy0F/QawXMCrNxepw7lKoRimRyiiv+OkNNWeUfXyIvA1YYa1CAdBQEIV2Q0Il6YGOgTHe6yJNc3lo9I1IWCArxbJvlzkm3b5SSnR+kGGomGMg1E7GiW8hZUwEKXHZ1VWJPL0CO5YAlX1VQL0joDLVbBH550hX7+CO2vZACN4jrdrz7nMfdy9e7gTos4QUMaC8ydXHP07C3I9OvTMamzygsdtgm4Vn8YALopDIs95Qe8xYUOMFMqmGirF4uMu7yX3xgCgVmTgNoUsjGnLxtDvbYgQLtWSLOY7RLl1yWu85gHQlIkqBd8qs4ZoTwbBbB5SsTkHmspxpj1GX3lVhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6067HVF+J0DG+ofMoXQG4B7S9A1I2NXiUJHfzJ1YYQ=;
 b=meDVkbamu9Yfj8VkTVWCyhcUdgePl4y/7iNyCEMp5uWlE7le6dHqPRc6YDpL6FYoPfeAKfJRfwYylXX3TdDw9E6ZUeH6wMUUbIdSoJJxs8NbpPwiv97lguNeOCbtuG25grXpagik9grScLDBZUMcd1SPlWHQJfbx6/2+ORp7EcgWNRvLJfzlv4R5eH4en0FgUDaHpz52PoHdBwfe0WwUQ0t5gpFzwfDaJDrAzIJ74zjuNvNveUZuxiTpXUAGz3b3Mt7dUuLsOXEtNwtH+sXXPn9NCbUI8AvlSLC3mnp4IgvJc/rOgbqGALalPX4YqBVlLuGIj0KD1qPMYkUu2O6xUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6067HVF+J0DG+ofMoXQG4B7S9A1I2NXiUJHfzJ1YYQ=;
 b=zvRnzfqPgB00jRwu4GjyfHCaAwDrDUtp+p5w7t55GwGXGQF7GlAVaGUTWkjSYeduC7JroO5pczRK7FICbfLgs/My3Bpl2FVDFed4kr7afrqOu8D7ttTHrCkgKL+qpFWN1DEndm9+if9lv5ynDyW7gUgVBtk9n39DpRMASbg6YlQ=
Received: from DM6PR07CA0078.namprd07.prod.outlook.com (2603:10b6:5:337::11)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 07:16:17 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::f8) by DM6PR07CA0078.outlook.office365.com
 (2603:10b6:5:337::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Tue, 7 May 2024 07:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:16:17 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:16:12 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] x86/cpufeatures: Add feature bits for AMD heterogeneous processor
Date: Tue, 7 May 2024 15:15:24 +0800
Message-ID: <1e26b7da73e0ba2ae5e85ad55d593b7507f3663a.1715065568.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715065568.git.perry.yuan@amd.com>
References: <cover.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0c054c-dbfe-49dd-57a8-08dc6e65965d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZNirWoyqw6GNF/suoRuKKG5xYWTqG2Zw/O36rBurlD0N+YlNSJKqJxvH0WHf?=
 =?us-ascii?Q?liCXrG7xkVmlb6GnNGcHeuVu8Qgg2Vvq0bm7j+5IQ+fNwz8rdlmdX/EsmLV/?=
 =?us-ascii?Q?od3C3BsTlZ+c0htWxmxjMQDEDkTtJehp6Mi4PzCJTD24ndy6v6tt1QWUMxmm?=
 =?us-ascii?Q?C+tsHXQamtKJM8HuPdJzf/kmFkNDCJWR3GRTIUQ2lCZcR7krUeL+bH+fGfzc?=
 =?us-ascii?Q?c5g9gOddYSNmMOpSGrolSl8K7TM8G7pMPV62VKfcprHWlPcK1axBfWQ+MfBq?=
 =?us-ascii?Q?cio68Taz/hf/pMH2BlO/W5RAell7xxljkbf7ZZGtA2IeaOvziF59DBxjWjcu?=
 =?us-ascii?Q?cIR/W2HQC3NoZ/f8VitPwto2VZlNE3/8wiHyhkhEi9z4Pf5bqd6S9/30WVWa?=
 =?us-ascii?Q?kHbK8q0kQtiRhBs3NYTbvQL07uM+/q6leF5EEzL7zdELZFZwIY9v5ThfBl7d?=
 =?us-ascii?Q?cFLxphT4DBZ5ed4ShAKMDWl0K07oSS06DoLELHQd2seyS1znTFkqeTiChg94?=
 =?us-ascii?Q?d4fkXXtrMFn55dKlekcqFImse6IhGJL2sA2Tb6IlYS0fJFpA1hWij+uRzVpy?=
 =?us-ascii?Q?7HR/d1/fFKKlYuL1/8iznc6GOvd0ccOjN7zx9/e8CQC9TYBd+lZxgQWliIVQ?=
 =?us-ascii?Q?VvSFqQNDC2HbtpzQnpigvqNd2fmERTyjpRz/wV95N/Y/2+TuIQJ7z++pBCwj?=
 =?us-ascii?Q?1zUv1jG/yTgB09SSMfJX17lbU/luMuYK3JoBNDw3mVRQd4aBrUS9mUxlZSFS?=
 =?us-ascii?Q?oqHBMUAvIvdD6vRisyMLWHNazKliiHRtxH1VwcMmNNreRX2MWlnfGGBTpSrS?=
 =?us-ascii?Q?7EQKz96Kujj77tJcbp6LPdOh56suNmaKHpjWs2u/F3XcNMhBhHh9eaDvlf3V?=
 =?us-ascii?Q?9JpAEQuPw9LWdlVBDg/k6VUsw3Hf6TXWI2EGQwOnjzEEbjR60LbzmqY0jY3k?=
 =?us-ascii?Q?n1C+5AzQhseYmwLa+HyuHg+fGc+txFNIqnFfDqwDRTw6KfvVqxKIK9wfNLW2?=
 =?us-ascii?Q?lOhFuYisigAt1sNs9/XHGpW20NZ/gPyp8Kkcpgn3Gdh+eGsMQHo5Teq00hTi?=
 =?us-ascii?Q?kR2GPSBz0nI/ZbHN41NYVeuwG2LBZNbTo+va0+QF+lNB7V52KCuE8egla2f6?=
 =?us-ascii?Q?WVcJqKvtpmQGPng0Xjmg0RTaJLJF9J9myt8lfXIicO24l0ZoISaZxbpy5emz?=
 =?us-ascii?Q?fPy9M2M8h07/5LtmJKGwLyhx0exGELK8gq1T7upmH35Aj+e+p7uqkmWarijc?=
 =?us-ascii?Q?GmVQaRZBup3UqlHKu1bF1WwBbWHJAhEr5m031zB6lEAs7oh5yxu1ufT/gW4/?=
 =?us-ascii?Q?m9PlsoRzUej20g0S7i2EfbxDDt6kICDeWblciTYqDCQz/A7OhHQQA3VfQ/b3?=
 =?us-ascii?Q?6oRe++K/wnb6j4u7pAw1mKO3cMiw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:16:17.2438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0c054c-dbfe-49dd-57a8-08dc6e65965d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946

CPUID leaf 0x80000026 advertises core types with different efficiency rankings

Bit 30 indicates the heterogeneous core topology feature, if the bit
set, it means not all instances at the current hierarchical level have
the same core topology.

For better utilization of feature words and help to identify core type,
X86_FEATURE_HETERO_CORE_TOPOLOGY is added as a few scattered feature bits.

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
PDF p274
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..39a92338c015 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_HETERO_CORE_TOPOLOGY       (21*32+ 5) /* "" Heterogeneous Core Topology */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index af5aa2c754c2..9e237a3daf7e 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,	CPUID_EAX,  30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1


