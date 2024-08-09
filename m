Return-Path: <linux-pm+bounces-12025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4EE94C9DF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 07:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B42AB24854
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 05:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6A16C842;
	Fri,  9 Aug 2024 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dTKy1jfc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830534CDD;
	Fri,  9 Aug 2024 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182658; cv=fail; b=MDzUvZZl7i6QVKecpXNrJXbX0WUF4uCz3eznOhJ3wMDqRpCdABJMm81qiihgdn2RoeccBOsiOvZamZh7UIFnVdIEXHNmVY6B7imEVrUsgrdtuEfilWf7KIw/ZQHbmWFecD5LZ0SQ9ixysswxgW6x0UTVQr6oELmkD8SsEZcs6Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182658; c=relaxed/simple;
	bh=UrnCH11idcJnzVSwNIYDKEmOmBcygJSHMmxt2fy3U88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mc7ZSgud3uQe84OehxK54MvKf2KIFZxMoFqxRZwzLJyWyZRnF4yJGwBKiOIplfH+WYJliyBREDjxzJ77j5JydiWguUPl5/Q40c8Kc9BGz5+SaavukgDVNmhzO/VqgBvW4wqi40ZlY3B9AjJSDwtKTgobaGnaIG7RFIEs92zOXQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dTKy1jfc; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLMLDoY0G2nAO/jKGNsPcGBS5yMBAHlb6QP6aPeHKTlL0WZk2LAImcUZ+LZmrxsFokCXbXgb/YOejETVyqDxWZEkfWREpUL1tLj5OOqoJpzmnMpPjWbP23DVYp1tqnUOZ1y13M5IrLmFak4zAy2N77ijXVFooXByLU21tLNpPKQv8rX3wpwmsG+7znIzPBGV9CTa34f7avx2tcSDCntJ+eAnozW6Rt0x9D+5LyutvIkXBg++AL+AwMVnnEZlbVjWgOS+9jLIw7xPkFjD71VfbQO2/I/MSBVHVr1+/h1NuC36N8/T28/tYjV1Rtot4pmkrd/uothH63GuXGt6xQtAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQX00fxidpyK91SZHFqAZGBmiXIZqpVfcMVx7uURFY8=;
 b=OWQd0WiralaDm2TDtHRY3jTnZ34Uvn16QwqVwJCIRpZBc3JUW2ahO6dtqKrBIEvcE7CBbLTXsYZ6BWUh0zpvek1dxwRRVjM/F0YvNTNmu0VB/yJPJvwrlsKUvk7L5+A35q7J403HASHglTwLbIWzF3vPX68lCLmlnqEU1lXCbIbqug6gyuKgAF+luefSUoIPRIZOyJzcdcaNAFqEishYUrA+WMdSrf54suUAJPeSrqzAq3qNtxiUULMVWMOOpgnbjJv7lJEXq9aQuZwYc/p6yKBrjUT2Lqj2Z+7uUs9zn/mD7fQN3N5VIFZW1kJ06IHpAzZ9QwVnZf1+eDR1BHpRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQX00fxidpyK91SZHFqAZGBmiXIZqpVfcMVx7uURFY8=;
 b=dTKy1jfcG2LUIlNZGuwOAhalHhnvGfrhIyaXwvU+56KhZZAHw291F9lN0ZWgZnXdl6CCdFYda4ASwP7wxbYgQjt8P69sRctw3VtjJMC6gA/2EKoFXCH/HnlJT1TTI9ZbP+lTwvgL2fQp0ouD+Lh9OkVu5YgWgXQEhD/n1w3p75I=
Received: from SJ0PR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:334::22)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 05:50:53 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::a1) by SJ0PR05CA0107.outlook.office365.com
 (2603:10b6:a03:334::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11 via Frontend
 Transport; Fri, 9 Aug 2024 05:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 05:50:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 00:50:48 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <00107082@163.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: amd-pstate: add quirk for Ryzen 3000 series processor
Date: Fri, 9 Aug 2024 13:50:34 +0800
Message-ID: <20240809055034.769443-1-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: b617648e-9775-4c64-74c4-08dcb8373b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ER2y+8sRBdFdXfkzatg7PaLBjjl3FpjkR+o6WiDghXg4W481ttvXwmbSXTYh?=
 =?us-ascii?Q?hez6cEiokZPHf2M+/g3gqu1tWQGYBxV9XDiUvyy/VC7ISUWX3cOXEGpcKWVG?=
 =?us-ascii?Q?3UJT6HIBuJFc10Bt0vpWFqW65cmqGizVuSqjBqwVxb5RtQ+IFdV8dLYWGptc?=
 =?us-ascii?Q?MnlvJBRHGPhq/gROnh5UVIBlXmTyK9D3WtcvogP64pIchw0FgenHAMlQAc7+?=
 =?us-ascii?Q?Cz7HKwn0V2Eub1Fy0NlQAOReGFvtXC9R2Hbcdf/s/1JJ8sw3Btod6DWurIsY?=
 =?us-ascii?Q?7QBbDtbeCWdm1Wi+ccQxDLh8fg1m1k0fWoy1yLYH3BMOLNSwdHSbVMOHQj00?=
 =?us-ascii?Q?21IH9uab7T6ag54w1UsZvvcXDq+sHhSx5naF7GCB/Mn5OEQR8goj51gkI1TO?=
 =?us-ascii?Q?TK3X6VqijDB7Gf1wX0H7Et9BGiNclvTCQR+maVViuA5Htg7G32VtT512Gf0z?=
 =?us-ascii?Q?qD3xuH5ShsCUHxi2rBs4W4Qgj90CzL5MHy97l6bipBWU5uLLjQqq4Au3G1/K?=
 =?us-ascii?Q?7+n6nk16HzzuTOZWkjd6e48VcVbU7s+8n2JfxLgJ81ANbOllUlPIX9i+pMue?=
 =?us-ascii?Q?AAGA3tumDz5C318QpOEDHslZIXSv66YCW3QPmazM1XC27heNljUbBp9xb5DF?=
 =?us-ascii?Q?Ew59/vummlvOystYIRi6x+2hpOQdjuqYLA3p7C1TdJaIGTntr3iL/7aGlUHH?=
 =?us-ascii?Q?Nm1vfpWslSsjkhFhPFcrpTSqPLo5RrEPMjo9YuZLmCBU8DC6TfuVOQLrfmdz?=
 =?us-ascii?Q?IXY0jOM08cjKFq1/E23Rpe3cVMqb/FWt5ienhW3YYRAbbNVC2pCTV0wtwb1e?=
 =?us-ascii?Q?LbNcap0HFcbXdyxbSwUaWVC94+oKOpHjqdDwcpwHK9y5bpMyCd0pL7aTNv1P?=
 =?us-ascii?Q?afKz+aCPaTqi4huIiL3bLI84D0gISiAzzPWXQ0ahHqfqCQ8YSR1C6r+Vmwm7?=
 =?us-ascii?Q?dzP619n3nK/8pMFo8c5JymubRG2FwuSAZZGGeq4YqmnLblTZjvguqGT2yE9k?=
 =?us-ascii?Q?ztsnCSxa6fYcbRGyMdOuWfsbCM40vyID+aNEgQo2SOudsgpZZVlm23juwcRI?=
 =?us-ascii?Q?GI2S48dJMqQQQBwNFLo/STowuhEV088lrPXtThcYk1+ys2XaIrputUC4I1II?=
 =?us-ascii?Q?8ViMKON4vBN3NLRCX4nqRhYchMHqDI6IzBB/EJdDVwOn0qoSpmK33qckm/3C?=
 =?us-ascii?Q?MxLb/fEIEtuM/gNbH4GDMydQYO1KwWu47Fy+UuOzTQlWMSs/306Gha+zI8jp?=
 =?us-ascii?Q?Dfp3k1YFamfYnGO5Sakw38sIQlX4hMDs6hSbGWXHaaPmLpBap30d8ZOu5MVb?=
 =?us-ascii?Q?DU/7xDEUiE0DHjwq/hdnu5TUufZjhyeCJC+gu1e4JwYtcoIgDYwzDE+kNOpY?=
 =?us-ascii?Q?T4WzAlTjWvaCM7jQIv661TOqSg+af2uhmXAZovCZDzOqPvoaQgOQijwT0thR?=
 =?us-ascii?Q?fXvkr/XCCZ92RZRlcewzQqr2nTYd4KEn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 05:50:53.1760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b617648e-9775-4c64-74c4-08dcb8373b11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461

The Ryzen 3000 series processors have been observed lacking the
nominal_freq and lowest_freq parameters in their ACPI tables. This
absence causes issues with loading the amd-pstate driver on these
systems. Introduces a fix to resolve the dependency issue
by adding a quirk specifically for the Ryzen 3000 series.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 68c616b572f2..07d26ae80454 100644
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
+		.driver_data = &quirk_amd_7k62,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
-- 
2.34.1


