Return-Path: <linux-pm+bounces-9813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B3913629
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 23:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9D2B23633
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B1B5EE80;
	Sat, 22 Jun 2024 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vxHqz94m"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9D12B83
	for <linux-pm@vger.kernel.org>; Sat, 22 Jun 2024 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093156; cv=fail; b=FK28Z1eiZMec6KQl0mSmKXnsGbSbrDDAbg+bZ7+pSWMlyBdXtS5tMWEfwvbXEeBi6Sm2ufKwFXwOJkJ4toxf2wHrEIIma7Uem3uSyzGpc50QrsJUQvhxV3spSnJPLmrhpK5AfYU1TtZmcBxUxFKe/mwgYEyBsKtGEEuipSUiyUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093156; c=relaxed/simple;
	bh=kb61VbBjxol0YvZ7vFKBDkbgStW487oZ58dSUZoJcJU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VZsq7AWyB+FNUxGRrUpf3YoUjMTMAn52M+BPZk5g4lRTBel34tS3HKO0o2JYjCDegPjsPqcu5fWmYaSxfL2SkjgmPVEIsVfUR8W+YkV4v4HTkCIBVBGaOHoSlHXA4XHPOFcDJ6foCHTX1NOQDD16Q1Dzq5Fql0RCY6TMjLtsx1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vxHqz94m; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPVrRnT86fUF2C0WNQPprVWTbyxZPc984VTuIXBT1OGYaBKnUc8RO23FaTCieZJ8OYkzWYf1QKi/J7NDyhfWvYFBMrshgEBsIFWNSWuOz5EGAatT3Xskqpf0aZcZAKEhsozwzjnr9a8lHtlEktGgzv9CheTIYAoe8wpeu1j9PAnU2W4u/xcVV26RBGgqAAs+eytA0g6NRPBsGCHaN1bJHtSrLuKE03f9ZqQjXv/KozLN3p8kL3axGmYvgopwxSNwHthh8JSj15u/1nc4x1WDZVyqsf9Zgl+yHDB5c6BCbMU5P3kgvC9CToquyImjX57LxcNtJwJgkQfOr9Rn6GR9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iy2tXkxwO3o3nNYLezXcM5e1/wRB9os1lamJ+6lCK8=;
 b=EQdI9/fBcpXU6n8DNpNdD1ILvcpWp3E0Lf5ISDb7A0BiKVox2gXyZbKPDp+4zIgRHQlntKtorKwK/ng7Q6rSqdj1CRaGYMoU3fRLWz16VuZtlKKiLLS72x+Vl/KijiyQk/FhF2jbiC7SuNqx/9i7vHETClfYnQHlZ0wJpk29spYJT5SRPnnxI22sUJ59OC10UBSL1Fc5bl6gC9t4xIxRq8N1/KaRiSkUXDAK+cb4PpvZCi70vZ+K62qfV0oyq+MSUfYCGUHf7N2rDM8vjrwq+O+zqD6Q/IuTqdUqDVqEZ34WFimFdsR1nFc8lFA0L+gEOU8mTOkaGJmpHCdlAx/zFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iy2tXkxwO3o3nNYLezXcM5e1/wRB9os1lamJ+6lCK8=;
 b=vxHqz94m08MhKiH28NVHejHZieG7QzU9plIqscZCnFstg1IRJVlYv/BNWC0z2u5A2ZiMS0mdsr9bXsnBjU/bDZRvzsNbCfHcAaoQITuwILhVHYr6ehpdCjc09pploZozAcch46oQ52W2VElGn0AhbzyAj94YqvmvQ0UjhD9jKJE=
Received: from DS7PR03CA0243.namprd03.prod.outlook.com (2603:10b6:5:3b3::8) by
 DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.26; Sat, 22 Jun 2024 21:52:30 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::3) by DS7PR03CA0243.outlook.office365.com
 (2603:10b6:5:3b3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Sat, 22 Jun 2024 21:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Sat, 22 Jun 2024 21:52:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 22 Jun
 2024 16:52:29 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] cpufreq: amd-pstate: Make amd-pstate unit tests depend on amd-pstate
Date: Sat, 22 Jun 2024 16:52:19 -0500
Message-ID: <20240622215219.47911-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: f6bb371e-3ca7-467e-c88a-08dc93059d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v4nkbzV5mBZzMYRL2zmo4ANBDcGnXjzIcYh+LbwRtU+uWpIabtxe8NY+7qft?=
 =?us-ascii?Q?4J8+/zeV+D9Nyfcqio4OZ0lMBJboLZv20b54qSG7F/8exuxBOMUgYnelZLEc?=
 =?us-ascii?Q?DZ7JucjhwW8yhec+cfq73yMiHroEvpxdexzPaMcOmx8sg/iq2bymWrqd6crF?=
 =?us-ascii?Q?kHt1Gb0XYEzc/Xasb211+rFYuEP0zbOJUbN2IRP+iVldCoBxCnhfmgyhStiv?=
 =?us-ascii?Q?iyNlSE2kCQnlLnXOysOfT2rDT8V8KNAvuhfJFP/T38mm22/ipOS2fkVROJSX?=
 =?us-ascii?Q?japn7YUROS/aSS4Y5Rgstm6iA0DAquqlpJdaZWrd/KBHNhSEUoM/IzmeKUqP?=
 =?us-ascii?Q?LRBE+1CjMQ7TpbCzgsJ3/wGo/OznrF7gDMpNe965UUo6VO3d5JZjxC9Yb5Gk?=
 =?us-ascii?Q?n6Ed6rFsbPoiUAffrStYPeaEyNnnEaLk14YLTB+DiqvOtkMn6+qedIksVIiq?=
 =?us-ascii?Q?1LWLiPlIo4hqE8j++SCU35frvXRADbQ9oxYYTUkKBhjWP0WswQYVjx1RQEDw?=
 =?us-ascii?Q?uCODVSGo5K0LjArTvWhzoyuXoURA5HXrw3K+ow9IKdhRuvV5CWE3eB1X2rWQ?=
 =?us-ascii?Q?v1lzpLqII3hp78Vv5OQaaI8r53r0icC9H5w4KUq3tGkmx/aKgcNQHVJJhNmL?=
 =?us-ascii?Q?NAqx0aC8uAeHrTLrCKLf3iTv47vJRB1KyzP2WNu3+JGH9Ds3ikgSMm/sChdh?=
 =?us-ascii?Q?4IuREQ65958zhs9kJvfA5dRz97JRMdAYyG7rejVNaAx+KYYsG3x0Z+vPAw+R?=
 =?us-ascii?Q?if5Z6FWxVQD7K2ukuzaxQ8/ImI9hkH0PxL/V1MAyuvnETCyxFo68V6u9LnbK?=
 =?us-ascii?Q?C+iW6LuWneM8BqyTeehSadnGjBG5TDmM3QDvy6sssP0YECH9ln2pDNua3M4j?=
 =?us-ascii?Q?UvN5uUN+pIWKwb9i5AJHLaDO4Q3jCTMPNG3KBiIeF2Ua1dJgI9+yxi4Ipar3?=
 =?us-ascii?Q?Z7v9Ayy3/j2BttVZ73Xrzu1t2PCLIR0k3tKIAFMv/H5sXV4X2Exkr5oo4lSg?=
 =?us-ascii?Q?LWIQTleE49oJ/U6EFtiS17dYLqboRNI1z8YkEM34vFmILrUL3TN+LttLKMuj?=
 =?us-ascii?Q?HCsyDY4r5ycCHQTmse2JMYlbFrotA6AuZoA3YaxOVJ4qsJ/RvssgPN/ybjnW?=
 =?us-ascii?Q?jehmPyIU7zYhc4bG5EFRfyQfvHFjitMtS071toyJf04fB0cI45sbJ396f9mH?=
 =?us-ascii?Q?3tdkr0bWJoGiNZRuim8K/pnSgTHQ9PdvV0BQ6AA2VhWOd8TY2Nj5XhFB+ISr?=
 =?us-ascii?Q?mMqBMOJz+zRZw1MI/y3sbFyDVzIL7dLD0dVQ2RfxbZm3hZfSsCyOzb8+/VoZ?=
 =?us-ascii?Q?8Ys8pAyzFykJhUdz4wlWR1jPyamB0a2i7QPfZsTNpzYpG9w0l5e0TfaXFl75?=
 =?us-ascii?Q?8n+0sf0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 21:52:30.7313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bb371e-3ca7-467e-c88a-08dc93059d9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465

As the unit tests use a symbol from the driver an explicit dependency
is required.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406222016.R4A2TMs8-lkp@intel.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/Kconfig.x86 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 438c9e75a04d..97c2d4f15d76 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -71,6 +71,7 @@ config X86_AMD_PSTATE_DEFAULT_MODE
 config X86_AMD_PSTATE_UT
 	tristate "selftest for AMD Processor P-State driver"
 	depends on X86 && ACPI_PROCESSOR
+	depends on X86_AMD_PSTATE
 	default n
 	help
 	  This kernel module is used for testing. It's safe to say M here.
-- 
2.43.0


