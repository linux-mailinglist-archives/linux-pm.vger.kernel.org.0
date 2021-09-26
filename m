Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3D4187BB
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhIZJIr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:47 -0400
Received: from mail-sn1anam02on2083.outbound.protection.outlook.com ([40.107.96.83]:6229
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230257AbhIZJIn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAfXJxyxzWO8UxohoEAxlyNvgoEEBM0o9dgAxVnw3vSILZsY5DhhMB6Bx2QLipzTULxcMNiKkwtwV5AGGQ/2/o8gNjeeAT4g1T6DdF84TsDvpHrfL5V3127KEh9Z8ANjUAWU6A/75U/fZPn+04j9bvl7ygswfrU0K+qH9Bt85o3T977K37HgfUIbH9SOLvhFx1ZYS3NHN9AaZQZ5oRh6irTMemumpkUxkzSUrbLlDulkAP7+u2nAqaHEWOWpHo8HuH2dzdlrzGBI/ctQKqAEwmULNW3aa077W1teAh0f/aOGlueLqj0/xjq2g2Kt4X+NNc/sJby5ayjJ+42bmFOyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YMZHc7iSZjyWM5YCdriAgAHfga8jGAXwZD1fyxyWLPs=;
 b=QJ60LA+f7tTSHGHo0UhveO3cqs69gYivve23qUFkbe/0KRAYJBKmx+uglEDCp/TAwp2tQYNat4ZeBAmsB/j3Lkl7oc5EO/WQVGHSk/+QGCtftz+NJcwZbW26wzthDmJgb4I4YAQDmtBJ8hhqBTvxyb1TFHSqqqyOFsjXWrgyF11Hk5aMy5A/gIw9fnFGMoXeiBBWa9QryK8Yi4DasxODaC6G3ZfQLALLZrHi2tekjfElyTgPFIJ9Wzjd06O6w33Ntb4wE4OyniAHV2ecCz4Vv8atgCovVWokUl5ohqtoEpKB5+L5D/4dupApGE+x56eMhzkOohSltyYw8viW/YO6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMZHc7iSZjyWM5YCdriAgAHfga8jGAXwZD1fyxyWLPs=;
 b=TpA9g7hoEA5WAgynZhoWUlnylU84b527+iUSd1RLZ1d/BPaYsBsPbyGynrK0tPUwMyU5uqadXuN1VPChSs4uQuixmvqAV5tlvSycYP8GgtrDboQZGFCVm2oVux7d5zyuJt2+ykw7jjn6DY/2g6NGQvITTCC7WV5pHakINB0cXhY=
Received: from MWHPR12CA0038.namprd12.prod.outlook.com (2603:10b6:301:2::24)
 by DM6PR12MB3228.namprd12.prod.outlook.com (2603:10b6:5:18c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Sun, 26 Sep
 2021 09:07:04 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::cd) by MWHPR12CA0038.outlook.office365.com
 (2603:10b6:301:2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:03 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:59 -0500
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
Subject: [PATCH v2 11/21] cpufreq: amd: add amd-pstate frequencies attributes
Date:   Sun, 26 Sep 2021 17:05:55 +0800
Message-ID: <20210926090605.3556134-12-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f4fb5761-910f-436b-694c-08d980cd020f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3228:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3228A0AC6838B999B46FD108ECA69@DM6PR12MB3228.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atGL9/44Xp9lLl8l/YdgUb9+uJlYEin6YpgSzarYeww/w8pi553C6USq40fCUJslKNx9OMIpUd6GO9W8tgpVq0RwBl1xjwEXC1ysdKZIVhy1RsjYXipWlkD7lcmij7UZpGKBKAipX6NuEsu3nFVKLGe6DynYVOyVrGq1hi1ZvT6hRu/wcZzgLe2AaXvoatUUXM+EotC1jJYhekr2B3pVV4xeHGEkCGK9NY0E4kdNRzM3329bDEqsVMhPPTT8DJ8LFlL3O/3t5ygsmdiOSYHicCgLwkMtomMVQjVLrWBxSoNtrMY9jWLJx4ukaklrK+ZIxMYsMbMxmFFcFGIu8CKeyKhV7SFcKgCOLOb4ziVa0hO+NtCGjDJ5m+xmUGjhNIJCckYa8a5Ym54lX1CNZfGEEDLEclA5VDSJ0bhX3kQVNBZvGT8zRxRnv1SdXPSS04G7wh/6Pk4uE4h7odqZ4G8X6Ti3lmN96eswv+/AbWViaGH3e5MsuDBg8EX9A4RYC01zXIeGZjf7ohmx6WVi0ZrRuopUP//OII985yrB31K+JVZghPV2ET0pOgG87pcVQX+pAJWrHZDPtWIkAeokrGoJvTt0WWFC07zVgRwRPo4ZCUF0MrAG3BGInujaL8A2ICPn6osstvaXjBVom5qxg1RWa8I+8ewXhMZvAkCmk5YYlIDpFjvNZ4tSFdll9vc6oDJOOAleLzOSVUz3oE7P6F6OcjzK78yi2jEY8O/BIIDqt9E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(2906002)(110136005)(316002)(83380400001)(1076003)(47076005)(81166007)(86362001)(82310400003)(36860700001)(356005)(26005)(36756003)(16526019)(186003)(8676002)(6666004)(70586007)(70206006)(5660300002)(7696005)(2616005)(508600001)(426003)(336012)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:03.9242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fb5761-910f-436b-694c-08d980cd020f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3228
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce sysfs attributes to get the different level processor
frequencies.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 71 +++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 74f896232d5a..16fed25c3400 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -517,16 +517,85 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static ssize_t show_is_amd_pstate_enabled(struct cpufreq_policy *policy,
+/* Sysfs attributes */
+
+static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
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
+static ssize_t
+show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy, char *buf)
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
+static ssize_t show_amd_pstate_min_freq(struct cpufreq_policy *policy, char *buf)
+{
+	int min_freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	min_freq = amd_get_min_freq(cpudata);
+	if (min_freq < 0)
+		return min_freq;
+
+	return sprintf(&buf[0], "%u\n", min_freq);
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

