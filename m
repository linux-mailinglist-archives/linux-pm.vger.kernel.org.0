Return-Path: <linux-pm+bounces-9601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4362A90F265
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91A31F2345C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367415380D;
	Wed, 19 Jun 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0S7dxpFR"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76597153506;
	Wed, 19 Jun 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811649; cv=fail; b=fcjelUC/m9eh2ilb/GzTFeV8vliZTN8PlN2he7hFyOJoFBKx6wSpbHyZgxvP9ruyMdBaUlWCpg/XUTm8P0+mPqNhwao6VaMvCU6N17HGuD/hTsvbIndF9JtHTfc/Trph5Xtpa/Jmqbe8aDtls8tB+KKTaDKWeyW0lcd5JP42y+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811649; c=relaxed/simple;
	bh=nzTg83Tp2KVTOlE7x+0Ug5wzeWbrkQurFgj/6Vnnpfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dcv7TZ3wONYnCQ1WaVXGY9jlQdRRBCdMHShsN6PGeJSDsWHHSuyeMncWkMHMZblV+hKH9mTaZzJdGzknYKHjCF/EnAIA2xEiLKq8j8GrWhn7eg8zGD09XPm8cQnZ/bD6VBgpY1PdcifkK5O43+8pn7vcFlffSNXcj7h85QUgu8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0S7dxpFR; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JacAqzOshWlOIZXROVbmTj+cZr+IowIzkweq8DKok2RbuORgwnNhemqFLwLUntxB/acoJYpuBVFX5GbouDmIW6dnyDxfIScyslR9/yCBM2olV/Ah1Zkg6ANJNg73WfCJqEi1p9/stF8X726C8NPvoUBxSYWoXbSVDV8W03TWoyywDTQGtyKnY3w4rTkycOCDNE7XINA/eJwG6NXUysyFLFIyaNINdPG46dRy6ZbvlDcClQh98OmtTlUGIDb29YMkWhLUc8vrA3nf2vFSaHd+TsmgcfOgxBpLEztYs1EiEyocQy/4fgfDq0qg0ri2Y9N4RniY3T3a0JUIkiCw+nTdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sK5KXlwKPkdIGyjDy5laceL9Hg4OojtpPlfVYO0BjM=;
 b=OpbDt8pF/fdKMwxtd7BAnLpsDeW+rUvxQcLmDjQT0JYNvjXkis9C11dmiyi8bvl6xpShyJWrz0Wvgl5CxVydpD9zrMLXJneF1Yuypa9pKbD2QQ5yhCpAQDFZo2aKQ+Z9sl5gwIOM7UIiEcrGrTO8/6ck2z01zz+ie+CC+Ar8V5CvMyCXcHOcSXz38/rjTuJe7F8tihGq1bsYNSeP9k+pStwKmSrvRxgMu6eJyaMLaH46LJoBjXv5SCftu8z3ZujCQIdOEPKhNzypjYwfe25+Gxh/JKMuFLRBB9EJpbLGPw6rVBoTJIW4pPsOyI5/rUMJ9bELDbMKaa3w2nPoEnzjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sK5KXlwKPkdIGyjDy5laceL9Hg4OojtpPlfVYO0BjM=;
 b=0S7dxpFRSi68TYP+OIuvf+LzV7N7RU8hrKoLg6lPPhoefHfkj6L4DuWwXpEbs3D7BGGbyFTaYLXtuvHCvbujn607CclNccZhe5lm9ig5PlrXDKAJUcCQB4HYZq6TGKDLjpwow5s/lVR3yLPk53pwQva59P4WXzvdS9GFRlTpJOc=
Received: from CH2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:4e::28)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:40:44 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::d4) by CH2PR02CA0018.outlook.office365.com
 (2603:10b6:610:4e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 15:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:40:44 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 10:40:41 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<gautham.shenoy@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/8] cpufreq: amd-pstate: remove unused variable nominal_freq
Date: Wed, 19 Jun 2024 23:40:13 +0800
Message-ID: <b7ef41557f71d40d098393ddb27f0fe1f23648ae.1718811234.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c25c7f1-9f53-4d86-07d4-08dc90762ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nyf4ZIyGdaOshf8KcqITZakJlyMKIfzSAAEpWcrII3ag2ItV7zzcnpnedYG5?=
 =?us-ascii?Q?3YqejxyBrXnbSN4Cmnoq7nlj8iTmeeijybYZS35GXZ3zcTCoi3v6D6cwviwa?=
 =?us-ascii?Q?omKx4NZnikoe8yBF8EQhdeQ3PA+4yl1zMMNpokiVtaqb2dY5ptdY8fwIZM1z?=
 =?us-ascii?Q?/r7zI4VNDYAcEmRA5nkOu7x0X49WvNp4ulpRJqOKkeP6brl402AYpqc9aWSz?=
 =?us-ascii?Q?D761GbrlsM35F4KDz/NSSKqKnP0QY0Mq3Jx/aoPOUVEdw+CMF+EitNOdKkjq?=
 =?us-ascii?Q?fZAc1p9GPKe9E3TmlL4FeJbidsI7wWPxzZOSQRuKJD9x+UjjbnUtztDKjKKZ?=
 =?us-ascii?Q?Og4QRwWfJ14tjW7L8DXQfIknUEALpxOa+ee6fMNk92NpmEqvFqWULi+mSrLv?=
 =?us-ascii?Q?Xr/6tEf9XKetyPyxtjPwrLsrY/JdllaTmLVX5fGadceLnnLxQxsgCk9sFRGb?=
 =?us-ascii?Q?/x0yLku2oHlLQE5xK715cBImo6oe2tiDA7l9KecPRKZ1b8TIGtm2sjoHqbYp?=
 =?us-ascii?Q?aTAxPpbUnAWNpbKUssj55QeYwFFK6JIr+MX216fmKIrIb7qJWjOnnz/Wo+Jy?=
 =?us-ascii?Q?bve9vpOWw5jI2D6F2ExKZz1B951AXo592utW7AwYDeLcA7cXNYSs1cxZfdQ+?=
 =?us-ascii?Q?yyMwAAmPPWo+7ScctWNsBIGH7BdoWWMlzjLZaS6G2aXeT7o1/s+/zwfpsVQk?=
 =?us-ascii?Q?gqpn9YSIum7lR5GMnjsgpFuPp0TYkJP/7hgUOmxls7pJxKfZgi9bA5gSzrkC?=
 =?us-ascii?Q?N6k7a/alpTqRniWWwR8zWaOsI34tJ3KoGEMCJ4fM3/ZpO2804c0mWa9wj5PT?=
 =?us-ascii?Q?SiE3mqQgr+Lh+X1qAkzAnG5EhYCcvRnK3kb4Z75h6qGui3iNoWBg4sChFMoB?=
 =?us-ascii?Q?i4eMfBoQoPQYi5qlH5z0+2YKd10TVsPuj0EyQOl9sn2mSVOF6O3zQYOuuPnj?=
 =?us-ascii?Q?V5bQHV2rSTJlR/gxKfcHBdWIF2V0RR/Nv9yQBOUPIFpPiKU0bx6QhI1shZLE?=
 =?us-ascii?Q?vesqAWlzUhBndcO8Fd+M1wzqmN4mNQkg9/eYvre7iMyHSKsZBkqt2gFqPgVT?=
 =?us-ascii?Q?/DVqp3831eZwP3gdwjQCiTm5tScU+hW3cvRwzgI655XTXLIgIKcqDN+SeyXh?=
 =?us-ascii?Q?CUnvdyXQKrHj2DaWuSu3RKfQLXNtAb6NDkaX8N0P+QcOMgz2EGBfepbYv1d8?=
 =?us-ascii?Q?vC4qjzyF0bbGydlp9ki/79HXBx2uupECw2cGNumcVKD6ORd2FNHk/VlIH7B/?=
 =?us-ascii?Q?SjfpRVWn8vaWy6u70BJaAfgUl8kk0wAnOwEmVBK/elzpXbLRy0pA4Yt42b5e?=
 =?us-ascii?Q?rI9XJIsgO9/qRU6t/qSA1l9R2FJqXbZwtYmBxYZgpCVUAWZOR6Mbu5qi4N1E?=
 =?us-ascii?Q?9mS/Ndw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:40:44.7115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c25c7f1-9f53-4d86-07d4-08dc90762ef4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

removed the unused variable `nominal_freq` for build warning.
This variable was defined and assigned a value in the previous code,
but it was not used in the subsequent code.

Closes: https://lore.kernel.org/oe-kbuild-all/202405080431.BPU6Yg9s-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d4d7b7cdc4eb..1ce063a22214 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -947,7 +947,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, nominal_freq, ret;
+	int min_freq, max_freq, ret;
 	struct device *dev;
 	struct amd_cpudata *cpudata;
 
@@ -978,7 +978,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
-	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
 	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
 	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
@@ -1398,7 +1397,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, nominal_freq, ret;
+	int min_freq, max_freq, ret;
 	struct amd_cpudata *cpudata;
 	struct device *dev;
 	u64 value;
@@ -1431,7 +1430,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
-	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
 	policy->cpuinfo.min_freq = min_freq;
 	policy->cpuinfo.max_freq = max_freq;
-- 
2.34.1


