Return-Path: <linux-pm+bounces-16989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44F9BBC9C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C22B22952
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82D1D1310;
	Mon,  4 Nov 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qwEmFDCL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0B1D0942;
	Mon,  4 Nov 2024 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742894; cv=fail; b=TnnnOGmVHm31WZyoLRosfz9jiD6VRfDDrLGC4IGsp9Q1ybxkybQ6dZ5dkNU8W64+8DD9vAPvNxEeRRn4KIVVxaIudW7Bpf+szmLTC3V5+I5UX8Cw05ivOtNZQeIJO6FWjGOdXm9Psk57NhHojgotRsZk6gfzMckt8yBSxSkF3l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742894; c=relaxed/simple;
	bh=bDvR2K+f+PYR+6MKtv6xsvrS0eo/npy4A7OJFqB4JgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx2drOAKyLAfu7dimd1qd7CtVUW/+rtaRYgVQbhFRpkzGKmKhZVW4fh9uRuOjDOxJW70SaV+YTJ1DQHjAKO0fbg2ak1x1y0L94cM2kPsp+8SN6KMa2FKDXgJroOR9oXZTq47aFiB8R/FhC8ZLPDcsfRn43eO0tJQcoJnVENSdIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qwEmFDCL; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl1CV5CHF0QH3r1Rktqbb2z43I1zLDEQSnKgr5NoJ1xoNDPgLFbivBjPFqBNyKX90FYRxWsLHzqCM/uBjHj1gxhBPLrfF01a0+07G3zxT+3a6JhWsgFzz7+jtgsPV1+Q9Qg/hJKo1kX0p8v6/qR0LMxWIH9Ax2DNa9zuFi42AnjNZeu+TgqwzixY8sHXXxgrTDhwxHll3BStxjiXE1cvL++tWXsx6/Wg2wCdnNDaRL2PiL4v/4rvp2yJoc6Aoa44+/zrdnipSbklJ+bHBTyZO+AKVilNfZaRVwwBRtfgKO4NB81vSQ70lUKCnn2xYSjGyz1jZZ1ZYSxg5oH2IPU0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWs5FEGQqUd8GyhxRRXB4i4dUwFwI3nWbIVa2kBnoxo=;
 b=BLZIBFg8r6P5gpa9mPIRCsLIq2UZ8M1mtpML2P4fm2PagxG5WDmB9KgMEMHA23dEpiiRFf0rosaxq8GM1tRigLQAbpAdDKeG7YaMxlgWDc/sQCGxLOdJaDM7Ii67+oMT62cKpwhNFKKJxzSE+K7fhE5rPt8pZTz6Ik4nz52h3S1TqHh91leNHrVoBgm/y2NBUwIJK+AeFx0dbyJL34zKq1iwdeUa8CtDtp1pEcnzzVffIjMw5DRV0uzX+TzIlEBMoqEPaePorLVM9sQDE1sVTXB2+md8NZGpvndGS/jljzHx9c3DaHK3d6A0xybxlVS0FaJ3CKkzMMS/Q9jaT8DU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWs5FEGQqUd8GyhxRRXB4i4dUwFwI3nWbIVa2kBnoxo=;
 b=qwEmFDCLXJ3EzRDeHSwCfOpOhUa2YXBnAmEvwARo7LTAVa0k0d9+zZGy9o7K/nlReMAYeQiS9Y6nbjSAaM1ypSHFMJgmDtrsdggMPDCf4UmRRwf/IPr2r/uBGq+6I4xHDwnveNkRkCmtXUh2Pq6nKmgaQ5wKC4dLoTcoJBTjCas=
Received: from BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:48 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::fc) by BY3PR03CA0006.outlook.office365.com
 (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:43 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v6 08/12] platform/x86: hfi: add power management callback
Date: Mon, 4 Nov 2024 11:54:03 -0600
Message-ID: <20241104175407.19546-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175407.19546-1-mario.limonciello@amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 846245ec-8538-4465-0b5c-08dcfcf9c52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hrQ2xPu7bdsRepSG8pQ09fqTjCHz1eWEiAHIY2Tzf3CcvTquaxbXijGRio+v?=
 =?us-ascii?Q?bc9GDTRw0Xv7QxehgZ48akLbIqpcFAIAhwQzfMX9lChsKbbF78PBMTqr3RQ/?=
 =?us-ascii?Q?xX7K1dVJ7/xoFMhTikb+vSdkNAJaz1sQBajjDo3SkFcyHH4UQDMSoUJtw+ih?=
 =?us-ascii?Q?rLzqPYfPQ1Q+moNfJcyRjCYSXevkqWpde77MNLzXYSYFn1tssSHmDDA8uegX?=
 =?us-ascii?Q?RVG373F/95mjehAFSFr4VHLJTVPGccznfivUwVGRsNSXoc5rwJQdujH4u48Y?=
 =?us-ascii?Q?4X3tmENbI2G1Mzf2XlTdnqiEhaPEdJ1CORUZxQ5zMaaoECb2rf0msNrJQGCd?=
 =?us-ascii?Q?U9d8UTl/UO+XYKHFlarIgT4p+8SfnFLu8DflXX2DxYwqcuvzyKy8wAJk7Ktv?=
 =?us-ascii?Q?wqd7d18BAdTLI29/3J0KklgQ37Ps3EgfdTMuG+78SG34B2OJG1UTdAoTQ5Ag?=
 =?us-ascii?Q?/kNurGBM0a1qaPpZ3agTG51pT+jU4kbJpoBIhiONT7p4SPvBtIU9opXyd1Yc?=
 =?us-ascii?Q?TQjEKZk8JPjUpl2ucg2V78dJtKXubnox+d/vXZaqSGumCLk6KcEaGZlKTMc6?=
 =?us-ascii?Q?cocL2kDKnQmjtKm2ZCKKC1VMdV4iNHwfIXieY3axPUvB/XV+0gDeCvJyjRvg?=
 =?us-ascii?Q?6PoF1Ew1G5r1AnU03jaHlKeqrX0sJcwuCRCxNkVDNqPBHa57mlbCc4rjC8g/?=
 =?us-ascii?Q?xo2iJq+gxX9IcXQuvYgbaSNGPJIK0kg3qDgkzAs6isApF/WkSeUHMRIZX1WB?=
 =?us-ascii?Q?Kq82sXyr6HYOVug4s0N0uHL1FxesiC6EGJvZ//kiKSelbzrReaT8KzcxT9nO?=
 =?us-ascii?Q?Uz9KOb6w3FobYxE5JPBIvquZ3BO8K1s+T6NS2slRAS8GZ50Rt/7ce5MH/rwt?=
 =?us-ascii?Q?y9beL81LuRJG6riPvAC41vrc49SRzO5HGJVzh94FQyJky2oM16zAphtAUjHs?=
 =?us-ascii?Q?LABhlhKi52TmmlI8qJMiFPUl6jhGIKFIrRIQteinKBilyjD60zT+o9xxnT9E?=
 =?us-ascii?Q?wiAQ4PTg1KzVykOHLtXprZ64n8wogjXiLwIRH9LErqhSQwKxukr13kbRD2Re?=
 =?us-ascii?Q?PzDNB4305c+5Z8F4aVgg6o/JIuc+FAksedk2HylNn94QoBOv2+lUhUUcltdg?=
 =?us-ascii?Q?KS8Pi6A3N3nt2wF34Rj2IBsT64T1ujhjBkwb4ZYal+h+QJ156c6Xef6lWtST?=
 =?us-ascii?Q?8c4jToF5kPIInJOF5FYUkcSLgpOOjEyNRJ+p8I4dkr5fF9Oyfd+M0dBjhnkK?=
 =?us-ascii?Q?2Z6UQotOywWeF785Q4ReBTOfDM9ND8vgiiope6OEtzTZPdcl63d15JeoDaat?=
 =?us-ascii?Q?luWsuaFiKOcDd3pI9sS5uAwa5WsODJ2+5TE7y5SNdMQEJ4hNjZAs3nzXBtbQ?=
 =?us-ascii?Q?o8Q7HLEW4U/ZtE86CarWNP3Za8ZHOFN7h7EP2vk8xy/4fD2d+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:46.3819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846245ec-8538-4465-0b5c-08dcfcf9c52b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

From: Perry Yuan <Perry.Yuan@amd.com>

Introduces power management callbacks for the `amd_hfi` driver.
Specifically, the `suspend` and `resume` callbacks have been added
to handle the necessary operations during system low power states
and wake-up.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index cb85a538f8168..cef6aa84bd85e 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -380,6 +380,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	return ret;
 }
 
+static int amd_hfi_pm_resume(struct device *dev)
+{
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
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
 	{"AMDI0104", 0},
 	{ }
@@ -428,6 +460,7 @@ static struct platform_driver amd_hfi_driver = {
 	.driver = {
 		.name = AMD_HFI_DRIVER,
 		.owner = THIS_MODULE,
+		.pm = &amd_hfi_pm_ops,
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
-- 
2.43.0


