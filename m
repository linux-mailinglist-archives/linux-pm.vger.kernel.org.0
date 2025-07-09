Return-Path: <linux-pm+bounces-30423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990B6AFE067
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 08:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C929165231
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FB8272E7C;
	Wed,  9 Jul 2025 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SSrWBu4m"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E327281B;
	Wed,  9 Jul 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043468; cv=fail; b=td32yFCHfBTClm/NGff4umJlbhiH1/mhod8JFxwM/kNpnubIYRknTPglkTujyNi3gtbLCE1msQd3ZeWwxFC1A1YnMBt1iKajZyOas7lnIO6xGTUiFJCJ/ec7wfArgWWZC4WN6tlLS5nd/A5yZC/Vit5Gy8znGzDbcydGqJnbPOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043468; c=relaxed/simple;
	bh=6zWwDCopnbZLaxi0t0UOLIa7Fp0Qp86aZE1sq1ICn9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lojzpz0+HRsvz+BtHGEMx4mKAX2skJaUJx6t05nA0/Sve88uyyJAzj2T6dqkKVmn3pKoGDBQP8z4GQUe5c9AUfv0w2UACLAKknqDTv88fpabgpGfaBW+wnpN/7oKU11mtahLfBwDvyu5JDCfhujxxRKYx2/gLvWUkFOXqkXXIlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SSrWBu4m; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUioyGLOMukAed1lO7ySHR24hH/snlLWvneDQnfNWcAG7Lr8uv0D84qQsPxMOTj6RF3Mq8NQHu2mr4MyFNzUu8LR3qQbksV7kRjcZjXr5nHBebdzp7jGPkLzcmdr9DYhLEVhgqmqgD+KCrFi5GgC3Pdff3T3SYE87L7zkcervvBn9Cp6jtOFqDlQTCIy91zoLvY3XAxWvg6OzNfMvOoiTCeQi1plZKX3Dg0DjucuFrdp6vTPmrEIg7oz9o9TC3CXPSJwxL6fLHEhC+QrekUc5ta1z4G9luC6FQ0NQMJCZ35dEFEQw3jvQm8kU9rZAITXaCWn6vNpgeiYMDv/B5uG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOUK3XujX1rGsw4kogej0gJm9gjltYG3Kn+A75MPBCg=;
 b=LU3Ltmxwneu+2U+wzaRT/gRsS8XHTbnZw+EpP3TNm9IiGJX2ljw3PwNZjVSYUfCrg+wDdgpHXFV5jc3GGsNTXxida/dEt5LUuS3uAeZUlx5+sizx02Fa5ZlSS2sHFzexpxJjiGc1aVOksdPl+xkeQXBWnN2y4O31XUvzO0pO7xbxqx0tgNCYwVHGh2HX2zX9AKJh4zTt7zu2piSvhZk8qFqmytUbv6mZTQAYCoqnHpk+aGSG6Ojjjxm4lygFapIH3RhXWNcOvCCdKjscYErUI0cUgebvsxWxsWlzNSM8o/CzifEREMNQ8PAMQz31XEDBhMsdGxCW4DYgcBDUvNh6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOUK3XujX1rGsw4kogej0gJm9gjltYG3Kn+A75MPBCg=;
 b=SSrWBu4mkU6REaD5EGRcPm7SHL5+nE2SFQuQfmuJ8VgHSEZL43pCsgZbTvF5Qp2Tk5KMepbg/IMPzTY26ig+TOu1sTaV5YYDVtm6+q/uh8sRbCE57n5HGac4OALsAWhVqlMscHTW+bQHwnRIrQrfatErW0TjZRneLT5UD5IBgmw=
Received: from MN0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::26)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 06:44:23 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::67) by MN0P220CA0016.outlook.office365.com
 (2603:10b6:208:52e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 06:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Wed, 9 Jul 2025 06:44:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 01:44:22 -0500
Received: from hjbog-srdc-41.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Jul 2025 01:44:17 -0500
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
Subject: [PATCH v4 1/5] drm/ttm: add new api ttm_device_prepare_hibernation()
Date: Wed, 9 Jul 2025 14:44:00 +0800
Message-ID: <20250709064404.839975-2-guoqing.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: da74b663-d019-49a0-9a02-08ddbeb40a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TloYBhGbrHmD3vFxIGtOYhTKVMpvsmq4+/5/bolNfZUEM22eXDBBYElq9hUj?=
 =?us-ascii?Q?nZIjnx15eEf51JOhfa+QVkfV2fhf6K7jThkmmi2HqVFs5cXmU1wg3ehHRzMd?=
 =?us-ascii?Q?IpDFisHWjTVt6uxwM7UBR2phrf93PpZlN1q9yZqGjV3QeYczCzAnuhcqSoo2?=
 =?us-ascii?Q?E0nj2/UHoilUXdo+hmFcwJHAnKTSmChRCA7zBQwEyb7on3kgHf4/mNkduv4S?=
 =?us-ascii?Q?EmHq4XNPm8iIhT+wpYIv1MddhyhWk0g76AQUsb8AWkV0qa0u8oDF358zUuqK?=
 =?us-ascii?Q?qXhDycUM4Hgvfr7yFWfdIHiAB6vBOwm3WlqL9bjJZjk9pDaiO0eAP94VpJ2m?=
 =?us-ascii?Q?P4w2Ngq5hctShW64MMI4Lzt+4Ozlj2rs0OpdDucrNaDoY0CjvO6OtTByyRgO?=
 =?us-ascii?Q?GkEFPHpi4MgunpLXuX1pLibjM5MjoWLMuKkiRAHYPwpxmWoPQAw3+fpj1fOM?=
 =?us-ascii?Q?Etw/pgJrYT7kfzundS3OFCkHA033xVz9CHLTNuoktS8m4hcC1hehD9MWvS9x?=
 =?us-ascii?Q?aTpaesMQaB7/IYwrjPcemYc5S5GCFnPLEXP4IEsFFg6mjI9yy7uQcUBlxzsg?=
 =?us-ascii?Q?MREFsJfiUlge9poKlSBLZtK/2va8zh8AI68C7+xQTHN8qGfOxOaRHa2oWgcY?=
 =?us-ascii?Q?NF33rWfVZMFAiJlIPBGQe2/+O2R3eo7WNhTAtpTee4fyx75JzwCfDBMAeOrq?=
 =?us-ascii?Q?4RAQPFnzNdMz8WL6pRhplGG8FLwAgG9sX59Evmwi4n10SkS5ptTJg8EWn68E?=
 =?us-ascii?Q?rczruq7j2jsaPN1WjPcFRiPPuADrY7g41aQYCsV1i6t2zllUmNzkl3ZWgotB?=
 =?us-ascii?Q?+Y8X5GAKjg9lfXlSMJ01kMUFLzjxblX1NM1RL+A4NvG2ENV/JFBoiMyN+dbN?=
 =?us-ascii?Q?Yz1Y9VIORiCkxs7WoOteJxG7aX0NvbKelmGmGmTGERRUD8CgulJqQTggCzYG?=
 =?us-ascii?Q?zDL1QJ8Pw/TAEkX7jqiyVrrjhB0NMkECKh4bpBvqqmZdLSNcO86z+CVgBi0+?=
 =?us-ascii?Q?FQUTfhWBnKhphKwV7027EpqJrpM9Wb5ACmY1QRbB0KOZtkaJHJPu3fTPHYW1?=
 =?us-ascii?Q?4m54vDVE4kr3rFo1iNYafhyWHqwI/USTZLHTYRYpARekhuhlfu9c5jzUvuBG?=
 =?us-ascii?Q?UGhssyIu/weB67KEWfhYHCIik/wdJZnQ/wCT25S4pM0pFYwmQTVgyTPnc7G+?=
 =?us-ascii?Q?+m5W0L/A7JyITKdo9rmkWHfogNakEqjkNhrGNHP20TMJ9IAGlQMw2ZWXDsFB?=
 =?us-ascii?Q?hYQw5JrhPcMfT/XuY1inMDlYrTMyTAKc5dk/JGz0l9yQYzahKOwIzfs3ZowS?=
 =?us-ascii?Q?kpZxP/joP3NONSrGS81yy0CAZYyvskipBG5rjWYXVIWlas3jM1N4W9heDqCR?=
 =?us-ascii?Q?eiG5aEhJt7y5b0cAFoxJXFCWL9FHkgMbZAqCbu8QcAwAQAYk3yym01kiGYhr?=
 =?us-ascii?Q?KASPwN7a8bVahm7bQCsGcwoW7AXlqZ1SsbyjhQTsmKZbBrgqcQXJmrAOPFd/?=
 =?us-ascii?Q?WUxPFptuqCZmKya26h0mEsv02mFRX0G+iODcabKEvjAhnH/rZkjgoGJY/A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 06:44:23.2894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da74b663-d019-49a0-9a02-08ddbeb40a56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735

This new api is used for hibernation to move GTT BOs to shmem after
VRAM eviction. shmem will be flushed to swap disk later to reduce
the system memory usage for hibernation.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/ttm/ttm_device.c | 23 +++++++++++++++++++++++
 include/drm/ttm/ttm_device.h     |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 02e797fd1891..9c9ab1903919 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -123,6 +123,29 @@ static int ttm_global_init(void)
 	return ret;
 }
 
+/**
+ * ttm_device_prepare_hibernation - move GTT BOs to shmem for hibernation.
+ *
+ * @bdev: A pointer to a struct ttm_device to prepare hibernation for.
+ *
+ * Return: 0 on success, negative number on failure.
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


