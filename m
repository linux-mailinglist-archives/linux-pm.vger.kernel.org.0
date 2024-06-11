Return-Path: <linux-pm+bounces-8925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7770D903777
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 11:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2772B27167
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43317B4FF;
	Tue, 11 Jun 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oblhHj9t"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D1176ABE;
	Tue, 11 Jun 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096001; cv=fail; b=K6GBNYkq3+pUh7pEkSbpR9foPXuOrC/GKywXqgHIdxAff5peNI50bYfzjbM+DM85l1f1TTJWzpuRXgIZpvB9L80zxC9LNaWKkdvRL9ap1zsoM9tEWzQV25EvqzIMs+esARiuPVwjWx3g78EsTkhA97WLUzjOUIJxp2Xu0JOUoQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096001; c=relaxed/simple;
	bh=5FiSM+uQeOZpz8v498h6TTQvnoVU4ruREKDIyzmEzCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n66ILshhZkxVS2TSZGh61x0im4409wVM7hQRpeNFf0OT0ddJR+KNYzVUvYnAKuh7/7xEXljbLFUiiFw7I9box14/zVzAVNQ9sk4j6BPMoSOJv1T6/+Ju0atH0XkCwbSoi4TUXLGEpGPQnJrB78K5RZavs5dQ1PBrQiwdS05/hoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oblhHj9t; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYWf/0BcmdA2R17Kx6NSk/qMZ9RYyD70TjJu+sY9mQb2TatiqSab3BoXk+eVc8iqqprQbOznh9PRHfMcKzM1agQmWRNTyuN/YM7kJRnRX+SzA5jgNfi/qAQSrT7kaiwTUFhKlr3+Y771M+UWQW96tNPYQb55jbjvZBN6wbvXY/vH978t52G72zIsNgkK3ySvuIBXL3Eh/6eJpbIO516b9THbmdeKbbudQtrnK/Zqq/XzBqw4kouhwbiF9qrHwCLG5FWfheWvnzUGaUZtjZLb7xxnqUrjpwUClw+dg61gmVqj33qRk65jytZSdSuJMGyxldGFE7Vv3jVqFLFj1W7Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQyzJaOne+We6n1n2nOcSNThxpN75QCZB9oSmSOaKKg=;
 b=cRbfxRYdc+3D/vmQTO3y92174chcpOL2oRmaRUUmU14QDsLtqEMAR8vDRJuyXdfz6hOHO+Wb8UeFjQFnStouJQCpYjd8gmlrimvcjwxx9hgfoBDPHDREnzdzXwpht8+dYO2QftQOf6SSsdnak2RQGQfmuSNfA4dk1xtUdQgC75+s9M7CcEqgCDyzF7CKA2bCXllESyALULYb7hvgySbxk8e1K8xbpCnMo9oUaIKTUblgbx+N68Hm7F/4krWm/iuLBe1CoLo8bkG2/Ddx4WS37bhrtsRC682rWZ2qY7FARI4+Wk9TZwODGVgTfVUnZkzmQTbmjVwM/2PJL0OvUGqrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQyzJaOne+We6n1n2nOcSNThxpN75QCZB9oSmSOaKKg=;
 b=oblhHj9tCVBOyjFNPyNvFuiV+l1DhWVwY+2XMbUcYS72PdOKyYgf+6B2keFRi7KFThx1JU3UbE2W0Gbri0vW/Av7rJjcCeTBIbByHVqTHbCOk1cPjXuPydaczQQsAfMs1pN3lkXhxmln4PdWtnZmYcGi/ikFfhURT861ivCxjIs=
Received: from SN7PR04CA0169.namprd04.prod.outlook.com (2603:10b6:806:125::24)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:53:17 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::b7) by SN7PR04CA0169.outlook.office365.com
 (2603:10b6:806:125::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 08:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:53:17 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:53:13 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 10/10] cpufreq: amd-pstate: automatically load pstate driver by default
Date: Tue, 11 Jun 2024 16:52:26 +0800
Message-ID: <39b55abeb278d9ae1688c0b87cb7ec8a3e37932a.1718095377.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ebc321-1c81-4239-1339-08dc89f3effb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQmjp36itnK94Lcc42GJ5krlSqcBSqFq1y9KAR5FhMi4PxBqdDhvBTHHU+t5?=
 =?us-ascii?Q?25SzsqekraIbfZ6CrifPiUNE6+Rkcb49QW2mRuGisDVvEhqjNo8tsZ8XqjWE?=
 =?us-ascii?Q?MfivLxYroPvkpIZeFE84YQEuw0x7D0x84FfoC4tUS9TKA5mTw9QhdkRmorFT?=
 =?us-ascii?Q?SaM8oeYYuqFBXWjuGMFGbHQsaGwKPhn8U0Tn5lBga4rvyxcRTC0B7s6UHipf?=
 =?us-ascii?Q?kYCVJUR3AhU1xW9B6MCraWugAG+W2DhyeB+jfmrHmWx65bQO5bcYMSEcyYjw?=
 =?us-ascii?Q?RH1lhytQIoU2XwXH+WsFx0FgdXt7sL8BzbGcJKWDuABKxM4FYf9w3DlndcuJ?=
 =?us-ascii?Q?w6lkbDjfsfyeAHtj3i9VX6cmStLNHaBAlm8Jlmw6ZFJHs8lQfgdeoe7TsIDp?=
 =?us-ascii?Q?opkS8qtaVVad4mc3vltSTYM/ejwofs+sfcdsYC5UXiqvgdym6SR1Wgmf3Z1m?=
 =?us-ascii?Q?uyQyAkJ8vIyPGUZmAa2mgenhVNigNHwaNnhIoP89HRXEGa4xxvR6Vf6A3CpM?=
 =?us-ascii?Q?UjIB+Ami7ToxFtxd9v4ggLVTsxzWfjCHLqC/6xqf+OkkfXDucIOItzX78Px8?=
 =?us-ascii?Q?3gGk/bEGbXRRNgN7xoq+UO2sE/UBOH+o1mAivFQT0oJtjDCaZ0krJDhHVpJx?=
 =?us-ascii?Q?Te09Rpu1IZZQpxddzHCZuSW/1YK8xRffii7fVIrgtTBhPWZDfRWfSjGO0974?=
 =?us-ascii?Q?HU+yROfMYPb9TTY8Aqs0t8e27jRtRL9nuNSa3p0gyM0vg/GaX7oCn78HN1YL?=
 =?us-ascii?Q?0WIVhx/RSfM6hbpEo0JYFqIS0gXZqj5NsFMSOG7qqkKx0ExX2qrqvE6yu9lH?=
 =?us-ascii?Q?LlXD6SuOMZA/vgPFQW5PaPfk8zW2k0/2wrVhJhKoBUTI+h/t2Lvqq+jkdDVk?=
 =?us-ascii?Q?iEMlyjg7NSFmbzVT2TPYplfsc2rGeR/oRS0KHWT3BrDFPOflBAS0dXBu7DBO?=
 =?us-ascii?Q?bplOpKvsrWbXyXkh4sYL+NzicK6o7ivAV+Ab6sk1ipbx4kxkOMfF0XkMq+nL?=
 =?us-ascii?Q?NiNQpLA9hUwg/Y1Nxob2HMQqSWDDiT3JpG7Bo8Ce+5HK+0jeiu9w5/fUUlGE?=
 =?us-ascii?Q?EKmiZi+Jle2O5wMO7AapcgFUzL01tGnZwJvBrCp5Mlw7FUeFDUgrIxu/eoAN?=
 =?us-ascii?Q?RrW6narOG1JNQxQQfygWY1q0LhPEsSb+Kg5GibPxaFRqnGPYXiS5UzHYWvNL?=
 =?us-ascii?Q?xAgboDtmvTHkG8i4ZgVGjfPqr/PBnYh0J2SKjHbonqh1KI3rURnRTVm6+W2Y?=
 =?us-ascii?Q?K8BajzgK9OnBOIGgfeS920I41R4INO/RQb7gAud9bB0jy+qOv34kkXkUSGfY?=
 =?us-ascii?Q?jQmGcFk307XV/rPFFdIpODmw4Trm/gZzY7HlP/pvJThHetvuoA0UyU+0QteO?=
 =?us-ascii?Q?zWEpvHE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:53:17.5253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ebc321-1c81-4239-1339-08dc89f3effb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

If the `amd-pstate` driver is not loaded automatically by default,
it is because the kernel command line parameter has not been added.
To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
function to enable the desired mode (passive/active/guided) before registering
the driver instance.
This ensures that the driver is loaded correctly without relying on the kernel
command line parameter.

Meanwhle, user can add driver mode in command line which will override
the kernel config default option.

[    0.917789] usb usb6: Manufacturer: Linux 6.9.0-rc6-amd-pstate-new-fix-v1 xhci-hcd
[    0.982579] amd_pstate: failed to register with return -22

Reported-by: Andrei Amuraritei <andamu@posteo.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fa486dfaa7e8..6e5c398810bf 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1841,28 +1841,37 @@ static int __init amd_pstate_init(void)
 	/* check if this machine need CPPC quirks */
 	dmi_check_system(amd_pstate_quirks_table);
 
-	switch (cppc_state) {
-	case AMD_PSTATE_UNDEFINED:
+	/*
+	 * get driver mode for loading from command line choice or kernel config
+	 * cppc_state will be AMD_PSTATE_UNDEFINED if no command line input
+	 * command line choice will override the kconfig option
+	 */
+	if (cppc_state == AMD_PSTATE_UNDEFINED) {
+		pr_err("pyuan cppc_state == AMD_PSTATE_UNDEFINED \n");
 		/* Disable on the following configs by default:
 		 * 1. Undefined platforms
 		 * 2. Server platforms
 		 * 3. Shared memory designs
 		 */
 		if (amd_pstate_acpi_pm_profile_undefined() ||
-		    amd_pstate_acpi_pm_profile_server() ||
-		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		    amd_pstate_acpi_pm_profile_server()) {
 			pr_info("driver load is disabled, boot with specific mode to enable this\n");
 			return -ENODEV;
 		}
-		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
-		if (ret)
-			return ret;
-		break;
+		/* get driver mode from kernel config option [1:4] */
+		cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
+	}
+
+	switch (cppc_state) {
 	case AMD_PSTATE_DISABLE:
+		pr_info("driver load is disabled, boot with specific mode to enable this\n");
 		return -ENODEV;
 	case AMD_PSTATE_PASSIVE:
 	case AMD_PSTATE_ACTIVE:
 	case AMD_PSTATE_GUIDED:
+		ret = amd_pstate_set_driver(cppc_state);
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
@@ -1883,7 +1892,7 @@ static int __init amd_pstate_init(void)
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
 	if (ret) {
-		pr_err("failed to enable with return %d\n", ret);
+		pr_err("failed to enable driver mode(%d)\n", cppc_state);
 		return ret;
 	}
 
-- 
2.34.1


