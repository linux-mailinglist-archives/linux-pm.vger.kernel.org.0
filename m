Return-Path: <linux-pm+bounces-18748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89129E83EB
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7402B281A62
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B803D66;
	Sun,  8 Dec 2024 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WX4H7RI/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12F13B280;
	Sun,  8 Dec 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639462; cv=fail; b=enWwzQJCh9JsPCnob9KPsz4oyI5Em/qR/Z2JCLgBjTFVRD6UMJBNITd4ghzDTfAnbVM3k/flsJnKaTw4WwG3iAGkkRvM/0lPZ/Dhtif5cq9j7FY/fGfkZwM+M65ajD/PRQj1Bz7W63mQ77GZhN6GhvUl/Xh+rLC9yuuZdF+cTiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639462; c=relaxed/simple;
	bh=bIwEkB4RisuaBUId95SyAh/ypfFCch8mxVSwKmvYZ4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1epgRZ/E6nkxjQLhxNZ5BKIZMTeDIA7mfDSrQSW8fWeJp9OvAYyYhFkr4i//z2uggCuGenTs8cZ8kq+wmLLlgrqX7JKNgwi71xm/8SL+Jsie8TzX27c2tV5HZ7URNE/2kOn1EcDqWRMy6GnKaZw+/QhDc3K8yv4xFk4ooXsn08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WX4H7RI/; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqSybazk/6r4N0C3r+PUZuEzIPegcARsIiR5Ayk2Lg6bkqJ6ZHGhcw08Ub8FfZXL7I9pyXYsSvaMmbLZ2RzMCKcsA+01xhTkg9TIU5sdLEGcJz3n3JxiAhEz6R6aVIo2+MZOrrEWQrBprQjwdsW+tnol6Lm30zidLab/ZqwUzVGnEBGaVBP1EDmFXUnhuAlOTvFO+fW130bDnhkSaYVDKlKlLXKtLwSAOQEm+T8MX345cQbzaQZz1AvvfYSgV2z6/R9RzH4HAXytm02PwbiAisAxXzxsIbCRogr9x1qc8iUCrbg0yywh8fKrYrPfaFGTnOzQyOeHZSM3PB6DeDwZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58MdHhkW1tfwOPWWvmX8ZgK7hZsGT/j6kAdVv3nR6ZY=;
 b=rzSobRA1iAHXvWXnuZ6uGTTOV8XI9W68x98+XeH1eX4yqAzo/5rItvRMvEgV/iJHfmNDile/vGoH1WgdIJi/y5C0jXGpRJIqdop6d0eiFvXu6IXbOxo+MfoYFGvcORobQW+sD4fzvzKcFmF68OWexnThyxtgn4SrOli7cq0gQR8lpFtzS9DPinj9VwM6czRSXc/yrLXlMrP37Gga5TZUsktBs4due8K8e5LEnDvUAQLnSMRJHo5hhxnjma983Z6+OZ//0GGHhiNSYiEPwbBJvjEOAwb0XnffejncD+02fyqffE9ZqdTR67shpNB5DT9llzbrJuKGGW5+72oWo4IN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58MdHhkW1tfwOPWWvmX8ZgK7hZsGT/j6kAdVv3nR6ZY=;
 b=WX4H7RI/1uF1uU+EzAKhx2NfZe/ureYOrPDXB/kX7jfzN0lSEdcgp4YgKKClZJoomD4PacNWBoA5F+9dLDAp3cpoDSo43FAtIcf9ZjUVnhkBtkqO/kvuda5ZVYFB9cbHC0zBY2F+HJIQz1H1Y9vgyLaprqFfhh33+YPXl2FVHAc=
Received: from DS7P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::11) by
 IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Sun, 8 Dec 2024 06:30:56 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::b4) by DS7P220CA0004.outlook.office365.com
 (2603:10b6:8:1ca::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:30:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:54 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 06/16] cpufreq/amd-pstate: Use FIELD_PREP and FIELD_GET macros
Date: Sun, 8 Dec 2024 00:30:21 -0600
Message-ID: <20241208063031.3113-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241208063031.3113-1-mario.limonciello@amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f493ef-5b00-4cab-639a-08dd1751df7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w//cFdOE37yygib4glWmp59LHx/f0xvJ6LeWKeCLc4uAjbmn52phyr4tP6QQ?=
 =?us-ascii?Q?IqofBGuy5yeKJ2sXH7trOv39UQO4AbvAlrtHiea64WzNznT03CfaL44lJ76i?=
 =?us-ascii?Q?xgUX35DNp9I3b76Ez5IcXYZcz0mNCAZ5KqXhpwvaUF1o1bHATKVlJ9eiKwb2?=
 =?us-ascii?Q?qPBO2cjYmaBRSDyMeYJjDMmbBtQHwxpm+4KRwlQFoH0MdDkEucL33H61T0pv?=
 =?us-ascii?Q?fHo05jVStSZnaQVRJKcjFh5n5wiBv/YucEkFFWq6nqqzCYjm8HWjRZ4ScknC?=
 =?us-ascii?Q?rjdqaq4RDsObH7w0nWWcQvmopCRrNDe3JoRSPpEA6+0p/oLDzP8lCp6W9/7S?=
 =?us-ascii?Q?4Zk4faQbySibhOA/6318APDodzrdw6PRBUsSYYaf9Akr8ZUzWRTQKR1hHDW6?=
 =?us-ascii?Q?PFnAytji3gPJdE5K7+4jb9UMZUqNdnchuiQxfhmRB6QiywMI1paDA8DVY5lU?=
 =?us-ascii?Q?Tx0bc7ObSVaBLKPTRhRAtqkObV7MybOLAu4Dg3vCiKNjIrW78FX91dgFjril?=
 =?us-ascii?Q?H0rCpxdqH6ix1KpPNHyNg4RAcOJwgzPDQCUqwr+pEvKREmGeoYs3iBGTMyyL?=
 =?us-ascii?Q?eb8IjshXMvoOxbnBt58YyUlKR/8b4qWyGpewbpOqNiQEgA8saVFOSr4vnqak?=
 =?us-ascii?Q?O83jt3v06fTXb28dxfj6xhSBPJohmiXzOXDVJQ+HHf5Q1PTV/6UjoFvCQyqr?=
 =?us-ascii?Q?Hxrw5oGmRQNZoofuixH1xYuQmNA60dc2SnZOS/oFCW1bVheBOPfdev3z/XuC?=
 =?us-ascii?Q?Ril3iNMLCpK9ZpAeFGTpGHZtJbVAnpwQa5FA3Yp/wKkxIl89s6kmawA40qgI?=
 =?us-ascii?Q?ekf57Z6vz6MiPtO6IyPWEcIFELTQEhYIvzlqqpUZGgpkQTI1p4XWVA/fsnEI?=
 =?us-ascii?Q?DkxF/nAq088QKD+2UvNW/64WoZBrbcXO0DYrB+ql8DJHhS02NOJryG2O27zq?=
 =?us-ascii?Q?uAEBNUWP1WyBxLopRNRo3NfYblbO8HyL8oU5IvjKpenn2uQxPJH926VwuelL?=
 =?us-ascii?Q?ZOOsaWE8bR5N1ZO3QuJccfvtXRuKXP4gfnitBG0lUN8vqOkHOK9QQKdKWQsv?=
 =?us-ascii?Q?tE7qfS+YL7zbPIU0JsRUTTUEV4OWAmmKURQgygewO8r/LjR9p5cq+F1x86P7?=
 =?us-ascii?Q?TzcCmoPxOdX6lv5K/d5OPFji29OML5lIgMVUlrJalvJfZtW28D8Is+gQD5k3?=
 =?us-ascii?Q?rTMRU9/t8VbANxGep8Zl722OIVocV9DDviRzgWWEhU52yNXLxXW2HKimsYXb?=
 =?us-ascii?Q?JQv85LVoRU52Jni2dhnZ1eJOhC6Ykl+Hix8TvJbPALRgi3/o2yA3qOsNVW2i?=
 =?us-ascii?Q?yQ/Kl1UMSwomLpVxSjr0F9Hfs2zuQ4iBWsTGOv2Bf2xAyvoKVMBCydyzl4HQ?=
 =?us-ascii?Q?zKh64x9HHjHDFSuPZm/6dErAwKUhqo2ESLft1LzP5vC0OcTMpyqeE4G4O8o1?=
 =?us-ascii?Q?5Xhf3NAcC+w3VQpQvMAGm2w7BpVNNXow?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:30:56.3889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f493ef-5b00-4cab-639a-08dd1751df7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

The FIELD_PREP and FIELD_GET macros improve readability and help
to avoid shifting bugs.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Add a missing case to traces
 * Use AMD_CPPC instead of AMD_PSTATE
---
 drivers/cpufreq/amd-pstate.c | 51 ++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index dd25e7e615984..0ed04316a8d80 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -22,6 +22,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -88,6 +89,11 @@ static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 
+#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
+#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
+#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
+#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
+
 /*
  * AMD Energy Preference Performance (EPP)
  * The EPP is used in the CCLK DPM controller to drive
@@ -182,7 +188,6 @@ static DEFINE_MUTEX(amd_pstate_driver_lock);
 
 static s16 msr_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 {
-	u64 epp;
 	int ret;
 
 	if (!cppc_req_cached) {
@@ -192,9 +197,8 @@ static s16 msr_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 			return ret;
 		}
 	}
-	epp = (cppc_req_cached >> 24) & 0xFF;
 
-	return (s16)epp;
+	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cppc_req_cached);
 }
 
 DEFINE_STATIC_CALL(amd_pstate_get_epp, msr_get_epp);
@@ -269,12 +273,11 @@ static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
 
 static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 {
-	int ret;
-
 	u64 value = READ_ONCE(cpudata->cppc_req_cached);
+	int ret;
 
-	value &= ~GENMASK_ULL(31, 24);
-	value |= (u64)epp << 24;
+	value &= ~AMD_CPPC_EPP_PERF_MASK;
+	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
@@ -327,8 +330,8 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
 					  epp,
-					  AMD_CPPC_MIN_PERF(cpudata->cppc_req_cached),
-					  AMD_CPPC_MAX_PERF(cpudata->cppc_req_cached),
+					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
+					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
 					  cpudata->boost_state);
 	}
 
@@ -542,18 +545,15 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 		des_perf = 0;
 	}
 
-	value &= ~AMD_CPPC_MIN_PERF(~0L);
-	value |= AMD_CPPC_MIN_PERF(min_perf);
-
-	value &= ~AMD_CPPC_DES_PERF(~0L);
-	value |= AMD_CPPC_DES_PERF(des_perf);
-
 	/* limit the max perf when core performance boost feature is disabled */
 	if (!cpudata->boost_supported)
 		max_perf = min_t(unsigned long, nominal_perf, max_perf);
 
-	value &= ~AMD_CPPC_MAX_PERF(~0L);
-	value |= AMD_CPPC_MAX_PERF(max_perf);
+	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
+		   AMD_CPPC_DES_PERF_MASK);
+	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
+	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
 
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
 		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
@@ -1573,16 +1573,11 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		min_perf = min(cpudata->nominal_perf, max_perf);
 
-	/* Initial min/max values for CPPC Performance Controls Register */
-	value &= ~AMD_CPPC_MIN_PERF(~0L);
-	value |= AMD_CPPC_MIN_PERF(min_perf);
-
-	value &= ~AMD_CPPC_MAX_PERF(~0L);
-	value |= AMD_CPPC_MAX_PERF(max_perf);
-
-	/* CPPC EPP feature require to set zero to the desire perf bit */
-	value &= ~AMD_CPPC_DES_PERF(~0L);
-	value |= AMD_CPPC_DES_PERF(0);
+	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
+		   AMD_CPPC_DES_PERF_MASK);
+	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
+	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
 
 	/* Get BIOS pre-defined epp value */
 	epp = amd_pstate_get_epp(cpudata, value);
@@ -1652,7 +1647,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
 					  cpudata->epp_cached,
-					  AMD_CPPC_MIN_PERF(cpudata->cppc_req_cached),
+					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
 					  max_perf, cpudata->boost_state);
 	}
 
-- 
2.43.0


