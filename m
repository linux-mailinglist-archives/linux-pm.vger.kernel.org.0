Return-Path: <linux-pm+bounces-15894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8D69A2B13
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A2283222
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 17:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A651DF99D;
	Thu, 17 Oct 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hGvr+XSU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8E1DFDB6;
	Thu, 17 Oct 2024 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186555; cv=fail; b=cjTCdCnsfcIfbDFfoMOY4uh3xMYPJ1W9aYJJWHQ9ioAoUMqj8lffk/6C1V8Zfpswx4yslMCTWinIRUhp+a5Hyt4bywTJ0bTDm7HP08Bb9HKNSEwTzZKI/vsk8xG7oywdxohd90c+b+aZqeDde2kcik41Kg+2c5thLqCmH/PEKNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186555; c=relaxed/simple;
	bh=6dmwMjP3pUWtFfca+ItxrO1yRmYwfhBRCUezDNCk/8k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q5eaf9S1RV8OljmYp9xjQwGsldlaodUtEUUZMRBYZQOs0kMh1xCnfibvmVenSdZeceUS3tZw/P1IMpvj6QOPIkwPF5eM5XyTv44Nv3JsfWtOrO49kTub8FP3m6GdtoWdbR2Yv8RIP9Uv72IKISURA3uOlssxhLVvvB/j/uUQLkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hGvr+XSU; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTW5mdF8/FZoxBDX2G1mnDSiwlYvI9R+4vVFsZPX8gDZBZmlEGumsMIs1EAQ3jv99xvhrsEpTnltVfH1soE4+vA2Z5rkJoytuoK4HJorKAkLyJir7BPBf2z4nqoRCmLYp9E+dpLm+NmcBdZuclwf+9PHL3Yd9XsZcC75uRkKzkiN+jZiy50MSm74gYmvcTVpFuE0qoSY6QXtQuCgD47uUInMBKITgdw6iuElmQBzEKJBeRJKLzIxZblPvd8LFE/Aop7qkH8xe2MeNL9KDf3ugDfmm7D6ksT0EWY60hxIumeKeTy0zY675F89DhSTCDNDfnGmxJD9dvAxYhdHnEqfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prDXHtG1GRM//yMKoTKbM1uWCwELswxYBc2SGb0r6vc=;
 b=b3izBRRapPhC11RPKN3zt/l+3WlsKJ0AxuRaXFLAVax7/1DF/dH02Pydq/hrZjmCps13yvQrTUv5nX3jHLwR4BQaJNOStkpr1tW0pMDRueKL6PEAc0HLwIse7vgovLsPKPR2xM7x+hwiGwK8Nn1AenfMNK9h7zZ20JV9r0L8m8nlQS6xZNT+WkGP1SEPILM02O0qsF+QdenvQSJ78FWC+cJSLXMf3lGXR9JbLzo4KfV+wNzOCa/L5TBaDh/PTWcxa2eCkHM41qUVOHdZgfp8je47NkWPpy7R9pk6w4ZKF4lOgRCSUGyTe9YlvKH30ajMlnA3hBzbsHWnTpWqOzNkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prDXHtG1GRM//yMKoTKbM1uWCwELswxYBc2SGb0r6vc=;
 b=hGvr+XSUOdYhKHFaABxMayk4v1SGUg3ZiVo5w2ka/GiPsrUzbzhCAvFMtYrX080YiLaHDQdfPVIIdyJbf3QDqSx+UEWCto7Yz8Yk1PjpzgzxEyBrSdPJ1ugy14KpCeT4udELS1qfco6PQWeKXNMruUrwrN9loIUGLn2q3uUAd/w=
Received: from BL1PR13CA0237.namprd13.prod.outlook.com (2603:10b6:208:2bf::32)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 17:35:46 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::e3) by BL1PR13CA0237.outlook.office365.com
 (2603:10b6:208:2bf::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.7 via Frontend
 Transport; Thu, 17 Oct 2024 17:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 17:35:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 12:35:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] cpufreq/amd-pstate-ut: Add fix for min freq unit test
Date: Thu, 17 Oct 2024 12:34:39 -0500
Message-ID: <20241017173439.4924-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3b74cc-cb93-4687-7817-08dceed221b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0bTJsoxgYNv2Xxr/rNxutXJnto5oakhqhJ8U7X4d3rP7G69unpyofHMX/RmQ?=
 =?us-ascii?Q?H6ljmyyRDuPnRhzYIfuandWxd5KIaRFNBXADbt+9n5LZvNesWgVGVAS/b1gD?=
 =?us-ascii?Q?pObo829wsi7a8cP5V5nLpkSfXhD0TN/GQxpGnd+NFnAT+z0K9JgmkLV2MAAA?=
 =?us-ascii?Q?5ms9pZ4zNXw6KyifAQRTVoE1OL2SsrI3d1Q54VcUNReWO1Z8LJrXWp6xcVfw?=
 =?us-ascii?Q?EM0AhR2kVff0JQlr5Kwy0mpZgpNSAVr0rQ478HKsn4omO1shwf/fNASDyuGH?=
 =?us-ascii?Q?CFJ7J61XNgZxEafYkHHgoT2oA2ZNiNNr9x+d/Ide8cwXXh+yZS66H4+HZQMX?=
 =?us-ascii?Q?BXMkUzDe55r3TZ2z4GLyNi/d+HnMK3P0mCp1QvQ8W5AJ/laoZKouC90D30tx?=
 =?us-ascii?Q?SKrpPl3AhcSgd3RL+0v/voBeJaI1us0eXZhOpngBloQY8xcD646OXbWkFh5H?=
 =?us-ascii?Q?dewrKWOjDnV25GAR1zw4q2OE+kOQr1VnvAOgM6armsEsyGXIPDfuUrqXajH5?=
 =?us-ascii?Q?5GA5va186V0Bkx4Kp1/wxS6XA40FpGtkgn+qZQhae2QNgE9lsxKwwejaNEEo?=
 =?us-ascii?Q?pl+/pWqYnCCFUrxY7fMkVfbnuHMvcNv5ZJYHhpsMziYBFQCnQ7wCh+fh1sDm?=
 =?us-ascii?Q?yAbNiJ6ybhd65ykSmOpnvuQHgd0zjLTeyX9onikg3qAPO4FCeb3ZJvkPOiKV?=
 =?us-ascii?Q?acNwUyVg7yQEGZCfGd6zTdVuRXg2Z7wgcLzckAJdWCjhrBVVLwaSVbUV19W7?=
 =?us-ascii?Q?qQtYVuI3GvcnYjPifeTMvU5tkIZ8NJLvqKJzor6+aFUy4fEgSHYNX8Dhfeey?=
 =?us-ascii?Q?wh4DA+ziK9rvUoH/TUBMvhDi+sqA36NTaxw+cY5PWf1e6Dd++aFcoN3WCkEF?=
 =?us-ascii?Q?BTma1Tcj5yzOHBdajOEVMT+m75G0V8lcAxyReLVQwZRTWMAkfIHErOkgvmUL?=
 =?us-ascii?Q?OLQwtouAUa3s2Zr+DXJNUGdbYBWsM+p1M6r6jbNWGLzs0fgVK5/U56j3qXPq?=
 =?us-ascii?Q?SWFvoGB88PWn+ALnUs42cp4qReppe5ayWH9/2muepJZzq68gHiNjpI5qgSTk?=
 =?us-ascii?Q?zJ0kHyKpjdUE8aXghmCCo7eDe/YQoOwe0SRrU3Z9TwAxfTRh/ncuK/WoJTj9?=
 =?us-ascii?Q?+acDs4UOAewgJQBuvn6fmae3z1bm4MYtv0Ov32p44behDO900HJAzc1drpKL?=
 =?us-ascii?Q?GavO7wDZc/+fFGc7mwHbB5nOM1Dy5qEQFqf9HWeS+3ABoiIoC9eQaRnOZtQ6?=
 =?us-ascii?Q?qt4miUt9+GFic4kRVSpiY+twu7WzMdXNY5TWVI3vsRb9ZdVILC17InnG2Yl0?=
 =?us-ascii?Q?llXNlK3JMV9CYw6htDpMb6X/OOp2B12BDT6cyftcxSnBFdCGD8GoLK2BZ3X6?=
 =?us-ascii?Q?OlBPC6GjtY0yavePX8K1aq4FLcmP6Ek7fkTdHDGR7YOJPHDfqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:35:45.4808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3b74cc-cb93-4687-7817-08dceed221b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168

commit 642aff3964b0f ("cpufreq/amd-pstate: Set the initial min_freq to
lowest_nonlinear_freq") changed the iniital minimum frequency to lowest
nonlinear frequency, but the unit tests weren't updated and now fail.

Update them to match this same change.

Fixes: 642aff3964b0f ("cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index f66701514d906..a261d7300951e 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -227,10 +227,10 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
 
-		if (cpudata->min_freq != policy->min) {
+		if (cpudata->lowest_nonlinear_freq != policy->min) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
-			pr_err("%s cpu%d cpudata_min_freq=%d policy_min=%d, they should be equal!\n",
-				__func__, cpu, cpudata->min_freq, policy->min);
+			pr_err("%s cpu%d cpudata_lowest_nonlinear_freq=%d policy_min=%d, they should be equal!\n",
+				__func__, cpu, cpudata->lowest_nonlinear_freq, policy->min);
 			goto skip_test;
 		}
 
-- 
2.43.0


