Return-Path: <linux-pm+bounces-18860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A39E9E70
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EF4188891E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C519CC05;
	Mon,  9 Dec 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FoxWe1mD"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CD19995E;
	Mon,  9 Dec 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770405; cv=fail; b=etaAeMAQOBAceVhmRDWHodwtHMJXM22ITM5KB6TCMFPZ+Kx8N5NrkDvHXVrlF+ec4y5AcPOr0CGVYlXrUL/bZYzU+dbZMLibBAttJHQ8vGamK3DUiwsW5whA5JcHlvC4L3okKNZcafsIYrRw28Z5mcl5JFuApb4nKz8QeNbewuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770405; c=relaxed/simple;
	bh=gQD6FKH8emXlgFIFhr0PiLn45yqwPWOHWKiQb6b0N2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jM/Iys/2D63KFx9R3Nv1+4HUznvuZCs5dHS/QVNJgt5Vgz/XR3A3HgdrnFkMK+TKCfLilnjjIibJ/Ldp0HLtD8SkRESHEVd6yl0miAvjASQAcnGFUvpfJwWHjf2wI9MuAoD/AW1onJADM+TvdAg9HlCXSLE7aGiE1UUrvUSbkZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FoxWe1mD; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1gaSjl/tV/esKaoPdmtS38l1X8nqDl//gpqPufBNvMkzfKnF6F1ChHlTsKAE6lPdc5fM5NEaBpWv6mUov0qgjP8ckyNmyTvRevLViSBsZkBnblcJgEIVEiMTGmxFke7Hik/GFdwp3RISKl1hQJdyeKQOtFfihUQ2MEf6Y5xNa0+y3HJ9yKPBOvDaUdSD424/Z6RH3+NMxgdaMFFXnDkHqACw3bRXVIbmrzrh5QMGjUGDrNIKEpAse7vvXi02Zh/Pzg39UJI+vcgiW9DJNUw/DRvLKzuVCmlMKAz79eML3euYTuQZQnNoYhjP6vKJEGNnCen9qqzZdvw1DSr5Kv2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/32xu1DW/wwZdkvQdgmLaDFVjzOuUKbMneyzk8msQaQ=;
 b=VV1xrJkZrCxNzIt/lTjNAiTb01nFH1vDmgJFsPk48Vibrpset8gfq5K44onpetDrmYQ7NeiKX2cOtPIMPUxMrhYpYVyy3ubYJkl8j8+mYGqKHS5p4PMiSfueuhzvSf1dvkycHnNsR83FcPyPK+lgOmguI9vg2ngrzLSS/v8wkChRxYdEX5sbksQFRx/M3aR3J0ok6Ge7SV6q5Yc4mVbjyR14V+92tlkeePnNGjgSIvFpdxGIpUcR5zYd8R1+7fioH484bmzIrC1mIT1LA/vTxFi2I3DSWHFNMf5X+teMk+HXYwj8ppHndIzO+hA7eBUyVvxX+ep0nniPRdsuWnciJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/32xu1DW/wwZdkvQdgmLaDFVjzOuUKbMneyzk8msQaQ=;
 b=FoxWe1mD9G4aeMpxYgbGgbcmALS1ElAndDXd9Kjy4IkkBuI8+aGfBpWLVi4IpXhiEYDornDSbvEi6rwd5C1NecOVMAhvkQ5wpQxDLPE0wHb3olJiyZRjhc7zmsyPlxLMkkOMRr80uqKScoE4tZyqClgkiiTZFRAFBOJDsQoaEM0=
Received: from CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::21)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 18:53:16 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::c9) by CH5P222CA0017.outlook.office365.com
 (2603:10b6:610:1ee::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 18:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:16 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:14 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 12/15] cpufreq/amd-pstate: Always write EPP value when updating perf
Date: Mon, 9 Dec 2024 12:52:45 -0600
Message-ID: <20241209185248.16301-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc00e30-29dd-408e-143b-08dd1882bd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwsoRYbldHTNg0Vc9ru+r9zX6yxM34GSADILwPsdBH0peW7YGZP8zyZg9gqU?=
 =?us-ascii?Q?3Ca8UqHNPE8K800mSULd5wpMWPfedsWKnv8zR3Y0PSz5VsEc8LZ2pRWFIUz6?=
 =?us-ascii?Q?z+rGYWaSGuiD2r6BNOyl/7Q4PKRxh2kto7LGIUGGC/YprCJpCE6mA5zukdV3?=
 =?us-ascii?Q?cSUJ7t5BeoU4engsM2frTLbbmy486su1ufn0hGLArBJlT2qtArfIUQ+zOeUx?=
 =?us-ascii?Q?Pv/xIRXRZ9RHom/pDu+3Gi4hRfqV62gM+rRk5QSIDktPq3ZQuJ+hYbl0Nx+t?=
 =?us-ascii?Q?N2pO1EDlpEEZx3Rmz3aH+sulS2QCKkfrUMzNSKFgIAz4mclxXlj0OTm7HS3s?=
 =?us-ascii?Q?2yXSJNzoRdLzjie/BIw2C0hJBzBXYukNHcO3Q/lUVEOOLUufeOYc48tCGTRM?=
 =?us-ascii?Q?DyRYLTRLL3eqdtfmcnCaXtCFzg0gW1MeUfummcX7FnFfrrrZDyafMdGepszD?=
 =?us-ascii?Q?Q7La0gTTNNH3sFTBkvuyN8FQYliIHwkyiBErL0xj3F7F7A/UWt1urPoeTj06?=
 =?us-ascii?Q?chbEAEPD/pDl3A8kJ8plCRzh4foV97bY+yFTnF7ZvuOi/FqGJO+wX2hFWXTD?=
 =?us-ascii?Q?03GAd17bFHi0anjV6Z18ChthlN8CBemDXs7naL3qURnSGXFZryY0BW1b8v4s?=
 =?us-ascii?Q?YlpTVu2zvN2KQkhrcDh9qKWO3QIZ3/AgGo+MA3mpCpll8V4rlYLAHh+VYxzw?=
 =?us-ascii?Q?crsaGqqECasy+/4dITJSDYt/9uMbwtIfGNvkTZetvpwkLF4Iu3V04VEaLc8K?=
 =?us-ascii?Q?YXce1TI5E6jvFtiVkt+vlspmPIGXZnahwTijO0dfOviS/8bi/8W7edq8xLZP?=
 =?us-ascii?Q?JKjt9DjS5WN4paKHVeXap2uOqbecaC+2RuXdEXxMfdwxe/rLaqa36Lp7UsDE?=
 =?us-ascii?Q?1tN32JzVFbVWUw82A1578sKrficsJ1N81YtzrOYQrH1o6C11Hw7JxFh7jIHp?=
 =?us-ascii?Q?BDLdq2Ll9TxH3kGpP521qRnQJk8MAHt6eU5xH2pCHlNkM80rV2Ev2LEsSelQ?=
 =?us-ascii?Q?M2ZvwSyR/hwpMa8EHE6JjuuKoJMHU/vbSc2w2iFSF64BKhCeo/miZwh43eh0?=
 =?us-ascii?Q?sQiM3auzB1TF6fasqp43kzLZOln3W25xxhI27jInaXQ3YF+fQ9w4GNqWqF0K?=
 =?us-ascii?Q?tRL8b+0BLBfTtYRoVzJnhq+3SVFAgrQBxmJb4DvLb3vNYLkUl+HeS9UdwaU2?=
 =?us-ascii?Q?2FIc9Y5x2mWMNL2LnvVwOrNZkb7mSSjmq0iFzg9flppTmhcrF0/Bbeoq78hV?=
 =?us-ascii?Q?z5lhKTHclze6FGL2PKHWKIM7iGsmNQtB1rYdH0gHvjdKdVCMiZ73Qdfqmcd+?=
 =?us-ascii?Q?M223fIcPzXMP5NXK6vz0zxh+3zQJV2B5TpzF/IN4DNEn+a1HZRCvlyZRF3Y2?=
 =?us-ascii?Q?K29/uby4r/N5rpXhKyw45yTiT3t8EVRrLWENcSkhJLsumQd0PqY2B61NX0Wz?=
 =?us-ascii?Q?gdzBscndzfjUsJs2yuV4LYEP2GWL+Iis?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:16.1151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc00e30-29dd-408e-143b-08dd1882bd97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897

For MSR systems the EPP value is in the same register as perf targets
and so divding them into two separate MSR writes is wasteful.

In msr_update_perf(), update both EPP and perf values in one write to
MSR_AMD_CPPC_REQ, and cache them if successful.

To accomplish this plumb the EPP value into the update_perf call and
modify all its callers to check the return value.

As this unifies calls, ensure that the MSR write is necessary before
flushing a write out. Also drop the comparison from the passive flow
tracing.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Squash
   "Always write EPP value when updating perf"
   and
   "Check if CPPC request has changed before writing to the MSR or shared memory"
 * Remove extra write to cached value
 * Add comment explaining why updating two cached variables
---
 drivers/cpufreq/amd-pstate-trace.h |   7 +-
 drivers/cpufreq/amd-pstate.c       | 108 +++++++++++++++--------------
 2 files changed, 56 insertions(+), 59 deletions(-)

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
index d21acd961edcd..fc0eb268c0335 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -222,25 +222,47 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
 }
 
 static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
-			       u32 des_perf, u32 max_perf, bool fast_switch)
+			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
 {
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
+
 	if (fast_switch) {
-		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
+		wrmsrl(MSR_AMD_CPPC_REQ, value);
 		return 0;
+	} else {
+		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+
+		if (ret)
+			return ret;
 	}
 
-	return wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
-			     READ_ONCE(cpudata->cppc_req_cached));
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+	WRITE_ONCE(cpudata->epp_cached, epp);
+
+	return 0;
 }
 
 DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
 
 static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
 					  u32 min_perf, u32 des_perf,
-					  u32 max_perf, bool fast_switch)
+					  u32 max_perf, u32 epp,
+					  bool fast_switch)
 {
 	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
-						   max_perf, fast_switch);
+						   max_perf, epp, fast_switch);
 }
 
 static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
@@ -261,6 +283,7 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 		return ret;
 	}
 
+	/* update both so that msr_update_perf() can effectively check */
 	WRITE_ONCE(cpudata->epp_cached, epp);
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
@@ -459,12 +482,18 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static int shmem_update_perf(struct amd_cpudata *cpudata,
-			     u32 min_perf, u32 des_perf,
-			     u32 max_perf, bool fast_switch)
+static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+			     u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
 {
 	struct cppc_perf_ctrls perf_ctrls;
 
+	if (cppc_state == AMD_PSTATE_ACTIVE) {
+		int ret = shmem_set_epp(cpudata, epp);
+
+		if (ret)
+			return ret;
+	}
+
 	perf_ctrls.max_perf = max_perf;
 	perf_ctrls.min_perf = min_perf;
 	perf_ctrls.desired_perf = des_perf;
@@ -510,9 +539,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 {
 	unsigned long max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
-	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
-	u64 value = prev;
 
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
@@ -528,27 +555,14 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
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
+	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
 
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
-
-	amd_pstate_update_perf(cpudata, min_perf, des_perf,
-			       max_perf, fast_switch);
-
-cpufreq_policy_put:
 	cpufreq_cpu_put(policy);
 }
 
@@ -1544,36 +1558,24 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u64 value;
+	u32 epp;
 
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
-		WRITE_ONCE(cpudata->epp_cached, 0);
-	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, cpudata->epp_cached);
-
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
+		epp = 0;
+	else
+		epp = READ_ONCE(cpudata->epp_cached);
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
-					  cpudata->epp_cached,
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
 					  cpudata->min_limit_perf,
 					  cpudata->max_limit_perf,
 					  policy->boost_enabled);
 	}
 
-	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
-			       cpudata->max_limit_perf, false);
-
-	return amd_pstate_set_epp(cpudata, READ_ONCE(cpudata->epp_cached));
+	return amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
+				      cpudata->max_limit_perf, epp, false);
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
@@ -1602,7 +1604,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
+static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 {
 	u64 max_perf;
 	int ret;
@@ -1620,17 +1622,19 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 					  max_perf, cpudata->boost_state);
 	}
 
-	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
-	amd_pstate_set_epp(cpudata, cpudata->epp_cached);
+	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
 }
 
 static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
 
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
-	amd_pstate_epp_reenable(cpudata);
+	ret = amd_pstate_epp_reenable(cpudata);
+	if (ret)
+		return ret;
 	cpudata->suspended = false;
 
 	return 0;
@@ -1654,10 +1658,8 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 					  min_perf, min_perf, policy->boost_enabled);
 	}
 
-	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
-	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
-
-	return 0;
+	return amd_pstate_update_perf(cpudata, min_perf, 0, min_perf,
+				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
 }
 
 static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
-- 
2.43.0


