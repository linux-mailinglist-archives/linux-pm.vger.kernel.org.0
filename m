Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22BA4187A8
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhIZJIF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:05 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:32927
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229839AbhIZJIF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx6lr6AtG0Xw/6anHdDRaxqxc5XrdeWnqs4cw8zbmcU9GYYjMQoJYhbp4Y9SdJTYuapw+1pi6IrbwTJ7HSBuVFAJurdQtRfFondC5//8IAHa6VaOReYVEgk7mEdkDLne5Q6aio38MItFQeMvuXq/jJjQf79h5+OYRLvjTP37FOAvZST936qfUD8Lei893uqPmABhAs51sgT23LtXyZF4sGx6uGiOebbDhzgmHVxLUn2f8/ZqkRkMB/+dYs8i1Dfc0UXOeFpaeko8RsDqRmVKAHRfWawbK2YBK2AwYdSPZc5K2pn/JDSn0GhCuQlD1lUhX7gQTMd1DNbXlgFNPkrJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3P4xm4O0CfQIfSr9XLFWM83Rq1vmw75kCZ0qdhpe8uk=;
 b=LNmXjldYlkXSfXhjE0szE/PQap6OGrKX26a5vi+QvqcWhlhEU0CchVpb0M/2tubn1/obfSkUp4H4iK6C0+EbAfiVsQLm112L21xPMtwRP2l6xZVTnu+AxWMYvxagIgQqUyu0nRVRelNusAdSGVviXKHLhemE9q44rXTd0I+PUKvjgkpY/F/pCD9b4mBqBPiKw2nPEItVJwsk5NgIhlZfJkNnV85hbBdrRhrSIRE0Ho1arjJOIu4lHGNbhGyIBXXdBwOerwnPFU4jt30T8gvle+rk/vw6aY0HRq+cDpWfVEOSKLnqeyg89qw7WB45aO6yX/GCkKh+g7UzBERjiYK+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P4xm4O0CfQIfSr9XLFWM83Rq1vmw75kCZ0qdhpe8uk=;
 b=46GTFydtJoy0Zv+oqAdTFJaURjWrj8Rx3WzlHltFE2M82oT8SP+GjE9og9ARujsImnfSF2C8g85gbtE2z92Z9luxmee6/RIBQsWhA2YEYM0FkBhLJyTfkE40i+t3n7Q1KaUev3iCMP4ShS6sQB7AoWV4BLmIkQeIuvtBPuljYu0=
Received: from MWHPR1201CA0015.namprd12.prod.outlook.com
 (2603:10b6:301:4a::25) by BN6PR1201MB0019.namprd12.prod.outlook.com
 (2603:10b6:405:4d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Sun, 26 Sep
 2021 09:06:23 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::ac) by MWHPR1201CA0015.outlook.office365.com
 (2603:10b6:301:4a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Sun, 26 Sep 2021 09:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:06:23 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:17 -0500
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
Subject: [PATCH v2 01/21] x86/cpufreatures: add AMD Collaborative Processor Performance Control feature flag
Date:   Sun, 26 Sep 2021 17:05:45 +0800
Message-ID: <20210926090605.3556134-2-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 07e371e8-d2e9-4e01-fd5d-08d980cce9af
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0019:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0019A4E3D496F5F6D43FC96EECA69@BN6PR1201MB0019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5lFZkrEzRVkHWv82nsnPkmwUK92ie8lDPCCdgpmi2qsRxnyAeG8z5t6lxe1e9l5zv9xwctL6rCOkBOtnJq4ULLK2v2ki8KcdJauImkIlwXpGGFIJs4Zwrfc6EsGNPOkvRNFBGmO6PZgWcM95JKGGKlmKrp5LP95QPwuGZ8GllrizlW2CLdGYDgovUFOO3qELVYEq7Ay0bwdIxFkV7tD/fidjfqImWSuIL8g1tCqXXGyvoS7z9Rgb+Ti66JiHHG0acfXGCKHqQunrF13EXUgZjJ6B7oYzcKjCPwP72nlhaJLTOOHE7g+d2H8uPnRwd3oZzAfeIRSSNqDMGSiIRGZAJhm7NR/TIF1iANr1tlCUFMv7ykDr2mHNH1SWAgcf717zPkZqU7NRanXVKW1qu/FXAYNypEFH3qvUUtjul1cdGArJMg9Wh70tP2LHXj0t05UBQ/A43dSF+1xcV+173+tZ04vCkA4Ue0O/cCx+B7YQ3FgLXrtlHVN8WbJG0Jv1btUyxNoIeOYQGbjt1baqlGxSJIzGNQOlp0b2lp4iUfBSdwVDkalhDSr8fa8T1zTTItx1imRVeeMV+fkKy5d8MD1fNSDDLu+EmvsMfKG2tcsj4tkrLR+EnbtayPfGzcZbQLajBbv5hSidYGSu/HMdwvH4VVa2u8wiAHp1FeW8OUvZIzoQFEjA7KdkUFByN30yWSXSMEItvcqUfyq7vjPI13b9VrNjVqOyqF5NwQ1SXjmDc0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(54906003)(2906002)(110136005)(316002)(82310400003)(1076003)(47076005)(81166007)(86362001)(356005)(36860700001)(508600001)(36756003)(186003)(8676002)(6666004)(16526019)(70206006)(70586007)(5660300002)(7696005)(2616005)(426003)(336012)(4326008)(26005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:06:23.0325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e371e8-d2e9-4e01-fd5d-08d980cce9af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0019
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Collaborative Processor Performance Control feature flag for AMD
processors.

This feature flag will be used on the following amd-pstate driver. The
amd-pstate driver has two approaches to implement the frequency control
behavior. That depends on the CPU hardware implementation. One is "Full
MSR Support" and another is "Shared Memory Support". The feature flag
indicates the current processors with "Full MSR Support".

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d0ce5cfd3ac1..f23dc1abd485 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -313,6 +313,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_AMD_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.25.1

