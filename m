Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098FC4187B7
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhIZJIk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:40 -0400
Received: from mail-dm6nam08on2046.outbound.protection.outlook.com ([40.107.102.46]:2017
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230298AbhIZJIi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSVJB6ClaIlGldVy1yHAgiCFse6owzzONylLEk888gdOIKXClJwlCpeccvM8lnbtjHzKT6v5bgt5r5daiksI+N9TsC2SPnWg99O4IksHvInCKJORnevMXOOczPa35NrOAZXb+Kc4F4N/vtXYVOfLnujCEFL1CnFLRW3+oihHuWjSPWimn9OjuOA3OO7rMPUcTgfcFnUVHryhVIjQvXFHsizFIsqJE8OVtA22QgNdK4B4OQrESNyfFFH4gMLIax2xFWMBB5wfWFI3cwfY0K7zRmdBfzYPEqYobYPnsfz4b/k0Sd/SZnsfqpmZ2Sr+fNGwDFeShk1h6pTazom9YG6d9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5PXaYbf9wVs53Kzkj3tyunWgynxkqdaG/dhZog/7/t4=;
 b=Izjc2t3ckZyNLrQwuyyikBt1zUXbfBr/nTQA+oo5xyJCvg6Vi9qD79OBIoY/NnP5PGt43wqwjTic3Op3httMUHru9WDiiWI9NMbI9ovGXEvbB1K/TkoqJX6iB38KaERqWpH9Nitxeq+8lKXeFF5VfLnrbtlQY3iNbTbyNmLzxyk/MIN8Px5/Lq/odI2wmXdImQXKD7Q09LD8lNFfbiQ2wqnWhk2QKnKmfq//tdlbO9K2+BXGQ3xp2WgSCylqfl2n3av+Accig1P7vifRF4pl4crRF0a53vdtvGqHV/yTP48L9zGyZHjn10oZWBzQTeQKc0jpe+E/cUYn5HuxdHsHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PXaYbf9wVs53Kzkj3tyunWgynxkqdaG/dhZog/7/t4=;
 b=YZ++YM+jYh2778hUO+hZGpRlK3p28b3rrXamP8Ur31jlfcmufPCCXT6LKuWNqcF7Pka//YixUlhWLqhMVfhXf+8Chu3nEkbvddlnheJRVy+amQf2jlN8zqfSLFwLXuOReJ9dL1hAKz/bGnz4BjHtP19MOZYnQZP+6fMnsQcPI4c=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Sun, 26 Sep
 2021 09:06:57 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::72) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Sun, 26 Sep 2021 09:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:06:56 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:51 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v2 09/21] cpufreq: amd: add boost mode support for amd-pstate
Date:   Sun, 26 Sep 2021 17:05:53 +0800
Message-ID: <20210926090605.3556134-10-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926090605.3556134-1-ray.huang@amd.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce672332-3783-445d-ef4c-08d980ccfd7f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4349C1E2669516CEA28DC068ECA69@SA0PR12MB4349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kamJhLWSmw4LX/Imdk4fmTRlynYciax1mC3arYGS8DEXZVh6wAIjhWlM7uO7QjWeZNC//SGlP2T25uU1W5Rkha+R0D+UwJw4IKaKAy9Ly/6NcBBjIfsVK4KbRaZ8Qgd/BrRg6bW5oVDC+XERAbc2wLFfo5J9Ac5FOi6YiM21FI7WbCNxfWXcO6+wp/YicFmZj5V3Aj7+g/cVOYAkvBSch54oZdv0RODVjlXRnPV3w7xHCybx2LDH77uQ2VGSUWt5SF/oJZq63fCIqwEKOguPjLB/s797vbjqR1rEAE/CCSAvh6CvsOsFVeXNp9rEHCs0ZjAGNIpDCUmCCbirX7cjng8PmsGyJOoShlUisc3/ffT0PxT3In2LhzegDNNtCFQ52L+ieNsvvlgDDA5LC8EGD0gH1VrtOmi7iRzn0JTyNIQwRpo2a5jsUIMiutDfeVdIVVC5yRHTYAsHg6FjQAeCZKdMhd5k/uEKeJTS0tJHPHTX2xcWNxc3AB/VBtdykVBxAk+FbEs1neMBJbis9C5OeEaEFNOBUWVZZAzPBk/YalPhxfqv02uaA+nPBmScwpBDVAHcYKajwFvUsPRRturZgqkDT5Tj2H1xFD0C0vWHi1cBxclH4vxy53ldtWlfxTBGXS0IohFoCwaL/8ETc/GJlFkdZQpxU93sp2zioz8gOpqbK2pOCyLav8YaBSp/06uTuBGpWZ4C1ImjAot/FojapmRFWn29KE5g4OLgS30WBSs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(186003)(16526019)(70206006)(54906003)(83380400001)(110136005)(36860700001)(70586007)(36756003)(7696005)(4326008)(508600001)(316002)(1076003)(2616005)(82310400003)(336012)(81166007)(426003)(47076005)(356005)(8936002)(86362001)(5660300002)(2906002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:06:56.2720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce672332-3783-445d-ef4c-08d980ccfd7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the sbios supports the boost mode of amd-pstate, let's switch to
boost enabled by default.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0c9f9c0c8928..847ba00e3351 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -75,6 +75,8 @@ struct amd_cpudata {
 	u32	min_freq;
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
+
+	bool	boost_supported;
 };
 
 static inline int pstate_enable(bool enable)
@@ -360,6 +362,45 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
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
+	u32 highest_perf, nominal_perf;
+
+	highest_perf = READ_ONCE(cpudata->highest_perf);
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+
+	if (highest_perf <= nominal_perf)
+		return;
+
+	cpudata->boost_supported = true;
+	amd_pstate_driver.boost_enabled = true;
+}
+
 static int amd_pstate_init_freqs_in_cpudata(struct amd_cpudata *cpudata,
 					    u32 max_freq, u32 min_freq,
 					    u32 nominal_freq,
@@ -450,6 +491,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
+	amd_pstate_boost_init(cpudata);
+
 	return 0;
 
 free_cpudata3:
@@ -480,6 +523,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.target		= amd_pstate_target,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
 };
 
-- 
2.25.1

