Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D87A403C25
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352044AbhIHPCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:46 -0400
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:4395
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351854AbhIHPCb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fupqjP/mw28qanmL+4GBkOLMk6ynaRiZhzC6nWpQrUyNT3N4zVQI5XALeDee040VEZ0eCUm7/MTYAG2xXbbO9mFo47whSYFhN+Twr4BP/RnYT21CuweAsSpcS7xg+Zte7lznCidGnnRgXMsGl+VF4GonPr0IANDvmQ0xctTvmYR5BkYtriuhpalLggz/4EZwHhLZ86Lvqi1O0wfihlWZTR+1oeP5jRa7HK9Kc9tfeh/ffDyilRdK5AbQjtBqQhPer40n7naEED6y8EMkOA4FcTXpwux6Ns1MIr9ozBMC0VqIbBcK0DY1y0YFt8lP+1KL849pdeUQU0y8Sv/ie08urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0Sts+f19HSD1eDbCMpFPpFVWoJBFJa0nO5rBOh8C4B8=;
 b=HvdbMgRET60LJQMtcsdDyk7r5AqhTzBJT/W1aCHnkffoyDfDtTz06p5779pt/xZ5ZyB2N9RCgANEFqkmQ5xLGCX5nCPvG39SwCCqJm2aHJpIZew2KyWtAXJzvPUILKFtvDa5x3/Td0auZqnlvtU+M1y/lKY9PCj9NhJHz9NioNMXFZwD2M7LpD+HEGF3HHF1IHPlffpHX6ZL1VZhKNNK/LB2sDno35P13IQC+dmG4NMWwNKLHHjz/hxhry1R3zHo2rY6QM7ToieLGDhYR5GOVuaLH1amHZKuAuwTuqSphZCUwtgfr8UXM2AFxbpokDKTyvPCxu0W06PGZ9wyZNxKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Sts+f19HSD1eDbCMpFPpFVWoJBFJa0nO5rBOh8C4B8=;
 b=mBgH2WbPkSzeqQSeX1MxhX9pL2YOZ0VqPxsZofSIOkZ2stbYFO3RLMd9gs/dnEjqtvsP6CK2qPy/+3nzcl5GDz79c5Zu/wYTHg1VIqP4coA6ykqTcwOAiXewTYzR4J45NUmfAhF70BGYhVj+AakBSm7OnQMT36mmUPSEq93pEg8=
Received: from MWHPR11CA0039.namprd11.prod.outlook.com (2603:10b6:300:115::25)
 by DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 15:01:21 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::bf) by MWHPR11CA0039.outlook.office365.com
 (2603:10b6:300:115::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:21 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:16 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 08/19] cpufreq: amd: add boost mode support for amd-pstate
Date:   Wed, 8 Sep 2021 22:59:50 +0800
Message-ID: <20210908150001.3702552-9-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908150001.3702552-1-ray.huang@amd.com>
References: <20210908150001.3702552-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d094a05-79d9-420b-4e7d-08d972d984df
X-MS-TrafficTypeDiagnostic: DM6PR12MB3547:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3547FD1C2073D7CA5FF4A938ECD49@DM6PR12MB3547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRQ9bnCY6wBiOTmbgM7szG5rlcVWFcNaWz23cwQ4QfELfeRQQTuP1ypZVoyFdCgsBTY0dNdrNeuQiYVyCHLCPhmoQi4/6kREeDTwECto6rQQLydg8phXywVOg5hE1etab2dsH0fkwpMyAKlDtz3/53NiAABK1mDE1WbztJYvXIxx1FysZF9CgzfNT37EEZsvaxjlna1YYy5r9CDmQuWnLurcnkBBZ15R4kVe1GDLvFHbacvGildUqg/Zk3uh1qBQbzYG4DyIrLTbYH73zfo5Z11n+ZYGroSC0gF4MjUBjgxAnOWzNpHuBmp8aTXY2RF4rV3EtMlbonBlPiBb6T5phgvHRXNcdDYNuvALn0Sc866dNWH6F8gXyl3GopabYLH3+huXiSfFUik9KwtdA89nxbYHNtWRBI8i/EZG8Fp63Fdk6Uor/0FzVnIcrCwOtj6qJYNHgsmULMJ5m+WVnfQextRau/XbB1f9KGG1Bp/AGvH6nUJskTPfa8nReq6ZDMYK9AoQm2uzWFcoQYj6cKwZwBbmSqkUGdUnO1sbvaKoJG5L+fy9XluXxYgD6Fi3xlM3fL2wyWKRwuB1X8yHuHxUxsEJcv+80Y+DLpm3zb7AxoNTK4Zsc5+KIekp6u3rtn6Rem/E4Cb82Yhu745fw8I6eJw8g0Za46ys+ZkKeiMHVOWVpoDbTLlc/YExvPDe+11Pxp7ng5VvhP8f5ZE2m1NSuC60KofGq//tUQenNznsu5w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(316002)(47076005)(54906003)(4326008)(110136005)(5660300002)(83380400001)(6666004)(26005)(7696005)(478600001)(70206006)(70586007)(82310400003)(16526019)(186003)(82740400003)(86362001)(356005)(81166007)(336012)(426003)(2616005)(1076003)(2906002)(36756003)(8676002)(8936002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:21.0673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d094a05-79d9-420b-4e7d-08d972d984df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3547
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the sbios supports the boost mode of amd-pstate, let's switch to
boost enabled by default.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ea965a122431..67a9a117f524 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -75,6 +75,8 @@ struct amd_cpudata {
 	u32	min_freq;
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
+
+	bool	boost_supported;
 };
 
 struct amd_pstate_perf_funcs {
@@ -229,6 +231,19 @@ amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 				      max_perf, fast_switch);
 }
 
+static bool amd_pstate_boost_supported(struct amd_cpudata *cpudata)
+{
+	u32 highest_perf, nominal_perf;
+
+	highest_perf = READ_ONCE(cpudata->highest_perf);
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+
+	if (highest_perf > nominal_perf)
+		return true;
+
+	return false;
+}
+
 static int amd_pstate_verify(struct cpufreq_policy_data *policy)
 {
 	cpufreq_verify_within_cpu_limits(policy);
@@ -402,6 +417,37 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 	return lowest_nonlinear_freq * 1000;
 }
 
+static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
+
+	if (!cpudata->boost_supported) {
+		pr_err("Boost mode is not supported by this processor or SBIOS\n");
+		return -EINVAL;
+	}
+
+	if (state)
+		policy->cpuinfo.max_freq = cpudata->max_freq;
+	else
+		policy->cpuinfo.max_freq = cpudata->nominal_freq;
+
+	policy->max = policy->cpuinfo.max_freq;
+
+	ret = freq_qos_update_request(&cpudata->req[1],
+				      policy->cpuinfo.max_freq);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+{
+	cpudata->boost_supported = true;
+	amd_pstate_driver.boost_enabled = true;
+}
+
 static int amd_pstate_init_freqs_in_cpudata(struct amd_cpudata *cpudata,
 					    u32 max_freq, u32 min_freq,
 					    u32 nominal_freq,
@@ -504,6 +550,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
+	if (amd_pstate_boost_supported(cpudata))
+		amd_pstate_boost_init(cpudata);
+
 	return 0;
 
 free_cpudata3:
@@ -535,6 +584,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
 };
 
-- 
2.25.1

