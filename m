Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648C1456D64
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhKSKe7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:34:59 -0500
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com ([40.107.243.49]:60513
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234711AbhKSKe5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:34:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODAVKdr7N+r5HS7jzXcV9b+KEoYR/mNqb3RNXDiJ+jAale4jGbgGWzmeS9YMRwnQWm8t3pvhRhzlKcJoxuYlNuMI7ZXBp2nvSSRMP/jAvp4yvyzGdnn97B+YQvOTdP3cjdKpsOhHjotOUoSx0dv4Zo8iaqFaxf0qb/1DCXXVHMUkZADZw4yaiPewyOo909C68vCu018kqBtz0QV3r0LR2RX6Ys3jikTH9QpdchgaWZpjvQcrx5XjYsM+XqcEjkEkfy0DKeSuZ03OsL1bBc/imTRhk3/AYpc0YGLXwB+PmcF5EkQblXvS9oeFD+2dWInChiedt3zPF3h2m/2osAUYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8kgyOkrddODGeP9fLYswG8P2mhNQkaTgXSoOqeB0ZY=;
 b=BbucXkI9LNXo9obaMB5Wv9f23R7AmY3g0ldiLzyxJLdtRGSoNZVCdEinKxUg86+C0Xhrhkz6o33y4DeDIbxvOOQIpzKmL+Nvw2AmCRXRwBGQrvQVP4c6yuE17mnjWyIpUPPJ3JzzNjLtN7DewEsG3Nn0JFfKlva3qKVDaksfvJhUssyAQ5W4jhBmR1j1SqN1SAhjKV04xD7r7TqgIU5gixfkMG4q4Xjd7GOWNjv9Bhrp2aSIsthkIyRFRTnQOBEMBcZiqfAwUHLf0mkrcGODICJFn5Mo51qqTDpcq/VlNxjNz1lBgnAZxjm+8Jj8cu4KRZE8tkzqJl7mhSFdebmuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8kgyOkrddODGeP9fLYswG8P2mhNQkaTgXSoOqeB0ZY=;
 b=fNBfMepssFmIfDDH/qrAyupou3c15hWJpf4zbYy+1ggQWB6G+PBPYEPYwIv/NVBDnbFEwWnjzN9hMMGwbXqjGT8W/F5HVXRgZ0tv5+32bksSiWJdNDoc9Syc9Zd6Escfrm6Qg6kMgSXKb6MYgOXJQxKfxr9768cM6MbFWiIRQQY=
Received: from DS7PR03CA0324.namprd03.prod.outlook.com (2603:10b6:8:2b::24) by
 MW2PR12MB2588.namprd12.prod.outlook.com (2603:10b6:907:a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Fri, 19 Nov 2021 10:31:51 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::b3) by DS7PR03CA0324.outlook.office365.com
 (2603:10b6:8:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 10:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:31:50 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:31:45 -0600
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
Subject: [PATCH v4 02/22] x86/msr: add AMD CPPC MSR definitions
Date:   Fri, 19 Nov 2021 18:30:42 +0800
Message-ID: <20211119103102.88124-3-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9cd1db08-00f9-4df6-1809-08d9ab47cc34
X-MS-TrafficTypeDiagnostic: MW2PR12MB2588:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25886BA52C3FEE2DB092EE55EC9C9@MW2PR12MB2588.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WXj9+0PHa3KpitbzlWNQh2F3BNiuGIHCuxNXFS44eCF8MBEhOoXFsbDMXCXIFmMYSvR4eFPe3nBCCHm9hm62z3Z/NPgxduZIJEa2jJ0ZbS417zVsfXy69+PWIaWJti6fWcB767Dcp1ShE0qTm9F5VU0GYuXfKGDg2Lxumg62JidWvoKC9VnbENk0vFH76HvvRTGw9Q6zw2OkOflj8Qy1urh14qXUId7P1XqlMuWwUfd/3yp4i4XKq6oMNLOZ0WBlM2ZbJClHVESsS30uW1yZym8s6NVaDcI6PtVHrUhnyOU0xJl9RWfFzz14/OwxclwLxSgdvXRREgBLEa5/wm+OLoKglURB4MJHYP9lAIOFHGJEKDtbsrzg1EpJT3qdYSppA7Gb33ivQb2iqcYp6J46FwZD64wOLBVTP67JHBG4pgn6+clBvHZdZME45Fy+MYs5p2qry/sPpWC1c7K5WN0hEaqMSEBfN/wv664nkFBZOpteMNyi9f9r3Ps6unhqWi8vFXBnzGm+FWZDoxgwW8mgEoEQ7eBbNkVS0qWJpxWRaYqP6Te0JMsRVoycWB0jpZQ/if/VhFH1KAXDQIe7Ku13+xmunH0r+Ta9A7qe5RH5YrrWe4kmpQ4ckzJGn/mukZNmgs0RSB5yHIXx+S0G4SD/SDDSTdSjhXDhWUVsj0r7rKzT/m2xvZjaHW48KYPc/X5UTJOgkgfASwivAlo4Jxcxckdaj0l3wE/pxPXmDZQkSE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(26005)(5660300002)(7696005)(186003)(36860700001)(2616005)(8936002)(4326008)(36756003)(16526019)(508600001)(2906002)(1076003)(8676002)(47076005)(6666004)(336012)(70586007)(70206006)(82310400003)(426003)(54906003)(81166007)(356005)(316002)(110136005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:31:50.5760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd1db08-00f9-4df6-1809-08d9ab47cc34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2588
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
index 01e2650b9585..e7945ef6a8df 100644
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

