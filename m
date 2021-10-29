Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43B643FCF8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhJ2NGw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:06:52 -0400
Received: from mail-dm3nam07on2080.outbound.protection.outlook.com ([40.107.95.80]:3356
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231755AbhJ2NGi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWmfxTdnBEROuUFid5NQ8vbLBvBWR/tbNYuf2Lqha8zSe6dVd28wW/w2JMy024gExNdaS95fL256EKWQBaZYyHtV7AbyPrmxm7ucN3X1pjgUrhWPSrbjVnY8YbZqorDAd99eslC0I6WWeXNMWJSfi3tGUSxY66G6pTQphxFC51Ybm3M5xBatM+hw3S4xQ/G/sZmWd2Eq+XZofdlyNTT3cxn4gsGrjQO0vDVoyv8GC2ERiPOVeZa4QN6w4EZlJeMVNjyASaW//EITOrqnuytu7Ex1peIL7u5TH/Sj7GLwWULFcXOdvFW/kZj/OLSfmtJ9T6Trx3q7CT3ixpUijvp+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK1Tx2TrB5J0aDp4pfCIUh4gDNku1ZU1OSw53PsLKkg=;
 b=Hrneai5qE2jhVQl6Z1PXDH04q21Rp/LN106AaLhut2Mj2eSwNutw3QZoh4X0yRNUXo8dq21h7WujUDJKeMItjVd1IAn3SXbp3xF/4B7Gczb4XKKNfdBVUzJkuG1g4mkXJZNiMXY8+0TaSWUcuTzpY2W7uvOTOU+9w49HuX1xKilkj9dJM71xazHoSAVtP0gUCQpTdt6YBkPpsScbOsCy7I0J/2yCrTNbkRfvRgBN5u6Y0u6s4Is0rb64/zgQyHoM3Bi0AqzBDp0Et6KOc8d/ukpJh7vOHGcVob7/eBLzsyOyYCUZ+pgYBTMlLWygFal829lCQj0Fevq5x+j6AbXxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK1Tx2TrB5J0aDp4pfCIUh4gDNku1ZU1OSw53PsLKkg=;
 b=D9CZt5zEWuVXMGpl4oClV+fg03l4gpoPu2eDjP0oz5coh6QhkoTcOWJG3kmbPMo4lpiLyuRAm0EVKI8i6iMj9OKKaBQhhNZiXszg+ejrfzTIubNi/J9y4dKNtZr2XtVCU9gbnXkF5YxVikzr8ZiiIWNIv0nsGLp0Gqq90TPsxGQ=
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by DM6PR12MB3290.namprd12.prod.outlook.com (2603:10b6:5:189::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 13:04:06 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::a5) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:06 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:00 -0500
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
Subject: [PATCH v3 10/21] cpufreq: amd: add boost mode support for amd-pstate
Date:   Fri, 29 Oct 2021 21:02:30 +0800
Message-ID: <20211029130241.1984459-11-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec9a5427-6bc8-4169-05c1-08d99adc96c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3290:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3290D439CF9DF429B3F4CB3CEC879@DM6PR12MB3290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JSEzHENxd5KgaDe2p8XXufTGvinRtfKqTKoX0KG8IK0GkpM1E+9CW80kr1UuszS5q7mbo9No5GQQoyHrV71hb4zzE4MbzyVO6W3Hlo2OPyNkN50N2dKzasXUazvii3ypFpNeUw5UoY+J6USGjE/RjtMR+be4gKwxeAO2wFaZfKT4BXQBYf+5ouRmewTzoiNd3wZThIdKhGEQVGms+OTyKPbupbZlRX6r0uSlA+cGo5L689DlDA0FMbVPIJ/vq6QsmRD0YU3YcFKBOQenTWD7y3up1VIco24CawRFTKx5gOBoujD2x4AEtx57i+CqVdo+QeWt0DSvpNJFV/i2r+p0tRGnieGMAmwYY0CIH1CXeg549l7sQeQnsGgdY5/g90cG3Orkpqm9VmlcQFdZru7blM3i/0YQJan+tWZmAQGmuyjB3jvj0l+XO4qeeWZ2o2YUgMaw5Xin+SK+9jv5phRZ2b0oVz3zRYZ3IUkz6RHOTKgPiybbwtlfj9iF9ii3IyG1magU9zcSsskh5jofV2PJ/OC0Fab2oQ2RqIfJtiFZJhE9twrEhqMEX9t2ssEJdUnd0ha6LKlTzg0bigmjW46iebNBJWP5740UyJ4tBWm8KJ1xX/AzutaNcLjORYrZd46syBD8kQaOHlFp9DcYk9ue1TQ1ZukGSTOA68rJYai09u2IzDRRZ10mG35dDNUffzi2COgBY+TJkxSgjwr8FZda1md9seXic5r11OeSu7vTjg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7416002)(336012)(2616005)(83380400001)(8676002)(26005)(5660300002)(36860700001)(47076005)(186003)(16526019)(86362001)(82310400003)(426003)(54906003)(4326008)(508600001)(1076003)(81166007)(36756003)(2906002)(110136005)(70586007)(356005)(6666004)(316002)(70206006)(8936002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:06.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9a5427-6bc8-4169-05c1-08d99adc96c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3290
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
index 6037590e82a6..9af27ac1f818 100644
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
@@ -349,6 +351,45 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
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
@@ -419,6 +460,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
+	amd_pstate_boost_init(cpudata);
+
 	return 0;
 
 	freq_qos_remove_request(&cpudata->req[1]);
@@ -448,6 +491,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.target		= amd_pstate_target,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
 };
 
-- 
2.25.1

