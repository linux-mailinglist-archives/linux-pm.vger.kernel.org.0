Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A58477C7A9
	for <lists+linux-pm@lfdr.de>; Tue, 15 Aug 2023 08:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjHOGSZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Aug 2023 02:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjHOGRe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2023 02:17:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37A81730;
        Mon, 14 Aug 2023 23:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEjduneP/OK1qJ/VWTOeIXY2tJUmChSJviS22kQorAxAlnenPHSon+zTh0TDx7a35FzG5RQ2SphQY+gui/0EtMmONxyUyqDSTS5cr8d5fwuOUy6V/l+B2SqzzGw1awzOgWwZ+TzsDtVMgqstHDe1OLIP848kuMRfS123/ozQJXzlAXiLpRjioS4OjhLHYAdTDIK2OuvQbobJ+0Fq1XY9KmqRU332TDLiCJ+b53PvUp8uy/JoqU3VCIpvc7iYhGZq48e5a1zl+Vfjn+hy/+oNIJjBgwc/xBkkU1qBZAIqWf6hrTohhlPSIatUDmXJFtqW4baS130KnxAY7N24jt6JlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+RQepWEpY82uXKfwKZoS1l72EUVb6pDIlmqk6YuNWs=;
 b=Gboqa3ZvBuOLU7PAmq7ecLazurmbO6YB6+5WxttizlDVa3sww51nIoznUBz3VYKS7utgiWYDf3BzD108tzsBL+xFtvGgxPlRNBvDVvhrQ9YqZYpjTGR9Wj8QoVa2NISYMNiAZs020BNMzHbU9XcUL38IydlHeK31Y41wEOX9xgcPBgLrhCtknCDY+vhNSD7A8qZX7seevu0ptmxU0Xvv67TE+6+cQRnPhEHebUU+SF1DOLyqxH2O4Ciru/Ed8mEtaNffz839fNWR5KlY8X/9TYY+ACYuyrJrZoDyYqtIsWtfjbtpThzPfLcf9Cr7TqSdxV0JYDtr5u02hPLACSQJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+RQepWEpY82uXKfwKZoS1l72EUVb6pDIlmqk6YuNWs=;
 b=eJVdBTNvK+7Lz8uU6HNitsYGey7bgk96Qq65tmCGQtMf4GdFLDnR1A2DWfamcqqOgDmvTKjbRLfCnqizOteOH8aehVmq8RI70BmRowWe+Umw6DwJTzfcW8JvN9ZAJAlVlTNI1pSUj1Kg7fZZW9YXGbHs+UJkn7DTCtVT5dk1jaI=
Received: from MWH0EPF00056D0D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:6) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:17:23 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2a01:111:f403:f807::1) by MWH0EPF00056D0D.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.11 via Frontend
 Transport; Tue, 15 Aug 2023 06:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 06:17:22 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 01:17:17 -0500
From:   Meng Li <li.meng@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Nathan Fontenot" <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>
Subject: [PATCH V2 5/7] cpufreq: amd-pstate: Update AMD Pstate Preferred Core ranking dynamically
Date:   Tue, 15 Aug 2023 14:15:44 +0800
Message-ID: <20230815061546.3556083-6-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815061546.3556083-1-li.meng@amd.com>
References: <20230815061546.3556083-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 4900fa3d-4163-4e40-cb75-08db9d5749c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibkb5pf0D2SPJVGUBys4+mgkw0cXtla5uPmyi9hzhV3kYqvpULKb+3/ulFywAYBXY4D+8S/yq/IU7PvET+Ap71D6WPVF0H8EDkvsPnFQxYuRA2plZOBlUx0uFoh8TDwKKafM0abSlWxJyWa5HLqcNGFRszfSwMkb4ddGMvdMBfMRz7w6NO2i+NCkXgPly8Inmzibt8XN74eLrsMakd3yQQOz2nX1IgMhaS1riCI9PVlQDZBlTzb3Vwt0ppAbqm1o3ICpYZ1X147DqyUXZQm7cb/+diaX0DtJSPE/4BjFR9YCj/gItTk6W+ChmPvfPgq5HxipCWTu+bjUlDy+UVKynavmU84CB0ppb2XFsUGTx2Lmh543+Yo29iJzG0+BZMJLsK1fBLuwzeZvrZJMAzNmv6Z6rX6HrdRtC+keJXqMpgYDuIoVumbt8IyLaAKCyIV9mLTQOtOkqgI/jbR31ll2X7JkPV1Z9gCtkgHh+z49exQPkyWz24Eey5WcrK8SyRol3yelnrCp35LcVxf6QQfsxb5HRTjDgbsSHWacwzFswjgvnHDqhaMlm8vB7EMPsLy6Bkit8jChvYt0P90uGyBSxIkARm40c1RHTCZeb/t1oUBdz47UgmEVlTaRLAhGwYKEAs1PzGk4x5mbMxcocpcAS68RKDZahZHXlHIP6EoSAgWZ2m3Ng1DZd9veM3yMwDiZNomtYH6Hc1i0ps01MzfTPWV4WOROYE74w0OXP7KY3pErTumZmXbVPaN8ozyZUdRNBSi55tUSBVeWzPonEfkvpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(82310400008)(186006)(1800799006)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(82740400003)(356005)(81166007)(36756003)(86362001)(40460700003)(15650500001)(16526019)(478600001)(6666004)(2906002)(7696005)(1076003)(2616005)(26005)(70206006)(426003)(336012)(83380400001)(316002)(54906003)(41300700001)(110136005)(70586007)(6636002)(5660300002)(8676002)(8936002)(4326008)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:17:22.6934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4900fa3d-4163-4e40-cb75-08db9d5749c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Preferred core rankings can be changed dynamically by the
platform based on the workload and platform conditions and
accounting for thermals and aging.
When this occurs, cpu priority need to be set.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d02305675f66..8a8e4ecb1b5c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -315,6 +315,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
+	WRITE_ONCE(cpudata->prefcore_highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
 
 	return 0;
 }
@@ -336,6 +337,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->prefcore_highest_perf, cppc_perf.highest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -744,6 +746,34 @@ static void amd_pstate_init_prefcore(void)
 	schedule_work(&sched_prefcore_work);
 }
 
+static void amd_pstate_update_highest_perf(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+	struct amd_cpudata *cpudata;
+	u32 prev_high = 0, cur_high = 0;
+	u64 highest_perf;
+	int ret;
+
+	if (!prefcore)
+		return;
+
+	ret = amd_pstate_get_highest_perf(cpu, &highest_perf);
+	if (ret)
+		return;
+
+	policy = cpufreq_cpu_get(cpu);
+	cpudata = policy->driver_data;
+	cur_high = highest_perf;
+	prev_high = READ_ONCE(cpudata->prefcore_highest_perf);
+
+	if (prev_high != cur_high) {
+		WRITE_ONCE(cpudata->prefcore_highest_perf, cur_high);
+		sched_set_itmt_core_prio(cur_high, cpu);
+	}
+
+	cpufreq_cpu_put(policy);
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -1468,6 +1498,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
@@ -1482,6 +1513,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
+	.update_highest_perf	= amd_pstate_update_highest_perf,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..fa86bc953d3e 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -70,6 +70,7 @@ struct amd_cpudata {
 	u32	nominal_perf;
 	u32	lowest_nonlinear_perf;
 	u32	lowest_perf;
+	u32     prefcore_highest_perf;
 
 	u32	max_freq;
 	u32	min_freq;
-- 
2.34.1

