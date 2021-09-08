Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257FA403C36
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352137AbhIHPDV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:03:21 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:37985
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352139AbhIHPDJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:03:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKTQFGWbhaVlulHBnrpu9j/5VvkWptFFUVvfr+VjGFRNbZSKxaXUr9dMMKVhw8QkRJyfRrakmPhOkhKPaNhl5EKYo7YofaHdjVk5LuU5ZqkjnDocbWWanjlma6DWhRy4AV241uU3W20ZPexJ6vHPWvwn+g2O7CCle3JTGda0G9ZTljQKKkqI+2R9uhGyWfYYlWGSv6zx9kUXulsy6zRa+lhQhNZ2jHEyrLI59fCeIVEF4AqE7IRKSRrGNZqGz+/hyC68GfliBHelR6FHB9LHeDO441Q1G9Z+eqVIW4UHnH766tiOPazzEc0B1zbvOqQRBrd5wcs951t71YR5fteJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eyD/zavu25QEKfhRVgmr/pwsTa9qz6QM+kgPqzFP2wY=;
 b=HJCS6o/tmkSO48sYFkLhtw3Vl0CN+qhDCH4jpLhAiXcsCeaHu2crZ5UdrkryJBI+57KjYNMnG/AJqwKJHO3L5PJBQihuR12PRmmL01Pgz0pQSBu/1EdfyhUSf06Jmtp1n/Nlrl2KhKzx6QXy9ct93vLjEPZNW3LO7EwFSnaB9/AzqYkAqmpL8c11C9jVzK4yXR9xNpgmXfxNtoSIr9R4W7cmY5oafYykEr0f/wSEmcfxjTpRAeVXiZYOawgcf+F9dYbWEp/P5jWxImoe91hD2S3oJWdGUG1utB26dXBnWz00F2OG1VEMV36nm4Qf0F0sMz/0onG5dveJ/Af6OqT6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyD/zavu25QEKfhRVgmr/pwsTa9qz6QM+kgPqzFP2wY=;
 b=KrEr8i5ogKKqSk4jPkklEytf3PemR2SQSohSaVrkVjwhDz1csnr1vzxSOyDnTwSb4J/FWgijxOpHaFzujAxW6BpzooEUDwFOR8QUqZeTR6I/ZsOm8E/wdHLAu/8bD7n/TqY7l49GwK1mivpXOfiJE5hCYQdy4cULKOmEWeFTMHI=
Received: from MWHPR22CA0035.namprd22.prod.outlook.com (2603:10b6:300:69::21)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 15:01:55 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::d6) by MWHPR22CA0035.outlook.office365.com
 (2603:10b6:300:69::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:54 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:42 -0500
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
Subject: [PATCH 15/19] cpupower: add amd-pstate sysfs entries into libcpufreq
Date:   Wed, 8 Sep 2021 22:59:57 +0800
Message-ID: <20210908150001.3702552-16-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6a78a0b-f777-418f-994e-08d972d998fc
X-MS-TrafficTypeDiagnostic: BN9PR12MB5209:
X-Microsoft-Antispam-PRVS: <BN9PR12MB520975315213EC072889A0D6ECD49@BN9PR12MB5209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3urddICapwYmMzsA85Lf7yfMbOStByuSw9da1DAs5Tv+zdg8XzGpVHsdycEHRoFTYYhsg3e3ugFTSeTsc3LrTqP9Q62lBmZ4oc5eXSwbfVLtxwxffsI4He6rq+oxFwheW9ERYsxoF8usssIGOwzuLq1gGkv/DLC+8RJJf1chS/5BrO4vdD1NSLKigCrWVuvaTbgiEOs2uK1LqxAPtfl32cuXuj0J687k3hN7MP3FLM6pGsC/pieOVQlLK8GWKbozKUb4WNRGvJfna9QOYeZHNe6eOXxQkPxSxja2oeGZq0bOUzqEGoIy6qr6VQ8wEmRcdsmNviW8rBHq8UudhhrbCh+NIbqjjWpQC0TZpqSPkxBTAkmbrPjx+IwuFiDa9OCkRIRfdWagU0kEKCyejuIwJ1EmlXAEZOpoYmOkouwmK2+MvShYMtMdMT/oguYmlez+lXz/H8DWyekM6x5Xe04Q/XCN5MCR6f7W4BzAylk8+7wk9CZ54qodNhuf2oY28S8Wi6OO8DTKJGKwRcxdKco5JBooxW2oCL3JcNbPYzSz2FHeghvZLk/VjamQzujr2Q5LAaiYV/2eC9TpydWxgqyRW2WHBWktF3TmCwntyR6VvjG2t6ElMR7zcosFaiZxV1fvvYARHmmggxiFF8dw0gv+TLeuFm2m8UDseTviQsLpKUm1oLV7T8anf/HCRERt9n7yBqoh7ehJ1ikrmixuWzTl6B7Czif7bQPo3yzHAZGYM/A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(46966006)(54906003)(110136005)(83380400001)(82740400003)(316002)(86362001)(2906002)(4326008)(36860700001)(82310400003)(36756003)(186003)(2616005)(336012)(1076003)(70206006)(70586007)(8936002)(426003)(26005)(16526019)(8676002)(6666004)(47076005)(81166007)(478600001)(356005)(7696005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:54.8077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a78a0b-f777-418f-994e-08d972d998fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These amd-pstate sysfs entries will be used on cpupower for amd-pstate
kernel module.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/lib/cpufreq.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index c3b56db8b921..3f92ddadaad2 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -69,6 +69,14 @@ enum cpufreq_value {
 	SCALING_MIN_FREQ,
 	SCALING_MAX_FREQ,
 	STATS_NUM_TRANSITIONS,
+	AMD_PSTATE_HIGHEST_PERF,
+	AMD_PSTATE_NOMINAL_PERF,
+	AMD_PSTATE_LOWEST_NONLINEAR_PERF,
+	AMD_PSTATE_LOWEST_PERF,
+	AMD_PSTATE_MAX_FREQ,
+	AMD_PSTATE_NOMINAL_FREQ,
+	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
+	AMD_PSTATE_MIN_FREQ,
 	MAX_CPUFREQ_VALUE_READ_FILES
 };
 
@@ -80,7 +88,15 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
 	[SCALING_CUR_FREQ] = "scaling_cur_freq",
 	[SCALING_MIN_FREQ] = "scaling_min_freq",
 	[SCALING_MAX_FREQ] = "scaling_max_freq",
-	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
+	[STATS_NUM_TRANSITIONS] = "stats/total_trans",
+	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
+	[AMD_PSTATE_NOMINAL_PERF] = "amd_pstate_nominal_perf",
+	[AMD_PSTATE_LOWEST_NONLINEAR_PERF] = "amd_pstate_lowest_nonlinear_perf",
+	[AMD_PSTATE_LOWEST_PERF] = "amd_pstate_lowest_perf",
+	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
+	[AMD_PSTATE_NOMINAL_FREQ] = "amd_pstate_nominal_freq",
+	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
+	[AMD_PSTATE_MIN_FREQ] = "amd_pstate_min_freq"
 };
 
 
-- 
2.25.1

