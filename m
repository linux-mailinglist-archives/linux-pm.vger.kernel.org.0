Return-Path: <linux-pm+bounces-9919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E85D2915917
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 23:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660241F242CD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BDC1A0AF0;
	Mon, 24 Jun 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1gx5V8ar"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5461A0AE9
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264866; cv=fail; b=A57I+EbcVM58Bvv/vjdJKWDhABzG28SDi3sdDOBTC8GaJgbNWwrUvIPgwviBfAQnXJzMoQ7y9jxmohSkpgszkefiV33rZW61e+gidqnrGtanZbgWv6jSQW2MNpx92kulqKR/F+bVpZbMqTVl7RSNgL4Kp3H2HwbZDAzZwjL7OpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264866; c=relaxed/simple;
	bh=otL0e+3EURv6ZChQzvF6tiU4cltkj3f018l6dNIDj1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWQvfQ6Vk3WpIgaT/AURJqMifwns1ELFtXImW8ZwI8CuR6MPDy/roNWpqTDpBOe6mb6DVnTMWqSJa+3uX99QFww6ANfNNJXOy+TgAYarGx+F/C87HQX1Y0KVV7GcSjZhwOpyWeMovN6oCk0CfWxNdzbvTlIcweFIh4HASWedgcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1gx5V8ar; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG97xHNzTtzNtlGNzgteXZebpDzXoW5HvqEwhaV/OCitMaevYLSub1xRRgDNZGIBQ1GlW+HdP3E0xy6bNE/LDmfDdAxWImTS3WUNMCk6O/yj019wJpHxrQ5xenxLu/JT+QaiH2tUpG8VvM6sz1C2he+x+4YaP8FNe9+R/dMxSnljWo+qiETXFrrt2vOAKMka0P5xuMkY42X3vdxKtHkF5fZRQyFOlIl83ZxO7SQjC767SYOOjB6z904hZC6P7Gx9cfZhcsciYB21VWGXu4G4sgQ6zzTjE6qzq0VVWYNppe4CvrZuBOpYnTGuOdHUXYQ9ekgA+VHf4r2mXgbS57TYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkXYmZbgZ5Ub+9LLTvUdZDnI32ISJuA3PiekAWqWQxk=;
 b=YIgPTauZEtfPyBBISC04kx7uKadNMB7z4l1QgiKKHRLzSnx4HFG85XIeDy50yQR9LPhz9tuHtZt+amDbF653htVWZytLG1AjO5w4KJHOEtdRMojZg+ikrPUPSKLRUmJmUDiYBan5U2GjvV2FKvqynJ3g5D+adLB5MfhO41PiBVeDzJobr5Ohww8ngn0egLKCiioxRvbrYyuT/m0gx+7zqGGMg3fo7hquwDzze+sV3ulYwgHIncUGVsDXxvxypQRilArEMwXRs+1ADNK56wwCyQN0prWaG/yDAc/owvncRbf6rrtT5TrWGQWCeJUnKMiLKdsryn+K+7d/xA1uOsoSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkXYmZbgZ5Ub+9LLTvUdZDnI32ISJuA3PiekAWqWQxk=;
 b=1gx5V8arzoTIjuCRT+ghZ/uljfpxjhiQdKdC5AnZ3nLNfLZpIUovh0yW0yr4sk+hYUo0fAJKv0JKSbP7lv3P0/uqCw9HMcXG3solGuO8miFwj9kM6pLxFTq1+dreuDpyJWiCl/9TJWrDh79GSmhWusPQ2mDlO9cs1PODyNYCTGk=
Received: from CH5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:1f1::25)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 21:34:22 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::c0) by CH5PR03CA0007.outlook.office365.com
 (2603:10b6:610:1f1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 21:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:34:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:34:19 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Sibi Sankar <quic_sibis@quicinc.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>, "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online when using frequency tables
Date: Mon, 24 Jun 2024 16:34:00 -0500
Message-ID: <20240624213400.67773-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624213400.67773-1-mario.limonciello@amd.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2339e0-38cf-4d9b-bb50-08dc9495699f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ev0BvDMRvflU/fwr2FQdT0oBI9jYhQIMNzXttgHGlCk/y3F1vIfW6mNl7d9y?=
 =?us-ascii?Q?e8sQmrZ09/udkVpggNNIVeebnJVkqkDPX6EJnagz3iBcUKWewRKTidNBiK8U?=
 =?us-ascii?Q?u//oB761ChGKdAyCGFbE6/QdFVJ4giF4UGJZQJQhGGYsKJieNvAw6fUi1a0p?=
 =?us-ascii?Q?eYZ6rNx/aUrIWb5k4w2G9zlaob60IrnxegupfYwu8dx6vtSPYwmXL8+oBhkL?=
 =?us-ascii?Q?Ualyiam2zL2E4WveGlAx14O3T5Uy0DU+KLP2QO73pRXECUA8aioLQANeIXDy?=
 =?us-ascii?Q?DgEGmBmSZ4FH/G5AVgvMvMdgCY/PGfW136EnliJsecSmcc6uKchjNYqPqmlO?=
 =?us-ascii?Q?+jv+nZ8z8TNHRqza0LVwf8dsffA/9CR/iaDYxMVUFH/TKVysQKcijV6z4Jpb?=
 =?us-ascii?Q?aKPlpbsYL2hNg92tGhtSR8EV/OpVkY3HzSm/zT2t8Zq1X+lj5WeT9DOMYodf?=
 =?us-ascii?Q?ojTcCQmgnnoolXDszGN2wKi38IUA+FePjyK6/6bnayXTO6A/Ivy8bCjye9zl?=
 =?us-ascii?Q?BL0QKxiNLm4IS0mbG5sTfgHU/jrZGRwh/DevP9EJ/0B2c+iKbvWWa0wiuihU?=
 =?us-ascii?Q?s5wVxvoNT75RVXsP5IPquQXdZsyc54TphXEMxCHa6vKNdBVhKjWxyOXv25Ru?=
 =?us-ascii?Q?mQOupC4ocaY8DNfdpEe1cd/rhTjfwS9w/9POwI/XWOrJYNDRnCJi7jRiGC16?=
 =?us-ascii?Q?659HwUpnfARMs1w79g/L8aoJYE1Gy0TQFsSpa4O0Opy/zu2+O8UzdDro+SjT?=
 =?us-ascii?Q?2Km0/3G7ft6Qw64oscAI5AOMLIjv0xaPJqysq2oH+O3OXA7giKeNhKih4kBp?=
 =?us-ascii?Q?WeLb7ZX2Vqf2R4x0C55dwz1EUTkZmWtLK+5DoAAPEixoiAC3Y1357T4+RBQC?=
 =?us-ascii?Q?HXacVwnMB14G0cZHb3ncrlBnRgrXngNUKLOTnTSRha7UEU3cJC+v6OEd8+J0?=
 =?us-ascii?Q?4XMbax5bL2lzYX1Q5FtRgHD2fB7kuI/mVXdYy1P7IB655belmz5abAtU0QTZ?=
 =?us-ascii?Q?SEKxBnnReyC1ExHrZvIx7kJxz+H4jHHpkThPS2EuFBq2i/DCg+I/vOKv2Iim?=
 =?us-ascii?Q?iIxiN8DIEHUpBz42FoNajZJATexvcurjypejoOyEakYtbnIE6/KJh4rH7qSH?=
 =?us-ascii?Q?UEXOr54Vh7AIt2u5oUZ0mCikGAg0UJcYls7tbiiDP+iSyPgoNNA1SiPA92W4?=
 =?us-ascii?Q?xZnd+hRCBv9Y0sgEo0E+FWQ5sbSXRtVHuxb7Bs6LnDC6vmeJ4m3pGdbragEy?=
 =?us-ascii?Q?zJBJyZ/9suwkoxa2SDn0U1D7L17SesX8v2JUKHKFFKTkH0ArrjSK0jZnfmXe?=
 =?us-ascii?Q?VRHtIpnOFTDX5U6njUP2iQ5eYJe+d8ufR6+C0KaUW+HonbmeOSxltWuRBRxw?=
 =?us-ascii?Q?Sgr/1wUDn5naPXXKI3u5e5EhOmvcwCqQs4xjPZImcp+Nya8UkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:34:22.1944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2339e0-38cf-4d9b-bb50-08dc9495699f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246

The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
policy incorrectly when boost has been enabled by the platform firmware
initially even if a driver sets the policy up.

This is because there are no discrete entries in the frequency table.
Update that code to only run when a frequency table is present.

Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>
Cc: Yipeng Zou <zouyipeng@huawei.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 drivers/cpufreq/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1fdabb660231..32c119614710 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
 		}
 
 		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+		if (policy->freq_table)
+			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
 
 		/*
 		 * The initialization has succeeded and the policy is online.
-- 
2.43.0


