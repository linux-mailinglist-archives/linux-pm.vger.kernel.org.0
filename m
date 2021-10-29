Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C55843FCFA
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhJ2NHB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:07:01 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:15072
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231761AbhJ2NGp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l52pkHuRWuQu+r5eZpePptYonwDL7CbAdAhvWYDCy7UZJhqicqdmfJhcGsS8F8wswkmJBOJY6X86MzLfhTkcm89uKNYTD5FsL+capYWCQbC1XDevUicy6f4kol13J5U2TxLlx9AHJM21i9a99ugmISP0y7pkRlCbu2CD7WmW8ktCRq003WE9PSh5iTviBhqZ8MlzDQLBVK/oHlQAPUPsT0DMZr95kgYbuodCdrXSFW4V618rilM3QXqfvDtae4RXU+xtXqJ7OvOGPec2B8aCxbq7Rz3SVHiNlhrKZULDU+LjTAqdxSZZkEFYM5fMKM0G82zTL/wyXPyxoh+anXy/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4koFZNyKzbVPvWYlYBA4c7b/wsiz+tBh0FZ9BHmHyA=;
 b=AfDML8Tyx8olrddlzBsq9s3JJNj4HIw8r8c+Dyj5GYTVEaitrhf6rh4Zda26eQHjiG2UTMGi1M3jwDgNzsKOSuobDd7DKbnuOBdVwOkmsDaMNWAr1/9H5XTwT99cO/PDlmvqGfUT+ZXlF3BUYRLu5Y6UOUNhtAEEfiOkzlD7p9LGBAvTM7nq3Rs9H8u/B0/FVyjpvXqcxVN6NyXGNpOkebgTikR9ZH2nY+HAofHd5JnSbitWMLch8B8EkL0ko/Q5KGqDxGiKrymB0b7xh+lKxzLXakLGInszALca3DUX8qYKfh7jOPeBZmVoeNEYWtUET2HXn9NqBYir/fpBYzekHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4koFZNyKzbVPvWYlYBA4c7b/wsiz+tBh0FZ9BHmHyA=;
 b=obCPri57wXcPait1rQIeWsixuzbKh6VRjzdNSsSNH0O+rVVO7VovaAnZGi+/HOaMtG++oLO6uZimL/MLsosPzYLC8fWHDkh7VI+PLllvYyOG0/T9YMO/zIpBFXifNjUORlsZEkC3lNjCoD77RWTr+ltT9nx2kLbQJwwcW5vr10E=
Received: from BN8PR15CA0008.namprd15.prod.outlook.com (2603:10b6:408:c0::21)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 13:04:11 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::a7) by BN8PR15CA0008.outlook.office365.com
 (2603:10b6:408:c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:11 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:05 -0500
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
Subject: [PATCH v3 11/21] cpufreq: amd: add amd-pstate frequencies attributes
Date:   Fri, 29 Oct 2021 21:02:31 +0800
Message-ID: <20211029130241.1984459-12-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b1114c0-bebc-48df-36b9-08d99adc99bf
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4130457A55E09C87C633135DEC879@BY5PR12MB4130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eE3AhLSkZdwhmrXBSQlrnLnDztoaFnqOqtOiS7oUFTwgVUVkF3oeompPY0hFFImu8GQgwoZMEzerjyfj8ctCURgOVbRnmdGlkbwa302AZozfxYggKS9HEMAL15BV2xDaabOVoBIzQVFy3sWGzHwIekLAZkJxHHFRcaU+INEmuws7ttEoQWqwJ3VdoKvyTh+7JXU6u1oafZWYIesRHhFhpyVX5C2QOaRtuv0fS/c8827uL8a9IKtty/uZZcaHyuzF1DH35XhFnxIgWD1iFwoXQC3hJSsk0I/VqPQQOGF2pbCcw43MqpgT/8SZBs/pQ4YWr2SIax8n6hQ8zKicL//3pc6pbPtSJDuihTU58PylG5fQ8bcJmKrzp4bwziAbZ+7/Ljanl27i2H1AFIlJpWRvBX0VNUCtmb0YDzERDz5G0XnLmEzwuaXFmtTPMS7AMSAIug9eq5gfNOMssU3c5rfrGFcnfKW7/O6ZE+CNSrdCewgtiLn8IDtP86SupHcBgUHJSl9lwkyRQUSswA7x8dtaWzSOY7OvXeh05SLmfN2OGLEc87MaYRjEkET0O6REFq1UQYFmDRKGqUxsYrLCoTPpILBoc2X2aMnuky/N6uKXhy4cPhl9N7+VdI7nv1d6jiaEZQy8tI68b/svr6VHXZP//hLCnX81knMlZOvtBArkWk9ROqONwUEed6hlTkNfD/tolNQbF7kpMSUtt/pyOe4fvbO8NcgijvCzJm6HoPDsthM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(16526019)(26005)(70586007)(70206006)(7696005)(86362001)(426003)(316002)(5660300002)(8676002)(186003)(83380400001)(336012)(1076003)(508600001)(110136005)(356005)(36756003)(6666004)(82310400003)(8936002)(2616005)(54906003)(7416002)(81166007)(2906002)(36860700001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:11.2134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1114c0-bebc-48df-36b9-08d99adc99bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce sysfs attributes to get the different level processor
frequencies.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9af27ac1f818..8cf1e80f44e0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -485,6 +485,68 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
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
+static ssize_t show_amd_pstate_nominal_freq(struct cpufreq_policy *policy,
+					    char *buf)
+{
+	int nominal_freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	nominal_freq = amd_get_nominal_freq(cpudata);
+	if (nominal_freq < 0)
+		return nominal_freq;
+
+	return sprintf(&buf[0], "%u\n", nominal_freq);
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
+cpufreq_freq_attr_ro(amd_pstate_nominal_freq);
+cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
+
+static struct freq_attr *amd_pstate_attr[] = {
+	&amd_pstate_max_freq,
+	&amd_pstate_nominal_freq,
+	&amd_pstate_lowest_nonlinear_freq,
+	NULL,
+};
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -493,6 +555,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
+	.attr           = amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.25.1

