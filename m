Return-Path: <linux-pm+bounces-7755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4798C3A0F
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619E51C20C90
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828921386A8;
	Mon, 13 May 2024 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hsEtK2Qk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D91384B0;
	Mon, 13 May 2024 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566101; cv=fail; b=Mk3m5wohiTlKenX4puzeaY1t0ealEoiT90p6IJ4tzXyITNcKd/xcHEmF5GPVYTuxS3Nr6H4ct9gY4PU6Ul3aE9eqGuyDfvgGkkw9SzBPwzxx+Zvzzb/ZFBNP3nPedlKult0kX/q8RXbT2xkq/oFsTfbq4bWLPAKm7B9buM13ToI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566101; c=relaxed/simple;
	bh=Ro6TgRrZxMDVyKANqLunzjqR2DtiWvmP1ySZn+wS2XU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjTmihebYosn/vrlbn8zu+X181XfV7jTR81n+uUOomK+OPKb2+9KTHQeZfTRUAgXNcpEne/4l8A093tFHTdH2/FjjfHXCVNjCY4dGw6999vfWSG8e0/BF1YtB8yDLv0ofCBX/eV9XJwySitpcE17HtoYp04LGY7P8Vyhivr3euk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hsEtK2Qk; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxK0ZWvu1dd5s8iYwDSIOe8qL3V4n7oQwaWr3Z8BtPWmzOpg714txHdqLkhzZijz1jUs3QpgvVns81LPJcVq0+PRvgSUVhQTFxiB2igGUxHlwapMoBOAjUcDTTA7UZh+yMmKAJtzRrdJ590pcgzfk0WdO8BCdP0Hm8jxPEi3HQ95LcwL08E1jDed/LIDTpme7Ss1Uv6utqAnUB4yPMCSL+E8l30Q/qIhANdvCD/sZwH/WvduNycytpqO1Ym9YSVVNX1Wo7cOh/S5W+A6fYbeHqueic5/H2btZDizc1TK2DJoInav+6Wu5AD9akzR5oXNVd+T0BCrLbnwTKrbfhFOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGedl+dp/OW8SNhqwmcBSMmVSzYm+lFeij1pJrs+49w=;
 b=aIQJApmGKttWLq6TA51u2X4yB4ULyE4PWEbX/p+AjTZWnbPr1mCkb0oXJBEZSPdsGTvwyDk+Yy0O29eZqY45/IscbUFab4olB3D5PvqwomTTaUiQcVqoChf5NkiHL0D2AN9+5sCdUzVOVQPb5vWP0eBwDgaeLsnjaM0qbJBeSqO+QwzvuBcE7zZcilfbJpJVhw5HavWTkgSYdkEbE5lv8p9UEVgUVo8YdKy/A/U/NhJnRTWI+K9nnBosfV/AKfQOy1Lwj7y5hOeRXpUIFIHdI9d0ZfpCIr+UFDlGUS8oOSb0VoCrdjk4+ph6UZZvYP//1+lfDD6fkkCcKecFoyIluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGedl+dp/OW8SNhqwmcBSMmVSzYm+lFeij1pJrs+49w=;
 b=hsEtK2QkYEp1/xZAEi+L7f6xJ24SOWf1KH0aQG9aOUmfFv+Bbr6sKUV+SKTCwyumDY1R1hX6L28ptglV7FFyK3pdUjUfy2Tf2Z9Ph0FrS1ogxfyj0NWo2sfTd0rVgyKttsnRTCpM50mHtIFyiQ7Aze9zul/2jVO22XMuZmPFnTk=
Received: from SJ0PR13CA0185.namprd13.prod.outlook.com (2603:10b6:a03:2c3::10)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:08:16 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::db) by SJ0PR13CA0185.outlook.office365.com
 (2603:10b6:a03:2c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 02:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:08:16 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:08:13 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/10] cpufreq: amd-pstate: implement heterogeneous core topology for highest performance initialization
Date: Mon, 13 May 2024 10:07:27 +0800
Message-ID: <c632dbb4ee183e185d1fa408c7b5511765d1c711.1715356532.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715356532.git.perry.yuan@amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 71010524-b9ee-4708-d3eb-08dc72f18d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnyQURWR3WilfRQtbSfwpvlrpZCYofO1F/VCvYy/8c95VVYDCD2DlS/74Y5N?=
 =?us-ascii?Q?0At5RzCl/nHUJeQTaY94pVLdvnTAojC6Mh3K2Ve/2985q9s5VZ8fzRP2bxR5?=
 =?us-ascii?Q?lIQjQm24rQxEIhIqPNiWjz9M5+vC+eYGz4fbnM8vWyM7jDsoBQsQQxJ/7575?=
 =?us-ascii?Q?/cQx9HyPxLnFIyrjCwcGeZRyXgzzJxCDjw5NN+QwrG1c30YDTzUyxwIJy5PE?=
 =?us-ascii?Q?4Qun8d6oICURfMYSyZgELydi3hg+csRMz4WyRE7j3W9QUuZGkLB0ZaNYJpXd?=
 =?us-ascii?Q?+oS8qssrvY3YyNcANultJuwMLwIuwqdVU2k7yKx6LYdkvrYVRLvMAdFTFh8/?=
 =?us-ascii?Q?PpomVqF5eM4C6jRTqglHhVKP8prLJfgLqQwvSegYcQz01ig5dDwSAiAYJcMY?=
 =?us-ascii?Q?NOgxUYnLyWCxkzip+bNx+CEMoF+UtLt9prZodHPtxuR8n64iUE2JDxjD2y4Z?=
 =?us-ascii?Q?MbwKRvh4IbjzqKm6IbBHYPGgUaTlcNjufEwFuHvknDfGD0zZgd1Pxtn4OVmd?=
 =?us-ascii?Q?ABy5BxgyHSxrSZmu/u2cBNIFmW+Sy8XEYayBmnUOdlk/OFZSrz/A2o6/ersO?=
 =?us-ascii?Q?Ue6cFpcJ9EAmG91iykZx+mJYOiR8+oKMUS3IcEvo4GhaHUEFohpthfZg871X?=
 =?us-ascii?Q?3GV8rARebzNyfi7CTZd0ZcyLf31YZCp7yF3WTkR8Tchjiplten7h05xNfEKC?=
 =?us-ascii?Q?EizisXCNMn4yR6eIIOYlTKcL4yQaNrtL+g4NsJvfeCHimEjfKxy7R7eFu+sy?=
 =?us-ascii?Q?Ow6x42PVRQ5o+MjubzmBxVtfLzAtxqyCl4mtAbIBGLA6wSVQopGn9W5kLk0f?=
 =?us-ascii?Q?iNmkymtocci4hIfOQbJnQxgGrfrYeDCO6Bv+5PpLKPgkWd5nP5dyqLAHqeC3?=
 =?us-ascii?Q?a8eMOV4TKtAYMCJV2zu7QrMj8giL5epBG6YdZhZJT8x3qm1+jp8itURiidoA?=
 =?us-ascii?Q?NMdpunu0u3k6ColCjZAbLtm0a0qLIjpAVj9e4JnWShkuQ7I239aDIBlnZt8f?=
 =?us-ascii?Q?M69FYamQy1PdyMKRTBjmEBQnrtJu9AaLaPOf8a5NECEalxKqegced817Ep4V?=
 =?us-ascii?Q?aswKm9dswT/Oj3z5HG1i8+ds/ixlrtQFRD0Qirv0RFsxk4VZMkE1MdP613Hr?=
 =?us-ascii?Q?BQqRWp0Hy3puVR5hENqpTt9Fl47JA6HvBh88dSG6XQK0FDQTiDh1mG8pRFE3?=
 =?us-ascii?Q?gj+4+QzKn9JlydeQaaoUS6m4mLc9wwP4nIAW1Dk4sTeT9+EYkHmYxpyvQNMX?=
 =?us-ascii?Q?hjly3lQ7Op0S6BbdnJ6V063Q5+JsTQXrJ++r25Eax6vEVbY45BP7rlJKfw7E?=
 =?us-ascii?Q?9LIYlyKGDMEtvYdIFZEusD4hn6XcRtu/9OTLmcJbXdVIJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:08:16.3332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71010524-b9ee-4708-d3eb-08dc72f18d63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323

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

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
PDF p274
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/processor.h |  2 +
 arch/x86/kernel/cpu/amd.c        | 19 +++++++++
 drivers/cpufreq/amd-pstate.c     | 66 ++++++++++++++++++++------------
 include/linux/amd-pstate.h       |  8 ++++
 4 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 78e51b0d6433..04d30dd35d0a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -682,10 +682,12 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
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
index 8b8cae1b678d..dce901a403c9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,8 +50,9 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
-#define CPPC_HIGHEST_PERF_PERFORMANCE	196
-#define CPPC_HIGHEST_PERF_DEFAULT	166
+#define CPPC_HIGHEST_PERF_EFFICIENT		132
+#define CPPC_HIGHEST_PERF_PERFORMANCE		196
+#define CPPC_HIGHEST_PERF_DEFAULT		166
 
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
@@ -327,19 +328,47 @@ static inline int amd_pstate_enable(bool enable)
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
-	struct cpuinfo_x86 *c = &cpu_data(0);
+	u32 highest_perf;
+	int core_type;
 
-	/*
-	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
-	 * the highest performance level is set to 196.
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
-	 */
-	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
-		return CPPC_HIGHEST_PERF_PERFORMANCE;
+	core_type = amd_pstate_get_cpu_type(cpudata->cpu);
+	pr_debug("core_type %d found\n", core_type);
 
-	return CPPC_HIGHEST_PERF_DEFAULT;
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
@@ -352,15 +381,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
@@ -381,10 +402,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	if (cpudata->hw_prefcore)
-		highest_perf = amd_pstate_highest_perf_set(cpudata);
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


