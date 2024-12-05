Return-Path: <linux-pm+bounces-18652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B0B9E6092
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DF716A7B3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE401DE3CA;
	Thu,  5 Dec 2024 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4wmUK8uA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17931D5149;
	Thu,  5 Dec 2024 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437755; cv=fail; b=I4PgLb6WD8BjoDdFZwcFZAxoslxXiQH08+ab3ilXymAk08DTyJ6EA6r7vlb6okocGLsZzfWVLB6sy+XePN7EWhYNzn/asSXAs890Nq/zh+KmF+h1T0x4dVpvg1F3Yy7bSMjktEcGS/avd2+k3a8EPt69mLyiUvxdulwJH2CmKdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437755; c=relaxed/simple;
	bh=B8aMeNGJNUFWB/u8rEC0v5an9zJwunlq7365zy16Ya8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTUoHqLsetxH8n9LaNmqijaRxbeErXIN57/mgEY/GmlzSzHgTKaGPqEn26gCxB+JwMvIfCOEFlvMCjYL4O7K3DgIGbWQkJctE5WCnsow+hevpGP0zX6w2Yd1+R6OlFh7iZLw8bxJ96XuAK8SGa5sxiJsFR+8jswz/fgB9qeAwIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4wmUK8uA; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUzsMFewNcifw4ElhiKON5GN1jX6YAf0I3HIa+lGdKc6P2E9sFuqMdovmP/j22MK1hIxVfU5MXiszED40f1D8iACZ1jwj/pqvZb/E00u4Hm79dTJzxkvuncTrwcU3jZr7Bmc9LFXaVh1przkXBeDrTCDY4n2EZ36F4G/uQRHlTTtCxp7xhTxLCU3sJzw5YeabFyezG2W7lPdHfuuCZLgC2LFK3e2neyLhrSeU0dzVTcP/7JHfXEMGSxat6daNl8dBj2cD7V3/W+bhDDypH2/jJn/eO3fwOc+fErJxsv3J2iAfxwb2B/IiOTnnm7mBQRDrAjrkbskQNTDheZdq66zXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znql/bVl8wuG7jJkgEDCCBVUI7fUqjnUdPagBUbZquU=;
 b=OGo1YY7ikYSaxvZQVVjvMSCk7XdhT/OKJv1Z8iTSPTEmZ4aYGzB4EY+llkZy0NH8b1QRwnTYkYr58Ueli9g2zDbmxCtpQMCBO6UQhnmqtJK3uPVu6O7Q2KifA75r0sl3eoZZBnEJaTb0PSdIqqnzEL1SMgBA1blQO1KWahmakN0rQ4+/qAT7N2MZ9IU+ZLzKYic3fBZzEDQa12jA/fBZctAJWOttewf+tlLZWSTSBBbRbQHfWEYRvHXiuCmOR8oqa9dY1VqMv1ro78hh/+zdYLgDInADoCRSerG5mP3q30BDqETwRUZhxH/PJ4TIdSlhPyiWU9wQNrHmJgx0bmhPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znql/bVl8wuG7jJkgEDCCBVUI7fUqjnUdPagBUbZquU=;
 b=4wmUK8uAqSRQtXPdqwmC5BcbBV6dECuzxugUA/Oousg/j1hPlsf1IR5plKle7kOB9t8eK4oq0Dr+c9gZSoDbOVX1L6r4AMEBNpmGknkXBsbhTyG0d5kNZr4kbghuf0KumsPUAJO4TGqZ+QN6aVUjoUL8uIlVDYkhlmUSb5W0lxM=
Received: from CH0PR03CA0209.namprd03.prod.outlook.com (2603:10b6:610:e4::34)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 22:29:09 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::4) by CH0PR03CA0209.outlook.office365.com
 (2603:10b6:610:e4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:07 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:04 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 06/15] cpufreq/amd-pstate: Use boost numerator for upper bound of frequencies
Date: Thu, 5 Dec 2024 16:28:38 -0600
Message-ID: <20241205222847.7889-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205222847.7889-1-mario.limonciello@amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d54f203-3e89-40e7-6594-08dd157c3bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?If7S57t4QYKUsj79W2Tsbd2jMfXBwkNzBC6ayYzwtITxYW1IyKU1XmbarcWQ?=
 =?us-ascii?Q?68U6l1NG+K0d3Og9MxYJRZAki2+sW8zo0H2jsKK9usLz3n8641KjY5ccgNHz?=
 =?us-ascii?Q?6WIIP0SHgFbeK1ikitmcDjPaQLdVOY/b5IBhiSyCFo6wwfxIVTUJbbTNJ/xd?=
 =?us-ascii?Q?OyvVwCQPNKv5FUGEuqpvxRemWiiqkp/Ne47fxmUrwpgQEMlSbOoZAlgMboQo?=
 =?us-ascii?Q?hrBc6nTVTr6KCtDsm6QLELv4AvYB5qKYmnXK+PL+N5bQI2NwXsTQbio3JaAO?=
 =?us-ascii?Q?6toTjav/68f+IlqXk3XTgZjz5qnQN/hP6x2nuV3Hpk/mYIg1xwM8b2TPbmwe?=
 =?us-ascii?Q?lqogfkwnI6nR3bXP9OvwR7W9SzX514NWzVa2sgDIBCn9l9F294oDSacAqQ0D?=
 =?us-ascii?Q?8zr46lyb4n68ltKtoGLVcFaOcHctxtj27NIgfYtKt/yLOs2CCBU0cib9oFx6?=
 =?us-ascii?Q?xY/JD3NdT9nEwrqSCB8g5HUMd759MDozjq48FIQRwb6RAq/4TkKdwAsICp+6?=
 =?us-ascii?Q?I2EonxQfPGRTSVs6bw7/Cu7mO1wy7oeGWI3577Wm07V6yRi6HA/B5uW22ITg?=
 =?us-ascii?Q?FV73dsqFjHDKcKcFNXCCWALJeOBLasYR8oVLSVSTLwjTwc8GSCvw1H8kJ929?=
 =?us-ascii?Q?IC4UTVpbXe7R7sNkPxWKh70WC9zblTiv5lr12E0JpSQAAoGg855LF5QvLVyk?=
 =?us-ascii?Q?ZjJ4KuqR1GQQC/Ul6Wn1zNiCbdUyptRd6dPs3onhVzxQT7DOUZNZSxgzNVAF?=
 =?us-ascii?Q?TvUqi/K8ZiKjUF+HMcRnxunZSGWWHI8Yej2WtjEKXPu88cjfhc+PMCwj0ZOx?=
 =?us-ascii?Q?uvQR/1WiigbJ3WKG9I4frq97Ird/kg15+S2W+H/5veP2TxHgCXrf8nYoQXWQ?=
 =?us-ascii?Q?5Gm3bof0xaWT2iDd/Zao03iq73EJhxU2kaWfToo0FzLIiE9JLK8wbbr/x1I/?=
 =?us-ascii?Q?BiatePAxSwtZMxyD4Pge9DDHMdbW3yXgB0Va93D625PjSzMxVB0HHeIZy6tu?=
 =?us-ascii?Q?61df+r8Vykew10qiGrme1rJCKyO+mEle3BlxuBP4uhoTUqZd+zxIO9o64VlI?=
 =?us-ascii?Q?5Kz3tjT/wwwd/BcoewHPER2ORGZQ4nD/HeXwpykwI8C1FT1bnXLuf3NHQ4KI?=
 =?us-ascii?Q?+N2HD+VcsziJF5zyfyklAmSPtyB85jFQBkqpgw6VIJIJoYPCuhg5B3UJeXJC?=
 =?us-ascii?Q?W9jCHT8u5w/1mNa8elQB7uU8yFPm6qAspbeQm/nD3trcCqeDIPtoekOKI6QY?=
 =?us-ascii?Q?V4B28as/sCNOC7QR8DgGfnnP5dzuV+Jrj7wFJ9r2HNnUf0hcXLoaQTaHgbxE?=
 =?us-ascii?Q?eQyvYJQqEoNca/AJXNwJe8C8VStQd5oia0Ako9xFkAwPj2GWJD9lx21aB5OA?=
 =?us-ascii?Q?sDyuX8zYm1tZpRdHcQkkM2V2/Qfeeo+qBCKw24ZzqLBEA5Aqys2Lw5M6NYud?=
 =?us-ascii?Q?kZOJ3IfMwugVuA8e2XH87f9cz5aB+2Fh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:07.9641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d54f203-3e89-40e7-6594-08dd157c3bd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

commit 18d9b5227121 ("cpufreq/amd-pstate: Use nominal perf for limits
when boost is disabled") introduced different semantics for min/max limits
based upon whether the user turned off boost from sysfs.

This however is not necessary when the highest perf value is the boost
numerator.

Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Fixes: 18d9b5227121 ("cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 738f63d70546f..14bd6faa3d730 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -601,16 +601,13 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 
 static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf;
+	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	if (cpudata->boost_supported && !policy->boost_enabled)
-		max_perf = READ_ONCE(cpudata->nominal_perf);
-	else
-		max_perf = READ_ONCE(cpudata->highest_perf);
-
-	max_limit_perf = div_u64(policy->max * max_perf, policy->cpuinfo.max_freq);
-	min_limit_perf = div_u64(policy->min * max_perf, policy->cpuinfo.max_freq);
+	max_perf = READ_ONCE(cpudata->highest_perf);
+	max_freq = READ_ONCE(cpudata->max_freq);
+	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
+	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
 
 	lowest_perf = READ_ONCE(cpudata->lowest_perf);
 	if (min_limit_perf < lowest_perf)
-- 
2.43.0


