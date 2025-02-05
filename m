Return-Path: <linux-pm+bounces-21386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0726AA28944
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F9F164B60
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B605722B8DC;
	Wed,  5 Feb 2025 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eAbJITiG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECC22CBEC;
	Wed,  5 Feb 2025 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754923; cv=fail; b=c9/9wOp6w8JXHKd1ari2OywBNQKORWvCX4MeVKt3RpFvzxyZTIBn5xPRjkRJ42gdx4wqEuhiK0tBQe0aStzCPt1hFEyqiQ9UyRoAkWQvTh+MBSAAVRWsQKjtPZGiZnT6uB5y2cHV/N6doLy9FOHdUQl6ED3tEBpBjzbUvLzIl9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754923; c=relaxed/simple;
	bh=dG6h0ZhiyW4zZDfibagNWPFupt1FSF6lhdL2bC2/JqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5G9IRrMXeYq1xU23hcUtMowXOWA1cCECdpoP0dEB0xaMgb83Tn4964t6gUjAyT/85rFXQh41g2zdf1sgi9JRMLsehN4db/Rn1eOI1a21l/enMvbgBo6IKHo9QGCRXVXO2pb4Hn8ZOgTECykYkEXdfbwZj35h/1A1JbKRIrGX4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eAbJITiG; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDPo8vHfA8FUkp+KQoir31WmuSMpE8RIdBMLXprfAWa2S1JLJPkW4HxYzk9TisCFMnzuO1NBcV8NK1a6FJPgGpYaJXjWkxHIwRGXRY/B9Kl1GOQdzKJTtPbYP0TGjsJ79K/wmVgZVr45IpBh8BS/TkwBv9qSyt317OS8G2yHjO2T8eTPjpolaTWLK5JFrmroGZCClRAG9rOziJZSPufpuo+K92WJTABJ1kGowbBTbn75CRHXHNHoycXVx2aONCNgZs0yXzm+pzknXKrQW0JIPpRMhZy6Z4JJquvCHnpIA9CgGHtA/hpHVHmP40tqw9ey+NRQ0uJiZqWQjlEod+r1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrKzhYJ2s1I81LO4d2M4m2UJknIyrCxOljqyby/50po=;
 b=Z7HUz2NQ3ppVsB+yJFim0q0bAZoTZTa/fIM1DIyKGk68LZ/fU9UB9dZP6RU/Uh2uCMxXXNzQeAd8XjCJLUUGOk7P21/RtyMbOLH2VPevhWBatdmNNunogUVg85aeAvsrVNIxPYsFWJgJnAPcAapffbu2A6g38AMdbUvUPX8I6TFL15ENl3yzJ5zSFcUKeoeidXPJoGGjonUsDj03WH3Da+sXckRACYHBoNr1+u5sb8MB3HJRltcT7tA+ceUziUx2R2zbYVziUCslFSncKw2N8evUW+8/j99S03IdiIgGrsE9w0ga5jeReqg/JfSVu76K+t1iWwex3LWLIQqxT1LtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrKzhYJ2s1I81LO4d2M4m2UJknIyrCxOljqyby/50po=;
 b=eAbJITiGB6mD+aA873jMg+si/THsF9BGIPzi7FOPX5DnNRYmOWcauuVtkm38ilXhYFgr28yn3uueGXHMTvZaZuIztKvrxR+5AYkPvla2heLFZLAusQ//M65MdBx824/CcmURHGVRwIH2pQW28TiCuiDmaV1nZ2Y6233gbHMUdh0=
Received: from MN2PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:160::36)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 11:28:38 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:160:cafe::53) by MN2PR13CA0023.outlook.office365.com
 (2603:10b6:208:160::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 11:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:28:38 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:28:34 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 11/12] cpufreq/amd-pstate: Use scope based cleanup for cpufreq_policy refs
Date: Wed, 5 Feb 2025 11:25:22 +0000
Message-ID: <20250205112523.201101-12-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 40531d0f-faef-44b4-3931-08dd45d83c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQksj0Xz5V2XLx10Xjh3EqK/6OwOuOSmTowUKY9SqTEmr4znuEPjCAp8xrdY?=
 =?us-ascii?Q?63OzEnvlzRRXPTmnKOPSJElF6j7Oo+HH1hzn0vhIdAwPs86LDqipTJkPwJky?=
 =?us-ascii?Q?GCiFqKqhUrmOOtfkNEZSiPeT5960cGem0pkLxyrAMZZBxEA1ZliiCii3BKiJ?=
 =?us-ascii?Q?pdp7ItWSSi8BDnnocCXdOwq5nsvVJLJuPkh+HTERXUkok5yY6rrhEmsGNm8z?=
 =?us-ascii?Q?qxqWynf5qgzmmYdrVobhVPuRkGRoIIyfsecpa45r/YiGtN9G6tEUuHBtBFnB?=
 =?us-ascii?Q?aDF/AKa6yoiJRfvc0TVYT0zQxGn2H1FwIPU0YA6NuFH7T1UNuZeNcq0Q5sHl?=
 =?us-ascii?Q?pVI6GxaEpyNjhTEjv09Nr4a9Dauy1Dv7/1MBQzG3Yr1dlJd0c5uHlgYDFhnD?=
 =?us-ascii?Q?LMrDYdmXhWQYAgOKHtgEyRIAdM/njEsPdnGTqQ/bpTkgCFeqanwXrFScr+vI?=
 =?us-ascii?Q?9kTV/yg0BawrHcRrEPCIxAoAwVxt9NCzcGOMXWV49p/pLnuVimTri9uz1z7w?=
 =?us-ascii?Q?OwyKGPfIXkT1+6t+9f3X7lJUR55kleLz8K3o0Epym/J+XhYReFe88kH9b6ya?=
 =?us-ascii?Q?kNXxt3grEuPu5uceR/JZizu1nVh6yM+OZGL/RQpp9nP16bdpFqSvRbygo308?=
 =?us-ascii?Q?/iMnIqdgpRHjCSQpjEdm3a0zTBnuKbdozF4HWTm7GMLLhmnsTDjeRRj5YsMi?=
 =?us-ascii?Q?8kzfgOlIQqlL+WXKUTJzdaN3oQSRFulzyzLctPYdD6I/2vVeXbkSloJ71g6p?=
 =?us-ascii?Q?wYIy9UKrudzhs1gQOisHEghxWF2ySx4zDvex1BPTw/RFPH03yFu6ODy6eKzg?=
 =?us-ascii?Q?RE3Hui7kx+yHPQPqMmDRFw/L1GQVzUP6ibpRi1GxH8JONI4XefpRtAakv2J0?=
 =?us-ascii?Q?O9w9Olu68QVaIOTO2/dPR4b7pqX3acIzseIw8Efr8lLBQ9PWbqLzLxMJ6yFi?=
 =?us-ascii?Q?bqKNbwrX8X0ueFxcC9NwAKpwY5q9IJxyN8ZejElMQXS3KQpOS3Ji2vm39Z+L?=
 =?us-ascii?Q?3BoORXwEtPzEjz8jWOysdmGkQq67p32STLjMJSYH8v79nyBr0XZGXAFrgXNz?=
 =?us-ascii?Q?XbeWuvJ68qp5fl8XfwBIDtwtATfe0DBXxka2qIjvIQlLm5jenLS/4WxErW6U?=
 =?us-ascii?Q?bE8Oh3+Zw7EVYAH0ie+NDweAQy297XKl+4ZM8DZQcc7w64+oQVGVMVGF9YsO?=
 =?us-ascii?Q?EZ8UEFOs8PrQmMJWwnb/EDodpg8Rot4LqdsgS3rSumpc6xLAqCDYWIgUYBOI?=
 =?us-ascii?Q?SZQH9K8khByP4n+IfQz/7UCVPx6He2HwPXDxgmzwpFXWn+bCU3iSkhypyvMl?=
 =?us-ascii?Q?GdKbWG8b9gL9zIgK5AQVcG8iu7rdDQ2cMBswny8Oh0OmFW/0n/1xuHDHLK+1?=
 =?us-ascii?Q?cLkAGDJU7uNgWhkB/BoJtHJ4i2Zt9cQpSZqAQM3ixj6zmts1xQhBr9aukIOc?=
 =?us-ascii?Q?PWgYvISCvqtRBcdBq/gHIp+xBtv8ztj9NkzLJ10NMti8vDoKgNhJ/NHYMZn4?=
 =?us-ascii?Q?i3It74a+9EvqxDA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:28:38.0374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40531d0f-faef-44b4-3931-08dd45d83c28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339

There have been instances in past where refcount decrementing is missed
while exiting a function. Use automatic scope based cleanup to avoid
such errors.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 25 ++++++++-----------------
 include/linux/cpufreq.h      |  3 +++
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6a604f0797d9..ee7e3f0a4c0a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -548,7 +548,7 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
 	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
 	if (!policy)
@@ -574,8 +574,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 	}
 
 	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
-
-	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
@@ -587,7 +585,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 	 * amd-pstate qos_requests.
 	 */
 	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
-		struct cpufreq_policy *policy = cpufreq_cpu_get(policy_data->cpu);
+		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
+					      cpufreq_cpu_get(policy_data->cpu);
 		struct amd_cpudata *cpudata;
 
 		if (!policy)
@@ -595,7 +594,6 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 
 		cpudata = policy->driver_data;
 		policy_data->min = cpudata->lowest_nonlinear_freq;
-		cpufreq_cpu_put(policy);
 	}
 
 	cpufreq_verify_within_cpu_limits(policy_data);
@@ -678,7 +676,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long capacity)
 {
 	u8 max_perf, min_perf, des_perf, cap_perf, min_limit_perf;
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata;
 
 	if (!policy)
@@ -710,7 +708,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
 			policy->governor->flags);
-	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
@@ -824,28 +821,23 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 
 static void amd_pstate_update_limits(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = NULL;
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata;
 	u32 prev_high = 0, cur_high = 0;
-	int ret;
 	bool highest_perf_changed = false;
 
 	if (!amd_pstate_prefcore)
 		return;
 
-	policy = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return;
 
-	cpudata = policy->driver_data;
-
 	guard(mutex)(&amd_pstate_driver_lock);
 
-	ret = amd_get_highest_perf(cpu, &cur_high);
-	if (ret) {
-		cpufreq_cpu_put(policy);
+	if (amd_get_highest_perf(cpu, &cur_high))
 		return;
-	}
+
+	cpudata = policy->driver_data;
 
 	prev_high = READ_ONCE(cpudata->prefcore_ranking);
 	highest_perf_changed = (prev_high != cur_high);
@@ -855,7 +847,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
 		if (cur_high < CPPC_MAX_PERF)
 			sched_set_itmt_core_prio((int)cur_high, cpu);
 	}
-	cpufreq_cpu_put(policy);
 }
 
 /*
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7fe0981a7e46..dde5212d256c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -210,6 +210,9 @@ static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 static inline void cpufreq_cpu_put(struct cpufreq_policy *policy) { }
 #endif
 
+/* Scope based cleanup macro for cpufreq_policy kobject reference counting */
+DEFINE_FREE(put_cpufreq_policy, struct cpufreq_policy *, if (_T) cpufreq_cpu_put(_T))
+
 static inline bool policy_is_inactive(struct cpufreq_policy *policy)
 {
 	return cpumask_empty(policy->cpus);
-- 
2.34.1


