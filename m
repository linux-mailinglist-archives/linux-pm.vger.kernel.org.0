Return-Path: <linux-pm+bounces-30125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4325FAF8FB7
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954154A3A0E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68E12F2719;
	Fri,  4 Jul 2025 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IlA86w+d"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147182F234E;
	Fri,  4 Jul 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624068; cv=fail; b=qK3PmWQ6/5tTMXZMn4Sr6zU8eG7rOod0fWY57JJwP8Uqwwtik9u+P18OSP18Jp9xFFKThB/kFGXq1QkuqK2YjGKWwJ7glFo2G6sMRFeKs1lwPAhK3XHTWbB+fgiYracSQLYhRsUPqlABgbuo+HVyB0A+1CnQMjgnE5NAi3OpYW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624068; c=relaxed/simple;
	bh=B/lOqwCmA61g9ceeOtENzGlAF4TsAKqanEv7hU8eT24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrJ+/yQHT8UuMBc8K7tvbvqV9ZsITILyRZqtl/gRGFE/b9VHrEEqDJrwpGAHW7A8g0cykR4vFWO0/He/hMg/s5avQ6/hYWq0ZjNWpnQd7AqaVTVlwGXiaPqzJh7u4y91FSxioAat2GE73Hqn24bACFeAYdf+BzAUVPMTkHTwPA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IlA86w+d; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8eewG0SYy4D+XXEM2ubeu/H3v0HC7LnaQCqb40Z8V1zWrMDJJBh61MobkKmyjTP/vx7dpr0RWT7X4yr6Kjf6sshSZAWRGJPJFbDtIKvwefOUdrQ4vPoeBTbSOKjyGBwtG/FZpPPVIi+iDnOYWe+rOW/XLMZkKMsRmeDGCes079Ie5FvcYEnc8PmPenUtsXoB+/JCLo6ZHPBuG7k1tsb3pqAlanh4lF6vQDY97kA/uGLoACjhdm9AhQcDGnxd4LaTRhvtItfHlXmfhIKQaRtjb9rs6tiQQwWUdH+tvFHa3eNXRBbujxi8glpGhBZM7urO12S8JheOFyBD30MR1zvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khk92tWJqudEqkUAf8XgKfc2JRmxRaenPZMItyrzpg8=;
 b=roIZIxpTZa1B1V2t2o3dK/JPYbXLtPPxedx4r5kJbifDg7/CRgT/dsHmTCPt6isbojrm7/GUhQCPzNmyRlBC3IgJZJMs0RI2fcZFBbdpce2xuz0DwhLjvgwwgeEpZuHvKoLyQ0bL5jAhyVjul3P0gKRW8ydZJuPJxHdrxg3vlD3pAavkPv26j24aGtzalI0VWQf0Ztq+LHSgxzZvkXRu/BLWxVPU1zIVmkosgZ3KbJq6ll0akxVNSDT2z7ZRseKY72ck5v6zglNujInEdRCRcuTAaSeE/qKNZGim5REQ/UaNi2ZFtPw2o846B5+cI0mMaNmwWA75Wmtfqv6MAdkmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khk92tWJqudEqkUAf8XgKfc2JRmxRaenPZMItyrzpg8=;
 b=IlA86w+dvLm9TmDNRrcc4okJh1EA7WdW07xoY0CT1vHqOXHjEOEaq/nD3ulHScCAuEiHG5jm1Z3CJnhmkDlwqHfA9Yn5Y0FP4bfyP+9VPMyLJ43FZgr43cL+TXpGYcV5Nr6BsuNrbXohTfuKMTbuIpzi+FxvJlpLcY9vTwNQPmk=
Received: from BYAPR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:e0::48)
 by CY1PR12MB9603.namprd12.prod.outlook.com (2603:10b6:930:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 10:14:23 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::a5) by BYAPR05CA0107.outlook.office365.com
 (2603:10b6:a03:e0::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.14 via Frontend Transport; Fri,
 4 Jul 2025 10:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 10:14:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 05:14:15 -0500
Received: from hjbog-srdc-41.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Jul 2025 05:14:10 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<rafael@kernel.org>, <len.brown@intel.com>, <pavel@kernel.org>,
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ray.huang@amd.com>, <matthew.auld@intel.com>,
	<matthew.brost@intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>
CC: <mario.limonciello@amd.com>, <lijo.lazar@amd.com>, <victor.zhao@amd.com>,
	<haijun.chang@amd.com>, <Qing.Ma@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Samuel Zhang <guoqing.zhang@amd.com>
Subject: [PATCH v2 2/5] drm/amdgpu: move GTT to shmem after eviction for hibernation
Date: Fri, 4 Jul 2025 18:12:30 +0800
Message-ID: <20250704101233.347506-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250704101233.347506-1-guoqing.zhang@amd.com>
References: <20250704101233.347506-1-guoqing.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: 2730100d-6ba9-46a3-8181-08ddbae38c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WXf80uMaRngyYzbeBZFUPHi4c5WdCiKRid9Pzti8L2+X+jjJ1zu++wS2hfZt?=
 =?us-ascii?Q?hlMrkXd/2YK3EY5ePq1mBXNIGVQtsbfp/6DH3i4178D2gqhv2S5mitjZYD7N?=
 =?us-ascii?Q?Oujz1mYRw3uGFZkDkwol70zhrfBKUz9u1dyMgphAAw2X1yaYC+unC/AcHGo8?=
 =?us-ascii?Q?qQaXFY3HuRCuaZnbbcX1vRm0HNGkUVahRPKun5DfQ5+kA9P659vngwqXPOF0?=
 =?us-ascii?Q?5b9h8qbvKV4DXqG32KBE7cb/ds0/haE0yPpgOjaV//tL3WCoGhviktXQ1Or/?=
 =?us-ascii?Q?KknrGOMxPECHVFFhIZv/f9jzB1vhGhbAIsyAdiKk6vtZ71xBTW2AofZ19gW7?=
 =?us-ascii?Q?iK2RpJQ18B6+EiyZosasZY4g7/OPB/pesTC7liZJaMRR6RTMjJZ+SNtzAKV8?=
 =?us-ascii?Q?DYJZUIxSq8iY3M2RF+kaDksNXLaRAVTnvzk5WgEj6kLdg0MO11hWHykFSQEU?=
 =?us-ascii?Q?/GcUH0E+iCn8OhChq65F6CL22duSoDukOaqnXcDxRV/I4ugo8PU1gBIbKAt8?=
 =?us-ascii?Q?xeqXQl9Ud2JA8vKrtU/MwNM/o7mDQ5jBV4TFnVPIMpgMs/qSSdLKZm6Xw/rp?=
 =?us-ascii?Q?HTGajQISdbgATDlICmQGLyhCQmWI1Ff2U0tZN0XMtjxOVQHvs+3StXaKvSIP?=
 =?us-ascii?Q?20lB8nCqLinCMiLaQghrD7FBHx+WqGz/IA3wYUi8yEg8HLLiLLzg1tzitacR?=
 =?us-ascii?Q?k3ADcncXdPuYgHKvxoR+fyJhvPK/ntXDHr7j8IfRlzj+4B9AW9QiRkxZ8Xh5?=
 =?us-ascii?Q?RZERqa1kKoPGSPaIZWpBujqOvV1XN1qXmVnM50vGkQUV6BO5mY9IY51XVbjk?=
 =?us-ascii?Q?V3valNzVvOcUhIzK7IATwZ+X37n3R5iwkSes3iLriCfmtRfjnREdbF0yism2?=
 =?us-ascii?Q?lhLNI+4HQx2knSahdSCq0pRasTIwkv4hqyF2CbxBSv/LyGR5SiTAtOoJ1Eb+?=
 =?us-ascii?Q?0niofyrAANBoCYs0c90V4jv8zgbVhnzP19y0Fk95EqmZ+9ekL2xbfGhpINbv?=
 =?us-ascii?Q?jeLa0KSQ+YgU1eSIh81vHcZFYZESFf/89lyawAdhWj4QkzRDz3ZG74g62Mof?=
 =?us-ascii?Q?DocmqAyK15D+b5Q8bRIOsS33rc/NcyPfqupc6cbsHEhsJ8OHdrd22mhUrTeV?=
 =?us-ascii?Q?LiEadgxIJtCvy/Pn7srV7lPTh4mLxjgT3wRsyXpeIgKeEhyFI9OyF7kD5bYm?=
 =?us-ascii?Q?Ni87YHAFfZXsi+w7B+4dA6u3C4uYg341zEbgM3Bpj7oi+E7nlo/81RMATdZU?=
 =?us-ascii?Q?q1fsygiA6KftegGmRI9R7xvDxvTDxrBrL4Dp2X7/oNdLDfrQptSfaJhu/ef4?=
 =?us-ascii?Q?rBpZmcf9yKCTNhNSaCLBftyoUyTDce72ZuGKtNj2YziSh7mh231bM7r9KXPf?=
 =?us-ascii?Q?rZCl4r7tUSOJNuKK3ppxT84Yenbe+3/PVtZ3kYdAb3hRU8P4RZDoDwe54y2z?=
 =?us-ascii?Q?m63cNF0Q+LPGRQknABC8YZplVkp46jnF4/uCqqrFPadlSbnAalwAbNX6d8A8?=
 =?us-ascii?Q?vkXmv/nR0BG1RcM07mhrPHWtfgiXst7wAxcEuYoutyOVQ1NuT9m1gTfu6g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:14:23.4279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2730100d-6ba9-46a3-8181-08ddbae38c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603

When hibernate with data center dGPUs, huge number of VRAM BOs evicted
to GTT and takes too much system memory. This will cause hibernation
fail due to insufficient memory for creating the hibernation image.

Move GTT BOs to shmem in KMD, then shmem to swap disk in kernel
hibernation code to make room for hibernation image.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 27ab4e754b2a..a0b0682236e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2414,6 +2414,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
 {
 	struct ttm_resource_manager *man;
+	int r;
 
 	switch (mem_type) {
 	case TTM_PL_VRAM:
@@ -2428,7 +2429,17 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
 		return -EINVAL;
 	}
 
-	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
+	r = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
+	if (r) {
+		DRM_ERROR("Failed to evict memory type %d\n", mem_type);
+		return r;
+	}
+	if (adev->in_s4 && mem_type == TTM_PL_VRAM) {
+		r = ttm_device_prepare_hibernation();
+		if (r)
+			DRM_ERROR("Failed to swap out, %d\n", r);
+	}
+	return r;
 }
 
 #if defined(CONFIG_DEBUG_FS)
-- 
2.43.5


