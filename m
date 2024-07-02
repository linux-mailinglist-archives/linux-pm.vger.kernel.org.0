Return-Path: <linux-pm+bounces-10368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF949244E4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C388EB263E6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87F1BF31E;
	Tue,  2 Jul 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LP/7BBDn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CB1BE248;
	Tue,  2 Jul 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940551; cv=fail; b=TiOzzm6RgZKmmnX1/Tiv1M5appvrAIo6AC8TVYZ/Oa3XjZnpPOnskge26mtIs1t8SmSjzkZ62g/QkxJ5DyECD2uQ56iJwMG7G258GPoXrXXlkjLADrYUJaXm7Xm9AO6VRBYnr0mD9A2uM445if1ZHyUJ6PyVv50zpj9SGNyfybs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940551; c=relaxed/simple;
	bh=yDSdeIXaHEWI0p+SVSp2OwVPdQbLc/kOng8lp3YQhiU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cvdo+2qaAH9XEjrHDghf4+KOQbwFHpOCUQAgfLVeCAjZAmoESQlSxM1CDqJNOAEylRTGWC5GGIKyHU2sNsmUmJzHb96Xcocpe5bmqp2TLsSDw3kTbz4RMMQXPSmupBcKVd/NpBzxRvSxpdWRC/xns3Tkl/f4P2ZzkQIn0QhaWQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LP/7BBDn; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxQ75zzA/Yi0scF2eYwJG7ERYGvegTvpjMxXbvbXBB9hJmX4ISjskycx1zYLQXkTVblj9PdjWlZ/YXxJRqSUgkbDqTPWJxU66ClG+gmmi1kvH+lzRLOYOkSZR+H6ZIMT2k4Tgrp19jzKL2Qx81CaFZ4+Ep/3TMXF4Hl5sn+jdT+IS/4Tod9xexMK/6duslut6vc4kOwlbahSslWIf5gu6GLU0+XL7k/PZUpyLvV9N4yzomqbjZroTykttCNDJCqF3cMzENuPlEqKKIZVrKHgAU1yLetay29o3ahgsTCQJkQkMha8AHT2TssUA1QoyVYrxbMYx3T+2kmHVlewdvm9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efGjyeGz+CX9Gb5D6Ag6M6ahh59pFv68S0tThCAlAJo=;
 b=BHE+v/vLxVTkHRCBcoO15VS5lsZhvK2yIIRFyEps0O0GMEGEmaqysD1xg/ra2hXzaxkps3XqfNoObd8bYF/R0DzrqGmcb9VcFrfBWtDI0vVIdvzAyHRA24zmvsdd50YSG5F0QckSCpLdiPkmgV7WaVBhsJN+8Br4FXTwZdnyLTU3cdL0SBPddb203PIBm401ovGrbDtGbFJ+Og851cvlA1mL3r2YjtE+0yQKhY+NRs1jVlMtgLYA0+f5DBhQGaQDnQVWYnvXDavLU9VYwk6nKBjKlGF4hj/YWDcvRKUcuLCYF55XQBosO+TTZboQad3rh5lXjLxtlesz6lGCUS2J1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efGjyeGz+CX9Gb5D6Ag6M6ahh59pFv68S0tThCAlAJo=;
 b=LP/7BBDnht2jpy7S8kewEV+coHdlvQs4CLtW+gOlom5SqV3sJHGCNug+5WWPJ8kqSsHKROxUd15SLBpHQe9GMvFhAQd/MM4aX+1dsYg+p4eWDSX6AIm6ONGbqSrXhJRm45YYiEsg7vBQ2X7jgHuM33Jp39saHO3YpfQPvZh9s9w=
Received: from BN9PR03CA0275.namprd03.prod.outlook.com (2603:10b6:408:f5::10)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 17:15:41 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::c9) by BN9PR03CA0275.outlook.office365.com
 (2603:10b6:408:f5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Tue, 2 Jul 2024 17:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 17:15:41 +0000
Received: from AUS-HP-PV-STX4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 12:15:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Meng Li <li.meng@amd.com>, Perry Yuan <perry.yuan@amd.com>, "open list:AMD
 PSTATE DRIVER" <linux-pm@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] cpufreq/amd-pstate-ut: Don't check for highest perf matching on prefcore
Date: Tue, 2 Jul 2024 12:15:14 -0500
Message-ID: <20240702171515.6780-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: ed11b728-fce5-44e5-4f95-08dc9aba99d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NdnVK+6ip4lKT3CXE2oqVO/5EWaRfW2eYtTenbFdlAw7lNE0YwX0p8h8Rt9U?=
 =?us-ascii?Q?y1ZO/qkWZuUEdt1AUBKTiITOmnM9XhffhKvq5LIUbutJ0HIagQeFbJcRXkp3?=
 =?us-ascii?Q?UFlUP5VmQbZE+Z8uProrag8M41UFH+fl/v+lbaOoKTiWXlHBhp5cYEsO9yCl?=
 =?us-ascii?Q?DPXkOGQQYtkvNgHzNicPRLG6CNxM2LS16bfEb+o8brHE4Ci3NXYCJT8DNNkH?=
 =?us-ascii?Q?vxDmawPJFMM8MjYkishGR/vHxU3+b3n7epZA8olqbFxhyInb2c/rSu/UN6D/?=
 =?us-ascii?Q?RHMZu3sh0glFrbIQ3VDGvTh7PCEr8L39pT3W81IC5193gi0clUCpUDamO/QG?=
 =?us-ascii?Q?naRpJeDYX/4SNRoyWrXj0EQSCW0+vWebg4XWX6MnE9/MNbkS+MOYDzOrcNlY?=
 =?us-ascii?Q?GvmRMVVC5HOiTTLU8q6r7LlX/T9Z8+x8h15CWMX6+hG66qKbnVeUQ8UhQCCg?=
 =?us-ascii?Q?4rfI+W4vvrhy4wslhxFQQ32b/vWmF91NeCGvdnLLugx5497GRcMjBOQf2pzq?=
 =?us-ascii?Q?FaBp3EgYQuOrVVayZbFE5D2qVGfp2kHLv59+Su+FgbgQrNfZ16UEU+mK7uHC?=
 =?us-ascii?Q?TsbPcZY3ECYm5d28DGFzF5sbCoiAcd6hfZG9xXPLLSnf4ygZplIMxAFFGcN6?=
 =?us-ascii?Q?Cl5JmXNLKo8dH+0QFw6PyajEbY1MvdjEYEnrb+xuZTukkxqYNpk58B2zwXTs?=
 =?us-ascii?Q?CYI5TR3zL4i9LpVtS+Q7MHf5bzgNFS/g3TCSW6KvoIWfX1fm13r4Mja+OFV0?=
 =?us-ascii?Q?8ea1Uv4Jo8KfGGNiMNj+hIxKTrUTDHmHi+Euq/FreEeN72nK2luaz+Z9Zq1j?=
 =?us-ascii?Q?ZeTUpFYcR669hEauFg9JXjkAfiiC0WI1OtHHpuMo4JJBhoindqRav5h9XnWS?=
 =?us-ascii?Q?a+gnk3+fP5basIGcGC8koKJLKa4NtGSShTwwmpu/S7oc9Elkm2CVxzdnqWrc?=
 =?us-ascii?Q?qfUiNixfMgoUJJdQigVTnyBvroaSaWJDJLGcEg1kB3EKX6q6QDHRDOlpJn+O?=
 =?us-ascii?Q?A4aDpMEzjpKB467TApyZYVUNegIopONS31+Hvbze1Cww0XlkQPlUFB9Q6iXH?=
 =?us-ascii?Q?Ws5owBwaUlu3WGFdRg2Z078dC2IRgxycoFwW7FlIFbtbc20TnBAeFG4zVNwz?=
 =?us-ascii?Q?5GN1JFWEMaSgVxC+67Z6kLZxIvwRKf6kdjeC9IJlIC40E5BKlU7DKSyp2e7p?=
 =?us-ascii?Q?Am8/r/BB40VJ9p9Sj3WaGFSIeV/XQC62OPLU19d6QCssGtxbq5wH4FPe2L+w?=
 =?us-ascii?Q?L8/TeDBJS+fNROc4j2Z1NOdZCJCcNXqs9Q7VwazVaINDq+jfJDPGE2+JwM7l?=
 =?us-ascii?Q?KC0InY6psUN/pZ7e9xFQMGzWCxsU7t6EWfNAuRpDY7CbBaxQFj3k2D6GlQf5?=
 =?us-ascii?Q?GpJRFNRN3Jr5RDJEBTcKeVklNem3/wXH0xCNByW+aopOp1prt2hA63XiFl9f?=
 =?us-ascii?Q?tFnacDDme4rPapzeAP6pRQ+F2dcfgxm8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 17:15:41.4762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed11b728-fce5-44e5-4f95-08dc9aba99d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709

If a system is using preferred cores the highest perf will be inconsistent
as it can change from system events.

Skip the checks for it.

Fixes: e571a5e2068e ("cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 66b73c308ce6..b7318669485e 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -160,14 +160,17 @@ static void amd_pstate_ut_check_perf(u32 index)
 			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
 		}
 
-		if ((highest_perf != READ_ONCE(cpudata->highest_perf)) ||
-			(nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
+		if (highest_perf != READ_ONCE(cpudata->highest_perf) && !cpudata->hw_prefcore) {
+			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
+				__func__, cpu, highest_perf, cpudata->highest_perf);
+			goto skip_test;
+		}
+		if ((nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
 			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
 			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
-			pr_err("%s cpu%d highest=%d %d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
-				__func__, cpu, highest_perf, cpudata->highest_perf,
-				nominal_perf, cpudata->nominal_perf,
+			pr_err("%s cpu%d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
+				__func__, cpu, nominal_perf, cpudata->nominal_perf,
 				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
 				lowest_perf, cpudata->lowest_perf);
 			goto skip_test;
-- 
2.43.0


