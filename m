Return-Path: <linux-pm+bounces-9600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBB290F263
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861071F233E0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329BF142E98;
	Wed, 19 Jun 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rw5u44/s"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601815253B;
	Wed, 19 Jun 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811646; cv=fail; b=apwyxYkv5ZMDCv9rw5gr0BhZiAvxRuS/KVtzGYl+51qozdVHUcY0vLiIt86TUqMa0oYjrmw9j8m7vN0+UGMOAG7VCTur3etd5vH9HlfFSHENFThO6s3jtrTwmKswwPyKh756H4PzhEIRsX0H6DD8SwHOH412gMx4PHr3xo2ZZg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811646; c=relaxed/simple;
	bh=SaQ84A9mdXOlivUfJ6Y0mpDmxq4O88+lCsp0/N4Ix5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUoT+jRj+Avk2T8g7sMlPBjaUXi/IcYzoEDarwPXFrRLj4WozDe/+Mh1PPXEqtq/PiptRPPNums8EEYnUmOGI9tdUhNfMu6KPOlN6ny5gt2kARIGsDW5of/Z+JnlHm4R+GUW6sdpodQYUy8eyS5acAk7Yld2zwW0luPgHdKeSS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rw5u44/s; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z87BprMjMzYp6bAOlUcNDFhbavTbomUiYI4Hm/vd+BoHSqGsSVev2Btz/ZwK1WC9d09va8KLOo03aiKgHXOkj3iN6qjCBi7vRlk/XZlT6kCTU02e1vcTlcmKz7RTeZsS9RMPkietQJGszJxQNU9a+bpM+ex+pHETq2ByWmpPfCKSRsuHvkFqbpyj3yy1Xi6ur/7pkLb3N0BthC5ZRjVvkSLMbtIxUCSKeWMWOhHNpzmswVugUhV4c5MPBtTOBH2j/0zW6hSTVQQhzswWRNqrlaMpttjhpS0n5L+TRbwgjbfpg5ExQNZIqR8vl63QYYEZv+yP6Wju29nmSJqXxfYkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ASNxod0sbZOLlFkXfgYDq7sgE7KelcytOVJjua1Dx0=;
 b=mOxaL9Za3y1IjEejD1ZDjpHi5SpJixxUm7W6tiMP3ol5JQCCF9rSVFXYwYfODc1qBQa8CB7+Um3OnBXHmE2kumACrv2unnYsDkd5b6GiiwwLTBBIM9YjJY/YOoTiXOhQ+2mlFpuCPD4VzMjM8wZEn4A8Ub8kydQQxl/ynfXEJ5Gb5kwI3ktWm1O08D6gW8LCqL/bnihjcmy/U0FPztq/jRnbR5bLGoRq+96GreFFlBgZkeWov9CMso9Zpr3lnl2gsDW9wfmDX38Be7xjoI/CcSpIYtjrN5RgU1qaGj8a3Tl6hn5/TQUoreejbVvc9f1kVQn1A/DxVZm66LQbbrOKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ASNxod0sbZOLlFkXfgYDq7sgE7KelcytOVJjua1Dx0=;
 b=Rw5u44/sLpdlwwPVpRDd5SCWBHsleSYCUq7kLpIjZsdZCN6s3Y/wW42eTdUrhNv/RcfKs3CDo1ybb8FuZGCNrKKR7vKuj5qZVC/MBlmSeB9SIr/rPYEgMyLmy7pkxn88tpwOrOIot9JJUJpmP2YZEp+drjIbRAuUBpG21LSC45A=
Received: from CH2PR02CA0029.namprd02.prod.outlook.com (2603:10b6:610:4e::39)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 15:40:41 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::26) by CH2PR02CA0029.outlook.office365.com
 (2603:10b6:610:4e::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 15:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:40:41 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 10:40:38 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<gautham.shenoy@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/8] cpufreq: amd-pstate: optimize the initial frequency values verification
Date: Wed, 19 Jun 2024 23:40:12 +0800
Message-ID: <f9793f8451c1832e34cc9dc35f89c653b39cfe38.1718811234.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d83293a-5542-45d7-a6c4-08dc90762d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YB29vTJDFbyCGwpQsL8ynyBFVthxjzu+Vb9pfunEgH6GL8moGDWqadha4CJU?=
 =?us-ascii?Q?pch7ROMH1gjysTmdXejkCbbk+fFXWwzE3ORbavaPW+5bL4QRJFhoKml1C/jk?=
 =?us-ascii?Q?wQJ/KrBku7ACHmTusT7WTxIWD7Pti/okEUWh5fJR0CXg89BxkdlSRbzfMHwn?=
 =?us-ascii?Q?QKiOApVRrL/1HzQKcAyuCG05CMbOJL8vEN2qybpRbU8XI0hqzU6ufhoj9tfS?=
 =?us-ascii?Q?bDG67XwMseZz3WatIqSkStQAidvVykiOfmDXsKCaWz+S4fxaGB3gXQdxjTnG?=
 =?us-ascii?Q?U9RJQXVq4k5GecxVVSdt2tjMvKCRsYydhPP8UBwuvkCSZqn6TdziyAase3nk?=
 =?us-ascii?Q?iMVaOEWiittLpgcrOhO7+omB5fEKgO0KiaLeIXP/6rJ3ONrN0gHr5b8XM0bR?=
 =?us-ascii?Q?42JZ0RYSsj3cdeZ+aumdN4hK67eLDcy2a9q0x4Zhg3fYKTzswA+Em7DKmyl9?=
 =?us-ascii?Q?cf60+rJ8QxMLKm0pancK2gTrDPBqooyS8ssbactQw6CeTFfeUxONcU2yQ3cs?=
 =?us-ascii?Q?adS9Rl28Umijhb01hsM0QhWWwbIIfx5Wefz0wj3etnmJ60LmDStC/gChKPSg?=
 =?us-ascii?Q?QQtmIn8GbtjJiwdSDO5I5HsPPjSrPP8wTKSqZ7kuz2kjG5tqpeh1QaPCP4IT?=
 =?us-ascii?Q?cc/9lc95dgCilj4pQgFcDWrdwKv7Ze995dxTyL4tp0kvjDT0f0N+dpS/v60u?=
 =?us-ascii?Q?IcknwilRzcta56q/MmlpHmmz4dwmckUTnlSCsEJUtWaWVCi4SRdAWH3RvZEU?=
 =?us-ascii?Q?dhKEaNuI62HQlyZMCWxK9JhXV7Emazyi2d/SJhDyxCfqM6/NxI5ApyKxMubi?=
 =?us-ascii?Q?eFmbmDUVjh3jDtQvI7s4qfebJ5FCMrquLYkHanzuGRE/SViyGBzM0pEBtqy5?=
 =?us-ascii?Q?qznzJWDbl9sYorpY6jPfubys6pa33ZpMNkAB7pY3sQ/GaPaiziGKbs62KsGH?=
 =?us-ascii?Q?Mlw8c42FNCgAUHD3JDpErXTAUh3CpI75QNXZ7KKmpTEU/MGFeScGHHNwfjmk?=
 =?us-ascii?Q?9D6MDn2A0iKrlEK5ijTAvE1iqgjfgbIYdW1S+Q98UkRnurGgLPRGl4DRQLoU?=
 =?us-ascii?Q?tbWmcoyt0GuzsWTG3ChnR+XjF63rFu7/NgC1yUxZrk3JenYfVaOKbAQvRUD8?=
 =?us-ascii?Q?N18lqTj8YiJfAY+6gyOe6XhN5q0Fva8gyhDuom5xwlMdSpKyCC6GRWJq/65p?=
 =?us-ascii?Q?Vl6yvUWIXIuEfrVkTfD/Q2SKb7H+V+qU6cT/w1WR8iXjWrwy4aaqXhTTq4rX?=
 =?us-ascii?Q?UjM09F846mVRaDSAiwoCBhFjz+kdTotijaja7PkD0YC4REnurFRd5hlZ5Bvz?=
 =?us-ascii?Q?YlVIJhf3emcjx4+LtF+cfLlnTPW+mJf/kzklWRoiHdcFWX1LF2FfMtifbHLr?=
 =?us-ascii?Q?33+/U/GA7Bx+51fT/352D53RLo8yVH+ZmnOTgPo651zvyBJ9RQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:40:41.7428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d83293a-5542-45d7-a6c4-08dc90762d2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449

To enhance the debugging capability of the driver loading failure for
broken CPPC ACPI tables, it can optimize the expression by moving the
verification of `min_freq`, `nominal_freq`, and other dependency values
to the `amd_pstate_init_freq()` function where they are initialized.
If any of these values are incorrect, the `amd-pstate` driver will not be registered.

By ensuring that these values are correct before they are used, it will facilitate
the debugging process when encountering driver loading failures due to faulty CPPC
ACPI tables from BIOS

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5bdcdd3ea163..d4d7b7cdc4eb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -924,6 +924,24 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
+	/**
+	 * Below values need to be initialized correctly, otherwise driver will fail to load
+	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
+	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
+	 * Check _CPC in ACPI table objects if any values are incorrect
+	 */
+	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
+		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
+			min_freq, max_freq, nominal_freq * 1000);
+		return -EINVAL;
+	}
+
+	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
+		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
+			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -962,15 +980,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
-	if (min_freq <= 0 || max_freq <= 0 ||
-	    nominal_freq <= 0 || min_freq > max_freq) {
-		dev_err(dev,
-			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect, check _CPC in ACPI tables\n",
-			min_freq, max_freq, nominal_freq);
-		ret = -EINVAL;
-		goto free_cpudata1;
-	}
-
 	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
 	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
 
@@ -1423,14 +1432,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	if (min_freq <= 0 || max_freq <= 0 ||
-	    nominal_freq <= 0 || min_freq > max_freq) {
-		dev_err(dev,
-			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect, check _CPC in ACPI tables\n",
-			min_freq, max_freq, nominal_freq);
-		ret = -EINVAL;
-		goto free_cpudata1;
-	}
 
 	policy->cpuinfo.min_freq = min_freq;
 	policy->cpuinfo.max_freq = max_freq;
-- 
2.34.1


