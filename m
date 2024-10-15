Return-Path: <linux-pm+bounces-15699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA5099FA3A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE2028519C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69416205125;
	Tue, 15 Oct 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cgUvaqPd"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DBB1F818E;
	Tue, 15 Oct 2024 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028253; cv=fail; b=SW9fT1c7W8yYjUy3lynIhjAdoDcnC49no/oPJH2Khr6Snt2npd7vLD2IOqXScmjVwimY9Eu5N2xkC4qaGZLXPs73NHFLnVC4NKA5y99VhM9q+2kZDFd5cLyl63e5hhwGtIouD4nrLAzbGi0oLDMIbog83qsojeLsEn0gaQKAMDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028253; c=relaxed/simple;
	bh=cc4FYa/Vuesa/XyVg3MKYbcElbdt0wJAvPFjdD24OWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+PMnFdcirRk85BPJm982gu7HAAqIUXgEXw6CEDzO614EJz2+usJ+Dx3z5YQ8zJBaZfr5NHYlG45+7mE8adMABJgM/PmVR5dnAIkwNhVt9bs0oAe/fnPx/aW85fWwEHyYzJNzXqpCfn2wqAyahH2REiREsOgIjmvLnJv5YDMaIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cgUvaqPd; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVqCKnd/09jMQzHMGilF4IfaFhqvGZnyhdr3x12B8657V7pl1LvPcxaQNR6nhQtlZxkyjOpuAXKOJGGYsTnOWocgRJcF5xR7qbt8601URmNg0Tuyc3DHAfOdB2SIcKT1KGaw8NbU4et9L2fLa52ajLrRYrJK7gmYWDxbU+t/SX5RtEtdDwlbXx1Q0QGlP/RhVV3S1K4mdeXqr87unUE1qFN7xyVmstC+DKoInoeRY56A+QkI7Ed35JIU6gpVbf7suyDbAZdd22KG868vCdjkKgXPC2jJypukLkOdimSeYGE64B6cXe6hKIhzJk3djd0ClPeJkdRb1+poQsv78RiVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfg4dBKIC3Zfil42gpuoofN+BPB+hdfEIuvwNTO4J74=;
 b=d0cq3dnG3KYBvDzoM61d9Y0Dtc0PszMjE1fP/oI1w7UHaoB97lnx0CdGqUbpkShT/IdvxdRbGCcTf+WBTiuufUm/cX9Je3McW0rSTTg+CecNNLNcDCfTdf7zy/Nky9bwkYCVW+N8hHNgGiQCZt5eZYB/BRdI4K98gFGxKEINnb7kTFCQ8bh5SSv/676RVq/N2QSXQwkK7sIWPiVpE4ds04pGfsV24C3vGbojtLexuGn+YMGNycGbvlHDB1YA8Jkos0qwHULlfrcvKFLELdDNR7Zz92Re9gU8hSJqCYTuuhZrqwAolF8Wau8a0QwBglXi7i6mZzfnajuCZ+hDH7kQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfg4dBKIC3Zfil42gpuoofN+BPB+hdfEIuvwNTO4J74=;
 b=cgUvaqPdutV2ezbhc9P49nIs3Rx0BDz7p/gM9vQaCZRQy1Fl9I0rgE7TNjndDtSHFg0WgfiWVPVh8+B+rXTTqYMN7hxcI7r9QIlZku6MNINy7KtZlGrISGNrgUk89fboqoMbus2vSKFAsK8bxbCAlAGq1mA+RpKjXWFCHYIYaUg=
Received: from MN2PR02CA0030.namprd02.prod.outlook.com (2603:10b6:208:fc::43)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 21:37:25 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::71) by MN2PR02CA0030.outlook.office365.com
 (2603:10b6:208:fc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:24 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:23 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 03/14] x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS feature bit
Date: Tue, 15 Oct 2024 16:36:34 -0500
Message-ID: <20241015213645.1476-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 367a10e8-e3eb-4a19-a36c-08dced618f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jYuDu1lqsDUp6CNz61WDL0HNiRz2lQDo4YPxdTTyGtFYYCJ8dzaFlNYiOR1f?=
 =?us-ascii?Q?skSXYEu6I8ud5ZpqLf07vl1J/+Nyq5KI0jeE9Vz+VEEWN8xUscBCffXWn3ju?=
 =?us-ascii?Q?YeRke00HnBEzYf9bsGhdQORxwRGVxKqoIgVHELEV6p88sMDeWG5oV1hfhLnx?=
 =?us-ascii?Q?Gu5cYVBPBPEcWjSPXIVU+Q65uVQHnSZLvEiVlLO/AL9v/Ex/jchKJmq5WHC1?=
 =?us-ascii?Q?dziAKKVGgodRffd9jsczqPDSRrqrfedW5rIN30Ic7u82a8N08H/x6BKD6e27?=
 =?us-ascii?Q?IB2AMxmnrXkoDW6lqdQsHyAk0xWj2tboFUzUkzLAb3Jr1sVCAqUCB7CU1hBZ?=
 =?us-ascii?Q?To4Yv+Y5N3INQtLKpUo0T3RcxmPcAwTZ2YanZL0C4Muj27w3ZYKb7gbfXxGY?=
 =?us-ascii?Q?H7eIfr9WT79HFT2xV7/XNgtfbsCuWzOTpLUZY+5FDY0ecRPyFEWjTJRU39Fv?=
 =?us-ascii?Q?5YTiLkEahWnf9dIkPPHyMzCMRrrs/O0AuiYZ/wbHfWhjpguat14iKTh+VXyb?=
 =?us-ascii?Q?vcdTMXcVI2RQlvqytzouu7rLZhTDBs/zabYw+0fkdlI95xbufAnO4xEdxwxZ?=
 =?us-ascii?Q?I7+fHsj9VvYizicqNFoS7B+1gZfpD7ebWuupa9M7ewg50TwOC+tcbaGhH9NZ?=
 =?us-ascii?Q?bssmWTPIlo/462peDFjg2MW/ln+UmXfzmZhdFnR8BO5WbhaMiMpKVBOtrUNf?=
 =?us-ascii?Q?NFAfrvy/08mYyk+w6Ef+j+8un3o3v0vREd899IKCUkaDuevtddkaE1e8TZaq?=
 =?us-ascii?Q?TWhsiXPCw0FhW7AmycJZ19B+zYZzcNK4zktyjSkrJ/GhymgClHPC0bN+KL/S?=
 =?us-ascii?Q?HiMPpCt9t+OFb/SznsXXq/P9wkTEjn9GHsGsSilmMRKR7O2knQpsOiUQpQiy?=
 =?us-ascii?Q?Tlce8jrSD4o253ZIpMnqsJo2btuJLcb56jqIpirlcNam8oEvbJ0yuKqRbi+n?=
 =?us-ascii?Q?9yMNQe86okKFOj5qWa4WyUnaoP2iUhWvh1nRdYnYzJk5+7ZrMOT603zldoXr?=
 =?us-ascii?Q?4Xvm9fuYiBmVedx55vLnmZU2tXKBDVK51TklD6o8uUCtqRI2HIcURCcTlpd6?=
 =?us-ascii?Q?j2KpwRjra+AGnZbPMpEGA7gSPtfmh86KJZkyl23KY86oHlb1wnnxLioMvliO?=
 =?us-ascii?Q?rBWFvRZW1F3qNsaf1rOS/Yv0AE+hMYLgIcdBvPXHBxix9u4UyP8Qgms1JH7G?=
 =?us-ascii?Q?FhC1oKaJvBLLY33z0wOgHocVodRVtyow9ipcBdY1wByKJ3D7wiv5GbKcdVMo?=
 =?us-ascii?Q?yTE+aOYhKU7umZMQ8E+V3LLnGMj1quEtZvezed3pxgNZNKN7b3MNpBS0SzNy?=
 =?us-ascii?Q?Uy62/wobagFjW7ps+g6BN2+auMQH7n+c6Rw7w+ab9zthS1T7askOIy0XGAIB?=
 =?us-ascii?Q?jkmaGC1mVk5a0CVQbPkqJP5WebIA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:24.9476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367a10e8-e3eb-4a19-a36c-08dced618f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

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


