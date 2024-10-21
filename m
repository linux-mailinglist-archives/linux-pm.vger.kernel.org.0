Return-Path: <linux-pm+bounces-16134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C139A71DE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9684F1F2212E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17241FBF76;
	Mon, 21 Oct 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jXB2iAs4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95E1FB3CB;
	Mon, 21 Oct 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533811; cv=fail; b=N2iA5ZGLr1EzzPVrZDrO+6iHCmVwyVFAms4SxFjPtvY3GpLU6eNqE1XnShLPiMCg+rgrajuZ0+XLKZkOqWBGmqvwrVEq4MGUdW6FGG6X4uO7wMUoQrZ/rJVBVLmDRm1CopAD4zYQVjNNO1ftLXndPjRL6j54YZkb0PYSvaTjQDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533811; c=relaxed/simple;
	bh=KPzuI8HE8WHHX/zzyZJkcJkbwtWd3Vvff/paWvnlU0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYu7YTq8531IGeCNkDmbPv+eYGZ+kGEYyjblVh64TatVWbcHZsnoiY3JDSrc1/SS1U4ql5fvCR4wbzd6/tXg1Rb4to66qyEkKaHfwym1sNUJ9AiL7xc86aaBSmQ5ZeTfJFq5JtQaEWru6rIcKMgh8PSRvxCnxEjQO8A6kZeRbY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jXB2iAs4; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9a6CBzwA0/Hgsf9r+RATgLysWPU438ErN5hLir/mlQ4pZ1y5AaoSt9/nDRTUPUbyPukVeeNW6kCcBxeGP872aJCMS7Byb8m7XsHdpIXFyNqByOp3KCSxvwdIiU0RMEMxc84CjFY0Pol+RqPKwbPcO71xLSeEnlnFMn2DcBWKgqY9gewPkIh9JIlY8B0gvC7eWKZfdMooYqbmAmN4BX7sUUvw+RFN9pYGL4V1pSVDDRjRPIscEU/riETGi5AibT/KWEynT+CX3bVK4BelteVvpkKEPSyfRyl5SkqnjbpXH0mIjjBh+LJntPOV+AfiR+pCFvpGn+8bbfGc6qhfgWHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq4U4YF25FviaREC9j0lyNGCKcnYOubI1fSCJ0fcrQY=;
 b=rNX92IYpqJXWIXxYMitTFeR1kYaZfuQWwJs9rvl72rPNMKrMoJbAvlo6AFfzUQ1btDAUSz4SYPNQyNrJtoXUGtjoA61AtUV92tFky8Qu3EzdjDpunD9uKGdPIIwZaymaCJl3sZQWOd/bq0JKL8jUautkdTF/e3HZyY2Xgg55r9KF/35cWfYgEIaM2hEWXXoHdHwOblrJIbpBHqWSN4BhPpx+P5zKvv5imf57G0+t9qdr6iC3HVUtZTG+MJKhPGhJQGvIyiVetA21MGHYRQ70iM7EuWC6HEauJuj72Eq8TH5EQg63oiq1dgxDZa6nSXR22cWfS76HYKREcQrFltT1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq4U4YF25FviaREC9j0lyNGCKcnYOubI1fSCJ0fcrQY=;
 b=jXB2iAs43FlS3qOzs3A67ATLO7m9DALUVSFlr6/NTOmZzmNhckjMyyObNkO8ZfE1/wIRpmgetqU/KBsnN4cOnw0nJfgivlLkwnqBLXLobVsFB6OyyE2r7gQBo8Fxbo4+Nt6trCY/nzq48YEfjuoq62U4FC+s60kUM1sQ4u3dZw4=
Received: from BY3PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:39b::24)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:03:23 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::49) by BY3PR05CA0049.outlook.office365.com
 (2603:10b6:a03:39b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:21 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 09/13] platform/x86: hfi: add power management callback
Date: Mon, 21 Oct 2024 13:02:48 -0500
Message-ID: <20241021180252.3531-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021180252.3531-1-mario.limonciello@amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 329e59bd-5729-4a9f-d6ba-08dcf1faa7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/STAUvap7c06xNrzXp4tYnbjEHnT8sNce7vRjY6mFjCAwNJBO7OtHqCwOCRH?=
 =?us-ascii?Q?C2pzlUvL6o63xWP+l4OIzSUk9owfdhwbSE7lTf7T9iblhSleyrmdblDAOLY3?=
 =?us-ascii?Q?i805hBoY7dN2nqx6Mz8lqsAR5RkF8IZG02LZr8wfgnkUp2G27Ot5t24/baL5?=
 =?us-ascii?Q?qNlnEIzMTjmy3CWzWQfB5PgnDXokLYAGn4p9fmnKbEnjnWy1M7PgUYTfcRMM?=
 =?us-ascii?Q?M38xllqsktEScqH1JyaFCtI54ZIGDvIiLCOapXSrNtttgS96UJM3b9++2864?=
 =?us-ascii?Q?Ib8bJ3oJ56GaM+ov7ur2TKTkVWCmkUyKk1MP9eM2RfJghBh5+h/3dFE9nAEL?=
 =?us-ascii?Q?a/CDZnLtgUCzjlnpJ2B53dBruPlstQXSSlClHo8/2fsumgZmMQHs4S1tSQEb?=
 =?us-ascii?Q?VQkQ2gp8/r+DGKz9jDYVy19PYZDURhRVBebMOBVpk7ACQ5scRe/9CRk0QcGY?=
 =?us-ascii?Q?WEe7BjE0fU4vdB+cj/kcqYWhUMkbduwGJUJEZjnNs0EB0dV5jUvFng8nTIy1?=
 =?us-ascii?Q?llWxbLzI1ie9KDRgiPPVJio0wS0TFJL8XQfJBGKEvKFljpBa0VQYdLrmYZFT?=
 =?us-ascii?Q?ejwJqwB/k6MeZb2ivTR9i4DE/MpZ/f/uGG4us8quareLoTaAfr/LuIDy2K4J?=
 =?us-ascii?Q?O9w01GRWupLh5NojTdbqVxiYq8JuZXhmmIuSNXd7ohc76AriQf3a9s6eYhYa?=
 =?us-ascii?Q?FUxaAvxwNOxYQqEc55/CYed6Qe+HptNoaXefJe0cCmuoDHNtZsrUwtIEJGKl?=
 =?us-ascii?Q?PNP3mKHz+h9RTou3bM0wt9vK6fU3k0M90m1/GKJOcklexyDKjO9py1ennUQs?=
 =?us-ascii?Q?QY1mRiW436ette/LR9rbZpo+dngI+XsRhJaYVxnptXxM8bh/3h3esnoCvXSZ?=
 =?us-ascii?Q?H4ZxC77hNHpUo8ldV/nNUOAqJktSd2nukk9UTusSOJ4IMXhaSROn2KSXL5vh?=
 =?us-ascii?Q?EhTQBT0hA8vOsx1ZC7PbvrtmxorUF4Q+QnpqgZv3oAkbr/M0Pn2w5y/WJp3B?=
 =?us-ascii?Q?pd59l5QypTdkZy1ShBPZwvcJbWNgWIMZ+zG/74dxaKVwWrBGasBlXxBf3eX1?=
 =?us-ascii?Q?JSgETI9rmvVa7nN/e7WIE6jgJvZNe+4tPnP1vipQSh6LKaXNAl5r6k95JhQA?=
 =?us-ascii?Q?BwQI6mhQ0W10shLOY6Iy+7u9XxkJOVCjFt4X9rD0KjmSLNjZSJ0nJulUQCOG?=
 =?us-ascii?Q?Zu0+gvZg5DS8OLcZeNeYBwAg8oEgEdTR9wc3Esyxa0E3JOrfcNnTv0rotuLt?=
 =?us-ascii?Q?RgZfTCJHfgbMomVTRh+KLqAM4fCxjcOkqnl6dL6Umm8xL5KeFxMGKH82EHIS?=
 =?us-ascii?Q?To8lmlwXydcD1RoQ5Tw7M3qoQ9JT2UpNhO//5IariPBj6NKyKUT9f7tluQ7i?=
 =?us-ascii?Q?kjFnUttmTP5eldsbfsfRQgvYLr/MKM/OqnkkTqd9HCLi58V0cQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:23.4921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 329e59bd-5729-4a9f-d6ba-08dcf1faa7a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

From: Perry Yuan <Perry.Yuan@amd.com>

Introduces power management callbacks for the `amd_hfi` driver.
Specifically, the `suspend` and `resume` callbacks have been added
to handle the necessary operations during system low power states
and wake-up.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Use for_each_online_cpu (Gautham)
v2->v3:
 * Whitespace (Ilpo)
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


