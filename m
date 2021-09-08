Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D248403C39
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352171AbhIHPDX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:03:23 -0400
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:32993
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352150AbhIHPDN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIFSxqoBsjqZnPxb6rknURdcjhN9ptm9yMIn91tLeR2YI5QYIvaUTQsPe9D80KySw8VtO5cCtEqmA8hERZvJHeqtm767binJG1wACzNy55o0NBKYSFYmJwebCSLzjp9zXbG8DB2DMi8Qr0FdGdKxWVI0YCWim4Dqh0nFKdv249o/9vx/YoAFgQarS1BRvK6TrxoBKtc+dA3PtddbuAQ+ufHFoYKyKFFFHWhJ8/4zlSx9k2Vr3AU5cN239SSBe4zpM9nuX6sGdQIHgauhN7GcvSBZTXhjGp33f/eIjdMtuRB6PYfQzaY2U0zbjYlxCZCvybdH/O8r5osQAjv5Jh2g7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=81l4DI6oBLJh8DFDJD0bnFficA68wYX8LYqPE4J60W8=;
 b=AD3BE9nYyKHJ8ZNbkr9KFr0QgUuMmYprHQSHdZCHY8DyWs5yWq53XETYk8OtMXVGVuclGtAC0GXpJB/cF+P2BTXz9kcCeV26xksdrFvadYzG3LUfD7OrDkCWoUZPHd2f03wlkNS9EDAwo+gx+ah/Aff1gdDs4xJ4Ur34nfX/UOEhB18vCD3mC0V4IVEpiGQR3sFNOu5UjkhBb3AxHk3WyyfyGlYBHabYAeIWv/CtUaHvxeJSxTk5Z4ykch1kNcePZHXt3IU5X4guUcQBUbJ8F3iNgs3dqoPEF9VykWpIz5DJO8bdh1CzplT03ecvKggNmzPZh6Vmu7/pY2RySo3AuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81l4DI6oBLJh8DFDJD0bnFficA68wYX8LYqPE4J60W8=;
 b=5FO3hrAIjQjGo2mqT6lfomEsRAX8WrQBYlCS/7EEVpDCebjSFzG23n9BoYVltfmcQWAnTmo82uCIVLzS4sy6r8m/5vQNz1UEj8AgIlGiJ1jzTFlpEWkl0Vfkufj68oY5EvLSbOLBI/dXJEMsCdAAkun9D76NVTlsA1LeFIk8Tm0=
Received: from MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29)
 by BL0PR12MB4754.namprd12.prod.outlook.com (2603:10b6:208:8e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 15:02:03 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::8d) by MW4PR04CA0234.outlook.office365.com
 (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:02:03 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:50 -0500
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
Subject: [PATCH 17/19] cpupower: add amd-pstate get data function to query the info
Date:   Wed, 8 Sep 2021 22:59:59 +0800
Message-ID: <20210908150001.3702552-18-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 47733560-7453-4dda-79d2-08d972d99de1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4754:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47544C2C8CE1B7B8C59A6BABECD49@BL0PR12MB4754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRdqJaEks2HQ0O26Ttkads+ODJPmtNz/Xz4oATz6I6MniZTkg8d/YMI9qZM4PF9r5fSG16KRH8UBE05kNjjChkckLM8PmZ/062Jdn3mpb9a3LM4jwoKrbJF/7y24qZkXlGkHX8J34MU62X5tKVvHVIDIj8r2ln2s0heshkSSuG02+w4/IYP5oQhsCvm35gHEB/SWPIL/DQvmhfWB5tV0BdOkfvzbJY7ZdzLhT2fUm9RGx0JChvOGdrNdJ31hmTnf9lF4X5ArBES/M26ZgtQvFpE2L/LOsS7KS3VZySYbhKZptS98NEr4LX5OCwRqkDeRjLdNZ1wl6Mgu1NZpS8nUoonUxzlMHiS//3OOUOOG+urPup6iw6xqSYnkzrJgvgzDaC7d1Wx/2tK4f1jEQ+VjhQclwwmsYAJ5tPja/zUD2tDyQfzO1rL7c7hiT8fG5nOSdQ+zGjLliDC+af78+Aw0BQi38hGQXEKSGJAxgReKoDJ8yWJn7voN98YPNcDlSPM/5/ImMtiFUP+47OJYDknRU5EM4jMzB2o/8p65y276IZ3sy8QBBRIHvFCnkc6J678HqqwU9tXfTK4HV6JqAqeHaBw6kTAvNLBMPaX44mQt5vGut8AHRlsPuQdlQL1gkVcWQJWEX9oEUMU1I9pIFuwqPvZMWZ3QQVoiVgXenVu9h6rW6cg+ntGvfUZsbMZVPQAnAe/2QrzFr6dXbxqH1+iGXnP2mES/77yO4RtjpVbSKbY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(4326008)(110136005)(316002)(70206006)(86362001)(336012)(83380400001)(36756003)(47076005)(81166007)(82740400003)(356005)(70586007)(2906002)(54906003)(426003)(5660300002)(8936002)(186003)(26005)(36860700001)(82310400003)(2616005)(1076003)(478600001)(7696005)(16526019)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:02:03.0286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47733560-7453-4dda-79d2-08d972d99de1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4754
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Frequency-info needs an interface to query the current amd-pstate data.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/lib/cpufreq.c |  6 ++++++
 tools/power/cpupower/lib/cpufreq.h | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 37da87bdcfb1..1443080868da 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -810,3 +810,9 @@ int amd_pstate_boost_enabled(unsigned int cpu)
 
 	return cpuinfo_max == amd_pstate_max ? 1 : 0;
 }
+
+unsigned amd_pstate_get_data(unsigned int cpu, enum amd_pstate_param param)
+{
+	return sysfs_cpufreq_get_one_value(cpu,
+					   param + AMD_PSTATE_HIGHEST_PERF);
+}
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index d54d02a7a4f4..954e72704fc0 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -206,6 +206,19 @@ int cpufreq_set_frequency(unsigned int cpu,
 int amd_pstate_boost_support(unsigned int cpu);
 int amd_pstate_boost_enabled(unsigned int cpu);
 
+enum amd_pstate_param {
+	HIGHEST_PERF,
+	NOMINAL_PERF,
+	LOWEST_NONLINEAR_PERF,
+	LOWEST_PERF,
+	MAX_FREQ,
+	NOMINAL_FREQ,
+	LOWEST_NONLINEAR_FREQ,
+	MIN_FREQ,
+};
+
+unsigned amd_pstate_get_data(unsigned int cpu, enum amd_pstate_param param);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.25.1

