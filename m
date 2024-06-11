Return-Path: <linux-pm+bounces-8919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE4E90371F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3E228B5E4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27260176FB8;
	Tue, 11 Jun 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dAIiuVGy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523C176FB7;
	Tue, 11 Jun 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095980; cv=fail; b=gSyMX4HU6HDiivGd0WVov7+2CBU5ulR2OjbCi5xLNYAffgIqQvfxhxtnJR7h2iDqA6Yz47PZ02kumQLVbVBBH63zP1eOkbxnzi1IKw72kpTKw0OS0Y5yDmD1bFJaw2MQTBKQJfumLFqgyEhMC1cfI8j9slEjyQbNLlJGIDSf2Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095980; c=relaxed/simple;
	bh=tEDfx8mHUWfdUxcRaEpEX9TQCXUn/okttpoUbgGUT0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jhkz+Mc3Yd5BqGoQeVmWOQvNuUvqaehrPRN8yv/o2KwVsezfuKBo5fTRQtvoQq0MqTLKlf01fZmnKm+5o+vciHkEi+6aJrlFK9XkpuJRLzmjbS+0cvrSvZWkWBUKSqAnKOLioQmsVT4J2CcC/LM7jmhXzUttq7oK2UxO/RytzWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dAIiuVGy; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UghKGT+JqpSTteR4MPov4TSi5HxDN+JryselHwwFX0I5g4pHMCQwbGkAEvNDl2csjy06EImDgekhMmSWmXiRfcnKQSUeBeoIZjoKd5FwM6ehvYxpjv/VkX7M4pQgJUEKtcbnpyCMBaElY6EAT0NVLEoiZFmKMeCghCo/JMAmtb0ERswXl5le6YGW8fN55gBNyGe5a7lgrz13rmrbbJXszz1IRd/SfGvgDkPDY+qzlPkf5mjs1npFfxM+bbpsxKdOmIeTxjzS2I/u1rO9ATQkQPVDkX8He+upLBKbz4HGD7gGZJZ7dVP6SWcReE5/e8OoJof493XmRJdxntbKonHInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liWm75Z0i6PpZUdkpkbQYOaVVs8mZASTyBjMW9Pf+S0=;
 b=CbXenKj1NHMOy7nSeXzSTNneo1hYIOsAAFrlJxZzn18fznRxVq4w3YnAWipEOheQYuHY63YPdq2Q8Vr4og9T2MOKDhG7F7SBIZjkLimnTMIcPQ8Z12vkfNbvq8jTg1CEkJ8LxDPjC1HFjOARtKUJck9d/a6g2U8Osaj8pHj2NzSdf8Ai9Rv6NGDK2hT0auJ9qDMadr52q46tuBH3X5xKBwS2oRcuvq//gHJXoKazzQbJjC15xTHiNkGtm0B2lmyatJ+xXZu+AwfnMm88+JCT8kE5cUc99eqzZKTRqIqcADWthfBtaxxSw17hG9HdQ3lxr63lxyQWj467Bcj1qqIQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liWm75Z0i6PpZUdkpkbQYOaVVs8mZASTyBjMW9Pf+S0=;
 b=dAIiuVGyXH2518x6dRbaIJ8GYJu2GN9MLK7kGt3Mfc3n7WIHjxShCZ5i6WKXTCslohONNBgM4DoRNe1txr90SkkcAV6a5Y7DtxqQcl6plpOb62H/OZN59fibtuq+p88TuHWyXEy8MSwdc8Ne3jZiJyztCiAzlaWCJHt+POlZLaE=
Received: from PH8PR20CA0010.namprd20.prod.outlook.com (2603:10b6:510:23c::7)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:52:53 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::46) by PH8PR20CA0010.outlook.office365.com
 (2603:10b6:510:23c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.27 via Frontend
 Transport; Tue, 11 Jun 2024 08:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:52:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:52:49 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 03/10] cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
Date: Tue, 11 Jun 2024 16:52:19 +0800
Message-ID: <41d5573ed19525f95d79d2af46bd1cce5779d6a1.1718095377.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e85a1fc-17de-47d3-7d80-08dc89f3e173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p7qHh5u2VnLveiIFQN9NOHHSRIJSq5ztZ/4Nu0K5SqBzBwG9DSJjnDE8y7J+?=
 =?us-ascii?Q?NrqjkzunLtNfMvlwaRWyWIfVF41ru2POkJfcmC0jwjiJ/x7ByT9rz6F1SdEk?=
 =?us-ascii?Q?LRb+kiEOnL9B/+VVhmeA5hTU/beOz41i1CLIArqSEYW78qGBqsULGPo21l8C?=
 =?us-ascii?Q?u21Wn57eh9VFvi3H1Fpb5dcUPi3LvT8vHGNOfBdgj7rUwcAnRygXG30Ukfxf?=
 =?us-ascii?Q?WMOlx+yc+q3tUQ6PVLMmzv40+Y50Q/9q5BOpzqunNimjq69QsAkJrRicB36u?=
 =?us-ascii?Q?rxgShkyvH0rC+dWy5Wi8/orJ7+jAbxJka7BUCy6zlqqRJ3+qcx2aa/Q+llLV?=
 =?us-ascii?Q?doE47OyT+3xKMb6zTy6Nf5u1O8eq3X8A8kg490EgZFiTiSkveW++25mdxV2w?=
 =?us-ascii?Q?ODjUSHAbDu5T+0IlL4xYHsKtNzhSXk5327e87FRsLYk1MKR+0JgqHrCl81vJ?=
 =?us-ascii?Q?cOysLMcEZ7dpLH13J2IPYjeKa2kFvSAAZaZ7W/ah3yE6IysUOFnaHCKb2dx7?=
 =?us-ascii?Q?Op6/BRg7wzVV/jgpB2z46875hPYRQYNYTn75pjpOKO5KbF+s1+Dt8PXIl+zm?=
 =?us-ascii?Q?j64TvF+XjRsSoYU0Ci8nGmuJxDnUfj5/bbmqact32mbFCveM2iYx7zdugjlS?=
 =?us-ascii?Q?W/8LAZaedTsD5JDSXo5218rXDjjMFxEIKCmEooWbawJ1IQtRCs9p2vDboeJu?=
 =?us-ascii?Q?DrTX/5RpXeYCX/sswwarzP1waLin/oUz2jFaDHfXhKhk9n0IyoTGP6yNruEh?=
 =?us-ascii?Q?PVTVqk3EOf4VR/0NjLV4Fyke9ygiTnzYIfbwQZYAO9ZdhxCh1pYqY0Z/CB4z?=
 =?us-ascii?Q?vzSv8IqR0orbijJB+lQLtuGSuBxz8X7BlV3at8kqK+F2mL2YYpwFAYL0jseF?=
 =?us-ascii?Q?ki7h5eSbJoar2QY5IK+Ic1E0mXLpeLZSmW2gEs6coeBbg0zAN9zNmuxwNzIO?=
 =?us-ascii?Q?G0StXrYAnGhb5tZGr1FouWPBaTQH9im4ocwupAP/sw2O2gnYQGEUvL+W+LYA?=
 =?us-ascii?Q?yn/HMgJbrIgVE0CSy1gHn8vgSPP3P7O51hjIW2QgToXd3IarM3J0AJyya2qS?=
 =?us-ascii?Q?3Y8+OmUQJ6ykFXbYBH3OkZn6ugETOrUVbR+RYxfVflQahJ7n2l7npwlKZKit?=
 =?us-ascii?Q?tSku4tdWGDdQsx9EV0N2f/ix0+uLAXPuZ8PIc329QQd4v7WXz8OZmkMLE5n2?=
 =?us-ascii?Q?vZimoNjT2fH/vyC3eZkF30hJd0B2HS7iEqNhQWUacwkUG1wTDvYZy97qMDec?=
 =?us-ascii?Q?aeQrd6JH2Mu0ZvKfMGxUqcxJ5V5J+0zPL1kbrdauF5vh08gCbMVj5ab7glQB?=
 =?us-ascii?Q?q3vNwn/N12xFBbS2DzHuw+oZiP39DbDOC+M3gQUCOLUAVdPJ499SGqWBf4lh?=
 =?us-ascii?Q?T859gyg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:52:53.1330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e85a1fc-17de-47d3-7d80-08dc89f3e173
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

Add CPU ID checking in case the driver attempt to load on systems where
CPPC functionality is unavailable. And the warning message will not
be shown if CPPC is not supported.

It will also print debug message if the CPU has no CPPC support that
helps to debug the driver loading failure issue.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/linux-pm/CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com/T/#t
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 36b1964ca8d3..f166b3b94091 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1740,6 +1740,20 @@ static int __init amd_pstate_set_driver(int mode_idx)
 	return -EINVAL;
 }
 
+/**
+ * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
+ * show the debug message that helps to check if the CPU has CPPC support for loading issue.
+ */
+static bool amd_cppc_supported(void)
+{
+	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
+		pr_debug_once("CPPC feature is not supported by the processor\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int __init amd_pstate_init(void)
 {
 	struct device *dev_root;
@@ -1748,6 +1762,11 @@ static int __init amd_pstate_init(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
 
+	/* show debug message only if CPPC is not supported */
+	if (!amd_cppc_supported())
+		return -EOPNOTSUPP;
+
+	/* show warning message when BIOS broken or ACPI disabled */
 	if (!acpi_cpc_valid()) {
 		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
 		return -ENODEV;
-- 
2.34.1


