Return-Path: <linux-pm+bounces-13023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AE2962460
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 12:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5ED128277A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 10:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC5167DB8;
	Wed, 28 Aug 2024 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rVhlUsP7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661915854A;
	Wed, 28 Aug 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839889; cv=fail; b=qK+q96j9whFjAWMjw3mLqYFlWOl5pE82nRm0X8PyU7+i7F96PJzYMbVKV9g01OiN1Na2DCipRt4oKvBK7AlGbJdpoqk2jY1uoyDvAlZPPhv7mj0fwy48gzwwSo977kyvR1WArgnf/IoM9cFcmiRhgeydj2o2JfkopFwiWeliTUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839889; c=relaxed/simple;
	bh=TDF5fo89HTH4AqZMKrRegxPe2NTvcBi1RJ5SReunwx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcFfdBhVkKS1NPUffZeY7XZ/KBfKPqh0pN8lfMnmK5TaE0nycJdjz/yr0Q7ME0U+qUQ7IzTvIq8lYrdFJxbDNH8RfMz9Vpe/SvghtlWU0Ic3XwW/7fqs0frtrQp541vGEjJKkdORyZX/D/WqLrvAzNt99v22V2RsOL+DKiOvGJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rVhlUsP7; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzmLq02GEZA7hE7Fxj2TEl8CrE804MDSmIYHMJySLcgO3GK8G4HSOymlf6SLJKo1C1WsxnyIGWirh0uokuxZSEYRdfWaePJUWwNfokfd+XBrj6za8i/sVedfGXy/TDY0N0/YpXsWyOicsHeOxoLTCXQOlYnfl2p3/bQl2ae9cDILW2VpUazGBLGWk+0P02aTwGXIQJv0qXuF5i4/gp8Iq7Gf+30PSB0PR5/keMqH0osDjS9M23FMEiLcR+BiaHhcgyQND4BBauwvRMdqTgQc2gov1BYXF3L4yB8zbe5rSuVdbInqVgfZs2OlpzY6hB7msuxn8kMw/feLnAFGY25Zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtM6TGkIuX9iv9CcaaEH8cs5RtFfMuzZtbDmGP9IlmA=;
 b=UvmYUy6x48uxzMPw0g2d9ZfiCkJxJEOZ6Qeu0M1EVpwYGAbnsvj1+Jwds5mmo8CFWGKC2fyv2LR9joaoYIRS0BE0P8T7jt2+aQEQr4jtsvyHVTOvgWbwTo2Pnz2g6DAfq7FDShXhewRhRZdwwf8NcPdyzSbRiRe+wLTX6RD+ijd84XK99OmwCVok5dEW+sqQGOPvKl9yE9kaQJVytL1MJWqtbUG9bgLZYZqLdtkTjcf7lJYD+Z/umrm7Ys+Vu5Rr8iU/1uyc0Kp4qGlOfOSRUFfMSN4n4BFtTal28e/LDAuALuV20FronPTWqH+gWvng6oil6x+LhHi+R92u52NZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtM6TGkIuX9iv9CcaaEH8cs5RtFfMuzZtbDmGP9IlmA=;
 b=rVhlUsP7JcVISoz/OmuShMgZSoHPgchmy+7iI3kGnO8AV8XAQGPlfzMaTvN077L5ILVta3lljuPcP5zT4zah+fKXjR2jjQVmVCmaSwZAuaPxMXEmwInX+toVC461yOVfo1g+h6c5vyvWcaoLH0DHWejzjsvbMbG+HSLduBKKzK8=
Received: from SJ0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:2c0::24)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 10:11:23 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3c) by SJ0PR13CA0019.outlook.office365.com
 (2603:10b6:a03:2c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Wed, 28 Aug 2024 10:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 10:11:23 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 05:11:18 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Rui
	<ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, David Wang <00107082@163.com>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Subject: [PATCH v2 1/1] cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on certain Zen models
Date: Wed, 28 Aug 2024 15:40:35 +0530
Message-ID: <20240828101035.2099-2-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828101035.2099-1-gautham.shenoy@amd.com>
References: <20240828101035.2099-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 786733dc-9c32-49d4-84ab-08dcc749c539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94qzQIKz9tEAbOXo7Tbn4PJ+AccXMExTLvVesEivBRlos5u/3PpxMxKV3Dvo?=
 =?us-ascii?Q?6+FJ6tJZHzbQy4uHILhHhqBIuUovEdlpU+yS3KTNczySVrO/RcpVQxwzle/H?=
 =?us-ascii?Q?76raPW9Qn55vrd8lJExqMH4lC8hW/Jo/Nrli1GwixDvw+NuwTKKj/XZZ9Pxh?=
 =?us-ascii?Q?4Kc3q3UK/knO02zGuQl5bwnEoZuJCdvmBg1QuBkgRHQEvl/GAINZNqg2GSuK?=
 =?us-ascii?Q?2Xp0Jzn4L7AaVex5G2rpxgw1CUKDaCzWYiqEiUFh2duw6eQJnOG1kG2TXO2R?=
 =?us-ascii?Q?8CMiXsasOBGeb3ZtAnweJ+e8kDEn8Gu8VOof/QcOlHwkUGGocvd1ZJU8L5hK?=
 =?us-ascii?Q?GosGXZFj7y8g6Di83G+O2qSxEu0JEaOuP+p1cU9T4vHg+7Eev0l9V4Ye0eBg?=
 =?us-ascii?Q?Sz09hx54wDNGLkgBicYDOk3/KSm/PRCMgdTbtM9oEeAuhFRzjKhv3EWpjClT?=
 =?us-ascii?Q?d0MvfkdoB4wvxGWUiMfLVkVQiYt6z39o7l8EHjTsNe2bgA5GVOYCz871covp?=
 =?us-ascii?Q?gGJD9Jmy5Qwoa5uB2Iun07OvcBKpqD52N32yAiPfDgxw2+tiKC5xp7rmir2U?=
 =?us-ascii?Q?JlFOk/2PXWnc+lQdldvG3hUs/Zs64Jy6+OrmCevzhpQS2qI+/D5jEvFq21MT?=
 =?us-ascii?Q?IC181jE3zE+S8+wagM7BwF002BXIbNokTJjhTFqWEcGIg8RhfnI+u+Lqz9QF?=
 =?us-ascii?Q?DDdQHjTuPII4/IwIZY7bdq97oDhPftg7s7nWoC7DDWpu6n9QMpg8U6uGxsv+?=
 =?us-ascii?Q?wFck5PplhQYBGoW4n9nlv27YgXrbsdVPicNWlnVpxMwBEpTWoFqdprp+drfr?=
 =?us-ascii?Q?k9TiDsEXVT6+FKGhE1fd2geLCrggtiL/aY/M53DbqJvigwk8QxeNZSlXN1FU?=
 =?us-ascii?Q?PxxZhtePFZRlxzFoGdLX8q6dIgMYgGjsRJY62M2xHWX97hNfcCK0EfIUIhBE?=
 =?us-ascii?Q?dQ9dCBj6S1C2WJWbxl5cdV3ptBLft3Vd+QODgh/ej63PbtNNS47HJZbNo0MZ?=
 =?us-ascii?Q?H4mLmsiNhb8RImOtnltRgiPaKi8QKgfI8ffdWkjrKkPmYK30tebUHIb168WZ?=
 =?us-ascii?Q?wx0Gt6KVIcjEjmn5jygrHsAxWUI0moqA0VzehYk2KV/mlE23kB7SvizzqO74?=
 =?us-ascii?Q?cxI3mG44POD6cgE+ml5Oi2/QkElfO5IBP2Rq9RHb3tv5OPqB7e9OCYsiywcQ?=
 =?us-ascii?Q?7Z8b109f2CCA1v+LPQty2UrItbHagqolXm82TrNz/aqKDjlkj0J1RZnzm0VC?=
 =?us-ascii?Q?By9psGmFj2A0m8zh4hKNf92IEiN0CMVvZ0YBhE0Q/ZGWILEZiuDv5Qros9+W?=
 =?us-ascii?Q?Vi+SeYFHjarW2Oo6J6k5Gn2QUqtRIYiaSiw/UthBgk7nTlYoP/gkfTBKx4GN?=
 =?us-ascii?Q?OTQgUUACl4zVcYRNWiNs8l3FIWNGBxvmrc2ftKJZliypMzk0jXKHc2ERHZiS?=
 =?us-ascii?Q?C+WOyk+ZuOd3amPukorr14de3sdddKhl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 10:11:23.3782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 786733dc-9c32-49d4-84ab-08dcc749c539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989

commit bff7d13c190a ("cpufreq: amd-pstate: add debug message while
CPPC is supported and disabled by SBIOS") issues a warning on plaforms
where the X86_FEATURE_CPPC is expected to be enabled, but is not due
to it being disabled in the BIOS.

This feature bit corresponds to CPUID 0x80000008.ebx[27] which is a
reserved bit on the Zen1 processors and a reserved bit on Zen2 based
models 0x70-0x7F, and is expected to be cleared on these
platforms. Thus printing the warning message for these models when
X86_FEATURE_CPPC is unavailable is incorrect. Fix this.

Modify some of the comments, and use switch-case for model range
checking for improved readability while at it.

Fixes: bff7d13c190a ("cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS")
Cc: Xiaojian Du <xiaojian.du@amd.com>
Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/lkml/20240730140111.4491-1-00107082@163.com/
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 89bda7a2bb8d..259a917da75f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1834,20 +1834,34 @@ static bool amd_cppc_supported(void)
 	}
 
 	/*
-	 * If the CPPC feature is disabled in the BIOS for processors that support MSR-based CPPC,
-	 * the AMD Pstate driver may not function correctly.
-	 * Check the CPPC flag and display a warning message if the platform supports CPPC.
-	 * Note: below checking code will not abort the driver registeration process because of
-	 * the code is added for debugging purposes.
+	 * If the CPPC feature is disabled in the BIOS for processors
+	 * that support MSR-based CPPC, the AMD Pstate driver may not
+	 * function correctly.
+	 *
+	 * For such processors, check the CPPC flag and display a
+	 * warning message if the platform supports CPPC.
+	 *
+	 * Note: The code check below will not abort the driver
+	 * registration process because of the code is added for
+	 * debugging purposes. Besides, it may still be possible for
+	 * the driver to work using the shared-memory mechanism.
 	 */
 	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
-			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
+		if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
+			switch (c->x86_model) {
+			case 0x60 ... 0x6F:
+			case 0x80 ... 0xAF:
 				warn = true;
-		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
-			if ((c->x86_model > 0x10 && c->x86_model < 0x1F) ||
-					(c->x86_model > 0x40 && c->x86_model < 0xaf))
+				break;
+			}
+		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
+			   cpu_feature_enabled(X86_FEATURE_ZEN4)) {
+			switch (c->x86_model) {
+			case 0x10 ... 0x1F:
+			case 0x40 ... 0xAF:
 				warn = true;
+				break;
+			}
 		} else if (cpu_feature_enabled(X86_FEATURE_ZEN5)) {
 			warn = true;
 		}
-- 
2.34.1


