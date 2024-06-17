Return-Path: <linux-pm+bounces-9281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF190A647
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B3C1C26DF6
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60C818C349;
	Mon, 17 Jun 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HXzaaYse"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D79188CB6;
	Mon, 17 Jun 2024 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607625; cv=fail; b=awd5cXo2dX2JB7XEYXzyR2+WZ1moRibxe33s7lZLilSQtojZU9dRGc9z7TiZMFjxAJVYhbjtbh6Zb7Ed73mVOyAH3M29EsyC4k87Hb29VezTsal6Fq2tHRz1qBO+YLWrQrQJhfjFotCG6UMnm48JO5myN8ypsjL4C9oOkdjpdBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607625; c=relaxed/simple;
	bh=nzTg83Tp2KVTOlE7x+0Ug5wzeWbrkQurFgj/6Vnnpfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfDCh73pro4mV5pN+mV/1UOiWa4ZtOAnwLlHiEb+wv7LHEToMsDvxI+P1RunvOEZ3nM8CindcZ53wiyDBnvWfxXVtKx/eJaYfHCS8R/0mPvFPA/JyxIezfZyGmCJEqu/aEd8k0u3sR0ORXAgrdWZ88q1O3XDb3vu1T2bKBMFANc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HXzaaYse; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTFHcX6xp5Wg8kB8YItUhTbYE4SEpTOIiIlGB5iYJOGF12NvwtRxtla52wTb6AR0lj3mwxQl8GW9PSEOFyKhyhXg6dYGpsj0ZZfiCBWZiuDQVw4DaMgQ3CBtiUp8KCBz+jKCo2XX6nDq1MgkN2e6Fo/BHoMLN3vGAghuK2NlZFS5fPFdmuYm2tfafmoyJwU9VDNt7Zy68VCj4yWVuGsmJcgDJbqZQT2nNqpJOMrATaEcKhbu+1tABzkhuaZEmBIyLIF9PeWG+674Rx2PNtDIbSL5H+QbPWY1f0R8qtyULZ5G/z6CmXHuQHIlXkjh78LweGVQyMwySHp49pawDbsPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sK5KXlwKPkdIGyjDy5laceL9Hg4OojtpPlfVYO0BjM=;
 b=gD2iHSbXePywNm+rE8MGHzS/713mPHXdcYDKPryqgs2WiZO+TgfYOpbiJ6SvSSiJNAfe45TBnGdN05A/GgI6o5ChvgGuuFyCfhtm0AkRWritXnTY8HHZ6kX0zpOw3z9RTO5bGcJ8TGYw5jBT9VTFiLOrB5HA3+QUBgRw3AT5nb/2diir7XEjc3iPZFRCyZ9PnLLo/oYZKqxi00pg4eA8CBv6dhvHdnvXATx1jTi+j0lD5LCU4NWomlDeOiwUcE62nSl6xSMfg3alowQiC0+JGPe0wV6kORjq4vJNdzzi3zLgVQlZ0mjV9CZ2dbHqX+FTZmjvM9k/TVWU/Y1ipK2A7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sK5KXlwKPkdIGyjDy5laceL9Hg4OojtpPlfVYO0BjM=;
 b=HXzaaYseeT6fJyhUwF7yKOO9xPgN8KpGiCFicvjiHdqJ2JfAgMacioRTCQu5M2EKQ7EDYui1X1YvhxrpT/QBMnKmMcHf4b38hzRD3Hhn2hAtOyBScUzuLV5QQvD7wC3VxUpFlm+E7peb8EdoJCrns/Yqh4xUNo3JR9IXJH6HdsA=
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Mon, 17 Jun 2024 07:00:21 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::4) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:21 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:17 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 02/11] cpufreq: amd-pstate: remove unused variable nominal_freq
Date: Mon, 17 Jun 2024 14:59:04 +0800
Message-ID: <afaeb27161045d08286579c08277d30e00c8406e.1718606975.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718606975.git.perry.yuan@amd.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: b16d65a1-f0ef-4674-eb5d-08dc8e9b277d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QExYB642lfv1qppoZtRgTOC5A+W/2Nledp7kDh9dzHGhSADNxHqZT2sBKOx4?=
 =?us-ascii?Q?fm4Sxumg7tU9LkObnnuJSJMJrVJSJHUg0yYknaco7LD5+28d6U1lbK1Xp7IS?=
 =?us-ascii?Q?nevmVDJ37GTl5gRJF0vrBCV9M27l3TrdUh/pQZkeQ5dG5hCu0VVQwSZiy+p4?=
 =?us-ascii?Q?mh8ZTMe3ioJkmtkL//B+wo2ctRONXFWlNA6K3kP7Oji/PZsN8xYrJB9VqAVP?=
 =?us-ascii?Q?cIm4e9OSinDOvmLW2lGmB6EraKOqLrGNw90svzP7Q98flvbwp1hvcQEgc6O0?=
 =?us-ascii?Q?dEgsl52hyJsKXYj0rc6xYvMAfNYZqw95j4lWvPuDE0EXRBZihkJualqIUn3g?=
 =?us-ascii?Q?8yxzJYnrMaaHEkIS6gUPKNYIbG68X+z4Nae5PSdEGwmd7ksg14oa1AtL9l7v?=
 =?us-ascii?Q?kkKxTz/yzTqHqESkgymJtG2Ny89n7dp3KoK4Y3bTpVpDIoyc4oi2GUtM97T7?=
 =?us-ascii?Q?64rKet3ZxToE4+qFvSdDyUTtbv5YYeezplHD0fvw2blXseY36tdPk/SmaTJy?=
 =?us-ascii?Q?O4lEaY5E/Z1YEXMJokfQiViM2Vvv+z3z54MJvj7m/gFfNe6+9KY7xeF2IamA?=
 =?us-ascii?Q?SIamuZM+YVbGyAQ+PbuB+aWjVaaRue42Nu9Z1IWZ6YqjtXxERV+Ojmd4DLvR?=
 =?us-ascii?Q?AAtuJwapIHoXfdHI9Xp/ShZak07xzpGWpjeia4mLyVcUW7iEbEajlNTgRmyg?=
 =?us-ascii?Q?sMskCIzhvpghxV/+2X2vMX3hbwBPVF1ft7+JYqVgaxNzbCES2cwqLoP6fCla?=
 =?us-ascii?Q?gxhr7GLjGQUEw0b35HQ7msVZAa4gpCgJMH373kOZb7YK99/8fYptCwwIYEUK?=
 =?us-ascii?Q?tflMgj3wB4mu+qjZlTUtSCzOOeCPiHadOOYzvBsq3JikG5xu0vMCLSN6Gwot?=
 =?us-ascii?Q?bNB94VFmAuglTALAAKzs5kz5b+f9mzQ2u/V+SZAUH4kdEVfe3ZnYa7jKf4N3?=
 =?us-ascii?Q?ZWmby7hEF+IDXN89qxyBLGAgWmXs1lvkrVO3nj1qlGdZq4aAL+R5KEkp8mf5?=
 =?us-ascii?Q?ITUZjSnDHLm2sPkVG14NHJ4J34IS9YugHp0u+d3Z/+mDvWYa17qcLDJCm9o2?=
 =?us-ascii?Q?A4rzdaNhgFXf2Xb0eWc54mNGeQBQQvwFbbgE2cCLCdfJLXO+mkU051lSGYLh?=
 =?us-ascii?Q?Gu2JdH4RYoNN4T2mowXj+8aXh1H5C7kZvmEV5ftRQCKq38kXz3xMXF4wzVZT?=
 =?us-ascii?Q?UN6aucw8svuPDKPAOJyGYdbvNvETUuhMkVl2ImsKae3FmbrxNQfCTPijb87i?=
 =?us-ascii?Q?7vvMnmO72sCeOj9IRu2lhQDU7tnAp+hzR4DXYeoM8KKpJ7UKh51rr0u7UylI?=
 =?us-ascii?Q?5PhW3OIgur9LewOEp0ZB1shy2Pl3ODr0fGeOp8+oLc7094+H2gTJB3qOG1sO?=
 =?us-ascii?Q?l7aoXRg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:21.2312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16d65a1-f0ef-4674-eb5d-08dc8e9b277d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403

removed the unused variable `nominal_freq` for build warning.
This variable was defined and assigned a value in the previous code,
but it was not used in the subsequent code.

Closes: https://lore.kernel.org/oe-kbuild-all/202405080431.BPU6Yg9s-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d4d7b7cdc4eb..1ce063a22214 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -947,7 +947,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, nominal_freq, ret;
+	int min_freq, max_freq, ret;
 	struct device *dev;
 	struct amd_cpudata *cpudata;
 
@@ -978,7 +978,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
-	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
 	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
 	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
@@ -1398,7 +1397,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, nominal_freq, ret;
+	int min_freq, max_freq, ret;
 	struct amd_cpudata *cpudata;
 	struct device *dev;
 	u64 value;
@@ -1431,7 +1430,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
-	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
 	policy->cpuinfo.min_freq = min_freq;
 	policy->cpuinfo.max_freq = max_freq;
-- 
2.34.1


