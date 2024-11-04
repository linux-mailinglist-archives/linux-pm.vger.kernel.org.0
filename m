Return-Path: <linux-pm+bounces-16988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD189BBC92
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2681F231BA
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351771CF7A2;
	Mon,  4 Nov 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lh6jd2bs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE31CDA1C;
	Mon,  4 Nov 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742891; cv=fail; b=bmjAQxnUxZLQhYKUl7Bzt9EHxX98smbK071wigpO5+uyq9/fO4VOg4EviBydlwuYGhw52dv3vbOwpfCIqn91cT+la6py6zUCU2P+rPccGte0/S7ydrdrRyLi2GRBqK/RI6paSwqa3l5Xw7u5COJGOC3ZhCtQZcWwgJQaecW7A8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742891; c=relaxed/simple;
	bh=8hyqUBZYzTZYptCwDh84yTVItwnDwvQNG9BISya2Rdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+wL02kcGGBxUb24TP0e14iLVSl5aIx+jZ/9XbdLuHdXYb92oeUzaWd0FXQ2aLuUcwo1/WK+OYspxnGjR9x0xHaCKbCpoCH8NKdGZTEZkNElBRyrx8MfNN5eethnt9ORztt+6xfAV4BLwvUP8pKKCZ2iZ9tiRB4a8lcMeD+AXLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lh6jd2bs; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMvWcwA6d+caSJLzhjroMYTnmb44Ippvf84znX5NpLQAFkbS7lRmiTUVEtqciQGDzk9OWyVo58G8C314cPVkCrbejukrsEUz+LD7vi52T+J96nJMA6Uj53Eqtn0BqXn3mh8UpLo7FCLP6XezkvTpUjvr1u20N5jp6zb/jDXazKFgty22riKrrysXoFSSLC6atobM2CD/G8o8Jn5L9uHEwdZWpnDDz6LopQuorkByfOuPlWlNgftNeiXl+AwuXco8cGYLn1+wCa+mxrRxL1/kAAFl8hoei9va0xRfYeyZMbGPPw9RbA6AOEKBAigqMBVa1uPdwowZHHY1VHHFcML9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7KunMFjhHxjgzK5chsTGqMgZNatzcxoVsK/HYkR33M=;
 b=WaFrSHJgBNzrb+Q4Ipu2xwhLEvcQM1Mnt9392E7r0plLApWkwiIEYKeeoHUlKcYmWRscfrPSTTFVksHO7vByzzX4b+GiRxTkhI/Bct6DyNcFWfxsYYV5yWbyn513QZUFNMLotRhVGccKG3RU+g8KbnLiWXKSMdAjJEOYScoRUv0Emkw6cTVh4Qgy45P93epr34/H6MiNeo7bIBXj+UG/c3nQhBPDz1yk1XjzxU68aV34D9DFjO4MzLma+8wZrcd5QsTQADsCYyKC4eEP5uxLvtax5qu2WxiJG/0FWJKUTcnrnfTTpWPv2ULnTF3Hhnhdm9a0ejA5Cz8tx5YKxwjAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7KunMFjhHxjgzK5chsTGqMgZNatzcxoVsK/HYkR33M=;
 b=Lh6jd2bsB+SJtRwB2riKXShQBQgwMQ8vxICvd0b2aXUz9fHFowPxn1GtWwYpkI7mT7SpO3qAfrqEFPBojg2YjTBDhObvMSHL5/hwXM8HRECb7cEdQrXH9iCbGZPqA995xJkV/ftZofu0RdxsYCtLMrwgx/DLhiAF+FJEgCOV63Y=
Received: from BY3PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:39a::35)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:45 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::be) by BY3PR03CA0030.outlook.office365.com
 (2603:10b6:a03:39a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:42 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v6 07/12] platform/x86: hfi: add online and offline callback support
Date: Mon, 4 Nov 2024 11:54:02 -0600
Message-ID: <20241104175407.19546-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175407.19546-1-mario.limonciello@amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd38a14-13b3-4eb6-b1fa-08dcfcf9c44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wscaMnVEa4FSypf16fM3NIJZSNsAeZxB9cxwOdSJyZtYtZpQwAdu7a3o0v2y?=
 =?us-ascii?Q?nmq7UDaJUWoFt7pEmjet7MOJYBTXED7pBzoStS8AVlQg7UHZ6cIXJN8wYWVb?=
 =?us-ascii?Q?nJPLXDoEFcHHqaYMTjFqEEhn3V36WBAzX55V80q1UV+SAdpvdT2CEPgscXIU?=
 =?us-ascii?Q?cvgdwPHo0tIaRONG8kFaE8B3NInqQJAyVOmlPHK2Zi4h7HfpVe5M9q9lcely?=
 =?us-ascii?Q?dRIHiYOXcBYJnZmHhDzLZd614IOpCt04eA01DiHWDZnD6AKmBLUf2lsZ5avQ?=
 =?us-ascii?Q?klsmKL1jSTWxpBquHYIvp/RL7zS0ZobLIeDQY5ugxAf98DPovd3iIhzC4j9P?=
 =?us-ascii?Q?QRRS/D8HZu2eu0RQWz4RnZaySOeoV5I0CaU/q6ZQ2fE1iLg8wo8K+ihOYeS1?=
 =?us-ascii?Q?2Mb5dSAWNcPbz6YVi+/z0bQYQzWv842Xt8+Jg1eYhKjkGnV5dYuyFbHr/2Cs?=
 =?us-ascii?Q?wN2bH58ED4rTuOLBfNHECxKiGpNqcShfk/LW2I0+wpHL0wvQZy2SHsOhjnjt?=
 =?us-ascii?Q?tEGSPiWlKlD+o4qLxQjna71xpQodrpbqN0nfF4wJny8mPoq8xS2GccEIYNfA?=
 =?us-ascii?Q?59hJd5/5I43/r8Hao7F7Bw1guJs5zCq1DQnLF1dkQE6fpKjS5TrYc83ymp86?=
 =?us-ascii?Q?upe8rQGiGy+LHi4PRQJw1V1Obvp5gwB/RMkB8Vc865eHKASp+gdr5xnIcDHs?=
 =?us-ascii?Q?OqJksRo1FFyf0Vk8ks8ngGZbuSop4cNrZCneCZis2XFTzdkgAvF5gy5WJ9+i?=
 =?us-ascii?Q?Eh7l7QsTJhqxQXaupJMp1OyERMhha3OFycsyFS43pl4DCQIRIzNrHBxNCvS0?=
 =?us-ascii?Q?14ruryVT93Y3Owy8+1P9Q3SgRTzE5ADtdbWnOPEI4vyXTPQKgikDaYchA20Z?=
 =?us-ascii?Q?JHBovOmRm4/OYx8Pr85YbI78Ok0PpiAVdUQjk/o3z4dKFaiAjt7JSFzr1Z4i?=
 =?us-ascii?Q?9pDqdSALs5/aOWxGbg9LR3tZxBLIZOnTlgDgmvF+0xwParVp+ZVrEZBMbmgH?=
 =?us-ascii?Q?xbTjRV/FP15SbC4Q0jm8vDFPb9DR25BIEeE9dl3DHfbrr4UmispBK7PE7WUH?=
 =?us-ascii?Q?9eg2SjxN1vtiZdUokvMIl6up5kwH15WyeottueK3h9eHkvMCME4jRJVHmJLs?=
 =?us-ascii?Q?aOXgYp66U03Z1+QObYWA0cUnpph/a30DIp5VldiOZbJ3KZZUc1E3I9gi136I?=
 =?us-ascii?Q?QnnugwsELh79CFMjhaFbxc2Hv0p+P6czoP9OEE5OwNuPgo7J35WDo1RRlR7/?=
 =?us-ascii?Q?w46ojtMVujjjiBqPxLRnBkRtFhRoQqr6hDR/QVPITmo99Mc3UP3QmSQm4WEA?=
 =?us-ascii?Q?tUm3wiUyP4bITsCRHUGqTFQrX1P1UW69asjZKRjKS9Jx4MycNp39X3398uU4?=
 =?us-ascii?Q?/aQCFqlVNF5lC/+O4t8iXtVznxt0mxdyoyj01PT/Sd12KIGnWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:44.8818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd38a14-13b3-4eb6-b1fa-08dcfcf9c44f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

From: Perry Yuan <Perry.Yuan@amd.com>

There are some firmware parameters that need to be configured
when a CPU core is brought online or offline.

when CPU is online, it will initialize the workload classification
parameters to CPU firmware which will trigger the workload class ID
updating function.

Once the CPU is going to offline, it will need to disable the workload
classification function and clear the history.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 79 ++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 9bdd9d9a615b8..cb85a538f8168 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -237,6 +237,80 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 	return 0;
 }
 
+static int amd_hfi_set_state(unsigned int cpu, bool state)
+{
+	int ret;
+
+	ret = wrmsrl_on_cpu(cpu, AMD_WORKLOAD_CLASS_CONFIG, state);
+	if (ret)
+		return ret;
+
+	return wrmsrl_on_cpu(cpu, AMD_WORKLOAD_HRST, 0x1);
+}
+
+/**
+ * amd_hfi_online() - Enable workload classification on @cpu
+ * @cpu: CPU in which the workload classification will be enabled
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amd_hfi_online(unsigned int cpu)
+{
+	struct amd_hfi_cpuinfo *hfi_info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+	struct amd_hfi_classes *hfi_classes;
+	int ret;
+
+	if (WARN_ON_ONCE(!hfi_info))
+		return -EINVAL;
+
+	/*
+	 * Check if @cpu as an associated, initialized and ranking data must be filled
+	 */
+	hfi_classes = hfi_info->amd_hfi_classes;
+	if (!hfi_classes)
+		return -EINVAL;
+
+	guard(mutex)(&hfi_cpuinfo_lock);
+
+	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_set_cpu(cpu, hfi_info->cpus);
+
+	ret = amd_hfi_set_state(cpu, true);
+	if (ret)
+		pr_err("WCT enable failed for CPU %d\n", cpu);
+
+	return ret;
+}
+
+/**
+ * amd_hfi_offline() - Disable workload classification on @cpu
+ * @cpu: CPU in which the workload classification will be disabled
+ *
+ * Remove @cpu from those covered by its HFI instance.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amd_hfi_offline(unsigned int cpu)
+{
+	struct amd_hfi_cpuinfo *hfi_info = &per_cpu(amd_hfi_cpuinfo, cpu);
+	int ret;
+
+	if (WARN_ON_ONCE(!hfi_info))
+		return -EINVAL;
+
+	guard(mutex)(&hfi_cpuinfo_lock);
+
+	ret = amd_hfi_set_state(cpu, false);
+	if (ret)
+		pr_err("WCT disable failed for CPU %d\n", cpu);
+
+	free_cpumask_var(hfi_info->cpus);
+
+	return ret;
+}
+
 static int update_hfi_ipcc_scores(void)
 {
 	int cpu;
@@ -342,6 +416,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
+				amd_hfi_online, amd_hfi_offline);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
2.43.0


