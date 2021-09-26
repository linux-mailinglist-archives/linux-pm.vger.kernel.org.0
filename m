Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1221B4187CB
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhIZJJ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:09:26 -0400
Received: from mail-dm3nam07on2060.outbound.protection.outlook.com ([40.107.95.60]:18144
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231338AbhIZJJO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:09:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOsB44y4dlT8jYs46IudKBU3vSTtBOSt2iYfK/I8+aM/fkONcOu23A7Wfl74aYG6Ev9+/bAqYb9pVB2+spjlPupd+FI1NNXNHxC7c3UQfVFfR6WMYVTaqCJt9jkYrEeNZ4aHuwgeaEVuu9Uxl/AJ6czIoW/yQugD7011FvMYVKln7U4BWWYWsoBU5D6tnbusYBf45Oqj2FbEvyPMbssdmsXqQlhmwkcpGTNftGB02KfKrwfss/7RLsrkCuMNDiSJ2zdXDlpjdRh+2zXEXLKaGF081GaYJuI/b64u2BV0o/tpsb1RrbyGzK/zqWb5JHKTdVFSsrV9HjqAggt8bkh3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=B7HRs1xNArk6gq2g93nxmeApASDnCzNJL7fA6dhPCgU=;
 b=Oi4CBr3AHwhNjEUltvUCdArwHQZSGnSvNsCfbZf1KPTdb133hWX5OEMlo8pc5HrQRzIQkASs2wzjvSkbcuqhxBw89snTLQLwghvzzLz6tKS7RA4QlxxgoPk/+eN0eyhRrOnGY8t/8+66U224ZqM/HiUgqhqTdid+qJu1AZJXEfYTToqVkLxTo4G0inYglEmGXteehoGbgXK0TPCqvyT+OPlMA8x+e5f+B1EpTMoHwOcUwWis/Hk9KzSogJME4lop7Og+L0qnN922mtW0bGeKXGrtRygqCtGH0TOdHgkytG1Avp86K9KUGT0CrOCr9TLRnJ1fp8GXCsaIBvVMIeDHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7HRs1xNArk6gq2g93nxmeApASDnCzNJL7fA6dhPCgU=;
 b=4FiXi+mWDwEiUuuOHtipyGuayEDVDfwHcBbz+Ob3qPvN+HVg+80GN05lfd7SzjpeCCpI5AM0GErCodVjKC1CEk35KxtN0RtlIasDuyPsHXp8odm/MXO1ITlpxanGIeYBD3ZnbQ/MEJ6lu6u8x5hcxaRyMIGYSCx2vm8FEuAq1GQ=
Received: from MWHPR10CA0053.namprd10.prod.outlook.com (2603:10b6:300:2c::15)
 by BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Sun, 26 Sep
 2021 09:07:35 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::34) by MWHPR10CA0053.outlook.office365.com
 (2603:10b6:300:2c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:34 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:07:28 -0500
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
Subject: [PATCH v2 18/21] cpupower: enable boost state support for amd-pstate module
Date:   Sun, 26 Sep 2021 17:06:02 +0800
Message-ID: <20210926090605.3556134-19-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f92ed48e-a2c3-490f-4c06-08d980cd146c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4886:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4886C26555EB3C1013FD3EACECA69@BY5PR12MB4886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQsQzuXXyEtzX8jPSxPmpW1msqnstYtEmKBvHgfYnXTJDW3RXphIf13MGywJI3L+ndtGrj7C5DGPzxBoUUNeBpzD/7nffipeGxljM08vPnofrlvcG7dQSfKkCLBciRv8xzrbO5TMeqZ9NyDgcCET5DEIj4JEYo5KrYYxqVUBLcPAjgM0u9G2Iy06+xR5KRL651nTJwk/5NitZi3F50c9bmVO10KZoH963dWci/JM6V7+gyWR8HAGPAFiNm94j0IThtxJQQ+DA8Dw3j9NvmE4DB5ojxmx+ipNazjcF7jrEgzRjLXLRRR2Nog4aWgXOXOLCcSeG0BPsOGzsPGY5Igl+COPkr6iRqZBQNkDI31hnR+SCAY5XM2wjjUZ0LmPL0DeESUovdN99TZ+0xTIZZ1CoBqTZS8/Gf2xWl8v7ciZzGgbaLTZuWpLLKuHY5hoE89UKIl6ChD7itXorL0zV9F+tlXkRuwjyNFy8Lbw4POtTgU0BeFCc9A+SoLKt9T4230rE/F/wRjKVs+4er8pLceJ8gyI2ouY4nx8G9z7qGV5jh60g2nEes3XSm4ANgEbI7ygn0Ue7K7q9D3LJ/jljmNznydksJkEXpYlNer6AQKm/lw/RrBW+3G/q83BdUGnqNyMwRpi0ss0361+gC1oCSwTirIp9b3/d1ylpHYnWVxlfD/Rcip8Oe8Cl1seDWiAvKeJ2sQXk57hHS6i79j6qwAPZPR6OjdCHWCP10ZYJ9mXp4M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2616005)(86362001)(110136005)(1076003)(316002)(16526019)(6666004)(336012)(26005)(70586007)(508600001)(70206006)(54906003)(186003)(36860700001)(7696005)(36756003)(5660300002)(81166007)(8936002)(356005)(83380400001)(2906002)(4326008)(47076005)(8676002)(82310400003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:34.7309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92ed48e-a2c3-490f-4c06-08d980cd146c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The legacy ACPI hardware P-States function has 3 P-States on ACPI table,
the CPU frequency only can be switched between the 3 P-States. While the
processor supports the boost state, it will have another boost state
that the frequency can be higher than P0 state, and the state can be
decoded by the function of decode_pstates() and read by
amd_pci_get_num_boost_states().

However, the new AMD P-States function is different than legacy ACPI
hardware P-State on AMD processors. That has a finer grain frequency
range between the highest and lowest frequency. And boost frequency is
actually the frequency which is mapped on highest performance ratio. The
similiar previous P0 frequency is mapped on nominal performance ratio.
If the highest performance on the processor is higher than nominal
performance, then we think the current processor supports the boost
state. And it uses amd_pstate_boost_init() to initialize boost for AMD
P-States function.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c     | 18 ++++++++++++++++++
 tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
 tools/power/cpupower/utils/helpers/misc.c    |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index b953277215c0..de68c14574c0 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -184,5 +184,23 @@ static unsigned long amd_pstate_get_data(unsigned int cpu,
 						  MAX_AMD_PSTATE_VALUE_READ_FILES);
 }
 
+void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
+{
+	unsigned long highest_perf, nominal_perf, cpuinfo_min,
+		      cpuinfo_max, amd_pstate_max;
+
+	highest_perf = amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF);
+	nominal_perf = amd_pstate_get_data(cpu, AMD_PSTATE_NOMINAL_PERF);
+
+	*support = highest_perf > nominal_perf ? 1 : 0;
+	if (!(*support))
+		return;
+
+	cpufreq_get_hardware_limits(cpu, &cpuinfo_min, &cpuinfo_max);
+	amd_pstate_max = amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ);
+
+	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
+}
+
 /* AMD P-States Helper Functions ***************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index ae96efac759f..976c142ecfa0 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -139,6 +139,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 
 /* AMD P-States stuff **************************/
 extern unsigned long cpupower_amd_pstate_enabled(void);
+extern void amd_pstate_boost_init(unsigned int cpu,
+				  int *support, int *active);
 
 /* AMD P-States stuff **************************/
 
@@ -176,6 +178,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
 
 static inline unsigned long cpupower_amd_pstate_enabled(void)
 { return 0; }
+static void amd_pstate_boost_init(unsigned int cpu,
+				  int *support, int *active)
+{ return; }
 
 /* cpuid and cpuinfo helpers  **************************/
 
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 39ff154ea9cf..99d1dc8917d0 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -39,6 +39,8 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 			if (ret)
 				return ret;
 		}
+	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
+		amd_pstate_boost_init(cpu, support, active);
 	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
 		*support = *active = 1;
 	return 0;
-- 
2.25.1

