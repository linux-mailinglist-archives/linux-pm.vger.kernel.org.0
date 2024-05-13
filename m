Return-Path: <linux-pm+bounces-7749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F788C3A04
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5120D1F21145
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E295136E2E;
	Mon, 13 May 2024 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xXUeI/40"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493884FCC;
	Mon, 13 May 2024 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566084; cv=fail; b=P7L8za1NQ8UjX5dirAVXQvbAQNSsvSldIzTCZ6zwCF5km5GqPtl1/fJxop19wwg+pivZ8X+PKxq9yMdr3oXtqsMM5sHLFB4Pf8fUf8LkpeRGsnTOlKofYlFN/4pPQrW5/hfmqYbcIYuB1OHPxBQ4yM6ksifZRtvwOdSAt/uLjuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566084; c=relaxed/simple;
	bh=Ul/9XVgf5jjdqWmqsUG6M+mZ52ltx1t/l/OcVWXeaNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C012w3So9FqHjuUIZIyqTdn7giFr8qNJ9FzJHnjwgt3Rq7mEZj/RVHabqP+8tX3Bzx3NbdVM0bVf06T57AbdPlqu7pLiabGV201NrFT11J3NEkZsf92tb9KRuiWTFwZdVqfZ+qUMC6BoctC0qn8hplkN6FTF9+w5QEax7tPaakM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xXUeI/40; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR1wwOItoOLerwpKlKbncHsHUJ1kClkK7YkPPwQF0EojWVKRi4Jo+IFmcd4LSC0rsdhY0sBFdL+Sk6lx6ecQJ/SjAxbVKOz1Tzwrbb9SdOu9E6bwV3BkdznbQGrNUtCi2dx4+4T+0yBG7NOq1d+Cmt8gkrpdlcTZRD7W0uWDtB2GQbuuSZlxcDLJ8FKjpjkHyXzXdaLO/hWJgfZu/PEni3Pb5Iwe9YRaa3CMPNBeDEgac36Ct9G6dcliJuVR7M7RQL79SjnZXzLhDRsQGja2DRWkTvInX6C1+UgGv8D2riLA1JlCJ/4Qti7Sm5b+AdMMvSdDh2x0qCJXh36IM24hog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLaouRC0u3QXuYxR1X1EMPN+zYuOF4vcWyJcSZdkgIs=;
 b=Q7hW8NqBAUb07kVqcZKMNI/hEmwiy7hddGFOimbkYQFfR1GszRZeC6VGu9JXbgHAOZkjsTRPIzvoknhS0rkTU/Qy9HUIoPIf/UjfUVJ48SslY0oMPJbFpRKQe6SXXwCuO+ftI8I4qG3oAbq5A4wZ1X8gJobexCMLlOcwhy4rDTJSrZLi8qkNg6Kw5P2jLqq7xCBrDydQ7BW8X42rg3dr3mRbSdmfTuuT7AFCri9O2JzlfEn5FApsJr5jWtMmm4Fe5vuhfeo4372UTE2zk+EAkdsmGeYAmdn91eniXWXEvWuOu9qpqX9y4BbgdZUOVrrMmMQ4MJ87eUFjsUmmRUJxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLaouRC0u3QXuYxR1X1EMPN+zYuOF4vcWyJcSZdkgIs=;
 b=xXUeI/40cKHdTKjleMLgePtt7Hia39xn9gsU3EpuhDFyQEppexqRG8pNQVwmoiEbm6U0+3SK9lF1mNDGCtUrtqTgNfgZfPGXDunCbv5G0zqfWG7gPI1K4eTC5+jzLU7i0QklEp4xeMX15YFiElG7+FqsdscV75YW8Zlypc8udAo=
Received: from SJ0PR03CA0095.namprd03.prod.outlook.com (2603:10b6:a03:333::10)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 02:07:58 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::49) by SJ0PR03CA0095.outlook.office365.com
 (2603:10b6:a03:333::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54 via Frontend
 Transport; Mon, 13 May 2024 02:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:07:57 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:07:54 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/10] cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
Date: Mon, 13 May 2024 10:07:21 +0800
Message-ID: <e6132ee6b6e3c3db5cd9c1e8adc0777881bd2cbd.1715356532.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715356532.git.perry.yuan@amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 195d5023-3367-4ad8-e25e-08dc72f18262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m5XEZAphyo8L7sYuF/YyIwHpxsE55t5KAv/Wfl1nDh0s5Da4ApdFbO3o67ue?=
 =?us-ascii?Q?+GlIN3VcF02DHS2mtAfLBqWYnQ8Xua29wf5LNXkMepWzgZh8So64IhFf+c37?=
 =?us-ascii?Q?80FoYs1xX/nMYYE3NzC7/+hVmW5t7l2bCEtroiIryg8SGE55x1zuov4YVzrn?=
 =?us-ascii?Q?oUTPb6O/J3kk6c3dxRheJx/7HgI0dVMnBwx31HdONxpvV1yUBr38SCqPk2mk?=
 =?us-ascii?Q?RFXWNHb8+gOaZc82DDM2+a8TsEzProF8DIRkAtn8N6SmDCTFft8SJHXu+h8D?=
 =?us-ascii?Q?4cU7cyuquZmt9aX0noCNZ2cnmdZPng4Vgv5DFBWC5J9xB65H48XiWfrqrrhq?=
 =?us-ascii?Q?UU8p49r3LHztzYF8lzIGRkO5vBTquMNEJReLItaX63jMLsOaz0UTFFDITC53?=
 =?us-ascii?Q?LEH5TEjNJJmHw9VJP2/rmcJ1Q2vuMP/QyycUB/PAfdOWgRVsXeuu6vFr13sk?=
 =?us-ascii?Q?sPoo3mNvCjdPTLIs1XyYr9V+g8yxkLxy8HoeWFYdqjjal/RqSZCygWtkkwm0?=
 =?us-ascii?Q?2q5BnP8c+5dqqW8cY5LfJA7AjfzHuxMD7N/GsblHcsydopIk6al1xzsn/Vks?=
 =?us-ascii?Q?Pk1F4fY5tYfeP+nr0LT4tKRDSnE3OToIpEIw+BwzWy4Hq4puctowuE9wtha4?=
 =?us-ascii?Q?yzNvSg1WNjkVX8jHH73HVUp8JhvN0a60A4yNwakq0HoFow5kIwAFXwm2iikt?=
 =?us-ascii?Q?va3NfVlCLMtLpgC7Vd12vc5iEMl4dCZeryCK8sEFQs3zjtjP29O7R0iWIe/7?=
 =?us-ascii?Q?pOL7ZqSemS3XnYwi4ixpLTjWrhwZZwGQheCfKyT2MtDyP5F0Fl5mFez2QvMX?=
 =?us-ascii?Q?jqHa4T+mWJwn4t2+MT2a7+STIqQcAexHxuxKeZQs5ZF/LF3egKGaB8aHh22B?=
 =?us-ascii?Q?XceR/1sHIbV8C1kjL7yLPpQZ0RqRp/ExNmlHRGeFcta9crRogW/FBpgCCspd?=
 =?us-ascii?Q?1uoPmNZTCdBSj/M/b+nURu87zkZfxIve43PrE+NHeh5jbQexP8dmXueC1VmG?=
 =?us-ascii?Q?8y8Kvc0IL2xrkm+Zadur/piDOIO7PBBtMpZzZDINAnNUeKEl3vMjh9vRBKmS?=
 =?us-ascii?Q?34bqvZEVMjTa5eTU0pfqqj3ElAL8duwoTXA6YsMhsoFRUFd4X/Vyk0K+xfV+?=
 =?us-ascii?Q?HDeA7oI6nWs1WDf2Zuyi7hyKOCNes0jb1RJ/62Pbw0LH+96AbBSGS1/ZIhih?=
 =?us-ascii?Q?IqfKJ0DByMd+c4rIh/WGrRlmzziyRl5MbG6r6lKwdzYgHTCjBASHVj52v04d?=
 =?us-ascii?Q?hjO3N/bvsZpo+Uy2L/kdvycTjlj4JClF/qx2wUu5n4CiUuYGpqpX3TrxV6F3?=
 =?us-ascii?Q?wSm6Tcij4tC8+F2Znlntm4zZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:07:57.8721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195d5023-3367-4ad8-e25e-08dc72f18262
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

Add CPU ID checking in case the driver attempt to load on systems where
CPPC functionality is unavailable. And the warning message will not
be shown if CPPC is not supported.

It will also print debug message if the CPU has no CPPC support that
helps to debug the driver loading failure issue.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/linux-pm/CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com/T/#t
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ca22e94f3f3..3109b46fb02e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1701,6 +1701,20 @@ static int __init amd_pstate_set_driver(int mode_idx)
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
@@ -1709,6 +1723,11 @@ static int __init amd_pstate_init(void)
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


