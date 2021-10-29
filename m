Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8405043FCE1
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJ2NF4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:05:56 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:5472
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231573AbhJ2NFz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:05:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwyhIrxTXsoUokVTIajJY1pAdcPWVfcne80njhBW5nfudBLE9B9dnXPLnCweEZagvjg/hEfUoz6OFwZ0HCZMVcFjMnkthEHKaQZgwCGbm2NqdE4okNig+2ywyKn32IyqGgW9d3yKQPs4s0rAVbKBkm1XnQbIwaiY3JkX3i23hrkpxOEKnzV2/Can+uqSbC9wqpp5+m1yYJsVhGTpCiI7D9rUaT3svd6WfH17ttq72yeNeHJ3e1ef7OLKoF2NU/GnrCiRmVqQX99IzBCouPyhv4iL5UbPBOon9TbOSILGC+Ewax5tf+MD+ZSBTLQkj5PgT2v930nGFGTOmIsGZuIC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P4xm4O0CfQIfSr9XLFWM83Rq1vmw75kCZ0qdhpe8uk=;
 b=XPcj86G9qkrnHryNWYbO59fCecpGyd3ttlIbZLOPucfDqX3UD1JyrUvBR7FeMyL53iktNepM+cTpRtvgo9bjhcpXVPf3yoanimnFlVmiAR36sd8Afpj3hVGghz9W4BbUHZ1sP2DUt+a2U0McGxX7iK9UP1bw4Cdw2520FLrvfyr8EL3/wuUlnoM+03lsRK2ARqPM+GUk+BG0Xe58GevR1IoSfOxVWC9VnW9V7Hv01qoqrNsWZiUGlV7XYwsV95Lf71wAlC+dfu5ykIHXsPVRoY/fu6mh6c8v+idD2ZxLvLufzt5oA91StEjotQrdt56TSARTSQY5nixTAMt9hIA9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P4xm4O0CfQIfSr9XLFWM83Rq1vmw75kCZ0qdhpe8uk=;
 b=bR0LazgfMTj63DEmvySGvtCbmNmqsZI/lBkCGKTs6C1T2oiEbTUUowS73jJak4K0xJIcGZWDd0BAbYxEOagZomX0JCd0KtCHto4ExFrvoo863WuByeBnYNoNbAK9+1n2IzOaoAl95VXQgC90Jx+Ee8N3OgsnNhL6PZuM+EGyqFg=
Received: from MWHPR10CA0018.namprd10.prod.outlook.com (2603:10b6:301::28) by
 DM6PR12MB3113.namprd12.prod.outlook.com (2603:10b6:5:11b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Fri, 29 Oct 2021 13:03:25 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::96) by MWHPR10CA0018.outlook.office365.com
 (2603:10b6:301::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:03:24 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:03:18 -0500
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
Subject: [PATCH v3 01/21] x86/cpufreatures: add AMD Collaborative Processor Performance Control feature flag
Date:   Fri, 29 Oct 2021 21:02:21 +0800
Message-ID: <20211029130241.1984459-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029130241.1984459-1-ray.huang@amd.com>
References: <20211029130241.1984459-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abcd2449-2acb-4c4e-5947-08d99adc7e0c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3113:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3113F33039D48E6E6756FEFCEC879@DM6PR12MB3113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eh6If/60hkW+C5GVWP3pci2sNPxzUK/R2Oabz9/Y39Sf7CDZvodwj+/0MQgYuY9zOXOsYW2BQZzcKamS0kasYp6anFuA+oesAhD0eDBwcKh3UG5S87fMh624jS2uoiDjDUByJtNgslom4Evz88J5lZHmpg3PXptYHpDz9t9vlJCvDCQW5lk3aAZM8mqSYIondEy97w3eodBdoCYe4IxG/gU6ZDkMuZVMyOearM/3MdKCw0Eizg9B2WTp25M6cjQjJYLx8tfvCQ02GRzJ3cNj70CiZsywSbNe8PiQL801JRPzPOdpah+OL1jM/RI+d4/KY2HAZaIKBzHA3qItmWui1B87xPehAWwcMsjnhZYI74N/UbuaBDFq8VMvVfsYDzu42Ca/onh0S/Ma+Fch8eNTKWXdsfuXdwhUX39oq93axniqEpzSG1CokwGnok3aTGOV9iyAwbU0OI7OFXaYeWy5M0QE0+iamWndBDDa6Qu+z2ADtpoup6np6mwAb4R5HpYi8AKs1uggC1LbVG9leIDRt7vNN5Qvtl86AQ99GIjxxmHcxWekKIj8Jp8G50FoSlESwNNaXzoeGEi6S/L84wx0XGIJEt5A2EG6PJn4cNhFLmBVjTnpZe2WJ+PkWd2djnh4HYeXGpQOFHffF4snCBAu4WUomTLrHIMvzwtfFChw3iwIvi1aYNvzhW01k+L4rSgw698cPeOeA7J6tqGNcgHrvS0QGmw9CkOrd1iU/4I7MgU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(508600001)(70206006)(82310400003)(70586007)(1076003)(36756003)(6666004)(5660300002)(26005)(54906003)(4326008)(336012)(110136005)(16526019)(7696005)(81166007)(36860700001)(2906002)(186003)(316002)(426003)(8936002)(8676002)(356005)(86362001)(7416002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:03:24.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abcd2449-2acb-4c4e-5947-08d99adc7e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3113
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

