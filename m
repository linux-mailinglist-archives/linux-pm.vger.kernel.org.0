Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BEF456D8C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhKSKfy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:54 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:58319
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234800AbhKSKfx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUr70uS1/H9QClV2cq8LNn5HotbH9bUfcfNSLGL8yFxEuMgjOLet9vWYVF6EJFsavwjh1r5O63WXKkkOQDJQW6lCnzWwE//8qV5VaOsgMsEAw8DZrIZrsJ+F3z3ai/Xr5Jh43x2XCTOZ6ZT7b7tnmR4mWVSRqBfS+H1aiSDuF87m57LXaNmqnWCQeg1Vc6Pl527v17wGjFK6SVQ/qacU/CUSMSvo6GyhLeHHviS5u1X1WMdgA0a7Z0/1ehm2eylkv2Ueuyppbvk1pBJxBtjAZXtsHQ2y70b7xV4oqpPFrWKl32BywN2wGyQzqH2pQTd5pboePaT99RrdRBN4NfOWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggtBMGzJNT0gf1w54AjpMAmINQmo2vLf+BXHb6ym2hY=;
 b=G/lJp6NoGLrw9HA7qPsUyR9PJAq0bYaduacxqaXLkvdxfKSP3p31EHrJTvPzmxCS51tsICDiro0GK17oqC3aHeWc70ZDlc1ra5H7OPALI+HgXBADMkBXRVddEZRdVvI8PUl2gIIdimRCImVDjcEBH/ml/6ffo39WC371Ny3yq9YYr1adERWIoHLjtwwpQbxGmTSxxR3+mFYbs0KY5OGyE+FK0RizJ9ToIM6m6PGUo4pKg+/c/cdWvEFzZiw1cfnitD6USz+PHhucc0v+1P6PECiD7Mr0izGSEfhjGOwLMEjXGTRlCR+JFfNWwboLeYwbHVXTau2z7HW+Sb19A+ni+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggtBMGzJNT0gf1w54AjpMAmINQmo2vLf+BXHb6ym2hY=;
 b=S954fXA4lxqnTcOfZmtAhpAFm43npE9sv1zFBkJbi40spYZjb57gKDuzEIHQnKDco8zLRGmgN0++4Jg6oMRzCNgclDw8IhEzpbmyMI2t/D4nKwLtR5/CG8WHrPepvzK8PSdCRQzmtSMfK9/FQigaZoSP6M6wVStpzYYbGof/Ncg=
Received: from DM5PR18CA0084.namprd18.prod.outlook.com (2603:10b6:3:3::22) by
 BN8PR12MB3266.namprd12.prod.outlook.com (2603:10b6:408:6e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21; Fri, 19 Nov 2021 10:32:49 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::6d) by DM5PR18CA0084.outlook.office365.com
 (2603:10b6:3:3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:48 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:43 -0600
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
Subject: [PATCH v4 15/22] cpupower: initial AMD P-state capability
Date:   Fri, 19 Nov 2021 18:30:55 +0800
Message-ID: <20211119103102.88124-16-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5c62e5d-3cd5-4447-e924-08d9ab47eecf
X-MS-TrafficTypeDiagnostic: BN8PR12MB3266:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3266B6F19C662AED6109778AEC9C9@BN8PR12MB3266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jlVOwubDE/4yJOmQ9j+y+z72HKB/Nt3/7AjXZ6wvyJrIPYVGypy18X3RsWR/hyQBlRzy1iSl2EWCCCUndWa3XrLQ6R5gNlGiUcdSJStGNjioRlt0NX4um+Xrqr4BebkWz1Dr5P5DI5hqdIwXdDPEWgwTiWztkaZobew7jMjKZCDNlWtoGNVqzOyJXC8YXwzYcl+BtGbapI7twADudHTfxJKB8sMdpaGzxqwHkC6rRl36cP8Qc56yvGVq+v8tWuGAlXCbQTct4tsbB7BTtXhO57wWh12iPZL0q/OWUMsaLZ3GOaNT3EHQ6Zj+Nani1Z9t3Y6A4+QgPMmWXHmhzm9CEUx2bcrEw4+BvM1V/MwmrwaQBe9LfG0G1HLWPn0f2YGm2cy6dBhISO9TztZY5rx7nD8b6nIM/MpaAi+U70nzppJZTMetAjqvZ3qn/tcL7H/9NVDg33Acqb58pxPdI/b7CYjL20UAsZcjznPdDtUf6KlnOO2i3/Yo3vV93tklVaDMLXlK/wfDRKai/pF+hyt/96FjS3pMQbNhk3eigeqvfUgl/28ci+K/dg9ygw/VlB2HnsVu8w9btSz6yl/zG2oIYMp7UgHoIY9oYIrSpFtdPoJARZWl5GkU3X96CDBXBd/Jm37EeLMFDTt5ztwAXSDhfWb0FlOmTB6T1KnX1Qs40c6htXl8Q/n7SieYk3bgVEFRE9PsBRRenoRs2L7B5GRJFBD0LJUkaA1j0pAA9Hcq5w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(5660300002)(7416002)(110136005)(6666004)(336012)(70206006)(2616005)(356005)(7696005)(54906003)(81166007)(82310400003)(86362001)(316002)(8676002)(70586007)(1076003)(16526019)(26005)(8936002)(186003)(508600001)(2906002)(4326008)(36756003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:48.6207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c62e5d-3cd5-4447-e924-08d9ab47eecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3266
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If kernel starts the amd-pstate module, the cpupower will initial the
capability flag as CPUPOWER_CAP_AMD_PSTATE. And once amd-pstate
capability is set, it won't need to set legacy ACPI relative
capabilities anymore.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/cpuid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 72eb43593180..2a6dc104e76b 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -149,6 +149,19 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 		if (ext_cpuid_level >= 0x80000008 &&
 		    cpuid_ebx(0x80000008) & (1 << 4))
 			cpu_info->caps |= CPUPOWER_CAP_AMD_RDPRU;
+
+		if (cpupower_amd_pstate_enabled()) {
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

