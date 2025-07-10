Return-Path: <linux-pm+bounces-30537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22341AFF9C3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 08:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1517B546890
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 06:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0992F28B507;
	Thu, 10 Jul 2025 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vuX1svhw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C228982D;
	Thu, 10 Jul 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128640; cv=fail; b=mRkMHf1t8QxQP8hYzo/qvG2JOrlVLRSExuIHu/O3WUVMEbZRmIBr0JWnr6YCui/1QFRtL01CH8fH3O5BVLrr+yUfCIn2TCpePa6IqMSt/4cjBppuJwwTVYfxLTUF4E7glYvQAA9fMgV8ib6FZ/U5vh1hrXOhT2X1mnkwoaivQj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128640; c=relaxed/simple;
	bh=FnvTtNQk++SEkQrgDk1QB2UqOHajAPWX99rFSpbqlwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFs/+t/kHpDtZti65S1eqrgZEgyzP2wVY6MbdD5HXPszy3VhvXfLooO67YV9WrWMp2uaevijVvk34m8iDXhJewnE61ziJ2pH+fH8R9EBwokC3aKV3Uxg8qrNA13gtF2K6goFcGjgTm9i7T7CRnO8CASHris2Ob+ACIPKOUy/MyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vuX1svhw; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3XDvH5/JkODqqYxYFC4/rObRR08X89DPw7BVoy/ar+qJ8D3FPlgs/Iw2UIsUB33X/ppm4jZOXHV7d+DvkGeng4Np0o9KKSWd1VF8Hpoc3o9Tc33BqxitK/yVYg6PAolp+AOVh+FoheGCdTxDRDNYZVBs8jovRtRbbquSV8v4GdPAdvm7gNervNpeudCzs6+BwsqjpK4ORZQq2fNVRrsv1G0uFJ9nNUoNWlgHfHKM6CXhtIW2O/I718++PBgDUI7YV4yo+PfSuLobJdhO951LkXP6Y3QDFS6pbHNa4HEMd/YfTl9h14e6FfZUXAeKUvbWEOBhdj11s0iZwCF700J3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfSTMpMDhiIuTq3yjZ4aIK59TlX2Yq1gv0AJHdRSBWU=;
 b=bSNASPRd1gU2ztjxm1iMAgxRplIBCIBj2ZPObwZAIxPn4t1AuDUNy/a+8RFLxYXt31pmxrUjXCKodnlOJr5rKChJeXloY9nq1eMRuv6oEllTK+sTolrnKWBswjAD+qnVbi9WjJ8WP6F5USx7HD7VPDJPKYsdopiYLZpoFCEVoV0GYjL9FebDsRQC5Oi6ZfD+b8B5OPtifpulSLwGhEfdIkgwuOpmVqO8C/YImm0CXvvM/s8QrBvDyxh74NJrgDpPKaa0tZ+b6mTNr1Vmo/49FMPmeXclSH5p4BlJxQN+vi8bjFihncwQBU6DcKkZrz5zESXymoZPEB1ZqsrMgfnxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfSTMpMDhiIuTq3yjZ4aIK59TlX2Yq1gv0AJHdRSBWU=;
 b=vuX1svhwf379I5y5q7GjwoT1jszQ7OeU3A/FuLYhO7wEc6yPfjPz/gYXuCKdrQd6jHtRq81WVLXxFk1rmynK9TyKEGZF686vSKkdRMdmMmU4IEKtKUM8zxHlGrCm8nhG8/ZYAGaH8Wed5kYK1C1PCgPCdqo/tYP4a+/grZBKxzU=
Received: from BLAPR03CA0137.namprd03.prod.outlook.com (2603:10b6:208:32e::22)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 06:23:56 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::31) by BLAPR03CA0137.outlook.office365.com
 (2603:10b6:208:32e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:23:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 01:23:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 01:23:56 -0500
Received: from hjbog-srdc-41.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 01:23:50 -0500
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
Subject: [PATCH v6 5/5] drm/amdgpu: do not resume device in thaw for normal hibernation
Date: Thu, 10 Jul 2025 14:23:13 +0800
Message-ID: <20250710062313.3226149-6-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250710062313.3226149-1-guoqing.zhang@amd.com>
References: <20250710062313.3226149-1-guoqing.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a7073a-44d9-48fb-216a-08ddbf7a59c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3lWqLs6Nwq3H6xi741Q6El3FFzzUF98Kc4Ml/qTpPmXZZjvMrBk1NDkLYxh0?=
 =?us-ascii?Q?VeqFZ/CSF5WAGsCah3hsiZ2rDqwvT1iPgoxkOPjHdkfSJ45neaad1Qvqryki?=
 =?us-ascii?Q?XLLQnqz7xzRL3ZYYDWuOFqbk15bPlorkUK0uMinvAA+rGigeb8c9wQm/3hvW?=
 =?us-ascii?Q?z1D6Ox4lgw5Onhv+XpXwr9MhVaWONy0KqIsEBtIGpUoLnEnxolNVgWKYP2P5?=
 =?us-ascii?Q?+Z8tqrrRzMWgNqz0Jo6h1vtUU8H24xE/UxWddRqLzXXkkA75QqdYxCZngA17?=
 =?us-ascii?Q?/tDILcowTKhOK3z7WSmTad7FpHB/AgbG1AmODM66UYyKNBjK6Y+ih283pDC0?=
 =?us-ascii?Q?Lg/CmN4sgVys4vClsNIOcWsV24Dr+fHXgg1xuBCLXi5RGu2roI3FRcc/u2tr?=
 =?us-ascii?Q?xthjZl1B2Xrp0n/PAd2jrk3mnT0euOdxSu/0iGDSrS2kIRpfMcVAI6FTdZat?=
 =?us-ascii?Q?gnH87443YNHFy9IoQKIwgYe488hkqi501ZK8VEWUixDG0QB04wJhTe8N37Cm?=
 =?us-ascii?Q?1D+iHgAToOMh+a+f2vuct3jSDtPNns1+UXP1KUStC6vT7WaajHuPv6THHTr/?=
 =?us-ascii?Q?TTMucNdyH6K2K1TxXtigCCNDiIJaDc/Oifm2oMlMzhB808KdUAUcfL+e+4PO?=
 =?us-ascii?Q?alm0H7TqqdVUIXnKcZ3Y0MYQJHXE131JzwdGFwrzY6ikOU3F46NtE9B2PybY?=
 =?us-ascii?Q?B5wWncZX8JWPOFFuSMwO4sa+gODNAkwNq67SW1UgG+XdM6CchHYL0GbHdgaT?=
 =?us-ascii?Q?RGcAjWaVNBDXzBVFabuB5J0VtSHHBcSL1yXp18AzdCRk4u87rFrminxmPiB0?=
 =?us-ascii?Q?9FTonzTUVY75O4MFxqZRL1FIuFdmcgEVsPx6vOt+jzgxuKl3i6di3PAL8JjF?=
 =?us-ascii?Q?D/SwEFQC5VNyRPFq7Fb9JcxQ9SIBaFIZKFwXDD9iXem9LYaTQIxPmlRZRDPs?=
 =?us-ascii?Q?+f1FfBAmeiJl97gIR0wx4Q9kJKFn04hij6Oe8gd6eOEuLQU61OtOuxMJmp7S?=
 =?us-ascii?Q?Jdske4fpasJkq+3eo7omjNZjhKr6qSaRn1+kd9X1zQklJ6Z9ewoDssq+Cp1L?=
 =?us-ascii?Q?Hbqbq5O086OqRAkTIQ3xvzBO/OMvJSdNW+aBhDAr/9XsZM1xvKV4SjASW7zS?=
 =?us-ascii?Q?JMf/CoUWimDxABtAtjFy1FpkEkJ3YKHKFlayF808X1FvUEbPS7JicDp6pSdo?=
 =?us-ascii?Q?fIIHslhUD58YNeVaFkCsDvHG9MYIqABUVAwmv7bseYEQBxIZ0E3gkHnYWJH9?=
 =?us-ascii?Q?E96j30BAEDAJYQyAzA1pB0ueYrVLOarhM0nTpsUEJ8Ywxm+z2UGRbxb2t89/?=
 =?us-ascii?Q?tVLugDoxSike4ty4y5DuuVgOt/hi8Chy6BSYJnt0ivNkuXYa2Xt8cw0imk6t?=
 =?us-ascii?Q?loUxQ0ifrNGdPUtMw7Zie8fiEjKAcqf520+1Oncs60AzNU6c0OX/B1N37y9X?=
 =?us-ascii?Q?+sm+zkAKdFDciOcfe951R/+CSSYHrsXnWnH8oc762IWff+vahFsdnomFO+k/?=
 =?us-ascii?Q?5PFjDDbEI8aukWm/XCVPzOd6WyKDOK4ql18oQ9lxUJE+SdHQjPayQ+nKcQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:23:56.8916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a7073a-44d9-48fb-216a-08ddbf7a59c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077

For normal hibernation, GPU do not need to be resumed in thaw since it is
not involved in writing the hibernation image. Skip resume in this case
can reduce the hibernation time.

On VM with 8 * 192GB VRAM dGPUs, 98% VRAM usage and 1.7TB system memory,
this can save 50 minutes.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1c54b2e5a225..021defca9b61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2541,6 +2541,10 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	if (amdgpu_ras_intr_triggered())
 		return;
 
+	/* device maybe not resumed here, return immediately in this case */
+	if (adev->in_s4 && adev->in_suspend)
+		return;
+
 	/* if we are running in a VM, make sure the device
 	 * torn down properly on reboot/shutdown.
 	 * unfortunately we can't detect certain
@@ -2557,6 +2561,10 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	/* device maybe not resumed here, return immediately in this case */
+	if (adev->in_s4 && adev->in_suspend)
+		return 0;
+
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
@@ -2655,12 +2663,21 @@ static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
+	/* do not resume device if it's normal hibernation */
+	if (!pm_hibernate_is_recovering())
+		return 0;
+
 	return amdgpu_device_resume(drm_dev, true);
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	/* device maybe not resumed here, return immediately in this case */
+	if (adev->in_s4 && adev->in_suspend)
+		return 0;
 
 	return amdgpu_device_suspend(drm_dev, true);
 }
-- 
2.43.5


