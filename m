Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F255456D61
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhKSKex (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:34:53 -0500
Received: from mail-mw2nam12on2060.outbound.protection.outlook.com ([40.107.244.60]:10785
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234712AbhKSKew (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:34:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF/9KDRlnB7YGDxtSCujInkTJGAyym6x4LS6/hwqQSDad+uUCDJ+XKInXI1wFXdQCCgPmwxwvQm1FHhtR/kSfzXTwnLUJdkDVbUT4WUW+xEddybUQP4RNMTPMHioZXVBSKbdbU/B4zeZrlh5KK6H2YUdYRqNMLWiHkjmmbjFO1pDc3mCGNxCacola50jwSldmj+rMF91BZkokVsLewH7jm+8b/6gsHlI7S6w2VbYlT1h1WvPth/1yXBxPYA+pPu7s3PvFJE0XqLWdtsuV0AepBX8WB/xpkwWVgsHBqxJcPn68G9G8/Zgf1jBPDyFi1R9X4oYx6LvvoBsf/jXD6jX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yUZkCL0yck8d8/rirSFyp0H6Gs7BCb7wXyyMbYT5jM=;
 b=g+Yd1jG6piSZHgdVUL2lNSMxZLrXQySob/fzNDNr/YjKOtuxHxf46yDiTrodclUwDiagAPRErIijXgTbJ0n7LC+hTsGZUycKfAfSIT1inimP7NNtdz7EyVWqix1+VP1euNXy+QsnIQFl7q2XdtoGr3J/TBqEqbTW7DfAbj5vueY88pEuBl5sRugROaUxXkUZS2T2i2kmcaw520bwNvr2NqV7ciMPw6dAT2rMmu54n7OgYNW8mLbagONF1DCXYA0GRyOwTkW1+Qs4eHQmjMBPZbSGdJ2Kd8NpCLRQIqA4yjlUI8C2zPw9Vgc9bed9Z5sTso9mPnCv+6fQKYxz6zVMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yUZkCL0yck8d8/rirSFyp0H6Gs7BCb7wXyyMbYT5jM=;
 b=LJOzcAfZjNf6rVW66gqqtTZnNuB9c2M7/6BJPDwGLJc2lQ9utEXdEyy7GmTpkIBpl4WFioQuLO55CbVEDWcpaWsopF+88c9O3ScST/TFdmJsPuw0Ov5p+kRnZwR1TngJ/2SNz5Jy4Bm+wQT8Eo0uoALKdCs34uqnxkltpEsY7fU=
Received: from DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13)
 by BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Fri, 19 Nov
 2021 10:31:49 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::d0) by DM5PR04CA0027.outlook.office365.com
 (2603:10b6:3:12b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 10:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:31:48 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:31:41 -0600
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
Subject: [PATCH v4 01/22] x86/cpufreatures: add AMD Collaborative Processor Performance Control feature flag
Date:   Fri, 19 Nov 2021 18:30:41 +0800
Message-ID: <20211119103102.88124-2-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57f326b1-85d0-49d7-7203-08d9ab47cb24
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5258F72424A3B9478382BFFCEC9C9@BN9PR12MB5258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHEduPUJxtOTYOUV13CPt1q7tICbwQB16HbKnk2oG7h+lcepWH1bI9gAp0hYX1mCCh+Mw4NASZywqzi4TGjBK+A091bZ8iByzOp74xLyZ14OcRsWdX76vUVJ5ypNdRS4iKL5SwqAqLtEq/gnD3hI820Kcnu/jUGrT3iW5yZ3Vt4EDJiNtRyXFTe5QChGQ3o11o7B9DrYiZxupuox6unk6Y+9IpgIJCMJTkNxSIktwagu3Rhht4RJSWoLRs1b/dA0ZKWT4LqSdFZRp3JnrWJAd6RVHBIy+vkEdgiREB2cGjS9AO3+U7H3sIg1/vh13NRGR+BNEwSS29KfWPclcBMFq6zChEYGde3dWSXR46vnyqq8pmyPzJ4iLVAyQcCE1SgDpqlqhlmowfjTOFD2WvBpZl9PvcDeOgMzQEKjd0G2B0w07fxRX6n0W+OV0havUiAElphFkmLGCzOmvdF2jSVqbbnly/LDOjtwjqD2T0poj5Jqtlk+3OOVIuG9gpwiGIcpxATJre2eZ/Gc1Of1RoTVhem7E6QodYeetEwL47sRtLU25/BrymFHnY94NI028W4Q1dySKOUqSGpglxdSjLxQsx5pK6X5rxtfxMFQz9v63Dm9Nxm8k4THoaLINhAsUkCCujNeD9g5/iHnjToDaw5CedUaj4utRPdwytXnpesNp6mPQsoF+nkOh6bJW2W6eUbzqXpOi/+e3iXwhVt6geX+ktqYPEaHBEL7AkC13NZMHpQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(8936002)(86362001)(70586007)(82310400003)(81166007)(7696005)(2616005)(508600001)(426003)(356005)(36756003)(54906003)(2906002)(110136005)(1076003)(4326008)(336012)(316002)(5660300002)(8676002)(186003)(70206006)(16526019)(47076005)(7416002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:31:48.7787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f326b1-85d0-49d7-7203-08d9ab47cb24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
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

Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d5b5f2ab87a0..18de5f76f198 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -315,6 +315,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.25.1

