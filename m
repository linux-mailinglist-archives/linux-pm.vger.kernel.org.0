Return-Path: <linux-pm+bounces-7561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E588BDC4A
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99924283433
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D98613D28C;
	Tue,  7 May 2024 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SWu85vLU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89F13D254;
	Tue,  7 May 2024 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066184; cv=fail; b=gnQ18xjQqg9USPtriIajycXrnhNF7ZMCSdfhZZCQwh2SrAx6Wr5T1AHz/KcVq3Dpd4NnzYZ6KrAngTlu0JSD+CXZvhqcAIfesbAITpOD8KLJ3isgfs+4u/AYguKps6HkMdm2LabtRIDFlKcK9WeydvPulIcWkwiQkKlvLGE5TFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066184; c=relaxed/simple;
	bh=u9n9VSKXSgelXHISVKhJFIJou0knZpyuom1aaVNUA1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEsbnjSIT2p3jNftUky4OdlE9H2aXETXzXXpNbsWmgjAvAiPoEcLCX6KhDiq9DksH9N/GgV/Jy54Q8XNHJ0a5H2YO/m/eYs00pbmoIjpHM/qt1a5iqenMbq0cR5yJkm+WhKRTiygay24DmQmxFGcWKUfl76ip0Lf3iG61Wkfj0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SWu85vLU; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ6m0ycHRS6zLz/dDbpH1TvdijFNEtba2DhjDdd6KIvMqxPECPmSDNPY3UgXfeNEiTcPabPvyacK7+zXApHSroHPs0QWY9KXsji4yI37UUrd81Dx7GLDaMwwke/XrYcwnvTSA67BMti0Gyhs/hEaIk7VDhh5uu1T1IkEaMu6+0JnyF8F3/FXyBT1pIiqP0LEXWXYmYSGqFjkYTIB14u36dUFObD6/hIXfatlgrT5VJIEczKhZcCVNjcZwQg9xxAt3O34MgicCPjIo5qq+nhGuExg0XBVCntQEkgpMyXlLn5u00LbZaDA4LcnvCDRDktjYQKv+cXTw7YnRjVkN0kS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YStj2QG72WU8qakFXMgACbjQSIFUw5eEpm6YP1Ob2hU=;
 b=GcA8plV2dm/bc1ZabWboE/OQg/Zv0NK/ZxQB4Lopj16aJOdtY3F1qurR8Y0R8gfV1UtCQGT73/CzOE36VF7syECHZeyhPXvIdn1RmF/5w3FVOu4vCjmXHmgGhMQVkwVhAgcshLHilwn5qSAA9+pBBVxz1xWZEwE/mOxXS6MKnyYBMdWFB+bJgfrE9TYFUk6WpF27ClZfEBD0EIEn7ZJZ37ZIAlInZ+BNVj/Qo0iFBPTpo6kLMYkSWEWrrTpQg2WUIQ5oDSMBt1ktMeJ6tr3gUScoj5wLszBD15ONFPb85R/+UMPofldMjGY2PpK1GVXhlkFDiuPib+6qRd2R9umKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YStj2QG72WU8qakFXMgACbjQSIFUw5eEpm6YP1Ob2hU=;
 b=SWu85vLU9b6rh+5VpTu5JmmNZqZBYcVM2B7PQAFDcrKRZ9+blgm/znqc3Dyue/+VZU8UcadN4R3whj8hDe4GHS2fi2q+PXHFfamSStT7DE07fBgj5F4GFbmxT63w5PPEIKpCsgMtjbRtAFGf44fUgMGgfW72RYYfSaQ8L2RQoq8=
Received: from DM6PR02CA0123.namprd02.prod.outlook.com (2603:10b6:5:1b4::25)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 07:16:19 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::af) by DM6PR02CA0123.outlook.office365.com
 (2603:10b6:5:1b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Tue, 7 May 2024 07:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:16:19 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:16:15 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 09/11] cpufreq: amd-pstate: implement heterogeneous core topology for highest performance initialization
Date: Tue, 7 May 2024 15:15:25 +0800
Message-ID: <731a28ea8dda4ca1db64f673c87770de4646290b.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 496c1030-cbd6-48c9-8393-08dc6e6597b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zr6V89/jx+7+JpTuLEDGLHKDVG0hY9HQmE9buP4SOD9tGUYWeeDV51BezQh5?=
 =?us-ascii?Q?dBv+YO2YAFc0NozY2TsRgNGYLS8BXJEQgb23SQHxTYt8hC4mQN7YLmGE2ZIE?=
 =?us-ascii?Q?eBYuRh/3TkltjL0gEQVi63A1GCmSSR1IxKyuTmHmBFVZDPWgOeBc5hMmAf4z?=
 =?us-ascii?Q?x0Q/r0X3dsX1+DDW30OgFOrWbVjd7SpN8C74B15i9Q7T9RXa3C11AwTFLw9G?=
 =?us-ascii?Q?hINSAomRpXcmeNi3JU7c5Kupii9ipLnCg1Dj/++WfHH8mdRsvV1DM3J/cYbL?=
 =?us-ascii?Q?aKLAVR9XUA2OnjC6oNAeQ5eLvgPLHS2Ids81/beWQQ94AOlJTrr1iRtWqMUf?=
 =?us-ascii?Q?0QvTB8UEojEQ/jSTdLLt7ueC2yGbraRU0TFoouaRYBkxXbWlVn04XFQHCZxs?=
 =?us-ascii?Q?Q5IOYkfW4iPYTorzek9wO7PjhbNkGREtoA3N5mrai4WbRGvgkfjjcPBjhpEI?=
 =?us-ascii?Q?hDJICr0PFRMKWWhg03gtq6E78Z75JvVSTYwlLCRJRdULIuvlSdVOczIDM3Zz?=
 =?us-ascii?Q?0M28ECpIze3J751sG9Lk6kcIEOUUVDYT9alrZox4CRc9lO6Pdo7C7F9WPD08?=
 =?us-ascii?Q?BbGGrvgqRoQPhtcPnE3Eyuru094qVAmPkvoVGNRhakTA5bD9AN3zLgkDmeEK?=
 =?us-ascii?Q?XkwoNPNjUzE8hPNx9uPUNtePcymkwVRQTeDLHwkiZjo4eIffhtLog88tIfZ8?=
 =?us-ascii?Q?pStVoKVvUS/SqJweZAn1sCKRXo48fNbavCXt94sjRuf7T0GXvvMaf3ESJNy9?=
 =?us-ascii?Q?w2OT0tvfPk6/viW5V+RqFHDVmdnJGDGrfJ5MMfvKE/Hk88VvuUYbZOoatGke?=
 =?us-ascii?Q?Pb8+9JL0Fz1icHdAg6u/J1L6vGnN2IoU0+7fcPOnd9Gjmi9t/x3AlOyxeCWV?=
 =?us-ascii?Q?IbJ6wCB2NRYbk5VhO2VgNw0wELVQDb0ItvbKZvgKbN+GS6V0dF9jRqtYN6qj?=
 =?us-ascii?Q?ZpRzYBjM9KcHenYao3kBuEBKghXGS1fYojRyLLZgmHc5/HNLca/VvxY5rLRI?=
 =?us-ascii?Q?IDbaQo2DkdyoSkxXZblbYKYOnoSaz2kMIk3gyHxuFLMk/LjCxE8pQZKTcNgV?=
 =?us-ascii?Q?5riFz22eV4pw3P3OUlB+WjqxqMvEwiKVRERzNmMt1npRidcDrFePNbkpTd8s?=
 =?us-ascii?Q?EI6L88TkOW/gud8LrrPU4ihV3/jw6v47Nwic7VWFkqepeIvVtw3e5rY5TMaO?=
 =?us-ascii?Q?uZn+oiscMael+3PEAI3U/liRsy6sLRldHZONnJZiDJy9rQgAhWjmlcK+WvPn?=
 =?us-ascii?Q?9RkQW7z8PWAtvoYP8Z3H3WqWdmaVHF3bIJ8vLBKTVhOm9iQ75PcfSlV6e17z?=
 =?us-ascii?Q?nwco+1yGUu7V6IvMMrLeoC70faM4d2hzPe3kD77w3ocZOCZbZVgxuhg8Ga1K?=
 =?us-ascii?Q?hEDaBnORK+wZMyUqRCcvHPOhD7Ja?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:16:19.5256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496c1030-cbd6-48c9-8393-08dc6e6597b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158

Introduces an optimization to the AMD-Pstate driver by implementing
a heterogeneous core topology for the initialization of the highest
performance value while driver loading.
There are two type cores designed including performance core and
efficiency Core. each core type has different highest performance value
and highest frequency initialized by power firmware, `amd_pstate` driver
need to identify the core types and set correct highest perf value.

X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the
processor support heterogeneous core type by reading CPUID leaf
Fn_0x80000026_EAX and bit 30. if the bit is set as one, then amd_pstate
driver will check EBX 30:28 bits to get the core type.

Value Description:
0h Performance Core.
1h Efficiency Core.

https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
PDF p274
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/cpu/amd.c        | 19 ++++++++++
 drivers/cpufreq/amd-pstate.c     | 62 ++++++++++++++++++++++++--------
 include/linux/amd-pstate.h       |  8 +++++
 4 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f131f4..30d1900bb7e0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -683,10 +683,12 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
 extern u32 amd_get_highest_perf(void);
 extern void amd_clear_divider(void);
 extern void amd_check_microcode(void);
+extern int amd_get_this_core_type(void);
 #else
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
+static inline int amd_get_this_core_type(void)		{ }
 #endif
 
 extern unsigned long arch_align_stack(unsigned long sp);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 307302af0aee..67966bdcde65 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1219,3 +1219,22 @@ void noinstr amd_clear_divider(void)
 		     :: "a" (0), "d" (0), "r" (1));
 }
 EXPORT_SYMBOL_GPL(amd_clear_divider);
+
+#define X86_CPU_TYPE_ID_SHIFT	28
+
+/**
+ * amd_get_this_core_type - Get the type of this heterogeneous CPU
+ *
+ * Returns the CPU type [31:28] (i.e., performance or efficient) of
+ * a CPU in the processor.
+ * If the processor has no core type support, returns -1.
+ */
+
+int amd_get_this_core_type(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
+		return -1;
+
+	return cpuid_ebx(0x80000026) >> X86_CPU_TYPE_ID_SHIFT;
+}
+EXPORT_SYMBOL_GPL(amd_get_this_core_type);
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7145248b38ec..7fe8a8fc6227 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,7 +50,9 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
-#define AMD_PSTATE_PREFCORE_THRESHOLD	166
+#define CPPC_HIGHEST_PERF_EFFICIENT		132
+#define CPPC_HIGHEST_PERF_PERFORMANCE		196
+#define CPPC_HIGHEST_PERF_DEFAULT		166
 
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
@@ -326,6 +328,49 @@ static inline int amd_pstate_enable(bool enable)
 	return static_call(amd_pstate_enable)(enable);
 }
 
+static void get_this_core_type(void *data)
+{
+	int *cpu_type = data;
+
+	*cpu_type = amd_get_this_core_type();
+}
+
+static int amd_pstate_get_cpu_type(int cpu)
+{
+	int cpu_type = 0;
+
+	smp_call_function_single(cpu, get_this_core_type, &cpu_type, 1);
+
+	return cpu_type;
+}
+
+static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
+{
+	u32 highest_perf;
+	int core_type;
+
+	core_type = amd_pstate_get_cpu_type(cpudata->cpu);
+	pr_debug("core_type %d found\n", core_type);
+
+	switch (core_type) {
+	case CPU_CORE_TYPE_NO_HETERO_SUP:
+		highest_perf = CPPC_HIGHEST_PERF_DEFAULT;
+		break;
+	case CPU_CORE_TYPE_PERFORMANCE:
+		highest_perf = CPPC_HIGHEST_PERF_PERFORMANCE;
+		break;
+	case CPU_CORE_TYPE_EFFICIENCY:
+		highest_perf = CPPC_HIGHEST_PERF_EFFICIENT;
+		break;
+	default:
+		highest_perf = CPPC_HIGHEST_PERF_DEFAULT;
+		WARN_ONCE(true, "WARNING: Undefined core type found");
+		break;
+	}
+
+    return highest_perf;
+}
+
 static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
@@ -336,15 +381,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	/* For platforms that do not support the preferred core feature, the
-	 * highest_pef may be configured with 166 or 255, to avoid max frequency
-	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
-	 * the default max perf.
-	 */
-	if (cpudata->hw_prefcore)
-		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
-	else
-		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
+	highest_perf = amd_pstate_highest_perf_set(cpudata);
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
 	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
@@ -365,10 +402,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	if (cpudata->hw_prefcore)
-		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
-	else
-		highest_perf = cppc_perf.highest_perf;
+	highest_perf = amd_pstate_highest_perf_set(cpudata);
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
 	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d58fc022ec46..869d916003f1 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -134,4 +134,12 @@ struct quirk_entry {
 	u32 lowest_freq;
 };
 
+/* defined by CPUID_Fn80000026_EBX BIT [31:28] */
+enum amd_core_type {
+	CPU_CORE_TYPE_NO_HETERO_SUP = -1,
+	CPU_CORE_TYPE_PERFORMANCE = 0,
+	CPU_CORE_TYPE_EFFICIENCY = 1,
+	CPU_CORE_TYPE_UNDEFINED = 2,
+};
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1


