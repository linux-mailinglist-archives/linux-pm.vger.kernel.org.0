Return-Path: <linux-pm+bounces-8926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C9903732
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5561C20D85
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E1A17B51D;
	Tue, 11 Jun 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T34zTJ4O"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6635517B500;
	Tue, 11 Jun 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096003; cv=fail; b=Acokuu63nkEy4kZUEtnlSQEWsnHQv9CCc0douJ2oKDhXm/y/dNUMde/Sc41mTcasFrFQoG0m+Gc9IuIgeu90aypYX/9hYbmj1fc1ebJrPvp3EQTuY4Cyqd1teKmGI9H9VSm/lJ6MyjqO+oOXHTBHmUrgUlyfXRABaWwfiQvl0r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096003; c=relaxed/simple;
	bh=W99zQEQQ/OGxxPso2jS9+4W6tk4N7XEGoGWIIlK+OCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZxWyIAkF9Hg4FOlP9aEqCa6kXG9EcVQo532GrWxjcOo4XT9aGiSWqtcBvSNRshgkL/+b9Fi1TLzOqVMBxJpo1M7mcATPbjYBvTFisRC1dPLraZpn/CYmNLQ8Ma4NFneYoIRCtGigOuQVOllu9uYPT8xfWh8UWvPaDCMfrVskrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T34zTJ4O; arc=fail smtp.client-ip=40.107.100.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RREGDQ86XXRfopZZqpzWtbMCPv10TX9QL9+qFUCd+U+ehB8vjcg+oU63+MkpDqcDq4Umz9yqpIdNMRSuE0Ep9T954+g1DbYLJ6eqv7sXZsb40fVpWN+jTSzXv+xtZ2J70tRzYuEC0cLQlzoISQjcgLpV77l2rbgF9L51H3p0OLgFWseC5eqiTTW04SHEismwuy3KtPzggqaaKGYrnKJWtC6c/+kQz8zSzpSm6ni6HcXRwrx793T1t7ucm87nGQYI0R+amdYBnh8l6VFtvLs6QAl7HjeifCZiw5SBrCAOcxlWn4ZsmNdQN4dQLY/txrro48tSv98Ue+kewP4DCiPj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRrjJrhZ9mOUhVW3oEGJa+meilMx3yjHSMrYjj0j9Eo=;
 b=cthpmEG6ah/VPx7ERKtCwZCwIcXMHwxNhJ/jkU+ezzIKVzXJZA69wZP/28IMf6Zjl5bbyNpqJzeSDE+1oNhKoyb0M+2rCbb0l7ETVVfrfNUPprFK2WWY0A/hXzyUUT2ZTzC5AZdmDbFpoUlifEM0IraDZ3SpWqjChZws2Fw6keMhEWPUzinjdRGWR/DUD64xyBLXHwRBuIS/qgRvgEKT8gfGTGzV/1mtpFJzpoh0hUqhqdKq7PPl+1QvkM1Sl0AshPvc7Tv5J6IFiClMqNjwlKwawUxZoyI4qrQF/qeStQg8tpgYSEyan4oKDz8hrrV1gUQn0Ckg9vfM8uY4qznS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRrjJrhZ9mOUhVW3oEGJa+meilMx3yjHSMrYjj0j9Eo=;
 b=T34zTJ4OdXiBnCyTzmfJjFdUtyxpSZHSM64XChK9u6FZcGw6YmxA0VppdYZIoi7uxFuP/WBUfXYgjoglu4Wtkcz0gQtIq10Hc9SFygFlRTe5DpUViw7kIvIkMag5WkmnrCec4EchEsGyhuJ0tbTyugNSlKIWKnX5BSmp5Ru4BVI=
Received: from SA0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:806:130::12)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:53:15 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::7d) by SA0PR13CA0007.outlook.office365.com
 (2603:10b6:806:130::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 08:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:53:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:53:10 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 09/10] cpufreq: amd-pstate: implement heterogeneous core topology for highest performance initialization
Date: Tue, 11 Jun 2024 16:52:25 +0800
Message-ID: <97b65a2294154dd469377a7a76ee738de7bf7aef.1718095377.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f3fad0-45b5-499d-53bd-08dc89f3eee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/THm7uoC8n3ANUyyXrUG9yp2GRC1vfWVEeu5EWDFMPI+SeX5bwnDD/RYeaD?=
 =?us-ascii?Q?icfgtYwAbGatDA6cSy9r3r612ryN+l9R/5zvzkKfGo+GZjg02nemP5mMxTgx?=
 =?us-ascii?Q?SvyNC55mqVl7jOljthA9n9xKU17lLSILpP7mbnuZ4egS+i4Wnindxl1+6WaH?=
 =?us-ascii?Q?2EshEOJlaBcOskgCrzeU9dJxA7E2SfoEzeXxDLZmamYWMSpFaGm0Hsl5OWTV?=
 =?us-ascii?Q?rwO1FC1edHoN/MOko5QKccGMoSIMpv61iuMsF7S1/w3zFHGbJIOd1tYROd0A?=
 =?us-ascii?Q?+L80/qOuM/pRdf8AHxB+xwSxQrqtyO+yqjVoC83z0kd0NjiE8y3hfFsH/+jA?=
 =?us-ascii?Q?G2B/VABWH36pjWpwG4lPfg79TL1nWmuV0gB0TEQGzXFe4G/CVlXgJj7IiSkC?=
 =?us-ascii?Q?EniigoJPdwddqycpabEz5zvPPBQBL+vpe6HY6skgewBn8UEox5LtgXXB/YkU?=
 =?us-ascii?Q?04hCoS0gh5HY7pCVLRJGoEMBZZyuspy2JjrSLiWXBeJnAmvgsmgQXNrdo/+l?=
 =?us-ascii?Q?eMPzyoeqLzk8nXMvzMilOzfKCJvG/Yj1ETB/KJz3jJMELny7O/MKg0RsbbFy?=
 =?us-ascii?Q?xBc1WcDTZcIbE8FcYI8ezziEvu+1QuM6AaV0Af+8fiPYb/QS7up+tuyamYQh?=
 =?us-ascii?Q?/GuS2XxP596en1c2q4oFV9bCjpJghxAWGyvIoIsyFR7InQ8DLcOYhOETP+nv?=
 =?us-ascii?Q?A5UbqKTDa6tVHdtg7oKbQpOsIHqU5SFQaD3Un40NpC3rY1lIf5//+wxDaO0e?=
 =?us-ascii?Q?iNFi58vm22X+k4RImRpRilsA3niLHALhiU+4AXcA0MDavLdq9p+gr5ENLJf3?=
 =?us-ascii?Q?ag0ny7T/TPwFKCuExJL/59JTMIhLfCEHDLaHnpRn9POGBCMZVxO6WD41PS32?=
 =?us-ascii?Q?+8Rj3jn8bWuMzETqd8eq9+TV/n68DszCN08MbXGWu1V5Ao65AZzBKBY7SKeo?=
 =?us-ascii?Q?r/c2gLpCOA95blztJhgLmrkoUs/igIhDwDSQxdAOlpqb5xkchSKuSYiav1l3?=
 =?us-ascii?Q?1B2bwbAe34yb5cUKrfq2l0dSpWbEUfEBkAHIJmT8M/5BeGSslaJ6kSuSoAnT?=
 =?us-ascii?Q?vpis0bTRGcd5KWVXcAmOLe/b3Gj038SQp+CXSwb/kYLEZzEySRidiYW0q5X9?=
 =?us-ascii?Q?lIQng8B2enIm+YSg91urhEpO6qqG006ILMIU8pSmRRNG8EdYUpIHzuIPVhY0?=
 =?us-ascii?Q?L93ZXWiZlAP62ZlCywPy+lfnKLTjRZE4NfOmvsJFnOLICyb+CXyOc7Yl8agr?=
 =?us-ascii?Q?1d7Sr7Xp+HCnkkiRejvDih3TEHHFrm8o+Hbw2WPAUsMsrjQKl2h+Zgx5WDZm?=
 =?us-ascii?Q?ULLyvsK7SYf0OUmZlACkuh8zAjoeoZvQYoqmn6heZZks9rM4aCj0hf+w5zLM?=
 =?us-ascii?Q?Iefcj3LILw0uDlht0iD45Z+XuzWFSgaCsJmjpSy+b4D3oIIoqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:53:15.6789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f3fad0-45b5-499d-53bd-08dc89f3eee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889

Introduces an optimization to the AMD-Pstate driver by implementing
a heterogeneous core topology for the initialization of the highest
performance value while driver loading.
There are two type cores designed including performance core and
Efficiency Core.
Each core type has different highest performance and frequency values
configured by the platform.  The `amd_pstate` driver needs to identify
the type of core to correctly set an appropriate highest perf value.

X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the
processor support heterogeneous core type by reading CPUID leaf
Fn_0x80000026_EAX and bit 30. if the bit is set as one, then amd_pstate
driver will check EBX 30:28 bits to get the core type.

PDF p274

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/processor.h |  2 +
 arch/x86/kernel/cpu/amd.c        | 19 +++++++++
 drivers/cpufreq/amd-pstate.c     | 67 ++++++++++++++++++++++++--------
 3 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cb4f6c513c48..223aa58e2d5c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -694,10 +694,12 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
 extern u32 amd_get_highest_perf(void);
 extern void amd_clear_divider(void);
 extern void amd_check_microcode(void);
+extern int amd_get_this_core_type(void);
 #else
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
+static inline int amd_get_this_core_type(void)		{ return -1; }
 #endif
 
 extern unsigned long arch_align_stack(unsigned long sp);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 44df3f11e731..62a4ef21ef79 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1231,3 +1231,22 @@ void noinstr amd_clear_divider(void)
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
index cb59de71b6ee..fa486dfaa7e8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -51,8 +51,9 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
-#define CPPC_HIGHEST_PERF_PERFORMANCE	196
-#define CPPC_HIGHEST_PERF_DEFAULT	166
+#define CPPC_HIGHEST_PERF_EFFICIENT		132
+#define CPPC_HIGHEST_PERF_PERFORMANCE		196
+#define CPPC_HIGHEST_PERF_DEFAULT		166
 
 #define AMD_CPPC_EPP_PERFORMANCE		0x00
 #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
@@ -85,6 +86,14 @@ struct quirk_entry {
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
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
  * with community together.
@@ -359,9 +368,27 @@ static inline int amd_pstate_enable(bool enable)
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
 static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
+	u32 highest_perf;
+	int core_type;
 
 	/*
 	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
@@ -371,7 +398,26 @@ static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
 	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
 		return CPPC_HIGHEST_PERF_PERFORMANCE;
 
-	return CPPC_HIGHEST_PERF_DEFAULT;
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
 }
 
 static int pstate_init_perf(struct amd_cpudata *cpudata)
@@ -384,15 +430,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	/* For platforms that do not support the preferred core feature, the
-	 * highest_pef may be configured with 166 or 255, to avoid max frequency
-	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
-	 * the default max perf.
-	 */
-	if (cpudata->hw_prefcore)
-		highest_perf = amd_pstate_highest_perf_set(cpudata);
-	else
-		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
+	highest_perf = amd_pstate_highest_perf_set(cpudata);
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
 	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
@@ -413,10 +451,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	if (cpudata->hw_prefcore)
-		highest_perf = amd_pstate_highest_perf_set(cpudata);
-	else
-		highest_perf = cppc_perf.highest_perf;
+	highest_perf = amd_pstate_highest_perf_set(cpudata);
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
 	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
-- 
2.34.1


