Return-Path: <linux-pm+bounces-18851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AA39E9E61
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5226F188012F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCE6198A01;
	Mon,  9 Dec 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ap94FDAF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB518A6B2;
	Mon,  9 Dec 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770400; cv=fail; b=uSg4kwR48kHcfj9U57exQhd/Vxuwe0Ty9XBqDnGBoTLwOFHioecJL6nsHXBZKVfIy8YoBkLJ9KL9PxEiom3eGaIYmF2tjcA5LY0bZ5Qo8wSGMPisex6F6rJmYzX6cXAOCL5AJuzA2PN+reOxAN3TpQnBuy8unAifpgKY/LfNQ+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770400; c=relaxed/simple;
	bh=bIwEkB4RisuaBUId95SyAh/ypfFCch8mxVSwKmvYZ4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7sXAQt6ylfYDgxsChUDDNGA99BfqIKJ8j6oKe3itwj+aFdqoGUMjacy4BUYPUDeF2fhKXpqNv70AAmn/Hjk+YudekV/WZHjiQwSeyH7VnKkNcYWg0JgyJEPIZWHMKLRrzrQs6rVieKZS9BCxIEYlN7ZgdRwavOPJSbvniVyfFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ap94FDAF; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLlVCNvH5BsHVwZPLIq2kFbUyDIaYkEHWf6U4Vyyb/e2sUfXebBoQc2akR6sES/M2Jt6XGdeneRjyBcw/pvz6G6w1hFdF3rTlIW8QvFe/Sez/xgqi76MrPjg6VcpXrMrR9sexuIvVNCxJ2UUZOlLlRZRFmMKMVzLrTj8leTQeS0++SbwoQAbY/INl70VATvIA+NwDysZz/iVQZwAsunuIq+SyHVnpc2EZduHyKSIUpVDK+UqPjDr3WEgyToZGGLpe9lzQYKRrfC8oZOu2NQigS+yKFDKWi7/bMUilQEW7Iur3oe+pmx+EYr/ut+FqTnjwIIhRsOWr8Yzo/D0Rku9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58MdHhkW1tfwOPWWvmX8ZgK7hZsGT/j6kAdVv3nR6ZY=;
 b=Qe70Lkq1yiZ4LerfSlqE9rNJ9EUoaOTn0aSwnx1ykQ847gjEELkUgHUqeV/1rWiWjBIE8aTDNbmRYOl5cx1ag73C/lQLcafvQQBUr3E+QiFJQmQ4p5A0DxRZXyxcJGfHGTXjm84YiUgyBJq+vRVWLnnSJnytnrp/JEQ5r89wlE0xEEEi0KlduRWJBiwTs0rUK31QlpLrHiRVILLUcQiwddhHmt8s3hfbDQml4NXbLGgoGit7N1oj67SJ6X6jNwafmYYVLut50QOHC3JmSu7/sY+38QxcAc/s0f84iJSJyB9K1+zwe13L0il2y/5WX62S8lqgvOr76FkzVgpZ4GI4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58MdHhkW1tfwOPWWvmX8ZgK7hZsGT/j6kAdVv3nR6ZY=;
 b=ap94FDAFahSkU1grtgUdIq+BZ9bZBdjipctjNBvE86g++wf/+ZPVT2Iygf61p3kk2OAc17LOU+lqc+zIBwPso0R1G5J+FTMTamzrJAn/Q5/rIfj6Il/oaKiUq7/7B2cf6vNIVsyP7yiYbKIcoAEFuvRIYGl5zIbFSQoxsQlMLnY=
Received: from CH5PR05CA0007.namprd05.prod.outlook.com (2603:10b6:610:1f0::12)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:53:14 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::94) by CH5PR05CA0007.outlook.office365.com
 (2603:10b6:610:1f0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Mon, 9
 Dec 2024 18:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:11 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 06/15] cpufreq/amd-pstate: Use FIELD_PREP and FIELD_GET macros
Date: Mon, 9 Dec 2024 12:52:39 -0600
Message-ID: <20241209185248.16301-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209185248.16301-1-mario.limonciello@amd.com>
References: <20241209185248.16301-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f648dd5-64a8-4643-e50c-08dd1882bc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iCyS5wPrWaG9+eOMWoD2cNntstkWO5xBElNMiCG0N40YUTbLfmiJpQzbr7Ys?=
 =?us-ascii?Q?l81DTOijjpaxXExnwbpo9TyCR5dD7SyvKQ78GZ1WN4jpgRNt+7GpBnA9ZMvi?=
 =?us-ascii?Q?fneYW2ZNEc0nHe77WDqPjjrpsg8+2LFrVox+Bry3M0jG8cMUKsUwtP3y4vYx?=
 =?us-ascii?Q?jn5IEF+gdnlHQByULnGrCIdrQlBvM7Gm0d2nBrK74ZNnsin4+DXr3e75apCa?=
 =?us-ascii?Q?a79Y71WHt9eGgXOCbdcVdA5IUE3/q26dWFMwYbZoWELr14pJdE+Q7mtsijkY?=
 =?us-ascii?Q?AqmR6lHpJJCZAB6O0V75gLempIfk12ut0FyoUlqKD9uIW52pciIE6FJCSdlt?=
 =?us-ascii?Q?Dg3lKzZ3EK/Mi73qwdW32IqNodjehKFPs/kCWpWTB7W7Rn96wAmnZR8s8WBo?=
 =?us-ascii?Q?RcAhHeJpdRQmd+7QRU1Jr4eiXs9keESPR+9nSw3YGp8pk/OMI+z5w/EzqArc?=
 =?us-ascii?Q?m668g6sFKOInInJMAGWR5hEYKU8U6osxAnVIDdcHRbgIYkIUAVJx/MRMjDsP?=
 =?us-ascii?Q?XOe0c2IoIjsnBdGKGF2+E4u1U5obUg2xkkMTD/nFZnG4ei0bfudv3gKTlNWp?=
 =?us-ascii?Q?lWe1RM6Rk8j+H1jxl1AzAE4ogevL50hXC2FgqHj4WgofKDpR1YOm3uP4n2Hz?=
 =?us-ascii?Q?qGCkyTT/E4R9c6/uciQDfi/pz6i/z5Ra3y8JjWT2UBQeJbq3EScuMgH+U6Ck?=
 =?us-ascii?Q?xaXH9AyiXywBWIKcKU18uVNe1En2ioFKwM8PRzb8D4jMQpaUyfXFMSTqP5lG?=
 =?us-ascii?Q?731C/XoGQXNYhwjOqFOz/hWyzhpnchvgWMEwG15my7K6FFyD/t48Ja0KshWH?=
 =?us-ascii?Q?EE9HqOQiwgiHClD4yXEV6kTmA5OdQXkZxb9R3F2qN1hvWrXxKUQPRqdvFlmK?=
 =?us-ascii?Q?h9fJ0uWaTTsFKuHFCzB4ZUZDsqB9ufPNo2S38Pv3uJYsMybIXBp4JWQDoX4H?=
 =?us-ascii?Q?1hJ6wjCAkqGFOG0noXrp4Ug0px5jAUQo+3bJaRvr6+FjE+Vsu6skQTCyru6u?=
 =?us-ascii?Q?OU+AZGYq/tzYEwrB/Maw/Z5LUArC01gqrQs11HAsCfbbcV6PzWc0NIwUBR5U?=
 =?us-ascii?Q?o4f3OMXhiAvlCFUl8UJfZJhhsH5kNE6ft4why+pkqLDlvNQPY9N/bJI6b4Dm?=
 =?us-ascii?Q?YWkrtxZR0/FERxqLNGp7INFJTZSt0zx0Tl19eHWneYlmTg/j31TxMUJ/j2NV?=
 =?us-ascii?Q?agMD4A02yxDFUgjMOvZZstgEik7QPfb+ZOwMfbtsm3NNk+RBf/DsWMYcB6Gm?=
 =?us-ascii?Q?s9I6nLDFnyNvolRmS85ZOV7ILBNULY1IEij9aY0gw++et39ZdHP5GsONCgG9?=
 =?us-ascii?Q?gC//z1hEJPLJudO0BFU/7TPs5fogKqfjCTTScgcolYsssfm2xOIRfYp39iZB?=
 =?us-ascii?Q?W1B1jcCb7Xaz8RfR/MO5cZY8efjQldQjLK+Zib42Yj92uVIC9KFIKx9IvRAv?=
 =?us-ascii?Q?Xv+V/Tnoq0QiOzJwvFs69UEWNJyO08rt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:14.2919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f648dd5-64a8-4643-e50c-08dd1882bc80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206

The FIELD_PREP and FIELD_GET macros improve readability and help
to avoid shifting bugs.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Add a missing case to traces
 * Use AMD_CPPC instead of AMD_PSTATE
---
 drivers/cpufreq/amd-pstate.c | 51 ++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index dd25e7e615984..0ed04316a8d80 100644
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
 
+#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
+#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
+#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
+#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
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
+	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cppc_req_cached);
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
+	value &= ~AMD_CPPC_EPP_PERF_MASK;
+	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
@@ -327,8 +330,8 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
 					  epp,
-					  AMD_CPPC_MIN_PERF(cpudata->cppc_req_cached),
-					  AMD_CPPC_MAX_PERF(cpudata->cppc_req_cached),
+					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
+					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
 					  cpudata->boost_state);
 	}
 
@@ -542,18 +545,15 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
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
+	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
+		   AMD_CPPC_DES_PERF_MASK);
+	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
+	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
 
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
 		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
@@ -1573,16 +1573,11 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
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
+	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
+		   AMD_CPPC_DES_PERF_MASK);
+	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
+	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
 
 	/* Get BIOS pre-defined epp value */
 	epp = amd_pstate_get_epp(cpudata, value);
@@ -1652,7 +1647,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
 					  cpudata->epp_cached,
-					  AMD_CPPC_MIN_PERF(cpudata->cppc_req_cached),
+					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
 					  max_perf, cpudata->boost_state);
 	}
 
-- 
2.43.0


