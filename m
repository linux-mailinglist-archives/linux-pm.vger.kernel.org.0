Return-Path: <linux-pm+bounces-18848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8407A9E9E5D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57489282734
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E936F1957FC;
	Mon,  9 Dec 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S4D+G7of"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212B187844;
	Mon,  9 Dec 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770399; cv=fail; b=VdFdcEZwcpnQuPiGtHO/zdzPZPZrjEQLkWlkdwF1mOWJpRKV011aw4qe0nDVOO4bjfeBJuNfw+L6FHCGVZ3gMk1PCZqoYFp5dSdwC24rqPaKUIwiO3Y16/TjI1mC11hLkAlxxlI7NjcL2pXgLXuS16Rf+YMG7ASl8sgnaBNrZ8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770399; c=relaxed/simple;
	bh=6MTHRL5MHUSp36pwBet7p28UW/1GIbDwH06pyPCfy2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUXGQ7sIBpqWD16RmtjcMz637bYRK+qzVc6PqetsbddJ1IzrpylJkG9vUdWnRm3mWSaY3v3Csa/MGTtbSsZBlozw4H1kEAR8VNCCIoqdc2wg4pzSORO8NNXij55gf+j8i7VxnkQuITwicp8LwNLwZYV1oHAIxTPUhgREVCj90R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S4D+G7of; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMteiD9Gv4KCZf15kWg2A/SaE+eXT3lkaYH+N/YLq342e/Zkb2K3vCQ8dNZf81wbJj+PpvPSULhC0hfSjUi7+pY5bnIIYnjYRK4uEsJfzB/CyfzULP2z7rSMsSDVynMjlrSJWWBSv73JGLj4fdQgH9PR9i3SyLq3WdBJB8mEIYxmoWPC4Djd4DPEb2xQB1G5qfxEdhGtt50fuHTg2LyxK6N1kz7SV+COq7CeIu7DAuZkC6KJAdWcwHVaXDFBZBwywmT7kSGh5ozioiuC5wKpFnpM/kmp+y/KCeXwYEkpowuuC6HENM8ioIvTE+IFHm9bTuXPIZUUJtWHEgIIBmEocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saJk+iuS5VELA3XAGJetWjnvUPeLQzFGvShlQkEJD4k=;
 b=RhAiLb7Onxe96DvyXV6uOteMRaZlpI5eMAaY89gQ6yLB4JsRJ+m7LAIq3CaEQNV511WQR8WjQQAnW0i4qxeYY3xJy1uM4TJgAjxbpwHNK88MmcCGibpi3W+kLG5CRm5jiAvFKtVvsTyjhnMBBab5X78hJd91YCRpUUS7L2kwh0TNp8BTrRNKk4b1eHyoMfKv5ovOauroZ2NeOlluqI1zCV38reqUccQUAqY26FRaQn/LUC601st9g2Uvcb74oEp0qYgOuHh5Cnuh2yQxcKjy/InWoVJBVK/08mWIpl+gkIV2l6CImYRIkML/1swDH8ATldSArcgzlOAb2V2C1A0vWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saJk+iuS5VELA3XAGJetWjnvUPeLQzFGvShlQkEJD4k=;
 b=S4D+G7of+btK1g3DdCwgFhSIca06ou6zL1paqgiZKrb4grgK17Yb6KBoCUHzSPuCA1asKyFkACwBVihvomO9LUqonn6DSHRJ7wxlX71qzv7dABa5mfslT+a6Ql8pUaxY+X7Nvxbkl45eqBlPIOJ3jI7EfblaIzm1NuoH9Q9w6jg=
Received: from CH2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:610:4d::33)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:53:14 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::d1) by CH2PR19CA0023.outlook.office365.com
 (2603:10b6:610:4d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 18:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
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
Subject: [PATCH v3 05/15] cpufreq/amd-pstate: Drop cached epp_policy variable
Date: Mon, 9 Dec 2024 12:52:38 -0600
Message-ID: <20241209185248.16301-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: b5318070-06c0-48b8-d2c8-08dd1882bc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qXqTKB/KBiZE+Zr0SEbW+H6Ur9ZoFpDxsjFkpu4ZHYb/A23Bvu+vBLa/8Qqk?=
 =?us-ascii?Q?VCrBVHIAQ2/ZnhInjjAGIkp1Nkn5Vf05yTU3VLYZwosHS9opwLrv3CL3cB2/?=
 =?us-ascii?Q?wg46iJB/mosezpM1C9ZhIygnVKYopC4/++FmXDvrl06pMfnGwTMkg9Q/6f9E?=
 =?us-ascii?Q?k7vXFLG/Of10M8TNIJTA3PDvoxEhgwAigQuHg2LnejYCLfPAp2QVXZmyeoye?=
 =?us-ascii?Q?1/p9Y6zOFSjRCR1mvISmWjyjZR9NFgTnP3Vfh76gD9+veiuaNKd/BYf4PkfQ?=
 =?us-ascii?Q?b77B0y+llR6s6nIOuA7VH7rZCUNTy5UeVZeizGqxgCbsI+Oo8QlYZi/DsRg5?=
 =?us-ascii?Q?i7cP9w10BzfXQa0dcLJryguScb8X9ufsojucXOiTHi9QN6lcmnan/VFipTT/?=
 =?us-ascii?Q?Sd+v1qZKZmFVZWKGHnQdZ2ChCU8UM/TctUz3M9zUSc1EPLk0m0PMjPfiXHQ8?=
 =?us-ascii?Q?gwtX/N7putevDoLCsirAUQFHJH4bHwfMuTzDGX7xWd3EMTKegyVTEcfG/TbJ?=
 =?us-ascii?Q?hwQh57FecJe68KlQlcA3b1kv5BqeqZnQim44UJw4p5kSMVGIeuRdQXg5m0qz?=
 =?us-ascii?Q?yVrE2SkJ2pFD3tl+GxLOHm4NdPz++v0Ah9V0KeXpA5cvCUdQ4KEwispPnHvU?=
 =?us-ascii?Q?wb47pUXxgJBjOWEC308s+xy8QP+Irqx9s/3RNl7rPRLQpOJLaWhkY5sqtuid?=
 =?us-ascii?Q?5TUAUBUZz6r+pM2MMV5oY9WhEQwMTBL71bmfO4RC1I+TUhc/dRaVv1XuVdZ/?=
 =?us-ascii?Q?NCUfFZZiTJdVs5LIqHM60nDYJrLbJtwKaLmh5CpufF7acDRAQ19J6s+Z6ERj?=
 =?us-ascii?Q?KvEnEOKEs685UljRIKqJXxvzS94Y4TWSIPUJJObDxPvb8W6ie7Z/1cYrYkp+?=
 =?us-ascii?Q?Lt8Chkfy2Oa9KOQqVv2DLSXTy7+iMxhTfHrLEtcjEh8aAW3gnpm2j8/zbRZi?=
 =?us-ascii?Q?FeQWUT4tI8Z3jWLZraPBKZpEe5mKGHqRAXQhU2jmVN5jZ+YQLsOJdkG9gSHI?=
 =?us-ascii?Q?Qj7caV4oIKesBocqZv5N3HFLBnAzO3MgNG7sw78GILVog/nMERxTQaHD4kZJ?=
 =?us-ascii?Q?WJ4lzDJ+tmIHKVu7udC906JEC0uX/To3nq8kMygAkNaupF5ETtoR0tSeob0w?=
 =?us-ascii?Q?m1iWWddb6MdQ8IHnCp8CrdiDGkBeJ/iVm5RrpMSXm0dyRQqQmw4dh17Fzs0M?=
 =?us-ascii?Q?M4B2CM36ZMImSBUZ1I2OM4rcQl72MftnYT+9Gm3KDFFy7TTx6F79Amxm7nRk?=
 =?us-ascii?Q?TESbEtSmGcQEoZSSI70SMy/GG6jgBjlwefefL6Mn4mTsCIXeJ806vpU1NveO?=
 =?us-ascii?Q?q8PEj6goVwxg3ng0GRjIy1Wz5g0dauEu5cEh2a4ZSpJuXLFmduppVXSNj95H?=
 =?us-ascii?Q?DEqePm/A3Gy2zRusDIvlmrUHBZ50wCuc13eT82Yli6HTqX1alOAyrnoGh9d7?=
 =?us-ascii?Q?6i9ivAL0cZFoufqpTw+3qvzKWT2h8wr3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:14.1932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5318070-06c0-48b8-d2c8-08dd1882bc71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207

epp_policy is not used by any of the current code and there
is no need to cache it.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 ---
 drivers/cpufreq/amd-pstate.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6a96d3a24c77e..dd25e7e615984 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1478,7 +1478,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		return -ENOMEM;
 
 	cpudata->cpu = policy->cpu;
-	cpudata->epp_policy = 0;
 
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
@@ -1585,8 +1584,6 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(0);
 
-	cpudata->epp_policy = cpudata->policy;
-
 	/* Get BIOS pre-defined epp value */
 	epp = amd_pstate_get_epp(cpudata, value);
 	if (epp < 0) {
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index cd573bc6b6db8..7765c82f975c6 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -57,7 +57,6 @@ struct amd_aperf_mperf {
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
  * 		  AMD P-State driver supports preferred core featue.
- * @epp_policy: Last saved policy used to set energy-performance preference
  * @epp_cached: Cached CPPC energy-performance preference value
  * @policy: Cpufreq policy value
  * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
@@ -94,7 +93,6 @@ struct amd_cpudata {
 	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
-	s16	epp_policy;
 	s16	epp_cached;
 	u32	policy;
 	u64	cppc_cap1_cached;
-- 
2.43.0


