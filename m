Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBA2456D67
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhKSKfF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:05 -0500
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:51936
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234738AbhKSKfE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdWZ7IWtR85N32RPU254bViMcCa11+MRuRslcWLrCEwjqtKi1oZpQ3YesIGhnOCy4RcK3mvdsflamARcvGfALBQVlTxLQmqBeaKKBWePqahHNDiDcVIv5AtAJksQ+TJs0qt/FKL4626V7IKzab72SGTeVYEGarYl6ymDUQTP1IWAkQjH78yaxWGzVnL6RTxVkH0/4PtDcFcRYAjXYjEYNiublx7yGNbzsTdBv4GUzHEiezLs1KPJadQoRD6qq9ZC6j5rj5liWtfelSzPs9CKwk9qmIVRjZ0qdu9xMdYbCHP1fdWbQCSGn64kepyHAjcGqU4RBGIZrRJvSqL2bz/RCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmrJdogSFnhgOG9FgwOU58MPcseoeLMGB3Z6ARKq1WM=;
 b=d4fj6LnJ8QCp7Al47A8LnkjJ1La1V+IP7xDbdb529FIzTfVgjgzFlurVo7vO0jZncNnD2Psf4excmmPQtaKPJhVwmR+xyu460zNd1tzWhyIslWzvrL6pRvTchI7xX4RGaI2zaod6xZV8IgH1d1dAaH7SHOQ2WG+1Vm1VCm0tIxpd42Hm/+k2iQcZMxWTGKQ//+9QBQfkN3ng1G5HMjXTNzmPbIPyRFYsUw7q9XtTHqXysvnggVgiTrEcgaWFZdrjVZ7jE8XJKM+U6Uxqgadg3aclUbNNbep1Xjaih5aNkn+9tLsk72nCy9xy9fj8Gh79ow9Xbmwf6bUywar3DntRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmrJdogSFnhgOG9FgwOU58MPcseoeLMGB3Z6ARKq1WM=;
 b=dguwzSF97pFfhwqQoWqk8UkeuW7oJwvmqeSL7+pcVZtt4yjnRd1d6eP+/bhKUEQLN7YI/htrSCWlpdX4DiwiC4LRLeCjJybC+lO3jAVjbAKncWW9BpMXb6hoFpeRoNZDnuRlQ3O6sYjR2Nf3LyxQooyPMp8roVc8gwmGKItldV8=
Received: from DM5PR12CA0049.namprd12.prod.outlook.com (2603:10b6:3:103::11)
 by DM4PR12MB5309.namprd12.prod.outlook.com (2603:10b6:5:39d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 19 Nov
 2021 10:31:59 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::8f) by DM5PR12CA0049.outlook.office365.com
 (2603:10b6:3:103::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 10:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:31:59 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:31:54 -0600
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
Subject: [PATCH v4 04/22] ACPI: CPPC: Check present CPUs for determining _CPC is valid
Date:   Fri, 19 Nov 2021 18:30:44 +0800
Message-ID: <20211119103102.88124-5-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e648346-2469-417e-da3b-08d9ab47d15e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5309:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5309019A3D90FD5A6AD04B55EC9C9@DM4PR12MB5309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6P5FYd0KBSVMgGGscaDOwn0zd0ANNglIoKLvN8mn1zGkDTmOUJLzULXfsraNxKu7X5so9HA1HcI/+ta3aTnduSyF23Zw41oXsktFRmUyyCheuzoH/MjAnrkg9HupEhaJyoAIRVjMuTAJqQ1msEtyYtvBQU20Tne5W4rvdluRbEEn4irSWEUdCVw5dfZOAm/SsN61LdK7jbvhFx8dHw/WHIdOu7//oRx9KX/4z6aa534QixIX0jmR4UddULxPbk1cYaoZPNf9T+RgfLDf1DfczYRgF8s87IvyTzypG7aRr3i5gDv32tqr9LYzeet6nsDuRMiohXCWX5y0fdNsURbrtm09gaEZLLievJwYxekyLRoJq4rDNqSooKWKE9bIfSEtSXACAjckSjqyQBh2hiWtXnt/OeKad5T49SctwXuFFLi7HpzgNP++yqtBuunBnhFI/clhU3ID3AM+SFQPiLdQmR3NjHmHvx8v3IhGrx4nwkCq8dDkzjAQdw0Gez4U5Pqf2EFI79fiPrgZh1f5UsgwV7E400NMsK+ivuocb1fncKyFgXUj2Ge6IFGsR3VhUZCwjRlfCH8QrEsUnoLo/kJJE6gvxLHZPuiWaVsUMrFopkbE2oy5LViQLBPNh2rIAt7Tzm3U2Cl2RVOphzkZjYci7pKxPPz2zsUH6BJ/feVQEzFb6CrYYW9AtQ9dR9p3GayvuTHs72hpavgxOJaffjjRjDV67DKlIrDcsjZhE68u33w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8676002)(36860700001)(5660300002)(86362001)(47076005)(82310400003)(356005)(4326008)(2906002)(8936002)(426003)(316002)(81166007)(1076003)(6666004)(16526019)(110136005)(336012)(508600001)(7416002)(2616005)(70206006)(83380400001)(54906003)(186003)(26005)(7696005)(36756003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:31:59.2498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e648346-2469-417e-da3b-08d9ab47d15e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5309
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
check present CPUs instead.

Reported-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ca62c3dc9899..a46f227dc254 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -411,7 +411,7 @@ bool acpi_cpc_valid(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		if (!cpc_ptr)
 			return false;
-- 
2.25.1

