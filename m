Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDF2403C27
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352054AbhIHPCu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:50 -0400
Received: from mail-dm6nam08on2078.outbound.protection.outlook.com ([40.107.102.78]:62240
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352046AbhIHPCs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrJO9kE+JlkZdrZhg+wvQJ5pPY6UdlGCWpjtKh+0Vl5DUtg9DVnIEo9HUp4Y5pYA3UHt2iKWK61CT/mv2iFOKj5OpZqur3F9VPlly2HbT8DrsvfrPzm4mzraq6e9TCt9zaAEHLxc0tTv3d+UjRCGr5Ct1+Qw1Wxl+P9z/Sw+pqE/fJXkHalLLm7M/HzHcD5XrWKUkAKAb9m5+TTVK/R9CS3M5i4of/CvGeL4SmrM2eXqvzTuu2QmFokmAkMjUO9M7P1ephU7tjaYZGrDIaOPJdFhuveScqiUW7YC/Ysst0+gNTxd5V47TZKZrAPvVuLzv4LG0dup8uwz6IYRfoAWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pv4oq08kf3tAlLw7OGigFu4eeqHnwr1cI0XJnv+bU+M=;
 b=Sd1RaphKf3cr43AHoHE3WIGcSsfx9nV+HL5Rf33xhmkZQReqbZhD07s8E+ja6tX2eQUdAbAAGR9kI1lz+NUCSG3Dqejo83uRAbsWgBvIB0hKcPtgd3q3TpBEMOZ06CY2fmr710JkSOsXMERGK95aLAyhie3JloMCe3H1A0QsnkvK4YMSAxCaBPB6LuwdtDU9m5SEq4Fxh5VEqtooEENqAHS8F6hZGRag5O+Rfn67r27/ye462jT8CgUUwfdhWsM8EI/D+2BAGeNvZk7wALhsJzIHRy9jWr7wV+fIR2zUoxMXFdukLnIZrBg6Y4pXRhem3bfpPALIT0QVPAsfRx2dXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv4oq08kf3tAlLw7OGigFu4eeqHnwr1cI0XJnv+bU+M=;
 b=tYnN0pCGw7Bh6kP6OajJeSBOldt0gILAYq/L1y2E5hlBWQQGBU9OhBlwfa4V10nH7X1Khl8qxtvbK0PNzlwsM1CfWOuvM2KW7Vbli19XZLdMH6qyruqtPhGg0EopI6IDvEus2HK4DqfFoxOmr2DetE0YMRaK3dn48vcihbdBfVs=
Received: from MWHPR10CA0018.namprd10.prod.outlook.com (2603:10b6:301::28) by
 SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 15:01:33 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::cb) by MWHPR10CA0018.outlook.office365.com
 (2603:10b6:301::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:32 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:23 -0500
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
Subject: [PATCH 10/19] cpufreq: amd: add amd-pstate frequencies attributes
Date:   Wed, 8 Sep 2021 22:59:52 +0800
Message-ID: <20210908150001.3702552-11-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f9dabfd4-399a-4e9f-ff88-08d972d98bf2
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5405:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5405EE849CBE5534082BEB27ECD49@SJ0PR12MB5405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8S+HLIRajyTSN1U6YMJa7dk9yJaq1l4aCdCXoRULHxnM+wNQPs3H1iG0bUz1U0o6UoRzLOpMoxab4FVjOGkxaEoDW7kVbElalLhnnges7vljzjsWIBhETrejgxB8TBCCIdIGBH/+QXURHtpVz1bPvh9GU9l/J3tJ5AJOEMdfNvScMDO9oe/V67h2Z/NJA99ifOODU311FblQeq5dqOrb5XSEwPRBvW/9KLqbmf0HDUlamMeBFz18+IPEttgD2IlhjMofe55iJUyK/fr9x5IZVPm+DHO7AQ1GJokulYN6cQ0R4OhjExFOVwQ151jrYeqnBfgQ5jVGmJGk2uef3HN055uIi+RkfsY/++DSQdNatIh/P/WZQEoCck5p+85/edm8iGWVHISXbXlfm5eDHUVt9uJXRlq6A+jZrBeSpFZRb0C9Ol/CH1TTmy7CppS6iTccqFyTq2/c04SPeMrO2X7BD+NqQF4BYzNvYDKF7JXuuujyBoEUerurXsKM53tLicDBphtUH4wj/GjI4bQNCE/j4li2RakUbW/M0FcrMdmUl5RAKlS1gNivR7J0zBrJOwBquB63RgTC5JI9dmpQxxaNvingrdqeJuBtxVIel5CPpadnQTitDjcNzaBWM0XTvsR2PxJ/gFDrZueozi8BCvrj0qMhSAihMEbOspkH6YFTNuunqs6BsO1Pl5BsslyXxW5nz1pwqtFMXWVlMisz28PIHzvS6CI/GWezPYjGrniIEsE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(26005)(36860700001)(47076005)(426003)(2616005)(1076003)(4326008)(82740400003)(70586007)(82310400003)(5660300002)(86362001)(186003)(83380400001)(336012)(81166007)(70206006)(478600001)(8936002)(6666004)(7696005)(8676002)(2906002)(110136005)(356005)(54906003)(36756003)(316002)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:32.9524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dabfd4-399a-4e9f-ff88-08d972d98bf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce sysfs attributes to get the different level processor
frequencies.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 80 +++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 48dedd5af101..3c727a22cb69 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -577,16 +577,94 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
+/* Sysfs attributes */
+
+static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
+{
+	int ret = 0, max_freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	max_freq = amd_get_max_freq(cpudata);
+	if (max_freq < 0)
+		return max_freq;
+
+	ret += sprintf(&buf[ret], "%u\n", max_freq);
+
+	return ret;
+}
+
+static ssize_t show_amd_pstate_nominal_freq(struct cpufreq_policy *policy,
+					    char *buf)
+{
+	int ret = 0, nominal_freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	nominal_freq = amd_get_nominal_freq(cpudata);
+	if (nominal_freq < 0)
+		return nominal_freq;
+
+	ret += sprintf(&buf[ret], "%u\n", nominal_freq);
+
+	return ret;
+}
+
+static ssize_t
+show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy, char *buf)
+{
+	int ret = 0, freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	freq = amd_get_lowest_nonlinear_freq(cpudata);
+	if (freq < 0)
+		return freq;
+
+	ret += sprintf(&buf[ret], "%u\n", freq);
+
+	return ret;
+}
+
+static ssize_t show_amd_pstate_min_freq(struct cpufreq_policy *policy, char *buf)
+{
+	int ret = 0;
+	int freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	freq = amd_get_min_freq(cpudata);
+	if (freq < 0)
+		return freq;
+
+	ret += sprintf(&buf[ret], "%u\n", freq);
+
+	return ret;
+}
+
+static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
+					  char *buf)
 {
 	return sprintf(&buf[0], "%d\n", acpi_cpc_valid() ?  1 : 0);
 }
 
 cpufreq_freq_attr_ro(is_amd_pstate_enabled);
+cpufreq_freq_attr_ro(amd_pstate_max_freq);
+cpufreq_freq_attr_ro(amd_pstate_nominal_freq);
+cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
+cpufreq_freq_attr_ro(amd_pstate_min_freq);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&is_amd_pstate_enabled,
+	&amd_pstate_max_freq,
+	&amd_pstate_nominal_freq,
+	&amd_pstate_lowest_nonlinear_freq,
+	&amd_pstate_min_freq,
 	NULL,
 };
 
-- 
2.25.1

