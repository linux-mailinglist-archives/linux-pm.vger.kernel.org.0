Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5DA456D88
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhKSKfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:47 -0500
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:53024
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234799AbhKSKfo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMQBk09f9Wldn0gYHr6rZhd7mfQX5dn+6AyAH8/nVoBXqL0ixGBQhcYOkuGECGYnX9M2RGir1/YlIrtZy9k3wMs5pJ+V32idbiaTb76ARpjAXZUe/xmvQGAJnxFoTBg94mdzaAKEezJaX8CyV8ZFI0jRMHRsEHXqXJ+F6L+2EfyjDrQC0urs04ysuBtx+HyIztWnNNNEr5z9FJ1PA0J3de3Rh3cgtE7YEvW3Fbr8bXL1kMN9hTe5JV6Z73AO9Tewk8HSbbvFhhfjpYKWViSrTRv631aQABm5rLZphNTYv/Q7tLLJF2jVDYPJRVbWbRK0UMZyaiMRRcrXmPhQQ1Lu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps07KAkkEcOIick636gTJ37A8LHbpf86ddMPvpS07Ec=;
 b=PhLwtrqXmQuDJG8e/LLc8KQw/ezCLeGs3cdBq56hP1vaD4Ep0OPSMaXkPaNi0KtD3BW5Fwh81Cfo7PnfPqscwew5Rl0+D7x4qtIQoJ36o28U01vhuRtL+echQkY/+WUHGUB78A3F+U2PG/VDUAEXPNFDNRe8LSgcF8azjKPfQEk0vXSThViodJxW1HDPk4ClBze+r7eW9qfqyaeJHGARsL9FSDCxX0yBmE3zwZq1ZBOdpS5NG9rW4By/bNNoDxmVA6LqRXXNyvQYaQesKb2AxynoYZmXPnmJjHqEL3Ph7OC0TvOd65Lo7gDQMti+53vEP0/W5asLu+6dF4oio46g8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps07KAkkEcOIick636gTJ37A8LHbpf86ddMPvpS07Ec=;
 b=smE/E+87k48Kz22r6p5tePCnSxEqnjC9r7mUnVkmefCQtWMjl/URsbJbGPag2zoF2W0+D/PFrk+ymH1qi+s5B6WKcurphNhC0eieVMyTi1CuLJ98jHaYR1/Y/Z69BNOrICRKWFdf34WKG4c82p3Ax6rqb348n3AeMF4oWzec+hE=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 19 Nov
 2021 10:32:42 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::e6) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.17 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:41 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:34 -0600
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
Subject: [PATCH v4 13/22] cpupower: add AMD P-state capability flag
Date:   Fri, 19 Nov 2021 18:30:53 +0800
Message-ID: <20211119103102.88124-14-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 720fe409-b321-45cc-e4ee-08d9ab47ead7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5490DF9B3DE5109745B18160EC9C9@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfFyRhpxl10AzwU0U6N7jCiQjvLatmKCQyFwwA16RGnOJhaXIzXYNdW6PjDEHvDpsALvdbMmNHLdhrVhlg5UEZf7+twAPHVUpZ9b6Oct8DH67USzp5Tww5h+EsqKtOgN3CgMdRy6+TZX4OFUT5d/ucQFetDwHuxpj8Rq1U0qhDnLERwJ3jI7TnoBCaA29iwHdIvzFMO6Y8cJzO6beIXVi7tRRYt48eGgkE3dJh70rWcQDw3b1AdEKPm4KZnwgyxFGfXiicJhb68RwkN7cjqFoJrPa8lyFOV2WDEZ13iDbMK/wGVA+uDUtMF+oH70Gj3r4Ls+SCft3tmVC7aAWQIro758D57MeBIZUo6vpQtfWmAtgF7bRTNkEONv1nMdnr+JfsAT/SOqJK3bVUXZp61D9lQkdQw85xSAv0j77qiDi+2EIkVEZr4npOjAMa+6VD+X8yTlk9j7jRSsYicIdSDaSn1rL+pbv3Z7r1r3hV0szzTEKCzjN6Xi+CqYQKeFfzfS6OkvT4VPHuwG73jDHmp9rSHWBcOhSO+tWidrtXzp2hbGXm3IM2kLnF5giWccYOoQvyFuA7WAZ1jitt/8nCnIKRXOXIJxEW0jfIF7Gd6j65/WKG5n1FC78YE5yMgErje2z75+MnLxporHUa6H6hYiRsoTT4nfffGkWvTG1cfowVFhv/O6KHuJsJKSryRwi5MIlOd76MWz6QeGJEwSWgwpEogg/PaT472ptUcq7Bmg9C4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(1076003)(8936002)(508600001)(4326008)(186003)(4744005)(2616005)(26005)(70206006)(7696005)(82310400003)(2906002)(316002)(70586007)(110136005)(356005)(36756003)(36860700001)(54906003)(7416002)(426003)(16526019)(5660300002)(47076005)(86362001)(6666004)(81166007)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:41.9661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 720fe409-b321-45cc-e4ee-08d9ab47ead7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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

