Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D826C403C1D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351995AbhIHPCj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:39 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:63968
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351975AbhIHPCS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQL5Iadum7jyMKm8Jru4H5FYwWJ5S7CDIPu/0GIhj92DtNZzqyMt1ubatTpTSm3mM3er8Tkmnm2Q0T4vrTy+PbCIKXG81Y6NFavu663jWaelJbrnzwmvSZUrPOXINMiDvuqDCVrSaZIo8H8MaUqak+M97chpESzsYRVZ2RbBOqUpXqxEt2HeWPlBB1IE4yVg4qF5RbhYqef7+ho8jufor/6MACOFcb/4m+c4rMk8HMvKlRSHJPgeGFWSyulNVISDq4w0k/JS/DYmQ8cAu78Pn01RhzGsyVWu6V9pVkH6ArJ1JG1BWRUzzKMY7QqxTEeN2grSGuj0pMwetQiWQ+7BKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gko91jc5e7rpbCzfGpPpjqqcyCTjDnAMnKWSe+2E4Dw=;
 b=F6KGAgBlEjoPzG6IFnLJo28Z8Qx6XzvgZ/pmut8AetcdxztGs+coht4MZm6Nhw+o5+qixQjh++QUeARVWudGvbHlBgSDyrpq+sLAdmW1cdKoFBeeeh/zJZoUF9/7BDH4Bs17kWWvqCz6F4gtr0Q52AcAcrNpWOXVkDFgQ6qTMHCPDROD/jl2NS33P+rLXTciw/cgC7j8TQ5VAbB3KkJZFYlrb7jNdrG1S6F6/0z6FQSGsJ08xz/Zr1Dv6E9BSJUxgNidINUBL+k43B8dBvMp0cXBzLjG455qQkDchwELU/wIwYvHAHlawfcUxHChYgdbuzYBwABz69bTHvLzvZw5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gko91jc5e7rpbCzfGpPpjqqcyCTjDnAMnKWSe+2E4Dw=;
 b=wfyLMWlAFQUAwnY42jXX1xtlHikDBiavSAkGmy3+ueK4/CW3Nr9uSPWNIVodC5Mjm6TJ69hu+cVuch0/TSKXJyZKZH31/o0hbvG2sShtR/k4KDZoAWUl2sNHapjcxycf71n6zmxskQuWiUIUkeGTqDWdjg3zka6S8FHel9aM2QI=
Received: from MWHPR11CA0037.namprd11.prod.outlook.com (2603:10b6:300:115::23)
 by MWHPR12MB1504.namprd12.prod.outlook.com (2603:10b6:301:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 15:01:07 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::cd) by MWHPR11CA0037.outlook.office365.com
 (2603:10b6:300:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:07 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:00:53 -0500
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
Subject: [PATCH 02/19] x86/msr: add AMD CPPC MSR definitions
Date:   Wed, 8 Sep 2021 22:59:44 +0800
Message-ID: <20210908150001.3702552-3-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 590a14db-34a9-4488-a22e-08d972d97caf
X-MS-TrafficTypeDiagnostic: MWHPR12MB1504:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1504C5D5B9F3C6DA0DF04A4DECD49@MWHPR12MB1504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yA2JjAipvYTpw6Zzy3NIMWP+UxbMRXLKy0MF84nG9SN2NE0yM3xGZBERPp2TiIZCRqcGbO8kyKCK/1i5ZQIxJrC5/eiCRuwAGjyOJSUzBVNbK5y4nZbjG5SCBdhddO5XHQhZR+FgBxT/m9sZ9NgTiljpqKW/L0f1M0EoNVhsA/r52I2OOVtXj9ciHnTXoFCmFPAVReCyXG78b594e/7HXoIRHUv1tzhJO8VuIc+EJNi2FEhX6GFfVaI4MhD+L1YiUebzrkPd4WUCevUm2/UY3pe36wfJhVXXlJcFN50Zunyj1QM1IUCLX0ciExYeclvweobpo/e8SumxzHGY5K0quY0fzUbqUWw11clS7Wv3tinHrRPVucihgtvQWvudKloT+nekpkEeXyBdj0/UrjtU1ABVIeJQXQ6jFL/gQexv61yekzmieHXQnaug17/W0/X0xUxVCB5NYsimaK8omZmUG5Ane7ImOh+R7Tq5ttHNQnu/exupusci2iwcGMtdkCALnBEQmpxCF9k5Z0X6nqfzcpCVtlHVUItsG+MLmpY02pjh058eL0yrJjeZ9eDrA6Tl57XO1Bl+X2/wE/85a0rO3lCUEGDBA4QkqJbXMPFVYB/aV8JEYKJ0YsF2ISN6PvYg13Q+CtHqSkplm9ukxUKigub2sLVsNLC6oTpmtE63uq4VqGjdCWIsDEZv6RsolYKzN4Feg/rTgbjAI/y8phuw54nfxaPEW/kxGZx2//zUYTM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(47076005)(4326008)(16526019)(5660300002)(186003)(8676002)(7696005)(426003)(26005)(336012)(82740400003)(316002)(110136005)(70586007)(70206006)(54906003)(81166007)(2906002)(36756003)(36860700001)(1076003)(356005)(478600001)(82310400003)(6666004)(86362001)(8936002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:07.3331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590a14db-34a9-4488-a22e-08d972d97caf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1504
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

AMD CPPC (Collaborative Processor Performance Control) function uses MSR
registers to manage the performance hints. So add the MSR register macro
here.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a7c413432b33..ce42e15cf303 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -486,6 +486,23 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+/* AMD Collaborative Processor Performance Control MSRs */
+#define MSR_AMD_CPPC_CAP1		0xc00102b0
+#define MSR_AMD_CPPC_ENABLE		0xc00102b1
+#define MSR_AMD_CPPC_CAP2		0xc00102b2
+#define MSR_AMD_CPPC_REQ		0xc00102b3
+#define MSR_AMD_CPPC_STATUS		0xc00102b4
+
+#define CAP1_LOWEST_PERF(x)	(((x) >> 0) & 0xff)
+#define CAP1_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
+#define CAP1_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
+#define CAP1_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
+
+#define REQ_MAX_PERF(x)		(((x) & 0xff) << 0)
+#define REQ_MIN_PERF(x)		(((x) & 0xff) << 8)
+#define REQ_DES_PERF(x)		(((x) & 0xff) << 16)
+#define REQ_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
-- 
2.25.1

