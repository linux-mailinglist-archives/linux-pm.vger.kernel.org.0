Return-Path: <linux-pm+bounces-15485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F19999289
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FB51C226BC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB021E32BA;
	Thu, 10 Oct 2024 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wo2XD1ap"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C71E0495;
	Thu, 10 Oct 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589072; cv=fail; b=udrimOyZJmXJb85KGblHcDUJoZEA5c9BdNI37RUUm+NWVjgpg4CvqbKE1TK1nXXgVa6thNDDWBezTmsNqk9Sfo2QaNNM/+miR6WROvhyjGXSRPtBc49r5LmP4OTQSZ74vpAtqDqCEMpkXeOWK9eVnvsddSINKTbI6dy34wQO/+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589072; c=relaxed/simple;
	bh=c4x74gUUGr7+G0YkUn6OuqDvmXEa08Nm7tqrmQrGwEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDsOVc5Qdm0BawOg6e5np7F3svcV+r1cE+dp9Y2rZnl22EUg19qN6/B3Fta4MRQrNf9rUP31RpMkrAAIe1jwp1PbKmh32YxpuO3BdzWd2kv4s8mR3EXVs2LIFNzLL3q+BusiDci60T51qeOaMEvRnXESLy4+U5kRFUNcq/2yboo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wo2XD1ap; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhMNfuhsc8ybwIlQvF1ZcVR61U5l25fX1zkwKqo7J2+u6OEXWurtKZVJKkvQSspkB/0Var+ceZSGvu62a4Fg3EVj/x004Hyc5EhtcB57QY5FfU1nYm/+pfnqecJi9g3utGtIrmfPpGvHOFb/FHZykCxkMDGejK79JKedWgesnpiKU9Isq/Fqeh1Y2p4b/RNl0EzL8tgoj6HQYxF66+nUip8CMpXKpCeGjQljdwUlai2bslb5x6KOWB/b+56q0E9jM54CZWHtCghw42BGVi7W0R/fIjTdmxSzw3/JEIYFT/ZkSisJiPLf7phAJyr0bIbDWzCimEMTqDmEOuvOJOFgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlPMfOG2AfnrLE0YxH40bcGxD+6XcpnN7M/ZJK2u3jE=;
 b=isy0VdPm/pv9g6uL1ynvg7xfh336PXrTKd4tWabc6lzDW+/k7R1A25rhL47aREuQ8HitltrajSh0p+VtMi3NXrHbpjSKS/yUyeuudJgzmLibdzuysjDoiHUUOXg+A/o8tRkJWbmjr6f9SD55YfEeUXg0/m/l5RSzXIO1zHcRuHVUNxQCrExsc0qYMhrX6120a+F4vKmkyNFEZ9xdY4DPXBCuEev+SYrtjOb1GuApqnEeJHus7V3tyM3rDiKuVhGTJ7wzXeT/yLc5CwtZc0czUYfveijOKNc33idMmk7Y49R1sjH7zQinylB3L5Svh8mt2SGdBGFsf8msmOTISMO5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlPMfOG2AfnrLE0YxH40bcGxD+6XcpnN7M/ZJK2u3jE=;
 b=Wo2XD1apfJaIwhnWMr/D1ilCXerTC1y7+27ky5G4mP/dOuGp85Fnt7ZMHPCgN7BxwLHxz1Ym/Yc136AtNdAT6RmFVBWIeabGVTETo73C8xEzGXMOTEtd9T6JEu6yWrCZFLNakhF061muu2j1LfYdEG2uMEAE9glyZ9IOTfOmTPU=
Received: from SA0PR11CA0090.namprd11.prod.outlook.com (2603:10b6:806:d2::35)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:37:48 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::5c) by SA0PR11CA0090.outlook.office365.com
 (2603:10b6:806:d2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:46 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 08/13] platform/x86: hfi: add online and offline callback support
Date: Thu, 10 Oct 2024 14:37:00 -0500
Message-ID: <20241010193705.10362-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010193705.10362-1-mario.limonciello@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dae8d60-6f36-4cc7-a37f-08dce9630560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6D7fzATWtxiDcc68EosNcuKRoXBNrWwbusJQU2MXjpBxFqGSK5y5lLamzubt?=
 =?us-ascii?Q?8wqnWlGY/9/L5WQXlKPGPOYPYCrcFTmmeC+ufD8qPpCenJFSnZiZ5H7FzN41?=
 =?us-ascii?Q?IC5Dsc8a/R/24CuJSNAmsd7/wveujsrLnRYKMbaCJHcqcvcIh/8yox1erCQu?=
 =?us-ascii?Q?NHo3iT3Ly7RgDnkFtdfDKtN1Fx1hVeDO74kjB9e7QYxffDPTVO84thQP475y?=
 =?us-ascii?Q?HiORpDBZFhNi7ajxZ0ZbLKsKIyX/aB/dm8k67Abz99KPpvgo2rHywtG1Qho6?=
 =?us-ascii?Q?Aj3jGvMUaMYJMmSulhRo4AkqQOZ3C0ZHxuDylo9gtpYtXX3TVjCDoj4EmBGy?=
 =?us-ascii?Q?SQTZOFqSjTqjpe8961QmzF8THZo3V1fGUeBBsGr3lUGmiHQhZXLRjVsURzQp?=
 =?us-ascii?Q?RZOEOojnLauOtAyf1MsvMBMeq1dowHNV9h+FqopEtRdFr3rGcLt6AlQk6ua9?=
 =?us-ascii?Q?LO1DkS2gP3v4+SLIzG2xUu3MHVXEUcGZLXLB4vRwO+OsRy3iUTjBh+yNg9uk?=
 =?us-ascii?Q?Q6neKKzA9ENlbPx/q2YRGqeqHzqSFvVr5iXa28aPLkp3WC07DwCKJKVM1hQe?=
 =?us-ascii?Q?sMhLDrckeHT+KoIRUNKs6qfL+ORwXGfLhYsEF9Yxwk0X/eeg1qhaudqW07Z8?=
 =?us-ascii?Q?VcNddx/CHsf+ZH57w8rhgoVNbFeL2ck2W7E1vnwNVxscQAWx2yNAfhzFSbsN?=
 =?us-ascii?Q?8tgNt1xW7h++18s5cmY3sDzrf30hYUSA++xZ3ljTGKkl0fV47R8B/rmPHTzt?=
 =?us-ascii?Q?BNF3TLK4JSNv3+DUK4p8sATkAdk4UxealYRiyvgfSb3Wym97vJaM1Zd6GYP+?=
 =?us-ascii?Q?xKQKCvznsc2GifUuTQL87oFviaFln44TgEo56sc0rzKtWsXi5DYFGJXpJgIW?=
 =?us-ascii?Q?8UxLfy2VT8gLuIzD+/eG0fG5DSQmaVW9pEb1cVIv+c9Gn7Bu2ihjYF/mOAC8?=
 =?us-ascii?Q?lCIWuqoMFG+F4dbcjKE9sLE9gX2u/rUl8/TDvDnxTSsObg5Nrce3GNr5UY9n?=
 =?us-ascii?Q?Z0sMPmHUEE0paqTUuSKOOCLKrLEUbGjM9Jr1J+azivkT+7O7hhyStYBQRJMh?=
 =?us-ascii?Q?yqPgBxabkDFG+RofCj8i4DyZ8w88UaUUdjH345pO6J9DnbdTZHGJl5N4pqB6?=
 =?us-ascii?Q?IxYYmPjbCCpKscMjWudHcCSvtVDLxmhqKfdQnjOx9zsreoDIG0RM6oKkWx6l?=
 =?us-ascii?Q?La9w5bEZfVSHJKIJljm0HRP7m9CG5i+lU4te+LBQtXZpUb+vZCUdJEcRSS0z?=
 =?us-ascii?Q?XmkDH7akzaQt+QMAJwkcm76rUWADojzLYRbAAT1pYbY7Ke69R3RHnh9fnDXK?=
 =?us-ascii?Q?ZkRUrp/obF4obSELWgon59DK+9ZaEcwU8UZdzLWGsljEBWAVm/oad2DiXCzY?=
 =?us-ascii?Q?wFiZgybF6k47cA92FvAU3JN2UQVE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:48.0083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dae8d60-6f36-4cc7-a37f-08dce9630560
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272

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
v2:
 * Rebase
---
 drivers/platform/x86/amd/hfi/hfi.c | 90 +++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index c0065ba0ed18..c969ee7ea5ee 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -244,6 +244,89 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
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
+	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	mutex_lock(&hfi_cpuinfo_lock);
+	cpumask_set_cpu(cpu, hfi_info->cpus);
+
+	/*
+	 * Check if @cpu as an associated, initialized and ranking data must be filled
+	 */
+	hfi_classes = hfi_info->amd_hfi_classes;
+	if (!hfi_classes)
+		goto unlock;
+
+	/* Enable the workload classification interface */
+	ret = amd_hfi_set_state(cpu, true);
+	if (ret)
+		pr_err("wct enable failed for cpu %d\n", cpu);
+
+	mutex_unlock(&hfi_cpuinfo_lock);
+	return 0;
+
+unlock:
+	free_cpumask_var(hfi_info->cpus);
+	mutex_unlock(&hfi_cpuinfo_lock);
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
+	mutex_lock(&hfi_cpuinfo_lock);
+
+	/* Disable the workload classification interface */
+	ret = amd_hfi_set_state(cpu, false);
+	if (ret)
+		pr_err("wct disable failed for cpu %d\n", cpu);
+
+	mutex_unlock(&hfi_cpuinfo_lock);
+
+	free_cpumask_var(hfi_info->cpus);
+
+	return 0;
+}
+
 static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data)
 {
 	int cpu;
@@ -362,8 +445,13 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
+				amd_hfi_online, amd_hfi_offline);
+	if (ret < 0)
+		goto out;
+
 out:
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static struct platform_driver amd_hfi_driver = {
-- 
2.43.0


