Return-Path: <linux-pm+bounces-21381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD1AA2892F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D86D166519
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ECE22A4D9;
	Wed,  5 Feb 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zkuvH3Fv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FC21A458;
	Wed,  5 Feb 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754844; cv=fail; b=pugAjtzo2B6DnfkakURRNIF9B6elg6GrHqOw6Ki15eoCxbveXnykGPGnEY76mJsMnVhmYt7W9oNJskKZqi8eW5YkYkMR0ppgubLuoCT5fz3tcOOmpY/wg39sWAmec+rdbqFbqSDgLtfyNJf7xrcUcmTEXaG5IOHPMAZ7k1yp8uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754844; c=relaxed/simple;
	bh=y+MOtjjTpfpQYXxgiwVoYC4Sdd7MynVs/6Oxser0eko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZTdFvZgXw5hpkMk6FoHPmjNGpUwUoRTOKO8ZWlTyuGy3SqkrsTD4I+YRYQ2Ibx23ZvywJB9SQEptlZ1a4z40sRXoIjp2ALBVF2uw2EaIGsSDh3caExCQqD+rL2kSXRsx7BatVCDvEPjOJLB9l3Qp8nCfSW9rrhRm8HszIbd5bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zkuvH3Fv; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7uKJ4Aj3ehJglHfu0RqQmWBtSkPgvplm27wTH8nSKLJR81QD15oUgzSNRzl9EtqGC69CiPXub3GPpWOPajvM8LD/Bmr+eWOZRD+sT1NEauvHZOiM2BF3Ze6kxPYdGuIYKexg64x7YrMsQ9mbxor+Jj7h/KRVykgLlWsSZLxmkeDr8B2IpfCiYFgIhZHXfATy384WaYOZpa3RBY+uYkTnGKKp+jCcfSYIpvWkn9UYsvnHVueYhy5wNwAzrZ4K69fCBbnX49zviGHYTdLBtvg96EeDolb8g/uF/b9juNjINelp3030PZL5B/fPqKbg9wbteOuh6zHAh8mzMS+T8KfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lqkVVEs/Ut6W3XzgYIsBtKtuuBsg9KLDgTvPMUR7f4=;
 b=yvdlsyvrnP29px8u1rOKVwRDlWS5gbJTyvK+sT+HGcRd97LxWqD8oBaPH3PjvpakOM0yeeIDhoKqVWHZVmk3HNt6xC9Gq6fQEDRpfM3W8RaWd2EQm8J6WqbXdYy641XoIqQOrUZ43WdbKqUUOq9ylz3cwWTRhIgBGMxUm6Gm+WUo1+JDgh+IOYoPDLT6DAgVn8brqZw5igpbHCZ1rPqXR4gYIxVDqwrvUFGhzsL2XJJYrIEX1U858sPSE4s9DNbthaZ8N7W3YEYjH8HjayDFEY3lGdxLpBcyazjXl3zeOgxU1n1f8FYdUtXNIUcQUJmoM7NZW5STyPeZC8KjqJ3PLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lqkVVEs/Ut6W3XzgYIsBtKtuuBsg9KLDgTvPMUR7f4=;
 b=zkuvH3FvHA4mbqvTbb8x8fl6O7pLYZLm2QLSXg1OHm3+xNUTntnXaOuLnmvM76aU+aFF0K2jEwna6w2tPrnxwDgupIUiAanQZJbHfQlurOZGcGIh8DI3z6GW9mnYNmRfk+sFXu6mjqwBszZeL0U0/o8MINiOhBW+pauAcyUKtIY=
Received: from DS7PR03CA0228.namprd03.prod.outlook.com (2603:10b6:5:3ba::23)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 11:27:17 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::fb) by DS7PR03CA0228.outlook.office365.com
 (2603:10b6:5:3ba::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 11:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:27:17 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:27:14 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 06/12] cpufreq/amd-pstate: Convert all perf values to u8
Date: Wed, 5 Feb 2025 11:25:17 +0000
Message-ID: <20250205112523.201101-7-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: b12df71e-724d-4624-1623-08dd45d80c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Us6p8TkG1O6RRRs3A05dOoYonIYsDHpUpoxLEh/obvneRxoASgbGa+heueJ2?=
 =?us-ascii?Q?ejJs+84qIDV2TJdofeNxnmNSOU7LybPQz95/P66c0TAu5ZIFhGlVvG4qmoAX?=
 =?us-ascii?Q?VebmziHpyf8DbJlSFlvh/d9xD3heINWyihgSZ6YmA3OVkcNm8beabZhmjTKG?=
 =?us-ascii?Q?5zKN/JYb7IuPTPf+cn5iRotiJaeLwOvbGcLkyOKftrs4hxAp9LaSxA0tnxyS?=
 =?us-ascii?Q?c7uf6iqtbBL0iMoujwSzf6qgaLq+YcpsmfGpSCxR/FGS8dxtXlrT1zcFr3TY?=
 =?us-ascii?Q?J2w6mt8NYqx38xhPkJj8Djmd1A/43nDzk71QeAmV7qzbf9PkBhCoii6TpVwl?=
 =?us-ascii?Q?YkdSblvIegZP3/bb+g8xZLHvEh7n2etY6H2rZOK03kPKY8zb6e9ThDL283Iq?=
 =?us-ascii?Q?ve5xt00xnnkMXuFm79cwsVgTiBuEdRXamW7ARtiEzGq8kmmjzByCitGWT6XT?=
 =?us-ascii?Q?n8lrsuvAwj1mIfkVAw2UBkJ/gWNl/SWR4ulmz9DXBIfMIV72w9zTdyDDC8U5?=
 =?us-ascii?Q?RkW2Yx3FsfqJtn991gHuAeRMsaTXytkGpi3rSuy1r/f/vcgSAFLlHYzaZRoy?=
 =?us-ascii?Q?WaiwfCjkQnkvIBQ/QiyR2ZiSUoYrxbyDsapz8u23APru5PEw+29a9yxRernE?=
 =?us-ascii?Q?41hlYnWtq2EcRH+38Bz2JPrVaApWVJWbrZSB6fXTgSoivs6bW/PmNE3XIWPL?=
 =?us-ascii?Q?stk0wkNwL82NVLrldStiRBZSbU7JSKXv2dj/DM8yVZmsjvtvGYPixDJI7os3?=
 =?us-ascii?Q?RCA/OaC97Jv+VRl5a2oMZoalXi9YVpBYbChGCJuWraqiWS3SEiaWaEf3pmJ3?=
 =?us-ascii?Q?nhjExtwMBxZo4x5jnuKmrqDIUr4wb6wXnSENOnpSnZq7jDmrRYgGJsYC2P/A?=
 =?us-ascii?Q?rgJon57+tasyXYCas78A5MGiYjZtsTTfo6q2FieeNOu1oOIwtk9oAwCE84R8?=
 =?us-ascii?Q?Z0pD5oTl9aivnc5GSFVvrgC+eXiAxH8o+eUZaN/kR+bZItChVS/HP2Pzv26K?=
 =?us-ascii?Q?339rlXsKFvbTGC05gouYFgaR5y2lxjYjSBazTgI6OFFRlO1dweirhzlClxLu?=
 =?us-ascii?Q?STnslXxEFeENL6DL2pISZth0qPmnJLQTMu7KE3a6HxdmOK5NsjzUPJSGDGJ8?=
 =?us-ascii?Q?l/OlJaOjpD1ANmcvCWAorkZt44v4xiq5N1K6XaBZtGcZFVlxSqH+J0Y0HPVC?=
 =?us-ascii?Q?gmdNsD9rZJZZQnT8WmLy7m8GtwQDqx2POxLVXtopZhMl5/iUDwDrrajsKHvD?=
 =?us-ascii?Q?0Nh4gdt+E7BnUWCNg7iTJPum/ahKD+7n6ea7JYvOw2w9aQAbERg51jSeF8Mj?=
 =?us-ascii?Q?dUodh8YlWkXFxSWRfJlIGSBEdrqLplDWmp1EDWD+Lr0UjZctbVbQ4h7O6Dhy?=
 =?us-ascii?Q?yaR4jJiqC9kelTgvcrz7V6aLehrL3/miOt9mpjPCcsuDTbsjIWeFwcW5ncz0?=
 =?us-ascii?Q?RyCo8hjJI6ZpZ0oB8VJi1fy5QpggwpENSUNhB59bDB5dvcMxWujZwqB+LmJn?=
 =?us-ascii?Q?7xwZBjvb2rxNSNc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:27:17.5180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12df71e-724d-4624-1623-08dd45d80c31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958

All perf values are always within 0-255 range, hence convert their
datatype to u8 everywhere.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate-trace.h | 46 +++++++++++------------
 drivers/cpufreq/amd-pstate.c       | 60 +++++++++++++++---------------
 drivers/cpufreq/amd-pstate.h       | 18 ++++-----
 3 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
index 8d692415d905..f457d4af2c62 100644
--- a/drivers/cpufreq/amd-pstate-trace.h
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -24,9 +24,9 @@
 
 TRACE_EVENT(amd_pstate_perf,
 
-	TP_PROTO(unsigned long min_perf,
-		 unsigned long target_perf,
-		 unsigned long capacity,
+	TP_PROTO(u8 min_perf,
+		 u8 target_perf,
+		 u8 capacity,
 		 u64 freq,
 		 u64 mperf,
 		 u64 aperf,
@@ -47,9 +47,9 @@ TRACE_EVENT(amd_pstate_perf,
 		),
 
 	TP_STRUCT__entry(
-		__field(unsigned long, min_perf)
-		__field(unsigned long, target_perf)
-		__field(unsigned long, capacity)
+		__field(u8, min_perf)
+		__field(u8, target_perf)
+		__field(u8, capacity)
 		__field(unsigned long long, freq)
 		__field(unsigned long long, mperf)
 		__field(unsigned long long, aperf)
@@ -70,10 +70,10 @@ TRACE_EVENT(amd_pstate_perf,
 		__entry->fast_switch = fast_switch;
 		),
 
-	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
-		  (unsigned long)__entry->min_perf,
-		  (unsigned long)__entry->target_perf,
-		  (unsigned long)__entry->capacity,
+	TP_printk("amd_min_perf=%hhu amd_des_perf=%hhu amd_max_perf=%hhu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
+		  (u8)__entry->min_perf,
+		  (u8)__entry->target_perf,
+		  (u8)__entry->capacity,
 		  (unsigned long long)__entry->freq,
 		  (unsigned long long)__entry->mperf,
 		  (unsigned long long)__entry->aperf,
@@ -86,10 +86,10 @@ TRACE_EVENT(amd_pstate_perf,
 TRACE_EVENT(amd_pstate_epp_perf,
 
 	TP_PROTO(unsigned int cpu_id,
-		 unsigned int highest_perf,
-		 unsigned int epp,
-		 unsigned int min_perf,
-		 unsigned int max_perf,
+		 u8 highest_perf,
+		 u8 epp,
+		 u8 min_perf,
+		 u8 max_perf,
 		 bool boost
 		 ),
 
@@ -102,10 +102,10 @@ TRACE_EVENT(amd_pstate_epp_perf,
 
 	TP_STRUCT__entry(
 		__field(unsigned int, cpu_id)
-		__field(unsigned int, highest_perf)
-		__field(unsigned int, epp)
-		__field(unsigned int, min_perf)
-		__field(unsigned int, max_perf)
+		__field(u8, highest_perf)
+		__field(u8, epp)
+		__field(u8, min_perf)
+		__field(u8, max_perf)
 		__field(bool, boost)
 		),
 
@@ -118,12 +118,12 @@ TRACE_EVENT(amd_pstate_epp_perf,
 		__entry->boost = boost;
 		),
 
-	TP_printk("cpu%u: [%u<->%u]/%u, epp=%u, boost=%u",
+	TP_printk("cpu%u: [%hhu<->%hhu]/%hhu, epp=%hhu, boost=%u",
 		  (unsigned int)__entry->cpu_id,
-		  (unsigned int)__entry->min_perf,
-		  (unsigned int)__entry->max_perf,
-		  (unsigned int)__entry->highest_perf,
-		  (unsigned int)__entry->epp,
+		  (u8)__entry->min_perf,
+		  (u8)__entry->max_perf,
+		  (u8)__entry->highest_perf,
+		  (u8)__entry->epp,
 		  (bool)__entry->boost
 		 )
 );
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e179e929b941..dd4f23fa2587 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -186,7 +186,7 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 static DEFINE_MUTEX(amd_pstate_limits_lock);
 static DEFINE_MUTEX(amd_pstate_driver_lock);
 
-static s16 msr_get_epp(struct amd_cpudata *cpudata)
+static u8 msr_get_epp(struct amd_cpudata *cpudata)
 {
 	u64 value;
 	int ret;
@@ -207,7 +207,7 @@ static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_get_epp)(cpudata);
 }
 
-static s16 shmem_get_epp(struct amd_cpudata *cpudata)
+static u8 shmem_get_epp(struct amd_cpudata *cpudata)
 {
 	u64 epp;
 	int ret;
@@ -218,11 +218,11 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
 		return ret;
 	}
 
-	return (s16)(epp & 0xff);
+	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, epp);
 }
 
-static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
-			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
+static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
+			   u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
 {
 	u64 value, prev;
 
@@ -257,15 +257,15 @@ static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
 
 static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
-					  u32 min_perf, u32 des_perf,
-					  u32 max_perf, u32 epp,
+					  u8 min_perf, u8 des_perf,
+					  u8 max_perf, u8 epp,
 					  bool fast_switch)
 {
 	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
 						   max_perf, epp, fast_switch);
 }
 
-static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
+static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
 {
 	u64 value, prev;
 	int ret;
@@ -292,12 +292,12 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 
 DEFINE_STATIC_CALL(amd_pstate_set_epp, msr_set_epp);
 
-static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
+static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u8 epp)
 {
 	return static_call(amd_pstate_set_epp)(cpudata, epp);
 }
 
-static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
+static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
 {
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
@@ -320,7 +320,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
 					    int pref_index)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	int epp;
+	u8 epp;
 
 	if (!pref_index)
 		epp = cpudata->epp_default;
@@ -479,8 +479,8 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
-			     u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
+static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
+			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
 {
 	struct cppc_perf_ctrls perf_ctrls;
 
@@ -531,14 +531,14 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 	return true;
 }
 
-static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
-			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
+static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
+			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
 {
 	unsigned long max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
-	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
-	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
 
 	max_freq = READ_ONCE(cpudata->max_limit_freq);
 	policy->cur = div_u64(des_perf * max_freq, max_perf);
@@ -550,7 +550,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 
 	/* limit the max perf when core performance boost feature is disabled */
 	if (!cpudata->boost_supported)
-		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+		max_perf = min_t(u8, nominal_perf, max_perf);
 
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
 		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
@@ -591,7 +591,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 
 static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
+	u8 max_limit_perf, min_limit_perf, max_perf;
+	u32 max_freq;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	max_perf = READ_ONCE(cpudata->highest_perf);
@@ -615,7 +616,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 {
 	struct cpufreq_freqs freqs;
 	struct amd_cpudata *cpudata = policy->driver_data;
-	unsigned long des_perf, cap_perf;
+	u8 des_perf, cap_perf;
 
 	if (!cpudata->max_freq)
 		return -ENODEV;
@@ -670,8 +671,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long target_perf,
 				   unsigned long capacity)
 {
-	unsigned long max_perf, min_perf, des_perf,
-		      cap_perf, min_limit_perf;
+	u8 max_perf, min_perf, des_perf, cap_perf, min_limit_perf;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata;
 
@@ -904,8 +904,8 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
 	int ret;
 	u32 min_freq, max_freq;
-	u32 highest_perf, nominal_perf, nominal_freq;
-	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
+	u8 highest_perf, nominal_perf, lowest_nonlinear_perf;
+	u32 nominal_freq, lowest_nonlinear_freq;
 	struct cppc_perf_caps cppc_perf;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
@@ -1112,7 +1112,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 					    char *buf)
 {
-	u32 perf;
+	u8 perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	perf = READ_ONCE(cpudata->highest_perf);
@@ -1123,7 +1123,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
 						char *buf)
 {
-	u32 perf;
+	u8 perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	perf = READ_ONCE(cpudata->prefcore_ranking);
@@ -1186,7 +1186,7 @@ static ssize_t show_energy_performance_preference(
 				struct cpufreq_policy *policy, char *buf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	int preference;
+	u8 preference;
 
 	switch (cpudata->epp_cached) {
 	case AMD_CPPC_EPP_PERFORMANCE:
@@ -1548,7 +1548,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u32 epp;
+	u8 epp;
 
 	amd_pstate_update_min_max_limit(policy);
 
@@ -1597,7 +1597,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u64 max_perf;
+	u8 max_perf;
 	int ret;
 
 	ret = amd_pstate_cppc_enable(true);
@@ -1634,7 +1634,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	int min_perf;
+	u8 min_perf;
 
 	if (cpudata->suspended)
 		return 0;
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 9747e3be6cee..19d405c6d805 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -70,13 +70,13 @@ struct amd_cpudata {
 	struct	freq_qos_request req[2];
 	u64	cppc_req_cached;
 
-	u32	highest_perf;
-	u32	nominal_perf;
-	u32	lowest_nonlinear_perf;
-	u32	lowest_perf;
-	u32     prefcore_ranking;
-	u32     min_limit_perf;
-	u32     max_limit_perf;
+	u8	highest_perf;
+	u8	nominal_perf;
+	u8	lowest_nonlinear_perf;
+	u8	lowest_perf;
+	u8	prefcore_ranking;
+	u8	min_limit_perf;
+	u8	max_limit_perf;
 	u32     min_limit_freq;
 	u32     max_limit_freq;
 
@@ -93,11 +93,11 @@ struct amd_cpudata {
 	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
-	s16	epp_cached;
+	u8	epp_cached;
 	u32	policy;
 	u64	cppc_cap1_cached;
 	bool	suspended;
-	s16	epp_default;
+	u8	epp_default;
 };
 
 /*
-- 
2.34.1


