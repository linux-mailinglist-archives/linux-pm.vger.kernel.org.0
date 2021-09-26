Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817114187BE
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhIZJIu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:50 -0400
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:30688
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230250AbhIZJIs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/aPOhqz9/ln5MgUn//Xd+2E/PaFU7OaLp3oDh1DwDwdZ42fVKKIERPBEZSyMNHCOn6t4K8nVtxAB/SQangYNyss6ykykJheG3a3QprRxMoXOvBtTwSMlJEjO9yNCfaLqovdP+Ypjooj14O06tO+kfQzAfgBaqDum578YEtCWGH8t5M5mvLXY5es8N7pXEmKp0LnO0MC4/eL19FWEljRi0GCMgz+GWUsiKM4cl6xax7SwcmDecxyAobpE+q/6nRmDam5HlE07pyRF6Wg//wGDlIBWNaCY+FFlCgTAXBnlRWwUy9Sl6hQ0A2IEhZI5UH4y/f2QdeiMHbKt0Sr/pdcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LMmI7xW9aY8vBze/ZDVqdQHiunJXEvmOyG6yUC8R+fM=;
 b=NHJnab7d/fpqwVED+oEmQZYXggpw3Hj1ViMMiWXWaz7IGow1i4IbeNMhqJ4SmEKedCfOMBN66jjAKcND57IeHkAjU4bfvme2NqcGejeX3J+4X3LIPUBbJ62+vLULsy/g3/rqtdEyXjGqz1QwPrf307/MqtJD28xLfmQSsAJcQ80uuf1UyBDe14BW5sgZZPvR2z0BV5gf9K7HxLE4bKB/+WCEci5xH4haDHvR76sboWVNvzXiLeRzsNdXy+T3eLMcFgSuhCHXOQqvlU8V8Ac+wOnGzUef6Du5mR0y2xjMm3NRZ4uJXp84R30LAxlXnT/g6J1KJLO04asNFWWDCL8UPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMmI7xW9aY8vBze/ZDVqdQHiunJXEvmOyG6yUC8R+fM=;
 b=0EPU5BmupemgirMFErl71XO/4jEWCkoYqvsK0rMJhvxF7wM4zbSGEOxxA6biavuDaMAm9QEF+S/WKqhnyGcB5uG15It3/tSmhUuD69bWXxuurxgKpOLgiBZxsoBV5ENHsr7Qyo7a7GlTqv2rOYFqWZzgvyU7iCU1a/BYHI0ygDE=
Received: from MWHPR04CA0068.namprd04.prod.outlook.com (2603:10b6:300:6c::30)
 by SN6PR12MB2784.namprd12.prod.outlook.com (2603:10b6:805:68::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Sun, 26 Sep
 2021 09:07:09 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::21) by MWHPR04CA0068.outlook.office365.com
 (2603:10b6:300:6c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:08 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:07:03 -0500
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
Subject: [PATCH v2 12/21] cpufreq: amd: add amd-pstate performance attributes
Date:   Sun, 26 Sep 2021 17:05:56 +0800
Message-ID: <20210926090605.3556134-13-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab2011ca-e094-4bda-166c-08d980cd04c3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2784:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2784F9230B065A4C9811F45CECA69@SN6PR12MB2784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoCyeaoPXirDXQAsHuHaobeq3QWjKN/EqVANWDBQrRlG1aNbVTp1ZtfcNYTI49+jsxbeJR3+3+Xkibnb+WmkSbUUQWloTdBhnHa+9JZX/9N8z32+VfKt8mKajzbcJNwtMsRfLWDPBSXbOMhoeS2cDa5rJifySMzl7v5MLs6xXghO9LZClzgWLdDBPSholr+jGfnSKr5E/2BYpP2UO/PjEJ4fy7rbuo5rk/VmiN9KfQ2f2eQOz7uis0OPScIxe2cXaUj1IqB5uBtg+lU/Jlgf+3Jf4WdRh5oUHDWEhSBOYj1Ie1nB7b2zNmC3xnaOxcl8KVNGbsT1VwCr3wvN+5apI0FERUsHAuv5l/T00F/KIk2KkwEccXZI2BcX1zszBMrZyA+jxm34ibDr50kGyLvfpIcXG1cnoEy3E+JhCoypP2jMZeQB5nVnsxhVz40j/qxOTX+GCIahW2fV+Sox1kLKlvNh7PROiytmI3LX2FB5Cmi5WltN2dnM95wFSUWQD0wT4J2pzVd5NCaGdDa6S2a0s007fQIHmErqgmHTnoV5etZXC6YS+aulft8xgKVmBx/iCCTTJoapjzAWeT5VnALxBNnpAxhZ3dIz1fhJsh+U9r0UGz/ivsfOPZqm+ecViZrB3jWQ74ILb0imt0DxSOo/inlI4oRvYqScsE7yQv6cHZ7GfHu1I1Z9CHDkzLWD1CyIo9ZdCbpdT0H0ZQx0v4HnnxobcToAysQ3Yv2kyjytUvI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(7696005)(356005)(8676002)(36756003)(316002)(81166007)(2906002)(36860700001)(4326008)(47076005)(6666004)(26005)(83380400001)(54906003)(86362001)(110136005)(186003)(2616005)(16526019)(508600001)(8936002)(70586007)(82310400003)(336012)(5660300002)(426003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:08.4721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2011ca-e094-4bda-166c-08d980cd04c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce sysfs attributes to get the different level amd-pstate
performances.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 16fed25c3400..b0353d13f74a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -578,6 +578,50 @@ static ssize_t show_amd_pstate_min_freq(struct cpufreq_policy *policy, char *buf
 	return sprintf(&buf[0], "%u\n", min_freq);
 }
 
+static ssize_t
+show_amd_pstate_highest_perf(struct cpufreq_policy *policy, char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->highest_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
+static ssize_t
+show_amd_pstate_nominal_perf(struct cpufreq_policy *policy, char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->nominal_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
+static ssize_t
+show_amd_pstate_lowest_nonlinear_perf(struct cpufreq_policy *policy, char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
+static ssize_t
+show_amd_pstate_lowest_perf(struct cpufreq_policy *policy, char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->lowest_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
 static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
 					  char *buf)
 {
@@ -585,17 +629,27 @@ static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
 }
 
 cpufreq_freq_attr_ro(is_amd_pstate_enabled);
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_nominal_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 cpufreq_freq_attr_ro(amd_pstate_min_freq);
 
+cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_ro(amd_pstate_nominal_perf);
+cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_perf);
+cpufreq_freq_attr_ro(amd_pstate_lowest_perf);
+
 static struct freq_attr *amd_pstate_attr[] = {
 	&is_amd_pstate_enabled,
 	&amd_pstate_max_freq,
 	&amd_pstate_nominal_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_min_freq,
+	&amd_pstate_highest_perf,
+	&amd_pstate_nominal_perf,
+	&amd_pstate_lowest_nonlinear_perf,
+	&amd_pstate_lowest_perf,
 	NULL,
 };
 
-- 
2.25.1

