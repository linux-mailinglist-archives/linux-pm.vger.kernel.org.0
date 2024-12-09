Return-Path: <linux-pm+bounces-18853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51A99E9E64
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE85C282845
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5D21990AD;
	Mon,  9 Dec 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="liLhrDH5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A31946DA;
	Mon,  9 Dec 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770400; cv=fail; b=clFPrNt0pQDT+E+kgxCZZif51IvXjP5v5mMMR6fCszQhSfMi5QakTC0Q4iugv1ydIoGB3JtreN/3Ibg1f6KSL61CpKDKQDMAhg8xgnYcRljH2jshq5CE3l6EOpRjr5yCVjnWZ6IFUkdlAlvrsQomRnluYv0gk/Y4Cx0+XdptE34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770400; c=relaxed/simple;
	bh=cMivOQWZogQBB05LU5VTBgcnzLFViRdZ6a1taO7j+7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzXrDB62S2VHM3UtFg7f3e/VSh7DY9GaOpT8VWTpRSY7+6fzIDW1MvS1cXeMeqBSjubTNOr6hMYdS0L/vss8ooujNkbuiXFYe6O3lvGttW4LjekOaKvoUGjEE3RmnCy5OwEYqV203EycARa+JtOkHO92tfqd1vZiLDVLBaZRxoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=liLhrDH5; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLDcVnlLD/YqjA2YRGVNfkCMo9F8mwVEJnrlSaoGa9FRNxEIuuC3dqZXxVvG68y+/MZKxKbY1xhLuadeyFeev0SE3h6f7TVQOoobyi8rDgB/Tr65dqmHfFqejV1ADAhpuFT0WkMJ0ZUO32TCNIakFqhUCUVqB7eCivf3MAKzd/+uxwK9w/OdPXj4VRZ8qeoipnzGjmWaVes1o14fTzEVg/iztmTi6Z16M29k3XZRuNCMErAVok89/P0J6wCJ1hmkCDaHPJiZYw7lHgrWMRewQwMZx1JBpApVZfHOihKXZpqu5/N4bCfonf0SWT3HB97IY+41G45Qv+4pOkrXGkoAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCd4s0IPHxRfilvupvmiDEaJQouGx2yoyCLixWtybzk=;
 b=IF2yDrha8Mohvyy3mQn8/KZJjsVbLl/qdQ2NMiEfBs6GjcsUWtTXlDig4y41MbtL/2YeehRJ4zdAtiYQ+GsgCBer3bHdhXFtk8E4N3/qHD59rgtzEoDz+SuwGSQKaYOubIffwuZaOppMZoYVAvr6rd+k/frUuOkXf4G/xcXNa8gFBg27xPE1PajhYTj3Xw5of+cepWXlMOKxaEgrPGYmtApNiFlt+hM9nhaa7wk4tWU2jBP22K70G8NwBRicrdEaT50mJGvwHB4IhoUTUDmAkWkLbK3IJ9W077n/y1WEVxnp5b8cZDHRLspD8Hy0m/ZkXdpS8CCjwYVJtsXIG2G+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCd4s0IPHxRfilvupvmiDEaJQouGx2yoyCLixWtybzk=;
 b=liLhrDH5zT80nhYda7pdMzt2o/eG41e2JcE5Rn095PpATxUrM/XvQDsyvQR7AQHAJVUjRmf4EVWcyO6A6cb4adH+nPyZdni82IPsAZcOSXX6owfzgz1vnpvYPZ0Q6djHZG/UXjtXvm5utrpik8iPYJz4Kt5IgwE4sU/s0eIp5MY=
Received: from CH2PR19CA0018.namprd19.prod.outlook.com (2603:10b6:610:4d::28)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:53:15 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::5a) by CH2PR19CA0018.outlook.office365.com
 (2603:10b6:610:4d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.13 via Frontend Transport; Mon,
 9 Dec 2024 18:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:13 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 09/15] cpufreq/amd-pstate: Change amd_pstate_update_perf() to return an int
Date: Mon, 9 Dec 2024 12:52:42 -0600
Message-ID: <20241209185248.16301-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 44178ff0-4bf6-4461-3fa7-08dd1882bd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZoINt0oj0V324SUScG2jKFU05BfROoHBYwtMx4K9aibW2q/aZApVCxuu38tV?=
 =?us-ascii?Q?rpOQwXwg5x0GY3f+FjIUp/mmsGk8u5gY5DoingiQ4jYQOQLgZWGIjDlcEzeD?=
 =?us-ascii?Q?g05/8YIiN2ByQslLetjBFWfOlejSvB6n4NRgYkQY0fIArO4+wk09SyNRgriW?=
 =?us-ascii?Q?wPoqDx5UkatqGEgGRawf7MsaE7HbijY6g3LttIAC/jp/dh5tEbrqE86fytrg?=
 =?us-ascii?Q?ymrTBjd0J9rgpEQ9jqEfAz6JAL+5n97RRt4TeVD205JN5/uPHQoH80aXpo8x?=
 =?us-ascii?Q?+eJpS4/GPywCpS2gZ9QnYbrsdKHfE9WBcRozz92h3yM6lEwcME8BcSViDw16?=
 =?us-ascii?Q?I8F0MtPTuPDm3Nm4NRqUgB8RgX41xNUv9jiRuyk1QMDZQsVpas2HAbR5ot5j?=
 =?us-ascii?Q?BASOXRy0GZMPt9nd7iSAr9vb8XBTUXsldONM8zvFhnzG7I3eF40iFhMznss0?=
 =?us-ascii?Q?+ceKeRrTnz4Suk+jgjDq4EXdt3RfOT3xIS45Q9GMXh1w4okH52mdplm4H1YS?=
 =?us-ascii?Q?p3S6KXl2mb6MQoHUs4xwMP9vhEUxtRmQnBrqptsJy1M8vBfDhFv+Od4EEUEu?=
 =?us-ascii?Q?LBVEO4H6bon8NBTjViGyDMbdX67ImyKd+A1WvGxU53l08jTW5BGqFG6b+F+3?=
 =?us-ascii?Q?eQWywTGqg/Dz4wO3jhQBCxBjdO0iAx2j/w/xjVma2LkB/C29GW5JJwOXNoHZ?=
 =?us-ascii?Q?VfeUSLARKcr8Y3xVPchdzSi/JbIxyEkW2CA6RVo8kWYGUlQzCeKAeBaXKfnG?=
 =?us-ascii?Q?g1CpB1I3MeKFFdxsikgF0vyQ4L4r1ol2fPOzZ80acB226oOOfQymL0rTp//Y?=
 =?us-ascii?Q?E8iUMIZxLI7HzqVxcHDZyewZ4ozwiesh1ylTbImO4tsAi5DwR/xgVlANoHhL?=
 =?us-ascii?Q?wunvo/8yiVlRE7DnP6OE0GMVGvR+7GPdCFqVuqJRZFuiROcU8j8mgTndAKkU?=
 =?us-ascii?Q?zGaRtVnjecyn1wJcMl8KffIedPhnGb9RDFVTUR8OiEfAwRBbr5WOrB60tMEN?=
 =?us-ascii?Q?rsQABIyhbw1GnGJLm3EYTCn4nxNmaTlIktBTo+Iczkiv/Xmnmm/gikFNhzip?=
 =?us-ascii?Q?k6WDNZJ9wodAuBtpHwUQbwAFv7lZGw4btNhfqL4LaSL1ARorY4hW3X4dD7BK?=
 =?us-ascii?Q?Pt699o5YeWVv2MSQU3ggfEOPPO92fSEZ78+AbIN5XOv3/k2QTkasf3RubBkD?=
 =?us-ascii?Q?lI4IInLHJt0bxATYbvwWgk/kc/DbaKGn7aqdqn/9H9nFf+HbvXf/ixOhDzhF?=
 =?us-ascii?Q?dtPP04p77NBbdqt8SlVwlk4SiHprGTChNTOAHvJA2sbOvgKSal4PREYZip9U?=
 =?us-ascii?Q?kh5tHYRbzyt9WJ0T0phwmRYUb8UzgRfmu+XfdNEf8YBR0clwBrXvSFDNZADu?=
 =?us-ascii?Q?OP6fd4fjhxrI/JGmGNlFSi67nOJtYXeGOQegWwDA6RDaGVUwGInFQVFSYfEN?=
 =?us-ascii?Q?bB4UNiJuZIvTexh/JesIFx/A+rcKSkSn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:15.5525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44178ff0-4bf6-4461-3fa7-08dd1882bd41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834

As msr_update_perf() calls an MSR it's possible that it fails. Pass
this return code up to the caller.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8a173359c2754..3a3df67c096d5 100644
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


