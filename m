Return-Path: <linux-pm+bounces-18292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4C79DF192
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52E82817BF
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92F81AA7AE;
	Sat, 30 Nov 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lMnowR7p"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133E19DF9E;
	Sat, 30 Nov 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980061; cv=fail; b=Flm6DqYjq5AoYAqqLprrLDUI9MFXYKII/ikKPIxMDJ/z5QGYjUKLKPB0vQ93i/hBXU3l0aqC/4WhGRA6lN1oZYSwIXnxhgfbqy6ER6LjfvzaBtGJ7aUZzM4ASIdR5sL+r4JmoOjLrgmXwz289oYgsyqju8wxV7YM9h+rTzntcMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980061; c=relaxed/simple;
	bh=IOvZRKAPWNZC84/xYTtOAnd86sJc053Z0HhsqFxH+/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmuwxTl+MUENluVrlBP7PRmENEM68/3eWDpZTFcLnhm81uqjJ28TDBejrgkTvcbR8c9DadhOvmd9VScWkKiz0DBsx73+MsuiJDsdxVjZh2zwslN8Vnzq8SGh6SYy/2mVqd5padO/Hb0uAefaIDIXAlI78lLRep4QtXfvtXRteJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lMnowR7p; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0cQ6A9QGLg+vMU7icEBt82pNkmRSRbxufXjM59W/r4ZAKqJsdqOZw1w5fryF6Nsoih7RlV9wy71EVj4UgVJ3nf9Qda6H9p55G5mtbGx88/5HH5hUrr1iGqPr7OKpXHulV/yPpwTHhMYQkJ/qD0YsFaAcFnQh+k0dGw5kb+EVvMADrLQ8DcQ3vLS+arTmFZ6pPJlOoOLdWLygDlRWN/8+2D9kIGXJpDKYGz2XKw3lexFP8gTc2wqfNRLFzeUK/Q1W97KG6UASV6Wzp5/bGuBVpN28gQAAmnkOFErUeMhszIVJHahKSa8GLf3Z3y75awGNg2pcsVvCb+EgAWvgm9ABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rQuoDc8UaCkJTYhrzlrm3g5L3+wEqX60J51gCi0g+c=;
 b=keXEEE30ZoPy4/5LB6L0opUI600TIdR1A9SJC9QT2PktaP+hguZ14bJAKF4NpzIgHCiX2vR1v3oymAfuzgdaZGRIDhnetWYMmCLVXZs6kH9rjsdddzNatmLWP4dZHFS5/ClBh1FLCoR9KTwbv7icqaWUBG2KFMW/J5w/5PhTizTMqNEb2D73jbo11+6u6mVXanN2e16RqrV9KP/xwsJL0X1cGGD6QH0bqrvAmv7Ne29qFaNn59l0tpd1B3OpmOFtQJ1hG6CvcRYbWJSr9Hi492L8uGANS2AZwtvjvcLi+Q4UO6TwuFC8noGO3owLqHCVijwdozepqLvqdaU8KBNksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rQuoDc8UaCkJTYhrzlrm3g5L3+wEqX60J51gCi0g+c=;
 b=lMnowR7pjT94rst+FJ30uj4VCzBPwyJ5GBq4mE9EAteM+QZuK021UYUKIHm7jBEPrraKKl+E9H1/tN4jdDFuiFTHL2uS/qJFaTQ1HegrHxfKuTXWuPgETqAIu9nCxLMSqJGS+GeNXh+JsvwBPrZq7yWCs8/dH2XZIXGq+rsrnyM=
Received: from CH0PR03CA0395.namprd03.prod.outlook.com (2603:10b6:610:11b::12)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 15:20:57 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::33) by CH0PR03CA0395.outlook.office365.com
 (2603:10b6:610:11b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 15:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:54 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v7 08/12] platform/x86: hfi: add power management callback
Date: Sat, 30 Nov 2024 09:20:19 -0600
Message-ID: <20241130152023.684-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130152023.684-1-mario.limonciello@amd.com>
References: <20241130152023.684-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 912c675c-6309-4b83-e420-08dd115296a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wuk9tGd/R7HpO89Pt7JKathqmX6yke2zU9H2IXmHEBKNtYvl8EHy3/K2j0/6?=
 =?us-ascii?Q?uhXX/5uzoNFhj+geYsMJq2pG3q5LZ9zScYtwKzco4cFMjgfxFADUbLSlt88Q?=
 =?us-ascii?Q?G2yfY6Rkr0Za6b27lzukirZ7KDLCpeJd4lgj1DIczGKD98cY/F5W9YU0xWE6?=
 =?us-ascii?Q?Us9oVdTqLGEpF3PnbSBL8DNk4CsYuETTFfLloaNoy7S2nN0Xh+nDhC3oMNxj?=
 =?us-ascii?Q?WAYmurYeIRuzn/2hm4J0p4dHkIGVWxqvzmi6wrp2VWIsh9tEHrGukToZYTBi?=
 =?us-ascii?Q?x6q5Lm7+1+Ks+GjTqlQIr0WaPkApiAiq4tbZ4h9zme1YGKOBT3tDwSeqHGDS?=
 =?us-ascii?Q?1P4gPey8xBhqOQkD7aHuNbp8HG5FLtbxEEwJQOFHLclYeY46JnCIKyKvv/Tk?=
 =?us-ascii?Q?Lfh81vs2KLivTu+vskDz9yUODNJEVW4TkrqQyugorFO5xvYgqSeICzN96LaG?=
 =?us-ascii?Q?LWVM7F9fQAOAt7w/KSRTpHClc9XxEevtLgPUAaUB7n7qs7FE+mYu2YOc1dOk?=
 =?us-ascii?Q?q3nZakgaDDHVQ1CBLjuTsaPcnK07kxJyFGoWW8MKnkmyBPwfkhJSzgeUuHhg?=
 =?us-ascii?Q?/kuxuIKoTKMPSuPpkn6Y6hJiiIZPM1l1rJgxJcM1S/AO1NTMbVqAdpJWnVD6?=
 =?us-ascii?Q?Sb8PJlmgiPcqvehbBK6+Hvh3WsSFOlQarXNzdnz5rOxzbpyFdcM26op1L8jp?=
 =?us-ascii?Q?mzh/wVEdS2jFgdJM3sjGLOXQs3hhPKIZm59TOJKZDADmgzzVUDkWwqYYaQIt?=
 =?us-ascii?Q?d9QilVt5+8ADATNJwVl74FueBBzUGOnuT6XwdGIyx/zchu98BT3hzHeY+Gk0?=
 =?us-ascii?Q?iJkVjmP9uUVFBYv83PoOAR3qShFtATpj/iFChmMpRs7te9RzW+HQEesMOBQb?=
 =?us-ascii?Q?6aalyq7vBjs/ahbmIUsO+hjWnFOEgHpdtYNE7zLhA/Ttv82arhwxhDc2WKXw?=
 =?us-ascii?Q?JLsMRvmQ/Fl8BNazoydyqLzrhylBKTgPEYAK80dJ7OSU2FcQdxjvopvQFPd9?=
 =?us-ascii?Q?jYkJi24JLesrPc9GVPi+apJEytBi9wT+wGM9Om1hdCc76mITTK1zz0fuNVoG?=
 =?us-ascii?Q?B4dLDr3SamKhia8dH7OiTkwSWBZHxX8LaXxA79DvS3lJQz7dS0oyFFIDoz3U?=
 =?us-ascii?Q?6rWnE4jXrcVsTqeCc/bhCtE1QrHThvd6GJv3JqhCe4caBjkfb7rr5JAZjrBA?=
 =?us-ascii?Q?1XWre0G2MSxG1wXCvFF3CrmD8Axy3KgQWEOHBabiLtFhpZO6B4Gm/8zmWcGL?=
 =?us-ascii?Q?Yr0k39MObxqiRYVCjB+fIzEoSFfDxXQcXranWyCuXHsddZ2QgRI3HaGJGRw6?=
 =?us-ascii?Q?NSyoxUI6UJoZY3lM+h9zqcIkIKPtDvWPwbliEzreSf+nr2ULdxUSgH1yudFf?=
 =?us-ascii?Q?L1WurT0ny8/YgyjjCuYvttuaVqSKqAb/walDk2pNWr4Or9BYTI7RHxKcJrgH?=
 =?us-ascii?Q?HCM+uNQ0nPuw5hcN6zwEoDLFGIamJyc1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:56.7501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 912c675c-6309-4b83-e420-08dd115296a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798

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
index 922a9ff0d447a..80ccc50ee0914 100644
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


