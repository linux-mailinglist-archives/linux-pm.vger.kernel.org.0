Return-Path: <linux-pm+bounces-8131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD468CF8A1
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 07:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B33D1C20DC5
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 05:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2F8828;
	Mon, 27 May 2024 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cct6kq9N"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400E79F0;
	Mon, 27 May 2024 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716786714; cv=fail; b=KfLghz9I0p518jBYh+nI4E8UVMKyAwebPbD3UR4tn/iC2jbvVWU+/mCyRDh7FUo+lj/ZbcHeQPT7Hf7RbjTs/WWVP8W1w0OxVdzKJbg12HtRTc00Tz76me1B3NBhGdYmG9yOo3fSljU+r1iQQyU80nMMhMb4wQnEWNPRii381IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716786714; c=relaxed/simple;
	bh=LmRASh5Ou6QAzVNaN6CZCDFl568g/kmZp1BRO0atMVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGSmwUYOeuMdXDPknGco7VlXfc+vXwZqKuBSuXQH0AyOjqzr5NS5RXWO9pur6Yq0jprXVXsiwzmzfAj1ah1Ty6RMxfEOQboFGGAWekgk2rIVV5tmdqOfaQBedLGFAHWl/rM1vp0+JQ/mLZBCHzJJJrjB/vCE8/KAiINVQR738Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cct6kq9N; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnPRIbvrtZLa4AlIOqvVlRu7Yk9gLa+P9Qzw4IkqLcrEA1F+Apem+dWVY6V/h0KihzIFttY3j96X/NeXoGbUo31e3znNNLej+EJatwoMv+P23U3gfeodoUmBB5h+u/vxxTz76BftB04c289dPc/llW3f9IXbbrg1Eg/+DT3q9/MlaTaHtlqzuV/S/UKleMqdUxJGWB6JEzzpMPQ/fObY++AG/Bs6SL06jrFkxRYXlgx8s1yplfy+Xtx1h6L2tOau9z/Isgo5kDtfLF6t/UL6JcwT6tyT1o/KXcv4uoU9Vj8iJ577nNcciWwsz763fLYVz0CiIxlCHXWA281H9flzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jquh8+iyaRnqWj1uuIrfB2dGHuSX8+0S6DZZ5Mwu+14=;
 b=MvyplEA9+ov8y7s+7bDWsteVzGk+CNnpOGzjH2jtrvYfU2nRLtIXxAGeAseN1w2UBrFg/mQTI7d+FILWrrIjgrw/4xOIonEAdzU33UdIfFPHNlZmbVoJ1/FO+K7KZeQ/gHZQHRfc9E9UsTIhutCE9nWH9SbozxI1A4FIV+Ukznh349gZxSoT5ztQ4LPKIxBsHpHdHHPB1nstOvUe02eXuZUfrrIuJs5Aav6MTL9AAmy2jmhhrjV5eZb0iHgQV0DPiYEQN6FaayubiDuLQ3/hGn35qye+xH6968n9QIKv8wyNBzRPyoLIzK4syPn+6W3nIvmqqtQxiq2PrOgTPDgh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jquh8+iyaRnqWj1uuIrfB2dGHuSX8+0S6DZZ5Mwu+14=;
 b=Cct6kq9NSE5XVvYm4qJj846AZk4oFdPThKv47t+iJiumSLgWNqfPCNTVbrIr0AlEwHUGb4w8UolisBsiMaVuxsPHGHr1/Awc4YheuThS8D3R3RyKCJFYGekhdXcESf3tU4JrxYbCwXxKA7D499Iz3ASTKtwPI877tTtInYzK+6g=
Received: from DM6PR18CA0020.namprd18.prod.outlook.com (2603:10b6:5:15b::33)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 05:11:49 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::20) by DM6PR18CA0020.outlook.office365.com
 (2603:10b6:5:15b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 05:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 05:11:49 +0000
Received: from BLR-L-DUGWEKAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 00:11:45 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <rafael@kernel.org>, <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
	<Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <ananth.narayan@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Perry.Yuan@amd.com>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH] cpufreq: amd-pstate: Fix the inconsistency in max frequency units
Date: Mon, 27 May 2024 10:41:28 +0530
Message-ID: <20240527051128.110091-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ec33ed-97d3-4d22-524e-08dc7e0b833e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aEVZt1M+FZWLPPtOP0a21fU0lyMsrQ/A96aLxu2ToPPpzrzPpig0sjJ/0Pjh?=
 =?us-ascii?Q?8JKNCYjVMy1YjI1Hb9K58pUaCvI0Mzz3LzcjV8Q4z2NT+L9YilJXyS1mrcAT?=
 =?us-ascii?Q?bmd939ubw6dyaeJkp0UK+X1aBbvyGX9f7Jw4wbtnVAYFCR4ULz4Bmj2Gaqad?=
 =?us-ascii?Q?u3kEyObCaYLS4Dh7eqBVixDhjaVlYuCVjLbhmWrFoU/+VkGUMqQ1s1nPc9IK?=
 =?us-ascii?Q?rvYxUzmLCYXBF0fQ6UKX/NVr7IQNqm5wmWADyWz/X0XWcrXWjBk2JASXmxIr?=
 =?us-ascii?Q?oW0INxcgQy4uWLuu3/A2ipqDqMBd9FiZJ0ExoTrigXOnTICP1Dg/AMCu4GAE?=
 =?us-ascii?Q?l4S4km+2W0u9x2nq8VO4Q3qCy/8T804C+w/i3lGYahHmCT8RzXuu/dNj8S64?=
 =?us-ascii?Q?CdvkchuH4JwKNoOlStOTC+ov96co42ZTFIYlhrhQoD60UfFn0LCv+1zSwitU?=
 =?us-ascii?Q?EURH1jUEQl4mYsWap8Jf2XxMYeh28wURV/broCD6XO3jJh1tKWetxGej7L+S?=
 =?us-ascii?Q?2OgLxctirBjKV4iR1Jy2mdYn3QRqJBmBi6N/sMxMF8+3c2+iqqQ5mzwHE4mr?=
 =?us-ascii?Q?pCiXGTW4gG2MsJGwulMHbTjvtD17WDRuNlvJWtiwZOqYBRvQ3qJxmbOFhlUq?=
 =?us-ascii?Q?dlHU+pnXUTxCREFOn7PL9E5Oitmz26lUALk8oEGbBaJwJXYcKMjSEHOQMsR9?=
 =?us-ascii?Q?V3JMCAuPhpRYg15oaYUzYXm4eh4EIMXPedqUrY0B0beNPyg7S66qsn23NYHP?=
 =?us-ascii?Q?OhvIynqbHiVvArV8nqq1wz2oSADw1QCJMOlatvMLO1X1qu0U4EhZfyOUvuld?=
 =?us-ascii?Q?BpcDYHuiNlfsVgWj8Tmv831ncbInxyeFQ6UEfmWnILWGoYFf7ohxXPKSVHo0?=
 =?us-ascii?Q?8KmOz13MaNA1u2xHzFZBflqvcKhIAWIZ3fq0w3iRGe95CXyhteln7gyRAcVl?=
 =?us-ascii?Q?euFvvkils+yA34zEOlM21srdC4P3pfs4b/7/kqyU5l5ciiMBVGPbdqmOQtNZ?=
 =?us-ascii?Q?u8kPFh1mrEWu6p3a8Yp6Jy3MvpqYFp4/X+iHo7jVLMvQ+/etmLWEzX3lJt/H?=
 =?us-ascii?Q?8j+BN2syEYsYfHvRquHMDVaWIZDoXUYG9xZ+GM5CMrBtiGTWKlP5MvGZ1/Jw?=
 =?us-ascii?Q?klWyCpKxEH/WZmCXdyK3+3lq9AW3BoY8zrubOpQPaCK0hRCORJmDKXiKe1h7?=
 =?us-ascii?Q?ieGFXYjTfKhz6t1+0FFSfjDO5fRlTm7ev/aEswAOa3RoPkf4O+N3c4/cGeDt?=
 =?us-ascii?Q?F7HhLhnLsQ3admuM4rSxWXZlps+s+16oIMVBAbjIigWPgHfLqnTehX8PYRsO?=
 =?us-ascii?Q?7Dx0BNKQz7Idyz74ImMomU4uEBktAmucJluvYNZ1ANlatfq6o8bNpHzDj3JJ?=
 =?us-ascii?Q?UcfrxmAOuQTYMvgl3R3O0t81cacV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 05:11:49.0626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ec33ed-97d3-4d22-524e-08dc7e0b833e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802

The nominal frequency in cpudata is maintained in MHz whereas all other
frequencies are in KHz. This means we have to convert nominal frequency
value to KHz before we do any interaction with other frequency values.

In amd_pstate_set_boost(), this conversion from MHz to KHz is missed,
fix that.

Tested on a AMD Zen4 EPYC server

Before:
$ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq | uniq
2151
$ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_min_freq | uniq
400000
$ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq | uniq
2151
409422

After:
$ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq | uniq
2151000
$ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_min_freq | uniq
400000
$ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq | uniq
2151000
1799527

Fixes: ec437d71db77 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1b7e82a0ad2e..cde3b91b4422 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -669,7 +669,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	if (state)
 		policy->cpuinfo.max_freq = cpudata->max_freq;
 	else
-		policy->cpuinfo.max_freq = cpudata->nominal_freq;
+		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
 
 	policy->max = policy->cpuinfo.max_freq;
 
-- 
2.34.1


