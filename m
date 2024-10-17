Return-Path: <linux-pm+bounces-15831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C419C9A1A2E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 07:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BA21C222CA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 05:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6913D24D;
	Thu, 17 Oct 2024 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w3TipHs7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA929A5;
	Thu, 17 Oct 2024 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729143599; cv=fail; b=ONipwB1vAcFv1XL3TS/KBPEF86uaVwpYb3mSQJoCJcumfoYS6zdygW9U5GjB/MG+peIYwMg1p+N8c5AfMgTbbSZHHfr7cMHRkbQjMLgVI+a+DSZFeDbVpufDhyoWzYdfb6j8pX0GCz+cZ7vEb+1RgXbgXQ/iGTVPWCrkwldBfok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729143599; c=relaxed/simple;
	bh=M7EvHWmHWYOtchVpLSI4oGUd5z39y+kGSE+tk4RIkMk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KojlJD388XKOD8CNDBxU0B1pWKoVBzzoqQIwfa8jnPTjLTdWSj3bILFwx7g/mX70AQLtMD9opFdlEyStgn0jk1W3xBkb97Ic0SP4ZbhMaNZUw6CINF1ROu7M0GIFc/YAyhfZX6b4uu1nn2YaZUb+hbVnIafgVCGYPr22MIjBfQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w3TipHs7; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfLGGPC2OQ6CnpOhccM8ZpDevoeSgFIHr/+AQs41+IYj4i4/Hsnxp5rtAmh8sASTh9kR4R7cSF1qp7yuJuxkU7hSLIP5mUe9BJHH7MXdWVGcoNbjvPy/qUIY9bXNaRomC2fPJFsP1jz0cxYvfLAnP9ReQadh4NqnxrJVKI+wXPxI9oviJz9vPv35Q1SwW3LXDcUmjtzKKW3TGjjW30HgGlZ0Wwybx3uMRtfnje0esJlwrTNpQNl4GroGY9mEcocVV4SNXEcrqcREQFUc8ceuQ572YoX1fH8CR1TVBxNtpMJC9AyW70BsZcbhgQ0Dpx1v6aSXlkm3kdG6Nqtt7eowFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Woxe54LUkftcoyFRG6Dndj6Aemt0UkY9pJ78WkXwecs=;
 b=yz93ohbTsc3Z1EOQ9ZgCenm/dQG/GrPyo8AEYsf3LiOxiEyvvem47KKZ0IEFHExPZycCMnOBQTvMcI3h0mexBh1HEzxr1/yxClIBp2RMANCgIXrMFYft6njcgTos07fDxtwrYsl4rrQq9qivAU7tti5sC6ZQ7j0zDYetCQr4zdRVE4NeTSS8/I75yRJRskyH9N71LAuCS2xrhzdMtZHaSXK9NYkbkV7Xndenkd15gO7HcYDoit+vidE83REHTxENkXT7LafzmMPGwDYOVjLB08Uwmx8eqC355tfMHOhnPdKo0xnUxe0v5jiT99UOzWDsV/bXAZ35p5+QdTJk2Wt5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Woxe54LUkftcoyFRG6Dndj6Aemt0UkY9pJ78WkXwecs=;
 b=w3TipHs7WNukyJrNJ2wUJJQGAjnFE3N8vE//FExy/e9893rOOI5jTHHk5pXmX0Q3TF4hzTzgEACMPj7tIICxWgN+z+quWWLK91r6hUrR5FXTx5J9hCF4jeRMCRgj2b5h7AIZr0yweff8hL7t0FO7G270M3TyhJyrhezuQoqSxgk=
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 05:39:52 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::71) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8 via Frontend
 Transport; Thu, 17 Oct 2024 05:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 05:39:52 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 00:39:49 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v3 0/2] cpufreq/amd-pstate: Set initial min_freq to lowest_nonlinear_freq
Date: Thu, 17 Oct 2024 05:39:26 +0000
Message-ID: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d67ae64-4149-4fa7-7e8f-08dcee6e1fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|30052699003|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kOFXzQhsIrXrjDbQwSSJbN/KNTip0s6X0AsN7S5qOXYa7h1aCb8heSecXUyJ?=
 =?us-ascii?Q?mKGY2cC8hc35co+xkV2qfB4/ZWqWh1/x3lL4IQ91UfZcUJaLUhPRaK6kn80q?=
 =?us-ascii?Q?IWXitT3ik2GOh0v/+hBptREWcPc1Q/C5J30CLwldATVdTpB0niBwYxJ+haZV?=
 =?us-ascii?Q?oSKPcQhmz5VRb3EQzDxUma7XbiIl3Ty4QKsHAYcT/6N41LYFGBFjmRtAl9Lb?=
 =?us-ascii?Q?plomxn8eRmKE7lK39vMHJFRpWwwfIWDXObDycpH3LB0HPl3Sh0MFrNDgILWt?=
 =?us-ascii?Q?3L35WC1KCAKG8hAM4dwE2aMSCr17Z6CllfInC8iUhkKi0CdHQ3Sp/JR6oLUy?=
 =?us-ascii?Q?7hUvPv2bUb5UNt+hjfdARWb+CjYg8Osjt6E3OJiz76wocmNHv64VUKo61Fg9?=
 =?us-ascii?Q?gdzrM9cXhEkf47cTpxaydNm79+I6K/E/GtoqoAxLKp61yEi6ZXujpI5CGVIb?=
 =?us-ascii?Q?Kq3nQ06SviZ00xv+Za+bWdcheLuSGp6YPQUGtUNFNLxsuzkR8/OJs9qPittF?=
 =?us-ascii?Q?EJ39lHqw2gKSNlh4e0i+n2GMtBUd1jHiJKHFmbFMNexgViFOBbVwX5uerR2X?=
 =?us-ascii?Q?a6DWnZIKH/KDGVMNm/Uhqye0nPJiF9U9t6O4TSVNfffk7WCSj/6W6kIpwWyD?=
 =?us-ascii?Q?WvVti6uAsZ1JZL1rNoL4kKlPtUyZ6wJSD99XS79FlmRYB3/BxZE9C45gQE5U?=
 =?us-ascii?Q?6z4qVycI2sbcsyDwxmKyT/C0r/leFmMLwzOetoOADtiZe/iIWisoeLqDLDdH?=
 =?us-ascii?Q?gPirrfz8PYv+aPOI5gxbdr4vdBmoXV3qv6icEgmTizH9w3QVWK/DP+hYGFhr?=
 =?us-ascii?Q?a7Rntz9Qfi72VaDmHIsp0Xaqm8GPOHA2LFEmqiwTQvcFeVa3IjlQyw3JPEHx?=
 =?us-ascii?Q?DoDyT5i90u9NWcxNAbJMCz53iWkHEZN35vn7LGRb752GfAfo/Wn+I2IQJvfR?=
 =?us-ascii?Q?T4lvrfJNCJpe2aX9sS2nviGk3hRCBB6xi1hfWo2APDmVunF/s5c9hh1I1a0q?=
 =?us-ascii?Q?J7pEKOj+lE1xcn0G0MuG0Qrb2ywSBdK9R1/u3Q4F7s8xcHqBBBfAYnR28qqY?=
 =?us-ascii?Q?7P6rLNOFMCMcni7siWToAa10WvvyHe8D3NbUmtLIGbRnk9qMq9psnP7YeFXu?=
 =?us-ascii?Q?Xgjvum4PAzV+7rvo+yir+/V0h+ixpONhAVDHAZq3sFzjuNhubEoAroz5u7rS?=
 =?us-ascii?Q?fmheiujHAFpHE4JBfVtLDSaLmo70ayj41ama1/1ocrxl6UiC2UyayW/u2wqx?=
 =?us-ascii?Q?GcnlvPIdFlFur61K2/kJBGnUv/jfWSdmz9HS/37FO+Az+9hJty9YlopAJHV3?=
 =?us-ascii?Q?kWn28zgBVl7E2Ffzrdkzt4VNbiSHxTPABiw6vn/SkxyhAu25EHKG0gN4unem?=
 =?us-ascii?Q?tP6X4vefs1TdFkJV//9r13r/tUUDofy+C2Y0EwO4xGiX/MtJSMw6OZuuh3sj?=
 =?us-ascii?Q?IuJIbQqOB0k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(30052699003)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 05:39:52.4450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d67ae64-4149-4fa7-7e8f-08dcee6e1fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530

According to the AMD architectural programmer's manual volume 2 [1], 
in section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described 
as "Reports the most energy efficient performance level (in terms of 
performance per watt). Above this threshold, lower performance levels 
generally result in increased energy efficiency. Reducing performance 
below this threshold does not result in total energy savings for a given 
computation, although it reduces instantaneous power consumption". So 
lowest_nonlinear_perf is the most power efficient performance level, and 
going below that would lead to a worse performance/watt.

Also setting the minimum frequency to lowest_nonlinear_freq (instead of
lowest_freq) allows the CPU to idle at a higher frequency which leads
to more time being spent in a deeper idle state (as trivial idle tasks
are completed sooner). This has shown a power benefit in some systems.
In other systems, power consumption has increased but so has the
throughput/watt.

Our objective here is to update the initial lower frequency limit to 
lowest_nonlinear_freq, while allowing the user to later update the lower 
limit to anywhere between lowest_freq to highest_freq for the platform.

So, set the policy->min to lowest_nonlinear_freq in the ->verify() 
callback, only if the original value is equal to FREQ_QOS_MIN_DEFAULT_VALUE
(i.e. 0). Merge the two identical verify functions while at it.

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]

Changes from v2:
* Fix the misplaced NULL pointer check (Mario)
* Move all new code inside the if condition
* Add comment to explain the rationale

v2 Link: https://lore.kernel.org/linux-pm/20241016144639.135610-1-Dhananjay.Ugwekar@amd.com/

Changes from v1:
* Modify the initial min_freq from verify callback, instead of adding a
  new callback in cpufreq_driver struct (Rafael)

v1 Link: https://lore.kernel.org/linux-pm/20241003083952.3186-1-Dhananjay.Ugwekar@amd.com/

Dhananjay Ugwekar (2):
  cpufreq/amd-pstate: Remove the redundant verify() function
  cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq

 drivers/cpufreq/amd-pstate.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

-- 
2.34.1


