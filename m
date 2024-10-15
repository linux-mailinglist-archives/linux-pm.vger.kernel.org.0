Return-Path: <linux-pm+bounces-15707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED4599FA58
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925D91F22338
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8363420C035;
	Tue, 15 Oct 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5fWxpc7D"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF2208D75;
	Tue, 15 Oct 2024 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028259; cv=fail; b=CFtP8yDVceCyh9gb39utk3ZtAW490kXgBZyfpeTRh8l0daA21x3JUOm8ijwESSzYo2+9EkeC2tIzE+5WSHffOT8NJvDC21HFhwJJfO4gSN5SXyqRmJOc2TQ1HsGyLD32IDUnwk8TW1e8pbpInkteh3ZeyD/YmTbBEqLnYBGqQ8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028259; c=relaxed/simple;
	bh=mOGd7s2YUbghZd2Dxn3QUgfPmXQIdu6h9VT3ARaHLrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtbDPjjdFKiJXmOT9Xp7fD+2ZJ1+L/KOC8tOL4eIPuc+q0oCsrgVXLfohUr96j9GLSd0ekf1a9jB0vlwU1fM3z8DPgB5Td4dSbcpA+UDUi7LUgIAkwCIHWPnTBKMAtM3C/qfy98KEzdw8s3fcJdtVWxAdzXgScHhExSq+Kh1sV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5fWxpc7D; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C//oKykut+mFDgqNQB+DzRvetrtz6QXbTPvaYJgnCGnWgeRWkhoQoOyZYqapECMu78xRKd2zLp0PduLa7RdrN75CMlMI6OjxE77egN49lymDNDnFM5A/3nGVE+05aAaJoAcB+zCzsU3WlL6E+Y5C9EuzSRrdCVFwUoTc9J31yyV3GW5iGoiv82tz9wY+PdJwPWSNMXHMXXjqlK/QaAZ1g6B58zwT/68N/PSP+GdbNT5ECjUZfY8K65qk5z1zpNTsElbIc6R4nBXEHAWCt8pPIsCoRFbU/OSKFV3aBZ/uLf7Z/IKQveROjSKBN5CO91TQndGihiSgzsiS8RjFCej01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tORVxfEFTV3CnIWBkOSUc1UbnaD502E2dRLezlyLwrA=;
 b=pMcq6mumdwXUkg3fdHaFdmBUeJcWsVzYwIl/nGhma075WmR8YNf3VA5Kbg9cJZy6KxWUZeszDBlOntLeWaw0FHQ64m/q7jpglblnhUtxnaqzpO4Dny/wn3ywwkBG3fBqpHaDHefWDGrMfCrUDRuJlDN5EEIv4dhpFQ/QydxW2pOJDzcsGeceQkclGM+dCqR98YIgimDZPB90h6X1pRbYJwhnXUKRWbI7XZOkFskwZify1Ju3lTNnFLqAXC0jAayXcFB5UxV8wckZcn2UNiIiI/1YAYrKhE1qJVCdm+/xNxQP502w26IB/w2ZM9uY+yxDA8G5ro/CE+RvNKqoc4LxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tORVxfEFTV3CnIWBkOSUc1UbnaD502E2dRLezlyLwrA=;
 b=5fWxpc7DDh1q/x3pVBHJNTmjmod/pM+30OFrIpZkcyRm+LR2tc2GykCE6Ii4kJakA6GG8xpO9cCW0o9dsnBlGMa+y+yU03gSyJVliNhlLOb2XOq3h1jV+d+mfVrL9EZqqYBMjIwUdmOasnXKlntMbLO0KWAgtYk8Oyn+jztYzCA=
Received: from MN2PR20CA0045.namprd20.prod.outlook.com (2603:10b6:208:235::14)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 21:37:32 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::1d) by MN2PR20CA0045.outlook.office365.com
 (2603:10b6:208:235::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.28 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:31 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:30 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 09/14] platform/x86: hfi: add power management callback
Date: Tue, 15 Oct 2024 16:36:40 -0500
Message-ID: <20241015213645.1476-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ef91e0-d948-4efb-de97-08dced619343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nsSFifQyVxU3MZRx0Z5cnAUHa8GC/yNs2n81l5majBQahzK1qSoh/1aVK6gC?=
 =?us-ascii?Q?gAoYTtO5gli9Nkcw3PYqgzOme7llFryEqbn0W6XibOQSTksoskOn817GeA/N?=
 =?us-ascii?Q?Bc5tl0xsU+kk4H0xR1b/0EIAEYg6C0RHB30pvl2yomkoNmH8IEq5To4bOKQ3?=
 =?us-ascii?Q?5XUo0om6Nmp+rtCy7I7SWHbhyIVmYLrVKGmnL8UOHV9IAJLQQeKS1qyG2o/Y?=
 =?us-ascii?Q?McPyzBCkAJJcbuJhIX19YCu/OOLf/MNS4J8Vpscq1aAQllQmTNfQBUkcA0a2?=
 =?us-ascii?Q?p9JcgwCFki+xMqAmPYpiFP6BTPXOLoeNx5uCw5z/AtOvzIhx8wwDUZk94mpA?=
 =?us-ascii?Q?M8UUccC+cDhEHtW03pxgx2jTl+tKzmbHQ6jHTEH5pjAamdxWx/YdR9riyoc2?=
 =?us-ascii?Q?a4FhzqamYcawH1j9AFyFgCShwjd55J3IpiOFlID7HOWR6gEGmUKFO5JlonQS?=
 =?us-ascii?Q?9VB9XouDfw+V733om9JXPFtQpAUwR+q4nbu4H6GUfNv0kmrIhubOBetJ3Uvr?=
 =?us-ascii?Q?f/LlF/UbqOSIRmpzWgn0UFIXZ+fQWS3ZEVOH1wpHXvHr+r0NNMznwATx8Ya7?=
 =?us-ascii?Q?jsrVSoLfR0LPZ6H23uaa7PKCB7LFaXKPv87ak8ReTpQtQ2YDfU0vlGaOrgHc?=
 =?us-ascii?Q?+TbII+BwNaNY2JS+E3/4W0Y34NIo5awNVApywJhSmoEPggKN/z4hPqQIAqF5?=
 =?us-ascii?Q?xLrkzwxJipVdu0/b2C7Ao4CYqBk3KhxkOU5HlU5r/M2SE6p7AalEMkjNhK0a?=
 =?us-ascii?Q?6Md74U6a0FlhDbBkC3HAjbh26/DO+abvFrSMEfYUR8EAgnHETYRlAl0AOu9Q?=
 =?us-ascii?Q?GH3FsQD3ADKr/UR4ys6yLSygpgnTQkvBxGiCqNkXAu97/hFP/Xy5iCQUK40V?=
 =?us-ascii?Q?ThfLtxNkhm3ijBf0YSKSj7/9sUboUtxgHEkLBMw0DebMz8RA0bfYdp6lVXDw?=
 =?us-ascii?Q?vooRKh1cTFL51hz9ijreHa5ryXtuYy9UyFPSPaoU78mtcBvrCn00lvlC0Kvg?=
 =?us-ascii?Q?G5FLdCYNKa25lnwvE2vuI2NBK1KDQZAEdkmOKpBG48xj/Xi91CRllARoWv49?=
 =?us-ascii?Q?FfgaGoZ5LaLevgE9e4zEKYlc81gkpgFygwAxtIZ+yW1aVudyjHya41jdHrON?=
 =?us-ascii?Q?sFEabMvY5awoalkaTTtHbQLFRr4dSMB3xFVgHT5KjWHl8F7jADZerft+xn1N?=
 =?us-ascii?Q?5uMp/7hSdjVGrnLZul3DUdq37ZFGDYL5Z9Rt9K9HqNZ+4Dwid3uuCOBnnxTg?=
 =?us-ascii?Q?dBF992Uc2D0kc9MiD4Ppb2z1alhbmixz7XzPIpe20AP0f8F9mR3+OUehmKjV?=
 =?us-ascii?Q?6nnqfYLzoiiLWN4A36HzaO4v9Ez7ZdRmzG3HVQbJ6jCymCcxPryqEWxaFddt?=
 =?us-ascii?Q?0/VzwotNtgtlgeuYiy97X2aE44n0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:31.7452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ef91e0-d948-4efb-de97-08dced619343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327

From: Perry Yuan <Perry.Yuan@amd.com>

Introduces power management callbacks for the `amd_hfi` driver.
Specifically, the `suspend` and `resume` callbacks have been added
to handle the necessary operations during system low power states
and wake-up.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Whitespace (Ilpo)
---
 drivers/platform/x86/amd/hfi/hfi.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index d971ec1124af..79963c423d35 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -392,6 +392,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
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
+	for_each_present_cpu(cpu) {
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
@@ -438,6 +470,7 @@ static struct platform_driver amd_hfi_driver = {
 	.driver = {
 		.name = AMD_HFI_DRIVER,
 		.owner = THIS_MODULE,
+		.pm = &amd_hfi_pm_ops,
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
-- 
2.43.0


