Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0303E403C18
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbhIHPCF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:05 -0400
Received: from mail-dm3nam07on2043.outbound.protection.outlook.com ([40.107.95.43]:17569
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351854AbhIHPCD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXbh60QFGUrdzZ3CG9JgGyfKTkmsctA4i5S4Mmjl8k/n9ClCEee6F82GwYSLuvPcIddh+hxkUGQiQhtgq6lOKBNZx6Kl+XvwfmbNi2W3FeXvlmR9cneZmjusroKH8Y32oZf2yC1bbOBPi/AGSBz6s4qzBr2Ne/+IcxlsUyvCF+HdsJdu/3qwPJc83HLS33s0wOZFDytNH5G6HdsohlvuslsmyrKkoMEUk0S7Ua//jkfcsEyC2GUfR8uvxfl9MoQK66nxd+6AX0+Eje5smpZyvL10fq+Hia0Od/Fd6fOd4eOtz6OrjodoD4+/0hSWYryt/0uQq4howDl5+o89z+ci0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jpOy2ILYGeosWhLGfF2b0lYNXeK36a2GMcNcggRa9W8=;
 b=C/dkQvxyiqRUwW6wlTjFQkJXOf8vw8EBMSG/xC+Hiav769CQV2xBpia1Rtt0YB6Jtn7PsSNTmYGv02LhIqPgXsf2qWNUpHAaR+4vDtkJIGRlCIvSBZNS1s0FhIK/KktSpX9FkFDHFJk7QxBH+UmH+9jUOUEM+MJ0C0JnRHpxDXh2hS2BnsryxHfi4XNi7l5FUqitWgtiwK05ekuNpbn3FN974LqCKKNdjKCE1Dj7AAFKybsQ25mFqSU6s2ZoVupxXp2p6riFP1FlFKEYv77DqgqRfjaftI+hl31otpXC7KBHJQL9msRGzJO6dQFmIYpiD+G4kugbautltMb1u/SqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpOy2ILYGeosWhLGfF2b0lYNXeK36a2GMcNcggRa9W8=;
 b=ZdA37U2s+qHg+MbnZ0mbkvDswgWU2hUcsgmzA3Px43MVYslCtV+xy7UFirlrxsA1sxCN3lfIloS3x5//uuKFsNjoaFm9YU/JF44RjrgbF0akKDt33Xyx80jHK05knQZkqBALXI/k/mDLJG0gKjRy/KaWRwPD5zmX5yVHXJToMmk=
Received: from MW4PR03CA0286.namprd03.prod.outlook.com (2603:10b6:303:b5::21)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 8 Sep
 2021 15:00:54 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::3d) by MW4PR03CA0286.outlook.office365.com
 (2603:10b6:303:b5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:00:53 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:00:49 -0500
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
Subject: [PATCH 01/19] x86/cpufreatures: add AMD CPPC extension feature flag
Date:   Wed, 8 Sep 2021 22:59:43 +0800
Message-ID: <20210908150001.3702552-2-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8407e99-1bb0-4470-3212-08d972d9749c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5143:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5143CE96F0BED8D37F306CE6ECD49@BL1PR12MB5143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYpfS/yh6Y0C13zxJKxTya3BBkte30C0phvrBlssQs3XK6y5+t+srMGiXsHxYsimEXnVRbHQfU5kpB0fmf3rAFoX/WfWuLezTypLQc59XDntKBreZN5tfPLP2MFzCNwQ0rGwz54AJyxgOyDEK+zLFeY5QSgJ6EKIeM0tQXAQk01hu0RwwDZTDI7SD9Sm0DeeMbwd9MV/8DUskJtyDm02sh0HcCy1drlhUS4vru4SFh4PcMDuV9o2QisKTD+Yo+J8v6PYi+I42gjrkQMCX821j386pqB3eQql2EgKgEJPlUMzk9fjP2bj/1ZovyFzt/gvL0Vr0dsBncyEPI8qUYZW7fx0RxOWEeEKSo3CSHNyZAyepldYy9N3XveuOJejadUDJxc1lUDCFgw1ntD1DCH9TIhrnUTnnM7nnGIZ1gMuzzzuc9qyOESHj1ZcSUj/8LR0n2uIiUUVj+nbpBzSjfszL0MxSUZUX9VukFgTDNQa05osVaeBAfHzBkF9N2X0m0s1Ur/OJJOt7DqeoNMQ5z4TWcj5TOMA/HGSuwpHz+WQt8M5VqJnM/6YYWFFeZJh46hO+RQcCYLQqPNhMQpe6m70dHBKEgPZ6X6X8lndFAFhy/imzjt+1q0lJjOfde3qJ5dMwNI1xPUDML0rwlsU58ZoBEM9FZEFsNG9u9/0BHca0lx63dLiQQ2H6WQnAIK/yC/3emm10UYT7JnzBFJLQyso/Vt23vOfPSF2zPRflKCVjAI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(2906002)(1076003)(54906003)(8936002)(110136005)(356005)(186003)(36756003)(86362001)(6666004)(26005)(316002)(16526019)(4326008)(81166007)(7696005)(4744005)(5660300002)(70206006)(2616005)(8676002)(82310400003)(47076005)(426003)(336012)(478600001)(36860700001)(82740400003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:00:53.7891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8407e99-1bb0-4470-3212-08d972d9749c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Collaborative Processor Performance Control Extension feature flag
for AMD processors.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d0ce5cfd3ac1..f7aea50e3371 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -313,6 +313,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_AMD_CPPC_EXT	(13*32+27) /* Collaborative Processor Performance Control Extension */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.25.1

