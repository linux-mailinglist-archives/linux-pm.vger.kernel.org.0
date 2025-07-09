Return-Path: <linux-pm+bounces-30425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC3AFE072
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 08:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16781884CD0
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 06:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2AC274FFD;
	Wed,  9 Jul 2025 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pUFxRUzW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D926C3BC;
	Wed,  9 Jul 2025 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043481; cv=fail; b=aq5UYGbLHnSAphITExiSPwOH+goLr1XuDIEkyWQpkQ4tdJ9cwB9KiTSUSndf7PTmRzBfjq4AUihawaueAeOp4PhqErkHRIMS9YBsfhk4gwjLprwYBO/FAPkbKMXn7YLP/syCkaSxB3WyxIQdo8SJkHIjURyu/Nl6Mw5gBXBzk/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043481; c=relaxed/simple;
	bh=gxCKMvwPA8vcVBQChOLDDUjBgyF0rI7YkuL8BkQ40zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xh2Pbgo2A8jAwUYCSuGBoMLga8dA2/5eKDKGpK2Oqj22Et/Y0HJWi11LQfDD9eUPjpgNanpR05oOhswubRpajCeZZG/Za/HWCmRJ8kb5JL2MuNgK9DPnSggbClkg5735wrkntAPFE2JOZhUBOiFwoaAmWyCXoyajZVcQmsU2jDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pUFxRUzW; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEVpqy52VL3FKpojAhhP2RLXM0ZZ3CVa9S+ym0/8LAKQX606tnzle3yQ2wWceb5cgu7hDd+zCRBzfdKGiC8m5HGJD7LvFV1MlcLy6ibMXFkxVBHKiHTmcPFGI7NM4sGOsoUAskfGGSUN0XnOOYz/cmMbeTRfVHm6zEvRJz+WlWlx3ZmAadlhNWhISON7FbGdmQsll4iuYzZfV+Pk7iUflRtoqkxEnTNF5RFkkfewCx8fd6GN4YICXdJKK2vh6zBhXLVkGEL4L10adXC/PlBBYXtmO/6ldf8Kg3cKZImnWE4FXcJMbmz3zWHXaohOOsJrrxtQY75rLrfRDzxoGnG3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPUolXeLQdrBVInU0Qawb5A+BH4a310feGspIdffEug=;
 b=YWdsl/w5gxB3B+HUCvY4L6Owv6vaBVN2i0fyxM72RRzXHTxF01y7jt4B2WOKYzCipyj/AxrGxiTRBc2fsI1/oDNTH7/66xEL+9sDb5yj/AzbR3aoDTMgBgCvb3MO9DdQ63UAwZrrDHsBgSW989MzFe7obmAnAYNf8ES/GapvT4MGH451bQxnnOvcYjMIuIiA7vvUjCkov0aSVEbTJMslUNlP1LWt+xIbjV5/Pa1+XMm0cHy/f6ZScMcmptHD2DFNtJjeCp3rEdxtR0n/Mad6GKpmu51a4nAGEEkHYjrfLVaPYiZOmRqrssVyxkvoNzqS0soekHky+r4mCpFgKEFsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPUolXeLQdrBVInU0Qawb5A+BH4a310feGspIdffEug=;
 b=pUFxRUzW2Fc/AnMh/axl/Y9/3+DHRiKp6mugjVeysZNI3XQeQy34KCDonezUaTsJy+PEGvs0wMK5Yu1W1PlSlbKcWA2waftHmhO4z1Z3jjbsbhRCYhvE6arcoyDBsLlTaANTCb4Ntw+zKYCGSjRymJyJGRNGIdsXiYVXAafAHJ0=
Received: from MN2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:208:23b::33)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 06:44:35 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::aa) by MN2PR11CA0028.outlook.office365.com
 (2603:10b6:208:23b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 06:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 06:44:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 01:44:34 -0500
Received: from hjbog-srdc-41.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Jul 2025 01:44:29 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<rafael@kernel.org>, <len.brown@intel.com>, <pavel@kernel.org>,
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ray.huang@amd.com>, <matthew.auld@intel.com>,
	<matthew.brost@intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>
CC: <mario.limonciello@amd.com>, <lijo.lazar@amd.com>, <victor.zhao@amd.com>,
	<haijun.chang@amd.com>, <Qing.Ma@amd.com>, <Owen.Zhang2@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Samuel
 Zhang" <guoqing.zhang@amd.com>
Subject: [PATCH v4 3/5] PM: hibernate: shrink shmem pages after dev_pm_ops.prepare()
Date: Wed, 9 Jul 2025 14:44:02 +0800
Message-ID: <20250709064404.839975-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250709064404.839975-1-guoqing.zhang@amd.com>
References: <20250709064404.839975-1-guoqing.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c8f3a2-927a-4d73-061e-08ddbeb4113d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ADQ3Truv3IPISREAfKw3FUL88jhuv+yLL0EU450GBBMm7SP/PSjEoIcrL5zM?=
 =?us-ascii?Q?NF0svOMEY9UCk8kE3S0dNPDrwOOjDDYSZsFIV81jgZuVL2Q8iHauG7V2UnvG?=
 =?us-ascii?Q?as0l7VClKO7lZRJZM/0BiwfIIbLJ0G5oexq0ycY9ZlkCk51TB9AzxQzVkiUQ?=
 =?us-ascii?Q?ElBZ/Cen9wio2Kwbro3W13gXXiuJAr+SepF7wkFw0WzukVLfh52Ymkcl8vI5?=
 =?us-ascii?Q?ZQvHP3oBOmYxI54KIWAQigmhhE1m1o6IyDylFeyqnxHjb0jpyMTctNyi5DgX?=
 =?us-ascii?Q?f6qWxpOOe61+2Y/JpjPb4/fbxSrgt/k8dE/kmgR29zclMxwQDlp5HYPzYwrV?=
 =?us-ascii?Q?/LmAcGAE8JaNZ9+vuLYoJRV8CpDLYlxcXq6NtTfjEeYQwtw0JDoNkuS1qxTx?=
 =?us-ascii?Q?lfcXyI5a07tTOVkIwbVsMpbZV/icwvUviC4lL3qxRks1395YWNNIqzLDX6Go?=
 =?us-ascii?Q?OquU+bB99Tw02I/WnlW71MpUU+b9IVyhNVKjTaUmVhmHhJ0UkM7JXib6bclc?=
 =?us-ascii?Q?hIKp6wwHV4wC6vfQVWB3ARRGvwPied1oQ6TrkuOGA5QL3Xb+Anv+j7Ai78z4?=
 =?us-ascii?Q?g6FaMnY4Wm7y9arE2cuIGbDt3JLiWQUuqhQgn6f89igI0GPz5obhlxhkdYX2?=
 =?us-ascii?Q?CAP7wT41TOHzCVGMkDB/sZQfKkOpPWfz3qBNf0dwzqSu7lv18KKNsVlFurpT?=
 =?us-ascii?Q?10KZof8P9vYt1ng1XxjG/glbQeNAC2G+t5/wZ2ZvtRocM1c5Ke57dbIDbqn7?=
 =?us-ascii?Q?EaKCrXvnE2WypvC2HfaW6L93C3ZG1XywqjCC7/KUfmNSfT0G6fgY6sQrsA0H?=
 =?us-ascii?Q?y4IrYp2Hs97TLtLDSn2GkBDKYhMz0ZKq4q6OkejZ/Lo6oKuv5bTN6gKKgAaR?=
 =?us-ascii?Q?9JVyjzMW3XNQv3OCvbv0D/oScMcLK3xKk+w36lfnVBrv9EopIfczsLV32ur4?=
 =?us-ascii?Q?Gqm4mw7G+baHZQet0j2jQhxqgmf0doxBp6z4gwBSIkHTpel2jigDBtjD6iMO?=
 =?us-ascii?Q?1nEd3egBHQD36Q744QCQsnD4qxeuI3ybArTXi6Paq5VHDk4Wm5dJv10GVExk?=
 =?us-ascii?Q?Jh0R5SUzlaHh5Z940ZSfuVotLyM8xDDNNcZMO5Et1OdXgTZd0+syikwy8eDx?=
 =?us-ascii?Q?z3Y/NgJJaBvCrrc+LzmkRRHDrzIjbA1JOVidTTbAipx6sqQcfWCWkaLrdkfr?=
 =?us-ascii?Q?wx8WgFPYKmrpCSugWDb3a5qsQDcvsN/VWpU1mWyRAzyO+PoWtDrQnLOWBW13?=
 =?us-ascii?Q?D1VE4hIJByw1om5IULCZt2erd2jN/9wxc9cbR3Aq6VJ2YL1Ug1UwFd7eS4Ka?=
 =?us-ascii?Q?YanyC8FB0F67a7omuy3QRmJjdfdNEghULRnUsZA7YOm9oxnQGT8wBe+JRKyU?=
 =?us-ascii?Q?Y7SHqv4RU3tu0bN8PH+vkv5tVIKj+67/zfBKys4rGx5dP1TgIU8rizsxiCfg?=
 =?us-ascii?Q?Picup5fuwf8ei8qXMiqy4Lnkj/9bYfDhRflDZeqyKCEMhZM6s6HbVnZNWctR?=
 =?us-ascii?Q?HEDr5sF7Tc+TwXZJVNNhSEptEVBzzNWKEzMzANJ3b/OQL5cTk6vL9qV/nA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 06:44:34.8656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c8f3a2-927a-4d73-061e-08ddbeb4113d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

When hibernate with data center dGPUs, huge number of VRAM data will be
moved to shmem during dev_pm_ops.prepare(). These shmem pages take a lot
of system memory so that there's no enough free memory for creating the
hibernation image. This will cause hibernation fail and abort.

After dev_pm_ops.prepare(), call shrink_all_memory() to force move shmem
pages to swap disk and reclaim the pages, so that there's enough system
memory for hibernation image and less pages needed to copy to the image.

This patch can only flush and free about half shmem pages. It will be
better to flush and free more pages, even all of shmem pages, so that
there're less pages to be copied to the hibernation image and the overall
hibernation time can be reduced.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 kernel/power/hibernate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 10a01af63a80..7ae9d9a7aa1d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -370,6 +370,23 @@ static int create_image(int platform_mode)
 	return error;
 }
 
+static void shrink_shmem_memory(void)
+{
+	struct sysinfo info;
+	unsigned long nr_shmem_pages, nr_freed_pages;
+
+	si_meminfo(&info);
+	nr_shmem_pages = info.sharedram; /* current page count used for shmem */
+	/*
+	 * The intent is to reclaim all shmem pages. Though shrink_all_memory() can
+	 * only reclaim about half of them, it's enough for creating the hibernation
+	 * image.
+	 */
+	nr_freed_pages = shrink_all_memory(nr_shmem_pages);
+	pr_debug("requested to reclaim %lu shmem pages, actually freed %lu pages\n",
+			nr_shmem_pages, nr_freed_pages);
+}
+
 /**
  * hibernation_snapshot - Quiesce devices and create a hibernation image.
  * @platform_mode: If set, use platform driver to prepare for the transition.
@@ -411,6 +428,15 @@ int hibernation_snapshot(int platform_mode)
 		goto Thaw;
 	}
 
+	/*
+	 * Device drivers may move lots of data to shmem in dpm_prepare(). The shmem
+	 * pages will use lots of system memory, causing hibernation image creation
+	 * fail due to insufficient free memory.
+	 * This call is to force flush the shmem pages to swap disk and reclaim
+	 * the system memory so that image creation can succeed.
+	 */
+	shrink_shmem_memory();
+
 	suspend_console();
 	pm_restrict_gfp_mask();
 
-- 
2.43.5


