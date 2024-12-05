Return-Path: <linux-pm+bounces-18654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821DA9E6096
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA10518847B8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453C1EC013;
	Thu,  5 Dec 2024 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0KAQ6tt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C331DE2DA;
	Thu,  5 Dec 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437757; cv=fail; b=jUGXICwGSFRrD7PnjFJofnvOReGPipEh72X+K/bDiSv95mvGeNJQ7vOm+FbFZlksjp1cHIxw4lNQfL9WJo5JJM/ECffY4T7uA72Vm3hc6euxebiDbAp7spE9TDQDu2YokICLky9AaLbGxcd+tjF8CD7CIWF0fcN64a0TYZcVFE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437757; c=relaxed/simple;
	bh=YYYHUYvbPy1fh2229NKgd+krZkRGOpClLnYayod9gMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8z2zyhkhYGVcsjeeBv0fTfgAuQF1jUs5BvDv9OjPqbM6cw7OFCwrIWSq43Dxdnyuepa0HMEXLRKNOqQnxDfdVTPWkSlSrpUg4Z1BWafCKWtwHWb4MdqJDPIy3DthmHEgrXvNsCpmrNAL7jHo5CKruDX7tvLciqdwMmnYhuUbhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0KAQ6tt; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g30PIL6VkLL5oGyu2hSoF3ovSWbeABHFJqXa/fUCGug653ecMMyqeSthp8N4gg7p2I5Le/Iwv/zb9ZLh9nlSEFILrP2lSmJ6/jNf2qjsdW2D3uvs2Z6UY3MToJc/hk/TDKGSe/Z57EdOR7/oAgKnGlbddIeV81Wj4p8g+n7ar6WQb9mpHxWBD8kyJyAmRs5mC98EgNGa+sv9mjtuzVDCNzicn/WsFpQwCPqTDnCnYMaYs1CjWylkpuC2E7xC6D4GKHmmZQWSZUO5wDTE3a0Er3E4DPhBPvqt8ofnQyy3ii3c/4hU6Ua3Jfvrgb2YMypK9ZRQG8txgvwBJ7rm/yd5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g6TPHrQEs9lMgdjM1V/pBGfAgYd3aTNpSHwa53/Teg=;
 b=elVJdnVoelL7+40GdTZ3KXT2AkrGYoNfoJ6ppuq80a3rDWNtWBW1fT+wfciEf8kcuwemParMNg9V+uQB+fY1Xg/WWuYeuRWCef8Rx/PkkUgDUh9Mu9TvHpopJRLaYwPPFxsTvEGSnLraOig27eZkfHDO68QpwrVvI4wgqT84Tto7Zd0uU5/gip8nFrROuzSjYs3vaye05w7JynW6QHhYFCtEDWoymadIdZaEeklCfbBy3nzGPRBnbzhLHi69YF0BHnsoVjjCkBLjN3kf9cv5lLw17lzlTjwgoy5PBv+35ou5LRQ8UqtdXZPxSK1Q9H9a32aQqcoOWg/Q4yQJCEOoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g6TPHrQEs9lMgdjM1V/pBGfAgYd3aTNpSHwa53/Teg=;
 b=V0KAQ6ttSww2/qfLfdNBBpQM5meQbAgJ7Krfv3HtDidfx0Uy5sGtUt9hZjHr9cFBU8mAxtndW8dE/ljG5Q7Aegpb34kIPZcY7ZM0jbFPpf/443a0OFNJvkkQnVnA0nkpnGaSDpaIzLGR+2XCa4k+/qmlny44wIcDLzHaRy6kyyk=
Received: from CH0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:610:e7::15)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 22:29:10 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::a) by CH0PR03CA0220.outlook.office365.com
 (2603:10b6:610:e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:10 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:05 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 09/15] cpufreq/amd-pstate: Change amd_pstate_update_perf() to return an int
Date: Thu, 5 Dec 2024 16:28:41 -0600
Message-ID: <20241205222847.7889-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SA0PR12MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7cf96f-674a-40eb-1fdf-08dd157c3d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n2FopBTgP6OnfngRwuEEixcci7NZpADBAzgI7mJdWiAhoxR1tBYsZrxb69O/?=
 =?us-ascii?Q?tJLGCj5fMb+45DeUNeM44YAtZWbYFqMeQ7qbenCe4orGV8alHFZt+EkFxKxy?=
 =?us-ascii?Q?o82rEXvuO7TQeFNDAI/mGXukxPBCyzB3RzX4ofhG9vSOJeBKlAZZM4QTErvd?=
 =?us-ascii?Q?uO47o58IgZXjoPAy+01i27z+f8ZCcViRDiiV6UCKz41eCmtxgv10oyAMXOHb?=
 =?us-ascii?Q?XlpYY4cVt7Sd92JuhdzeRKHznooDiOdOhKGwd00uPpBW4Jsb2TXDuQ7uHxW/?=
 =?us-ascii?Q?eByJkJz01WzGCy9fUG+o7RCO2stoh1tOezmj2t6AFKjeVqsUZ/FpPqDE9kGO?=
 =?us-ascii?Q?/LIfqzK3ladLd9iULuGjc7fGf6oEJxXXKbPlT9i0pE8oVGE+DCvt9krxeN5R?=
 =?us-ascii?Q?iHi8n3sxdY++fLyKpQF39zcD9f/w1QdftXruNFzLLky9/XWc1LGIpBkN7PJk?=
 =?us-ascii?Q?wosItLYzY2fStrZuRdQtzqSTmPfPHYYk4hGX6bsmIlkH9libDgA7Pf7aaJKZ?=
 =?us-ascii?Q?+bi8+lOhcJGQfuQ4iWoGlzCYC7cO+2dxpuRVQYzZVjRgHxiXkwljerKJ2eoq?=
 =?us-ascii?Q?CC9EY6B5+wiUu4FARSENy6kEkARwUd5ss+Cc16Csd6aLt25m+YwVWs5nMV8a?=
 =?us-ascii?Q?8mes7QtymR+QudjhI0pwCMRlUEQJmI4TMBGsDNfIiL6LYyUCLL10CH9zThPN?=
 =?us-ascii?Q?F7fBlulpec17/so23rcHtRDrFzDBZJbbWM32cb/1odBoILMoe94sFRjcPmzm?=
 =?us-ascii?Q?2n9NY2gjGn/rrIWMUYX+/PoosYduMSCAuxn/qNS+MOj9sAUg41eH4inqcSZ0?=
 =?us-ascii?Q?UJmKmrPc9PWFtUDxC7kweyb6PknResPNvnoj7bUAglzaiNf+LYuAn68b82G0?=
 =?us-ascii?Q?vA//Tmd+LK5QS3K5cfPunfTgh31L9+FY1wsSNmCmhCit5rFuQCoAGyBTjJQH?=
 =?us-ascii?Q?KsYA80wQtcOahLO2T6VTPoDUJn07v1TGP+zYEsC1/1ZIXOZTO2CKhR3vHe+c?=
 =?us-ascii?Q?JCiykAqnqhqZZSDtORrKjk77lAt51KMJ9Y5bn4cMj1nsXYf1VvPQuWE0DCBa?=
 =?us-ascii?Q?wGapndnclKJ1GfaEPmUJ2pb3pYII6mLR/zg2FTrlfjn5xCGITR4qqlI0NV1f?=
 =?us-ascii?Q?PAfCQw1m1dYTHfP0ornGWW4AN7/S+cAG10hLx2MvwIK9kGQlUVjDgyayNEUc?=
 =?us-ascii?Q?zo27Od6T7o4J1b/JJhz6nsTwFIOEIk5mTJ/2zxTTScpp4nbRcGXdkbIuPgKN?=
 =?us-ascii?Q?y6v5vN5LIGdocqCjSkJhFSfqsWLGnD2XcXekjDcNnjVhPoNj9wJWSEwSAEyD?=
 =?us-ascii?Q?VE8CnJKGLwkdRngB4Rv2B65+a2UHOgV8aIit/HoW9l7b4/zglqUMLaywz0Bu?=
 =?us-ascii?Q?qME5EYNJLPC42iE48IekQ0trtY0RAYf6LAQBXha+C/4jcqB8KGHYSACHuSwN?=
 =?us-ascii?Q?RrV8Runm69YEohQI23MUL9NiO3X+8KmO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:10.4683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7cf96f-674a-40eb-1fdf-08dd157c3d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477

As msr_update_perf() calls an MSR it's possible that it fails. Pass
this return code up to the caller.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 464db6745d84e..842e7e3c5eaf2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -251,24 +251,26 @@ static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
 	return index;
 }
 
-static void msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 			       u32 des_perf, u32 max_perf, bool fast_switch)
 {
-	if (fast_switch)
+	if (fast_switch) {
 		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
-	else
-		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
-			      READ_ONCE(cpudata->cppc_req_cached));
+		return 0;
+	}
+
+	return wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+			     READ_ONCE(cpudata->cppc_req_cached));
 }
 
 DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
 
-static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
+static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
 					  u32 min_perf, u32 des_perf,
 					  u32 max_perf, bool fast_switch)
 {
-	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
-					    max_perf, fast_switch);
+	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
+						   max_perf, fast_switch);
 }
 
 static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
@@ -480,7 +482,7 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static void shmem_update_perf(struct amd_cpudata *cpudata,
+static int shmem_update_perf(struct amd_cpudata *cpudata,
 			     u32 min_perf, u32 des_perf,
 			     u32 max_perf, bool fast_switch)
 {
@@ -490,7 +492,7 @@ static void shmem_update_perf(struct amd_cpudata *cpudata,
 	perf_ctrls.min_perf = min_perf;
 	perf_ctrls.desired_perf = des_perf;
 
-	cppc_set_perf(cpudata->cpu, &perf_ctrls);
+	return cppc_set_perf(cpudata->cpu, &perf_ctrls);
 }
 
 static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
-- 
2.43.0


