Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9C4187AA
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhIZJIH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:07 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:21409
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229848AbhIZJIG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYm4CzN+SP5doQX9PHbY5ZlnwpMMOXaQ1Y5aexzV0DYImEpa6osQSa0+k2RYiqHsDOyfbZTAcLQnEFVreZdy3v70lkT5siHo2wGvRmEOwWTHYZ/80NM8GLCygxWyzd2w6WrF5ZUi+mi6eYYOw5+LJGjXWRqS5YWMWtwm0q6d8mfU1tleRJzlrZTgMaTG1xoWsvTHQlLv4Lan5VgPXh8wa0sx7n3c6GDkfO+WH6O8vE37zJ5mwzA4L1JdsaMrShAXpKOn8VysZAMAif4pGRsFLvdxDSUOgp0neYQ2c0L5hg4IqEDkbHZ9sevFNXQhIW1Eyd2uFDl/8i8CNqjsNX+C4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gko91jc5e7rpbCzfGpPpjqqcyCTjDnAMnKWSe+2E4Dw=;
 b=K30nOlTeP+QDPiTiKfSpge00BQFxzbj8KQqZd5oDABlwqbjwQ4PxFZ7RwyEb8pXwplyaV6U7pmae47fRz2OB1ozjhogsB20RByMQ4yVxRKXWoDqjcY5wXWvFSh8T0sKZlsMy+LZiJuV0Tqc1WlNkawlZmOai4mMMrXOKO6aiOwnXz2gtqjUYQuUwMwT0UWYaJve5kpYWJEfQFpITVXftTGn5dclq2bEfOQUHICkb4koz96xNXP/vEL1+4VGuMa2ycN/JP6FVg0vEiz8VO1Ym07hr6YLJt/Ic04jdjHGJZ8cx0RFsen9fdeAWJyTaz8UUz3tcr1kifxtxmiCZvf13PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gko91jc5e7rpbCzfGpPpjqqcyCTjDnAMnKWSe+2E4Dw=;
 b=AnwMeNytuXfFyfdOndBEeYSgB5Hq8fpaRZm7S5wzP0F6KpZgEclVYyvSbOqk1Uzpb9KAaeHFT1tX2Z/n+x3BH12FYnVihGNqgPh076z+kMU4G+QY0HUgOL6Y6CzpzIyP6ptbwXptmWEhjUjvnt00NjO6RdDPTy8F/nkvAW5ngtA=
Received: from MWHPR07CA0016.namprd07.prod.outlook.com (2603:10b6:300:116::26)
 by BYAPR12MB3512.namprd12.prod.outlook.com (2603:10b6:a03:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Sun, 26 Sep
 2021 09:06:27 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::70) by MWHPR07CA0016.outlook.office365.com
 (2603:10b6:300:116::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:06:26 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:21 -0500
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
Subject: [PATCH v2 02/21] x86/msr: add AMD CPPC MSR definitions
Date:   Sun, 26 Sep 2021 17:05:46 +0800
Message-ID: <20210926090605.3556134-3-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8695953f-0679-4985-7a2a-08d980ccec02
X-MS-TrafficTypeDiagnostic: BYAPR12MB3512:
X-Microsoft-Antispam-PRVS: <BYAPR12MB351239C1C1C84A26234A6982ECA69@BYAPR12MB3512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwN+9ZDSW0ACFB2ItfTY+54nNLh2IhXs0EN5/tXlDvYGuyW3gqHtICiHyRVFYfkQMHqBmFwaYeQdSzXkb7eTvjqAmuisEg/HU+vdI9SBzhnnxzXhG/Oo/IutwwQSE2Tb/pPp4dv1Sp64n4MZDzVhzCIfub9K26JdMlBZWMcidERkywg3MLOmVNDi4VpgYqh9Ptb5PlkiiC0hVjUMoEC/01JiScy4yhasfcPCe1rXN+pvQTkvzbjTiff8me2G+HH+inqxcHRkKyTVwhIm+apyQPcE4/ThUlq1E7tchByWbePgcKSB6sVCpqLtWZeRQRgeyLS86Snpmt+eiEXN0HNO6HvO26wU0ZoM0RhB7TqDT4MGHvQEcR6W+IM9dHuqqKu0sWs4KmM+7H+WCx2VqCLqRb6TN/I69tsg/AkB586sjSddsUFvy9HWhfjzVaw+87piotkbwmec2AVHh3mo/Gm0dqEoiUW5zJTij5YG5StVRO8yYLKc9jix1wnObBD9LbsiRoe6lXjsc24SvrHbVsJNY85UzBltxfJ/yvWU7krk/RIQxjtrYSQ++DtozJ4Pf9o3BH/fw+LdNpr4yCD/Er4IT/dlByV/JiuKKEbmkUInc3p8j28HUm7Lel6gIwJnoAgU9VtjJyZ/0PtusSTmpCZ1ENmQYq6+t2tfEY+nHLbd1j7u+Ov6BD9MgaDqzQ1KCeZ314JDKc6ZKyHFrTDYe+V9AbtLt8jXwVWVwS0+GJWmcds=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(54906003)(110136005)(8936002)(8676002)(316002)(4326008)(36860700001)(82310400003)(47076005)(36756003)(356005)(2906002)(81166007)(86362001)(26005)(336012)(508600001)(6666004)(16526019)(186003)(70586007)(5660300002)(2616005)(426003)(70206006)(1076003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:06:26.9295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8695953f-0679-4985-7a2a-08d980ccec02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3512
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

