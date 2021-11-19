Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C11A456D81
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhKSKfd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:33 -0500
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:20503
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234784AbhKSKfa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAvo35BaqwtVRuxJ14Sh0je/+ZiTCX9VA3jETYeKIn5sQeCzEQ9bERfy9NVZQLzk7KCGpqLpgMRMCqE4gA5nc04ppiNsRN4MOG4DHGaQS7i36JkZpgwgv0xzsog/dazJq0KTew7wKRNLhe39eO77ocGl+zdWEImPu57OBNf/weOUZDL1GHqfGhzrqIhHNcNZby7AVyn5+7QGeX13CYmWf+jy1xEYFhdWB66I+J4+lvCVXPoi6FkGUAUKTPUIjRjLY8lAaxHBARcLdvzVqrvIOsScmXXlrNnepNYhHJEvo3In240m6k68PmfKFZwGPEDVeNaYY5FXouYxGvvf66u4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0SJryC1kUaHCiTKgMAWoM5Ql5Wl12DvPc/b3BdlAKM=;
 b=Z4x8guGqtLR0SNJVcW3pldU5zyZryn0wurAPubj9qFtqp4dbuUKj9P8zjEOcocxIy82EmuqSlcVLdmt38FUIdPevMvIyWV/yhSvxRJukHdQpeLMCdAf5mVhI+ADM8tDCOtp+pjq88WveSInPNgzR4avqR8/VtCBH1Oi97zPHkNDZWbSslEg4urnl0O/PjBDUc0g7KpK3SHSJ3YJRcjHKkSGY64zvQckCUISOUkjEkszMwGVzRjEi50diU6Ab6ql8HmpfGVdR8C4NKDuTSoT9w9OqFLjJm9nB81p2alrHH+Z8SCpyhNvCF3pVXHfR8GSlDaSea3ciT7tP5+EElTj1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0SJryC1kUaHCiTKgMAWoM5Ql5Wl12DvPc/b3BdlAKM=;
 b=Xn31oQKaQLEx/nJN5rBGda4wqazYlr2jnlGLCdYC/drCsHe3Pic8xzQ+W4Z4w/Sf42bx9pC3V0ENUW4EGsY8sGBxwGv8NCa87NdgqNg67ppQdyQh2BIgDJPxx3NfyoKE5lIYsNxnE6WI42mtXe8GWvRr9NAnDAcdJ+GVU4XsRiE=
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 10:32:26 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::ab) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:26 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:21 -0600
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
Subject: [PATCH v4 10/22] cpufreq: amd: add boost mode support for amd-pstate
Date:   Fri, 19 Nov 2021 18:30:50 +0800
Message-ID: <20211119103102.88124-11-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2626010d-d5fd-445e-b38f-08d9ab47e174
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4383D05DB919BEBA7D612B02EC9C9@SA0PR12MB4383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eKC+G3NFz/ZHJuol3xw+BcUUTvTP3IVmdI08j+qDdXfglMFdiJTG3gfxhwIGN9yqEUpMZ1dmup/8d+p1XEaONIZGJj8uesHc+kQgAe6Z7PcziFpr6NOqfVaN6JANBN0dJQGdyF+hYU3BYgCnkqalqY/kfUWymf7btIXWs41kdITssuMTyqTcuWIwZhQ4Y1IEeoReIgbtIepeP+Q48F57NnH30Ggj8I+uDoWnsse5Qkins6VKKoJn+d0IWVizqBYSIe0h9454OE65t/FPwIT4ypdL0KNx/GnHZQk9iTpRLM4zSHZCnsJIMeLVmVEjQoLRzGBDAxqR56lYvpHV8GSBUjgGtVJ8JP/Qp6n7pF+ai1FNRyVb08twk8RI13uveP74v4jgwBc6lTb8CKXteNdHoTS5N+xKX+J9Kgi0GHPzyTSwwxx8Tl8ImdOrvLhKPQGZ9Nb6fClicGRmFGhZtafkpK1CylrBClV9CAqtVKLnH3FMe/VwfcPqNXDz/E6T6pbUdOqpFm8ckmZKX+y9w/3cLW148GqkCoobc77B59QMCaH+0LKWA54GmTVeoWdCS2ywaC8BX6F823kDznKn2rAK9AVBziJYMJXPdl7uW9e3GfIFIxSS27Yl6noagykyC4x5fb1WJN9em8uyIe6z2+HuhQQLF62GyPRL2lPlpROVqXdb/ymSmOWcjkPq8yr9jHGSFROS6ksejJ3uuOcQYWYVAhoe8G+CgE9r41JE+Yo+No=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(5660300002)(2906002)(70586007)(70206006)(8676002)(16526019)(36756003)(7416002)(6666004)(36860700001)(1076003)(8936002)(81166007)(356005)(336012)(2616005)(54906003)(508600001)(7696005)(82310400003)(47076005)(426003)(26005)(316002)(4326008)(110136005)(186003)(86362001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:26.2305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2626010d-d5fd-445e-b38f-08d9ab47e174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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
index 5e080d0dc45f..0c335a917307 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -67,6 +67,8 @@ struct amd_cpudata {
 	u32	min_freq;
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
+
+	bool	boost_supported;
 };
 
 static inline int pstate_enable(bool enable)
@@ -342,6 +344,45 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
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
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -411,6 +452,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
+	amd_pstate_boost_init(cpudata);
+
 	return 0;
 
 free_cpudata2:
@@ -439,6 +482,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.target		= amd_pstate_target,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
 };
 
-- 
2.25.1

