Return-Path: <linux-pm+bounces-7756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3318C3A12
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF6D1F22914
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A4C139573;
	Mon, 13 May 2024 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sNIqxyVK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15313956B;
	Mon, 13 May 2024 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566106; cv=fail; b=SVssFx/UBivOc7wkO+QlPw8FJv+lhjO6GznzwoWwXpRy5X+JEqSwKWMH8c0MyV3PzJD98nIUYwsECKvKtQTzmWFFuwAmWYkXVxY/IsTxL/+a2DOHk5gexXiBj8gRhKN4W6XWtpOecJ3Hm6HG3iSgpYuABnNxPhnFVa5QXH/qpOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566106; c=relaxed/simple;
	bh=xOX5/jL71gOPe+phHcmMOPqzYt6IMtZWbvbb1kZ/FrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmJex0h7Fq3BYt+BbUBTm93wdp6OQzI4tHgnmWIxFA9MZW0ZJjkfbBeidjQyTGsJB+1blNFKLoTiGm0fOMw0uul1qtPjLeuEchFqjxso3FlcDo/6XLiHQ+cxSwWudVM02qM580Kb7rCYPtJyHyRA/x/Vhy8Hizx/4lrdQog9Xv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sNIqxyVK; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSA5QgoJfcbXJi2BzcZ6a8J0tN33Cz3sT7lQvl72aKXeN6CZ8jR2fUKSaVr2umsZb0RRPsWUepwFIsrHEP3OwBiZ87sR1hZ2Sf0pN6AU2mM7sZs3c+ErWQMnf4mkGFbTN4sqTwvUx8xxlO2BUMUiDHobMKNiCOAMYUL5Otz2JI4lxCyO0y25EgN7yZRQxcPd9V4B9pXEpuKR7SkebKSjPTDsoTpclhGa42grrEYXhURChvBkCf5VTvLFsXwS8xKTkdHodG6je0YOgQwD68eJK+YxLkCA1IBF/EDNMQRlSjjyqj0d80hyafv/DWrRh8qZGbdtwkNgc+6b9Pvj/UAfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FAyYt0HE/cZUL1eFC7ZRF+YdqP/UpH2iZS9/18ppi4=;
 b=fY/9/QJlnJgQU9z/FT2vXaquBgdfjyVs1+HaCK2OMCd6zml6wUVqJxZn8lP5gegrtNQ1kh15a1xCDVFOwBhylnhr9tZ1x9nYyhJnV4UOITeAXFGtT9kYotbu2Oy7DQEgQvvOllQwEfWWq2Lt10j+t0jqhGXGYSV63tf5cA6aZdhraYzQJ/eQI2eyp5STKJUd2vBmQXlYW6Pl0cbMiTPG+N8ka+SLioOZiUpa7G9046cwHQPQ+g8XS/KTW6Ou0EnJzaV0aZQ9JorPzEtlqXqzfPviiztEaybfZUZ+pG0bm1YocU6d5oCvn02uCv2riYhuA6PzLhzXYizgmA43rNqesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FAyYt0HE/cZUL1eFC7ZRF+YdqP/UpH2iZS9/18ppi4=;
 b=sNIqxyVKzzVYwwFn8I9+q1GGV7XxHMkwyBRPrfb7DCz/ZqMT7Q+LaXpdfhYpfqtQFVSQt7cfQJtWZ8Hop2KXXqvhpGnvCpMd8UiSr45B3NJvehyZuAvJqNsHXvlJsXxqQUtroC/NVY4A15iGPVm2D13X+PtUJcLS6Jo0FTe8RhA=
Received: from BY3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:254::30)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:08:20 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::bd) by BY3PR05CA0025.outlook.office365.com
 (2603:10b6:a03:254::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 02:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:08:19 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:08:16 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/10] cpufreq: amd-pstate: automatically load pstate driver by default
Date: Mon, 13 May 2024 10:07:28 +0800
Message-ID: <9b31fbcdfd4e4f00c3302f45e655aa43589b224c.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd7070c-2e07-4dba-d49f-08dc72f18f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IrmaSVe3lV6SjTM77XFP6Te4PLy7SG0Yd7hfArHutkNZdFQJD45tBmx8430Q?=
 =?us-ascii?Q?GaCcEEbLR4XahUt55Cor4bIlKmitnOd5vGHh/Bk7KtYbA0qUdgtFeBkzD+oV?=
 =?us-ascii?Q?AKaLkpxlGm//rRyCfcf/3+dcRLn4Y7fuRTRy/VbrVyGc6/t4jqpk2CbKg1mq?=
 =?us-ascii?Q?Igt37mZzqxUSOWXHRvICzSU6dOVBNQaJ1/Pf4COboxET7QLsIcmieEk4onPt?=
 =?us-ascii?Q?5Q1FjcWOCPH7goIVIdgEXkbxa60Bq3RNiU61cqsTVrGOE1eZX6PBJ58IbjdB?=
 =?us-ascii?Q?0PIZjseWhtelRymqWRxBu3OisEwRZoFm3AD+XmrAPaQykPz/AGI/i3waK7fi?=
 =?us-ascii?Q?Ojf4h5FXTza8Mg7UbypV4UTncUJWp9JetkeKJZ3hsPcLKYh3jBBSuYmuo1vm?=
 =?us-ascii?Q?7UkqsWdKOp/Oo7luuA7Kuhy1Hx19lshp81SZLTk31uR25dCNJzidvV2XazBe?=
 =?us-ascii?Q?pQ+W0PpEQfEJUb5l8ADUH+ENeOdMi+HjOdyE4c818gnKA6xaYpqebnHA9g5d?=
 =?us-ascii?Q?rhPynMeC/zQKgNiKsNc2OyLWMldXqa+IObiPvPJ0S3WkS15c0fQNsCYgzcbC?=
 =?us-ascii?Q?Cd753UdTBCNgQf+J+WpIfPAXslWilgymFLwtjwtuIG6U80RssUUfuQagwuO3?=
 =?us-ascii?Q?597BZvkR0sz24xvQIrsBtd5PXN7fHopRtqjL8T0Y4+Oj/zyAxcOT55BuPelP?=
 =?us-ascii?Q?ErUkXmNfIPorU60s4yGBrROIIEfWxTKCk74GBj4GGQTdjJ5WTsToX1ErepsT?=
 =?us-ascii?Q?NpGrNyoZBlnWTFqGMcgT8Ur2E7C5/hejyc75cjg1wbQT6zOMB3Su+JurDsvM?=
 =?us-ascii?Q?06QEJ4LZHpeBTHva0PATqCr4eg1FDsoZbjPCb68v4Fi5AgjeYUnBxBEUAhez?=
 =?us-ascii?Q?q5h1c1oIkl2wQ0/gnxtj6LRiEDXoFgOJCuLbAJE5mIX3BP08kaWqk6M/1LNV?=
 =?us-ascii?Q?YgD8d1Ep1h1wXQXXuZ1J8PuLcKKiTNZoLX0bYn6NjNCMkbKL5Am1vK2POlDH?=
 =?us-ascii?Q?Zk7L+uE/jzk+EXtsPUIw8NGG8dwhGHs8NY2hU+Xxal5aIevA6DFPuXYL+GJw?=
 =?us-ascii?Q?oqzbgaxdOVgUHYtPd+/ioeCs5NGRcQHBT7IM8MHx6CmLJXHEIGh2yelMbuLk?=
 =?us-ascii?Q?4RtZHXCAxUALQKWTFIZTM6Fa1C2SAzqQFkbFSwsk34m/EyHzIBtL0w3FBk0j?=
 =?us-ascii?Q?WWkni7FhU9tpbhnFpFGmCmMeSpKfyJU9AptC4bpS+2ZQimOwJ4abBmgoEayW?=
 =?us-ascii?Q?xpQ2/iWGyIBpaOgbwYIsw1hcOaYAuZu5ejfSEZ5nSMa6wcQT71ctCWWJUwY3?=
 =?us-ascii?Q?m3g08Tc0oIgHpHT/pW/Z8X+c?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:08:19.9014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd7070c-2e07-4dba-d49f-08dc72f18f8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950

If the `amd-pstate` driver is not loaded automatically by default,
it is because the kernel command line parameter has not been added.
To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
function to enable the desired mode (passive/active/guided) before registering
the driver instance.
This ensures that the driver is loaded correctly without relying on the kernel
command line parameter.

[    0.917789] usb usb6: Manufacturer: Linux 6.9.0-rc6-amd-pstate-new-fix-v1 xhci-hcd
[    0.982579] amd_pstate: failed to register with return -22

Reported-by: Andrei Amuraritei <andamu@posteo.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index dce901a403c9..03342fef7d94 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1785,28 +1785,30 @@ static int __init amd_pstate_init(void)
 	/* check if this machine need CPPC quirks */
 	dmi_check_system(amd_pstate_quirks_table);
 
+	/* get default driver mode for loading */
+	if (cppc_state == AMD_PSTATE_UNDEFINED)
+		cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
+
+	/* Disable on the following configs by default:
+	 * 1. Undefined platforms
+	 * 2. Server platforms
+	 */
+	if (amd_pstate_acpi_pm_profile_undefined() ||
+		amd_pstate_acpi_pm_profile_server()) {
+		pr_info("driver load is disabled for server or undefined platform\n");
+		return -ENODEV;
+	}
+
 	switch (cppc_state) {
-	case AMD_PSTATE_UNDEFINED:
-		/* Disable on the following configs by default:
-		 * 1. Undefined platforms
-		 * 2. Server platforms
-		 * 3. Shared memory designs
-		 */
-		if (amd_pstate_acpi_pm_profile_undefined() ||
-		    amd_pstate_acpi_pm_profile_server() ||
-		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
-			pr_info("driver load is disabled, boot with specific mode to enable this\n");
-			return -ENODEV;
-		}
-		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
-		if (ret)
-			return ret;
-		break;
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
@@ -1827,7 +1829,7 @@ static int __init amd_pstate_init(void)
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
 	if (ret) {
-		pr_err("failed to enable with return %d\n", ret);
+		pr_err("failed to enable driver mode(%d)\n", cppc_state);
 		return ret;
 	}
 
-- 
2.34.1


