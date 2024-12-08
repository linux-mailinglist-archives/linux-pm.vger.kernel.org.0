Return-Path: <linux-pm+bounces-18755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CAA9E83F9
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD9B1621D0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E47154423;
	Sun,  8 Dec 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IuNDv/NB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FC14B965;
	Sun,  8 Dec 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639469; cv=fail; b=l83wVlYr+QCraJZE2Bhjjo27p6Xpys5oLEvi15/Gi24DzFpulGjhI2enc5Lm/DwHzwRAwKj4zOzIRvKDRnxQCTSNJ/+dj20Jz3Zkf8STO8Gnoa3wW9ST0EMDwSbLnTKUxLdbcbNksghp8vzKolG3XxktOg98Te/OkiBTsm/Qsyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639469; c=relaxed/simple;
	bh=/TVV2dHV8Z7jzSu9v2b0756gAyUbIYlrUEKmtiqAsLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbG8W2sEu44GRevmwmeXnbmebngLCCI1RGe3SSwUPkzDUrY4VNYZv/rGcGXPydh2TNVkIU/3eSFFWRw5yO82upGPLtmyi+rKc2Z7LnF7B19GQBbjdC87QeSKD2f0KSps3WGZn/ysOhtpEvQxDqPyuNALHEXJ/DHl9sRMI24TuWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IuNDv/NB; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfmFKppLoI40WmKV5QkyfyqHs2x6PpjSxTxgJqqXGxCEqkhJ2TmOzx1XhDDWljx6EJ20e5KqpPsCL4N6NRTo8G43YvAN8RVXK4YtLS5/KKaz27RM/+kjrFDaZKmvp37iZm92YmDYlwK7npht25fUumzTiA5Wq/s5mMj0L+2Cgwt4COys+x8hvtgzl/DAAcGqPBWgaK6qS//MxQuo/I/WeYn3hQHgXAicDz/MRlvaX2CTfA+8ITVi5ZTm3ejUXdeiGfJH309r8lYJe6IDjFbWWKHWeDmbK7p4R9bV9/omRzIfO3f+IOge0RT4fcyKuwtcg/3YSU/7KOiB2qaX1oL2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pESds6HcfdNRNMtn6/Xfc/5VuKjuNDCl91K4Vnf4tk=;
 b=MhywmJVDKrwe2B4YFMrbvt5e0yi3QL2ibwOmddMAc3GZqr4GYV2z/z/ryloh8NwZ/pfQ7TKz0nrV6q1OOpYxYUiNg5eHgZszmv8vcdcmEiL8nV+RcXT4Yw8W8NHsND3pPjtwC6/cggXnFWGuxB8m+DiMg5wHBwkD5UdayTHp2tIgDjZd3yQEIZ9FTXAyfTcPvuvIiEJ/siHbYLiG68Qcd7D1AFOEs6tapwoq4G6p5PsA7oUeZOBEoUwhDnISEc4OLaIQS1G74BK+vtWbcM/654j3Lt1DWyCWqz2SHPAuWA+zZtmi/qXj0dAQhsaDtca7Bb8Tz7ROAcSDFVaX3Bwkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pESds6HcfdNRNMtn6/Xfc/5VuKjuNDCl91K4Vnf4tk=;
 b=IuNDv/NBUTHVR1XuDEQeX3cFkPLItFqO2RTUC2niHtVuSnEL5WSNOscwcJiaX72nI2hrQIwZBJ/EHeQolb/X1ts1blvJIWSzrkMkTw30sDklc7u2MyZwn56hJn7sr3mgZkwHEGJXpzihmeA9TuRLdL/3bmxD6JE0jsm103EiGU0=
Received: from DS7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::16) by
 CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Sun, 8 Dec 2024 06:31:01 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::12) by DS7P220CA0011.outlook.office365.com
 (2603:10b6:8:1ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:31:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:58 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 11/16] cpufreq/amd-pstate: Cache EPP value and use that everywhere
Date: Sun, 8 Dec 2024 00:30:26 -0600
Message-ID: <20241208063031.3113-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241208063031.3113-1-mario.limonciello@amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 74137e7e-9a1d-4f37-a51b-08dd1751e245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DAHjzW/43oft+Ud3h88wWD45FqJsqRA1bYLL1+VMwUSmRb60UyaRWE2scyoq?=
 =?us-ascii?Q?xQHG6c+nsnK1LNp/H1mV+9eg15jRSh2Nm7MQuMql0IginBQ4gMKV5Zplngnx?=
 =?us-ascii?Q?xAAR2LYi4tl0n4eKDRjBKd4AyiodZ9kKx1yR32/7R/tdtRIekU4rWG/QDcro?=
 =?us-ascii?Q?AIllcD6v2/e3aoxClBz5GmsmI6wYnL4MOeu/5ChUWmx3Vwp0phHRr9Tgd4a5?=
 =?us-ascii?Q?PSBLNLOAdfxwhXI40lh6bw3mRQw+X4I0KwLsTs+GMRalhvsWNKhztbIvCjNx?=
 =?us-ascii?Q?qmasxytfceVv7/7AJr1mo8TpDDdglKlmOum4uXGmYynVjKugWsxxRjydzBNR?=
 =?us-ascii?Q?nV/vK806q/VYgPWEfpp8+2diItCu9aiPI/i4Yv4hI8pLIfI5IBzkFe0mp6Z/?=
 =?us-ascii?Q?Q0+lT37Tte2Un45tuFlhPOzVgTlfoSp08KapufqBDFKFdU9nC1fJ07f+sNsL?=
 =?us-ascii?Q?nTLC/aWgnAbgbGLWVs1RAwuQmpLcUmkTT4y9h0COKt9DDLbIjgbXf2gtdJ7m?=
 =?us-ascii?Q?cDIE0dQ1JNCg8/6dFZqD25P+YE+Xg0o8WwbDXnH5NaatKO2FsUaorR1UzPLP?=
 =?us-ascii?Q?4pQo8KRmFEnFgADvE/4KG2FMgmzibndYHscN3KQsPB3Ag5Pj8VULo11sadin?=
 =?us-ascii?Q?pROItnQzi9wAw2HOKMiXGLoHcj67xS8ZgAJal0a1Z3zd0XSkvlqHQsDcfTtD?=
 =?us-ascii?Q?ulpH3woG0BXtK61fFCAp4ThOC17hybM6olRBO8Bo0gDJj1YLbWTv52ZoxcTJ?=
 =?us-ascii?Q?cRHgRXEk3wc89NfNsU9vFbbxWOAdHHQjdfwQFd8rP5XwRJIC2Ga1Q1bAap6R?=
 =?us-ascii?Q?Oobpoq2B/R7Y7tP36VSOts4pGOC6nHTLsQ8Fs9nuRjJy2/u+/twKGK3KC2nd?=
 =?us-ascii?Q?LZqDOR5RGGfrLu3nwXdsr+WLjvgmJibq9Y3hWuQk1KZ2iXmhXaLWRUxAh7y/?=
 =?us-ascii?Q?mSXuDSP/bjsApN4Ct1ASKOisyctMHehcQzizKAEQ5aCrP0r/v7u6Vu2Y8rqI?=
 =?us-ascii?Q?uXmEcdtWIUcG9EAeZMYFDdZKWYXsSG+9ES/+EROHydbcHnYNSx0TQ10HGa5r?=
 =?us-ascii?Q?FINpB/Ceno/xvOTFLqQuMY9oet1D+GlB0w5bcfYH4Qa0m9KDgjUegIi8CbD+?=
 =?us-ascii?Q?cbv8ReJE09osPBQVNf9qNb6rqBaApeJUP9nwoAVZ/+JQO0mi4cEZMQOzzJpi?=
 =?us-ascii?Q?g9zjGQr+UsLp2af6sv7zAxu1IHDxdeHtyNOVGurD5RGW2Mkvf92+BaaLOjey?=
 =?us-ascii?Q?3Y5sXGckN2StzVo5J2rLnFZUIRbE5zXbtY59CaTGYuwu8xzjSxtndbfJvJa8?=
 =?us-ascii?Q?5CH9BJvyOq1n19n6rvZueLf0wDfKwlzL9jCN1U30fIq2mrYpqp6iHVXoz/vB?=
 =?us-ascii?Q?VR82czQ0cOlZWq87Q4sr6i/gGqcGE/TAqiHxw6Q69JQAJdwprO59oX1TZc8b?=
 =?us-ascii?Q?tUMudXnbZRN0orL7xbiGoLXScxLnYr/P?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:31:01.0764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74137e7e-9a1d-4f37-a51b-08dd1751e245
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729

Cache the value in cpudata->epp_cached, and use that for all callers.
As all callers use cached value merge amd_pstate_get_energy_pref_index()
into show_energy_performance_preference().

Check if the EPP value is changed before writing it to MSR or
shared memory region.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Drop extra mutex
---
 drivers/cpufreq/amd-pstate.c | 105 ++++++++++++++---------------------
 1 file changed, 43 insertions(+), 62 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index dc3c45b6f5103..d21acd961edcd 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -186,29 +186,28 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 static DEFINE_MUTEX(amd_pstate_limits_lock);
 static DEFINE_MUTEX(amd_pstate_driver_lock);
 
-static s16 msr_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
+static s16 msr_get_epp(struct amd_cpudata *cpudata)
 {
+	u64 value;
 	int ret;
 
-	if (!cppc_req_cached) {
-		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req_cached);
-		if (ret < 0) {
-			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
-			return ret;
-		}
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
+	if (ret < 0) {
+		pr_debug("Could not retrieve energy perf value (%d)\n", ret);
+		return ret;
 	}
 
-	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cppc_req_cached);
+	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, value);
 }
 
 DEFINE_STATIC_CALL(amd_pstate_get_epp, msr_get_epp);
 
-static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
+static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata)
 {
-	return static_call(amd_pstate_get_epp)(cpudata, cppc_req_cached);
+	return static_call(amd_pstate_get_epp)(cpudata);
 }
 
-static s16 shmem_get_epp(struct amd_cpudata *cpudata, u64 dummy)
+static s16 shmem_get_epp(struct amd_cpudata *cpudata)
 {
 	u64 epp;
 	int ret;
@@ -222,35 +221,6 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata, u64 dummy)
 	return (s16)(epp & 0xff);
 }
 
-static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
-{
-	s16 epp;
-	int index = -EINVAL;
-
-	epp = amd_pstate_get_epp(cpudata, 0);
-	if (epp < 0)
-		return epp;
-
-	switch (epp) {
-	case AMD_CPPC_EPP_PERFORMANCE:
-		index = EPP_INDEX_PERFORMANCE;
-		break;
-	case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
-		index = EPP_INDEX_BALANCE_PERFORMANCE;
-		break;
-	case AMD_CPPC_EPP_BALANCE_POWERSAVE:
-		index = EPP_INDEX_BALANCE_POWERSAVE;
-		break;
-	case AMD_CPPC_EPP_POWERSAVE:
-		index = EPP_INDEX_POWERSAVE;
-		break;
-	default:
-		break;
-	}
-
-	return index;
-}
-
 static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 			       u32 des_perf, u32 max_perf, bool fast_switch)
 {
@@ -275,19 +245,23 @@ static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
 
 static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 {
-	u64 value = READ_ONCE(cpudata->cppc_req_cached);
+	u64 value, prev;
 	int ret;
 
+	value = prev = READ_ONCE(cpudata->cppc_req_cached);
 	value &= ~AMD_CPPC_EPP_PERF_MASK;
 	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
 
+	if (value == prev)
+		return 0;
+
 	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	if (ret) {
 		pr_err("failed to set energy perf value (%d)\n", ret);
 		return ret;
 	}
 
-	cpudata->epp_cached = epp;
+	WRITE_ONCE(cpudata->epp_cached, epp);
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	return ret;
@@ -305,13 +279,16 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
 
+	if (epp == cpudata->epp_cached)
+		return 0;
+
 	perf_ctrls.energy_perf = epp;
 	ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
 	if (ret) {
 		pr_debug("failed to set energy perf value (%d)\n", ret);
 		return ret;
 	}
-	cpudata->epp_cached = epp;
+	WRITE_ONCE(cpudata->epp_cached, epp);
 
 	return ret;
 }
@@ -1214,9 +1191,22 @@ static ssize_t show_energy_performance_preference(
 	struct amd_cpudata *cpudata = policy->driver_data;
 	int preference;
 
-	preference = amd_pstate_get_energy_pref_index(cpudata);
-	if (preference < 0)
-		return preference;
+	switch (cpudata->epp_cached) {
+	case AMD_CPPC_EPP_PERFORMANCE:
+		preference = EPP_INDEX_PERFORMANCE;
+		break;
+	case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
+		preference = EPP_INDEX_BALANCE_PERFORMANCE;
+		break;
+	case AMD_CPPC_EPP_BALANCE_POWERSAVE:
+		preference = EPP_INDEX_BALANCE_POWERSAVE;
+		break;
+	case AMD_CPPC_EPP_POWERSAVE:
+		preference = EPP_INDEX_POWERSAVE;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
@@ -1501,7 +1491,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata, 0);
+	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata);
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
@@ -1555,35 +1545,26 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u64 value;
-	s16 epp;
 
 	amd_pstate_update_min_max_limit(policy);
 
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
-		   AMD_CPPC_DES_PERF_MASK);
+		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
 	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
 	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
 	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
 
-	/* Get BIOS pre-defined epp value */
-	epp = amd_pstate_get_epp(cpudata, value);
-	if (epp < 0) {
-		/**
-		 * This return value can only be negative for shared_memory
-		 * systems where EPP register read/write not supported.
-		 */
-		return epp;
-	}
-
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-		epp = 0;
+		WRITE_ONCE(cpudata->epp_cached, 0);
+	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, cpudata->epp_cached);
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
+					  cpudata->epp_cached,
 					  cpudata->min_limit_perf,
 					  cpudata->max_limit_perf,
 					  policy->boost_enabled);
@@ -1592,7 +1573,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
 			       cpudata->max_limit_perf, false);
 
-	return amd_pstate_set_epp(cpudata, epp);
+	return amd_pstate_set_epp(cpudata, READ_ONCE(cpudata->epp_cached));
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
-- 
2.43.0


