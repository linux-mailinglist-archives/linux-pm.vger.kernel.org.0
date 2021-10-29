Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3820E43FCE5
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhJ2NGO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:06:14 -0400
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:3008
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231660AbhJ2NGC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C35fceKLSKygBU4ZlOOr59j6qbpm2QEzNXQg3b5uFV2E28gzKTfM2ybZDlirF6EictVRpOLKkmTWCSOp/5+ITGwg8WavFR185kah/4IEk6nCFe8F4H08Driwr9TZQML3mIRckhk58lReTVQ1izZqis++Gkpcq2FWrpbyAfecJWGRzFq/rH68gM4JJ+VkfUKcJUXb3dSM2oLCnj54b1QQBXdIcf/tJUSJoqhmqsB4qwscDWWx2jRGb3jR1r9xN0TEUN8RrymTmMTHiWdZR64ygn98VIfvLZBd9EiOIDvTgnL/hdtIbEKS3XeAj2r3Xu0LNspyJ9PisEiVSnnm6RSvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gko91jc5e7rpbCzfGpPpjqqcyCTjDnAMnKWSe+2E4Dw=;
 b=EB4zulWsG07KFNZdwtybTGGVQh2brj+7eQyRZjL7q1FjqIIWqJlOHoE2rxhl9ZU5kXzL5LkTjNJ0ZoCZuNZGTWq8dp0NtkqLLyhSCasu74LGJTL8ufrbjXOXvfYTqy8GzYPCCfn6YKSUHtbpl09i2t0jmudBu/S3tmp3gLx3n9W2d3L3unPgM6zipMfz/N/M2cLnJpa04KF7JU5oOcaSLKtG4KFt1q3tAXt3k7DBn9knTR7iJCWd8i+IaVxE0/qcl3XYKhzzipvej1pqV5ownRvOvNbpK8vPXzZwspvfEvjGTQNDaTvJCCqnBnDd5QkAyXMiwbakyZO13ojWPebm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gko91jc5e7rpbCzfGpPpjqqcyCTjDnAMnKWSe+2E4Dw=;
 b=d8P+GliFnt/Q5sbuaQw6fhK5KYLacrlGrKuxKwS6Q5CfCmR3cMn8OJIPcOgKUjLq2OWKZ0Qrhtvezif9W+W4cRgQherEYIKyWmYzB9Y42RVWM7/+PfJi8C+8kA94tjI1GhHdoYkHAaKcl1ib2LlNEY/fUbEoO3ITZ/T/nnzAWr0=
Received: from MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::25)
 by BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 13:03:31 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::8d) by MW4P221CA0020.outlook.office365.com
 (2603:10b6:303:8b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:03:30 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:03:23 -0500
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
Subject: [PATCH v3 02/21] x86/msr: add AMD CPPC MSR definitions
Date:   Fri, 29 Oct 2021 21:02:22 +0800
Message-ID: <20211029130241.1984459-3-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42eb8a05-b429-4fe3-83c4-08d99adc81b6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4965:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49659499D4E9A0D724346AE0EC879@BY5PR12MB4965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abd8ChP2Y7yHLrWOL/TpcKnI9zoU1+MPS41+F/ge/TZ39+K3/alYa7UktJzUY3dfhGeOE087zMyK4LztHIpC20JvoM9vLIhr0XGbbXAfGS/UFp0JHw4TkLUbx+xgiTBdZTc8uhoCv8aWT+DH1BlzMwdTvSELn/MbRUBkY7q/I79N5UMoHeO/w+iezJu3JH+8+gSz2G9OkvVlfh7xtv3CY4bCuBrm24iJ8MHeaPGysbb7zFVsHkF4TWrsRJLf4/KIy0oV/mQH0mwA/ouQKfjAqDHa7JpK9j/OpKEhZvFEJziOvx/u3mZfvexLLPic6wQDARHn9FaxzrVJRpBNlwcjXZYTUP3Ydia/GmeKNBgmtjjke20aAfgyn/OCIM9dc4SgCCyOJ4OD4gf3rbN6ba496HpE464ctCzeohNAkGaUgtA4RmmFzAuMV+TcqQ/HzkCgWT1s6m3ZU0zW5MC9tSeitlY5sKBPG6q04q0HD5sPaJJXcLD7U7JoyihQpgb1btbgVGekC1e1pb2NJwFKwCP7MKqB34emqCuzSA9MiTVCvxMFLAEI4jL9tptv/Ln3G8c1Jrc5BWOkjk+198oUiURIaz35nUQKvj0scwN5tBQXbs0HLIGLoGZkbz+SXx+sgbDokmFWORLVMjysOX30mPfkGz4NObigF2kw7sbt6sUk7kE8KCnhGimtnsl7a2l7VWMpMApy2ciS+A7EpN7LtvJPUXOTwP8dlotF8H/vBsab76s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(70586007)(70206006)(54906003)(1076003)(26005)(356005)(4326008)(7416002)(508600001)(336012)(82310400003)(47076005)(316002)(186003)(81166007)(5660300002)(426003)(86362001)(7696005)(8936002)(36756003)(2616005)(8676002)(36860700001)(110136005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:03:30.7631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eb8a05-b429-4fe3-83c4-08d99adc81b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
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

