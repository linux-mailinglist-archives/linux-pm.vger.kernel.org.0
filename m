Return-Path: <linux-pm+bounces-9049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF7E9064F1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E480284FC5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A8D80056;
	Thu, 13 Jun 2024 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tWKj1cXH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF685CDD0;
	Thu, 13 Jun 2024 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263546; cv=fail; b=lFAfd6rwRy6QHYeipELt8WUxW15E8VbRyUo4nzr6uRrtaC6IS5IiwbpHygMhgK9Zy8xpFRMyZdoYKGATnZMJZ+KyrpjpZslsFkALaNsxcxJipw5MLL5lZA8gTDNAKKh4xt04CmWD8b2lxMEBTfpc0H40CkoCOew9SQCYlPtweao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263546; c=relaxed/simple;
	bh=PkYLlZjxfECQNAtTpwSLNaDDoS6fj9PfSinZeOrh2Ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKpTlnb75E0xkYQtndPArhW78ighuR056JHtcMKfpflJONx6vIVzLg5bgph41igzY+LFRMsc9TWAZ3f0nkTIteo0VC2pe6De4IUD0vjvFellVMyYf4itqJV7WSB5QrTzXZcLSEGstALmq/nQqN4rUrnybRujugrytJUtCF5SLnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tWKj1cXH; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrrs9SCSE4KcP3HoixoeU+S9ggdZBgjgpKZ7JKTeDTUz9PCo9NTPaPawafm28xQhVgcKJ/ompv4+zLb2GU9/K+OKa2Yk4tWj8+xdEtKdIAn2V53Gtj5/lN/xCrQJnRvSVWPMmurNNzKKLGbT4IU2TzEAIQMNyWBLZhg7dZeLk0Pr+CYqcvPfcMVOQ51qZB+qRQRcB+E+k+qvSRQ1ub9HOzy+uuVM7P7/Kpx128WaWrrqAHwvzzMekVOYXlIGuqJnS9y+MXKh9kg/fzfM9zZKswVwxSVd1r08jsKUgnqHKOyTNYFAQwgAyjvKUK1SmsAYGIUOOObxHzSuq7DDvmF6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQRULbL83Wq7yBUahvTIeQJ17zPzxLeAflkvrXSzwkM=;
 b=kLZP69/kStonYgXAHHB/+7nMtdzy9i8PfTEXspTt4cCm5KtnQ28pl+hd1SnucxOVdJCKlsYRwbOdBW/phC5oL7I4AMZiE+E+loGqBJCgtNzBOYhFzcMrQzbUtpddUWN1YT1ijO0fuInYdLXyCGQBcqioism5HDq0Nl3hfi2CfahqbYmxC/cZCNh34CyKxmVPpvo4/5Gyg4B6N04Ug3WTsUD9bko5TU66afUlvxgKACP6NcNO06Ql4R1qirSW6sx0p90BxsZ0K9GlBnBhqcGXaIdORkyQ0e4l3gm12HLENweyKMqsYNJIpF09tXeUxzK1gSpO+Vh8M6mnFp1n4WgNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQRULbL83Wq7yBUahvTIeQJ17zPzxLeAflkvrXSzwkM=;
 b=tWKj1cXHCL17OEJLTLKFxzFsM3pxsyls5UimJFR79OBc2lzUbGRRvBKvRwv5B5ilT+lK5+AYUQkq3As8qPUr8eQbU3yH1CHnFQpcz53107DGbvpb67TYHDrJRkw4NMBXczHUYkDATIl5ToG6sip8pshhBRpcqCORcdPiW6NIOTM=
Received: from BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17)
 by IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 07:25:42 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1a) by BL1PR13CA0072.outlook.office365.com
 (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Thu, 13 Jun 2024 07:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:25:42 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:25:38 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 1/9] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Thu, 13 Jun 2024 15:25:13 +0800
Message-ID: <f824563c1f87b09e4a91ed874075bf10af677621.1718262992.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718262992.git.perry.yuan@amd.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed3c314-e697-402e-7bf8-08dc8b7a086f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|82310400020|1800799018|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1mlgG9UUFGHMKSYPyZrGm3afR8ARntwepK9G540pH/52uoZDev2ho5lwwtU?=
 =?us-ascii?Q?TcJ/Jv8qPzaPPuKEaZ4NKBD7//tp9vhF/GUn/g3n4YyM9IW2UGniWyVjrobS?=
 =?us-ascii?Q?UlMr/TVsBon2yqVhyKvuaAjTK8U6BBpStzw48zD/E0WuZ/zddkEkUPlueNnK?=
 =?us-ascii?Q?B7+HUyAw4mySJhEkUeFF4Uinb+qMPnvVkC7M9FbdDLa5oD8fmjp0w7lzgAg6?=
 =?us-ascii?Q?yoQX9lIzicRrUHw5rcvhvaIc/LlMWIkXmVjh08YLs13P906cbmYyzI1zlJ05?=
 =?us-ascii?Q?AUVuZiCEWFc0gZcCconiqgRuCMNwZLzo58g11BrsrmjCotc3fYAQScKYHGNR?=
 =?us-ascii?Q?MviMCqWDJybRPDh6bthqNBVe/yIbWQBui4PCzMAIcSr/UeahBMo4Hf3nOymR?=
 =?us-ascii?Q?gy/25enPyblJyzav3OmbFOCBXjavJR3NNmXbdjn5ZlxUWl1PU+wQtNENGgiX?=
 =?us-ascii?Q?SNpaGEodfTcUMR7aB1v0+0JS22erYgbV4DsM+DvfPRxpzVhaMpHVphoR1sdA?=
 =?us-ascii?Q?4csAtyYyMihZKF/hUi2FzKyrz9EWYOyLNtbwxBU9Dgh3Opp3gZ2qsWfqQy9W?=
 =?us-ascii?Q?Dn3jTAphlMlvWBQKaRTe2QZHFbmGWFZWy9WPSjFt8caSTpckmhLdCnMXihd1?=
 =?us-ascii?Q?Bcf1DdiT+lRGAwwAq4TV7I//W/IZQqwWfWoCYTE7ZioEcN3FHnTg9Ekd9JYx?=
 =?us-ascii?Q?sWzOFTMlLcL6l/23lI47tBwEWpYmf4sIJRzoiM5Qv6t/4rb7d2CGRZkkXPfl?=
 =?us-ascii?Q?vneiHgjRkkTFUUYD0jEEjrHb8FRfs8emL05ak9NzIOwxsFllXVgT/5NFUSul?=
 =?us-ascii?Q?RfYoyGaltmkUWN84MWnxf4wK1/xln/lCIzUoS/b1gl88fAo/W+xg0U/wVoqA?=
 =?us-ascii?Q?yJ2no+G1COyHW4ix7NQbIjiy3bimUbYcWWNuzFFvuQXOfUt+SPZ+aL9AZvJl?=
 =?us-ascii?Q?+AQMOjG5YxcgZPqWsIewsUos3Yc7VqD05xAj4tsisKfdB1mQVls9v3q7ft3m?=
 =?us-ascii?Q?gtVdQ4jlRE06loT3YH5occfSzOCju4MaIce0eqkqz6UmzyXJ82goGXnCO4UQ?=
 =?us-ascii?Q?qXTD7zUPGJ6+N5Lk0mqMaPF+9Xm5wSz25qLDtKvhW4uPU1Cd7cr6m28geKU3?=
 =?us-ascii?Q?AgaYRkIRUAqJzPtQd7hqUKE52g20+PXjNbHHrdh6aXWxOJlsyWmed3WdH/mt?=
 =?us-ascii?Q?kr/4M2usBcRFhl1zjXmBoDMNIfhgL/7mPp2i8zw5UbknDfyap3vWUfWsfcca?=
 =?us-ascii?Q?qS40kW+YjwZ+0ktIbn3ly1Jb/wtEXQ+WJ6+eBiKtnsUAYi8b7DDEHlImpIvu?=
 =?us-ascii?Q?f9iBtOcRhmuXNY7Rubw4q0SvSO7wTiSrZs0+vS8Ovq/V4H0XhEYpyvKOvDRD?=
 =?us-ascii?Q?5rEAI5tlmU02eqsfwMKUeTtW03n1nvPCxDmk4aV5+vgLKo82Mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(82310400020)(1800799018)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:25:42.1062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed3c314-e697-402e-7bf8-08dc8b7a086f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457

There are some other drivers also need to use the
MSR_K7_HWCR_CPB_DIS_BIT for CPB control bit, so it makes sense to move
the definition to a common header file to allow other driver to use it.

No intentional functional impact.

Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 drivers/cpufreq/acpi-cpufreq.c   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6eb766c..384739d592af 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -781,6 +781,8 @@
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
+#define MSR_K7_HWCR_CPB_DIS_BIT		25
+#define MSR_K7_HWCR_CPB_DIS		BIT_ULL(MSR_K7_HWCR_CPB_DIS_BIT)
 
 /* K6 MSRs */
 #define MSR_K6_WHCR			0xc0000082
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..2fc82831bddd 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -50,8 +50,6 @@ enum {
 #define AMD_MSR_RANGE		(0x7)
 #define HYGON_MSR_RANGE		(0x7)
 
-#define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
-
 struct acpi_cpufreq_data {
 	unsigned int resume;
 	unsigned int cpu_feature;
-- 
2.34.1


