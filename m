Return-Path: <linux-pm+bounces-16069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D959A6275
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 12:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5DE282FCE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7061E2849;
	Mon, 21 Oct 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hVqEe9Zg"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291481E2603;
	Mon, 21 Oct 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505965; cv=fail; b=VDz0MZDYNJ9r9MaNenxdaYdrdxkJw4kSBSR791uZECVFwhHIgnZK3skWITZAzEWiL6qSzVDiYd4EKKiwmP8QQ/tlYkheMTzuEIGF6HljL7BWMvsl91eS9KNNtXX4T47GRojrUat19rPXIyg0RHlMVYfrCWJ1wan16q2R1WFYFYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505965; c=relaxed/simple;
	bh=apvszOdTNj8Bn0wjQiPlmakhyP7gdz8gHA26esIPBak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qjiba+NZ/k2bpKrIxwczJeswaKMORdIFXKlxq6QLoJ/HO14iTtpgVcx+n16CbAVzwwnBcoff93rsTk59AQAUB3Nm5lCnFw1aSubDsCkjaIgQJ4peqBN0dnJyiOcBYeiN/ViPBOmeVHGkf6YlwGswsw7buxlXjZVnebdH9IYZ69Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hVqEe9Zg; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0AdExKdoBuE5U4BVSfp0sJQMN1YnSWxcj2je4tc1DVO1rgduxYr5Te2e1FMNqh7gYNXzKS35onxlTd7DMeCwaeI7q+wg8KIHcdT8GR/n/Bw8EHw5XJ7sSVTy0S9/4UQsZgZhxsva2nAszEKfigPB3nGAVHUT5azhXkCVScoxKBuGlC26RbKLPHCzVXsNtG4GeuDZn+CoW6VKbLwKQ/DKTUhrXMffd1i1n4r/TfJ0FKTzYJkvjbR7jUXQ3cEfhROOZdENYp2NNUy8Geie23dLgx+qoPFzjB3zr0GIcbkk98t83pLRuSWvOpv8dVg6UTtBTKRH4SJ0N+9kpZgOC55eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NFXW3SpYx+Hd5/3z0mnzlOeEB6SveB0I55NNSf/arI=;
 b=UPrkY1hhlAmymMThMwkrqqFelEUu2wNbcrM8PsEQQJoQYNuJB5qOBi4RalxysN+XN8yk0hgUD+iI7uCEu2H3SAm0T1pc4MuJuRILL/rg8VzGUifCM+9oWU61AQZT1oXPt/BhEhYnyrH0do9RROhm91h0Wg7i8FPbJ+Yu7fl1L5of7EZB47ropFKcKxJZWGh6/3uCG6Xk47/pvNGRakzOnwdo/whd/cXCRvWcFii1IVAkW/98ZmXh0kaitDggcj3OjMdkoybdELl7USHfWxvA6z86vAN7zit5TmLbYlhhNoqDu0oVl7TtQL2oalVTNz/8kRNqrnUjDL1HFgIi4oL6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NFXW3SpYx+Hd5/3z0mnzlOeEB6SveB0I55NNSf/arI=;
 b=hVqEe9ZgdgJhBdp1Dwq0fFW3ka/CJuUgXWrYoOkIOFa/aQqenNYqwWt/5O+STFis189iERCgPyujgcT/XW8jeyytMsBTdAOwVhmMW5CvpiAZEgUt8TbQqxNIQkw8MBilhH4ITF7gE4nAaMKKaGgP2LcqV9raTOgZkdvpgZ0TOJI=
Received: from PH1PEPF000132F9.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2a)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:19:20 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH1PEPF000132F9.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26 via Frontend
 Transport; Mon, 21 Oct 2024 10:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 10:19:20 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 05:19:16 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan
	<perry.yuan@amd.com>, Huang Rui <ray.huang@amd.com>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 1/2] amd-pstate: Set min_perf to nominal_perf for active mode performance gov
Date: Mon, 21 Oct 2024 15:48:35 +0530
Message-ID: <20241021101836.9047-2-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021101836.9047-1-gautham.shenoy@amd.com>
References: <20241021101836.9047-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 90464740-218a-484d-7165-08dcf1b9d3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hvG6FWBwv8hmvDnxhIO9qankd5rc1JzaEuGAI1XSXodDmpS4VnV0jmVMm5WP?=
 =?us-ascii?Q?SsB9zPis4HeddKcpJpipZPODzzbCprQ21sy5qm2H7G8OpBe2PWljwTYGEqWT?=
 =?us-ascii?Q?89E+jg0+72h0WXHwjcn7btrM5srO9eSDx29sctmD1ntxPaqlR1oSAsVMKxdC?=
 =?us-ascii?Q?hiT+MC/ytVi/8QVZ3JrXnN9YYsn9hWQXaSMMNDQPC9bHo5iborPAm+4sRiCN?=
 =?us-ascii?Q?LI1wnHBSOMULkT1mD7mTIM+DB7Tpb3+8WjwR/3qx+z1yRU5qmZu3Ba08GhUj?=
 =?us-ascii?Q?aCcE2wItRcO0m6OSl5aOYPFOuJ2ZlDbaDmZIc36GBFmDpslJ2cIy+QvDBVhA?=
 =?us-ascii?Q?WcImODhoz6lKciYGovyTOGtFFvfVzcWwJDvObJuPKiPQxOmwMzGxxjGMJAVO?=
 =?us-ascii?Q?CQdGj+VKHZkG1CgyWfd9MLJT3W1n1B7JtANwqnahdHRAx01sfBr0ETfoYU2q?=
 =?us-ascii?Q?xp/1GZjPL0ihxRruEL1OeehW+AIXs5uBpRqs1/KAtnRulQRHPWsBzUDHZSxb?=
 =?us-ascii?Q?2ovLfpo24d80eKhPcpvTsLcmo3SXf2LGnhnPpubkH1zaLGkIhs2R1e4SeQwa?=
 =?us-ascii?Q?BXC2bpvOnbK8517Mr7za/rwWATNgGXZV9A5fNdJ7+XKDVOAxPMWkfSOhSvhp?=
 =?us-ascii?Q?nM5SOOY7SiG0q58NXycsuaZ6vk4zKPkRkHLo1ljKi4Uc5X2kUNeDZpjzbarO?=
 =?us-ascii?Q?W6CYyzI9e/bEcVEX430My7CYFoIW+x0kBxyYlaQsIIuyEIx2MkycH9sA4Sfu?=
 =?us-ascii?Q?zldV0f/bZAVaMd9o2lMBm2HKtSn6HbCdI3rm0JDx4+l9FmEDdvD6uYYTrpPa?=
 =?us-ascii?Q?pN4FnEwDy3Vm28mPIbcwRupGAExSMVVZiyUxtjIL4430c70mEe5oJd3ekvvd?=
 =?us-ascii?Q?nDbcM+dOg3TqQ/RVbwpV7/enBFb3TLvsxhYaxofC7DSjAoOXW+rPkLrVyFQy?=
 =?us-ascii?Q?vawY9sU3IekxucsTmJ1Roarre3qsV9KYfpcA0HclKSkjDICP4K8t9vTIq64x?=
 =?us-ascii?Q?vGfjBs0MCuWd9ZERZAfBFPzbVlS5udEgCdqY3FmqVQaPQrBFjx3YZIOnkjuv?=
 =?us-ascii?Q?x7YHIhAqd5zRfgX+fbcb77Da73QQuBxQgOsMyym0EvSkVEzhyvDeB518kPEp?=
 =?us-ascii?Q?toIZ3QYDxUZvB7Wv3JUImFxTKI3TEx5ktMZMeM4rMLYHQ3j8prBQV0+MPS1U?=
 =?us-ascii?Q?VSOtgFjoxRyszGcm6v4BNE53AW0/BFYPiwe2nbUmwUvBL2IRw+1nO+fogtrQ?=
 =?us-ascii?Q?Iggxx29QYH22LAGxkqhv0fsn98lju5CtR+/0MY7IXqk2YsxmlQYz6P7KDnFq?=
 =?us-ascii?Q?PvbHfXHse5JGxQnc+mDEZkkklIKP9bjYn1H9b8bBUrq+yLVwxImO5Tu06cwl?=
 =?us-ascii?Q?d8pSdcHXHAYURZC4NkxgdP4lxsUZcUKeslQHyNA6TO9SE0fZWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:19:20.5199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90464740-218a-484d-7165-08dcf1b9d3f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

The amd-pstate driver sets CPPC_REQ.min_perf to CPPC_REQ.max_perf when
in active mode with performance governor. Typically CPPC_REQ.max_perf
is set to CPPC.highest_perf. This causes frequency throttling on
power-limited platforms which causes performance regressions on
certain classes of workloads.

Hence, set the CPPC_REQ.min_perf to the CPPC.nominal_perf or
CPPC_REQ.max_perf, whichever is lower of the two.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6f6d961879cc..23349f50c83e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1535,7 +1535,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-		min_perf = max_perf;
+		min_perf = min(cpudata->nominal_perf, max_perf);
 
 	/* Initial min/max values for CPPC Performance Controls Register */
 	value &= ~AMD_CPPC_MIN_PERF(~0L);
-- 
2.34.1


