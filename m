Return-Path: <linux-pm+bounces-15577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9860399B672
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 19:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9C91C21105
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ABE1552FD;
	Sat, 12 Oct 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t8GQWwe1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420BD13211C;
	Sat, 12 Oct 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728755160; cv=fail; b=bAEFDogupVdeBhBNqJoIrblhR13u+7vpI0y6+TJbOot7h7PF7jsPIx4qULz0ZDKlbE0Nwi5WNzYLfxot+fMA3g+Qu89CdhV4NqJwk/VgNjA8myoquZ04jfAsUx17ZCpCgzbnqlg/BxCLNvOpN6PTLWuKoIlTVtEqHG4AwUYiRK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728755160; c=relaxed/simple;
	bh=4RmqTx0MI+2dnQwjze1H2Z0vRTLLuTC/kphpUfBN4mY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1nMFW8fIwu0zArhaxdKHcI8KvQSAPPpW/BsVJTZ45GNDH4D4m6criRQ172KCJdGLyD5UVt1ffwAYXAR0u1KdlDzOPqEHzydhgArBIWJiuW/YDNPJSvUg4BiBHPYNC7bIPThT3Cq44C3+Qk2H/CS4dx9LhaPCyrQDYc3UsPMfiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t8GQWwe1; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeXQIJ83Mh3cv77GTQvv88z+nVqn3xPouHRM2UwHdDxU6potmNLfVIoNvwOTIYppXtLzp5I0w6PX5yZuiMlMIIR2OqNEgtVw35oXm7DxWDIIDckna1oRvPOn+Bgkta/qU6DeV9XMLCp4sQaMNWA+rgWHXdmTo/v2t5ImObeMO2+r63pWyr9GVQ2xQAh3eddrU4an2fQg1lFDZUNh3aMtCWRRzp5mlNyGZlyrz+c7TJvy++OwYZggFXcZFLH67XP36FitQJUVWPS7hl1nixA2sgSdEW5+YfCkmnsXH3bR2iIjk4otorZsmEguHsP4dbZ8YqJMIyIK2mKiluKpOmZE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B52RCpTCb8NlzBlqTXOFk0bjPZWSW0QLt1PmDxYDob4=;
 b=I+6lK3tdpm7U6GYQP6yUOByctuGmixXs6Wx/UL8DQAS/UhF77aXn1o0kmA9LqPC44oDkuUpe7kZiHNxCfwn2QodEh49DoQqzikJHUHSD6QksuhiCVbWDeNp10Y2AxrDKS6Ge2xOVzpbXL/ZaZ6Cowx8yqETx3lUmIgOQXULGuMQbecRH90ZYOX9QX6tE67P2lyAm21Fqrp3kwptfLX7ocNmZ2dQ/BWD9Bpx+uyP3EAG0Ck/scDCf2CKmv6eF7x6pd3LVQooQpLCG24IRmlh4SflILn9ceDegoc+SZlahCjb+KuCPg+99nPOecRoBb93OgwwDja5RVQc4PP6xwoyt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B52RCpTCb8NlzBlqTXOFk0bjPZWSW0QLt1PmDxYDob4=;
 b=t8GQWwe1+L0Ci+yq3VZIfb5ih45zRiiupLBE54VedKj4oav9A9JKt72j/cY8cZHRLQliYTr9b3CvLxz5MjL/egfrN+ztWk8L3+IQ5hwgjuiG5vGgfbhwLP2T8oC+0HTROlPXfyqEkggTmpb9BInLEjDFtHPMSA4zTogRIfEt6gE=
Received: from MW4PR03CA0146.namprd03.prod.outlook.com (2603:10b6:303:8c::31)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 17:45:54 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::11) by MW4PR03CA0146.outlook.office365.com
 (2603:10b6:303:8c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Sat, 12 Oct 2024 17:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Sat, 12 Oct 2024 17:45:53 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 12 Oct
 2024 12:45:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/4] cpufreq/amd-pstate: Use amd_pstate_update_min_max_limit() for EPP limits
Date: Sat, 12 Oct 2024 12:45:18 -0500
Message-ID: <20241012174519.897-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012174519.897-1-mario.limonciello@amd.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d09681-f82b-4641-dd56-08dceae5b84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llsJqApD+4sh8spK3JuCdO1wWnaaJ6mEDtK4ESFgwWVhKnxpDsHDGWiKMv06?=
 =?us-ascii?Q?RsB0YfPZ1xdsXQahiXc9YfEAr0RttWehGsfZ0CVhs09nMjmoxrvIE5/4Vl8F?=
 =?us-ascii?Q?jZEhy1resYjELwvjJXfmkFIb1U9zM+gkK8/zppgVSDxqHiUg8AdipTb/FjG/?=
 =?us-ascii?Q?EnYLIhxLjRgLQfXziYkb4EoQVlc2BSPeuYHUPo+tMYsMR/JzEvS/kQMKIr1O?=
 =?us-ascii?Q?danWvUylaiLjCRgiDqbp4w6nWBerzl96qNSWsT/zmm+XiI5UJKrrlsfjSsYm?=
 =?us-ascii?Q?lFlVUH9JuiF+DpABoy+gmWPRQlcw4bA60s20siCCPqMM1V8VTcTJKA4U/rkE?=
 =?us-ascii?Q?5ik1rgF0AQO7tX+gpwTXkcj/C6+aCZ58srN+o7me2QjUF4A8T5q6ebXAUsmN?=
 =?us-ascii?Q?KxCPEWdhcv471FcL0pk0iiW57AHBEJJuTSTLD0SOsrCAr2ISU+6TQku0pED4?=
 =?us-ascii?Q?u29GkxnGFqjkBTFNhOvDFEH2BqQIYiuhKrXlN5L5pvjUDh6X3W/AfsdbIprk?=
 =?us-ascii?Q?oWMceSEgue7WDcgfFhzeecFNy86V+/FZwAllvuWxI5CAF9axFytSwIg4zUNt?=
 =?us-ascii?Q?hXXtIWvGLr2VZpqE7SKSjGkd53p5aBCnG3mjhHrE2psQC4UIAGHX3oxQ4DLT?=
 =?us-ascii?Q?UM/vjqfHKXzNcZz3vFgabi8AN6gOD7g1JoaEgEk1fXOzAaOm3xlS4ErlTSan?=
 =?us-ascii?Q?Z91nbV2KHFY8iLmiNbFsfcufAvkRoqdoEML0/ikLjSh2aSVOyBNrhvbR1GDr?=
 =?us-ascii?Q?n6yxJytZ6yVYK66LCT64kBz+uvXrygQi10240WLULYNtgCQjZ0VV75UVxKKc?=
 =?us-ascii?Q?le5vxQGZ+V2xLMhjYoFYnRPKabm+iJAclURc8UKlsbTBxWoJHVBIWeAIXLLg?=
 =?us-ascii?Q?oMxmGkDtWnlpzM8owZ38AyNR1t8Rq+Lr0pqK7mjg6URZ1JT8R3gsgFRYDCBR?=
 =?us-ascii?Q?xrgHcTyH5dOwaiPrrFNxNL6Ox+TezrT2BTT+qLMGxpQ/csO2mA7ZPqAu2BjB?=
 =?us-ascii?Q?Gbns7fuYCp1fZjZQIi6dtBlZItMNNuK8KfYXArouCGw1TYXoXyzwp9k3VF4L?=
 =?us-ascii?Q?KC+7lK0DVm4t+SVj9AYTPQgGP/lAtWjSko8m4YXrannBZay1bi+0HDeDeP2q?=
 =?us-ascii?Q?WIrKtzdqGltBbs2YqPOdKB6SS47W/gsOxmZb6XTRMIJV475ZP70z2CDfqg29?=
 =?us-ascii?Q?J5pDBjvVx+tIcGNqXjLtYZ1cFMG/NgiKYh28WOAq3VbTHTyc9VwTZfrWKmKC?=
 =?us-ascii?Q?ZYWoxSCJAqjDxFkAmGolq2NAHMQgaJYjY46yuqdS9T2kvXmjRs/1ve8hgSk5?=
 =?us-ascii?Q?9h0GL/nKjEGBhOqLUliP3cFQpiO07FABC4GaARnnhvUPE0rCrByvk60W2w4f?=
 =?us-ascii?Q?lstYYcHEv8X5jRaCtVeDPCKiq7J1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 17:45:53.8882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d09681-f82b-4641-dd56-08dceae5b84d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

When the EPP updates are set the maximum capable frequency for the
CPU is used to set the upper limit instead of that of the policy.

Adjust amd_pstate_epp_update_limit() to reuse policy calculation code
from amd_pstate_update_min_max_limit().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 13dec8b1e7a8..8d2541f2c74b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1485,26 +1485,13 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u32 max_perf, min_perf, min_limit_perf, max_limit_perf;
+	u32 max_perf, min_perf;
 	u64 value;
 	s16 epp;
 
-	if (cpudata->boost_supported && !policy->boost_enabled)
-		max_perf = READ_ONCE(cpudata->nominal_perf);
-	else
-		max_perf = READ_ONCE(cpudata->highest_perf);
+	max_perf = READ_ONCE(cpudata->highest_perf);
 	min_perf = READ_ONCE(cpudata->lowest_perf);
-	max_limit_perf = div_u64(policy->max * max_perf, policy->cpuinfo.max_freq);
-	min_limit_perf = div_u64(policy->min * max_perf, policy->cpuinfo.max_freq);
-
-	if (min_limit_perf < min_perf)
-		min_limit_perf = min_perf;
-
-	if (max_limit_perf < min_limit_perf)
-		max_limit_perf = min_limit_perf;
-
-	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
-	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
+	amd_pstate_update_min_max_limit(policy);
 
 	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
 			cpudata->max_limit_perf);
-- 
2.43.0


