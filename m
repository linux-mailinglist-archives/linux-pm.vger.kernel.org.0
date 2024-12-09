Return-Path: <linux-pm+bounces-18859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1949E9E6D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCD0282926
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4511819C561;
	Mon,  9 Dec 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AcK5so6i"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD0A199EA3;
	Mon,  9 Dec 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770405; cv=fail; b=YzEJPhRD6liXO8kHqhgnqFVHQjm/4LfEFVZ5iUro3YH3bQOpoX75A2EfMgzaCuPfVsHojC+GDJeaAfDAR9jCzmvNwZvkAh9FmQTmoU1DBYOiP/WNKPgGCRBoYQ8O36PK9+K0muKwNILa5ZE8xoBZmftCKt021UZHa1WN1hKy8PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770405; c=relaxed/simple;
	bh=/TVV2dHV8Z7jzSu9v2b0756gAyUbIYlrUEKmtiqAsLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cC9ALOihVpuPESVJsKDrKrBUJ1Tj0aC50pGmUCm8Dmh6mZo3LbaiTyuCr3TLBSeLq2Ui2EKQMJiNreUiVUFMzpwTEb0kWfKetpp4216L06wXO46+NA4RHXvr/jLhY/Bf/NqmkJI/ghZWhS226xdvK/1PLqK1yyYgYSoMqQ2BIGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AcK5so6i; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9+T7TLb2Myf7KbjH8l3eRkdDYZ3ni6dFzOf7MaHxRGtVwQhBdwvHb19GNJv6gjrGvWmjirblkTb6gp/2GfNYVio2V0EzXoodJiARu4XhjC/seGNKjqc7RMqJ46Qp7agwA+oX5zMfUqKNogTTOtXHVY3NpYEYPe7NvFmlYalmF7/iyH1pT3EB2gvV0EPZpxN9I9Nq2q1YibytYkSMmTeUC71UhFB02516ikZoFqFxsDMczxLdefLNOAS95E//5c5z7Q53pKi9I3R6dVxWubAiwIcELodyPVmmTC0I0FbtsKEWaKI40xXm9tw2TQuWbTtBvC+zXaT/4rUMGRu44XTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pESds6HcfdNRNMtn6/Xfc/5VuKjuNDCl91K4Vnf4tk=;
 b=v4MC0bM05fvTavz10++xcLBsfJx0GVL+13jR/5xNpdH6YS0+Q31f3Kq1pldnHghP3kTLCvm7/EmfzFy4wwhLYP1s1XJXy36xoTxyeCjvibUDqansqNQjQwoowD7q9Z2FGQ+cmMSJjhCmAFcuH8TtF6psyDMQx26ATRAz1F+0qrZ5lNRBXPPfD7uePDPamnfZc8oTuccf4beJQ9AuwOPJybP0aDXMfG7jM2LXG4u9QAlsM/Kr0Gt5Q0BNCnpehMMIhkkllWn6dEDuR17QULenbfameYW40eGepm6uMRWMJsrVWoODPFDUFIcXDZJOyrOOPb24+nSLKrp7jTcUsIxt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pESds6HcfdNRNMtn6/Xfc/5VuKjuNDCl91K4Vnf4tk=;
 b=AcK5so6iKUokbjjcKmalwXRJPfng56q03VHs4mQUHZxunbPOmR7OiumBcIjt7BRyS48KkShzEKglS+PHUGsvZK95QY5YLQYeOqDqygUrx6vhcjJ7qFNEuRr5YOHMHVv11XsbXk5FXapvZqMDKEhPWcyVPskHdS9DuslF3mYjOH0=
Received: from CH5PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610:1f0::11)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:53:16 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::c2) by CH5PR05CA0006.outlook.office365.com
 (2603:10b6:610:1f0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.11 via Frontend Transport; Mon,
 9 Dec 2024 18:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:14 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 11/15] cpufreq/amd-pstate: Cache EPP value and use that everywhere
Date: Mon, 9 Dec 2024 12:52:44 -0600
Message-ID: <20241209185248.16301-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: daa8ec07-c63d-41f3-00e7-08dd1882bd80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GKZyS2mu6Q1dkZmGeoSWH+Wg0RpWnqK8jY+8eP+XuWNKzpTdUmPPwUVGdJQC?=
 =?us-ascii?Q?DiXlJpfB69oh3CWtoZGBhfBYZ0X+nstG2T+xjwmmqlE+dBd8OAEbXuHh+sAk?=
 =?us-ascii?Q?OqSCsf8eZxmmzeDjKctx8CkRBO0W/Sq5fl6flFh3rtTyq3YXUIi8Eg02a5xY?=
 =?us-ascii?Q?egZxJ8E4nnrLKNrwjY1g0mJFyPnffmQDOOxZGYVJp9bzqLT2teb0TmMiUQd6?=
 =?us-ascii?Q?935RRTLlE8YEpMXrrhvs0RB+4Ek5kZWFryXPVBY6ytYtBAKO79N028n4QX5B?=
 =?us-ascii?Q?Bh7Q3MNKWAOtsYizzJzHKZeXK4xLYOpE5X7y+6Z0jYtRTixsPiLvfuA7jqDg?=
 =?us-ascii?Q?ExCLt/PU/3XLnns8fSEhAKezX6tzs5B30KqCHBhAa7v8OaC6oMyQeNtpP5oo?=
 =?us-ascii?Q?NL5jzu4F+l3iWcxTZc7iyOi84JRgLS6eIniHL3kRciOMn/nyrE3WlZ+pk0S4?=
 =?us-ascii?Q?fohdJxIrgEuIV01cHCBRb2zBb2jcv5u4XklcjUGKBAGqW9KIjXySaS+b77UO?=
 =?us-ascii?Q?pndcnKDAW3mNTjSHNvqfY+TzfJLR1m+wOd9DyIV9ii+4d8dEu+S0Ja4VbTBb?=
 =?us-ascii?Q?Y5wVBl/t/exrnTJ/AcGVzt44tStU+669u5vflUhp2YuYbv1wpaloCvwsnQbM?=
 =?us-ascii?Q?e77SS4aigi6/wx2LfJ2CaPIs+ZOCFRhnQbL6cDPKV2/XhIaU4O4Y0ZaurQve?=
 =?us-ascii?Q?PFr5P5o9mqRGqQuvtjG/Fur0lsGt4HoF7PcYFLINVxkL9c+VoUX7salWiPEH?=
 =?us-ascii?Q?uvfg4AZGK2Q0WtKFKD8iQn/XPm6mZ/FTxii4WZZZHIdY1Lz7kTswsPPMn3Ng?=
 =?us-ascii?Q?DGHrmsTboOuc7qzgF4Lmy9yB8r/eb0vVNwK5tMaolSGfux6L6lXqSRKqmp28?=
 =?us-ascii?Q?znuWpeZUMqE2pZ6gpDh7Uxxy/kAmKwl+tf4XtjQ8COh98x/ru0NCqbY//bpV?=
 =?us-ascii?Q?UfQWbBt5tptDJSqh9xJ8SCTxhSXI3IPCZOBulfbkB9bMPt1zVEpKL0zeBeLh?=
 =?us-ascii?Q?Bnz7BJOqn3UrTODzEte54lBSOKkb0JRnh2b8W5jEJ8FHZmavqwMJ4TxgnYo3?=
 =?us-ascii?Q?siC8n5+I/q4uGykvgR+JvQnoPtvFIEJY938Y+iJAF2/jPgKIE4xrSmvHIG6U?=
 =?us-ascii?Q?QdLw59SQeecxYLh3Q/w8MlQclIpB6qvpM6lh8eYop41J82hCHsM4zjnNGOdd?=
 =?us-ascii?Q?G+YQ0C1KbxMJ5d5qMyy2BR895jtzMh9CM+zQF61Z7tkSv486DDNJB0q6ju5D?=
 =?us-ascii?Q?h3guO1y8TMSaRFjRLR1CxiuUMDO7EMeoLeka2rVLIoZ2rDpIb3fBZ7I0KkEZ?=
 =?us-ascii?Q?ivHYDaiHILyN06aeo4s/F3CquwgB3BDe/FL0iSnFHZ7DG8y00l8I/nkV4O45?=
 =?us-ascii?Q?Swq5O2tEPZzcD4yUloC64IPKwb/n8TopSbEDcOzMvzff0p+58tGJ59BNOw9V?=
 =?us-ascii?Q?i/aCINAEMKw125x60jcubtvafgLJsHPF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:15.9795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daa8ec07-c63d-41f3-00e7-08dd1882bd80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815

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


