Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA5A43FCF2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhJ2NGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:06:38 -0400
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:12256
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231838AbhJ2NGY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7Qw3HvatUgQmUrTa+VJv4X5UOmeBLgr/JTam5coi0rQ5zWvwqyfFvxaLaZougJ9uJK/5B73iwgCTAT2FiYNUnil6swsSDrQFDC1yWUdsPAfFvXzTV0zpZexmdV1ZAfOZr9+4QzfH1pbSrnOIuh5+wAiTbqo0YdXQha6koCwVzhKtty8mdrgjt2Yoc4uDuv7dyrsov9w7McOl62y05NEDjlX5KXvPdLrM7nNRgBYYl0aOp9JJ+7wrY9SEFGHk+JM6czNzWnPpXvN1MfHXnjeQQOkZILeOENkm+2BuJwJbqvOcLsFekixBv/5ONK9xAcKS2IzzxM2lPROAuW5p+wYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPkjuE4onkR6q+wD409+OO6QDzZB28QiKIvffbiQGek=;
 b=OFUeUrcsABWlU3MdpXyEIhgiIHCbxhsB8tqcY5fobuJAlGbGs6NOEEz/+7Gi4G8oJylkhkS28I64t2JGWRHtcu8Oq+ykNRueTT772zWSq6kwjHqRbHbX52cWBzbOmnqd0QhqR6Kk76S9kE690LxgVrJ7NV+RX1v8bHdNLmCOcdVpSkWE7ybHE96FhjUwpG5y2cFZAFZpas3rN60nWRatTb5FNNGHGBZwV9Cl7sZ0Vgx2kF/cSSkank6f0wOenNPoSRLehc5vaUn7ZjO9lS7NNxRLBx3ytZ2Y9OCKX+ZAsxzCN+/tEPOhf+2ogFU53Yj09tKFAjT03sHaNMXhgZN+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPkjuE4onkR6q+wD409+OO6QDzZB28QiKIvffbiQGek=;
 b=tVg/+1N12u6g1rolB5/fg9X0HNRZJsn+OGGdUaD4b+2dFIcsYkgtvNFyBN1Wg5+GQ4FikOV9g28B8AZwMSWeyoG/rkIAdij7g+plhicp5CA7zqDpWgqQS7IAljKJq/gDe9ZLlhD/8jIcb8uhPDCbvQQq+iJDgE8C1mz00lmeXqo=
Received: from BN9P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::28)
 by MWHPR12MB1135.namprd12.prod.outlook.com (2603:10b6:300:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 13:03:52 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::1a) by BN9P220CA0023.outlook.office365.com
 (2603:10b6:408:13e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:03:51 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:03:46 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v3 07/21] cpufreq: amd: add fast switch function for amd-pstate
Date:   Fri, 29 Oct 2021 21:02:27 +0800
Message-ID: <20211029130241.1984459-8-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029130241.1984459-1-ray.huang@amd.com>
References: <20211029130241.1984459-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617ea4af-10ca-41dc-7ec9-08d99adc8e3e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1135:
X-Microsoft-Antispam-PRVS: <MWHPR12MB113551C91B7B6CD5BC9F61F6EC879@MWHPR12MB1135.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Prm7UN0GTyrPXIVnMWbXPuD5coFBGq5w/tsusNJnNg1eL0w6asxEKbGBLR7ZetbJG4kp1e1AgLDlO0IKe+m5BS6uEujlQmJ5QI3pzncDL+E+ucTe549ffBa3n0aXQ/ujAludZhaipGSZIC/4uF0242PY1rlF/CttzuNSGqs0r0PwDGCbPKKVHhttjj4zr23nedKT5l5q/rIRtZk3+ntOV2IStzkm8QcSs/XE5I+XY0pS0gkF/5N+Ex3u09pgNogEnKRTicn6B6qC+D3wVxdcQXIKNuCWjTWNCq2laH/kSuDYSCz8W0xvXr50K81iDpfi3eG/2vvP5Tl4+qKEwZ5cgFkdmGitb0+bJaM+6hhHIPK5Rflgyhn0dVYG14aMpiy7gsSwysUHYYTjILXs0TPGJ6sLc86iR08LCdcD0Q9RxTFyXsCrt7qbVKg5aiNUL8xh9vSACiQl+RMq/hIEpr44+UkP9pp/6z/dgApHhRKLT0LHRWvr/HvgfJzODygNHGJR7smiXs6LxDM65g4knC9oS++LS/IfheR48pC5bjxa5GoZRbuN0ury6YaupR5tJXSQjt6u0Bw2DYUVFj1EyHvQjzErv5Tzf7vn1tlejzLpHODyn6rX/GjnCuKTUizPyeDuqgjtqq7KAX4znIMm37WcL8hrLty4Ll4NCZc11QQcJrlDeIUh7hfB61MDDSNOT2/M6avzWcadSicxGgEd9XppHTtAtkPPNo6pwI7pp187pY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7416002)(54906003)(336012)(83380400001)(356005)(508600001)(186003)(47076005)(2906002)(426003)(2616005)(82310400003)(70586007)(16526019)(70206006)(110136005)(8676002)(7696005)(4326008)(8936002)(86362001)(36756003)(26005)(1076003)(36860700001)(316002)(5660300002)(81166007)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:03:51.8949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617ea4af-10ca-41dc-7ec9-08d99adc8e3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1135
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the fast switch function for amd-pstate on the AMD processors
which support the full MSR register control. It's able to decrease the
lattency on interrupt context.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a400861c7fdc..55ff03f85608 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -191,6 +191,41 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
+static void amd_pstate_adjust_perf(unsigned int cpu,
+				   unsigned long min_perf,
+				   unsigned long target_perf,
+				   unsigned long capacity)
+{
+	unsigned long amd_max_perf, amd_min_perf, amd_des_perf,
+		      amd_cap_perf, lowest_nonlinear_perf;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	amd_cap_perf = READ_ONCE(cpudata->highest_perf);
+	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+
+	if (target_perf < capacity)
+		amd_des_perf = DIV_ROUND_UP(amd_cap_perf * target_perf,
+					    capacity);
+
+	amd_min_perf = READ_ONCE(cpudata->highest_perf);
+	if (min_perf < capacity)
+		amd_min_perf = DIV_ROUND_UP(amd_cap_perf * min_perf, capacity);
+
+	if (amd_min_perf < lowest_nonlinear_perf)
+		amd_min_perf = lowest_nonlinear_perf;
+
+	amd_max_perf = amd_cap_perf;
+	if (amd_max_perf < amd_min_perf)
+		amd_max_perf = amd_min_perf;
+
+	amd_des_perf = clamp_t(unsigned long, amd_des_perf,
+			       amd_min_perf, amd_max_perf);
+
+	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
+			  amd_max_perf, true);
+}
+
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
@@ -311,6 +346,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
+	policy->fast_switch_possible = true;
+
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
 	if (ret < 0) {
@@ -360,6 +397,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
-- 
2.25.1

