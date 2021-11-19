Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A63456D86
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhKSKfo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:44 -0500
Received: from mail-co1nam11on2088.outbound.protection.outlook.com ([40.107.220.88]:11873
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234831AbhKSKfk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m19xUTZRA0Wd2i2o1+IcLNHzH1446PvA7KOA4wN2cYSy1X+Wrv9MduU2AW2I+EBBy/D6bWM17kVqtdDY+QrcrVI/FLsfS3ja+ekxT07vaG0otE/cfHztVR+0Qy9ZnCuTDnZZiX0zUPYWtCs194mMCi+RTgyR/VTdwz+r9iPWzleOWV5bGqEdimSV3HJ0aJGzEaQcrz7kVcbgmolmC4qXJevrYvpnAQ6Ig0HaG3w6GtJiiE0ONbHIntXh3GIRBChHN2qrshi6gYln/m/QwVe95ClPvmTM71Xu0ambfoGUOv0xFtutm0cZc7SmK5TESuJeBauUEI6PdvDS1FFYW9jj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWm8p/+y2/85Pgb00jucUNqc8KHHSDgBWMHijhO454c=;
 b=b34XpEn3mEU4Hcfjr4ApZ+AG/Cskqujc6fZmFNUaLtA83q9/IaEaD1O5a4lGRlbruHj+EBEy8EKLz0pEJW9/g+PoFth5RjnXWBpJGbMxpDA0P/d/fV9FothwqW2XqyLPmZnDnWdodyOct27+jYQVLQF5uIjFiWWBKCEYYpYlTuamdeLM9j7j7oL3Tzek0UDenVFXpNVhZIkJ2raXnMH0Q17IqWDzh+3kHliuP6DSxJ3hQ1UAFnbWAzksNF1jHvTGffZvdZvaSnzVwYmdturXOyy5s9th0L5JYVrW2esKkFhDy2E3qxrWZgwMnFAyXqwJZT3Ha82Irjmz9zXxAAb12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWm8p/+y2/85Pgb00jucUNqc8KHHSDgBWMHijhO454c=;
 b=uBfCLNctQwpVfVfhThNMM1OU4vWBZqfbgNgdKT9i0fPAtqieQbKgZ9ZyqCyn6W3XhngmV52C+4xfqUlFlRpepvoEccOt6Jk3h+mVNFJDglxEWYPZxMaMZvlDIszIYWoqqHuCbu/QzYEtvlkSec74P6I5BE06hijfWu0nXDd4OLA=
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 10:32:35 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::68) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:35 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:30 -0600
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
Subject: [PATCH v4 12/22] cpufreq: amd: add amd-pstate performance attributes
Date:   Fri, 19 Nov 2021 18:30:52 +0800
Message-ID: <20211119103102.88124-13-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4937189e-f1b7-4db4-ea06-08d9ab47e712
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:
X-Microsoft-Antispam-PRVS: <BN9PR12MB536864C67067D8509A743A11EC9C9@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdI0tzxtpTIbcpS9iqQeHdF9sq76iSJDuBR8BuOLB0YLSJaInSIXLDjl5K9OKusOv1dyp4bI0FrsFyHUe8qGxVqyB0joAFKo4Z6cqy9zY9o2nuMsiUeUnZRq34Cs52z6IMOR3z7HHagEyH7gltAQhXck7X/9tnPddKzHe8z4ufNcBLFQ4Oj6r5pAEkORFCzxKBBFMlxCzTZIUpaEotpSaSgRME6Z80+QvO9ir/ZMKGVCZlxXN/dYdv3gyqn4Z7G6clV/5vx2T0T9BT3oVif94MqubRYlUvlDwAfEwupcJ0DC9bKzBngx+dlNyDBB3YQ1B5IlBbHccqEBY3/PHPkks/tYzsbttxqLGSp7tfHUc8bKbUVFAwCFv7kL54TxF2wHSpBn5Sf+EYB9znEvCuFsPNJNRLWH/b4SQ0UchKwOaUzJPsVOy6E5GuazKGAFj/Uuq5GSQHf5TLNh4wc8eoFCiy9EIgUri8xXx8RgoTFmMcWMV/Zwz2YNyE/7wR5b15bkuQYeYXNvkUBLzybpP+Vey5jZW8cgN3qbPozOlkY0s87Oguda1SkexAg6X+H51o5EtIE7yiziXD6wS0+ZySC+F6ZyGR0bIDkDJxfBEExo8OHkteeR3cU0NHgjhfGdmQ670XRl82aiDT7YzDTluPJny2nIzyYNA+3ynbvkimAtvERw5OY9gtSQqY3kSngGVWf9xTFcpomyDDqeSkN+8yofwjtTFMKFJwQyj0ceE1OGCGU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7696005)(8936002)(82310400003)(508600001)(7416002)(16526019)(26005)(8676002)(4326008)(36756003)(54906003)(110136005)(316002)(5660300002)(2616005)(81166007)(83380400001)(426003)(70586007)(1076003)(356005)(2906002)(6666004)(86362001)(36860700001)(336012)(47076005)(70206006)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:35.6550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4937189e-f1b7-4db4-ea06-08d9ab47e712
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce sysfs attributes to get the different level amd-pstate
performances.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 09c5fd8bd9da..458313cdba93 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -512,12 +512,29 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	return sprintf(&buf[0], "%u\n", freq);
 }
 
+/* In some of ASICs, the highest_perf is not the one in the _CPC table, so we
+ * need to expose it to sysfs.
+ */
+static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
+					    char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->highest_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
+cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
+	&amd_pstate_highest_perf,
 	NULL,
 };
 
-- 
2.25.1

