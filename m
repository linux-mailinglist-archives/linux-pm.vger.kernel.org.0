Return-Path: <linux-pm+bounces-15481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72343999291
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5FC1B21002
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACF01CF7B2;
	Thu, 10 Oct 2024 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uN7JkR/r"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B381CDFC2;
	Thu, 10 Oct 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589069; cv=fail; b=ADQ3VdaSIozT+spHCZ5J1QkgoKji3I2r/kvjnJpzRbItI3E1k/qL9LCb4+uNDJMWNiMjrUUTT2KsvLpNbpjdcYrgHxdd9W8eTrFERKNVBTb4Q0BYKbu4F7HC00agjnXh6gT5FuCcOxCHo1OeiS2X1CC/LITbXwVIW3uxaulGkXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589069; c=relaxed/simple;
	bh=ofBvHPgVw5oIr8IlpOP7+JqexZC7i3ifWbwlvmZ6jFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxDA7USUv9T5CmXigJEkSUUqGYapVvzusT42HT2wik2W/oq+2jijD9mT7xyJJQTL0iq70aVyU1SaYyCbfkepMI/BjX5A25nbjbkzUtOL2Ue1slGKPHHpgp9b65rH/2RKpow5tYBEVcmYqmjYQNxvCKJH5+yM7BYSA50peCNQ9+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uN7JkR/r; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgfiTBDIf/QsPsKBdZRO+vKEd25iNSE4vBUJ4NB611zqZXfytLdQEhE6ApyiNjvoHQVaTKX5ZQjsiJzKnyOC/JIe76uy2WM6w6U2gC8sxl4KHcuJyBTZuDDZIaJoV7TXMDQpXX6Yc24vrfY3lh5tp0N1/ohEacvjM0B3Xahkl+PH4LhzSYKbIaSz7DSZ7kg7hRe99mAbLuzwqmsM/I1girY70JTuD6Um3B0S8iYKgs4RuOPq/GUZbIaaMqmc6kHXJxQRDfVqZEwtlCi+ABlu0noM7vvbgJ4rPMQhxHqMxT6hEJ8fhYG50c/corG7Hkv7nGSIfbS7xI4Vvpzn9I2NGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Wpo1JAzLUn85517a0rtcIQKRr3tku7gUFu4sVqSGzw=;
 b=imSdRQHuHr7J4Qh5ZaQCihHt2t2TkrzFj1x4gmRhRIp766gqN0b3v0q9gj2u4TZ+5aSvLqQonT6kc00+NenZWUTiAsBa9lQvz414YNOVZ3j4NVmGXz9tDPefTOiLu3T8VItHIGu0tM2CEjB+2icykAVnSN1ej5E0c0exFOz8NrykiWpo+jhrO2sQ7AhYuOwZa5cw0xeG04f3cQ3BxM/asvQlIhlN296ZNliFFjSWyGm26ia1w/F2rFvoh2ErpwjntKv7EONAdVmbRxxY3hMI4sbFPR3mQLYUTMAkiLbhpFvysg9ok8NkvOZgPrJefO4ciI9u3gb5sohTXdtOquXnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Wpo1JAzLUn85517a0rtcIQKRr3tku7gUFu4sVqSGzw=;
 b=uN7JkR/rqk42ENd7ForisMbD43+dMeh8+zqIH3r0YsOZa/z/ci+y8p9eakFEv8wNgdQgJdGg3Ws14OwWAFAS1dBjDxWpUYcBo2+DcrL2D6tBo5lZU17ekfp1h0aI6wDoeV3k05KQcvjdmCDoZrIUzOwCK14gjiZpvuHJpcjryxQ=
Received: from SA1P222CA0151.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::21)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:37:44 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::ee) by SA1P222CA0151.outlook.office365.com
 (2603:10b6:806:3c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 04/13] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Thu, 10 Oct 2024 14:36:56 -0500
Message-ID: <20241010193705.10362-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: bf383d90-b864-4072-0019-08dce963031d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wtk8Ky5QJjT4UxI1/tlsOx/nKy5qgAU4v3EL4BG0+dDYiF3XQkSnPlM19vEy?=
 =?us-ascii?Q?j4SxEGJXbqA4FpYYUXGo7FPM1V2gnggeyAvu+yHQfy6L1skmi1G0PvjAyKn5?=
 =?us-ascii?Q?ArCc5rr9oLS1fkC9bT5MKZBwsrokuCpatjnSi7VqLyAbK2R/uDPO3v9NSUl8?=
 =?us-ascii?Q?rNSgcUY9z7Orb8yLEQvMkGlCZUCGrVHHiXtX4yXBTeDq1t8NYYDm6pqGBWuf?=
 =?us-ascii?Q?b4obEUHLwiR62jHZo9MvBfLpP09FptPTq263tE4trpSvEbwtEzEowDONh2EW?=
 =?us-ascii?Q?13F3anSnzFbbw0tc+0hK22nstIltL/NSKPsuug5lT3kDcGY2wGhmV+wCQfZn?=
 =?us-ascii?Q?LBeFg2kMDgso2YGD4AfEuZX7LqHwmjAUNDUS+pgeOZXPQ0jxhYMvxBMq+fjO?=
 =?us-ascii?Q?qO4vVGiKuz0sCn8BpfdtrOXqTB1/nb/AXCsuohsqWBEGLBhxbcrX3Mz9md0M?=
 =?us-ascii?Q?nOn/pE1JcOcLkHYry5zK1D7X+rSdX9JE3UOB8jS6xAQ8DV3ARvj0YdfDIvWZ?=
 =?us-ascii?Q?NNEflI6fK+krTPASjFv1D+TS8A3GBMUVs3jvOP0hOA9laM6doFtsC7zf1L6L?=
 =?us-ascii?Q?8+GnyUHXW+Zs+3LdEYZjwxan9CJzpxdBZRXjUBoQTEkCC1wr4hmr2EIZG90S?=
 =?us-ascii?Q?G+1wl/vMfCc5kTxg3Gr/ghSSnKU3NLTb/VqcEiLR9EcTxen+nvmj2evFXUsd?=
 =?us-ascii?Q?wObQj8rvFjRwy9I2CF0uPdv+T9pzv+yf6xYTDNhFE7YuAzorvFXsJwAiRicf?=
 =?us-ascii?Q?9UtE/YwKwUMnZWMd1pW6gNM4xIfgEXa3uLR/4kKAybB6KyQ/XeJDqvQ0oCJ0?=
 =?us-ascii?Q?3rHCvoH90Gg2de5gkYYrSrQ/iSl9+Yot0iw69WxogSNO6CGTmH1mk/vzmvSg?=
 =?us-ascii?Q?/nmnyxocFzbKkdIbzXw0SdoXWoIK9gK25hrBf5jiHiNDfV1blw3jziAglKDU?=
 =?us-ascii?Q?E8pQcqGq3XNjTh3G4wlwEeoVcqnuFPXH4GLW96qdBdS1vNWJfZ7E5PaQrMqa?=
 =?us-ascii?Q?O9yfjL1g0/xb8MlpE0NM7WfmNnpaNjLWq4lW0+JdhK1F8h0+SYSaAh59e0wk?=
 =?us-ascii?Q?BVxAOuh8Sce+DUcfRTGlUqeYD2h0ZlPrHp+JLY5PMpEfd2ArSxtmctEVr2xO?=
 =?us-ascii?Q?FgI2rKmYMRU+W1wJ/QQobKRkZW30oisZ0EBB7Lpqkr5u6VQFsPXzl5WSP7OX?=
 =?us-ascii?Q?9tsFA2duTV3pPUwKVHNyxfO3myQl136nUVNbowWFPbhDh6JLv6KaoP+pBG+c?=
 =?us-ascii?Q?pBnA8HOLKiG+qqWA20aB9g2UIqIWGTW4rdmgmVMd8GnZSvzSM5XEqZkjMQ2y?=
 =?us-ascii?Q?KifaCE21M+fDBpJfsBfMnLR6Dw5dy6cho0XQU7IF/Ahjegs1WTllNG2yysxU?=
 =?us-ascii?Q?ZOQy9CqHUaG1773B64nn6NBOn0t4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:44.2252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf383d90-b864-4072-0019-08dce963031d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575

From: Perry Yuan <perry.yuan@amd.com>

Introduces new MSR registers for AMD hardware feedback support.
These registers enable the system to provide workload classification
and configuration capabilities.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..0cd5ffe50f4a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -712,6 +712,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define AMD_WORKLOAD_CLASS_CONFIG      0xc0000500
+#define AMD_WORKLOAD_CLASS_ID          0xc0000501
+#define AMD_WORKLOAD_HRST              0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-- 
2.43.0


