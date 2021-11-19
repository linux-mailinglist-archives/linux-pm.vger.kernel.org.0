Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2D8456D83
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhKSKfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:36 -0500
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:13280
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234774AbhKSKfe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCpqaXAtBMNrJWTLGDAYvwDAP2XGbS2qX6QYtjkbEIuo+MIMJC/ZKNYSV+w1lAruLclJobVM/qAOJjF5KrEiYf1asFUtL2WRHRaF9vZBlrw3m/7X7euKl7wMzt/DGFWbIppksxEnTheX8cSxzdYQaBdWLaA3af8orMPcAWyaxVzQ65vGwJyklkvZd86c7JWMJhhWV6FVw34wXvA5330rFP/awuqI9O2hlG1JV2YWoqhoGvcKrE20fCOTuDFlwaq4WqothWM3rNoMLPflZph1Nj2noHfiF93CZDfGr0F27mJYhnDLm24O2DaqY4grCdCjNiQrJuMvhEEsoj78o9p4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77ES6NvSxcJi+B9/hYvboDAJC/ShQ/nX7rhm3C13UyM=;
 b=j4cu7WFW6DlkS5RaPKRU9Npi/s0ZGTyZ74qdZF0lEcFf12FjMfkEusvwDi9v0j4jj0jhhoYJ1on0+/XxehtSyNJE2Tcel9EufOgoLZuMyUv+NW+3bWnpQvgBb18/Tt6+Ds34UkwnbRdPEM3tT/lxoLZon1dUYqdSrbB12IllW8UBtxsc27MPAeC+9JJjtLY0LUxa/MGmsiB0GpGZ4OEBhoJd0oYtPplGpMRnlhxc9QxCfsQgAOJxto0dRVogaPGHqk3OOx4uOe/WJKMsqP3Vfi1zO1a0DXGYdJsfce6au2wa6wVS1n9wJ7XY/AgzV1QhtK1eGFTX1816ahb3Eis2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77ES6NvSxcJi+B9/hYvboDAJC/ShQ/nX7rhm3C13UyM=;
 b=WddnlMmE12pZXHuye8On+Jy4HONbwWKg2e5e1i7TKDPsxumilS/63bYJvWV2oW48MHMqxK78G8x9I5vh2ofZ7S9eMGWtbzli5H2HxIra0ZmfwlExCLdwgbeQfbLaeuCL650Dylpyr1esI5+BkOkykcEqbhVhfTeVuKELWZ6owl0=
Received: from DM6PR04CA0005.namprd04.prod.outlook.com (2603:10b6:5:334::10)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 10:32:31 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::ab) by DM6PR04CA0005.outlook.office365.com
 (2603:10b6:5:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:31 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:25 -0600
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
Subject: [PATCH v4 11/22] cpufreq: amd: add amd-pstate frequencies attributes
Date:   Fri, 19 Nov 2021 18:30:51 +0800
Message-ID: <20211119103102.88124-12-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bdc2f6a3-e4d1-4930-f917-08d9ab47e498
X-MS-TrafficTypeDiagnostic: DM6PR12MB4563:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4563D0A67ABC4692B965E424EC9C9@DM6PR12MB4563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUuBG0cZktjS+Lpd/7X1Tk8HD5ttrMlA6hXp7ojTdExwr8aMgr7LBzWcLv42gR86l+628fKwgpPaGCnKlS9TI5u2skhO3lGXv7KAgiFqXEq9KDPLm/dhPatadjGHNDy5Zlab3NxRoOgUpzgC17wRpG8KlW61m5ZNShCQ3ONuN+scb5BMY6FmI3Ode/6pj+s5RPAyxw6PwV72vbb6PuWJ+uMimjbjjCy09Wgmq5CFZyYp+M+fQj3Si+A9BfRK+Yn/Y6nIYsJKuDNEdW+G/8aPnoXVcYeoJeRDHe2Am0yDnV8Cio8uJQaxWVpLATcIn2uYPtwdIMMDhMLGXFZYfR6cgQmXM1HbfyBmfs3VhE4Usv0Og22zcneiqkuDemq9UKhXfGMEAfEroPkTETJPJBtX+f08r1ijLAZUP/xBv21RBiUDgDfaZvBQL9EuCva8GIBfigFDVSN2c1sAXl8Es3ROl8SVGOhfzMWB7m9NAoaYD6uYj59KYM0Fv+sAHIRSjlzCPvgW6a60pQzgp6QklBKm2AWnxy0upNq3KEKZUjOMkbIQCGkaKf1V7dm214/fTTTtP3nvnbwdjmWI/Fexj+0NtmSjbyAX439NqFxPGJ3tHGs3FUMC8fqyNyYR62a0dp0i9AuIXMUPxKVao/hxw83QrjnLsW6dkzxElakTmvk8NyAcFREB+jVRjLwmIYoOnGt+UOjPIViey0t74QkA2KolBoaUY84t5wa5G4G+cFEu8z8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2616005)(2906002)(4326008)(7416002)(86362001)(6666004)(1076003)(26005)(36756003)(70206006)(426003)(336012)(7696005)(5660300002)(110136005)(54906003)(8676002)(47076005)(186003)(16526019)(70586007)(316002)(83380400001)(8936002)(508600001)(36860700001)(81166007)(356005)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:31.5004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc2f6a3-e4d1-4930-f917-08d9ab47e498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce sysfs attributes to get the different level processor
frequencies.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0c335a917307..09c5fd8bd9da 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -476,6 +476,51 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
+/* Sysfs attributes */
+
+/* This frequency is to indicate the maximum hardware frequency.
+ * If boost is not active but supported, the frequency will be larger than the
+ * one in cpuinfo.
+ */
+static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
+					char *buf)
+{
+	int max_freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	max_freq = amd_get_max_freq(cpudata);
+	if (max_freq < 0)
+		return max_freq;
+
+	return sprintf(&buf[0], "%u\n", max_freq);
+}
+
+static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
+						     char *buf)
+{
+	int freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	freq = amd_get_lowest_nonlinear_freq(cpudata);
+	if (freq < 0)
+		return freq;
+
+	return sprintf(&buf[0], "%u\n", freq);
+}
+
+cpufreq_freq_attr_ro(amd_pstate_max_freq);
+cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
+
+static struct freq_attr *amd_pstate_attr[] = {
+	&amd_pstate_max_freq,
+	&amd_pstate_lowest_nonlinear_freq,
+	NULL,
+};
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -484,6 +529,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
+	.attr           = amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.25.1

