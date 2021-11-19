Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2B456D7B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhKSKf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:26 -0500
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50]:34625
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233051AbhKSKfT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elRiiRWtHkXE8gqQNIVcJyWibS9r5BqWrYB4VJDbx3upHCzxxFCkHEjMy809f0dtemwZqnypaLC6FLr47tcT6e8TYb4VKE34Ox+a9UvoB7ZCfQG6MHwgeuIN/+HFoFrTH81yVBo8MGIUNuE5IQjdV3pqwMT+dr4o2K1TtchSMMk4rA+7k+J9P3fnBf/pH/UXzCIQaW0xFg6l7D+KTCw0KFPWKDepDJ6pHdeFMoYQLaMhQ+c9zJ+h5LHS8pgkbP94AAiaZO4eMnnFOFlqT6IW50WWQ102Dx5mj72S/lex30APFGCjjKUUtdCsbg3koCnCUPdeOX9UzixXptwvqZrEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNTsNYuDnEXGmvpZUs/vnfiEMc91n1rdZXay8lIv8dg=;
 b=bFy4YclVld4HezIy05PFW5Qh7UYdAA+KNqDtAAaOq4qXrBSjRNAVmp9ZewYSg+W27MSs0Vr2CZikwbJaHIzo49FWhdiLQo6K3C8k8oNf3MmQrOgRdAqJeQdLebqUstB2m8dB9aCm5izym2NScY/PRKNgbT6/Sggf4OzAdK//R/398SySZhJgu3cNSzYgVCx3XY5Uk69NcP14GLV+UdIfiedzcDNj5qo0attuWlJqw3HO32bupr2mrdio0oWBDbhH89h+5ZlSI6uj8afXNGsa7OE2lhiWLhKyIGkM33nGGdRW14XRXvzEPq9KGc5woC89JOZYhFkeksyUvc004A4N6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNTsNYuDnEXGmvpZUs/vnfiEMc91n1rdZXay8lIv8dg=;
 b=HLR64VQrvceUq1VE5DeEO8as3ObFiQ3amHFa6z1Q8/Wo5QG5I4cODFR8YqfzqVheZtc5AseZIeeVL5DnNkrz5aXFut+AELF5RasrqTiIO5qg/9isll3MUEiF5c78dHSRHaVZn6yNrCx0i3OtsE+eCOW/T1xgvROgt+iyeejClIc=
Received: from DM5PR17CA0061.namprd17.prod.outlook.com (2603:10b6:3:13f::23)
 by DM6PR12MB3196.namprd12.prod.outlook.com (2603:10b6:5:187::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 10:32:14 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::47) by DM5PR17CA0061.outlook.office365.com
 (2603:10b6:3:13f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:13 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:08 -0600
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
Subject: [PATCH v4 07/22] cpufreq: amd: add fast switch function for amd-pstate
Date:   Fri, 19 Nov 2021 18:30:47 +0800
Message-ID: <20211119103102.88124-8-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119103102.88124-1-ray.huang@amd.com>
References: <20211119103102.88124-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2005acb-ef4c-435a-76ca-08d9ab47d9db
X-MS-TrafficTypeDiagnostic: DM6PR12MB3196:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3196140A7C5E83786B13D27DEC9C9@DM6PR12MB3196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIQsNw+oDJzxbf0wo4idZQ2ssL79Qw36CAhoUCEumFHspmTk0uSBwVLrAGdM6Z6Ia+kVD53GGhFhAm+sFh+ZMTeGDax+KG5EAV3zWeKmNcL2bGT00GAP6kQeQezq6wPBO/aZE9Vvq/U2IM9rzTFhUivCAf7Bz6fBqRnKi5DtGleUlwiQLQU1shg25s+DQ+twInwojmxWzxIxUqOXnvoTysdSk5bYH42JpWOD8SsklGiZOKjgZTu0+zjW5MVngANg6hbaac/W1i8GuHQD6EHjbJBwjuM5yzW/hLu4xxO1LQzz27lUkQnW5p+4ll4SwttlhDR7cgPcYEH40jqcyQtQsua9GQvuDCq5vBvJUazAk6Uc0ZdWIzoNVeO80SU2lhp92bBU66cmjevEWME8jTQIZtFEETzACoaIOxGKmSU/zdB3VZXP+z/2ecZBEJuND85Cl6RpFX/nC0EnB1Nbgc9ir3XGQV475ymD/1mNlvUBK8/gKMg9j4HXFxkRZYsYRekkgxvRI59g+JkutRDo/qBzz/Q7G9C1SoACHDf2SFfOoBM2af2jrPBAqc0FDn2F9WBPrXphbnONoB1+z4BsHNN3l/59yt4/BKaZ701DVP22E6lpC/2tGryvC8Sp7j0pMheBVaKcibLx0mRKzpGKj6/hOG2jir2VdNBiRpJPxX/kZRRQObZMQMxeu8iNvM0goSgscGW+BI8FddErMBfbaj+Mc0zi4DvbczcMpdGPWBoiiVNbRo0jt9+Iac4kZ3t+p8GNu+KgNK5ouFfTxkxOgixsDOW87frU2PmsdqVjsY+mx14=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(508600001)(81166007)(54906003)(110136005)(356005)(186003)(70206006)(47076005)(4326008)(70586007)(26005)(2906002)(316002)(2616005)(8676002)(1076003)(16526019)(36860700001)(82310400003)(8936002)(6666004)(36756003)(7696005)(7416002)(336012)(86362001)(83380400001)(5660300002)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:13.4892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2005acb-ef4c-435a-76ca-08d9ab47d9db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3196
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the fast switch function for amd-pstate on the AMD processors
which support the full MSR register control. It's able to decrease the
latency on interrupt context.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8b501a72c3dd..4a02a42f4113 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -177,6 +177,38 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
+static void amd_pstate_adjust_perf(unsigned int cpu,
+				   unsigned long _min_perf,
+				   unsigned long target_perf,
+				   unsigned long capacity)
+{
+	unsigned long max_perf, min_perf, des_perf,
+		      cap_perf, lowest_nonlinear_perf;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	cap_perf = READ_ONCE(cpudata->highest_perf);
+	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+
+	if (target_perf < capacity)
+		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
+
+	min_perf = READ_ONCE(cpudata->highest_perf);
+	if (_min_perf < capacity)
+		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
+
+	if (min_perf < lowest_nonlinear_perf)
+		min_perf = lowest_nonlinear_perf;
+
+	max_perf = cap_perf;
+	if (max_perf < min_perf)
+		max_perf = min_perf;
+
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+
+	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
+}
+
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
@@ -293,6 +325,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
+	policy->fast_switch_possible = true;
+
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
 	if (ret < 0) {
@@ -341,6 +375,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
-- 
2.25.1

