Return-Path: <linux-pm+bounces-30339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B969AFC49F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 09:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4766C7A5D16
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8397029B224;
	Tue,  8 Jul 2025 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ujWwNKTZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D329ACE0;
	Tue,  8 Jul 2025 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961094; cv=fail; b=C4SMCKLPIfFLDG4o7Mq71rj6MP8RZpNh9kOQ68Ufxn6pCvAoX25y97/kAi7RfMF8NBD2WbnZUjrSVNo0SsfrxSqvx87iPgA6rduwSOQPmUtxuAu8wm6qMGvAuChwAtZu+2wKDIc4aEYfhMwxqjUS+suAT5lXf4JaqLthnd9k3mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961094; c=relaxed/simple;
	bh=YDH5AH1ozzse6I1Ekt9uDulQ/+OhWgKpcTZje7FOfK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aABhLsHOqHDN/TseByTEY5N+/XAFJX6apSpRsLizN2VIAFJD6ke/uGvFfMuhHygiA70d/i6DLc+IHSmlRnvzT89otPZo3eHP6k91sLJxIkoz4Aha3Sb87y5NTUddXLyaFzV7xy4mwIvKDjqlox7Y0B3GUK2VYH+xPCrkz61ujGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ujWwNKTZ; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYg7tkg9gG4+bcimuMxBlNWjLLJXYjltRM5OTDkM7h7HQPgNIV5pQ2EDc+cHK8ohYL58AfKKIItZMBp+YCYE17vIfhNiK84teHFDzAhFXRVusagbGLfNnMh4O9AFxW+S49hsaldlJXSzFIbOzrlT/BAQhUwe1Jxwdw4ozpCJPvtkwZxJ2Qu6HwyMZmDanWI11LeeQHKbKE1ptu488knmhWfLfbyd2zFWI7WYmfiWICf2xS+T3P9NYdwnpEvdd9I/mTJNzA7nJdInN5YpaSikTre5X6We9oEXJgNr/sTWEA1QFACvKU2FXW/jPyXuEJU0KGxurispIS7jCTcPMdLYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TeI+iCMqU9F15Z68klPCBSSb0Wp8V2yLC/XgqFY8fQ=;
 b=yxCTkxhlA6HfOIbBdLkddjUHZmvXEd61W7zNTKx4D0QFx3J5uiqIdajvVATsx3/26SLSgI/vk0BwKI2nHyCPgj0Kqj8E5yzVNI1AORdv2+9REwlP7sF5rX+3eWhuWoqB+j+QgbDmTlYxZi32xP1Bu0TBH+4aq/WHWQdUUHV4RODNWFgZ12KI3OuVI6YFzH0tCcmyiVo9V77USGTl0LYrqe8Rtdr7jQDHwOIzrO8tdMLa6Ds7Dua94Ltf83nPH0g/u2xkPBj3J6e3Yy5JVkrNmsRIhMiDyt0Njcx5pyVuFPVaiB2ZQe+OF3fF8J1opDP0j0RsoNyszZ4VSldvFtZo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TeI+iCMqU9F15Z68klPCBSSb0Wp8V2yLC/XgqFY8fQ=;
 b=ujWwNKTZ9M5KfjrgmH/aPD+wrLhDUCMKrjl2Ex7YahWuxTl7DfyKzNALfiz/evlRZGzQ2y64vdQvhwmAXVtSEWE4+X3piEiZyXlnrO/hsDTIe3TkUaRFBjH+Jw4ZIG9WP5VqWMFra1CEkfRTlVt1ZMEn4L13CXU9P9XqcYOiXm4=
Received: from DS7P220CA0049.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::13) by
 IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 07:51:29 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:8:224:cafe::d7) by DS7P220CA0049.outlook.office365.com
 (2603:10b6:8:224::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 07:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 07:51:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 02:51:27 -0500
Received: from hjbog-srdc-41.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Jul 2025 02:51:22 -0500
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
Subject: [PATCH v3 1/5] drm/ttm: add new api ttm_device_prepare_hibernation()
Date: Tue, 8 Jul 2025 15:42:44 +0800
Message-ID: <20250708074248.1674924-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250708074248.1674924-1-guoqing.zhang@amd.com>
References: <20250708074248.1674924-1-guoqing.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|IA4PR12MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f1bbf4-4fbc-4a7c-0fb9-08ddbdf43f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WvBBd6AbeXCZx/4Oxd8lO6fvjpfw8qb/Mm1C2rA9FYYTGd5NxgxR7QRMjePs?=
 =?us-ascii?Q?B1NDpYpoX2y1oNo3LKW26p4NCAXgIQLoKJeWHl8de2/KZ8eUISqLAMuOwxJp?=
 =?us-ascii?Q?iEsNkgQYQTWEEMVT0OcHOK1GsGSd+W7JJqW4knz1VF8iYBxo5+Fq8sOF4aaY?=
 =?us-ascii?Q?szutlex2MC2pOJdOXswQIywNnEzG9cJ6BL6D4uoUZNzJoDZ5Ha/7uJpnK3Xb?=
 =?us-ascii?Q?MYw5L7M0O1pHHxzZsVPyRnUWgdb+/IRnvuHOSEQNvP/20F+99K5Kq83vFg+b?=
 =?us-ascii?Q?ykTLu2X7RKvRHW84hmnBzgvaNJlH5xXprNSgWHkVzGDCFoRu/yxFujibohVE?=
 =?us-ascii?Q?bH1SZ4Br5i/auTLZObBi6b0z44nN7GbsAErtXVJXiT8mGJZ2hEhgXkird73B?=
 =?us-ascii?Q?kjyJwoQ++yhJBODQHlYWzcxdTa20R4J9mVvoHuANOPhUNKIhzOP+f0sOWTEG?=
 =?us-ascii?Q?57f0fG6Xc1MnU+KmJO0ZjHXJXIWARodtYvlvDjmJTxFmZiHBqa/oPCIi2+WM?=
 =?us-ascii?Q?CcJqr9rg6ZITrnJG+Zw2laJy8Hd7jWtVa3okI16J90/RzOrcGFl6kmMJXyS1?=
 =?us-ascii?Q?0yykzTgc+oghUX6JyzDrIv1yqWmSrZM4usZ0pVKR+avGRUud8GFdBlU16y7o?=
 =?us-ascii?Q?/P2Rqgbt6WAiocE23hV3ML6SmAf0cPoQwXJG16+cYzHlkdKeM3AFDz+tSOOq?=
 =?us-ascii?Q?fn0zAHkX0fqAJZhJb+VEzQnIDKzegg8YI+osjcwbhDmEeAiQR52ATjGVBS8L?=
 =?us-ascii?Q?tWpjTAB0XbI4rt5G9sY6xRLRb0ErXoJvBxWL74ZHwV67cugngtGZdIkpGwe4?=
 =?us-ascii?Q?UDJ3OvXOWbm9ejjaCMLid0SE2zGwI1CkZsxf+RG6StCtl16xefaH56zc2VQL?=
 =?us-ascii?Q?kdvoIF6nhXa5tSXq+nGprCBlOtrIwvCJ2v8wAvgdwSILiqiP2QuPzkz0tHo5?=
 =?us-ascii?Q?OOxdnLUGBsL57TZVefWGmePqaRGLkgqHDe+/n283rKgnmkr3FGv7HZ+RkzCp?=
 =?us-ascii?Q?GsnALw6oc2jE08ycbJIKZG5VPzL33RwR1RETEe19r/qrb4w7m17coJ2vUlJo?=
 =?us-ascii?Q?qVwVOmJJGBj5lHw7hLLlj1P5R1f3dHQvQcJI6CGU0W9FLZGpfaA+X6g9A9Pt?=
 =?us-ascii?Q?Nuah+8q0Vx+oyc8ptXQVtZzR/uGrH27WzQC6qQqv8JdL3w/iLu0JWXZqnEdo?=
 =?us-ascii?Q?EjhYHFbXjPtLVzKV7WRSVIDKg/zrocFyNNv4Po91lpY83uRzoB3ILAQa9BM/?=
 =?us-ascii?Q?SyKXZPH4/Vru7yDgI5tFFQSml6iFVykykiRPRh7NrjHrifWsihCmM33PoE4P?=
 =?us-ascii?Q?VEtJqJvTd6+gDY47gq6cPVt8MPZl1c3YL3nnmtnvMObbw+zBbNzoKO53iwC6?=
 =?us-ascii?Q?rgCz0OyKcrtxbJ7i2cYYUSzxOQFEtW1d6QdMC4XZQhakFygXL30VKzpDDIvE?=
 =?us-ascii?Q?aKzSUm+wk4eE/aRbUo31HfAe7CgRLlm+qXCNaV7CV/DEKwd6pmfoR8L1Z4ae?=
 =?us-ascii?Q?shtZBXHYx/gbWgJEn97d2SilExbsHgL16rQ/TQwQc9KQdrETalOs5Oh2Ew?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:51:29.2667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f1bbf4-4fbc-4a7c-0fb9-08ddbdf43f9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9810

This new api is used for hibernation to move GTT BOs to shmem after
VRAM eviction. shmem will be flushed to swap disk later to reduce
the system memory usage for hibernation.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/ttm/ttm_device.c | 22 ++++++++++++++++++++++
 include/drm/ttm/ttm_device.h     |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 02e797fd1891..f14437ea0cce 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -123,6 +123,28 @@ static int ttm_global_init(void)
 	return ret;
 }
 
+/**
+ * move GTT BOs to shmem for hibernation.
+ *
+ * returns 0 on success, negative on failure.
+ */
+int ttm_device_prepare_hibernation(struct ttm_device *bdev)
+{
+	struct ttm_operation_ctx ctx = {
+		.interruptible = false,
+		.no_wait_gpu = false,
+		.force_alloc = true
+	};
+	int ret;
+
+	guard(mutex)(&ttm_global_mutex);
+	do {
+		ret = ttm_device_swapout(bdev, &ctx, GFP_KERNEL);
+	} while (ret > 0);
+	return ret;
+}
+EXPORT_SYMBOL(ttm_device_prepare_hibernation);
+
 /*
  * A buffer object shrink method that tries to swap out the first
  * buffer object on the global::swap_lru list.
diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
index 39b8636b1845..592b5f802859 100644
--- a/include/drm/ttm/ttm_device.h
+++ b/include/drm/ttm/ttm_device.h
@@ -272,6 +272,7 @@ struct ttm_device {
 int ttm_global_swapout(struct ttm_operation_ctx *ctx, gfp_t gfp_flags);
 int ttm_device_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx,
 		       gfp_t gfp_flags);
+int ttm_device_prepare_hibernation(struct ttm_device *bdev);
 
 static inline struct ttm_resource_manager *
 ttm_manager_type(struct ttm_device *bdev, int mem_type)
-- 
2.43.5


