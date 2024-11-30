Return-Path: <linux-pm+bounces-18291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F1A9DF190
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EAA2817EA
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392501AA1F6;
	Sat, 30 Nov 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="umES217I"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D111A9B45;
	Sat, 30 Nov 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980061; cv=fail; b=PsVV2Vn1NXRClTZz3oGp8Y+n7BKVqi7rM1VDQiXBjkEAFNAp918BYhRA+nhvmTytSjPCans+KHuPbKBxvQDPKXwcCSLP9sARrIZT/c1vfK3yHStXTIFNHCTK7rrKZtQFlttwHRj5q8cyQHlC4MqY+QyNuZ4aVJ1FUaiLk+xhH+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980061; c=relaxed/simple;
	bh=FpLsiRAJ0TzAVlqt/XYgzXMXQTsiGNGdRN6lg7gXd6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FANAQrDIXi+n/GPyEAwfpaudU8BqzN8IyYV0unsM1I8PY3bS3uvTXUd3rsTWVLG8cYkfc9EC+yMKukm9OfIUT6Ska0WhaHA8v/+Ox4VAJ0MoZfxW32D2HVV35+yuWVmmCGVceyTRuTo7XgGDmIVjcvV/MaXCp5aoCGQGrqrXI38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=umES217I; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X82a3wJgCDiZZ6Agiskow4SbNAwXEuajlEKQa+CBhCFI8rscdK8m9FAIklHnbvIYKzxNeX0M46N9S27xAAiR9x9GBnERuexWAOQasZ43ARsLhxzL43xiD9wEiD5bTUjnXHUMYqauPZpda28zqVU34LIZAduUA94JXUGr1NirU0nQy/VrhaYGRWvDtPhkHHfof4aACJEyraDscvavNP110VPYW1tOQBgB/DpLtZEteIO9hqpvNTuGkzfhLm/nj5g/iGRKJz3Y7WHMXxvr+cUt8iCPNWJsc72Q6qr/SN6bTvxguDDTrLfT5Br1x2SDbG5YbbenfjT/lHO0npydn5ktrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RknzHyVcDROpyuEbZtKEZ2l63n4PQHm96/Tru68mFr0=;
 b=UADkIovr6daFp/B+JDIyVFWuazGYcsaYHHrXMCg7KPSSWqr9kiPysgpcpiYw+LzEJhXiAkByWmDxdIsjsid/RUXUW7VWWiZbT6FlY7hSqavkR9r9fTGeq2J/YAhLUSA6j02NL5EquKXSxxHJkd3Ev++roICVZ1Ecx1+HJov3lwYsIzAPB+r0jrjECW54kAPLzA6SCff2NWN197V/MAwL9lESBx1UeBS4ohTjdtQ3pGqWfERqKI+J1ZBlEc4x1otDY/qc73AAddmvX0j0krBh/8iIKLXsx6Vj+NR0iw0nmMbHCeEzrM5zQmOLsyNJLQqFYCL3mPeSe5QiUfXT6Hgipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RknzHyVcDROpyuEbZtKEZ2l63n4PQHm96/Tru68mFr0=;
 b=umES217IGoiPEmMSngrW/qvZ9lNuHq7zaYR0PuKnKQJJ+w5nQfM2jFf+LW6XnuDC8a0woT9E1FSnmkLoN5DCJZCxzHuBTIUN2d1kYYfoE/x11EPrFJo26UrBlP2poEwmgnBBXMA9iJb9wF44/CbI/KySGBFeLRMjHN+ETFZeqxg=
Received: from DS7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::6) by
 CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.16; Sat, 30 Nov 2024 15:20:55 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::e7) by DS7P220CA0001.outlook.office365.com
 (2603:10b6:8:1ca::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Sat,
 30 Nov 2024 15:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:53 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v7 07/12] platform/x86: hfi: add online and offline callback support
Date: Sat, 30 Nov 2024 09:20:18 -0600
Message-ID: <20241130152023.684-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130152023.684-1-mario.limonciello@amd.com>
References: <20241130152023.684-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: d824bdd5-4ed0-491a-cf66-08dd115295a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yJ4c7wF7YzNJp+UCwyEeAj+yeQVuJkSlc8+rEnWud+IGmATFWqkAdDcyN6lH?=
 =?us-ascii?Q?hG/8l9DOYFJVI4xNFM03q2qA14AvJs6XflO6oMuCmNMeqC/kdkDg0z3FAlhW?=
 =?us-ascii?Q?uzPtR0CtxWFMgrOs+IDt6M3sjTC6fx6ecvHLFVoZfWKjAQ99pq4ikUpLw7aC?=
 =?us-ascii?Q?MMODdfIDTLpa5aDiv+p5COOcOyvC0gpj14xCWvhV8lx/1WFlciitEdXI1IFf?=
 =?us-ascii?Q?V5WTKcyZo6na/CQhkvD12XTcK9AWhe9vBG5mN4Op6KuqWj+5Zt96IExjfDLj?=
 =?us-ascii?Q?/twRycMMdtk4oqdB/81mYlBqrz+1EMv7u5L4TGwufykyO8ZhrjSkuBnEeo5E?=
 =?us-ascii?Q?m99kGro1LKSzIyNPKqmYJ42OOo8ov95w5GeuIUku9B/uWOoyJmv4rQHZA2cp?=
 =?us-ascii?Q?btznkb/O+VnSdRD73l2oh+yd7AX/PSstZAx33kVjczx9YQzXgw2ueJv8ROGo?=
 =?us-ascii?Q?F3pG1rtcClG2VhAux2mAuYk9+ufGvDRBfiD+gfL5fz1n3F+qh3QbxQfmx7jc?=
 =?us-ascii?Q?vNgWNs7MmeHgFMBjfoOTZUrC34M32gk8g7+roBPE3dcrhb7hAvh+kgNErwE+?=
 =?us-ascii?Q?Kois8U7ke7DBMU5+CnyBafVpfZRcs31Ncn4f5tUKwEOk49zAB4BjWUmjYKdv?=
 =?us-ascii?Q?et9Uu6ogsVoNV4xxyYxPgA2MxiKwTh2WFoFbZlbOjCtugYj1B29OlKPQVZn0?=
 =?us-ascii?Q?6kC5PNpsCqNhH49sxOICyYPytMcji2r5hUt8rEwHvYmFrZ2CQCoZsUyEk8RJ?=
 =?us-ascii?Q?P8tPdsEm3h5piOCFepA6paxYDAlP5L539U/FCT3hNPBQ/vTe1EqXzflxk73a?=
 =?us-ascii?Q?KmL748klrdzofjqUbHDwBZrwblg3LxMWNKFRexKyiY7uEKltVVzBZ4diFQZE?=
 =?us-ascii?Q?z2jduuLyzn2RPWFjoGJbcQLVcwQjw+6S0kjh5niZNTzFD63y34F9vDmQvhNE?=
 =?us-ascii?Q?jsH1dLfKobjSiQWdKrc5bK+vWSko1T1u/Id2EQr0uIccRZRSxh8+Yfj/EopQ?=
 =?us-ascii?Q?dyQXReQoiQITbC4Keo5GO/+0S6knPNAcodVV+N8HoMWiTxxZTKf66jLiDKcn?=
 =?us-ascii?Q?PPzoZ63CVRKQZZE9OwQCtBB0IdDOUTsh3Mo7lLlJp796ceDMF+0hbT9OFF5f?=
 =?us-ascii?Q?AU9g15mwx9+lGmwDpZpL8pUKAw7c2ZU+yL0OSWhhnVUGju4M/F6r/zwcQXHT?=
 =?us-ascii?Q?zaxouj0VqZUpZNOPvpiG79Av1ig2p9Xs7I05RtEN0tONsgp9joClgSTOB3ed?=
 =?us-ascii?Q?PvO/5W8suneCZyqZy3YUwrWDZ6oQxUAQHY4YALvh8EfwfiWbpHKzgHJMplKp?=
 =?us-ascii?Q?U9U+AMyA0lGVX3a4jr8m1+9ofG1hNCKxvP8DlNvjHL5OBPg/4xztf1WKOzzp?=
 =?us-ascii?Q?Rbq4HPOB5wLAuziqdgas/M5Gc0b/lNOyffu579q+FzAKHVp2jfiDbe+w3CBb?=
 =?us-ascii?Q?mGRYlbQLlQEyhBnin85poVwsgZoK39db?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:55.1309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d824bdd5-4ed0-491a-cf66-08dd115295a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081

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
v7:
 * move mutex to this patch
---
 drivers/platform/x86/amd/hfi/hfi.c | 81 ++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 9671f07c76390..922a9ff0d447a 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -113,6 +113,8 @@ struct amd_hfi_cpuinfo {
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static DEFINE_MUTEX(hfi_cpuinfo_lock);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -235,6 +237,80 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
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
@@ -340,6 +416,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
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


