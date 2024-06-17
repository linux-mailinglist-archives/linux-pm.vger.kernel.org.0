Return-Path: <linux-pm+bounces-9288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A2290A683
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C90B29905
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4219048A;
	Mon, 17 Jun 2024 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aO1/zBnC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415319046B;
	Mon, 17 Jun 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607650; cv=fail; b=e4X/o8N1oNwh2n/Tb4Ygnage8QvNFciknl1E7jjb2dW7bBgbItgYrbY3ggdXVPBL765w0/TjOGgyBpB0erGlB5Ad3mFMX1cBypvXKXn1aBKjfyt/gSiROz6SVARY+/vWjZ7YYH0yQSeD7IDrULKFTGuqYRHnX65f8q9XFLkRqcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607650; c=relaxed/simple;
	bh=tmgNDtPkmbXBk5PqhZse9dqoWpar+v9OUUIvKjoZBE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxpNAmXzy6k2HyLmkzt/FOdiqUaJIX80VJvEwdl67RLhgcY0DIQix3ON0fBEbdoYKia1gkN4L9jEXsJSrrLORu4bz3OzAvHsvxvaHQbznD5dmq2w/zP9CysuIQRt+UeB/RjR/CESQfFhaObkBZcL/9TS4sVpzy6kDajL4v4dsyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aO1/zBnC; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdWqblX6ctU/LA1sIYWQuQH14osXZltJiDdhYVEeIZ3T6avHY2FPJ70bbeh64Q5uPnyiyIOLU7zUJ01Glt0QU2L/WcC7Q89uHGEbItk9ewuY3MG7KIY1xXbsgFcPYROCakKJTBkeFd7IzqRprvpsg5+apGgSQghCAQNE5axdHTK1zb8PX3eloxXMwkgl6QOnhvbHTsc5SQsvWvLr8SSPRcVC1erf8VABRGV5YuEzwh35dBZPSu82qLAqUyQeuE5v8MQ4ZZkvvMPHkoBiF8psehQKmWD33KuCp75+THH1RSIs+TH1WZ1FzSrzB3jtUp+ypGC6fzqAZFsGFvQMoaVkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6wfCL5c4uf8PRKz7yLnBuJQO8q6e/5Y9WbXGc9qEEw=;
 b=GGp++9vPkX8yYTd0wROHIpA79L1pJhWy9fZUOfxFOU6UdXDfL+if9ozE8Zm+NT8TLf7FsxqoEhSaw+AcjPPsaAzgvSBzhrnG0Kev3qB6+iWEOs4qHuoDO+pp3d5LAk1PDO8l86IPe7jlyw04SWUnVMjVenhEzdDVN+jsIbgwjhOVCltNbfRNN8x9NQ8CRJjoQcC1D422RSzqyuzWQ5ZsbgZxnbevYjtns5qx0FC8IO1Tb5R1raya/Y+DAiFWIFCHTNnSWJVG/Auod9ALrtegquX4h1DtgxQQ24p+RZDTt6KOQ0gxj7Rd2JhaiYH3WxkQxIoRB4pOIhXGVMoXcYopIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6wfCL5c4uf8PRKz7yLnBuJQO8q6e/5Y9WbXGc9qEEw=;
 b=aO1/zBnCUjqoHiIYfXybUDibQPoC36WDa1nNhgsDAw3MFzKMzEZ+l0zHYHXepfSrqOMBM6SfKJo95x1XVIp4AfIsYWsFu+mdibORugsHS1A0jH/OnjyIOb0yuSFzzA8F7EAFtaFjjAunkYNFtCKxNaW5+pg1JXHNcpst09ul8Dc=
Received: from DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9) by
 SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.27; Mon, 17 Jun 2024 07:00:45 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::e4) by DS7PR03CA0310.outlook.office365.com
 (2603:10b6:8:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:45 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:41 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 09/11] cpufreq: amd-pstate: implement heterogeneous core topology for highest performance initialization
Date: Mon, 17 Jun 2024 14:59:11 +0800
Message-ID: <7aad57a98b37fa5893d4fe602d3dcef5c3f755d5.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 141439ab-084e-43db-0f0e-08dc8e9b35cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|82310400023|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hCf7AVCBuZHp+neg9JZuDZP5Lhb4yP2n2hvmILbZ0Cojq3IvvR7MCUMDzJRM?=
 =?us-ascii?Q?+cDfVE60xkCC7hm0Vn85P8XzOZYgmNxa7Qe5HFgM0qbo8TjLLVOOlT+ZN5mS?=
 =?us-ascii?Q?LJGW+8saZ5/tp4FK38IX79YmPT+A7R6Y2VelDnUfHxIL4T3EnQ/7LhGzz+lt?=
 =?us-ascii?Q?U0DMwY9+fDaF5FuJSumRwZC2l6lbOXnO00uAxe9+52rC7JAFQAx7EdVWML11?=
 =?us-ascii?Q?EuLNsqt0Hkfvo8wSbZQsuYrIrd9ANMO/fIjGloj8ssIehgMnhTb0R9iFdpM9?=
 =?us-ascii?Q?SfHxa2yNwpE1NSxYDM1NsbBfcEjAH00WZfPfpUwQMmJnRZWG/HKRqGjRCAiE?=
 =?us-ascii?Q?T9RvTmbDcS4WzJi4wTf2zgmy18/1Hlyv7wOqAzAVz17IM5v6B/q9lKBxG8Op?=
 =?us-ascii?Q?jPsEZABTLhPsbce6CU2xKC8u806W21MKhfYtk+NE+oONsm7lU8erfFsiP7je?=
 =?us-ascii?Q?E5n4cdX0ib+7djBcEOkcOZLM3hSXV6EF3KOmbgBmLqeBf9Ohzl5aVF+OVaT2?=
 =?us-ascii?Q?jn78TLbo2mYvxkzCWo4+F4hTf4rzPm1Qhl7NqXvvRcVFlwsf6QiKEi2kPyBr?=
 =?us-ascii?Q?NQplUcFqWPc3CQ9M9Lfjwx7z+/pZn89aQpWk1g+yBP98pKsJM3rQYN28N+XL?=
 =?us-ascii?Q?qhIBI3zSMfI5r+FQDp/hhrCv8hQCaoLBFXW5rI21aPPG6VS98btwuhsfKcQG?=
 =?us-ascii?Q?5wCShKALkKTwO1LzyC7SzBONK2/s6ghsPMOUI/uvA5sNbADsguKHUW1s/AJI?=
 =?us-ascii?Q?nrMuOcwibSMkbu2JWdtXUSg2oasM5Df/Ow97hdXxcGgYrBXzmRMS6j2RhZe4?=
 =?us-ascii?Q?lFVLJAAiRM4pmyWiKJ4H6xQwqiUW/MfS+QA5lizrmk7lFAknvpdv+XT7GMEb?=
 =?us-ascii?Q?ijigzZQpJ1jOezUxydvF6hGfWGjTHjjJMW+HAH8D/vZYENYA0uYS6xM/KlvW?=
 =?us-ascii?Q?l85FK92ZLdYmjDoNXCyZWT4AWk60/cpehQC4VIaM4Sj6iZydaKwz0gK8unAj?=
 =?us-ascii?Q?QiTQvhY2xoXDsdWollVbGwlzr5jPPxG2v+VluZ++Bcas0Fjp5OnU0RYZqb7Z?=
 =?us-ascii?Q?zbIpzDAHiZuCgO3Up3hFAc9KJ9d8MCSWIS4Ll0GLYLxZkv5sOq+dYk+WJtz8?=
 =?us-ascii?Q?eFIOEAs1L1Aa0h9XfQkd2dhaj+n4oobBp2XBZoR3W/+0YAt51zvw/mzR1rMc?=
 =?us-ascii?Q?rYL7JUBX/z3ji7D2h1xbG4w4a0yjjdHBH/VeFtNkKxnY7aY+0zIZd3Q2iIVb?=
 =?us-ascii?Q?m+0HLQxSO4jCXCrDAxKFXsgPkoaKLuYT7zSX8x8XwHKDK7IxYHYUtILbIVPt?=
 =?us-ascii?Q?4AzdhQ430taPrA+ZNE1nc8ixUlg5oEvW3i+DYvWXllik7ef/YKfVvlKdHnyp?=
 =?us-ascii?Q?KfqZ1aMcVdjE+E2J2zLvlESoN0wUjKHTzjYy7NBqNcI0FvI0mw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:45.2471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 141439ab-084e-43db-0f0e-08dc8e9b35cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848

Introduces an optimization to the AMD-Pstate driver by implementing
a heterogeneous core topology for the initialization of the highest
performance value while driver loading.
The two core types supported are "performance" and "efficiency".
Each core type has different highest performance and frequency values
configured by the platform.  The `amd_pstate` driver needs to identify
the type of core to correctly set an appropriate highest perf value.

X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the
processor support heterogeneous core type by reading CPUID leaf
Fn_0x80000026_EAX and bit 30. if the bit is set as one, then amd_pstate
driver will check EBX 30:28 bits to get the core type.

Reference:
See the page 119 of PPR for AMD Family 19h Model 61h B1, docID 56713

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/cpu/amd.c        | 19 ++++++++++++
 drivers/cpufreq/amd-pstate.c     | 53 ++++++++++++++++++++++++++++++--
 3 files changed, 71 insertions(+), 3 deletions(-)

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
index cb750ef305fe..cf68343219d1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -52,8 +52,10 @@
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
 #define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
-#define CPPC_HIGHEST_PERF_PERFORMANCE	196
-#define CPPC_HIGHEST_PERF_DEFAULT	166
+
+#define CPPC_HIGHEST_PERF_EFFICIENT		132
+#define CPPC_HIGHEST_PERF_PERFORMANCE		196
+#define CPPC_HIGHEST_PERF_DEFAULT		166
 
 #define AMD_CPPC_EPP_PERFORMANCE		0x00
 #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
@@ -86,6 +88,14 @@ struct quirk_entry {
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
@@ -358,9 +368,27 @@ static inline int amd_pstate_enable(bool enable)
 	return static_call(amd_pstate_enable)(enable);
 }
 
+static void get_this_core_type(void *data)
+{
+	enum amd_core_type *cpu_type = data;
+
+	*cpu_type = amd_get_this_core_type();
+}
+
+static enum amd_core_type  amd_pstate_get_cpu_type(int cpu)
+{
+	enum amd_core_type cpu_type;
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
+	enum amd_core_type core_type;
 
 	/*
 	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
@@ -370,7 +398,26 @@ static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
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
-- 
2.34.1


