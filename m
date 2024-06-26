Return-Path: <linux-pm+bounces-9997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73C91773A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AF21C22620
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003BC136E3E;
	Wed, 26 Jun 2024 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q2HbgHBW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC278C95;
	Wed, 26 Jun 2024 04:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719375705; cv=fail; b=pdAAMaebi+nyNDsbVcoPRlp89LoqbSEG5e/lL9pwkv3DJZ7+1jjJ4FesMz+9mz4pJYVCFt76LrWG4wn2+2lBC2ugUW8HWtEgWVpsCRnNN4XtbeozrjCjsOuZS/Gk9Zt86ikewWOMMw5iq99f716uxOSumW41gYdpINlUNU8xpZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719375705; c=relaxed/simple;
	bh=0ML53bo8IrNAxQoJvcqDmODvUDdLcyc9KXT16SDuBIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b36LP/C4rmY3UcbDRBJYYTsaYOjEXqjhdkkmY4orNosCF7o/YJbP9CySijHAs/0ggIlhOzc6yYtmiC6D+C8Cm+ud0n4LwKSKJ25W8OmYtQh5g5h2svjWyI7AOH1fZf+fTrgsLP5fsA1PQw65p58kZ7XJZPbTQ10w8nAyGMm2ZTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q2HbgHBW; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ks4sL0AH1yhTlHyGOXbtntPN1kSSRf9gVsxkiAnBVfKR5SEHizyt3JKj1X5uWtWyiH6HuYh/K2b54cug+ON70U20bJuETyjuWO4hMMXOkwGb9+OW4m78ipQCJTZeEITV+FbOpIOHrg6lKvfzWkrC44nIm7b8jLbd+dl5T7yXi21jB+rcTMk4AbOiEyLEa9QPXMRgbFNOOA15jL6qje93/HkPrk1Xox3pFgDG3T1sXvZDxAIC11THJLFDTvxE+34oUvnWXIxEY0IYKfGnUR63oTuS7pAsxhNoIB9K27xsAnfLXr4phjVgLA22SWXv5zvAI2e2iC3KSc3Qz9kTNU8RHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFJcL3hQNjJ3pLghJFw4NEr8m5YkyiXqud5I28/kP64=;
 b=Im8YyXaoQDv2AkYLCEhLE2T87vqFGNNQOI5dKTOkjfSfKw6H+Ogh1EpuRe8UmBW5inGOx+L35S8ciLCoxfXH0RimpxN5dDJmoLoGoceKmE7gQnbG03oKcrB6xmyFi8JgK0oXCPcf0rnZe4+jyOu2MCnBjRTPTtJG4OTokCbIrCDJJ/Hh6ef+0KT+Huns+DquzeTiy4gaBUACSwJU2ZzUHRuqmmLKuiVW6vYHSZkRw3tNe4dXeccqccdGlsvj4ItoUCrz/aaxf+gKRpozA7R86vWATG3K2b7uQwseB25cWHB1IxU1E4rY7Q6EeOEvCJQDEcnj3Lb3HzZEa9d2qYsWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFJcL3hQNjJ3pLghJFw4NEr8m5YkyiXqud5I28/kP64=;
 b=Q2HbgHBWFVWTUyjH4pEgwH1iDrApFUld8VyqXLMGtL3v5OLxpSH/tAx/mE0QYAArtqqkwgHWPKDrzgJt2eAlrpI3eWcQbS1oa7uWKbbp7XKlEia86ZVYwfIHK5kjxQiLP7Dvk3bFBjjy/UVic7ghzpzFJYF0JfLRc9o985Xlgu4=
Received: from PH2PEPF00003857.namprd17.prod.outlook.com (2603:10b6:518:1::79)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 04:21:41 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2a01:111:f403:f90d::1) by PH2PEPF00003857.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Wed, 26 Jun 2024 04:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:21:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:21:39 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Nikolay Borisov <nik.borisov@suse.com>, Peter
 Zijlstra <peterz@infradead.org>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:AMD PSTATE DRIVER"
	<linux-pm@vger.kernel.org>
Subject: [PATCH 0/2] Fixes for wrong performance levels in acpi-cpufreq
Date: Tue, 25 Jun 2024 23:20:41 -0500
Message-ID: <20240626042043.2410-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d172aaf-d240-4c93-5c77-08dc95977ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|7416012|376012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KoqzcTIWBD1BgaFG3Z1wAaGDDARk6dQk4tYCcYy3LhIm+suKpS+nII/RPU7q?=
 =?us-ascii?Q?i9fCY4h5lYyUV6tj+JkWopQx7mJqq7Nuw2BTroBDjs8QpR9SajJuWocDMj5o?=
 =?us-ascii?Q?g1uffimJo7znf/xidO0UQ0jNPfdiZH7FEiCXoliS/La84LEpg0qXiRm2xIYJ?=
 =?us-ascii?Q?ZnHlaLYdbP+XojD5L1mBWQGCEyqz8Ej5cnRgssq9N0dtiiOSSb7OqJ/ESkLj?=
 =?us-ascii?Q?BtWYdV7nOSxEpOPWknGFs3RGR8wdQYK6W6HR1AMA/UDLs0M6Ah5uaZMFEv+Z?=
 =?us-ascii?Q?fq1haqK/zBWtlv4Kr7LnSrSk1qISV7WeW8NAgq4YmG0qAANy7nkqoARaGw18?=
 =?us-ascii?Q?IDbOkyuysbAX5zan22NHy2zdisbAGiUOxJFzcoNHOMoP5C/Q4hzbp9o6h9/S?=
 =?us-ascii?Q?iiFyYKj4qNQCCh5g26YbXQ7o8Lg/tf0p7NdLaaImJeqxqW3PsXf/RNuyE1ks?=
 =?us-ascii?Q?iAYNsvZesUkF44SfNckfRihcX5dqbmbtsmatV37eWzKIR9rgF+kavki5wRyM?=
 =?us-ascii?Q?n7z0TMD5N0EetVNAQgPWQxGYSd/wIgAAJjtkJPhaop+opOYql6XpFjD5gQVz?=
 =?us-ascii?Q?VO6f4tsX0R43/qdtm1ucfFxoGfLoCYn8PC7OiC3DG9LYpea335ar+AXrVEna?=
 =?us-ascii?Q?QXgQfayE/uzbFHHVRXu19/qso+C5Ojb1Oj5nr68/gLSfjgUbJ74gYrR5Kulc?=
 =?us-ascii?Q?+bQArYqxrahUe2GoLOotTJbjOEK2AO7at4HW+UPg8Ga+44OEW9P8oXx6ZLD5?=
 =?us-ascii?Q?SA4p53zthVsbf+lSljY8ycpcKmNSuDu8ersMLj7efmFXnqmwZbHTEBY1smO2?=
 =?us-ascii?Q?C4lkZo2v5B3vDjEBOXIQ2UTtvdmN6XhEfO22zRZHs5vLJ2Rgbcn1CFcgI4Ux?=
 =?us-ascii?Q?9jY8wCaRwR8dVgAzJQvj9/ABLhzbNfw4jrMSCPQFxXCX4uqVuijp9YC4P1gt?=
 =?us-ascii?Q?qRWlN2o8F9zkInJIO/7J+vFMe/4pyguLU8jbNfgp6eOaUiaXWv8Ts4z3ST13?=
 =?us-ascii?Q?/dZ2k7BQasVnwBR8Uzl3mRvxtrXpqXeaRuYJcGyZsPIE++90IWGyEbW2HVDh?=
 =?us-ascii?Q?vAGrEpQXIHqM5qMBIKC4kekqrgLKCQ3Lpiuqyd1G+BLAMR3cmNcHf6vF03tR?=
 =?us-ascii?Q?XbkN5QNFjP8V3l/4LAIBvoDFyRQnm2/0M6QdeHrL1eo4BJSAjXysHBqrfW+d?=
 =?us-ascii?Q?QxREWacKcRwbJS7VvnqABUfCj/IQAJVHVEt/2SxYq3801CyNDdrIV4KMZtTr?=
 =?us-ascii?Q?lEL3AxWMqGwzrYy+X+uEvSSr8xxP6CCTIU7Ms/dKabTsK4baaE6Ua6UHlSPr?=
 =?us-ascii?Q?NNAKbNkfCE7QwBLWshEDgBRuxuzm3jFMl758ay/ryH55GJAco3YP7H9IMk2S?=
 =?us-ascii?Q?3ximcUBluWFg2GNuxzPtFn0MnQOxRFwoJjdXMl4pH3gHjkqSVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(36860700011)(7416012)(376012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:21:41.1275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d172aaf-d240-4c93-5c77-08dc95977ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902

In testing with amd-pstate disabled, I noticed that family 0x19 model 0x70
(Phoenix) was reporting an inccorrect max frequency.  This is because the
perf levels used to look it up are wrong.

The correct values are stored in amd-pstate, but there is no reason to
store it in two places. Move the amd-pstate values over to one place
so that both drivers get the right values.

Mario Limonciello (2):
  x86/cpu/amd: Clarify amd_get_highest_perf()
  cpufreq: amd-pstate: Use amd_get_highest_perf() to lookup perf values

 arch/x86/kernel/cpu/amd.c    | 44 ++++++++++++++++++++++++++++++------
 drivers/cpufreq/amd-pstate.c | 21 ++---------------
 2 files changed, 39 insertions(+), 26 deletions(-)

-- 
2.43.0


