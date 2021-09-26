Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA364187C1
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhIZJJA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:09:00 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:52063
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230482AbhIZJIw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2kkFEnCqOV5jPi9gBHNFf3RWzbfG1QXJ2mQlpFQ0JcQh5BMnHi+JacaSwzTzvJHluCjW/bETCnYH3VfbPsCyHAFadJxbEJNdCOAwotUqY8SG4MXEQMu04Ys2m6tPV236TfhzWw70NNoFaaxg/P3WkNroPihQZ19BUD00efROb/vIC8KAa3BlFrNUwFRKagjpg1uvZlTXIE5NWMXVmk5AipHUlUKaYvBI288f1gtk0YqboYu2gNxWk2KbS0hNS5sQUIp7QO2vlejOvTagowtYbw4yZtRt5GrtSVLxusvHAQaoi900RKVkL1VrN8fO9i35Nh/uqP1bt0BO3mWL7D5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ps07KAkkEcOIick636gTJ37A8LHbpf86ddMPvpS07Ec=;
 b=oIaihje1q9I5Sqj9E261rkfLKmTxFoKYSCt7wJswKALpeGI5Dnub+brkeuCyWrnkR9NrnxtdkuIg7DhY8Ir+BbHcxNWspJtr6ZcxTVsJvTSwPiv+3GeJoySwZHKN2gcPK6GnXyO1N8QuEqd5ntAzdMCAnnmsCLietuGx0W6jt3pNJhlOV+ZqyMKgay34GE4nOxu4+Sfa2bEjQlCPy4/ghBIkLy4QytXPgDjLAfuAERADRVhwO1ekyzxsrSSEi2OkwyWhOYZ8QEWnadPZ22iEASJWUvj+Ngxj8Dclb2o/EzsjuZe3bJF3eD26SCFQPURVBFuu8jZXBnkli2ebjfAVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps07KAkkEcOIick636gTJ37A8LHbpf86ddMPvpS07Ec=;
 b=cXojJq7UmzMXDa2KJWNkGXbKefQU9PtSWlwZeXeHiNPm5Kp6+LgqGCelSDFD4Phl/icCjslrvdDMwROJwOjfiChTI/5Q7sOYKaMIiKDukNyMta4ipcRW5Ae3Q8vJ4IyxQWp58MHjGs/M+98WwLUvN7bRM6X2e34gLYETWwgppP8=
Received: from MWHPR04CA0053.namprd04.prod.outlook.com (2603:10b6:300:6c::15)
 by DM5PR1201MB0268.namprd12.prod.outlook.com (2603:10b6:4:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Sun, 26 Sep
 2021 09:07:13 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::17) by MWHPR04CA0053.outlook.office365.com
 (2603:10b6:300:6c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:12 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:07:07 -0500
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
Subject: [PATCH v2 13/21] cpupower: add AMD P-state capability flag
Date:   Sun, 26 Sep 2021 17:05:57 +0800
Message-ID: <20210926090605.3556134-14-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 89db2fae-af6e-43e8-b292-08d980cd075d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0268:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0268EC349E1293CF2A7C022BECA69@DM5PR1201MB0268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsSN1VSI7wqlbwakSZ4/8DM2Jm1AUpor5dTdq0VTV5xFfKrxLVF6qIaXDUR09UEHuqtPUktv13v+MMKxWSh9cWo2Ygr6k1nJ/pY2qlisBi2dCuCcMKzFHOP6arlLHmVWPh2C4+7DUsojfDoMkaI2YQ83HSSnM+VtW9LYv6ZeBh4Csz3pvviRUszRtcSilpkj0uwGTVJV848UNoOhEbq0t8x8Pie9JTmtH3GCUmAzzwcQm799Rs6yvK+OJ0xFba80dFY3mK/1FHslb1C6IJbq0BsZbxqehx/dM9ltTJMOpqreK6t+mBDao/W6ZkeZ+i3ig5dmpn59an7Dqp0EM9PdAV7MWY6ZjUAZKghd8u+x049GkVx1sraSOdCmMtf2zTRQ0geZzfh9/fBd++M1W9IwQfTTmdH06lPfQzSCmiKhOdSohoWgPDqntRsNA7lhWbwBQ0xjtNNSrzcbylAeoUk24npXltICrocBvm8Ff6fzKhRbKwp7cXPuOQyYfasp3RkJG7S1cnk54z73qCYFOKoqnhjz2yGlmeQne8GpkbceoPywy9DLCUobv6ywQBA0gm7j4EG+hh8uTpOGDXoRKtEcfzyHnwdHnnD23yZ2NhH0hU+8rpLZAZFKWAYx8aZj4O5YPTdxj93d9U5xmUgQVdwffoweehzhghDMcKRXEBRm7u1J046Ku8wT4laA25/9+7Lax7Ab2VfPLtP6HNijOpgLazGADLJLDDswmtz5VpuHMdI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(110136005)(54906003)(47076005)(70586007)(36860700001)(316002)(356005)(82310400003)(81166007)(86362001)(70206006)(186003)(16526019)(7696005)(508600001)(1076003)(26005)(6666004)(8676002)(426003)(336012)(2616005)(4744005)(4326008)(8936002)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:12.8238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89db2fae-af6e-43e8-b292-08d980cd075d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0268
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add AMD P-state capability flag in cpupower to indicate AMD new P-state
kernel module support on Ryzen processors.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 33ffacee7fcb..b4813efdfb00 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -73,6 +73,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 #define CPUPOWER_CAP_AMD_HW_PSTATE	0x00000100
 #define CPUPOWER_CAP_AMD_PSTATEDEF	0x00000200
 #define CPUPOWER_CAP_AMD_CPB_MSR	0x00000400
+#define CPUPOWER_CAP_AMD_PSTATE		0x00000800
 
 #define CPUPOWER_AMD_CPBDIS		0x02000000
 
-- 
2.25.1

