Return-Path: <linux-pm+bounces-10001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38B1917744
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD8A1C214FF
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8FC13A404;
	Wed, 26 Jun 2024 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y7LjzPbz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08F1369B6
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376096; cv=fail; b=gxQ9SwqYm7ZtcqI/f/+nokDrFXTguy0SUfLFYo9LQi2kQVOuFbIric7bAi1EEmmJBJnx3yEi+xshf+/Sh10Upqh5S7FaX4umgPTubGShBkLjeAOdPifm2rKVe8eo0EGycHqhj7sFgJ7SAOjoHIrrG+y8g9TLUfvBDnDmE0o5TTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376096; c=relaxed/simple;
	bh=Oe8YtLHUBJUhHJnyvQEwpkX7Qtlqk2flHaqOWbrY6aM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJeItPaNvm0jX8nXdP5wkxWdelMi0MRJDZ2s+CUxJWwZWOsUA21qbMSybMoFJ7WolGsaqYE49aT9WsLqNPdkSPR3GAfZIa/8aoFgiJd4Pkr/hdXw+bGJxMjKYxEu6BXrHSp6HuI34UZmDkn4AWbWikRZlwN5vmeGLhJn6s68L1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y7LjzPbz; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV1AVu3VOkZMiWRzZmv2ojIxmccNVs3s4cw8KlvzKsoKemeuz9K92oicwI1UQ4hdeKPBc9a4IuFc3aN0tn7im7q1Khm9hgKW3XcCekmP7Uf+gniGjVkX8b8CQ0jxEWD+uHz7kH4t4DXW2PsxhFRV15CaF9rGMvghdfNuJ/41gIvcr6dshLz42njliVK51RnCJFc2nUzqjfXNosyLlflVwtx2reXMIKBu9amMETGpeDrpHP+HWntyUSo6gPO8nfF/2ucnGtq/6eDn6QXqVokuNxvjkQGRvUc6raEZG+22usKnKPcK+4A5yhwYIcHGYAsOaVBo+maddeHu3hHf10FhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ly/5AEwdhHtpVOe9oXEk9r2ICwYbhuLDSTpauN8szw=;
 b=V2+OOihTm6Xv05eTr1jQKmgvIHQxigN6oSLHbHIiv9XUjisRJ6d5vUpn6dKKCoKMhH3+Q30ihIQRYhiobDXsSgzeaugMXKTTSL4mMG0ET9nR5haCIFGeNHYQMPT6HOiNhYFxN2a+is9u2W7iPF5aMqglGXXUaCQtyOhZrbGESCzKjuUdEQPGJixGzLoILtAwusrWfO/37E5g+5HfZlrRjioCIP42uf1p+hVxP1kQNt41SJY3StOxoi1/Nwk/KjBuZxqJPvSTLdMB8TWSVC6vJD9QNwbqOmx+n+86SRxkp4ASJ1RdSjLO5f0ACo1MeVKUcLQuGsW9mZgw6BTWMLqg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ly/5AEwdhHtpVOe9oXEk9r2ICwYbhuLDSTpauN8szw=;
 b=Y7LjzPbzHVvvFHz1Qun4S2wjKAYy0ClxUCryCj/Eo4rKINfKlpJTud4SFpQ5RF3HgWMh3qvSvXc8hnic0QKpSX3XAGe5Oht1/IBDNuNFEnxHqLVNAJFmA0KWfL6uiTOy39tgVwgSzq4jKfrX5s664OFps4SKs9QHZ+TbPfrj7HE=
Received: from SA9PR13CA0106.namprd13.prod.outlook.com (2603:10b6:806:24::21)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 04:28:12 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::ef) by SA9PR13CA0106.outlook.office365.com
 (2603:10b6:806:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Wed, 26 Jun 2024 04:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:28:12 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:28:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: <linux-pm@vger.kernel.org>, Perry Yuan <Perry.Yuan@amd.com>, Huang Rui
	<ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v15 3/4] cpufreq: amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB is off
Date: Tue, 25 Jun 2024 23:27:32 -0500
Message-ID: <20240626042733.3747-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626042733.3747-1-mario.limonciello@amd.com>
References: <20240626042733.3747-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1b9583-040e-44c9-298f-08dc959863d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7KzESlz9nttqgLN9gZm2ipRCOGxaFOTadsRRsIt8k1ncWpTSiMnLbpAJkq5j?=
 =?us-ascii?Q?6HMqOSEJQENZ+agVaTgCj1vxnk2t50DwCifBSwt1xMJTYYCc5vjxpmZg0vQ4?=
 =?us-ascii?Q?/Q96ZCW0hOBtvqaUBJAPm8J3ACkjspkrir1+A7FMeFtG7wQ0+f8OD/NuuhO2?=
 =?us-ascii?Q?8PaK4pMCAkdLDO3JTM89NlJcndXel534rIMzvP6ZJb9MHJvISiUgo/WcbNfL?=
 =?us-ascii?Q?iZEsFZVN2fHVTsyDzMFex1C6XAz09ddC/ZjyfRMAic0mRFe5nuLXxTDVcPqq?=
 =?us-ascii?Q?W2gLSK5RCaZHkedqXQWuAROJAJRIeAzkiK/dTD9C7/8c42KpHQHoJtHtzrlw?=
 =?us-ascii?Q?yftEtXeoQfhvNJw9uFdRjmwX3Gm8zEPANbFiDGYC4ogp7bvuQq5vHWU7w7cB?=
 =?us-ascii?Q?1rWLRoz5G6mUGALhfUodGo/p7HUQkr1YH5Lq1NkYYWN6YwQimtoIMSmailUQ?=
 =?us-ascii?Q?vgkmWf9TZlGZVBHaKe1Qqjm+mpblpiLsUmLHDg17c6mgvxpSMWG/ppDsNTpN?=
 =?us-ascii?Q?3sLkxuhZ3TpGjL/8wviqhsUUg2h23RYuxJpmZ+QIAH4pPGWk0HWRfMFp+csD?=
 =?us-ascii?Q?GTJi+TdRVHcxTCRURMCxocZcjbs64pwC/oT2lLXFDSVAOPsHIxwKU0iOfaBx?=
 =?us-ascii?Q?Sl0og72KqBRpyN3NwdMfbTt50hwzwnRsYolr7rKIOothQQnojTAffxT3E2sB?=
 =?us-ascii?Q?WIlIQZgfnVtDw8017UUIDwKFhDO5yq0423FlbzF09DlY1btoi9XYZlPw8jPv?=
 =?us-ascii?Q?FY1LVyD9GYnsI2kFZokPijP/63tV3mnuYLoqY3o8nBit+IaKLldtQE9FRk90?=
 =?us-ascii?Q?ZoLZ9uVibib/OOmFYy8SQCozNAV7mG+tVf5/hX99haZAbjY/9VgvTd19hbLw?=
 =?us-ascii?Q?Qvc62LudFsmc6uN2Y4pPyvUbYKf8siRQHIxxGXsLaMgpqx+h1Jh1qdhG9MN/?=
 =?us-ascii?Q?oNLYh3699W+vz5MgtPrB+Wrv3mi5FYgOc4aVzspszTOc3bApPckuVuvvfEfl?=
 =?us-ascii?Q?HUCHHSPSJYs9ABKLPIbgSbTsb7bF1rDR8xELX1hyq5/bIIdeWkAYFLoCOQ/u?=
 =?us-ascii?Q?mhf5Svjlq/GGgrGL0w0VOuN/dhXiw/JrgOimpt1ltFyaipjHLSQ77SL3Zh0C?=
 =?us-ascii?Q?N3LG6voqpn5LnHUUsEXZ3dAPnM4o4ZX9NFhci+i4lW8LLE9pqy97xBeY2x0v?=
 =?us-ascii?Q?n3bf8PkoadMjs07W2NQJiJwFqPVovSX0W7TQvKKKDwRz8IbwGU886pqUMPew?=
 =?us-ascii?Q?mEkllUB3YxnyuAZJ0DZcwL2iihXAYKbl7yqMcvuLqp9ajOXySqgl6zEE8kUy?=
 =?us-ascii?Q?vBoGi+ke0RU6EASE9sZ6ftigZ+lry5unvU3F0x4iKvMb8lnXgNDJESRvSRz1?=
 =?us-ascii?Q?1RvPLRg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:28:12.1246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1b9583-040e-44c9-298f-08dc959863d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322

From: Perry Yuan <Perry.Yuan@amd.com>

When Core Performance Boost is disabled by the user, the
CPPC_REQ.max_perf should not exceed the nominal_perf since by definition
the frequencies between nominal_perf and the highest_perf are in the
boost range. Fix this in amd_pstate_update()

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Link: https://lore.kernel.org/r/66f55232be01092c423f0523f68b82b80c293943.1718988436.git.perry.yuan@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index db4fbd8d1e06..80eaa58f1405 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -514,6 +514,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	unsigned long max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -536,6 +537,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!cpudata->boost_supported)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.43.0


