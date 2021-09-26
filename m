Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B74187AD
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhIZJIM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:12 -0400
Received: from mail-mw2nam08on2042.outbound.protection.outlook.com ([40.107.101.42]:35744
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229922AbhIZJIL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Veygr686rC3vF18IOlq/hYMJ7rss/kzWSRv5sxk6JIZ41om3HN1k8f+8lhbSyiCbACG5Kal1AyZi40lcQMzZK1us+8WNlPRWUahuNOr6yZZpeSaxLaZROl9ao/6350p5Ulhf6VOHsVAZoIC4bO7HzNhmfG0qyIDu30u2n9z7ek49GVQisQqE4zqVcFU4viBrIrTAbWwuTG1rJwhbY4dJWpFZPRs+hhRHcuP2a7+XWKmKYJPHvqGWYjjPMS+WxFJjVJd4j2haAYBtNQAjzYdr/JZvxvc96tyo7vy9YGydDv2J0ilAycTt9L6fogz7kjsejaUm96LUOlw1I8fJb00tkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FSxOYos2nlzOPVOLLX+HHwkGLLMAz1KZ3IoO/8bTic4=;
 b=Ftauq/biAqmBtZxdnRu06F9LWtmOJ0IWVldPItVqWyYclsKlyE3dcw54npmj6VL0+Amt2GGKSJ0oClLer+emvqiVBH/beN7U4Fz3JtYTzTf91v6+ipfuigND/gEC9OWaz6RO2kpDqFAJ+b61+U1v/sxbidbz2c11FzM1iNSpEuB3Nm5bpQEiZo9xENgopMzy4ZNY8glpWRnPWh/NVu36iOKqpQI0pNvrorTnITXsRhjFUNssDcxOBBRiTgx9vM6AKjf6EnEwhiOissfURR2kfGZ1I4rgjc+oQn/1Z8jDcLqR519XJDx8pEDzhPBFO5+IsmY+E49hyYZh7mKHLbJipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSxOYos2nlzOPVOLLX+HHwkGLLMAz1KZ3IoO/8bTic4=;
 b=Svci0j0sMmbOHYRdlstMTnigQFSgNeWIAXPVU8hIzAxFltQtsiffM2PJ6kqHWjLqwsLxyi6305uEecwZ5R3r+LkljIpCiXBfhSiByKm8cTHgW9M6mBPDyglZzRytueRbuZKU2bANqawik7lxr/O1IHz5BxngVbWA3p+CkRSmjpE=
Received: from MW4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:303:8f::9)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Sun, 26 Sep
 2021 09:06:32 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::9c) by MW4PR03CA0004.outlook.office365.com
 (2603:10b6:303:8f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:06:31 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:26 -0500
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
Subject: [PATCH v2 03/21] ACPI: CPPC: Check online CPUs for determining _CPC is valid
Date:   Sun, 26 Sep 2021 17:05:47 +0800
Message-ID: <20210926090605.3556134-4-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f98286f5-f427-4d17-522d-08d980cceef8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4575:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45755CC2DA9FFFE22D4F3615ECA69@SA0PR12MB4575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkmnhBF7+S9OmlAqd0j4LHjgRz3+jbdCD0A0Yi1dnOBVA9Y7QD8V5wmaVOmcj7+OLm3qmJ11G3i/op70XvqwSi4BrcmXcPSfM+VX7kbEfq05P3jThRvx1DNluZmonMStKxQREuYWpuzucN9s1sUv6YyX+Y1DHYC2g4MPl+OXHzLZFymoqPqGFmAbB0sHx4PY2JxUUo0tAor7gnUpu+tgnSvEN48kZmlAyIzvB3YMCTa2WXuqC1qZX4Yu0lC+jwNZrnoW6651HNM8EbBp4ET+cb7MbfgHogWfM31v61ivHZ53cm4j/eHdkwRhCb832WJJND94RuKWc6MU2JsfB0p+CDExvVH6FFzxbb2qPt9T6FAarRkPeHx5Quom6nrWA8lcSrMUPLa/DbaGpZe/4BHhDPxiGf+EHIKatnscUkZbaddmN5+wH9FDj6og4xf8F6fls2vbsRYEfjfbScHi/UxMyJXO1SllvdFkVOBi62jWI0RJ8WivcKv8Bmqcp6CwkLId2NdjltRPPdxGiKTF4MkJLWNmniCtwhjPdz/0Mb109cbHCV0d845viScbfLpxtruRXT46s4n+lm+0+IfnF3TqXTvPfcB53vwCXcTYBIuOE0FV+RTWkDzBMJsf3M96srDHCO3+hM7X5sqxDjU0UObR/cGc1nrClRsYdhJCAl631akB66TfkIs9RgQPgwN2sC/qwVnM0G4MAxIDZfQfz2qinCl4VtZh06bD8okXv+xdu8s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(82310400003)(47076005)(5660300002)(110136005)(36756003)(36860700001)(426003)(316002)(356005)(336012)(81166007)(4326008)(54906003)(508600001)(2906002)(26005)(70206006)(8936002)(8676002)(1076003)(70586007)(186003)(83380400001)(16526019)(7696005)(2616005)(86362001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:06:31.8951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98286f5-f427-4d17-522d-08d980cceef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

As this is a static check, it should be based upon what is currently
present on the system. This makes probeing more deterministic.

While local APIC flags field (lapic_flags) of cpu core in MADT table is
0, then the cpu core won't be enabled. In this case, _CPC won't be found
in this core, and return back to _CPC invalid with walking through
possible cpus (include disable cpus). This is not expected, so switch to
check online CPUs instead.

Reported-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a4d4eebba1da..2efe2ba97d96 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -411,7 +411,7 @@ bool acpi_cpc_valid(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		if (!cpc_ptr)
 			return false;
-- 
2.25.1

