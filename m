Return-Path: <linux-pm+bounces-18758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7CB9E83FE
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A26B281A66
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC16215535B;
	Sun,  8 Dec 2024 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oo2bqOk/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD115252D;
	Sun,  8 Dec 2024 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639470; cv=fail; b=iuGBgfsEFnb+CZIwt2zUg1fAdByOefvoUgJJCd8Z2iALqE7HHfORPjTk/nAzQb6ptMlkU50Weed6EowN9Ld43dEY9eA2mESRkbOcFLjBG5b33JziFSJ56HsLMhu7h0jHi1abYG35noHVzifcpYzilxXNsXknp4camIJPNBwyymA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639470; c=relaxed/simple;
	bh=43TL3DHGRjw+j9diIktI+q56Yl9i+laB/64pkuVkpOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdsIu6svPDnClyenk5ycnPc5VBjMr2uPhtfWO0Nzdhvru+7KYuXWMglyYB/Vy/w0a5Xy7c/jfVbTVR/NX6IwRouoMC+PNCUNgcj7taBBsqQzCxx5fAZZLZsTEjblrI1I5LDcDwzhSkb4jvAYJLVw38dCAE+eF6/nkdCuX0/3jXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oo2bqOk/; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSJ2QjroaGOmP2btEApmAnB5BnwKbso9ZbhfqPfVcB0WSPVsU0Ldh4P+vxs6rsbYCnKyh4dEEL7uocJHliYEYzUHoo+doH/8AAApg8XKtOad688Ui91J2flK457K9vDxVjx9EwLI10t9uQjwstt7HJ+31bHIF8al4RP46TU/StT2+o5t32GJF1pEHEi0O+r/OcQ/w8rmY/NaNXgCOr/FrJCj5S3XJ0OoxvWqGsVyRlsTpRofjyNK1h1VFEP95ho5w700xAzs6Kc45S482w/5H7KW8Y3jlwgC+8an1lRnijHKJ0m8csn6keF3sj6VoEKL0oYY6HOCxQkY+nYBNib5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUC+b8LOZP/8cay9I9MUBpDDVjIaTiTwK0NIxMtU08M=;
 b=I+XdglXE4CFWQwUSrMVdwJQr/+yVeopas4+Fh1g0nshL3VGEKvWvePFW46dV8rLXT/8GjRUY4ZfsaW3sLOR8ikNzwlYvpguUGfNjinv5W95uPaQo/o4z+jSFo9rh1mt4UeuWIFMnSb8a8FCjlX+ieV0kvIfkyhQbcFValQy4jqbE1jTrV8jQnvRUASwGfvnn7laH5m3eH+s0VcdoKm82MWD213Cf69lmnofGsNhCB67ok3i7huQO3HNQELcIRcWY8TSAabZPIrEXJ3+DFzLAQcf49eFOsWfwTvW17ahVpDR3avnfUYdYHzrp49f/oO/CRcPHXCARzlwqKNvnUP6v7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUC+b8LOZP/8cay9I9MUBpDDVjIaTiTwK0NIxMtU08M=;
 b=oo2bqOk/Mxb6dkVTlbVXhKTG0Xtkcv8UnooQfduOu6zQIYA0OgtlP62B9XKxwbDgVobqs58txVXvpyfjOOza8GGeDXzfqQkNZUuCi2wAnwzSi788OznP7hlpqJW7Q/BN38DHSt7txroKYSkxUNcf8D/3wnEfJv4UnODyxNy9IeQ=
Received: from DS7P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::10) by
 PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sun, 8 Dec
 2024 06:31:02 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::3d) by DS7P220CA0006.outlook.office365.com
 (2603:10b6:8:1ca::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Sun,
 8 Dec 2024 06:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:31:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:59 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Dhananjay Ugwekar
	<dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 13/16] cpufreq/amd-pstate: Check if CPPC request has changed before writing to the MSR or shared memory
Date: Sun, 8 Dec 2024 00:30:28 -0600
Message-ID: <20241208063031.3113-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 850b5825-0894-485a-1198-08dd1751e315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4dOW86SQi3LS5biDz4Sz1OP1/tF/KgURq/k61CW5jyCjm/2X6NIPue1ZkGXU?=
 =?us-ascii?Q?w6kUCO65xGQwW90+tIElWc8E4pxxYsCi213TeIlxqk8Z8yZOTSaAwpU6Of7j?=
 =?us-ascii?Q?xAkPXx8U4iE5qmfqnat6zGHmDWI83ugsPdW+vKkSGiMsb7EaQdu5OOdlGS8d?=
 =?us-ascii?Q?JJgDQyq4XL0k2UMCIhmQxZXXu4tUSi2J+GmbV+mfrHD+MteC0d0GUkHKLzcR?=
 =?us-ascii?Q?FzluJ4KprORyjygD88/AzLmiru0+fQVTAfHSzZ5/T06KkUqO5q/zdW3PSDao?=
 =?us-ascii?Q?qDDKBHvBv/YIc0CTAs5wxxoKpnps9RibXu7SVwyx9DNTGfVLyEpEUPLfWhlp?=
 =?us-ascii?Q?/2jN6ADxaj4ideDeRbHiaTuaBfHNHb8TIlXuW5evnfsf1ZgGAMdDJIOi1Yu6?=
 =?us-ascii?Q?HYO3ND6uu99oR3195Zf2fo4vKR7jhRkSQvKSUYzzZ6weIY4/XivtNrTZGrFi?=
 =?us-ascii?Q?CdJsg5V+1uM7XqTqT/reCEOjYcJbbMNk3Cu77JKpYnIM44RR3sk9E7R78X1Z?=
 =?us-ascii?Q?iOqIKA3gLnN74TvtrjuGhkFJcQU7H8PTfGljzVO/WBfGbHZWptRNYKsWth96?=
 =?us-ascii?Q?5DKjsjisXWiNM1X4hDgL/R3NR9PveirdKcDkfWCQa1c4OdowwvC08HUf7l5y?=
 =?us-ascii?Q?qoz9veZ1FMoHMKh3uW7uOL3+liN/2AsqMsdoymmdA2PHDOSm/Nn6FB1H+M55?=
 =?us-ascii?Q?tIsiWfKblKRB50comHMP+pSQCneF2tsFszS9GCal2M/oaQG5blYUP2Ra/I9k?=
 =?us-ascii?Q?FqnYFBu/mV/qsnX/ymqdU4KvpPVzuQkCLKNrQoFtg71WJlgawjMV3jBua7FK?=
 =?us-ascii?Q?PsQbGKLc7S9/Z2/zluKrsi5LqeQp8hLSO/L83H5iNYWgzG3GVmCmQa8zP2wt?=
 =?us-ascii?Q?HW/OTjLsndCJIymzHLK2q4W/8XGIgS4T3osCb6NTlJIDanv1a+czckPUWw7z?=
 =?us-ascii?Q?ELGZrMQevIgeNz7jtdr+meH7GX8P4G/v5EI+4cW5QO+9mHhpSLw08zJYC0Yi?=
 =?us-ascii?Q?eL33wPeBRh61Zr7AHcMdrwD5a2ljxcPMMEZRETAQxdyk7LJR8fg7Kv2+VJG1?=
 =?us-ascii?Q?6tNrFScY4N0DDwza9IfrbxvWZXuj+zYhicuKKth/0days1U2GqAqBni1FYLY?=
 =?us-ascii?Q?ANmOJJVnPv3J/sVqmr+mYxZLHQjN5rqckmsHlicybuxodm5lzlcXWPoiS00L?=
 =?us-ascii?Q?i1gUDdxBLKWKODEMBXjQYxH2iKNQ7eTJAtti9xyBh3m4Ne2v8Q7XOOJ6NC9D?=
 =?us-ascii?Q?iDww3qYnDP+1XDZK7tvQ7Zrg1K5fc/0ncyWdN4hBVEaYY/oOlpIE+cEIw/q9?=
 =?us-ascii?Q?pj0zsFmpKJiijA3jlDPcUfte1aWW8ICE3QcGCE27Yo0VmabHlQBaWT3n/bcV?=
 =?us-ascii?Q?SrZBYNw9UWAVzpzHhDFM0Vwbjo9ZYtGn1mZfDOE2e0Zs18DCiQTZCJGlVjjw?=
 =?us-ascii?Q?sFszPKkm80lxE8shmPTIhreP13GFjibV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:31:02.4358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850b5825-0894-485a-1198-08dd1751e315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032

Move the common MSR field formatting code to msr_update_perf() from
its callers.

Ensure that the MSR write is necessary before flushing a write out.
Also drop the comparison from the passive flow tracing.

Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-trace.h |  7 +----
 drivers/cpufreq/amd-pstate.c       | 47 +++++++++++-------------------
 2 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
index e2221a4b6901c..8d692415d9050 100644
--- a/drivers/cpufreq/amd-pstate-trace.h
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -32,7 +32,6 @@ TRACE_EVENT(amd_pstate_perf,
 		 u64 aperf,
 		 u64 tsc,
 		 unsigned int cpu_id,
-		 bool changed,
 		 bool fast_switch
 		 ),
 
@@ -44,7 +43,6 @@ TRACE_EVENT(amd_pstate_perf,
 		aperf,
 		tsc,
 		cpu_id,
-		changed,
 		fast_switch
 		),
 
@@ -57,7 +55,6 @@ TRACE_EVENT(amd_pstate_perf,
 		__field(unsigned long long, aperf)
 		__field(unsigned long long, tsc)
 		__field(unsigned int, cpu_id)
-		__field(bool, changed)
 		__field(bool, fast_switch)
 		),
 
@@ -70,11 +67,10 @@ TRACE_EVENT(amd_pstate_perf,
 		__entry->aperf = aperf;
 		__entry->tsc = tsc;
 		__entry->cpu_id = cpu_id;
-		__entry->changed = changed;
 		__entry->fast_switch = fast_switch;
 		),
 
-	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u changed=%s fast_switch=%s",
+	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
 		  (unsigned long)__entry->min_perf,
 		  (unsigned long)__entry->target_perf,
 		  (unsigned long)__entry->capacity,
@@ -83,7 +79,6 @@ TRACE_EVENT(amd_pstate_perf,
 		  (unsigned long long)__entry->aperf,
 		  (unsigned long long)__entry->tsc,
 		  (unsigned int)__entry->cpu_id,
-		  (__entry->changed) ? "true" : "false",
 		  (__entry->fast_switch) ? "true" : "false"
 		 )
 );
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index dd11ba6c00cc3..2178931fbf87b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -224,15 +224,26 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
 static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
 {
-	u64 value;
+	u64 value, prev;
+
+	value = prev = READ_ONCE(cpudata->cppc_req_cached);
+
+	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
+		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
+	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
+	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
+	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
+
+	if (value == prev)
+		return 0;
 
-	value = READ_ONCE(cpudata->cppc_req_cached);
 	if (fast_switch) {
-		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
+		wrmsrl(MSR_AMD_CPPC_REQ, value);
 		return 0;
 	} else {
-		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
-					READ_ONCE(cpudata->cppc_req_cached));
+		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+
 		if (ret)
 			return ret;
 	}
@@ -528,9 +539,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 {
 	unsigned long max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
-	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
-	u64 value = prev;
 
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
@@ -546,27 +555,14 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	if (!cpudata->boost_supported)
 		max_perf = min_t(unsigned long, nominal_perf, max_perf);
 
-	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
-		   AMD_CPPC_DES_PERF_MASK);
-	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
-	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
-	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
-
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
 		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
 			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
-				cpudata->cpu, (value != prev), fast_switch);
+				cpudata->cpu, fast_switch);
 	}
 
-	if (value == prev)
-		goto cpufreq_policy_put;
-
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
-
 	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
 
-cpufreq_policy_put:
-
 	cpufreq_cpu_put(policy);
 }
 
@@ -1562,19 +1558,10 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u64 value;
 	u32 epp;
 
 	amd_pstate_update_min_max_limit(policy);
 
-	value = READ_ONCE(cpudata->cppc_req_cached);
-
-	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
-		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
-	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
-	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
-	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
-
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		epp = 0;
 	else
-- 
2.43.0


