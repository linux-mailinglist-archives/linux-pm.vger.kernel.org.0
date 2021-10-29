Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5443FCE8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhJ2NGR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:06:17 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:46908
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230273AbhJ2NGI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxahyBUlwZ8Mwy5eBqAn/50HvgACu9kuUEU/4whAWK3j+tVcafovQ0PNVfaZCtqQr4pU+zQQ2E5J+hOKAonP8La9uwN30DgihZvz7ijQB/OO7WZ5uy/ZFeEsyfOFVYmGoFoUp3Hfe02kOPzWBlUJ5lX7XDzWXCtBI1ity1j7ze4bKyh7vfRy7zTEMZ5zx2dLJI1tax21rQ9081E6aRNEpIPfNDUdLbCrUp4DAm5zwVk1mjJkVNNq2PfuXZJiRGdRzyMHzJzDTNfKrqB2XIis6jIxwwhXQ22oH5wO1KQ3Ec2NV0L9hSI0r9Ky1aNI/ND/4VrmBktkYkhRpbWpicunpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzZM35jCdRAOAYSwS/keMo+QoTpcf5ht7b35OCj935I=;
 b=DwpmgIKV+z1HBuiyNK+L2BJ5PB6tOhGvTzQ0Ggr0KA81fIIhu18IOQR36IDUwlcFCnj9toFHBspOG45wjDXv8Qj2Lr2u4afldsSgMLjNwfgy0c3KzztElHMd3M+XVt64FdXiFULEJB9OSXFVAeO8QcAiIm7MD/lsMa63sPp71ITkXb9riVVRCJC/IPESxWmzUQGIZ3NTsnTq7v/yg+1bgNgXMngsxWbOsDpXO7TskYdaKbH4v1QGRPc3imGT8ljbIB/ZM/lKYaX9ju4vcBG2lRrpNGKeomEp6oK80WXM8TxAz5pHIP7/ghC5mTyRbA4YjXTKoj4OHAnx8PCr6YhKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzZM35jCdRAOAYSwS/keMo+QoTpcf5ht7b35OCj935I=;
 b=h7eEkOuqw1bgr7cwfbY1g1Wg025dc2K/Zj2MSak9HiVdHR9bVESc9NRROOq1hgVDI4tqBUO5ZcraQNmDAsohnU6kQpQh+j6pEkcfydiNlAXJFvN7qpWHUgwHgLtTuLt8u4S/EN71RRBSmK3EQPhfzSOEZuPY8ZhO6Pfq1PRFsAw=
Received: from BN9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::10)
 by MN2PR12MB3392.namprd12.prod.outlook.com (2603:10b6:208:cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 13:03:37 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::83) by BN9P223CA0005.outlook.office365.com
 (2603:10b6:408:10b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:03:37 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:03:32 -0500
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
Subject: [PATCH v3 04/21] ACPI: CPPC: Check present CPUs for determining _CPC is valid
Date:   Fri, 29 Oct 2021 21:02:24 +0800
Message-ID: <20211029130241.1984459-5-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab09a66f-1b2c-4776-dc33-08d99adc856e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3392:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33928F66F1887A55983F3818EC879@MN2PR12MB3392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UA8lkwEv2IEHMX8ctnoviaSQbJk7dWuvwZhEEL/ASeigSQuHJtxpTfDyPsVJFmrXzT/okzKMYiJRi8G9yGkYw16ovSz/L0/QphP/Et+VfGqzKq/gUsLEWLgVDtz2rBwxjgG8PDMMAlpIMfWaF6+nfkb4UDchct4H9bCNBdj5lrLaRKmQwq3YQM+HzTr9F5FBL7tF0na8yPhnSVIpQCWv47sq+IGHcDnUg+Pn2X9Cg1LU27l4r4Po4+KLAgcR94FlCSkybNR2ODw5oRLT7XxljueUHqY0n7iDfk4jCN+g3XBgg8cbXTWUVxf9/qnTxaGOhFG4KbpEJF8dx9jCjlcoJPAf4QrZk7yItUPgCC37wYWvYqDxhg0+yasK4H+R/9fPiTEP7cQspEpkN6DphH1dO4hSXiFxnPqTo1lo7HLJEwNfexA6icXtRLZO6jvGqxeGN/1k67o+LRpiJI30eksACcncXkRFySm1D7HBS8kgg8B4qcBYyezx/kEmW4wcCr15dgOnsOgeYVlIsJ8Pu2dq28dE5rFdR4Z4Sp9a93QsigPk0Wa2TZ3EEIXrryr8OUINH1EoDc3iqbxnRD7zFOq42L07uphWr1WzZD4OBFPq5ojpB8ypeiRgWCC/wHwbEmopUu5NdYGdTq02di1/ZM/mGf4iqZ9dDMSjtvjrDbekjiyTHQhFLWGRMLR13pwWkbxSAdsO6qii4w/vANUbIeqxrmjTPnSDFSfFRKIuvG5Bj8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(70206006)(8676002)(8936002)(110136005)(36756003)(54906003)(83380400001)(1076003)(316002)(5660300002)(7696005)(82310400003)(6666004)(2906002)(426003)(2616005)(356005)(508600001)(86362001)(70586007)(47076005)(336012)(81166007)(36860700001)(186003)(16526019)(7416002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:03:37.1283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab09a66f-1b2c-4776-dc33-08d99adc856e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3392
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
index 444c7a4605ad..c9169c221209 100644
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

