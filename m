Return-Path: <linux-pm+bounces-7522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EBD8BCBD4
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 12:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484FB1C210D6
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894214264C;
	Mon,  6 May 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CfSbu6NM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363113FD93;
	Mon,  6 May 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990831; cv=fail; b=rejzIp/PbD1CYAkX8zLo/ui5IB8nmBeYC7Y9xf3e4VAcgbeWgsrx1WRcwEpcuMNfZAmArzrUOvcypOqvl5Rp63z0X1cyzrbf1asmCw+/yIyJQvSetVmjp66Vkk64+/5OTKDMmlgxYUV2cg1R6P/8D0Yerq7za0z9ss5eSEVkCgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990831; c=relaxed/simple;
	bh=oEJ1aIAtGosrFyk4IqINDU+8CxFIH3iJUhgfurIlJY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3BVrQ2oKN8c2T6D0ukg+zlKazH7GkemRQHUvMQL2NdXTkqL0p4SsBZG7hef/mCp9Zb0J7InAekBLegrp2KnNT9sZ3UeG8gU1vA1kanlLzW/OI2QruJxkkqfP/GV9KJVIth6tGKD0SJyMw9ZoZDsMNIdTKMj2OzJrJUc+gIRGFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CfSbu6NM; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHl8wZnvoYTk0ChVxwIFTsO3mfncKEwh3GfSW66LBgRjYxxpiKYiMZhN2soHD1VTNmUVVaBw4CbjBBp5uW7yoqfDal2ZDocLTydlptzKLpZyGH9z5Hh5OEAb9Qw1n50H75Lz/P2EyKv/fYh0awQmBTOUVf6tfcaUDl9B6s/xGKimiNPTbQmppG5FviR+r2WG2fx+xziyySp5mHWYf1sSOVLNjMkIVd2MaYpkcu+xUOEf9Z+LYSBqtdjTTLOhgnIGyqwNaGcEyr41ivZPLewXDcnsJaG/4Z9Ej6tAtxtBCVD6fr+gPBW718e8Blv58uXPEAe5apKqciPnYr3OD0pFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq+BXGQldt6vAGnrN13zwfmUSkeLFSTbaIEjid2Iko8=;
 b=RJ9O27XqzIGzs4UDd/EQV+Slee+8tyPXmu2DDJnsML0O29rQqRi+Wl/shhU0yZ9VEwvOH12Rf8gcVEUQv8VD95zQQ4MaPppHNZMKztjIGfAQeaoX8TpC81MlulJY/Bu3r4ar9w1E3c7BT0NnPgR6k6zoOII/hylCa5p45uipTf/XoRCSdcoGKFJ3O4Vjvo5HqYd7KPvUhgjCUoV8koABI1SzW9Jyrj5CahfdyTaCjf9OoK7grp7gFmOlmBTWvYQgg7/0xy3KsZlqfkiGpbsxLf3fsPjx8SHeQ90CKMIMCVQvbBOauJxfgtOb1Z9ADg4/5Un3YuCw9779hpwxoa3scA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq+BXGQldt6vAGnrN13zwfmUSkeLFSTbaIEjid2Iko8=;
 b=CfSbu6NMK+3dYE3e2XkA+4NzyG3E4cdsc9pwzx1yJgmt7ihGka5PNJMyrpQOitcXioiIbOJfsvRIzePh6wqWixMmI2si538f0wpVPTvFl7TqCHm9agiMw8ORIMO4bsz8KQxI1w0pdYkPryXWwS8yxRAMaQtDslIUM18prGaQqRU=
Received: from BN8PR12CA0034.namprd12.prod.outlook.com (2603:10b6:408:60::47)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 10:20:26 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::be) by BN8PR12CA0034.outlook.office365.com
 (2603:10b6:408:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 10:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 10:20:26 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 05:20:15 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <gautham.shenoy@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Perry.Yuan@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 1/7] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
Date: Mon, 6 May 2024 18:19:53 +0800
Message-ID: <b7ac14ae34c470579d02d55cd57e017daaefb21e.1714989803.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714989803.git.perry.yuan@amd.com>
References: <cover.1714989803.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 759c7dea-fca3-4c1e-a004-08dc6db625ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6oWCFD1oGPEIMk/b7ABqvCX6WOH9jsQl8pHaSm49NnldZN77Plivpdw9lwRz?=
 =?us-ascii?Q?sO0b8/hxgO30LsM14FQm2B54uxdoE5N4kr3EkPBMfTEr8p9DgWxey8v1wD+e?=
 =?us-ascii?Q?Ag0h9e9hujvGMm+BM+cAKGPWiqOj4vyzbh3eluylBhhx8DrItLolcRTMxItv?=
 =?us-ascii?Q?O3qNZlhuZaesHJLc6DhE37bdZ6sCLM+iLc+a5iHmvM2v28XZgTzVwgIaRllR?=
 =?us-ascii?Q?dmABCVYVPcjzx5CgukaF6+fSK9RkoFUMQ+1AGyu0T84znUPDSIaYt+IM63CT?=
 =?us-ascii?Q?x6aFEOUIqY+mSIjJr6Sj4Dlb7w2jiyRANcdcrrCmsaupvai1LIj0qy1HbRHX?=
 =?us-ascii?Q?GPFwTzs2lPvq9lHr4cUcmD6lIK9t30W1XeqGI2AoMvkCizqbqiSqhkbn+eUm?=
 =?us-ascii?Q?TqIU7ieRDuKlG+0mf5RCivB4T5zEf9vTKni4vODYB6PKsnKmweHn9VgEEZoW?=
 =?us-ascii?Q?zJjUPb/snWyKTFdHYlhffE0EDUK61UcD9loLs52YxAMzmCaSGzDNvzOtIC/r?=
 =?us-ascii?Q?rlYnItdGiI4pXSdZDAVgw/SHak7kXwgHKdI6BvLD9vrB5GkJbnEptR1k1/B5?=
 =?us-ascii?Q?mEGufKcfnxgDxBYCz5FtU0pHXsHLjTs40YbOA32Q1UEbdL9Z0z+EcM84LAO1?=
 =?us-ascii?Q?AdcfZn6jFxukUDk9QQtnsSx0t58Nmu9xJbiBbtXLlcOOuUAbH+eYF4z244ln?=
 =?us-ascii?Q?9vsXvfAZw7pN5JN0ZBD+7zHOVEPHfVZbM91CQl7gbAzbzBbTwkANyELlo0PM?=
 =?us-ascii?Q?Ih30k9PRUAQEXkAVnPOQ6s8LJKk1xmhFQFNq+9PTtZkEiegOdFYQx6NPHpzL?=
 =?us-ascii?Q?r1ctRuSH180emh8hykkNyw4ATQdEFL+CNkWs4lZecoPiIeA5dgGXSwSk/Q1J?=
 =?us-ascii?Q?IfGbHYbWyoMWEx6LRAV12QKWkGrOSRA9pi1Jg+xFKPTEhqVl/txOfeiZob5I?=
 =?us-ascii?Q?U3RBQmiq7cxTlL/18Tf3NF2pdkxrD+G9nc7J1umAZ4Sj3FWN/OP3g0zI3oGY?=
 =?us-ascii?Q?zrtiprfWch4h6KSxRmGHJIlA1IpIFUCXh2eHs96HvOBxyjzIMIup58oG+l2Z?=
 =?us-ascii?Q?albUBPuhPxNcKFQ3fOwoDbX/RXcUOhc+i4Y6MxYWme5KkU5ac3yAONhVRjTU?=
 =?us-ascii?Q?0OICz1GmSga5cIGJsu2+fo+WB0sq0HfGk7jb1LroE5cZojOmrAl/UePiJBPk?=
 =?us-ascii?Q?Gv4EV4xaVr2eOWhdX/jljKHtmBkgSv1Jnw9W52d/4RlZ1UNoDA+TnwJ0gskW?=
 =?us-ascii?Q?Jm6cTZPUNB4pvjxIgdaTmIpIbXXZsSn9LH4+8U3POUVu/KeasU1ob5qjOr4B?=
 =?us-ascii?Q?FqgbvRrJoXsuZBe5WBKnHRaDeDu4BuEYFPXfbiW9aG1oyM92OQGvGmRbjFIL?=
 =?us-ascii?Q?7SJ8rLw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:20:26.3762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759c7dea-fca3-4c1e-a004-08dc6db625ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123

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
index e72c2b872957..8738a7b3917d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -782,6 +782,8 @@
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


