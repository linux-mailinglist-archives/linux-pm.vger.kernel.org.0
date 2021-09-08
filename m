Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567FE403C3A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352177AbhIHPDX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:03:23 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:30292
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352151AbhIHPDN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRp9WlHo8dar0uoV57w1jPYVk+JbMJ4oi1aWHqFcFh8YSOeoLs10KJ1HYs+Z3KO4qeOQK4uIg8KDfStdcIahKmB1n6x3vuw4JHCbJUCf4zdLVlCQh4VJEIaVeF1BLfQqQS7trtNqR8RwApQ7p8GWlOTsTY1m6kMvQFV3G4uw+f9IEjmsgPyWOoPXpEZdqCPdSBRLFV+Og3KgDi+67f2mOJM01OdxQG1ufVQut4XEw6MaI8XyQeIjC/lXRyG9aCp1pMStyQDqcYWFkiRRrB5d2Kx8/+pdij6itv30Y2sOxX4BRd+W/HNSJukpYAHELAYd1BxUcwTm2g3WoyOJdS9TQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PY4ei2w1olgedxpgS8+uC3ssMr/c8cGKUIGmOWkYhXs=;
 b=X95d0ZqZxPHXmYZ20FskhOiKzlHuUsN2O8Y9lpy4+qStVmKGhdkS8NSbtJBctg9D44xzJ2arn0mpsTzuMeAGucUZTPiTjlWrItnCSPi37JjHp3SIIhe/GFRiZEKdMIVXBX/T6t4/gUxdSCe/WiGa0V0HvcDBADB7qZce9QbtnBaZQUkz3MeSINFOl8QL6fKv9DPDLAe6+lzWI12yFBR/TM9d2Z67MUZvhJLx37naZfMBtc6GDVJ73pCda9Thxk0hN7IEO7i8XlQg300dLjdyk6zaXiq2DnUiHfHPMGA45tB+RDspu8fAbt3SRA/5kIb0Pop1c5eNlKc71Yd7Jnu4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY4ei2w1olgedxpgS8+uC3ssMr/c8cGKUIGmOWkYhXs=;
 b=5saOxaa7+FThqe/NHVyT5C49G5n6lSlnufLAI8zBqxXDN9CSFXuoXWd79ImgkrU3gFYFtWLGT8DkBVC0VP6CkvMmsnSi7eM0v92fdDorGORQLe8qrsKtsi/7Rz+ycOZBJKRheTXMRSRZjTCb8tC+KYs9NGABy2Tt1gkwN5vAdZA=
Received: from MW4PR04CA0220.namprd04.prod.outlook.com (2603:10b6:303:87::15)
 by DM5PR12MB1369.namprd12.prod.outlook.com (2603:10b6:3:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Wed, 8 Sep
 2021 15:02:04 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::fb) by MW4PR04CA0220.outlook.office365.com
 (2603:10b6:303:87::15) with Microsoft SMTP Server (version=TLS1_2,
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
 10:01:53 -0500
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
Subject: [PATCH 18/19] cpupower: print amd-pstate information on cpupower
Date:   Wed, 8 Sep 2021 23:00:00 +0800
Message-ID: <20210908150001.3702552-19-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 83b1e812-9f6a-409b-b44e-08d972d99e4a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369F22D28FC36B7C59981D8ECD49@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VDOThMhLFn+6g9y2/1Np5p+zLPIVxcknYKM8fHAEiKfCDd1SXgFYD/90yRSWeMnhYQ+MZ0TXlI3P577ywtuQ3MYXWD3Cz+DIZGEZJwk3BOygpT6OvgKtTRtEUq+l+q4w+LNqAHO/ECe4t3vpF9zfmss4mcLbXk+t4IJqX0PPyw82xANKRrVBwRfiz66ouYP9Cj7YJg6h4DKwojKgUSY3D5DuqsDIW+zI4DRzPQ6VBklxR0bkW9SwwL6qPJK9OaxdNoSGazKKiXSPRkk8jmC2AelRib4HdRuWsjDj50UCygeTpAdQN26k0Zs499wdb7Z/+oW12VsXR+/TReJRWNViKRfdT66zFd2yu7kVx4+uFW8Vipwv9bjTo0FqAXoZpFLFxMDpd24kuWpNumcUxGGRHcv/vZAmQ7xOi4lQBRWZ8Sb6+Licee0X+XRRGdUjaIPviP50yMVQ0MkOrFqmosMeW1Jtt0K7DXqxgG1v521CPLaXbqSGMoCRJ9HDvMD5iA4TKcpgQtfDpiVt7sySlOwez3z497UIJkqPcutwMd5rtpg7bk0DT5bRWAI3c3BpsBi1n0HQOTwilWPa9q/X0wTxKvbqYP8o0Fa8Rz49Pk/Ygktkqc58OoDd/ljHVUk5RuxD6DzH/4074iZPKC2xk3M+qSjsCU5XGWzBMHQIPN/KLr9bI+nDlKyqe61U/opd1lllsL5iDYTCAQJB7ej6UFVHcKVgSSdHtKqV6dF27CXo9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(26005)(110136005)(316002)(8936002)(336012)(82310400003)(7696005)(2906002)(54906003)(81166007)(36756003)(83380400001)(36860700001)(6666004)(2616005)(82740400003)(426003)(86362001)(356005)(47076005)(1076003)(8676002)(70586007)(5660300002)(70206006)(4326008)(478600001)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:02:03.7192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b1e812-9f6a-409b-b44e-08d972d99e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

amd-pstate kernel module is using the fine grain frequency instead of
acpi hardware pstate. So the performance and frequency values should be
printed in frequency-info.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 27 ++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index f9895e31ff5a..9eabed209adc 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -183,9 +183,30 @@ static int get_boost_mode_x86(unsigned int cpu)
 	printf(_("    Supported: %s\n"), support ? _("yes") : _("no"));
 	printf(_("    Active: %s\n"), active ? _("yes") : _("no"));
 
-	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
-	     cpupower_cpu_info.family >= 0x10) ||
-	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+	    cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
+		printf(_("    AMD PSTATE Highest Performance: %u. Maximum Frequency: "),
+		       amd_pstate_get_data(cpu, HIGHEST_PERF));
+		print_speed(amd_pstate_get_data(cpu, MAX_FREQ));
+		printf(".\n");
+
+		printf(_("    AMD PSTATE Nominal Performance: %u. Nominal Frequency: "),
+		       amd_pstate_get_data(cpu, NOMINAL_PERF));
+		print_speed(amd_pstate_get_data(cpu, NOMINAL_FREQ));
+		printf(".\n");
+
+		printf(_("    AMD PSTATE Lowest Non-linear Performance: %u. Lowest Non-linear Frequency: "),
+		       amd_pstate_get_data(cpu, LOWEST_NONLINEAR_PERF));
+		print_speed(amd_pstate_get_data(cpu, LOWEST_NONLINEAR_FREQ));
+		printf(".\n");
+
+		printf(_("    AMD PSTATE Lowest Performance: %u. Lowest Frequency: "),
+		       amd_pstate_get_data(cpu, LOWEST_PERF));
+		print_speed(amd_pstate_get_data(cpu, MIN_FREQ));
+		printf(".\n");
+	} else if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+		    cpupower_cpu_info.family >= 0x10) ||
+		   cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
 		ret = decode_pstates(cpu, b_states, pstates, &pstate_no);
 		if (ret)
 			return ret;
-- 
2.25.1

