Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5767403C32
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352082AbhIHPDC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:03:02 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:28379
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352081AbhIHPCz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6lcW1rf0UHbDX082z7nuLZp04kFqO6CfZC/4fWQotRhwJw7P2pT+Pnr5JXtpjkZPuaQ+3ERVdFxyZyQb1b2Przv4N/5qX+hvNRvtn9g/Qxh4957lAo3Q67iIrtM86P41rsfmqC/m0miBgxKNhyK+RO+2J7UF+Rnw0sUCsqbUx640dKgE2vvqvt0l/bkhPvoCrLaedSUJFc8s6V2kcHO7x/2gL8uk5jjTmUvhIGln6tjgCVF0UK8A+2ot3fkXt9akVarUBj1SmZmd06TBBrDICcmIKJHy30pp1z6ZDgBDMSWeZ4VM4zkjoCofxKj9uBxu24dSGvzTM6l2uDYsJ4AUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4P6buCND4/eYrdEV1Ipo5MG22unD1BHrlk9UEtasDvI=;
 b=TriToQaKVOHOfqc1CBmAeMp6OsaYWdnc7LRitsY2sDFicCVbE5sw9G5Q396T2IJpzEldJvxgv0r5lHanrw3tWTIRLcREVqsU6HIMS4dE/sRuCxxxfqGxlIpuWYe3uEb6EVOPWteh4m8Y//jNAMz1iD5vQVVAicTJqhxX/4jsaVQ73yHbHMv10bHsk3FdeBxYLixEGTZMOQEdl1FDNwxL5esY7zJxVeBBzpTruSAVOZstWtW3tCffQ0N6rTag/CCPiel/+aPZzdp+BABl87vaU4Ayfteqp0c10JEkqkXdm+99OnznTUDNE1lswTiQKJgxIo/GHEoXOpWhTHz00nowLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4P6buCND4/eYrdEV1Ipo5MG22unD1BHrlk9UEtasDvI=;
 b=zN8GgXMZXrCucImOV3Cia/7tB7WLUufEazuVgRLrxjfi9EXiLYzcb7VejrD/y6taimeQKy11nh+4lWxtb+llRajymwWfQePbWM/+8X1y2P1n0LKuhXJ2PYcXynWLUE8qu4u5v+pOHvS6aagcvP7bTu++SIj5zAjl9fOxdF81XyY=
Received: from MWHPR10CA0007.namprd10.prod.outlook.com (2603:10b6:301::17) by
 CY4PR1201MB0197.namprd12.prod.outlook.com (2603:10b6:910:23::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 15:01:43 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::9e) by MWHPR10CA0007.outlook.office365.com
 (2603:10b6:301::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:43 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:38 -0500
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
Subject: [PATCH 14/19] cpupower: initial AMD P-state capability
Date:   Wed, 8 Sep 2021 22:59:56 +0800
Message-ID: <20210908150001.3702552-15-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85eaf7aa-657a-4c01-e62b-08d972d9925b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0197:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01978C34AAEC29A174E9B354ECD49@CY4PR1201MB0197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9WnuQe2mnfDfoKUmvUeWvlYN/fWc1wB0Akz33KZrPMo/Mu+ur2Y12gOmIbG2EIgnQ3A/hMING/KOvLp6okVUoSTYo9TbcMuPiQsSsKPBvAu/1cupKedlxAdpj+tw5JL5gUGtYFLtfNADez/ND1/ac3d9BTcQAKk4F2smcLB8MGG88PASA6wj6YcG8w6xLRnz+PtSsDeo+2wr9d+aSNSb223KsknUDaH2pYdzO1tq2oAwEyo+FTQ/PJ6Mh22QZT8t1T4G3A4rS6hkz5VRERxCTsRvuJXXJqKAGdMF7tI+lAa2LgIWlkK5whRyyb2TCmjifG3VZsH9foWgQcBMyDcK1omoTeBN66kKcYt1GfxfyM6mWfH1Y2/W5p9XgSeOFnQ7IDDaW61cPU2g8swxWL/zIwTW7YsPSTeQ5Zff85/v1rh+5Q3xWaJ1BDkH/ul4p9yl55FMz9pOEMBKi8vwSfFMYvNjnbolpYlFBYeTvMbC7Gy/KDNCsqpHYEzfsRiIkE2+bc38bbQOtBKPZAnpxTHhoNPy2I8udc3VUmDZtcnkMjkS/MWFYvfzpkKAOfSWypXYsv2LYzAOxjEQLGQyNk/NSwbN28hG6NfmDDSFqTi/XdMAatvPV7KsGhlHw2UiANlAOc8Woqqc3QscWH8CfV8S59clVJPM0jPwcd7TaYI9HLS6TO3x6D6sXH89V9mX+5Yj7gqiFR6elivoTTQK5C+YcaW+/EwJDfCPwDo3BXlCVE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(46966006)(86362001)(7696005)(336012)(478600001)(81166007)(82740400003)(6666004)(356005)(5660300002)(47076005)(1076003)(316002)(2906002)(54906003)(110136005)(36860700001)(4326008)(82310400003)(2616005)(36756003)(70586007)(70206006)(16526019)(8936002)(186003)(8676002)(426003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:43.7072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eaf7aa-657a-4c01-e62b-08d972d9925b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0197
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If kernel enables AMD P-state, cpupower won't need to respond ACPI
hardware P-states function anymore.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/cpuid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 72eb43593180..78218c54acca 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -149,6 +149,19 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 		if (ext_cpuid_level >= 0x80000008 &&
 		    cpuid_ebx(0x80000008) & (1 << 4))
 			cpu_info->caps |= CPUPOWER_CAP_AMD_RDPRU;
+
+		if (cpupower_amd_pstate_enabled(0)) {
+			cpu_info->caps |= CPUPOWER_CAP_AMD_PSTATE;
+
+			/*
+			 * If AMD P-state is enabled, the firmware will treat
+			 * AMD P-state function as high priority.
+			 */
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB_MSR;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_HW_PSTATE;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_PSTATEDEF;
+		}
 	}
 
 	if (cpu_info->vendor == X86_VENDOR_INTEL) {
-- 
2.25.1

