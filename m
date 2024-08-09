Return-Path: <linux-pm+bounces-12030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F794CA26
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 08:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEAC289585
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 06:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4716D304;
	Fri,  9 Aug 2024 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B9MkwX6u"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE9816CD2C;
	Fri,  9 Aug 2024 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183824; cv=fail; b=TQfNvGQAXcI2AgF1y+KdB2qPO77PHtzacex2/0ETUc18u/tvA3nIlfxSTyNN8e8DI7G3BEC+5behLhLq9r2myrmvHt6mbtv9d9RD3DWph/oq5l2NgrgrjV5WuZm0knf8SUySdpPPhEJLYNUQEAawxTzqqAy4fmmim2bdZ4L0XKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183824; c=relaxed/simple;
	bh=VFY1Qtet4Ob7mIb/S/Bn/KMlB3hxo8kXKuSKf5jsd+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WV6UyQi4+jfoG3qdbF2qgUtqICagncxLDTklgHwRXZmAgbHmcRZ3goZ2eKihdOu53mELcW8guF29zWZlnk6KVZY8ZveCW+5dKNOEY5HYYqztCgLPTQ6qL0+7S4PWDOLMAjUWODf0yqshXNYsv2FgE4bMPMnSprxCwRilJ30+LRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B9MkwX6u; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4hTZMjuSjyvN9Z/zkfN1xzOMUkVcrPVvjlKT5DCzC0+0t2Vr/kZP5BvSEXxcMnhZQKq4ZbMF/jxl31dXwTP6r0Dt+VeU/fWZfHiCvtM8ZA+EV45XzoAtktW2SkWiYoJPY64h+XjKjgAIkJzybLR8lYGNs6x5okDEcBu8/GUcIp8iSvJ9bEQwIbWGKCH56TyPSeHaqOu41aW4lyVkdhCzK2zeLZ85hASDSswWi0DMtJK+19kZOvPAU7ppZiq/9YpbH0tyNeJkaiXoWeMN44AIiz/mNTgTPBjjtj5rTccSZovdDXH6zduIrfWca7fwGL3n6fT4p8WUOHpaCnWT8dEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCthFpOKQqVfJsw6mf8AzUJAb+zD5wJHYtO68Ke0LQ8=;
 b=EnbE+6z0eVpVFo4PBF2XUsEgwEoseISf3CFnFH8VWoRaUplpIFhLdF7w9//Jx7fWv0UxYx3d7aqZ8sMyfqrH1UcTKIzTZFginu7pCpInpI7Tq5hEHFcMsVZuZDYiAyO6s5jjNOnB9lk36YL+/qGG0gRvGe2qOMqwX6n6yIsA2Lqk5MlTXZ+JqUyNX0rANG138W5+K9C5LCYz6+YlZfAhJdhBlYjrhsrQ8NmpfmfjMST3IBcqDVUEMTyxhzHk2jvCesua8DbnPxGZtqbmlRhb+u9mbcbUGHi1/ZJKSy3sGTbNiyDsYx3Nvu+0TBFZFo/uaZOLWwiPjlv+Z5gePJ6NYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCthFpOKQqVfJsw6mf8AzUJAb+zD5wJHYtO68Ke0LQ8=;
 b=B9MkwX6uJfdMGuR0tYPkxuSGzHzX3H70+4e0u5NTulOqyVD63o1iWH5EZUIe73pNuJwvXYfzCtyfh8HoFR9gyu2Xkj34L8gf4K/2ddmSHHkmISraOAvNrVIXolHKAh7F4SQ9+EalW1x7Ozp45Mpxj0+Voyqvtj8f7zf/kh8ip2k=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Fri, 9 Aug
 2024 06:10:20 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:fc:cafe::d1) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Fri, 9 Aug 2024 06:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7875.2 via Frontend Transport; Fri, 9 Aug 2024 06:10:19 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 01:10:15 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <ray.huang@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <li.meng@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v3] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
Date: Fri, 9 Aug 2024 06:08:16 +0000
Message-ID: <20240809060815.21518-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 6484fb3f-612b-40f8-524b-08dcb839f270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aewHVK/qrbIgrTo6dc/Zfwq9wB6VF4wbRPvAo60QmRtAgd0plmx2VYLS4Rry?=
 =?us-ascii?Q?nQ42vDqowTCqYoYQVaCJqhnOH6rn0zgd19YhPmFgTRe0ajA5rZAwuy5lZOvt?=
 =?us-ascii?Q?uvPfFGWvLJUQovHg+UlaXxVl2bCEifNeTGP+1PPGrgnOgCjueHBnGrcJZSWF?=
 =?us-ascii?Q?njsPJeZKMte4VbDhtnSLuCI3rSNDHMyhwdDAEsh2+0RK7t4IfoYoqX4c1t3F?=
 =?us-ascii?Q?zpj2m2gDSPs1qyvzhIyoJomL3yE1BIqqtwLErVuncfjxQjmOeDqIbrDLTM5V?=
 =?us-ascii?Q?GfZiUXDlLJdpjZ4+mtsWB5P/gt/v/rMj3xCfVCd+KkGHOg4o2+G9R3OpNfjJ?=
 =?us-ascii?Q?Joe33LH+weSYYEKSJZ8T6nSPhlWNnBHzeKEfGQkkfOd/paukdCh3YUGj8Brn?=
 =?us-ascii?Q?pbf1Pd+XF5x/JvGjS+c5rWTUZpCWDTTU0hz6UKlp3GPFpdz5gaXUDSlSbhS1?=
 =?us-ascii?Q?CUJfGca30oDLtuUC4PjYzcxXWZkgani8SxC19c1YALMLxeCpK0mfhq+VQLZx?=
 =?us-ascii?Q?ZuWDIPpIuPql8PXUnvcq/2MYMK7Y7sb1gWsWiO5lFU0ALr4+gCMubTxAk3pR?=
 =?us-ascii?Q?UIVcGP89jEIvbGv1b8rqr3hUvklKTeuh5TQ6ccaimgRGAKC/6VaLKpVOY4FM?=
 =?us-ascii?Q?GcVCus6WemJ5lbzWtz3WYxZgpks8+iG9LWyp3Y8CwBzzb5zY5AF4TWAFSBm8?=
 =?us-ascii?Q?CiZ31QpBkhmqYGAoqa7P2/MeD859hPqvfgrfddIlRgkogU4gluf1p3iel9XZ?=
 =?us-ascii?Q?3hn/1uEIO4cNVB4m82u1zCFMOvcsHLNEHD0DDjz6VrHZ7e5N0zSJsR1LTfUm?=
 =?us-ascii?Q?A0oA2Z3IwwQeRZmHAOXOng6ijGgllnyWUzctPWeXfjcPLQ3rKahWj4lYpeAV?=
 =?us-ascii?Q?qWCndnygkB0nb7NSs3S+WINkDkTAHmSfiRcRqUtg1UXWqQ/PZOBXrd/gArtE?=
 =?us-ascii?Q?FOe2FSi07WAH/LObsbaR9D8CLVfr5j14zewQGGJjMK3ezgD4j+1E/l9C6AKq?=
 =?us-ascii?Q?J7qjvMB7S1mAud59yU2A4uOMmWZgEkSaJ91dd6DOmdTTDpYP1o81RqBngawo?=
 =?us-ascii?Q?Zqea1i+v7MLt0nevex7+a+Byvyvyo8+cv6EdRaj61xrkQNeN1wilWxbzccJz?=
 =?us-ascii?Q?P14EDnSx/n1ASXacxzDQb/EI2PxR1+SweYXODKQEoxx8W7w4HPq9yd2b+F7v?=
 =?us-ascii?Q?Lp7wwKUHYt3EIPhqw1P7zNPUAw1D/ibEQhvaVvKuOqzg9pAjX20r9vh+Oa9U?=
 =?us-ascii?Q?7ssKD7JwEV19ayghhRhQOK/Aq40mpg//vv/IJfATdVdFroCwfpqQfO1BTqkN?=
 =?us-ascii?Q?3+2N3WtRDdRS95MrFyaoCUo8tOXRBOOQ02pqu4hisPQjP0iGO68Z8dT8ZK56?=
 =?us-ascii?Q?SRSoE4pEdI0kW+FOXf1DJ7kO8LWNEWzvuBCZ88lcSDmSdPzSQd2sk8digiZz?=
 =?us-ascii?Q?8PpvvfHAyPNGkQdWGfWhR8mJ/wH+5liF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 06:10:19.9236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6484fb3f-612b-40f8-524b-08dcb839f270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

Fix the reference counting of cpufreq_policy object in amd_pstate_update()
function by adding the missing cpufreq_cpu_put().

Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 68c616b572f2..eff039ba49ee 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -554,12 +554,15 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	}
 
 	if (value == prev)
-		return;
+		goto cpufreq_policy_put;
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	amd_pstate_update_perf(cpudata, min_perf, des_perf,
 			       max_perf, fast_switch);
+
+cpufreq_policy_put:
+	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_verify(struct cpufreq_policy_data *policy)
-- 
2.34.1


