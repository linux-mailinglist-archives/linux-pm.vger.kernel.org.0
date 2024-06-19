Return-Path: <linux-pm+bounces-9602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E590F267
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08ED21F233A6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1371154BE5;
	Wed, 19 Jun 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bDyNZBWg"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E114F9F1;
	Wed, 19 Jun 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811651; cv=fail; b=lhnX1X7hkPu95ptSZihWbOdihvq4meDs5VVg+2GyB3sKZ7vgEUFX39fQ8T2HCu+BnLJi/cck84W4ynXjBrleyP7TzpkMmtMwdfNzjiYOnoHsvOHN4Du6V+O+AW/DKbqPJmczQgHhnCggpHLcbklL6UGnNSDv97dwxNOIKjkh1+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811651; c=relaxed/simple;
	bh=flulp2l17ZcMirBGjtuR9DGyLFB5qYQ1O9kTE/k2utA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+nwKQysalA+Hp2nsVE/d7lF7OzaxeCxScStZrNhOF2OOOSpljJtEz+y+YUwDorvuQHOtnZwseVQVh8QE0ghJ0E7DdVgopcMl5Cfn1JYstXi7GxAyk6e6Gd8Ft9LauSUuPyyZIMUySAWu5IM+DPtSon3u47ubyrJPJYuq8WFDj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bDyNZBWg; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4sBvEZ7P4zYukSopk05Ag8Wi2xLiFBugu27AYS3wOqD20cokc90f46PLUVNfqfXriNdaTCxarsz8/DSykHYoNDD9JB1QCkQgC9r+y9b7/fGy1bWRxSpjOvSBoApPtWsD/+zWnBaAaZAiN8zllSDem3/z1kdp5fqOrBG6cCAOaeMxHMMG21mmNY/jeNGQp7MIwhYUDh66X5JICNI1AuWDUGnuskoimJR5vk+y4FfwiC8O4R4S0zvXhoqqmqJv9hAxkifzi89ZhUedSFhxPOb/08y1gVr0/NyLbgq6J5k90g6pRBCiXHdI2HWlBrfNEsxYQ/oWz4sCiIVpyZY+wSwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBDCR8wKHm6M0ndj0xbQF2fjvAcPcwvYwUuQn5l17x8=;
 b=htnIDsRNBCzCpUK8c/oyQORARyazmjz6HQ8t7202zSDQoLRtEd8KBjnM1x3YE8/3DNz0xWDAXD7t7UD8zmuawa5+OIe9ucwumKRiRfgzw/cY6zIIdlLFXGkHsL6EKFvK0F8rGXH8yZEZspVWOHbSf2xzyzjzECzj6LDZSH08hLPifOvr79OwSGbRwvbIa2/YpVh0jDV1cFeW9+1UU98vO+DhKviW9XgzCJk+NTwCE0BBLeoIEkXwYI73OBfVlxmJCEtxlmUnlgCOGYAcx0EJ3zMdsupwjh8bbNmvADqmtFSmlm3V0zIUJWUgzCvPTxXdc2DVIsKWDEsFBN3H9hM3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBDCR8wKHm6M0ndj0xbQF2fjvAcPcwvYwUuQn5l17x8=;
 b=bDyNZBWgl3icgRmEx5PT9Ev1R8KV14Rc5WsK7KhQR06NC/3d86BJos/+YgbvCHyB1Zbsx17cBTaDRn1oj3shGMtKTn67XdWg335Gwsnwml90UFJnjZ9kXn6xQ1Qf1cjzkXDEXdemtiD15iw/u0azjA9z+mQfXAoizyp7K6Pn7GU=
Received: from CH2PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:4e::15)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Wed, 19 Jun
 2024 15:40:47 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::d2) by CH2PR02CA0005.outlook.office365.com
 (2603:10b6:610:4e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 15:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:40:47 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 10:40:44 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<gautham.shenoy@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/8] cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
Date: Wed, 19 Jun 2024 23:40:14 +0800
Message-ID: <437dbd581a4119465581330081d9b1e289482ba2.1718811234.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718811234.git.perry.yuan@amd.com>
References: <cover.1718811234.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e37403c-63fa-4a65-7e74-08dc90763090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kYGRR6ZbrjNzL3bsi8zufhUy/XSFIPkOhJf3ozGZaRrwGdzFM1X7u/RIHZ99?=
 =?us-ascii?Q?DIOhYwH1rxcffvvHQQrhA+yC060jL4VsZQLtMXeh1TILtpwPf2nQN2d7pQUP?=
 =?us-ascii?Q?dMzDoHMUjqI4kFEuXdfSIyiuZpYNX1ybnYuO8BeqNiwg55olA/1ILZyw+Ozc?=
 =?us-ascii?Q?0RYqHY5Y0nk9yT/k6j/C4NTpw5V2hVDuz5IArc8OsiH0T0b2EgTiL8d5Z1AK?=
 =?us-ascii?Q?ZVeyXXL+YrbfX5RYSHsUD9aY/M/jHgPj2E/B2rG/C12CGp+luSICmcPnMTG0?=
 =?us-ascii?Q?WubKZyhLjBFDMP2OxHE5vK+ihqILJiahbEsBq4r7ANnA2dnWhMlzsGC2B/x1?=
 =?us-ascii?Q?vdQqhS2mjrq27ulTCFMAyaf3cDWfsYTxJnQliKN1H1dw3kBsmEJJ+Y6voNj/?=
 =?us-ascii?Q?wxDLDbwNlbUJN4oMhzNXSWMDPgv0/fXmpkj7h6PjTfNiwdXD16WMLev3nduM?=
 =?us-ascii?Q?Vuy+Ra50CLMB2T0vxAtewVaVEDU6p7U+HjCamCRWm8bK9t/kYIkyCZMQ24Bt?=
 =?us-ascii?Q?oVO7viKmp8xC5+QNOCTwy2Xhj95emDoD364yWXLFnb2gdIVUXVPeWo0Eq+z9?=
 =?us-ascii?Q?JN6FZrpQF7MHzbag71PbYbz1oflESP9mCqwhplN6Oz6lw3EAzVJPQ1JZJVR8?=
 =?us-ascii?Q?XLgnCBm4FHTzpiybA6OJ7WlJidpvz3yj3qFC041rfd343b9gaJ7jj96dToRh?=
 =?us-ascii?Q?Dmmow3Xel0pFtlmV1ErQMwuzahE3o2rsqForUqszLYGM4C5u/3i3ySPGohf7?=
 =?us-ascii?Q?I3LK77IwyDtaeJgEfIIT7uWKNo6WuX6DV7wSZIHp3HCO1nHoIVJMfS3/h9kR?=
 =?us-ascii?Q?HrqcOcUJAEs6C2qXjz8AeMOhvBdnVBCAcNXupHPVoKuEyiNOT+KkiIi6cfWG?=
 =?us-ascii?Q?zB0MtgfceB/CJ2cjnmSLF/fsl5L4zAPkZRn7965QtUU+378rzYWG0ZZIUdMa?=
 =?us-ascii?Q?Lt8wzNkSn1lZJtQd4fCrfQ2Z8+/EIYFCCFDgKw1eRwKcDA0VDlhd6lk20P+U?=
 =?us-ascii?Q?eup46dCcqXKnv9Ks6/h1Ky6SITNr4fP4NOi+/RPB3yZlFJbhgpvm4QcZdyxn?=
 =?us-ascii?Q?8QG5SgSV+AJjYKTWCg2ThfF1sUKOLvJbx1PNzq5QRJ6qUf4kjgzK2S6l1E61?=
 =?us-ascii?Q?/Fz5JmBe/QzQH4/YO94R5/X8Zrkpfvt6G2dZPQ82mkwE+NmnDKkXRlVv5ka+?=
 =?us-ascii?Q?t9wv8XnH3dvVR4KOXvjOhE2Q5j3JQiEVb6AyDjXTeSrOaMJzJsMj8wWfoRMI?=
 =?us-ascii?Q?RiqRYkjWg+j152z8Ux4rynE8YXf+GE+eRuc06wi6Im/XTRifplg2H2f90nL6?=
 =?us-ascii?Q?PsOUQugMBouTn1rVj9Xh8nEW0ynaoFVqXxJvf/4p/URUP7uPkQuqOK2vyQqh?=
 =?us-ascii?Q?cR8Gkj0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:40:47.4303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e37403c-63fa-4a65-7e74-08dc90763090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

Add CPU ID checking in case the driver attempt to load on systems where
CPPC functionality is unavailable. And the warning message will not
be shown if CPPC is not supported.

It will also print debug message if the CPU has no CPPC support that
helps to debug the driver loading failure issue.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/linux-pm/CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com/T/#t
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1ce063a22214..76419762c04f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1743,6 +1743,20 @@ static int __init amd_pstate_set_driver(int mode_idx)
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
@@ -1751,6 +1765,11 @@ static int __init amd_pstate_init(void)
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


