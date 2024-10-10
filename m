Return-Path: <linux-pm+bounces-15489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280C9992C7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82707B260FC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1071E5733;
	Thu, 10 Oct 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VaWvtjD2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E41990C1;
	Thu, 10 Oct 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589074; cv=fail; b=MF9Uz88QBSACCG7jpuHtVspWaN5epit7JHDs/qmtUm4NIBQI/6YQ5XG48qfe49tdQ0jY6j0t6KqAr30mWBAtlNW/XcAkKQpzaScnz89mrNX4L9ImnnHRk/tm/GSTysCvD0AU8jeAViNIkSVlYtJ3DPMjSt0aUju/KzGb/SbyWDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589074; c=relaxed/simple;
	bh=HfdXoUrJCOh1tpdl2DPe0DDRfl2MMYJhInpzYP9fvKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggynwJ9woewM6MvFkTKvxAsdvAFQ9rAgyYOSUkycvnT9RyU2O/GDCrcT0kVBORHJBxHoIxLfmB3Z4ARiEs4IcOzio8+icjUllC5svsGD0nCBYd4EvHrAkDVfLhMquZ1l3ddIuU+CIkthZ04i6IrqmBVITJn95INuirIrRUf3keE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VaWvtjD2; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHwE/D1jdD98AOh9J0gXgFbo+8uGv+WBnYv84QIbpukL3qVmE28hXlriiUTB5HLjtBIdrpM8UKzEykNYAFavyDSQNn3Ug+JsGrxsQ6CiduyOdsiybl7faWoYABLyoogsD8vz+pfI8OuspFdV5QTVgcV+oOJtbuX49RlmqQE6TO4G5b/c3/LX8aLT8RGgSdI3JBhYpPXYs/IqBRX8NweUW/Cg8ImsK/M/MPQiQusHO4TIlkkpPj3jjnv9ZjbhpX7CGOgoXpP4T+SDrfLGu1mbslWZXm6EPuSSfuOkSUVuGdIcXCfGOJvQhM5bed2+sK9ZnJDtpliS7W6vLqSbqTodUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx9SO3c96XRDlbNKtd8bYfvq1jcUGBe+tEkpG9n1WBs=;
 b=NnnsfSPl0d8jsKRIyVIYXLizy+mgASQaYZKkjG3jZwdHbHC6Zt7VVvYa/Smsm4Xh8OCWSlx4ctto5nibjYDhpyksqHClwy076F830Yf2i4IBnKVhQ88qxvcR+H8s7C0tPXbKpLZo7avut2amXGztDY7NIqqMr3RrQNE/JB1nHwF7ZpZ54TA4sVjePJV+3KSpaQ5VKqRRD7Y+Ab5F0b/ElkHMZlGAkq+/Cp/6YPP5W51ZyojSQ1StcP4cvGMqUdcWvpXEanrj7EhKZ2GBVZPi1fsKGaXgNIbHIQGJoo6/G2BW2hlqQLYxSrzQMaa7MDzHkgLEcjnq54k1G+LNpXh8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx9SO3c96XRDlbNKtd8bYfvq1jcUGBe+tEkpG9n1WBs=;
 b=VaWvtjD2eV/u+FRxCjhwvWAK31z+cM66iqjze1MZp1X+we8pHgMJFcKA81fDhsze7ZtJyliGz/oPo26ube6P3dzzXFFlahbDCLpa4fD3hQ9la7Uns8hU0pdTIy93e8V2umwoB6P0mjgqZN4GSyNlzcJek8X7c3yTmW+YSI0+KL0=
Received: from SN6PR01CA0024.prod.exchangelabs.com (2603:10b6:805:b6::37) by
 LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:37:49 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::49) by SN6PR01CA0024.outlook.office365.com
 (2603:10b6:805:b6::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:47 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 09/13] platform/x86: hfi: add power management callback
Date: Thu, 10 Oct 2024 14:37:01 -0500
Message-ID: <20241010193705.10362-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 621fdf6e-811c-48f5-d6bd-08dce963062a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0REJE2tNXjy3F6ECR0kXrICT+kjJ3XFQT3mpdRrVCFpOaAGUreM3gWkxNJ+z?=
 =?us-ascii?Q?b9CGSmSKs9nt7jjrQXN+bmGlMZMMlumHLb+LNXqDdv8olGoygGamozjb7MtX?=
 =?us-ascii?Q?slhmd1DNdPNsLQlDSGlL2VyVDdN/d+nL2SYU5riIFzTx2j4h+pPf8wB1dprr?=
 =?us-ascii?Q?eycykdfiuiHB/qObdu2J2YAVHRYVjccKyLImRMxmztVKeL3LHWVxsp8aGfLN?=
 =?us-ascii?Q?1hjGJbRADfH+VL0Yfq14Yvk9APYln3ewzMMW7oGxD2rEOEXFiCytqErDclNO?=
 =?us-ascii?Q?Y3Tr6GMeNnFUind89LynBQtq+/5CyGXlPEhQd5P7eW73DC6xOh8HIa83BbDY?=
 =?us-ascii?Q?Lt4nmPCGad97P1i/EsAMJrat4Y5ICN0PXz+Io0+9/y6JGyEch5wubrYxeFTQ?=
 =?us-ascii?Q?Jy7rVwtY3QKxeKnsF32dR9uXni/f88gv6ZNuQsm4bwTk1u7g1OcFkfsx3+gD?=
 =?us-ascii?Q?2dOzKyA+h2lzuXDWZNu8W4unDxQ/iVUL7R8JcLr4srR3QKTsdxHoTmQIAwyd?=
 =?us-ascii?Q?W2ol4gaXNmG1bcyQXISnUcXTH1QDqmZGnNNnElguCpKplyW7btRm7I3Bm9TU?=
 =?us-ascii?Q?zkO1MR/MjFx1DQm5Pt1us1R0RgSHrQNwtWoqqdO81IWBGBlgl1hlR3ncnj6I?=
 =?us-ascii?Q?lHNvJVk6YBdUm63sdr1nShKTClneFWFwvVUnd9fc1VvQ7jF5Ic3oeReCf4Yr?=
 =?us-ascii?Q?mA9pKab3sd7xsyhDj4M+AaS8dKrPtQu57LSYh3fignntb/myC58UEAwoskss?=
 =?us-ascii?Q?Iu5bIx9w3zdcONfpVdfps4Lnsv/mMgl3G7UUHKMu7/s5fsgAAUtrxG9f/JOP?=
 =?us-ascii?Q?myPRWS6yFMspSF/cFqQ9Pr/tsSnysMUFO0QWKzE+Fwd77IvHPWeMh0QDRfOk?=
 =?us-ascii?Q?thVwHy0rq/+1QlyqO+2xyCfPFeyLGDtrhg2IR01Sr1xWKl8L3lETaXk737bI?=
 =?us-ascii?Q?QPE+t8FnViMnU8FzjHpAbNkwtuk5+xdE4AT/W3ICKCd4BLX0h4UhSIwZPBao?=
 =?us-ascii?Q?SXZHULs/hkzqHvdkOGrdER0F28EwwsA07uXxuxKZw8NbyfMCLsUvD4zHGw73?=
 =?us-ascii?Q?g98NbRiYhqs2hnDXdv8cNZsGk3ofMgBP9SrsKh0dp/F7EXFk/yFsLyw+9U+C?=
 =?us-ascii?Q?FSoB/ry9RrSbpYTbGwxqt2WtDJBUHinE0KB+Q3L22ps3S3xgeu8Il9OSzKy6?=
 =?us-ascii?Q?uMKLrp4U8jOw6e2+FRO1XeX7d0sZ7yNpBYsGwdRk9ZW3rUQkSV5OtZjvUysx?=
 =?us-ascii?Q?etTE53bAV6KchtnpS3h+YasVrTjVTi8q3LHGUh5Oq1jxrWDa3blSjPBvuqw7?=
 =?us-ascii?Q?JjOv3D3Zsou/pCq/lRw/+4MNelD12yFOCwwnr1R1cmA2wgx+G8Nv8ARCCKq/?=
 =?us-ascii?Q?CWjF+UQZcjNsJc6/kFzcRq1FiXIJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:49.3335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 621fdf6e-811c-48f5-d6bd-08dce963062a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141

From: Perry Yuan <Perry.Yuan@amd.com>

Introduces power management callbacks for the `amd_hfi` driver.
Specifically, the `suspend` and `resume` callbacks have been added
to handle the necessary operations during system low power states
and wake-up.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Whitespace changes
 * Use on online CPUs not present ones
---
 drivers/platform/x86/amd/hfi/hfi.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index c969ee7ea5ee..0263993b0a94 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -407,6 +407,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	return ret;
 }
 
+static int amd_hfi_pm_resume(struct device *dev)
+{
+	int ret, cpu;
+
+	for_each_present_cpu(cpu) {
+		ret = amd_hfi_set_state(cpu, true);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable workload class config: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int amd_hfi_pm_suspend(struct device *dev)
+{
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
+		ret = amd_hfi_set_state(cpu, false);
+		if (ret < 0) {
+			dev_err(dev, "failed to disable workload class config: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_hfi_pm_ops, amd_hfi_pm_suspend, amd_hfi_pm_resume);
+
 static const struct acpi_device_id amd_hfi_platform_match[] = {
 	{ "AMDI0104", 0},
 	{ }
@@ -458,6 +490,7 @@ static struct platform_driver amd_hfi_driver = {
 	.driver = {
 		.name = AMD_HFI_DRIVER,
 		.owner = THIS_MODULE,
+		.pm	= &amd_hfi_pm_ops,
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
-- 
2.43.0


