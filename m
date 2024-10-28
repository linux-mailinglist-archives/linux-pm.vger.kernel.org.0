Return-Path: <linux-pm+bounces-16543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1469B227B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9081C211CF
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C21925AD;
	Mon, 28 Oct 2024 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0oY1Wol+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BCC1917D0;
	Mon, 28 Oct 2024 02:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081008; cv=fail; b=qz61zSVKJFAGbllNu3pakUqbWwLS+njpGQ5M0RMGq0edttwhhIQttBSp8v163IEEQs61WhYPl94klz6p4SlQ0Q4g25upwMWDaLtyfPiGNXkSocoR0/RGogLFzA7ImyzFyzHBHHMrY5n1sjyAfWpQBm4FjjGzjR6QfWX0ga2js2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081008; c=relaxed/simple;
	bh=zpb+OFazQFWy0mli3lXH/uVjxCvkLhwWEoPjvmdqFDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bik1tykB0XHtQIQD6Yer1d4lZKtyIW79PC5GglWr/4AIJfGzy8P1RMz4MweEGderlkBomDFf7JAM9QDWCxqfjzaZMVJ0pMvN+kgZ2W0k9tUGJeTWfqtYh/l7aJh1yStLdMvxhr95MGsTWKky3cDAPryKL0lZreHJlpC6rhY/KHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0oY1Wol+; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHvDjeZiGqFMo4Yvp+pPO9wZdeALgTfsETemvhKK9u8sTF8tnW5Tv0BoXzXi3qBwQ1FV2fclTRRJRweonLydw7znf2CmKmxa82UicNcWBtb669uj840roIf7K7QG3tDxFn/f5cRyL4Q2wi3G3eAuD4kz6InQhatq0eR0bRKe8uTwIAjOeVPCl382RCxN+s6rOcNCgUh7c4bYzn/JibhxNHQfokVEcDgqqt08CG05QnqtqbP8t4n72H6/2uIvvTDLvAkEYS1AbyJvRWkngpCdyeQJsSYzipnQMLhMb+0tVrkDllcuBCWQQZHbngys18y+rpFGEi7jdGNB68zf3L6osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2kf9Qa/oE6NaY6EdyCmnrCJYVdPqE8ZhNILdRNWrxU=;
 b=FLkpmmqPtTQ88td5918syT36BN2LUcMkWfnpY/CdLfHEgKyl4r6PZ+7Oibd8JmehlYg89vnYMrp5oLsAfD32RP7m+4w7Zselj+WXyEUw267K1AMFrHXruLLc3tNL3vXM9+5zaDN2qpCmx1bBDvA4yBgGB+405Yce5hBKgfCGRXU7yNyWJ70BryQMtJbCnOccy++UvkaSQnl7GC3jE7xAR55TPD78HrJm36n0y9qYjjFV/SeVHLJPJKh2bq8P/dPTLRSQTak8ZTa6F8I0eViMxxCGql7RVJUyMgH7eoI2G7qbuDpWyX+86vte+zigjLBdcWBm93uWr67Ymt5TiqhWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2kf9Qa/oE6NaY6EdyCmnrCJYVdPqE8ZhNILdRNWrxU=;
 b=0oY1Wol+5OiKQi+7GTuAHON0ChqcJZKzljSnHbg2jLjgY41gCrlb0u2FqH6jErSe0VNwMWK2dmfXSCSWlWcqMMCA0pEioagvx6rKiRh6+gBvuEZTklnOhs3hF9W/crft8S4R2FCWjzw8qIanCnf8PfkoFXm3OAvMDpjgKBTdr1k=
Received: from MN2PR06CA0027.namprd06.prod.outlook.com (2603:10b6:208:23d::32)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 02:03:21 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::5) by MN2PR06CA0027.outlook.office365.com
 (2603:10b6:208:23d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:20 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 08/13] platform/x86: hfi: add online and offline callback support
Date: Sun, 27 Oct 2024 21:02:46 -0500
Message-ID: <20241028020251.8085-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020251.8085-1-mario.limonciello@amd.com>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 608e027b-aa68-41c2-7134-08dcf6f4b2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?myRr2RyT+Fq9mSz2YIACjuGm+dGnc5mr3hgbNH3TzFFLMeGZiSaSJUiyQH3Z?=
 =?us-ascii?Q?jDtFRu++4gh1Np3dKEQFbkK62ICJpcsyN6daOr7pLWQfPfNBQgcwFwvGtQL/?=
 =?us-ascii?Q?yuSCTTZOBuR8M7eIuDCRbwg9EPXYim8GMkRzCD+YsEQMWA6eMRAoyFI+3iOL?=
 =?us-ascii?Q?hXFxH4CUylYiDd2TdaP+JGb08GrRq95D1qKpH34q2aEFcUihGv2tbn6e5KCS?=
 =?us-ascii?Q?SHcNOf2TUAScK9zX9GAXrznfPTiM+ZuEkiMayWqyRILHWonKht2Oq9TTvuq8?=
 =?us-ascii?Q?z/zeemOSa0/QF/UirLGKzdRcOeqmHq1U+681diF+4WmrsTxZot50jlgUvuQC?=
 =?us-ascii?Q?PzfSt6DZFv580tDJHqROV2en8P9uaceDjeBo+G733MJq8Q4ejHfyoNuuZ60O?=
 =?us-ascii?Q?8/LstQ/14amiKxx7igX+3gf+/67yBYJ5JwzSm/5lCNnbWast9Hx6qTl4RybK?=
 =?us-ascii?Q?8a7YQFGH41VVH80+sJdMSPEPpzCiqdNeheuI+SpgYERj1mhHxgPXYpsY6IjH?=
 =?us-ascii?Q?udYamSbPwPguxcZotrJOdydUyGQYmWykIoqG8IFMVvd2pLFuj+oECe5UhXZ5?=
 =?us-ascii?Q?UXpOszW2Z/ehRbAL/e9Guj+9WSyKZ/8bwIhzprnLR0QtlTRq3+lcq8FKpqwM?=
 =?us-ascii?Q?6GK7A9tdZhL0r+AziPtkpwtH6WaXa57yxk6moSS+1bilRIThFv5lMi26Dt4v?=
 =?us-ascii?Q?2GOx1BPJkou6/BvFHIIGSnRe1LA1jy+GDrbHCJosTzvojWjj8CfcncT4qmIU?=
 =?us-ascii?Q?PMWS5VkBnPDXilY36qnwK57qrPKRXpbrvF8TbfxGUKUP+Cx1kdrHv2xhRJmB?=
 =?us-ascii?Q?EULYJq7JWhwiOkkXQf0MtQVbovkkMOItFVtVOawYk3pIJhhsH2Qurt0puOqj?=
 =?us-ascii?Q?i/5yxsf+hph2JDE1MYAr+f4/CLyAE31WKgzg1UAFFK4YxVgTEumL8AXZHXom?=
 =?us-ascii?Q?ciCnR9VoApSONpCeVeaUkMFz6GQM7azHAZp7YzBjIFoNPndeSGtJksI/qOxB?=
 =?us-ascii?Q?0ZYWIYqR8izSBPE/2wFRvT/dMtdmw5TUbJwynTm/+HcZMsHxTOIXRY5RJsaJ?=
 =?us-ascii?Q?wm6lBIHZhLWtdvhgkXaUEoqzummHKMAG4uu84+Z/30dxWpsB1wMgRdeQC71v?=
 =?us-ascii?Q?DS4cFBb00jYnX8OSbjdFk1JLG56Vd3rGn9VYSy1CQ/ZVyOWlvhIoPdRMqJ7W?=
 =?us-ascii?Q?Ge07DoWzxeQhkxX1I0yvtxAUnSXb5TaNYgAhZIcp8B27AghGbYFq9EqoS5Q6?=
 =?us-ascii?Q?AiVglSY6Jn8Jhpt7yMgBh2vMKEBMQOMtT8U3j+2SMK4Li1ldZDJCbG94fqu3?=
 =?us-ascii?Q?QJ1HCbQDL5zoKkT5PtmyRiiuYzGgzUrnE/vTnur55tIaGPbUbbMdR4Gq3sB9?=
 =?us-ascii?Q?pBuqkxuky5vs5oaYifIZFQJ9yqn08JE1I1DDqtzCOUu5PiduPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:20.9700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 608e027b-aa68-41c2-7134-08dcf6f4b2b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142

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
index 986ea056fa022..70ddde37f283f 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -245,6 +245,80 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
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
@@ -348,6 +422,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
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


