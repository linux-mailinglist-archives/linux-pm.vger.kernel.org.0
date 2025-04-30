Return-Path: <linux-pm+bounces-26440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8336AAA4340
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 08:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679D97AE0E6
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8A41E9900;
	Wed, 30 Apr 2025 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B5cs0xpp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030413FEE;
	Wed, 30 Apr 2025 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745995372; cv=fail; b=EUTlrQlf/eZLnAe5Tdk0GhpLblP6sejoave/5YFKEl7jGTR34uE+poeFFwisjum4YbG+EPbByRrF8xUK4jCoGPQ752zcXpY1Yz62uBBmSwNOBiaLArKNzI+PmwVBEu03RBC1Z6yiuOZPw0nSj9SBQdqZ+E7eLfmzCrWOOb1lAWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745995372; c=relaxed/simple;
	bh=JX7d7B+qkXIF1JzMIXySlqf0oIuVE1WMSoyHPGl6Diw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bsJX1qYtbOES16/7ryEoXaSXQ9Ql7huL3+fZE/GWTKfhhFUjhas6xTacxwHqPxfhLqvD2hJTibDpOsA/d0FWAC6VFovTPix02A0RJSWuy1uI+uiD5e/X4GhK6eoPmBkWzII0TOfSH+v8/GmPBEDG1zJFQIZkkXBlZsCzJ9Cpvp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B5cs0xpp; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTuTSYlTp/8PFiHr+wEA7Cp7FOd3K35Pamwxhhlno9gYsgKEIyxfFTt43HtSqSTrKLanRZbYpVAT5SA88kqlOHhz/qWgDUioRUqkSC33wtx8ENtk9fttEaufiD3nP0F0Wh4xRGhHrzQc3Xgm0Rit7xz5jVbL/75mAZTVk95wkfckUBQqbf+R0hk1RSCmD59luX/p/HLwMauPkjAHnRV9wcXijDbIY7DhFpcOUqCm1SeRBhuTEK8RzYdWcwXeyZvmti30fv71S8TaqtOaAoPYsduL14gmt7/37uvR55MGYtI8msapaYsfDEzyo0gottaTlgQgPKbAlZ/GTLHkxpqw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkhYSPxPJmd6EAIw7GWsDwb49gfqbxjJFtxMaaQD4Pc=;
 b=f8OazHLy+9LiDNSMGO0GFlBCTe0tZ+D0vTce2CTKYAGD5QTPEiJKR4FaLxTTJNFYLvR2Bhjx4JpeweDUT+ecYW9xFhLv+UPxpGv85vIRkqbgjnvXbhRuDJtNk56fADRH5/XMuvR0aKW5JzdQ7NBJYooD0VSucjO6CoitcXhr1Q2iH9JbnFl6xpAkCA+OcaEZQ4o4scIKL6Mlggv7baA9EhalRAlM0fFLw7cA31xxMP0pnYsqEYURNKwEsyzeqKrwQjgu4GlFfS7QyVRC1cQgqCwHo+jc6vUp5jlyrwWI8CEDmqoY/xDNMmEcQqiee5f0Lva28ApKUwTzI4Y9CSvrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkhYSPxPJmd6EAIw7GWsDwb49gfqbxjJFtxMaaQD4Pc=;
 b=B5cs0xppyJ52mHitNBFKU/k/ViCZumgao8g55GGBdqAdFMsfq55+7x/E/0fkk0KnGiJ8WZwTbcOcMsMr0JfgtkYScZBOy2/L/CQTcvTD8wxO+wGcMBmmeKi84WWw1402ocA4t7nubBAs7JFFxs0VfdIIAEzPvZe7VfBIYUACxzE=
Received: from MW4PR04CA0269.namprd04.prod.outlook.com (2603:10b6:303:88::34)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 06:42:48 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::43) by MW4PR04CA0269.outlook.office365.com
 (2603:10b6:303:88::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 06:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 06:42:47 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 01:42:28 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <mario.limonciello@amd.com>, <rafael@kernel.org>, <gautham.shenoy@amd.com>
CC: <ray.huang@amd.com>, <dhananjay.ugwekar@amd.com>, <perry.yuan@amd.com>,
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH] amd-pstate-ut: Reset amd-pstate driver mode after running selftests
Date: Wed, 30 Apr 2025 06:42:06 +0000
Message-ID: <20250430064206.7402-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: d440df3a-160c-4aab-f8fa-08dd87b2385b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FPfCXoZkmixovr3DUR1jc+whLPAk985e9AaGG0DXuVvv023mJUSPT4ewlyXi?=
 =?us-ascii?Q?mZtI9gurvTz0IDpdiZwuPPpxb9W122AI19U8GYPiVaZ8o3MvWCwhcmmWlqvb?=
 =?us-ascii?Q?pwwoO9ljTVPe+yrF7MzoQA7JK3sBF+2bq3/TyGgGT0BtNvQ7r9Qa0mhbbyPn?=
 =?us-ascii?Q?1klizFmQ15N6Wp16zpVD/wAEArWhU7qC6FnUBxrMstpaq7FegR+kYK7Pin4A?=
 =?us-ascii?Q?XA/3zpWvPBW8flFzsrGjSTljf4W/gWVjorpRbO13G8Siovh6XK/wklBpYDQt?=
 =?us-ascii?Q?lxnSA2UR9atuaupzuizgMcNCLfeuKapBkNAM3/tFrZv2i0lS/BqV6krf+V9B?=
 =?us-ascii?Q?5zHnA7JyeD72+NHqcUGnJvsSFwiyjVOF0+z5Al6MLKOcRUne4JavVHJrd2vv?=
 =?us-ascii?Q?P3K5CkPHxpSdcsnopscW2bEUdo2TL+CY6gnH3ctDe1FtjwJtRFtdHa4UaZ0U?=
 =?us-ascii?Q?tcuqQk0z+9HCFcskJE7rh8uNQHEwYv/lBUOQtD98aQyYo5kWWtKLzuV9WWQd?=
 =?us-ascii?Q?pl1eqqGW4ha6IH7hyTA555puMz816urMU3Iev54QyVXQnX785xnnYF6rTuUk?=
 =?us-ascii?Q?5sJtSn07Oxb3GHycPVyeKId7zf2bRcgMfW8NoIFy83UvF0ob0noIWuQRB0Hs?=
 =?us-ascii?Q?ODUySmG8uCjWob8zZ+K70L3+cjAU0dp4z24XesB1fR2lKV8G1igwhm3TJ/NT?=
 =?us-ascii?Q?zIMOrQh5Nxmyyy16Jv1DGqcEVtLsOvCSODPhKddPYvhakm4OmoerqVNZE/s+?=
 =?us-ascii?Q?HaX6hjN/eOjANjBRwzWcdgT3CxFiuAGZDWzzqIsC2973TXRMXOmgnxD3rTmC?=
 =?us-ascii?Q?5vlVZJDaTr9wYENw1YcnF1t9moGpjb1lWO8q27p63TPfE9tDIHZmDYtEyx3t?=
 =?us-ascii?Q?c65uzJTglk4oSQsjlqtGlJIce/ZoYHl1pbDBdm5uJP5/dPnmLam5BDXmNk4X?=
 =?us-ascii?Q?U9NZ+O9IZsswxj7QGlgaz60zknmJIDv9oM53lHAnKycq9ormyZ1G74AWA1X+?=
 =?us-ascii?Q?BBFhpgmwELTqim3frRETv0qNJB2h2j66b/X/SSrF7ICOy9JzwlIiIfm51azu?=
 =?us-ascii?Q?dlLD0FYnWwQYcixpa+mpNSJhbNKtq9OI63YU7Z4iOm1eklwztEPUbUs+oPkH?=
 =?us-ascii?Q?YVe0Vbr0s0LInhXmBJpU25oSDeIsabq2uoiJCKKul8HxXdd7inCVDuYU9LNW?=
 =?us-ascii?Q?2YXRphmISkKI33BbIE4EdLNxA/vsU/9B0+b5Dkk+RWs49J4rLLTvkrbPXK6J?=
 =?us-ascii?Q?O3b/XbwvbkDonvt7EIlF2pw2diEPLnmu5fcMM8b3jhxenK4mMb9nhBGu+2oC?=
 =?us-ascii?Q?Aeg8AFVlc0qJ/nZ8Zrbz3GDKgZc9g1HXQJoKDhXnywzWPwcvKo4Rqm14EUdH?=
 =?us-ascii?Q?E7Jl6hRuxqF6zVR2Eu5sRDjoeLzGKpy4VivptfbeCKarrmvfYH6KnvlmGrl5?=
 =?us-ascii?Q?sU2V6LvFxK0x4+BeB1+rxsC3gLkKnxDsFO917bNkU5vqvrAre4XZfWKjH+60?=
 =?us-ascii?Q?zbrg0wOukVqpHwFBuutu7vYOQMW+x6iOYUV7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 06:42:47.4442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d440df3a-160c-4aab-f8fa-08dd87b2385b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179

In amd-pstate-ut, one of the basic test is to switch between all
possible mode combinations. After running this test the mode of the
amd-pstate driver is active mode. Store and reset the mode to its original
state.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 19 ++++++++++++-------
 drivers/cpufreq/amd-pstate.c    |  6 ++++++
 drivers/cpufreq/amd-pstate.h    |  1 +
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index e671bc7d1550..30835d0e4994 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -242,6 +242,8 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
 static int amd_pstate_ut_check_driver(u32 index)
 {
 	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;
+	enum amd_pstate_mode orig_mode = amd_pstate_get_status();
+	int ret;
 
 	for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {
 		int ret = amd_pstate_set_mode(mode1);
@@ -251,16 +253,19 @@ static int amd_pstate_ut_check_driver(u32 index)
 			if (mode1 == mode2)
 				continue;
 			ret = amd_pstate_set_mode(mode2);
-			if (ret) {
-				pr_err("%s: failed to update status for %s->%s\n", __func__,
-					amd_pstate_get_mode_string(mode1),
-					amd_pstate_get_mode_string(mode2));
-				return ret;
-			}
+			if (ret)
+				goto out;
 		}
 	}
 
-	return 0;
+out:
+	if (ret)
+		pr_warn("%s: failed to update status for %s->%s: %d\n", __func__,
+			amd_pstate_get_mode_string(mode1),
+			amd_pstate_get_mode_string(mode2), ret);
+
+	amd_pstate_set_mode(orig_mode);
+	return ret;
 }
 
 static int __init amd_pstate_ut_init(void)
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b961f3a3b580..af08049fe96f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1305,6 +1305,12 @@ static ssize_t amd_pstate_show_status(char *buf)
 	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
 }
 
+int amd_pstate_get_status(void)
+{
+	return cppc_state;
+}
+EXPORT_SYMBOL_GPL(amd_pstate_get_status);
+
 int amd_pstate_update_status(const char *buf, size_t size)
 {
 	int mode_idx;
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index fbe1c08d3f06..512d5d97806e 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -119,6 +119,7 @@ enum amd_pstate_mode {
 	AMD_PSTATE_MAX,
 };
 const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
+int amd_pstate_get_status(void);
 int amd_pstate_update_status(const char *buf, size_t size);
 
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.43.0


