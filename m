Return-Path: <linux-pm+bounces-15092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0BD98EBD8
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 10:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F325DB2366B
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470EC126C15;
	Thu,  3 Oct 2024 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lT2rwUBg"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586E482ED;
	Thu,  3 Oct 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945171; cv=fail; b=pL2ODap7FaxCRMBxEr7TsLUWJPN3hRcm7j+2pMs/8GYn2NfI2cLNiyDUGc5yBlDIgDQekGXqsQuamQ+cwBWd8slJwdF5sUuTwEGLZE9jbThqY9Yz5U/gvMwmJQiTG37yzegRaKzFnTmFHuw2DMWBCg67WpN/RUpzLf2tAj8GhB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945171; c=relaxed/simple;
	bh=4Ve6i4Rv3Mwn88STU8da3QNPK6uVAlggZRA168oFL7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnV9CrazzilfOa8LecW4qH5snavRJ+B4ASovQI43AcuEaqgswNbC+5jAtKDktCEOJLF+i8x5EIgMVGZaAMFLX7STyIqq87rQ91+JkJeo9U956OGKFxFc0yk8qIYnX7i/79SKJ3s7mQTrnVNo4JayKk+3CkZAVScISOQB9JFe62o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lT2rwUBg; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiYZicawj4MFTWSKpn8dB90LWhsSuvkSPFdf9FyQIy7NGtOJgNvA6FFnrqmmmOGKFARvyQGE7b75twZ0q+wA/ixv45GLRTrqatRpHULcY4mm3rqKWaE19eLd3cJ2pytaJiR0OXTaIvWFWeo/gPPxj0vNX828/Y0rlV7d5gKWwg6GHbVsZwNskXy4j0xlktl2Gtowbn7AjfoTtJ5QIQTlSI/caizuNA9m3xtP555zv9wqmjxp08OrnbbVNoSiklATqyoZb1b1IygTrW3PQ3B7XKXjNQDBY+oT16Jo71ZIGA5emRPdoLkKNkvCgRjlHTXx8JzFfUJRpSjukLpuPBHSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM15UiT3u2QbAYi3rT/oD6jbgjwQb5wY1LJWn2+vBL0=;
 b=aqYDSIlyzCmBgkRt06gBW3JDr3y87ez+iPb3pZItbqTjmllNxf1BvGqaLr+Hqy6rjCWLn5IuGAlGt3nGOIIPEhryRuzLU+n2kfXYj7F0XWK0GTwBkbJmNPZL6dIawDvmAUWVinn5MuCnr8QhKxbZaRwejxerS2Q/RnmT/FpIb1W9xCSQ261uZfHW1/b7VYqXkeHrYnhTgajGPWkG8u6ZelHCYygDw57Y16oceSo7dlcW6dA37ssyTs222dAZRqe5kZKR4pc4Sp2ReeE90tHfHW4u43iPOw1aWiS70HtN2dUIc+A4F1hS8PMztVRTV/jOXe/Dt39ORmrftl9IGKynDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM15UiT3u2QbAYi3rT/oD6jbgjwQb5wY1LJWn2+vBL0=;
 b=lT2rwUBgy+iHwZyfYQjklmTB9CS8yr5Qk+XZYy7bY1hxlxF3DIFym82nbcVfZK65OkTl4PX4LbbUNB3jtwFM1PzrzrSnYq4/WKfungy0ZgLsZ/XfxWgdL7ULacog86F5uMOs3gATdg5wJ4WiRY2iSqcJAfcvf7tJU9WavYxrbX0=
Received: from DM6PR06CA0051.namprd06.prod.outlook.com (2603:10b6:5:54::28) by
 DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.27; Thu, 3 Oct 2024 08:46:03 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:54:cafe::39) by DM6PR06CA0051.outlook.office365.com
 (2603:10b6:5:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 08:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 08:46:03 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 03:45:59 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <ray.huang@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 2/3] cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq
Date: Thu, 3 Oct 2024 08:39:54 +0000
Message-ID: <20241003083952.3186-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f38b0db-f658-4aa3-cb60-08dce387d03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iaF3O0HewwlfveIA6+jLb/aFTk7myaHjiYTT5ZYVADjYtlhpStbE+EmLxvZT?=
 =?us-ascii?Q?HWcitNsBx6HtYPBmfZ7UKNoThaafztfWElsqwRE/78t9b6a+mVKvVhfT+c8G?=
 =?us-ascii?Q?HMlquBDaH1ECqSzIZ/QREvw3hvST6pLTJZmqkGq9yrngv2rzBdhw/jaSnWMh?=
 =?us-ascii?Q?L33y9HCzwnguYJ4yBjLHaaMXxrBeJ+RohTPnOzpg8neuifUI0EMB2Wyym8Mp?=
 =?us-ascii?Q?OTmZVHDWykOMWzJfOt4EB7amrMPDalmx9ZNe7zI+DleXLBDmwyY9NJg83Lcu?=
 =?us-ascii?Q?snlXp0nJ/8f1fpXdBLvyTRVsEyoHE6EIU1F/XcuCMPeTkp6cyulL5duM0BZP?=
 =?us-ascii?Q?PbgELOYjc8DYF7SGy+79yxXli1DCQWY+dbTKWnf0ay94Riu28qCOq9Tral3t?=
 =?us-ascii?Q?4XYPCPnKHYVvHok3fHxvAQAnizlEKE8vOf9Eq0bmeLa9CYOtcG0tFT9o1Ms4?=
 =?us-ascii?Q?2EnHCv8TkNHUYMGztyGt12396n7UxQs3OWewJ7Myd1/1e7yoZ5cPkkfzy7AO?=
 =?us-ascii?Q?Dzkute6C5Qnu5ypgts9irHgUat9fsUJgP7Rg2QC4IP8kjkLMi03781a0r8JW?=
 =?us-ascii?Q?cTszhA6pHYDh1dNPt8kipOq5qG4HjXxWOytcuv4vf7K4yM2iZkhZuC3Odvoq?=
 =?us-ascii?Q?W83licDqMvwaFxn0gvKaeCK0uacwl2e8115QXjz7vrMV8CQMclGlN+MgDxbf?=
 =?us-ascii?Q?pyNyv1KO8E9s53un/neXtnb3XPVajkgOstV85MyDV7pe1gRxbahxaPYH8pqT?=
 =?us-ascii?Q?sexKgVCsCMh7DDtVM0gI4+jhJZL22pzKpm52PCFlZjxd7sc3vdJQ9+TwDiYG?=
 =?us-ascii?Q?QjJvC4lEN9kTIJmMUuH88VPw7pDwws8cp3dnFSQMG+RPdvnA8Gj24vMq5Kmd?=
 =?us-ascii?Q?Fd9BVW7rl1+1vVZXVgC7yor/ZBEdyBXqsWbe0IEZW94qpBVB0QTzEZDtqNv2?=
 =?us-ascii?Q?OYUsJlyN35KjQWnILxNsBPRzzqwaIc+Sia+Vfi0UIJl6ofQLf3fyKOZAs50L?=
 =?us-ascii?Q?RxIm8bbdbVHSH/hgOER4DXk4Ia1faLwyVpW16dndFFZLDMns9KzPAHkaAbAG?=
 =?us-ascii?Q?0J+kFDvFkNjkIYR+Z5CIgBC6qJvpo1lN+Pjnr/fXbAdkezCrxGto2+YbNJcL?=
 =?us-ascii?Q?fHUs9okkXyRwnQRCKbJJ6FwAflt6oepiPAcCxE7ZaMdvQEMmwpkP1GJLpSbM?=
 =?us-ascii?Q?4nwveDPI79cIh6ZUUkEIBZGPuHqREzmj1d+va+vFYQak66T0EVyfQt3FxIgB?=
 =?us-ascii?Q?Tu6HprUxZsJffJPtZQhXn4idVZT1x1PS+S0AxSxLFZ213LTzoLyJrrOsWUpw?=
 =?us-ascii?Q?P3axUJANDj55JMtnO8hoUaRfEPWjExcCTjL3U9xhwkS26zJoV471HpnrP5uS?=
 =?us-ascii?Q?dcO6HSvtUugputOeMis8DqKtBwol?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:46:03.1628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f38b0db-f658-4aa3-cb60-08dce387d03c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

According to the AMD architectural programmer's manual volume 2 [1], in
section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described
as "Reports the most energy efficient performance level (in terms of
performance per watt). Above this threshold, lower performance levels
generally result in increased energy efficiency. Reducing performance
below this threshold does not result in total energy savings for a given
computation, although it reduces instantaneous power consumption". So
lowest_nonlinear_perf is the most power efficient performance level, and
going below that would lead to a worse performance/watt.

Also, setting the minimum frequency to lowest_nonlinear_freq (instead of
lowest_freq) allows the CPU to idle at a higher frequency which leads
to more time being spent in a deeper idle state (as trivial idle tasks
are completed sooner). This has shown a power benefit in some systems,
in other systems, power consumption has increased but so has the
throughput/watt.

Use the get_init_min_freq() callback to set the initial lower limit for
amd-pstate driver to lowest_nonlinear_freq instead of lowest_freq.

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b7a17a3ef122..f8abae9a0156 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -995,13 +995,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (cpu_feature_enabled(X86_FEATURE_CPPC))
 		policy->fast_switch_possible = true;
 
-	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
-				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
-	if (ret < 0) {
-		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
-		goto free_cpudata1;
-	}
-
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
 				   FREQ_QOS_MAX, policy->cpuinfo.max_freq);
 	if (ret < 0) {
@@ -1706,6 +1699,13 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int amd_pstate_get_init_min_freq(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	return READ_ONCE(cpudata->lowest_nonlinear_freq);
+}
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -1719,6 +1719,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
+	.get_init_min_freq = amd_pstate_get_init_min_freq,
 };
 
 static struct cpufreq_driver amd_pstate_epp_driver = {
@@ -1735,6 +1736,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
+	.get_init_min_freq = amd_pstate_get_init_min_freq,
 };
 
 static int __init amd_pstate_set_driver(int mode_idx)
-- 
2.34.1


