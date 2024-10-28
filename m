Return-Path: <linux-pm+bounces-16548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2E09B2290
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A561F21D35
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F8F1D079F;
	Mon, 28 Oct 2024 02:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n0NJvWHJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99061CC882;
	Mon, 28 Oct 2024 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081014; cv=fail; b=Re2U9qFqQSJVGIm80CalOlfNeNfy8GhtL5WMkmcrDDX3Bp9FNFKTOFkJqegLWwX0D5h8Rcrx8WEy5ut9gafrEbTzwRU9IPAtw8YZPIBscOqRE2z8Wi9fZPWQHLhzm8vhp0WSrvgJ4yQVbrTES7AWvP2fdNRazfx/uz5GYxdLU2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081014; c=relaxed/simple;
	bh=v20A+qYcbUcJYDh1KpTP4gkfDSx1jIxGDQLp4XRswGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5H5u04Bi5uLv4jhi1iolGw5m0ovgfQ4mLu6Fqn3nYaGiDz6hSCxguaZrbhCIUuIs5iOI5nBlMFVts5UO4kfCdbWiSOd+Goo/N6QLg+yLng4h8W5S0CslMNksfCPAScEo/Gcf4Xvi0Vr1IA2FK9NI8F5RF+RaErG3eK+LuPiLB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n0NJvWHJ; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiuYT9ipNrFWYLkD3KkgHZpL2bmKIhnRc3Yb2QSI3zpHO6ZgpwHpRKLyh3ZppqG+Y61Qu+rpY8SvDWTIaEhPt5YNtqPGlzQbjjJ1H3E5ygHpjP4VbhUx4rwrplR4Yp74MaljriKiJXDH4G5AjKKNGmFLn87IVESt+kThC4CGBzJjaNZkAUbUKg1KZ8+ohi3J1CXqAzdD7WYNskTs3KVGbSkBBVqgqT67OjU5UWHGwdNnH6WVvpHLw/gNtrtD1rqnYr8wGfD1gr+UMtiXoW3XYGQ+lz9sgnY0W/RybAps5x52G4vHkmBKrmPJKTnB3hBh77bZjkdO1+Pv7ysypFhWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxV7Q56HF37N215gSoJzMyoaTl4ZgHOlFr7GHMSiEq4=;
 b=i0aJhvOVyN05lbMqV5GK+V7WL/1XXDC7jDSXikCy/SiHxvoEOquh9wB4traBoUXBlTDUd38mel9zoDSqOFtcXlQRUzj41TeP2QRQZZgw1xTUK3DwpT3b7aLzj5xb/aKzsCe8cf3yShDQoj3vzFmfMfduBmpjpIQffw7SUVIbVm8u0PYqB+0Ze+9rlBFYdBREd3qTRGSndqaJBIBKyKUR9yyV+H3tuS6ECji51rNafI1IQxraLVCI/dtfHxkPA/FUwR0ky3/Hp7aeEOQdHZHYIVOLBCXeVlXP4cyySM5xQBTCC/arIaILs8Jlb0SKWx77iGDSTI/fk03hv0lVsLBUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxV7Q56HF37N215gSoJzMyoaTl4ZgHOlFr7GHMSiEq4=;
 b=n0NJvWHJyYao4WR4kJvrrhVP5Mq3+eiOBhiq48Qqj+x2VI7QGSx7ASNbi71opUPllNPFuPGeTTvPHZqf4QThFgaHBpwapWma2eBZFo66SYQCMDzWPKhHpyEc7g2M1645Zq79qoqBdlUDF4cgvBRJe9P1BZsSI62fT8S0AY0Y3MU=
Received: from BN9PR03CA0921.namprd03.prod.outlook.com (2603:10b6:408:107::26)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 02:03:26 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::27) by BN9PR03CA0921.outlook.office365.com
 (2603:10b6:408:107::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:25 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:24 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 12/13] platform/x86/amd: hfi: Set ITMT priority from ranking data
Date: Sun, 27 Oct 2024 21:02:50 -0500
Message-ID: <20241028020251.8085-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: ad50181d-bb6b-46c5-8775-08dcf6f4b59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pz4QFsU9id0eGHjmOUFO2G3HNCmWd05oYIt6QWCN2KTJDup8QfLG7t+lekoe?=
 =?us-ascii?Q?yJYe13CF7MgNckq+k0661TnlRijfmXbRGkVippz+rWkeKb9wtmxHuesweSEd?=
 =?us-ascii?Q?G4GyjN31Tuzi7gLneiZp3+ZF++RKonw0i81zZ8amYwuemc4QfboaIh8O/gp7?=
 =?us-ascii?Q?NwHp4KWOTY5JmquQRjEOziAcq4f45PUVcs7zXekP05AMTG1rGhGe5dDUlP4d?=
 =?us-ascii?Q?L9EOPjBGa2HpL++wlKJe6NIl+UkAuLYo2EZSyKA7yVH5ZpAw2uqJDcJIJieo?=
 =?us-ascii?Q?/bsVusnoMW+garIzIvCmjG4k7xXqIcGspBbWNEkJBwIl7CzzTi4orev8WcvF?=
 =?us-ascii?Q?BFP9IeRleU4fDXSurZSgdOz+xTZdiKCE2QqdhfdktZMOisRivw7gedfpQvhw?=
 =?us-ascii?Q?wz165WCTYXcHmbGMs6YOBWXWzvp06EOIsY2GgYNBQ6+ewDWBBMzEHeQeUF7v?=
 =?us-ascii?Q?kfjfcz2xqTJxPzInWtsIvDCMQ7jC/suzgT8rCdJWZ2kNm+HlGHME+Czjk4CL?=
 =?us-ascii?Q?Xgq61CvAtZWNGkcuoTmoG8Ba3MjNXUH2bZwvxjVWL7curzEb5zRvhL3p0yj8?=
 =?us-ascii?Q?raCHjkZEIdrXN0ZfM3mQ8YAS9m2NXbblYtXapbLTWUkOB+C3BPqqO8hxUXkv?=
 =?us-ascii?Q?DHOi/Ypf5qMif80DvOC6n/xdKjJKMWym66dJ71rGQCUOoiDDf0i8YN2uIyQY?=
 =?us-ascii?Q?j8LOQHKJ/ePjdCAPCapWWKLV+CpXamGEP2eC9prLVxK7NuwDKuf1LkGYUrq1?=
 =?us-ascii?Q?6dkoR2l1DX5bIs1krPw1g7b9eHwP9xHGGMSG+RFq5wWiZFGQJ1EtGPG8mr+s?=
 =?us-ascii?Q?n4u8qctd5qly+Bvr9EzKJrRUNzwrvY1hZylVQkfDPhcfLCkABSvglgtuZQkz?=
 =?us-ascii?Q?TqVYNgWZysFZsNlk8eeE/C/qJsxR9QwrT2E8qaZzJURv2kggQ0cohxSaayXN?=
 =?us-ascii?Q?3YybriUO0whUfdIxtP0XsDLrzat6EyCXRBK7710SDJOpm5aEIKJ/JO/+Qn3j?=
 =?us-ascii?Q?PfZwDz8FgSDCSdj+Sqwzm5hid+lmaR4O73pm9QhvVfShsi47fYQy/ZlX5jvX?=
 =?us-ascii?Q?AFM0gJV5wFWzOzDHq0xSKmWIbrxNDeAiUPHuRRvh0/S0URTGeXa/j+FBN9o6?=
 =?us-ascii?Q?rJzr2BnS7czRzI7SiZg/D/nzh7XnXiGORcrhjnC9bBRWOLi+Ibtq/LjHtfr6?=
 =?us-ascii?Q?eJpPGyWEIsXvdI+ezyss/bstry4EVucTAppJbODsq6W890TmxEhwd70j9Ps9?=
 =?us-ascii?Q?OqbTsqdZX7QPYY0I4X6miibZDcIs2yNQJBkc3HcqeKA469x9f9leOnbox3Mj?=
 =?us-ascii?Q?jEfHr5swD8I8Suow0AHc8T3EdjI6FMURgV+sMaoGSbClHShElOv6h8u6PHPv?=
 =?us-ascii?Q?/WvWMSaMJky9cxDgb/6HXuuzLglR4Z74dt1Cd3ZPzbX9iDkSeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:25.8530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad50181d-bb6b-46c5-8775-08dcf6f4b59c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774

The static ranking data that is read at module load should be used
to set up the priorities for the cores relative to the performance
values.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/Kconfig |  1 +
 drivers/platform/x86/amd/hfi/hfi.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
index 08051cd4f74db..4dfa7641b35bf 100644
--- a/drivers/platform/x86/amd/hfi/Kconfig
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -7,6 +7,7 @@ config AMD_HFI
 	bool "AMD Hetero Core Hardware Feedback Driver"
 	depends on ACPI
 	depends on CPU_SUP_AMD
+	depends on SCHED_MC_PRIO
 	help
 	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
 	 selected, hardware provides runtime thread classification guidance to the operating system
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index c8fe03d0c9ccd..50407ab805169 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -116,6 +116,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index =
 
 static DEFINE_MUTEX(hfi_cpuinfo_lock);
 
+static void amd_hfi_sched_itmt_work(struct work_struct *work)
+{
+	sched_set_itmt_support();
+}
+static DECLARE_WORK(sched_amd_hfi_itmt_work, amd_hfi_sched_itmt_work);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -242,6 +248,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
 		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
 			   hfi_cpuinfo->amd_hfi_classes[i].perf);
 
+	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
+
 	return 0;
 }
 
@@ -459,6 +467,8 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	schedule_work(&sched_amd_hfi_itmt_work);
+
 	return 0;
 }
 
-- 
2.43.0


