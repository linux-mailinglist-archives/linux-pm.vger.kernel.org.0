Return-Path: <linux-pm+bounces-16133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2919B9A71DA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FB3B23323
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B7F1FBCA8;
	Mon, 21 Oct 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q+TMmpVz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C631FAC43;
	Mon, 21 Oct 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533810; cv=fail; b=HSk2yFTk+0gGq/BwYAi/SL+yQiP68QDuPtKLX+Gn8Fpc5UruxaKcunNm2RcoI7bO1vJIwjXa5TGfoItNMK2JF6Z/3KXKp2+5fAoZGrNQ77WmEp3DpbBO+4OJp+3tMMTa5jLKUEiIR05EtMvMV/lEpQqZPcupeKPFMoa0D3vET+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533810; c=relaxed/simple;
	bh=Q7K5xQBQbiOpHjAz+AqQ44L4GXm/BMbd+LVpBOzSLO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9MSxHGFyk2tf8aNzOdd+qBhLJYYfWWu5fxj3wTi4UYo2uf6dJXIfsdg5GGL8DoQxhn1cylvbTOckY7dGMCf79HIrqYwYkpLuehwh2eTJP6a7lLvY/7+OeWe537PBoNun1f9yZQNJAyNMRR0OMiV1ZJoJrGfCI9KYmyC4QF0Rn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q+TMmpVz; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPjcdaSVqL0ZOOAjqsCrhf0/TGD3MUjxH8J5UW+AD9Koqhzu8bFFdaXYFAw+9TBF4MJAjZ6Uyok1ytOzAFCr/xtFR9XzjrnwM8W0OeqTf6k70U6R9Fke31QxNHVCeP2k8o676JoQIegTb/8mUKdqmyZcrOaWANLwqyFvJy3wrrG+ynPeZGQubgZC/lH702BogS3+xM7dyAu8OvYe1rEBuaRYf8NHEwR/W6v+rMDC7ofA2O6cl0aAQxWgyu693v9mErShJXclvIpC+XyzhENOP7wc6NEgpbjnaYcYvj8x7xYpodJ6aVtWfHk5W/8htMEG+1vaT/E5KA/5Op0TXmNIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky1A5wrgkuHisJxrV5VSBFVNavppKXHK7euMKnrCIkg=;
 b=n6WZulp5DDVluSOcxEKA+GXKHYZSDpNFhb/rDUJOc+1JPsZtkrUSDEMAGz1/7L5fA7H62yZQq+wD8bRdek+Z/PL3XufKvwR9K3H1bUyYLzBrOFHUNMEUDMycRh9j6veC5oBG39qEGl5kQ/VIFfLehuy2CWLk4CqRDF8O6Mqe/Dow8x4ndhyDhnkFqJUelj/AqYLjkJavm5EiAyKxeihyS/UwByVy0QuTWaaqjsUY5ig5uD14oeMsw+jukRdmlghKqdWvkG66Uu3hczJeR33nuhpn4sqe3+gcTl0GBUWZhekVy5DYgmIrRaImS4pjsG3Nei/lsW6nXE+caMgS8klw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky1A5wrgkuHisJxrV5VSBFVNavppKXHK7euMKnrCIkg=;
 b=Q+TMmpVzi+gDFVHZDJF+8SMSS676BUEa7nDvRBZz0A7aOOnfokaJnJYQFqpvfXHwp0AFUjFiz6FgxvT8L8Dw5Fx1BzCBC5ZRAp2FVwOLDnxAM1Uh5evB23+sWcAoOOC2h8c87dO1kB+Sf1f+5qPrnp6U8OvCbN347ocERqARFHo=
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:03:23 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::20) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:20 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 08/13] platform/x86: hfi: add online and offline callback support
Date: Mon, 21 Oct 2024 13:02:47 -0500
Message-ID: <20241021180252.3531-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021180252.3531-1-mario.limonciello@amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 71111604-9a03-4942-9f9a-08dcf1faa74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kE29xwxyk9BuvD1WdU/jj0OX4vL8dSEuRbi7STEMUAfPNjb6zn157ZrhEhRg?=
 =?us-ascii?Q?OpJ1l3XJFMDnj5zrV7OXSkqlwxLTN2z0ePekvD5oh2IEzasiDzFScFLblaRs?=
 =?us-ascii?Q?KZ7pY719OHtoyg+TldYrkQHt6QIruMKHOz6i4frICM743u5mZ4BgO8uWXtG5?=
 =?us-ascii?Q?sY00dX407BwbbtjV7CRhk/wXuq0FE1bGMuP471ZuxB3oHZDU3wNmBPqRLXuR?=
 =?us-ascii?Q?WYInIuBdAIn1SsbHdn4qBaUg0Gip+nZ7RT4cPt9i9AC5ZEPLz3u9r+ibI25d?=
 =?us-ascii?Q?pVIJxsxcZ5/rR/U9vGHPRkBUTw9NYoOwQG0EY+2lP6+IsmClZrChN3/9/KNw?=
 =?us-ascii?Q?QbhJVoWiYZ/J88sKd6NJo14UfY7Nke1S8/LCUD6Fmmk+YHyEmf8nVHkCLDsa?=
 =?us-ascii?Q?Uom1hDm7JsQvE3shGETgW2oQU/W0EYzPULcO3WOmnJPVUMzPZU95K/PEsIxk?=
 =?us-ascii?Q?FLCoxFI4C5vgfgX5qSj+Fd9RQjRNnl6SPPuvUhZGe66M6RJc1hy7FzwRzcjq?=
 =?us-ascii?Q?xCZPjpCVnkDrwzHyq86IR3eelg4q42qtTxaM4p0R6owA01AkdUzdag7RDdea?=
 =?us-ascii?Q?44pPgulfYVq/bodSvTr8AyylUwbO2GTyS4CcSADO/KWKvR0U5iXdvcjzH3er?=
 =?us-ascii?Q?WEIAQDbBrcWt+k8yK6UHK9+xXYpsSbday2Em53DDWqfI4mvSyqt1VHULs+ai?=
 =?us-ascii?Q?vBTl+M9ke11+AB4hOXTGBCi8ExhcoFz5JUqzVA1X0uoCCBC+tECjrJhRpzS8?=
 =?us-ascii?Q?fQW4zjCSem38GXuWxSJ9nwIzMaNZCMdWctDWdOJGsgE2Vqu5uy5SXdctcmj3?=
 =?us-ascii?Q?0dDnH/9xTF5YVinWSPx870rvkSKzbUw2ExF48WXD+jVkawFbGVOwj9DaP8jE?=
 =?us-ascii?Q?CMpI9lmDLU7blXNAtrS1lb42K/1VTyuT5f2vKsIpxQbqugsPPoJL8XNPZUlM?=
 =?us-ascii?Q?bi+Oj/qqfZMHM0oy63MmVHBCreY6WKNcFEMJLl0uu1eif7uOGdQ6M9Qr7Pbo?=
 =?us-ascii?Q?FvcTMCbQxERTrHs/qY1OUDEJGU/aRxc+5GFZivvqwxNJ7xayug/cJYXqKzWh?=
 =?us-ascii?Q?1IWghmEkGqqk/KC2uhQb5+4edG4IG/rsJetuQkWbfv3mzaxS0I88n9Rvcw3Y?=
 =?us-ascii?Q?8XvJXnHbJT3MCPTkwIEvZ499z1EI4nYn8HDr44wV0t2BPsjLJ0nArooXwBGP?=
 =?us-ascii?Q?xO7+EFMV/B8+78QzWTU6t5aEkvVBHu/fjI7fHFs5VLq2QQ2z64hyeaEQvTKe?=
 =?us-ascii?Q?PHDKEm0HLo+Po53ejIzIpO/CxaYx4IOaSbune+nPVJ0NlePF9nbiNP23k8Mz?=
 =?us-ascii?Q?bsEyH4/9PZPDFakmfcHzscb6Tz2SojQyiyULdvlH2d6LGuIwjr/IEoW01n9O?=
 =?us-ascii?Q?MeK5BG+0FY0iJzN89HogTUxWZL1iWrNAYcJQEgX3L66WmeSo6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:22.9296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71111604-9a03-4942-9f9a-08dcf1faa74c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588

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
v3->v4:
 * cpu -> CPU (Ilpo)
v2->v3:
 * Use guard() (Ilpo)
 * Whitespace changes (Ilpo)
 * Remove labels for unwind (Ilpo)
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


