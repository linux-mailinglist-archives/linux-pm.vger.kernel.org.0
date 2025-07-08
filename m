Return-Path: <linux-pm+bounces-30340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68BEAFC4A9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 09:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CDFF7A7DAD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D329E0F9;
	Tue,  8 Jul 2025 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nQskCLq3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D829B8E2;
	Tue,  8 Jul 2025 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961099; cv=fail; b=lgQ8Lm77erpgEaVPgcSBApKy1EEVXms7BAdaaHpktqeoMm3wzzX+mGsIH6MsVFN9j+fZpxuvekCCoH9Q2JND6XRRJ3YlkqUzpTM8FJgS+vHVO23uLDgqWhSyyfwz8ZosvajQopekz5aipTgvN6HeOOWbDtRuvr/RCSHf7WS029k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961099; c=relaxed/simple;
	bh=mv//6Z9YDW0cHkZV/f6iSGdo5Me6+Vrc+wbZGCqFbME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8eqnkwc91TpBPoKtzCvL35X3zWGVYnh2vADyWTvsRHRMKzICbk+OdE2lT6LFxof8Iz12qUnSRpWXX846wbpwLUS64QqrZTB1XkaryzbFgX6P+TX/kKvrtDUo85Mx9Ql834SV/Zez0QQN26VZDrbU9VBTQVBmZeaMRqh5znHk3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nQskCLq3; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEeThWKna5FNgHy6KmgF5XGvaCl+spjDidZ9krcka8ozdiDDfUQ6iCtAX2qKLfsFC671asytwWMB5JbrNv/gjUgjQiSPdQUk1fr3ZmAer5l0H9RGOOsEdSnijq6z9GWJiuefnCEI1hv4q5KfMXGVcRMtw9EDCzPgLtXKXz3/55stHCjuITc6HN+ncN9RyjDi7fC1rujSbgWeNcN4tmr83+P7iAG6G1e5YE07DlqgmqgDzxp+PfHMhgTD+IaCowwX70YCql6KkT2daBGkcAH17X19rWAj/gFNSe9O0ARQs79hl5QkR1nwlTScKbJAWD/rqAY3QvnlZNcZL1NIYc4F3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opUSMvWw85wfMcx+UmVj1IEPirxKfaNUf9AXBAMnC8c=;
 b=w5QOiM9ChdIMefLTNqCxqXtVebnisRo8pnzV/PjNG0GHXNy/oMncPt5udtp6lznHHqLZ5obMjhkvyhjezxSC9DSNuI8FPsVlYxfvGg0HE+iLPeFcfmClFPNWQprNNyaSCkJF4XnpS1uN9GxkDST2bdgHCamIPjeNjbWOVYDlhfak4/+CPvcGMFzE6UQ1sJUyOK/PjAW6gWu36nC1oFSTNhg9OB2NROOUJfDx0VrDbb75zNRa0alvJO7X5PRdjGvqKQxaNTmvvNL3drHwd2N8En38BmezvAz/yVsB0XxwMiueihKEnFcUS68u9Oyxw8w/3I06p9aPG0oH0iQGspo+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opUSMvWw85wfMcx+UmVj1IEPirxKfaNUf9AXBAMnC8c=;
 b=nQskCLq3i3ces/OA16CmrRs0rPrvjGFwBNnBQpjt7WzdPPJSR07PioaWymj2QtuNuB2nQayNImF7zsP/c+EKOXzSNtuN1ZJH99c75tII+on4M4Wg7uj6KsIj3vZoDry1KFZBofemSxILwcR4wWVQZppTAMSLn0l0iOhyxbDD+EU=
Received: from DS7PR03CA0314.namprd03.prod.outlook.com (2603:10b6:8:2b::26) by
 IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Tue, 8 Jul 2025 07:51:34 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::da) by DS7PR03CA0314.outlook.office365.com
 (2603:10b6:8:2b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 07:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 07:51:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 02:51:33 -0500
Received: from hjbog-srdc-41.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Jul 2025 02:51:28 -0500
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
Subject: [PATCH v3 2/5] drm/amdgpu: move GTT to shmem after eviction for hibernation
Date: Tue, 8 Jul 2025 15:42:45 +0800
Message-ID: <20250708074248.1674924-3-guoqing.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fbb8f95-42d7-4c84-f71c-08ddbdf44291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j/oq/0s0aAO8VXaOjK0HruWCdmPhBGLbPdSFa4MudWWu0AIVzCb5W5FCTvxQ?=
 =?us-ascii?Q?5SwGwFUmro5hafMYEr3evcbsEAqI87wnPUxbvJryOgFbLv5SEomWLFntAOzt?=
 =?us-ascii?Q?/skWy/Zyqx3Vv1RIDmxVosaDmttaywRi5QYUWWF7eXcvKhVPY1Z1i0usAC0w?=
 =?us-ascii?Q?6gXIfDTGG2KfyypBVZMwYsmfDScg6swK7rHXrfE7aOOWDtKCvkFnU2Z/whKT?=
 =?us-ascii?Q?6fMwr1UzwOpYP93vK0LUMSeDDQFu6Vfid2Qj2PO/T+59nSHJBRi8XPms2DaS?=
 =?us-ascii?Q?wMN2VbhmihSBRIyQ8616iSQEZekmOBvYN1IFiuyUdjZVfFVUVPOS1fkhKTpt?=
 =?us-ascii?Q?TfQF034+zp68abADshlWqFrpZolzhwcVJZwEhKaKv7HUZZ3zQ3vQGpmXTN3I?=
 =?us-ascii?Q?Q7ZxFSGIGu18RYRXQlzWlLVisCjiyKPbhicT6E2fuJPj7PpvkLUUdC4eRV1N?=
 =?us-ascii?Q?nxKOgi9b8UXwMUXbJn/c+flMIaZvHyb9F5/zb4by6pUOyoqAVyCsuhCaiwDG?=
 =?us-ascii?Q?+qUJBfnincEk95vJd+D3CB6lTGm9T7rGwmdJNsztPv0GVIyH6NRdvHoJaryT?=
 =?us-ascii?Q?GgpFjpD9sYb6L4zUrO1bo0cRY1gwpXsKqOPIw88zOBS5F9rGh5OVCSqJkrVd?=
 =?us-ascii?Q?1me62fLWv0xcDMu/8TNIOLW6z5gat3BJr3/fZH9Bq6aeAdqMGLX31zit71Mh?=
 =?us-ascii?Q?qnZ9La0pnCODyPYdIOjrAqG+zf4WW3vg5gzMPvMKINXE3avydyywSsL6unBp?=
 =?us-ascii?Q?97k8NHESC8vQBTVlVNKfSHmFcvgvtgoZGowNAHT3BBBuME3ZDXWkTXPnFrNB?=
 =?us-ascii?Q?3MTnWW+rrySC3WrUE4Va+zGFE+V3Q/ltecvMrSP6SrNLWX2QagcizI07tYsm?=
 =?us-ascii?Q?pGg7ekepsr+4sI0g+XW9wnRCLSx3IajEIV7b6+qPntCrnDEhewiCzZo+/kA0?=
 =?us-ascii?Q?Xygozd38t86oECNV2Kn/hp81sVdfYrZZ5wt7QR4CJlUqEh0idLzxLp5O/q4J?=
 =?us-ascii?Q?Xgg5StPOnP35FyPLt2MSUGPLCXFCiHZepOvkVUZXj0Gwar9x5qNXv8ceEwui?=
 =?us-ascii?Q?ragBRtMNl2xV6qGXovFBOiz6fJfmIecWpNsuFhXTIxr7KxILRYoGALPeTj76?=
 =?us-ascii?Q?aVrxh4dj528WtHx+7Epg45tmZLDQEiXpVqIup5nSd1muTNrAYpSQ/2FX6EdO?=
 =?us-ascii?Q?gG6ZXf71AMkMzNTdCWfkRvMcOkgyEqkN1tXO9OFC6QxKsbxmiD5FPtoYiFAl?=
 =?us-ascii?Q?97cWBaRX/21xJyAtQ+DOfV4bJtgR+eBKPYvrdtRUo0gQn+lkdkFn6rXWXOYa?=
 =?us-ascii?Q?R5MOgn8lk9V8Pbyc7dLVFWnauIO4gaASQHRXkHDrwcfZS99YN55Xf0nXIJJl?=
 =?us-ascii?Q?pfNjpAkfGbhCMxndMDXtKRuHqgvagspu8PkG3759rzttygLaV71nQBzcnNVg?=
 =?us-ascii?Q?UGmcjrRIgv+ECHyQ8pJTqEz91n4qlxXNbaZ1PgDe5T4Za8iUfCUM+/4cawEu?=
 =?us-ascii?Q?ZhsEon0UY6TgqBN4n746x8AXWfZxFNu0CQIqGAYvm2b/gAJYVxinyfc1OQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:51:34.2216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbb8f95-42d7-4c84-f71c-08ddbdf44291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695

When hibernate with data center dGPUs, huge number of VRAM BOs evicted
to GTT and takes too much system memory. This will cause hibernation
fail due to insufficient memory for creating the hibernation image.

Move GTT BOs to shmem in KMD, then shmem to swap disk in kernel
hibernation code to make room for hibernation image.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 684d66bc0b5f..2f977fece08f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5021,8 +5021,16 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 		return 0;
 
 	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
-	if (ret)
+	if (ret) {
 		dev_warn(adev->dev, "evicting device resources failed\n");
+		return ret;
+	}
+
+	if (adev->in_s4) {
+		ret = ttm_device_prepare_hibernation(&adev->mman.bdev);
+		if (ret)
+			dev_err(adev->dev, "prepare hibernation failed, %d\n", ret);
+	}
 	return ret;
 }
 
-- 
2.43.5


