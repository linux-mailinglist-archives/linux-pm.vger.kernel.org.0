Return-Path: <linux-pm+bounces-15703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79999FA4C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D331F2192A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0AA208D71;
	Tue, 15 Oct 2024 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fZVOtabw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A92076AD;
	Tue, 15 Oct 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028257; cv=fail; b=ElMWI+GfE82QNs2zQbxuDJF9Kcr7zuzx8J8GzSUk/fVX/wNUw+zHztypqMC0qaQ3JWZcF9XJ4TlQRzeid/9OB+nJ9oOvsLNmcoDFEw3qjfyv66hB1m/IzmWBWo8ElY15lzIboW+gI47LwxeAm1lBtlv8Op0un/of3q8empDiNVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028257; c=relaxed/simple;
	bh=U1kUTPbBjOg7McrhqZd45OWpUCR57dTNt+kQOkAb5EU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B029X+KhXQX4BQjo/ptRBs6xTw//dOkXaq0d8ItNLtfS0vJwVVqHUMOsTa//yzIm6x+GyDgAmwsc4fqe6sH/41XisWu2Gvm7BKQIyJMVF/D8ftDM9IioPQg/V5IbtDbcJbZPX9aCummHwNfuTgpGlzKS4zabxdmzzp+37tOJ3UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fZVOtabw; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZkKr2L/cXLYgPkUZW2hSrRtWc5lJqOFToDFJ0Xir5hQkvEFOzg73pB5CTR+SKXjQxgRrULJuRJusK2tBrVU2F1YysdtVLnf1/yV4a/6qx8RjS+pa6bw/3aBGbm5ETVH5uT/47tVYPjqHSE54ez02rr46xmK2FKePYm8thMt1Vo07UyCQsU7mVW907aqt5J8wwX6GQDY19yPWrrbhaw/Xsd1zuDUCjKF7m/hArAokG9n2OT3uLA0H3pgVVkCzU7od7PPHuzI3768kvZxRi55wmoPRb7e2JZdHHeuWAom6kNNH3ih7bCvKE3n7TKNiWW/P6yK/dzS0eGM3Q/pdCHZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kvrTBfrCjQ8v9W6zk9aj4e7A1J0E44xYIShffNHcZE=;
 b=R63ZMXqYIN+4fcL2DSZkQ7ceVYcZeSgnlBANHRsBnBiSPfSeazCSgVyPvfL2rcrZiJ1/+ipo7HMoNPdarDaVusv+FUOn80UO0PDPULGYmQDnTAb4JMjlom4osZtknkX4jLBAHVHgiVGhXOVnvtlFVk9GskJtcifjjpjCnyhj4QsZMQVFvd3lQfeGJrKe++D5IqLrto3ovbb95CZZ/qqa1at7PGmEiMzOl71XhVdiJgrEKzioMBPO7V2kSzl7C3CO3rEQ6aHvd41xEAC+Na+bc0/Zf9ql5pAPM1Vm0FVYhuAcfEG3Zmv70H1H/8CI/IoYIIHVuBvYn1EL8o92tWofxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kvrTBfrCjQ8v9W6zk9aj4e7A1J0E44xYIShffNHcZE=;
 b=fZVOtabwyU/4HBIH0bluIAlIEk6LgEY9/AmtsUiQkyQ+7PxEIUD6d98/is89im7TQRq+imUkE/Miss+9qcpRNez0V5Maa0Mn7Z6aAxrLazgonx3aUpW5Mm5IinemKyy7+ryX8+yASLO6MPLLDi3lxAMxg0dktYxvYdfciRMf+pQ=
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 21:37:30 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::ef) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:28 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 08/14] platform/x86: hfi: add online and offline callback support
Date: Tue, 15 Oct 2024 16:36:39 -0500
Message-ID: <20241015213645.1476-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: fe439f1e-f01c-4f98-56bb-08dced619298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AHLmwZDPDkOgS2h8OZiMmaTYVm9+2RgT8tIVtqDJ3f/lZ7lfMnUn/9Zqy0Ff?=
 =?us-ascii?Q?HGvxBn46xYCES4MAElZ2SDJYVBnJa0qidBr7Jpffs3oJxKnHSBuZXtDSGrMn?=
 =?us-ascii?Q?vSlLa/QX5KwKlpSQ/bAs2FhrXVHV3b2AIBZV/1ZxwWKd3RwJgwI/i8CO7Fxw?=
 =?us-ascii?Q?B0iEuZFiOIXD+ScikFCz8g/73KxTaaVsdKlAug23IEjeT1eVYEsaqUYI1BHw?=
 =?us-ascii?Q?k99nJPPNMGC4wFxjIlzn+gfYIF3cPnVxmHyMyljgvijJsjI5Vf/D5wS01YnH?=
 =?us-ascii?Q?znCWJA+VL15kCbbccS5oTeSWHrrGMWYZr2WzHJQIsmhLAga+owZZUhJy59E3?=
 =?us-ascii?Q?tEWfvI68+rwfuyhWC1UcA6iE4WJOdtTAZ1f8uEjI3atnwHSHACY7OQbV1yC4?=
 =?us-ascii?Q?4VXYmkV0AOYbv+/s73gdvOUEthSq0aitLJJbqiUGDLa7bx+MOH5BjsP03Lpy?=
 =?us-ascii?Q?Yivq2rDd2AqKjRjqGX+JjUNe5p1AWY/ANqcQuLXQ4MV9ZBpoEj7LC7fARtQN?=
 =?us-ascii?Q?p2oLQnqQvVWxLrbtVR5BCEarBzer4RxTiJs3khO+0blE7Hwc2Cc1cJ21Vavk?=
 =?us-ascii?Q?DZS4qG5OqA4LoBx9iScD3whlW1DtfGLnSL3mlU2ZwAn134NwoiS4VtXN9JlT?=
 =?us-ascii?Q?L8r0zV9yXFPSup5eI2OymI3A23E2hJD+gNBEJwBfa7odqOpZD/ZpRN7jOr1k?=
 =?us-ascii?Q?SDZFA+ktvesV0/D374qT6242Aw02c3uAInrDjeNPw+rnMA0AC4hukxbslIuS?=
 =?us-ascii?Q?g0Rtvf0kmLnitofiUipHIqwHmcbrBPmwCSQLCGYI/bGr4VAEBqG3mTtRygL7?=
 =?us-ascii?Q?dHLojktB0+KOOciTBBnA+p2Gva3pds40ORjMJrgdGESIS/5/nSK8W/RCNcXb?=
 =?us-ascii?Q?t4C77sw7IOUKZyc02Ri1LJTfVev/5fmFLf5JHHAuxuHFaXhWsRhHlztU3POL?=
 =?us-ascii?Q?HDOaGkQS/QKrZvjaEDKZjJ+0RCXQHU7g7HR0ODcP5U+zJ8OqY9/E8k52wxBq?=
 =?us-ascii?Q?zXKaDK5W0GFYPUVEJpbH2zMuqg7ybsHDa1mcCtqoaItlPzJGoeUUYhAP7pII?=
 =?us-ascii?Q?bKa4wgF/Z+t2Vx8djMMB+xvdkrgJhrfdOdisRv14k522XHbIn9cPtGYiGO/4?=
 =?us-ascii?Q?gWAbE74XWIo9KG1D1FkuxXIcY+o+SiTKgaBh1DOjLW4XB3V7DsF47i28zKqs?=
 =?us-ascii?Q?C9XhCafRzia8EKV68K5aKLQtnffAqKsZ8VREMlLM9usSlGL9hWHUSmtj2SPM?=
 =?us-ascii?Q?4V7qj5fnUQ/wFX0aEpOGoRXCSBkiSwTCxrbi/23xiYuPGZW8WCrWIZUwwGav?=
 =?us-ascii?Q?2D9a5OI9GSTswjqQYzPdbPBDNaq+QENIevPJBb+Gs2RyK7/kjO7RGwXLKs50?=
 =?us-ascii?Q?f36FitGO8TkzPTriEiUeA/aLOh3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:30.6210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe439f1e-f01c-4f98-56bb-08dced619298
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688

From: Perry Yuan <Perry.Yuan@amd.com>

There are some firmware parameters that need to be configured
when a CPU core is brought online or offline.

when CPU is online, it will initialize the workload classification
parameters to CPU firmware which will trigger the workload class ID
updating function.

Once the CPU is going to offline, it will need to disable the workload
classification function and clear the history.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Use guard() (Ilpo)
 * Whitespace changes (Ilpo)
 * Remove labels for unwind (Ilpo)
---
 drivers/platform/x86/amd/hfi/hfi.c | 79 ++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 63e66ab60655..d971ec1124af 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -249,6 +249,80 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
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
+		pr_err("WCT enable failed for cpu %d\n", cpu);
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
@@ -352,6 +426,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
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


