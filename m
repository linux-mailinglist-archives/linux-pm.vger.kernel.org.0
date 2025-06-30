Return-Path: <linux-pm+bounces-29832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571D0AEDA22
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 12:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2F6188F29E
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E79257435;
	Mon, 30 Jun 2025 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1AMjU8Is"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED105257427;
	Mon, 30 Jun 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280110; cv=fail; b=rQBdezxD9xph1EP6RDEjxf0pvxskgNrRaYUI7vu4i4lsP40b9Ma/q2c75ka3TVkBr3XNl41yZPeQO7u7NXR77UMYtIbkV/rqAw9xbvgjlZ9MKbvX6bfmxDnOKq/k8xjMPSX/zlNllgS2DmJxy3djmcS4B5VX7B25Yeh3eWXVVhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280110; c=relaxed/simple;
	bh=NjDg5yhjRlq+5r+MDaAhAint4+Zf+EsIeHD/HCkGdsI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGpQ5z+WaRW2MNmZ3l7XWSVui3GU/voBpDUgJ/phpRo9YOSgYZUBmo/kJnlDsANbjF9i9iGFZUTg7e1G+lqZ8e7iZ/gZMvkcznyFg+zMuMTAQtqaiEVqHY+Z84Kgxk4Q3AAxKWwAwAXw0agzSQm5RF3ML8yMjGb0pgsZwaEZJVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1AMjU8Is; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BobdrmNHzpqrFHeuditosSFG3q3sumCCdBmGPvQX6Jbe5nHGb3rDzGTBjSDSn04LeY2O7j+BIbW0dIXLEXpWQLN4uhoLXH/apdZtSDy1NCeT7KPPXnBpMvrq6bMHY4VLUJ1j9en+oMO7w13VzU6HxuYtPiJf4bonhPOp9gvI5tE++/zvHUHJNh3MUcr77zEUSW8lI/1UwE7XQ+/LgKLBWkE8bbOp97qrKeVgzhlkfxF5Mf2Y32bHW0XTmxK4jC+CGJSxfxOyOvrdFvsj+JZeMBc3kKg1s+n94uOP9Rvw6KZdn30l8zsag+wyv5URWsL0C+TGtc/7K3piG6eV6B/Q4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4L7Ww+hhD42gc5GQN0DToyDYofS1ZmQRzIw0dKVfFs=;
 b=gxeXYmQgA5TRkcW337vl5d5benkhZVn4d/d3Tz1+hg6vVqz8wpJYQf8j8+ARpFcrqQLSRL4kv+Dzz9YZKzDTcgAqIZr6YKw+TQwf/ztU7ZyHzPMHHIDrpe4GZpMVClyhsN7Dn5WqusrSe3RjWkbB3vEC5q81t8Pt3gSZEey3Z45/YlwudzK1CC7qdlJzB9KIFwxYxxEhlinwOHw2ekbD9S/2uk9eh+JmA8Bih3XZfWOhWCntxneterkAbTna835eN81zwlMsrSFcO7PCL+1RbLCsCtNVWwOlD4YwNp7utuvrIfD/hq3BsJfLkNsfXAfWcwc8iJkIM+wYeb1am9XkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4L7Ww+hhD42gc5GQN0DToyDYofS1ZmQRzIw0dKVfFs=;
 b=1AMjU8Isl/gg5wj3SZVvVuOZhrAr7sGH0koOCkro0j9loMc+JtTtHDD0M6z/6rt0TwQ+KZUSBGGRkaZYD+GLFwkN5BA/T6AvyiKE1nmR9GirO2YJEo6IPP7N8vDBYJ1tJPCmlCKwadyFGjnRb57B3EecG78+qWeobH4wi5xK3xs=
Received: from SJ0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:a03:3a0::35)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::984) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 30 Jun
 2025 10:41:44 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::e0) by SJ0PR03CA0270.outlook.office365.com
 (2603:10b6:a03:3a0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Mon,
 30 Jun 2025 10:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 10:41:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 05:41:37 -0500
Received: from hjbog-srdc-41.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Jun 2025 05:41:34 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <rafael@kernel.org>, <len.brown@intel.com>, <pavel@kernel.org>,
	<alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<mario.limonciello@amd.com>, <lijo.lazar@amd.com>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <Qing.Ma@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Samuel Zhang
	<guoqing.zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: skip kfd resume_process for dev_pm_ops.thaw()
Date: Mon, 30 Jun 2025 18:41:16 +0800
Message-ID: <20250630104116.3050306-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250630104116.3050306-1-guoqing.zhang@amd.com>
References: <20250630104116.3050306-1-guoqing.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: e379d11f-4fb9-49aa-d7f3-08ddb7c2b4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HY6ZSg9aOegnZWnSOd/13F/BBalC7+jgn+CZeIVwmWXYHgMOaxYd4E6Lug6S?=
 =?us-ascii?Q?SVQhi0IRrWKI01PSMUz1Wp874LvMITNjjp+X/BgOl4BZLjSUkCd7384aj22w?=
 =?us-ascii?Q?yN7o1168iy5bomZdF4Rh4ASAGeiUcmuMvk1h+jGXkBddjTtRfBN0qNSA15T0?=
 =?us-ascii?Q?0eBWEo+WbmUr4JW/bx2oOCGH2ZsvQ8wr6/7FGZrnwIjFdWGnj9Je3Sdcofy3?=
 =?us-ascii?Q?I8CJ58Ct0khRMbq6e2HMBNBOS2teKOB1CfyjlSZoJN7dzTpb4d8HeovV/9gi?=
 =?us-ascii?Q?3e9o5Ev3eF/TRyMCfW2F1fZrv00c+xL8MXSfYl0jF2+AxnYl6TqLFeB+oLTV?=
 =?us-ascii?Q?8TW3waArgP9SC4wtWncBLLzgJb9BNzkOYV22x2onHnltZT09RqGV2Tx4i3Nm?=
 =?us-ascii?Q?Ri43TxM/G/jUKQKMIHlk6ywKx1+dfsuJdELj1VYg+y8JnFATCL/qnO2bXXHa?=
 =?us-ascii?Q?lNcXZhI9JyycuawzicDb6g2iZgOhsAqEeFqrh2Q0n5JT5K0S++/Rpoz6rLRy?=
 =?us-ascii?Q?eFxfayXbbUt5IPCN4bzAXh0FEd7MiRPnVYIjUpLCG7orJZZCiLElmC5zGih8?=
 =?us-ascii?Q?VvB7cKon2kVHflf9nKSkZXm1qNmW/3rsC/4hcUpb0JvM3ix5ncySlP0IhsqJ?=
 =?us-ascii?Q?pzy0bRtqheee0wmBWWuGhiKKETG2raUrNvJuXZ3uI2eCmSLXPHyJD3swK9bP?=
 =?us-ascii?Q?QDR++BBLkuH/g57sEOcdcTdH+IxgtqM7Rcvd3lWgH0hQ+JOkWvJyCT/ajfiW?=
 =?us-ascii?Q?y5yCzN/goY7iKJeYdYGc6AvctRrbjexEEUjHAb3OTFYTrECCtPelejVYevGz?=
 =?us-ascii?Q?H8uIkQ9Qbu38yaw8iKbk68KHsWgYKu6OGWfstjEHdradzxS9sjH8J59XwLUJ?=
 =?us-ascii?Q?kaW/P2oKhIcGRM+iASYFDuMJKFoNOk4E/PJlsao/3isxLRpWKa+97i0amjPW?=
 =?us-ascii?Q?jjqbYTVoxolAZHOemaLS1ab3MmQyjeCt1/o+SJpFVVj2vz0avxwz1jqqXdHF?=
 =?us-ascii?Q?uusdRUPP5+wggLCMDlRhzmd0JvbmH8vYG/UjiM8bCjhV3xkJvpEJYCDqHwzg?=
 =?us-ascii?Q?2EJoFLsqR1ebtT9ugVVDeSMJH02n+fn+MGDDG4+PulqcQECPf0SWX3wDtbwi?=
 =?us-ascii?Q?mdYnPV1/qGo8/LJtnFdCc4IsRGlR5oBM4dCD9gzaWkl0lqPAHsL+AE47Viyb?=
 =?us-ascii?Q?wj0qeGj6kXzj0GWIRgag3rcvXcpOJk/Qf5GEiMx8HyRaFys/dUakC7qUHSfY?=
 =?us-ascii?Q?Y9XyJc8oQn2Q6h8y0jhTndM1M8+TRHUqkPL+l7H2H9vTU+9lhAbXoxx+Bhf0?=
 =?us-ascii?Q?IKsfiHBXDWGHXVLB69EjvioTFsViMRr1LRbGlT4x/uDwXZr36WUmHaDNr6Vt?=
 =?us-ascii?Q?6UBvaclpKW/mgk8jJGF/SeHoJrtJ7XNbUejaywXtUHVf50FCOTuBIP+lLPP4?=
 =?us-ascii?Q?SYLseOZeyOCIwdKy6C0itii7nly48vSHG8qFaWBoaW+zva+XYn+RBWGI/ytA?=
 =?us-ascii?Q?231NgTEvCBxchDgAsk4QAtq9gJXfAou3PG1G?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 10:41:44.0826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e379d11f-4fb9-49aa-d7f3-08ddb7c2b4d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1

The hibernation successful workflow:
- prepare: evict VRAM and swapout GTT BOs
- freeze
- create the hibernation image in system memory
- thaw: swapin and restore BOs
- complete
- write hibernation image to disk
- amdgpu_pci_shutdown
- goto S5, turn off the system.

During prepare stage of hibernation, VRAM and GTT BOs will be swapout to
shmem. Then in thaw stage, all BOs will be swapin and restored.

On server with 192GB VRAM * 8 dGPUs and 1.7TB system memory,
the swapin and restore BOs takes too long (50 minutes) and it is not
necessary since the follow-up stages does not use GPU.

This patch is to skip BOs restore during thaw to reduce the hibernation
time.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a8f4697deb1b..b550d07190a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5328,7 +5328,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		amdgpu_virt_init_data_exchange(adev);
 		amdgpu_virt_release_full_gpu(adev, true);
 
-		if (!adev->in_s0ix && !r && !adev->in_runpm)
+		if (!adev->in_s0ix && !r && !adev->in_runpm && !adev->in_s4)
 			r = amdgpu_amdkfd_resume_process(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 571b70da4562..23b76e8ac2fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2734,7 +2734,9 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->in_s4 = false;
 	return amdgpu_device_resume(drm_dev, true);
 }
 
-- 
2.43.5


