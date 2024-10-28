Return-Path: <linux-pm+bounces-16544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DAD9B2281
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDBB8B21B5D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F6192D9A;
	Mon, 28 Oct 2024 02:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RWSgHfqT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423518B47D;
	Mon, 28 Oct 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081010; cv=fail; b=rKmUDywladLICPEkzb0eJ37/FEZ6YwIsJCE4VxwMFLwKJ6EtDkqK2qxIrVbERiIzOFlYevNiDvfHiBTxLNx99LWQanmN+1IOJd7Q6ohRxe7WDkvHx4jLzkdH4M7Ay2rnSxDwmO76bI0w6iosAVT+RUs0mwBOrYijZDIfYsDMqKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081010; c=relaxed/simple;
	bh=LNPjM+dPgjMNL75vlopqQfkr8adV7T737JOpjxZs+8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHe9w0CP59uuScnD2Ib3HtVFlve7UA1axQttSYHC/7XQLdJWUP7oYOv/TKUDNkEB7ISVJ8+HcApf7CPJE9jHXqg/EPr1JbaEmZEhpEKzWHIxmh8FQoSXACI7nWymnH8ZLRBBCIFLknMMPhaMeRqG9N6fiBKceSKFpNLIkp47Li0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RWSgHfqT; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoN+ZqzDlDTjNQIlpbppj77F9b5Z7pA35JV/Pj90DQ+u2R6sw2Xw4r16rwQJQBTYTJCKIZE8NWUn1m0TLLTHh06Amy6kdui2v83B26QBIsJU8tWgggF1fG4cx2goU35okA7WeOopR2EkTcl3TDRRzmm6BVpDxf7/5jiiiYFJTq3XSJurhCBA4eH1eCfNYIKlzzxYYTyxhzS55Scst/MDy5+cSbKGTPYT872dxpaeGbhBDWg8NTb8gmI7YOnnMrGdGXZl1YMR9VTZ03qN4TlpRCKw4vxZneGTlB31jYjCzEuB60aaaPVnQ7yJh2mACl9Nw9IH/eg0QlFHTHFDZ7W5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haXGWBrAZ0fxfa3qxHK1ETSJPyswEvws5g3hvbtCKk4=;
 b=vXfixM5EuG2pQNNUyFGgMjEjo3eLkw+g1x2E9uFoIlBnV8m4KtYIOIE2n5nqHypFl1hzvvYFCdTX+L7wMNFNkEPLcX5zpYhgPhbt0mOvZ/P0ubBcA1c41iG/piEk1YCimofNeNx4yvefQZHOeVJg7LG2hZqStTZzNPCUxWXjcuzOWcSSNgjGlp+mdmJsb7cfmJMaJZ2Vh/Vfaz7GAtZS5isn72r7UOzfWS5Br8C9XPKpXby4ULzOkBPSolcggtxlBD7HdfEJFev7BrbK2gF6O4DCGHendwFPLJ/jwyYaOYZSV9go7gBhnXWcFxrfGEcPcyJCGHRKJHQ+ph9Oh/5Kvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haXGWBrAZ0fxfa3qxHK1ETSJPyswEvws5g3hvbtCKk4=;
 b=RWSgHfqTzzMQYGox9fi77J5WJG3bhPQ7Hm5ZWJgNX41srkeklr1JAwa8WvrszC/1Qe/OUEefVD2uPjKY+ENZSE729tcVZuXqOwQ8/JDS4v2UBhtcPe2uJtNBYHqpsLhHO2oijDiRs94KHdEkILIWU8m1rDaFx53dvRzSFvdD1LY=
Received: from BN8PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:60::24)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:03:22 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:60:cafe::8e) by BN8PR12CA0011.outlook.office365.com
 (2603:10b6:408:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:20 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 09/13] platform/x86: hfi: add power management callback
Date: Sun, 27 Oct 2024 21:02:47 -0500
Message-ID: <20241028020251.8085-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020251.8085-1-mario.limonciello@amd.com>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b86400-e6ad-41c9-f066-08dcf6f4b338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lTpeNeRyEUrvq+M1fTKtqZmOtWMLCQca2ETMmseEIL/oGQxXYGKQ6n6Sy88u?=
 =?us-ascii?Q?PXImfeK/6jJC0CBCKmQDkr5EV7ie/p1NDblN+OzwU8CtAT/0BxZ5nf33H2Dg?=
 =?us-ascii?Q?IrHNDYaVxwVAYgvegu41S8edbJHtnkmJRZr42MhKhRpIFOeKFulfpKJ60KTQ?=
 =?us-ascii?Q?J9pkMc8BA3N8+iVNX3yAChPc2B6Mm4/KQQvN6BShZK5FKF1TxMB2rTKqe/4t?=
 =?us-ascii?Q?sLEuhLA6iQ0oq5a7w4eUMh85gZfcfmapyEOQogn+AWYl+JMm1aJ0eJC9p4R+?=
 =?us-ascii?Q?n13fCnynkeGazRMwVEyviR2Esm4ZkFVXgPdzvAsWs2saW/IoTpC5DsgudAyT?=
 =?us-ascii?Q?NwbjFxZooOHPny97IQPZITv/mHahpA/gGEv0ptBV3ogwFvXA2j3seoS4RCGX?=
 =?us-ascii?Q?OH8hp8vmejudLMVFDBX1s9/d1DzCOdxH+FSsT4KMwDDWIE84nXVGOCQ8DNFM?=
 =?us-ascii?Q?5NtXWwed/TV9bdne/YuGYhR67VwKbmXuTvfbFw9QYtZgUXYwU9AdCjc4Wh7Q?=
 =?us-ascii?Q?s3k7c3vbOhjAvgBMBrJW6emPK/sb1rXTcOXkNWOqOyO5gF1oMMiIJMVqxAlW?=
 =?us-ascii?Q?+5+OEBDM6xi9Tc3c8iFB1JVN3KSO9oDevBd41Z0lPdxEfs3O8fC5kzodJuy7?=
 =?us-ascii?Q?Fx7qHihVn/y804OncvQHEGuTpYD/Ei3qORh8XLbvZW/Ny8pO8htCqpAuLbIy?=
 =?us-ascii?Q?z2JAHRYgDHEsqSYwHsJbHnfHaxO33bL8fAYh6HgYT3NPGg0fLxkCoPFBHbBT?=
 =?us-ascii?Q?8oKvQSG/StPAj+0KwF3wqJd+4ZtF35sLadVHLEQ7LdlJWirKGKNwLQc6QoG/?=
 =?us-ascii?Q?QUqHnGeiVfwuIVcEjwRMzRg8USbg4LsYvMTfp2e6PLD5QYBlC5mCXLP8Sufw?=
 =?us-ascii?Q?Jx7i3X4i2psp7/fBt3aIMunluSlndpJTKiWxy26OkUCHt9W7g5bJKLElC9JP?=
 =?us-ascii?Q?PTLFrOCz3Slftq3U8tJFdHdvc4nnzij9SwZ1qZsH4MOG28+OoDRCJhFvtYsF?=
 =?us-ascii?Q?tDgtJkqFo6jTIb62vL1UiShZ+MVw3i+/EXh02nhuAOjm97eiSWOv0e17/Eck?=
 =?us-ascii?Q?mct2koHONoPDg9p+k6UoIUS7Abof+v/h4yWe8V4djxjJkYwzjGbXEd2HRBS4?=
 =?us-ascii?Q?PKzBGnm3ag2UbCSHHfup3Welobv4pY8O6MIH8DSBL+43ThKXEupqHintxinb?=
 =?us-ascii?Q?KtlMQh93PoXFJCdny8FTav2TC9jsODtMdtUaGw/o3NkGRBsT86ZcU76HlesB?=
 =?us-ascii?Q?AFdnaC/eh/qVYR0JiGzhbl/FAlbpP+I/iXAM5qDmgT2oLfkSntlbY7aYwht0?=
 =?us-ascii?Q?Bns/LK5BEhx4rnWOlGrlrnykFXXS/TyN4ZVHCHNucf05sTlAd3wFjvtXa7xK?=
 =?us-ascii?Q?CjcxQM/dT4e5kcnD+0nLW+X1QYWfW1n2xK0vm++yWB2GEwhTQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:21.8449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b86400-e6ad-41c9-f066-08dcf6f4b338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

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
index 70ddde37f283f..c8fe03d0c9ccd 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -388,6 +388,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
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
 	{ "AMDI0104", 0},
 	{ }
@@ -434,6 +466,7 @@ static struct platform_driver amd_hfi_driver = {
 	.driver = {
 		.name = AMD_HFI_DRIVER,
 		.owner = THIS_MODULE,
+		.pm = &amd_hfi_pm_ops,
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
-- 
2.43.0


