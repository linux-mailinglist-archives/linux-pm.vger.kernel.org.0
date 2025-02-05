Return-Path: <linux-pm+bounces-21377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B443EA28926
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD05188711F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D029722A4EB;
	Wed,  5 Feb 2025 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kymYXuB0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102E22A7E2;
	Wed,  5 Feb 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754778; cv=fail; b=TtRbKwCyp0z17MDJ63E1kpjJjYqSbRrJoKISkI1dkva4i4nEf5y+WOWOUObhRQ9ahS2CsGHaTHr3J3CHQqrOmYv+MUBS/K+kpjExjS3n8/w06H7cPhGyCdNbA+XqTMT8ltnVU5JqFqpTLVXu2IpVY2RqC7Kzbpt+Xtgy9UBr2no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754778; c=relaxed/simple;
	bh=Zq+/71yuVcbamiK9LkxwwMkSWmGhw5e65X+kl09Z5fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yz5CPSA/sZeICuj1yIhwOZZ99/2N+iUWj8JOR6au4X5MUP/Tf994tmhdnhZGd/VFGtqEhEUdCk/Sp6DfFJE14gfSI5FQBGa/vKfTdDdzBVueuaiUQZTBc7o4wuCMLG16MnjKtRToFlIt7cz2aEuWMEn6Y7hWSsYy17zswMFBv9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kymYXuB0; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPaK15SdZh6SIAtF4PWDc1yy+I6UEpl5d/J4thsIkOcByGwSwMXVJt+eXVVwxYCRrFIhsNKmmxwZb73nDqt4SumUgQbrtL7DfdTh2vzcx3+UsO5wQJlpx6OT293fFrClkWMDlsIlxL6ZNvT80FmNvT/uJLrkG15UNO6FbEuS859RmisumxYs0DebJROmpIxC7Vpo0J8Uomdr/o5o2wuZkttyR+l7TFpdNMDijbkajGEbOAa6wCCffbBTbyqAe0Dq+jAU1NfxRQWsbFw3vQcEfd1yVrYGymPUNnGOD/IqwERJhAFG8hvXJfie0xGvkJleLTM/smlY9ugPzAWMWms/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BOUKHVGDBdqFEEzNre8oa57Ye3jTp/HT3aKOwOKUNI=;
 b=n2satsLAIL6MkHifLTW3GI+GBTGH910vinoGM0CrFBXCJA4vIFWg44VVjJomcWvMxm/ptqrDQDZbnTs/xkgcNfMsY8yEUE/UKem0QkCu302Yd5TbqNs2az5uWIUJGciWjdg0/BPdelc1g+OakD4V7IW8uIiYKQH3ywfAGGfYTpYmgylexVErhnGeJPMwfEgOti/OQikgofJKyLWyWj5a5AByLXMM4eNcQrjjQ7f6GfiBXEme2z0QaqQ+kiFLbz6xPopVl32UpAZcwknuP/OUMcSkTfNPD1WywmaukTBvJlG5CJt+7O55/WRloZQmvDTf5TI5SVQxHNKkV3hvxmuG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BOUKHVGDBdqFEEzNre8oa57Ye3jTp/HT3aKOwOKUNI=;
 b=kymYXuB0S8yJHkc/OVN+NNkMmF7q2Oiu9ZjDS7QnY2ZfQJaGVBOT95cgaPZZsW8gTEv/exS/m7nUl9UzB8E17nVgbkDIRa7sYILbILu02L6BuxQnNH4xYMaEMocrkqJ5LV3QAlSfwCTuRfXOoIA0vhvAKDvsByXZLhxzPHXzzu8=
Received: from DS7PR06CA0027.namprd06.prod.outlook.com (2603:10b6:8:54::6) by
 SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Wed, 5 Feb 2025 11:26:14 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::f7) by DS7PR06CA0027.outlook.office365.com
 (2603:10b6:8:54::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 11:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:26:14 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:26:10 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 02/12] cpufreq/amd-pstate: Fix max_perf updation with schedutil
Date: Wed, 5 Feb 2025 11:25:13 +0000
Message-ID: <20250205112523.201101-3-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bda547-32e3-4d74-fe56-08dd45d7e668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/otw8V/7/itQxq0WKXhEZMy+BflCNPz5nC8XbLESsJhoc70HWa4wyX1BFPXb?=
 =?us-ascii?Q?t4TZ57VspUQTNm5uibtILYAL1Y3jKVIOcxxW+h/aQ789K1XioP6AyeVqSCVk?=
 =?us-ascii?Q?KQCYulhLHFKLMLhMk7YTEB/UWGJZjSuZirK4eSyShrvjNx2DvL2McHUuQtCL?=
 =?us-ascii?Q?94PN7PPyaI3KpDmk6759bX5muWkuFfuecsw1sBClSGkDfGf8eP7J9gh6RK1c?=
 =?us-ascii?Q?CpLz8XHi2zHgEyf7kLEldgMjr0JkNuylq/8e6MCnfkNOLTCjCvjoJC+beqEn?=
 =?us-ascii?Q?qFJ6mpguxAgmPtcHqPV+P+ypd0bTTTsFIXzWmy8+fzfPOsODBKl6hePtzFnI?=
 =?us-ascii?Q?cs2Vx7zQpGYKpnZB8W5gme1XaEgnFeiwhWE71WN0TRfxE6hJmMqs8TPB0BEV?=
 =?us-ascii?Q?EGFFWDiHxq7bqV8LFl4pu3PzWHp4RUsGGsxit04SfnYoPamGkgsmUzfflgro?=
 =?us-ascii?Q?CSZu4tzk1fkqxQNVO6UheopCriWs/3IdmgNiv5HAJy4BUHsfQOz8YyKthX+z?=
 =?us-ascii?Q?WV17yiPgVatGhFOxG0r9nlNo2CDvpX0DSNTmNkEyN/aBYTs3KuMgpgzRvYv5?=
 =?us-ascii?Q?joNzB+mXPsUP8UPfShvfWfunhjGxqRHG0tXwwPUZx4YBrMjdCAr1nTxZzkDz?=
 =?us-ascii?Q?ODKL7smBbXe1qx4HmkoJI5V5JL6hddA6yd/8+F7C4xhQ4V5U8VMgX6yh62Hv?=
 =?us-ascii?Q?x9458Bv4xA2dhRhyKga4eaBTkqXp7/HDka5lETCEekbF6jIZJZa/HEppzyf7?=
 =?us-ascii?Q?O7p+iw8WhNLLq6peeGjy6RlR8DpWHxuJLZiibcPWbhEZL/CFSszQaioe3nfi?=
 =?us-ascii?Q?YGhhgQiCMItBIL6lPEc7yWusqucTCsM9u3CU0FsRM/UoYmyF8P5331TkY4f+?=
 =?us-ascii?Q?8I8fe2eKKp42dgINK55Br+/wMt76C/AnMxEU2kNKQ33CM2el1jg/TQ1Zo9xr?=
 =?us-ascii?Q?7zAul8MZj5ApKggM4YKFxbgKooATAAswM7QHJYKNgWfd7IxDLp2bVdwkohbK?=
 =?us-ascii?Q?TcjP4Ely0qGdGnbj0ytk9kUVRtmgMV8f7j3OlVVVGugVpiQqfyujPceFORKk?=
 =?us-ascii?Q?fX3aq8OnkecZTtWwfAp8PgWLbXQ+K2pSNb9w0Iy5tLL4gi4yE8ypALR7nJB+?=
 =?us-ascii?Q?kaXhFHVEyZGfrHY8785g6LEi6SIbLKAflAgTpYmmsuC8l0h244Jaz8RKjZpN?=
 =?us-ascii?Q?d+EXsrSwXvI3ljIkyImiemuuzapM3PiIkkBF64Y6BYPZmq0mDfICqUzo9n8g?=
 =?us-ascii?Q?dMracqcr/PwBlVkyKtxpXClRW2TwNBbZVBI9s6ftL2wa/rfMtN771CyG/18e?=
 =?us-ascii?Q?UkcCznlZEWZRs+NJaiNJDRDnhhFUxIIdhfow67LvtKef+Zq3LMzhn8m7Ljfb?=
 =?us-ascii?Q?4OGzkSCpTufRDLT0eQsT7lT3csejfYmq9RN990tVuHhXjnzaGrw8eNRo97/m?=
 =?us-ascii?Q?Ac8O+bC5AkaHyZKjjYmvXTjSkIJdoU+n4ECGcC1B7xY3sG5AOVj3Dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:26:14.0528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bda547-32e3-4d74-fe56-08dd45d7e668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670

In adjust_perf() callback, we are setting the max_perf to highest_perf,
as opposed to the correct limit value i.e. max_limit_perf. Fix that.

Fixes: 3f7b835fa4d0 ("cpufreq/amd-pstate: Move limit updating code")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b163c1699821..9dc3933bc326 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (min_perf < lowest_nonlinear_perf)
 		min_perf = lowest_nonlinear_perf;
 
-	max_perf = cap_perf;
+	max_perf = cpudata->max_limit_perf;
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-- 
2.34.1


