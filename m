Return-Path: <linux-pm+bounces-26314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB062A9E829
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 08:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6E91892711
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442151B4153;
	Mon, 28 Apr 2025 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cOhuzqij"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2533CA;
	Mon, 28 Apr 2025 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745821599; cv=fail; b=nVpz2oJ1uWen8HuY0ylfMgtrcg2arGiJ261sV0d9jQIoQDFjiWZ29pN8nLR0dX4JtMdCfKTnKgzijVK1hXGiuwf4HxuIaQwleoh3vh16Tdl2CBhD2r/T/q9olOPlmedX0WFrM7n1eKECPJrGqe0M1HnkxTJtiC29Zd5Xv6koAxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745821599; c=relaxed/simple;
	bh=bqUtwFEN9ryEUuCMTCnBTcuKPgU+xEqdnus+dqPLoZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZXcqJKf0k1laM+Tb+YtG4VQHZZ9zMnPukfDT1FILOubvCP+jLxysO50HKEiY7MOluhRfdsU3zpkQwYvLSlyMg08nDE4qakgSFwRCKUfxLdg+G0aZoPC2exX4n4+lS0LKNeYMSX9bDzCDsDWdBLW6SdS42XMFNDY5b3g5F8SCco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cOhuzqij; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyavJ6S9XJLLYy0cQqwTufFyUXr0YqGQAlgDRTA1uk9HmWIurBB8NpgTuHfiLynLxDXzrrLyQzQxAXc/dQnmFmnc0Kznodxm3jpA0NJ+u+Qzpyed52Bxj0wm7m0CcnjzjOfn5w9kIORKsCgH+6ZmzY5shOllw6V5x1WQhBaO/kmLtkK2PgKsEbV3Zb1w3ZCqBZVdg2/jhdz52jdEKwqh5nBoQViwpZdHA/4604tOXKjpANLT+Tao2rCOrb7qnkxu7B3IihBIb17EaQ7dRWWgLB1iX2x1RRw7ixsUOE7kZY1Fr0FZbxSwh9+xI5O9pDoQEycGNqRFRw6P9JVmX3kZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W64t4/OV+vWYwIaE4De2LX71D0qZW74dJFBFY6JHdBE=;
 b=wT1U7q0hg1pcOZS6u86Ezop+paIP9zctVZuPd/YJPOm/cGjiPYfSNZlFSOQRr1KmXt246AmgfYzhDyN5CxaW7CagPY2KFArDIeyD/NR8TGoe4Tcr4esVNJ9/N1uC1auKNGtNRTZuHA7OWbCxssPxLBaU2wiqVywn6KviAVVN43DZi4kZFbN9H1+zodPMAoBTGotgxyQRwEXuVUL2TYf9snLzBVi/1IJhykzeKSk25UsbWxLJKshezEU12Y0KxiG+O9Xf2llUuOuMqGw81qvQANGj27FVFRHJGCM9jfcS8izY/ZaM5ePkxa2BZJsZa2dQuj/rXjrYyi9JHmRmh0M53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W64t4/OV+vWYwIaE4De2LX71D0qZW74dJFBFY6JHdBE=;
 b=cOhuzqijpQ4bWBGHi9FKZZv8J5010VYNnDrJkaOMMAY/6jWAf5NHsWo7Ry7kKDbrTklybbxLpJLlUW1bcRYZJ3Fqe6SFQy9oIdHBeDpoVk5gwSasoIBspzVV2ipnJkwOuaGK+WcA7HuYKFE8sVg0tyBRzKK1RdIO8Nu/bPl59QY=
Received: from DM6PR06CA0075.namprd06.prod.outlook.com (2603:10b6:5:336::8) by
 CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.31; Mon, 28 Apr 2025 06:26:34 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::1) by DM6PR06CA0075.outlook.office365.com
 (2603:10b6:5:336::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 06:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 06:26:34 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 01:26:31 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 1/2] cpufreq/amd-pstate: Add offline, online and suspend callbacks for amd_pstate_driver
Date: Mon, 28 Apr 2025 06:25:21 +0000
Message-ID: <20250428062520.4997-2-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428062520.4997-1-dhananjay.ugwekar@amd.com>
References: <20250428062520.4997-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 7188e9cb-0112-48be-e588-08dd861d9f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MixFShF/+zQF9mfASmvnyo5/gM3WyuqcJSONpZ++Ssie3nzjeRe51d4VpHCs?=
 =?us-ascii?Q?wR+/AEGP7HVjJLAewruyUHFoO0P/dNH1qeB7XIA57GKK+Mc/7cpBmUTw/xkl?=
 =?us-ascii?Q?r3S9g6saSTkVruVxjnecTfxedF7KlcmVsPCl+L6eoGdpAgSMUwWYQN/gpauS?=
 =?us-ascii?Q?kc6AXg/cFCidlqRKCLMtwv/JRV9G+ClyF49gJNdyxha1EngzA/HriwJESZoS?=
 =?us-ascii?Q?GE8b2g2Xc7cp6K8lJ5g4jbZkOJN/SECxBA5IBaXxoDqOe/OMbStWLxL39+Dv?=
 =?us-ascii?Q?ibopwn0Uw6NtdQ++LfA1JMDTGO8HuBcwyMil/h7P9+UN4O4ghVmNFXrLvoWo?=
 =?us-ascii?Q?ulsDyXx+Tz6HzCcre/agTQXEuZJ885vx7YfSM6m4pkwno56FJtBvF3z9Gm93?=
 =?us-ascii?Q?wnFX0NAWkLeuskUFiyFVtkyqGVp7X+4EGIjK1enzys3hWygNq6UCODDtw9wS?=
 =?us-ascii?Q?98LYugTna7J/wg/0Q1Z2M+huwMzGH6SQE9cTK0zzKKwwfVK9oO40EyHCmh9O?=
 =?us-ascii?Q?mel2V5nJCcLdPThL7qulI6ic9zJTqv7TOnbPeLLo15ZPjYglBY66pgnXIOWP?=
 =?us-ascii?Q?lJ/psat6dN29Oq4GI3puc7fgz/R8bj+9RD6589b/G3hp+wBhmOzZhqBOoqiV?=
 =?us-ascii?Q?dC22hCd+byLW35XXapnKhwz1WJ3FX4QxNgyPcRnxOUEX16gVKG8ottzRrR5k?=
 =?us-ascii?Q?dd1/3MuquxjOYWAC92lFuYzvyuq580KCIO2FAIxOAeiYezkLaVBip2m4SjY1?=
 =?us-ascii?Q?8kUnUTFy5JVg4hNSTLYHgcqAxKWXUcII/PEBK0wTbRTOTm7TlJx9PBTPv+cq?=
 =?us-ascii?Q?vXEIyL6xb6QJPE+ZJJm0L6G/aJsC/7M2gnpX/I0AIAe++TT0OXIG34eRmrAP?=
 =?us-ascii?Q?4PmZCPIdqHnoSzPcQHnImEK4bmfAz7KVtnTiTI2SJKSm+UaNkQirWkluYRmY?=
 =?us-ascii?Q?E0CvOWuCHP0ckDBELvfb9kGaLdUilWzaWkmy7tDP/Onqxj/96beODvNW0Zdx?=
 =?us-ascii?Q?oVRPbflhsnqhRgWa3b8ZjOPq+dwNBfxrRtMmiA1t8SfKnJqLNecRAorpIrzi?=
 =?us-ascii?Q?9zDYD6qn3FbXbwJwwSlQqxp7O/fjm9CB0fOhOhELc12O0gisphiljMJ486Qv?=
 =?us-ascii?Q?SJJdD0xWM8wDQcNXbhbk3S5tGJ2Gj5UnsQzMB+BqiJ1w/9L2jNzDGhVwINp/?=
 =?us-ascii?Q?r5F2fyNuEsc3xKZXivxmmMiVDhs0LWsaFHsUHIymVIYq3Zxnr/L6IdSEAii0?=
 =?us-ascii?Q?90Qmiwh1sbbgT0/jiJgli+uCoipiQ9okL1CnKVTdogTCciNbxRABssDmIwk1?=
 =?us-ascii?Q?Vx83jz1+GZn9D5/eu733oCmV2Dp87GRh973ArmeUnJvsVeDP3YZ5Gj/S0YVw?=
 =?us-ascii?Q?uC6A41d3jux60po6s1Imx96OXn2hJj1E95jvNnYJtq1UWwengM9RKIAQzbw+?=
 =?us-ascii?Q?g7MnKxo5KJ6sk+63zNpnP9UPslIrxwepil9WPsXEM57ogpi7s8j83mWRji1F?=
 =?us-ascii?Q?L44ICjqP5vwhHrkhC7RhFwjHI+VJE9uCURfy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 06:26:34.0233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7188e9cb-0112-48be-e588-08dd861d9f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

Rename and use the existing amd_pstate_epp callbacks for amd_pstate driver
as well. Remove the debug print in online callback while at it.

These callbacks will be needed to support the "Requested CPU Min Frequency"
BIOS option.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c29840ba3b30..02de51001eba 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1568,19 +1568,17 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
+static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
 {
-	pr_debug("AMD CPU Core %d going online\n", policy->cpu);
-
 	return amd_pstate_cppc_enable(policy);
 }
 
-static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
+static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
 	return 0;
 }
 
-static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+static int amd_pstate_suspend(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
@@ -1618,6 +1616,9 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.online		= amd_pstate_cpu_online,
+	.offline	= amd_pstate_cpu_offline,
+	.suspend	= amd_pstate_suspend,
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
@@ -1630,9 +1631,9 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.setpolicy	= amd_pstate_epp_set_policy,
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
-	.offline	= amd_pstate_epp_cpu_offline,
-	.online		= amd_pstate_epp_cpu_online,
-	.suspend	= amd_pstate_epp_suspend,
+	.offline	= amd_pstate_cpu_offline,
+	.online		= amd_pstate_cpu_online,
+	.suspend	= amd_pstate_suspend,
 	.resume		= amd_pstate_epp_resume,
 	.update_limits	= amd_pstate_update_limits,
 	.set_boost	= amd_pstate_set_boost,
-- 
2.34.1


