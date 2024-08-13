Return-Path: <linux-pm+bounces-12136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93195019D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 11:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9E11C21EB7
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91D189B9A;
	Tue, 13 Aug 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZtyzJZVQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87B187552;
	Tue, 13 Aug 2024 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542731; cv=fail; b=u3apK48cU4NhMUIcwV0BLFOqvK1SAUhIg6BKP6PhCGYYpKjfcT7WCr4GXolQgB9q5rvT0xnjEY1JwtP/UZekAaojqn0oPcoiRG7Aaqq0z4GK5mhjSoIt8Gfo4QL9iKZ6NvBpYiD1hVjfDpxayCYtQhnsmMx+Gr7w8MhWAcs+sbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542731; c=relaxed/simple;
	bh=btqYl5lJqbl4YOklscTJCikE5SMejM0qsEjoP35qk9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqgR4cNuepriHKp/paOJIjFHTC57vHVWWPtGfAsOe17AdYHi/qmTgCHRmysQG+fsAUws1/c4/9Oim6xT60GrgEix2MasuhbdG3OhyABkiJ27O9f4Ui+RMa/BTc51WAXgUZsmovnNz6ZKaQebu1vzN31NSMyo4rhEru4zKB3FggI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZtyzJZVQ; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFvhKELJ7XYOQQtG2vqtys8PRw5+55+83wNLOgb176H5bqxXoNxoorUliSPpRyITMWVy9Ek+cTFFWN81To6+nCUivY4c0GqJ8PI5YXre09Kfn+QbBHkB2wJAmZFwLEfh+D6ynbyGuMFn077+nzNHQgbI0VUHTFHavpsmOCvb5fVRMG9dFqkP3dPMN3WMDV1jwIy144O7sQvlXN215NsrqperNOF92Wttc+cZZEvCPnRysjPF/uldHRcXb2m4PY+KhsvnQOYp1KHX9yHzLbsqjm+p5brt8M7bmZzhsmIjH9bb8ZM9t3ykz1Mjw280qnGktEaoG3AX300KrJPZwqtYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/3GfHKXEv+Hn/0kICdw1WRX3FRZAoUTaYRklsmLSp8=;
 b=YZxBG0SKkMtDnYD3vC8v1is+OJCkR9Xh+7eJ4HBbuRH/jUNrvYhjwxQDwA7G71lXSy3D//0etZytDAQ79GNyOVCqHKNXn/mCkh26vV0yqiXXDEaLjCyH1X9uncPv9Xf7jPWsZ7UAwFhwA2n1ANgx4/nL64xZQmv0qcUzCvSDTU9xUHOZfK9rIKbge8xFxkYB3Y/qQVCLACwcxe01/oS8tWgIH6aKps/xNfuSek/g5d1RKDrc9Tz+jE1mAczzJndL2+2wjnhS0nzFSnUyrAnOjM6j3XsyEgvtWGfXHwjpHO+off8WWLRbW6XT4ptyIwr6bt37MOgR038rHd8cVpMWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/3GfHKXEv+Hn/0kICdw1WRX3FRZAoUTaYRklsmLSp8=;
 b=ZtyzJZVQEehG5uOSaVRtZtlCDR6GUQEbjqm+yGZopm5LbtzXmn0y+IxExTUU1yrQ1ZdXgiwCZ4Xh38vYH6GEVxj42p2MluubKK4PG2zNM84Ifp5qADB12yW5MUaxC2psYfzia6BWwG7bRpMnZh5Dx5KNE4SfrK7tv5tiImQq908=
Received: from SJ0PR03CA0147.namprd03.prod.outlook.com (2603:10b6:a03:33c::32)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 09:52:07 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5) by SJ0PR03CA0147.outlook.office365.com
 (2603:10b6:a03:33c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Tue, 13 Aug 2024 09:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 13 Aug 2024 09:52:06 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 04:52:00 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>,
	"Perry Yuan" <perry.yuan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, David Wang <00107082@163.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 1/3] cpufreq: amd-pstate: Fix uninitialized variable in amd_pstate_cpu_boost_update()
Date: Tue, 13 Aug 2024 15:21:13 +0530
Message-ID: <20240813095115.2078-2-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813095115.2078-1-gautham.shenoy@amd.com>
References: <20240813095115.2078-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 505c1e54-fc3a-4195-54cb-08dcbb7d975d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1aagu6avy+lImg9si4DB5mF61xRTlFIcTlU6r10ANJZTdEXiwliA37gtc5Rs?=
 =?us-ascii?Q?vg3sHdZ3JURYuAnESEo+swNdFCMCRhZN1Z9JoxOCGzBK8v5pRb2uGeFdNs93?=
 =?us-ascii?Q?lW7BDg66Yh8oIRpBK9Xyxs9/scal74iN/tSAma0t8isQHSXkG/BjYOdZ83P6?=
 =?us-ascii?Q?QsRLjyogdjfNHOXLlSpgR+J65FoF9uFMUxhdGomeR4fMiSweHXvWJScNBahF?=
 =?us-ascii?Q?MeieivIBz3kZ+rY6M85JznmMbAIZBk4JUHgxT2Wz0/FWM4+kzGjytwW3diFf?=
 =?us-ascii?Q?C42us9E3P4YunumG/1cGzAlLAG5Trf3tOIvEBTEPx3Xd13zjoEO0dLsA3fy4?=
 =?us-ascii?Q?uGEULG4fCcZ1AaOvjVyrTWDrtVGdzvazUdE/T3ZxA94iAgnEQ7E2melly9qy?=
 =?us-ascii?Q?/TwIirp5wsr4gz39T959mxrhENbWCujd0RPtHT747TE4Ciun1ZvpSXjn14Vl?=
 =?us-ascii?Q?6B5uecZU6reuL60LgWslxTSO5kNhjn8DwDALjTzbjcX/rAmhYAIJvPJiT3qc?=
 =?us-ascii?Q?lOxM3YfWj8rPw4b2mthHFVp62RW5wYe1AOYBv32VYK6tiaWeyY27IhX06GSb?=
 =?us-ascii?Q?vlS6GFoi8TDRkxT8NQ9tPkB3otB/cdu6YfamRBG/kBQs846q1X26FOZDfSyc?=
 =?us-ascii?Q?mluHKxO0qT81Uyz9VI4QTE2y4EsCaA+AcK+CqydCEJTGYZ4Y5kMXQzJjkqIm?=
 =?us-ascii?Q?gwmbZ8mVq6PdhP5MHR0BLkTl/PXLgP2ovd8k6y5xWrfYmFh5dOrdyB1RWiZW?=
 =?us-ascii?Q?3x+Brrv9m1Bqr0KqG30IaaW4NCQICcBvogu35ivtQScpE5/o+FD5NJxcnum4?=
 =?us-ascii?Q?TRALD2pnJHg4tMXPX5ef6lKRdGEIiUexyVSxTYm8vdiMt6qCB+4GKCyXDEsS?=
 =?us-ascii?Q?KEkY+oOsboImsVmmtfQpPUhikb+WaS/cEPVXfRLy1mmibf9UBlfidnH/MCkv?=
 =?us-ascii?Q?sX+H6r3GOLkyHzp+CHythmG9u/zuQD00/kzYauJX4+TwvhtKk0prEQ93LjJ2?=
 =?us-ascii?Q?IVtDAMQqd5T9bKzOJMu1h1cCMOvWxppSY4imB1mefNI3/aV+IfAkOdVg7hdu?=
 =?us-ascii?Q?IcTNcDJblBBKXqtLID+jV+eOtNZpZ/ddXvTvfMiMj/RVYOmh2T8fYoeHfSau?=
 =?us-ascii?Q?YVM3o/PQiCw9XtlfMz0VLtOsIxZME2psOhyidJsubqSO6xkXuaPRj9LBtIAk?=
 =?us-ascii?Q?Vg35ZIMVtrSGfoETdMBPizsbJveNC3g/gUkObvcTeyKEiw2oEA0vmymrIVxs?=
 =?us-ascii?Q?9Ts9Vf3+6HKlhll0r/LCG//GpJXcvd5vwoIY8bUUny/0XpZwREpzJvsqvz+R?=
 =?us-ascii?Q?DMlsk8eYnzPbRxcPk+mN53GAZ+ObevRx2DL30cI5HNml1/UPzQszG/xhLUXZ?=
 =?us-ascii?Q?11zjL1EGRc16z3U9ucg0kmKN8oaq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 09:52:06.2987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505c1e54-fc3a-4195-54cb-08dcbb7d975d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222

From: Dan Carpenter <dan.carpenter@linaro.org>

Smatch complains that "ret" could be uninitialized:

  drivers/cpufreq/amd-pstate.c:734 amd_pstate_cpu_boost_update()
  error: uninitialized symbol 'ret'.

This seems like it probably is a real issue.  Initialize "ret" to zero to
be safe.

Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/lkml/7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain/T/
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 68c616b572f2..358bd88cd0c5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -692,7 +692,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
 	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
-	int ret;
+	int ret = 0;
 
 	highest_perf = READ_ONCE(cpudata->highest_perf);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-- 
2.34.1


