Return-Path: <linux-pm+bounces-18650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1989E608E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1321188471B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CA51D5179;
	Thu,  5 Dec 2024 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SWOt6RV+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139481CEAB3;
	Thu,  5 Dec 2024 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437752; cv=fail; b=g+oV/aKSADnVgVNN+qtduKlsht/4adjMUSERaS+4KQY4Sz0UJmoLPGbZUd+MXsQVpIVCgbknYdoHGvpkLssT+TXunXeeJe8TxvyfgNHnxleF2miogZKC3AdK4aFcuuXImLSpyZcdiNUB3+GCCYOvrJliYlx3MMslukjXs+OOldY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437752; c=relaxed/simple;
	bh=DBlPCdvDzy/Bu1Is2GTVx17kVUsXbjOrKnTwA9xG9mU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZktninw32IYNDdFHCWh95Hexn0S0Lf/W9Idrq9gqpYKAyJLUiratz/CIt6sEDrDKDEQ445qvN5J2Lyp9vjAX8jXrrOM6U2uEF5WXhYKK0YH7JUcGQvxPKLaDoVN2Ntv40LqfOM5JcSmgm9tc+YPvYh8X65yL/WQh9xjP9SPtig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SWOt6RV+; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPDEmvIL1Pc4f+iajIQnI2TGhKcwl4U3uwzXFLPUlnMJBGnmEjQv070YA2Ac0hMQbdDXL/s+cT5Wl1WSCsrLcvjWuraFmcair8eBIE/cypmGLGRs9fx16MlUfY08pdCTtfcVAJvpxxsuBUbsX5ECyAbpebBXlEIc9CB6iRhABU5QBZY0BurzTOZ2Qi2J33wfNsS+2YMI7mngILMWMR5VRgEPmoDfsFgP3LD2uhaB94bNvJzpWyPcFbfBHV4q6834v5qisM2dVBwTZLmO2PcDFvmRcTIkKe6Rrqjn6k9SH6eqMSddWHjut3OZNYxoxVHPXsEN1kRkpyZLyg6wXOmSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZkUsT3oTfLn+Jt8d9fEJDcik87hfqsxuqxAcNWDFBk=;
 b=pRVUCYLjTKZwMHWaWblzB+nzlbrfo5sZuC1C+AFN5SmTaWAIbm4x1ijpVrKsZokqDkFt3qXArzleD/TSPkeGl/uqVkUxUCJnExKP2Ab3abMNR9x2HAfsWyjRyOg76eaA0k/hr7vZ4Sq72d9ESt+Xz/D95I6qH82NrrqxCWE6ZNIEvnDDY79UMqqxjgCVUl0+g+d0UnU9HHojuDFISSTT33SUdUlzraI2SPMBpVNxnz2s6PWR8ApCFlB/4O7/c//ZfbJ2eoWwZCAaj++WmP4aGrOKUmvXHxQSbAJu1srRWNa8A7E37CD5N64Mt/CLrGzo+67WoGbl/M3dovVvXJv6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZkUsT3oTfLn+Jt8d9fEJDcik87hfqsxuqxAcNWDFBk=;
 b=SWOt6RV+EghbQL3pFUgUKhBkxh3L3YjTta0ec13lBEKkFjldNlWJ2jRprybMjwZH2Vn6No7C7LY4YSwQAXQsR1+WdwGBxkEwy2d0hX6Pqv3/9mDLog2HP5QfiCcGXmPVh2x13zUXanqfsAhD9BZAUVo9RHdvn35McJ6lKlG6qmQ=
Received: from CH0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:610:e4::12)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 22:29:07 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::5b) by CH0PR03CA0187.outlook.office365.com
 (2603:10b6:610:e4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:07 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:03 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 04/15] cpufreq/amd-pstate: Use FIELD_PREP and FIELD_GET macros
Date: Thu, 5 Dec 2024 16:28:36 -0600
Message-ID: <20241205222847.7889-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205222847.7889-1-mario.limonciello@amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc67ce3-af97-4d3c-0930-08dd157c3b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pJdR6pJdB7q58pWvn43EjRGdU2+eorzgFvz4ia1IQ2NlkloY1K65sBCpkJ8+?=
 =?us-ascii?Q?CYO2iTEOl0VNwjTNWt9kFFpFyunv0Hyyaq4n0q0zgOb1/d51ikPJlB2W2xlH?=
 =?us-ascii?Q?TA4HHJtkVGF2avUAX7tfWPu//85UA4qPcMRJNb5+60vlAIjYEXJPVG2vyriI?=
 =?us-ascii?Q?qmuvt0il65UmNvmHc9OAsDhk1NzYF14VpsZehZPQFTp02xzAsnFo+VXwEE58?=
 =?us-ascii?Q?dEbSSRqwLeIgQATH405pNNA42sZ1qQvp3vGjhDjAL/gatwXXHBAwEvmfEU6B?=
 =?us-ascii?Q?nNjKFJsz8wLdLa7XdHllzf8fXfpOs/f8Qhr9Qkn0cJy3b2oQ+2OOu2Fcq9pq?=
 =?us-ascii?Q?FaJTnlXzKI3MnTJ9Pi/BxVByJYXOF2Nql8ZImIjHe5hCxKS5/hUorOBpr/JZ?=
 =?us-ascii?Q?OEHMPbVHLBdrwFLoxylbEH4ZV6L7ifVK5FrCdcr+fS2nlvRyeelDNiGbuOLj?=
 =?us-ascii?Q?8rfdo/78zPgh4V8lE2JymRolhnKlHXql6szCMv42sheA6P1FhhJWKcRypgX9?=
 =?us-ascii?Q?otKtB+urWcwHyMVfNtum9weP4IVzCdCJBAUEo39LTSDh0gLg6iywHagdlVcP?=
 =?us-ascii?Q?lI1DwwwmlCyoBzu3dKwlJAkbC0VD7WlINY1X+SdpFhg6OJyDRqeH1Y/LlQZ9?=
 =?us-ascii?Q?HXd2q9iF1UvWkC3Oeg4YRRtIVcw4QQJGK4D/U/u3zncL3LeUBiLnZPAHIsix?=
 =?us-ascii?Q?hvafGfUi4oMKuvFTrGCdqjzEpAKQk1kCU6CSLOeSLt4Xsc0/sIj6s6THkLQL?=
 =?us-ascii?Q?u/JDtiO1/3+Fh1W5X6j69MQFKiq3Lb0FXUJOvOsfAuEYto7FrKkQCkLIxzjU?=
 =?us-ascii?Q?dhvnqw8mvTjgwqnA11G+1SDD2o2HJeQGxlpNzySjge9zncmp/N7pDMfE/1Yj?=
 =?us-ascii?Q?Cknrpzti20Z5Ru0dLPauQFPyJxog8Lt2YFvt9oAFMnvjfUmLfwS2GFM0e9LE?=
 =?us-ascii?Q?JNnyuu4erv+Medf7v7RX2bZLGaKtn4fmbqmAG93HanULJJSZ+9r2JV38T74Q?=
 =?us-ascii?Q?gmOW4dmYt/3/lviYWgiBzJLEDcdBeEyif1wdU+/hjDD9ooefZz97pCagVQez?=
 =?us-ascii?Q?8Sz1Mby/WXkTOD69YYnPLH4qp3/sx+UxJEnS0ml2eTCYXG864Vc98vQpd45a?=
 =?us-ascii?Q?FEKQVW1w8obQ/j340gXYoAJRYmZOzEVJk754Ii7VGUu1EJLqtxJjK5leoW07?=
 =?us-ascii?Q?qNlQ1jenJBJ9R1Dyu4Wmz1/TntvbAuu57Kv66EOFwEYbUrUUNerx8K+BJZa1?=
 =?us-ascii?Q?BLjQnUphWgyYkAmfztMThL3u0lGZFSI+b6Sb/g6VbhhWiU/jP561gwMb06EO?=
 =?us-ascii?Q?wml21t8FuHU3rA+4t1rD+22lrv8onC1pnZNag4nDl9s/mos5TdtILlvJImvx?=
 =?us-ascii?Q?bPzi07k5KeTS1Ykxn+Sx8aBjXHED7kYOED4rLmuBviDXhoBMxGb00EmXNGwc?=
 =?us-ascii?Q?b/Gz6u7uZaZrLOidbTjlpnAewDFJhYxs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:07.1515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc67ce3-af97-4d3c-0930-08dd157c3b59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

The FIELD_PREP and FIELD_GET macros improve readability and help
to avoid shifting bugs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 45 ++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 22e212ca514c5..dbe014f3c2beb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -22,6 +22,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -88,6 +89,11 @@ static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 
+#define AMD_PSTATE_MAX_PERF_MASK		GENMASK(7, 0)
+#define AMD_PSTATE_MIN_PERF_MASK		GENMASK(15, 8)
+#define AMD_PSTATE_DES_PERF_MASK		GENMASK(23, 16)
+#define AMD_PSTATE_EPP_PERF_MASK		GENMASK(31, 24)
+
 /*
  * AMD Energy Preference Performance (EPP)
  * The EPP is used in the CCLK DPM controller to drive
@@ -182,7 +188,6 @@ static DEFINE_MUTEX(amd_pstate_driver_lock);
 
 static s16 msr_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 {
-	u64 epp;
 	int ret;
 
 	if (!cppc_req_cached) {
@@ -192,9 +197,8 @@ static s16 msr_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 			return ret;
 		}
 	}
-	epp = (cppc_req_cached >> 24) & 0xFF;
 
-	return (s16)epp;
+	return FIELD_GET(AMD_PSTATE_EPP_PERF_MASK, cppc_req_cached);
 }
 
 DEFINE_STATIC_CALL(amd_pstate_get_epp, msr_get_epp);
@@ -269,12 +273,11 @@ static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
 
 static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 {
-	int ret;
-
 	u64 value = READ_ONCE(cpudata->cppc_req_cached);
+	int ret;
 
-	value &= ~GENMASK_ULL(31, 24);
-	value |= (u64)epp << 24;
+	value &= ~AMD_PSTATE_EPP_PERF_MASK;
+	value |= FIELD_PREP(AMD_PSTATE_EPP_PERF_MASK, epp);
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
@@ -533,18 +536,15 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 		des_perf = 0;
 	}
 
-	value &= ~AMD_CPPC_MIN_PERF(~0L);
-	value |= AMD_CPPC_MIN_PERF(min_perf);
-
-	value &= ~AMD_CPPC_DES_PERF(~0L);
-	value |= AMD_CPPC_DES_PERF(des_perf);
-
 	/* limit the max perf when core performance boost feature is disabled */
 	if (!cpudata->boost_supported)
 		max_perf = min_t(unsigned long, nominal_perf, max_perf);
 
-	value &= ~AMD_CPPC_MAX_PERF(~0L);
-	value |= AMD_CPPC_MAX_PERF(max_perf);
+	value &= ~(AMD_PSTATE_MAX_PERF_MASK | AMD_PSTATE_MIN_PERF_MASK |
+		   AMD_PSTATE_DES_PERF_MASK);
+	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_PSTATE_DES_PERF_MASK, des_perf);
+	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, min_perf);
 
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
 		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
@@ -1571,16 +1571,11 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		min_perf = min(cpudata->nominal_perf, max_perf);
 
-	/* Initial min/max values for CPPC Performance Controls Register */
-	value &= ~AMD_CPPC_MIN_PERF(~0L);
-	value |= AMD_CPPC_MIN_PERF(min_perf);
-
-	value &= ~AMD_CPPC_MAX_PERF(~0L);
-	value |= AMD_CPPC_MAX_PERF(max_perf);
-
-	/* CPPC EPP feature require to set zero to the desire perf bit */
-	value &= ~AMD_CPPC_DES_PERF(~0L);
-	value |= AMD_CPPC_DES_PERF(0);
+	value &= ~(AMD_PSTATE_MAX_PERF_MASK | AMD_PSTATE_MIN_PERF_MASK |
+		   AMD_PSTATE_DES_PERF_MASK);
+	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_PSTATE_DES_PERF_MASK, 0);
+	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, min_perf);
 
 	/* Get BIOS pre-defined epp value */
 	epp = amd_pstate_get_epp(cpudata, value);
-- 
2.43.0


