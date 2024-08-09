Return-Path: <linux-pm+bounces-12028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992594CA1E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 08:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF132886EE
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 06:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C016CD11;
	Fri,  9 Aug 2024 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D9WRddoT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B916CD07;
	Fri,  9 Aug 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183766; cv=fail; b=fFI5Z5ozbwjuAlgeAR6X68M5WMxm02He97uzHdUt1C10qgL7Q4bchJ1xNXeltK4HkDLHhkKEAj4Fhi1PvuXZ7TIpa1uQ283D0rqHX/wMxFkFaPyEWtOPJu4evsKd75+KOdOr9KLavZ7EnY+xo8LSxT79sAtQWh9YTDAULlmQmu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183766; c=relaxed/simple;
	bh=1SKrQ4LuC9x9mjwTN4y4ehDlRuYsZ19IoqWyWj46a6c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fvxf6OiX4yHWPLxYy4wWU12kbCdOp8NlaVugoQFmIXXviTJbqmIDg0etxLqniknNHooKnVwnvjg5aGmelacDulXZna8Lr5xMQXF91oZ6T9s+b6ybtfAaioHRjz/cQJCnUS2DUvM1IA8nCdG290pQGjkD3PeZlPcGatFZ3Ox2WuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D9WRddoT; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMFYm4Bq97+74Y2ZhbUq4jBwm0ZYCP6qWk3aFYPTtD2+ViFB9hgqqQW96APOuDN2KWiRzSd49RPlGABVi8Lb3MQBL7KtVj+SRiuvtOzqUKR+zfQamBJWoDhDhPOI7mvqiJsBk8n1u7kmCAcL/UenOf0+OTX9MKej4hnlDg5LcIt6gFZYRNJfm/AOGMzlvBGCAXRLuKxDYzhCPcjHExSprdocEbPvfgvubFWIIk6yMRQtsy0lBzMd1DAkH51EQHaCACcXg6X9G/2IPs8mHKnFoMbWt4T8FTOFZ6t+62iOKZB94d86q9WrgrMBqCMnaeQOXrfUTPMN5d1zfD38Y4/Veg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn0aM/4J8bCJxNM6PjGHALw+yREOfRutJlVPIETnLK0=;
 b=M+XrIqEtAQpIVjVXHAk1+ge8PcSXUaV6rpJ2iyUtqS0kfjUTNy/DopD8VeqpdbB1rqNZkGDaTaX4JeoAoKm0xaiNzEO3hSnBnuoNY4jRcScx8t+H/ERaxnjJDq2oJErOnC1Rkqf2DJvDOtf5mCE/wHVBb6DVCOY4CqTlQq8yIZTSO9ubBsc3sxc171Sa7/puXUOPCwX7WM7Xc5y6xx1NX3skOyqx7Wnd6jAtbyLDljAaSOq+NbDtMVyjiTPB/UZBU6t2LbaYvTurOOTZObxIh1nlntsCDB87sHPaeR5SoVxui77gDGxf8ftth8k8tkPL0ONGV2AL0ScYiYnhboBTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn0aM/4J8bCJxNM6PjGHALw+yREOfRutJlVPIETnLK0=;
 b=D9WRddoT0xYyzEzx5hYGGMoifWQN7RFrQY1DtwtOwAcwp2NvxmydGVotKf1Z11+7mAKvGtXSXU3nnKue27hzeQc1rjaWOH9SOQNvEw/D2ADuK1+o+XMpwLytHPNhO1gDboTkNZpcspA/wE7RsXwMer0/zIgBbT5FdpZHVYBpEuQ=
Received: from SJ0PR03CA0168.namprd03.prod.outlook.com (2603:10b6:a03:338::23)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Fri, 9 Aug
 2024 06:09:21 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::35) by SJ0PR03CA0168.outlook.office365.com
 (2603:10b6:a03:338::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Fri, 9 Aug 2024 06:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 06:09:21 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:09:16 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <00107082@163.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESENT] cpufreq: amd-pstate: add quirk for Ryzen 3000 series processor
Date: Fri, 9 Aug 2024 14:09:05 +0800
Message-ID: <20240809060905.777146-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd93741-b86c-44aa-657e-08dcb839cf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cbbD/nMy9N3icVB3JQOZuenMmxwaqiGNqi8ulD0D3auo7l0JMk8eRY30TNkD?=
 =?us-ascii?Q?An6IX0lUJF2NvPGMB/4JpL8T72KtCcwxNIo+jOGPQ0s7UfWOliItSuXI9wof?=
 =?us-ascii?Q?Z8yrM8866lrOW9Fstd+ka1NljlCwwWvI07uwa0feTZiCvkVpxObxg1xN7f6w?=
 =?us-ascii?Q?matG44anjD5I3zNKLn239kZYbAHiqYu0kNupj0C/4TiyOhcn9JbhlzVw1EMu?=
 =?us-ascii?Q?Bqz/vrHpcYYAbso8yyPRUeEMe7l1Uc7cw98euk5tVKlg51XnjoNOyecT4e9g?=
 =?us-ascii?Q?pXzmSISIl2llQ6nPBxkqIZgJojJbRjmZvUwXtnvBr1GvFa28mz/pCv8n8zNe?=
 =?us-ascii?Q?rm7BDbMM1+gRPc+A5f7cPm6NNInEqVwMjNP1vgGK/OnU23VmF5pAzzXxb5WG?=
 =?us-ascii?Q?ewEzgYoBUb47z5GXwak1TbgFnJx6FknhlroYyRWbbcxe2UarT6clg8WKZj5a?=
 =?us-ascii?Q?NoAJ3nSc3npBShN03tY9iwWfRr+2XxisVNZgyWF3jlN3xr2OqD2FGx9yzffD?=
 =?us-ascii?Q?xKdVjycSx0XPi+qtPtl6Q0cylgJEUxCXDbr+C+FBB8rpwRPUFma0bJpxutun?=
 =?us-ascii?Q?HnsHHfIDzaITYh9ZVaNPc1kbmo/dD50psLRCTqXAtl61T+tPoPSTX25Uo6UV?=
 =?us-ascii?Q?pKhYoGoG3H5KQnIR1bvkJNccaUVJeAhX95jt3hSi1GNBJ+8tMi3yNTv3Hqw6?=
 =?us-ascii?Q?Rs5iHijVpaotnCKxXsylBItnpOM5IrmmLnHltxIunAg6o34KcwwoPiM2Vbwk?=
 =?us-ascii?Q?8wasHwdMyX+l7Pxo1Uak8f1eialRBHNBfMYPcVlaYbBhntFPqqim2c+0QBwU?=
 =?us-ascii?Q?+OwDBst/wQZKiWLCVJPZ22NBCyEuZ44LUpkoU7fdjH4n0pcFVIYwhIE/pm5g?=
 =?us-ascii?Q?2K+Ow6VKL4nFaXBec55hdVskwjgjxRRF+wNMhE235RQ6WawQeB7jwOabyy7l?=
 =?us-ascii?Q?zfkDQLAA+h+qKsrOpEUT40Ji0hFZh8WcPyTJYRPivAGeP/EaHeJTnNJndMuQ?=
 =?us-ascii?Q?8Yq51KDpUEGsK8+ZjiCfnIiwALZTasj84GtjiPVUWFm/kf+mfRcwlJ5bzO5T?=
 =?us-ascii?Q?YlLYW0W+Jnz3hn4odmgaDXOBSFVKODrpG3sYKfCSAGbQwdsHF11x85lBFJE4?=
 =?us-ascii?Q?0kDsM/irQSw4GJGhztGPGba/+nf3TZc0f6SMEdJDUGG8/neodz9+tpDpNZ3D?=
 =?us-ascii?Q?CWlZoIV/I0V8j+Pr9wg/8ULrLsfq2BJ8pOEEMSVGcIOWKU9NisqLfoBW+3w3?=
 =?us-ascii?Q?cl63yyCOahvcpSSwR8KSH0ur1mecjtCiAGXDboMLQGpvYJ5xjOItCZilVbyS?=
 =?us-ascii?Q?fJ5UKFZSj+uTogB1+6TxJ0Zl9ld7HXYjBMem0hzRe91ulr34VFfxezo1ZOmR?=
 =?us-ascii?Q?qjFkkn6bvOK6izs9qk7PWcgNObm9PnuGxW6yzzi3nRbbtSpgTRg0lnM7F5TW?=
 =?us-ascii?Q?Q2gQSJpHrlKqFJmMC3j1fuB3pUMs3P4m?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 06:09:21.2649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd93741-b86c-44aa-657e-08dcb839cf8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

The Ryzen 3000 series processors have been observed lacking the
nominal_freq and lowest_freq parameters in their ACPI tables. This
absence causes issues with loading the amd-pstate driver on these
systems. Introduces a fix to resolve the dependency issue
by adding a quirk specifically for the Ryzen 3000 series.

Reported-by: David Wang <00107082@163.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 68c616b572f2..b39365b980b9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -142,6 +142,11 @@ static struct quirk_entry quirk_amd_7k62 = {
 	.lowest_freq = 550,
 };
 
+static struct quirk_entry quirk_amd_mts = {
+	.nominal_freq = 3600,
+	.lowest_freq = 550,
+};
+
 static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
 {
 	/**
@@ -158,6 +163,21 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
 	return 0;
 }
 
+static int __init dmi_matched_mts_bios_bug(const struct dmi_system_id *dmi)
+{
+	/**
+	 * match the broken bios for ryzen 3000 series processor support CPPC V2
+	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
+	 * definition in ACPI tables
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
+		quirks = dmi->driver_data;
+		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
+		return 1;
+	}
+
+	return 0;
+}
 static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
 	{
 		.callback = dmi_matched_7k62_bios_bug,
@@ -168,6 +188,16 @@ static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
 		},
 		.driver_data = &quirk_amd_7k62,
 	},
+	{
+		.callback = dmi_matched_mts_bios_bug,
+		.ident = "AMD Ryzen 3000",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "B450M MORTAR MAX (MS-7B89)"),
+			DMI_MATCH(DMI_BIOS_RELEASE, "06/10/2020"),
+			DMI_MATCH(DMI_BIOS_VERSION, "5.14"),
+		},
+		.driver_data = &quirk_amd_mts,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
-- 
2.34.1


