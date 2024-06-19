Return-Path: <linux-pm+bounces-9558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF5B90E6C0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CC0284BC2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0260E133987;
	Wed, 19 Jun 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h29X1j2D"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4F57CAC;
	Wed, 19 Jun 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788653; cv=fail; b=guYVEhR1dszuA7jvcXC6KpnLZgib2gBnTFWLLV9z7Lm0Nq5gs8BmVgIzkK55Is27kwKGdd8PWdYiAM7Wp/fL66Rpyxz2o7hm5L9BEmxXWbIgg8GsTMzk/oSiqjyNd/OaM6IRjucxQ2HMAK8yLI/vI+1bPLyqy/4v56LWmjlvqcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788653; c=relaxed/simple;
	bh=2MXkEZt6Q9ICpYlgHu2/RPiaj2JIXg8VtVhNQypYUA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKrzkhsLVJfMdSDOXV+VXuDe7h/8UR+n+45J9X4OdI+iG15m3sxuJNsebyOg179Oj8cxqHML7/fZ6NBo+z2q2jcGl6H4XkKBHpVh7CQD24uRnUgyQHuID9QLW77QlPlU8/QLgTJYcWOZrrQ3+DMdGv8BVCViwCP4kJasR0y7Mr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h29X1j2D; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1bsWvfec+35mBN9lm4osRCwMCi3o28I9l5yz1p/KoCo+Iq2gV4cDHzNCG7BwKtDH/GpUUcTghNILEiwYjzZUpCC2TTNF5aR3zD4kgnsX6jdFloVk1BE3aZKo+ISMWqyllMJ9DT30MheBHJM3rbuSxJSGjE+t5tebDQm9u2Tii2Z3vba9C6LFmNOKPYN0yfotxqgXJk3sRp7qDJ38bjQwzpxG+GoWa7BC2MDjHsv0ttibEcMtIGLa0JM5VSitjnOB6pViQCqA5GcK+Km5sFbt9QZ0Mv32YWiY12jwgjy8/mrZUH4JGXO8Hjj72JW2CPHdKkLX5dfAFIvq/x4bpZIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg57gOnKHGYHQDres9hnAKHxcWb8TsPJUJ3nrQrv8lo=;
 b=lKug2YIjI45RXDQeK9yL86U8Y6iicaDM+MoFVPlm/QJo8Gviu6H9tnxMvIgrhQ7jgpEc4QoYm3hF19tbK9H55KGvvqEmzOKZf4p61X/WAfO61hXcuP0PinB+sWxfm03GG2ljDMwpdHukO8rvI1Ed7JrK6q7Wp1mFS3IOI/+Uq2PTUuwmVBesZ/SDNBKXqjPLpUhl2FQaXLSyA8pJtxxwHorwX6ycBayChjwZ7XDm6QMdizcWbA1iCm30nke594Vo0u57wPAr+shjGmkbRB1ME35EuW5LIWz9BJD4qIA0Ft9Xg7BkD5QiudM65g+MdyAFCGr67V+iO/77xzGQ/0BoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg57gOnKHGYHQDres9hnAKHxcWb8TsPJUJ3nrQrv8lo=;
 b=h29X1j2Dcx8CnhBgNez52GbpI771xTVkZ2+YiQCpcoW3QNpoIevUkENb8Kzvpsgm59yeACQmIluoVRzUaURbNsSJ3fXTJeQ4SmjihH3BbQdY333joNayJe3yu2vuzB5W+C/wh5JZSTMM1suU0/g5RbMqc+S+q6YdqBS3rDvoBGs=
Received: from MN2PR01CA0027.prod.exchangelabs.com (2603:10b6:208:10c::40) by
 DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Wed, 19 Jun 2024 09:17:26 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::7c) by MN2PR01CA0027.outlook.office365.com
 (2603:10b6:208:10c::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Wed, 19 Jun 2024 09:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:17:25 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 04:17:18 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 7/9] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Wed, 19 Jun 2024 17:16:40 +0800
Message-ID: <df44ee42774efd7d1c656ed43ff3b35988e22e60.1718787627.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d75edc-2cc2-46c2-a34d-08dc9040a290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3oJc7CcNN2OgKwK0YSYNbeNCMU7CaufEwIkR822NMMc0mmORFn/XdeJJYxQ4?=
 =?us-ascii?Q?uNkabeSkawwL8mc9P95Tl38J4ZIYIiSFXwk+xg917zbZKWk47eItIS5X80n8?=
 =?us-ascii?Q?AJZuDjln3zYH/q8A6exzpItIDr6FT+4rRLuhifeYJWkaVhQgCd2EhhxZ96Ez?=
 =?us-ascii?Q?sAGBrzROF4rvcK3f3oNTuQn4LW/lgBerYKhi+tROelUkL2PtOCbddVbNAzhC?=
 =?us-ascii?Q?6oS8yJz+jMlDBY3SNyVMwtObw+JmAa33PQ0G4n0EeCzgvZqoQgr72yV6vY0t?=
 =?us-ascii?Q?6wg9Q7Qbvmt2qo7IiPbODhQSA+y1sVGc7hGq9QNZ3E9IDcKFaYMzlOlMj3vF?=
 =?us-ascii?Q?wI9yjL5XzGe9Ykc5+qi0OBI6vd4NwIosLNRGUXkw2gteahtMn4PGQ0vSj+ks?=
 =?us-ascii?Q?Rocbu+mvzLUChZkQQ5tsS6uDs3NdzJfS6YxPzqAZfC95ydBCdylx37+i+1Mf?=
 =?us-ascii?Q?/EUQaEIG1UvDsZCcD4RQr5WlZa0TbdW0CSEXs5Squ98P/CCexNZAjnekN91d?=
 =?us-ascii?Q?NOVFQqwdmJMOQptJ0plWcEPz8anogbrwPqlm4duNKtZrV3m8zF7E61RHn6FO?=
 =?us-ascii?Q?c6RCVSeBBkC8G8Vl+Pdsp94tHpqOZc7tM1LhcE+i5vo+yRulnwgykRvFPvbA?=
 =?us-ascii?Q?OaS6p7vBVFNXmUsEUbmTUXk+hiJ6p4aT/GH7b/OItlODrQUbW7jjnXXTJhzh?=
 =?us-ascii?Q?2FLg7X6oesA0PGGlSEvZmk2wr0xCmCjtD5T2vBkuSxaLA/wSkUvo9BuDqkpa?=
 =?us-ascii?Q?87A7511xPWMgcx2A/FLlNjos+BHG6e7MreGIPuY/tlq4UhM2te0recZ41FcM?=
 =?us-ascii?Q?CzBp3M3E29uIIU4yb7lAR6SZM5YetPlM1EYGNr5OokxKeU8hMBKDeKXZ/ZHm?=
 =?us-ascii?Q?PIwGYaYqSI5RkuZWxfxUQFVtG3a/G/beg0ZsJZjKXggwiXpbXOyVtxHpEIt2?=
 =?us-ascii?Q?N7YHRfVAUSA81wwuC6C4X2akJFtGDW7PUeUpZz/Pj8CYiperQk4XVAN4lOnE?=
 =?us-ascii?Q?QqJvFTb95n5hC9j/lNH8RM9KFN/JwO8BKi8tgbfy6u5U/eygaf5qBGmUpz9p?=
 =?us-ascii?Q?AJj7HszALJNcEqbslz5XI1awa4EWpRRXiU0hByAQhAb8y7zqs2qerFr0uDiS?=
 =?us-ascii?Q?BEpB2QwOX2rLIafEsLOrdNLss9ginAGNH7uK5i8AkddmOQ9Esq5KGDkK5ZIz?=
 =?us-ascii?Q?J3GUUgnrRJSCN6Lng/rZvYFOUS4ByYOML7LBQkxYPqTmyvb0HiXTFtH8IlOO?=
 =?us-ascii?Q?76wnIVGlnfhWsGC6U4aqYc27uSvd8rqe4wedeQgF5sdHpg/VkplWh/PteaLO?=
 =?us-ascii?Q?WZaOv1TNvuQcAsdG1EHN4gxIofA7PhKd6hWMUqmPgFQrN01dt9UEKnD0T4Qj?=
 =?us-ascii?Q?GbOYkgOxFsa5+aE+FiSxYO0bim5ssMqUSJTdbOTlBaQNdSUvWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:17:25.8368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d75edc-2cc2-46c2-a34d-08dc9040a290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280

From: Perry Yuan <Perry.Yuan@amd.com>

Select the min perf to fix the highest perf value while update pstate
CPPC request MSR register, here it needs to limit the max perf value when
CPU boost is disabled in case of that highest perf value in the MSR will be
reset to original highest perf value which cause the BOOST control
failed.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 299e52d4b17e..f2ccef089acc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -524,6 +524,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -543,6 +544,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!amd_pstate_global_params.cpb_boost)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.34.1


