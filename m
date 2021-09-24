Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85560416B75
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 08:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbhIXGON (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 02:14:13 -0400
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:48608
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244141AbhIXGON (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Sep 2021 02:14:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWdaIjfS6kKDflztMXUVoYPsaJHV7srmudzoToPVIMjN0i6s5z4EKun/SHacP22UTBTi5oYrezs3l5MF1m9uYaIfBluliEoFefNa3iMZ7VUaAc6wrkIJ1nnFH/Qg8slLM346WwjWBTFqKQxjchMFkoAns+Vmh6SdaC/tEQ2UWPLWTqW/tCywC5jp7GVVdo4KgAHSKyMjmHQrqJa1fHGsqAzISXAg2nSm1dMZ3Hc0qdZtWaYBuYGx3KDOZ/vM19kY0fdokUtB+f/CpNd410GBDe9pdrM+Y2TkxEz1Ura+8/dSl3t4KOx1BPHZySQ8gyKzAwzqJtgdalVivkFspCaxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mFaUys2uaSSWqROFJpMpEqvhwicq6BqH6rOZAUipf4s=;
 b=iGB9wuQxlxaBG8X2QvZNwm07e2jnjsEY01QhpFFtcDalp8eWWbQI47Ag7J8GN2rgW1Ka24S5+Ytymb6uJ6m7e5l16gB7tC5oWVHejRuSAmAGUTV0ggRFO+KbnGIxYpmIbjpM4cv/HbuVn2r3Oft7WPvAyulCNP1YGFYf9Wd66o7CzE1yemLOuS+NacJaWsOh27zqflcDJSl9OWRcqU/piyd+f9avBW5g1asmrixD0lU+Mo86bZTPJ2PmfD6Ug0dwtjWD9GVYX2YVEtq3xAbiDYd0UuNBqjWNZKuoW7KRTPQnSzs6pIR0MxJkjscAFwqRnb+vMECEihHHxXgAoN/O6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFaUys2uaSSWqROFJpMpEqvhwicq6BqH6rOZAUipf4s=;
 b=NxfyfI/FkjLA9z1pA5XkrFLMoiez6AWGvoUXbqGoT5SgWZUkYSjv61IIwyjAmQ2L+So4JckCm7h7Ha0eI4FiWvoIdUr08Nhdsd1ecBJIRCzGa/B1s3IycEcIv12wGRssa7Cb/ma0dJia0qC6a5+t3zH1KUOxPp5BbyKxqye75Gg=
Received: from BN0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:408:ec::35)
 by BY5PR12MB5527.namprd12.prod.outlook.com (2603:10b6:a03:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 06:12:38 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::7a) by BN0PR04CA0120.outlook.office365.com
 (2603:10b6:408:ec::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Fri, 24 Sep 2021 06:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 06:12:37 +0000
Received: from ubuntu20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 01:12:35 -0500
From:   Deepak Sharma <deepak.sharma@amd.com>
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Deepak Sharma <deepak.sharma@amd.com>
Subject: [RESEND PATCH] x86: ACPI: cstate: Optimize C3 entry on AMD CPUs
Date:   Thu, 23 Sep 2021 23:12:05 -0700
Message-ID: <20210924061205.5523-1-deepak.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91210ec2-e0d8-4d4a-813f-08d97f224e7d
X-MS-TrafficTypeDiagnostic: BY5PR12MB5527:
X-Microsoft-Antispam-PRVS: <BY5PR12MB5527860A08B3E988394721BCE9A49@BY5PR12MB5527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6U/dj4grFEdGlVPCNHgx5qqeQ4iW1HUm3eXtzQNsTJOxB1rllAB0w3Bhmk2DQr0mowTOdz7f2wDMUTz69XkfKKHRRHWS7ezjuyCj2ReNVXs3mfBQ1Hlj2uB2o21MI15qrsdcjYcSDv0eGvIVXVxidAiltnNswbjBFRISOUKkEZE9qhWbEgzIfxF6tlNk0sDPy4ZSbq1pkQ29iEKL/G3HrEOGLF+qbFMvwSnZv4y2yHClYrbueydBZVM9KVuorBzUQutjhtKsVklI5WrRMGhMLw3DflvcfXS+1M2+Fl3gqvFwfpRZ8Hr9bFAjMGhjePtfW68PcGAoCC5swcwI48OE/7zD8p6WX8pnhLnb4cw/uatLz/EM3I0TH4quCY0qUB/PuTChCADCjutthcZvuBU0tJQvd/eujjOhBrmeOfk6ysUdTEdsMEym2orcluXqJZpOFzmATE25JmK7CM7qwx0Juq/v5nqTgkdLM+i/24oEQQBY5nI65r45Cm2MfhZi+4nalcOf0l/huDnX/WmWU/lhX6ldYlbrLhSAm8tN7mXaAtBzi0uHFgGGbvQ107pR1gkkw/0upykotPIOnJ3sC72s4vzAXeXtNrB9Fd7YjU9zHW9kxxjwuz9FMYdD+Tez6sozvrXagXGL3Pl1q40hIiBPKIIxTWIpiLoJVQbONpTiqCzCrJDclhgRX39Q0+l0H+nomCBjNreNekBhZZBNQkqABXW0oNjWucSzGVkNQI3YFg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(44832011)(36860700001)(70206006)(70586007)(8936002)(54906003)(7696005)(36756003)(316002)(4326008)(26005)(82310400003)(6666004)(2906002)(110136005)(47076005)(336012)(16526019)(356005)(508600001)(5660300002)(2616005)(186003)(8676002)(86362001)(426003)(1076003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 06:12:37.1109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91210ec2-e0d8-4d4a-813f-08d97f224e7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5527
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All Zen or newer CPU which support C3 shares cache. Its not necessary to
flush the caches in software before entering C3. This will cause drop in
performance for the cores which share some caches. ARB_DIS is not used
with current AMD C state implementation. So set related flags correctly.

Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
---
 arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 7de599eba7f0..7945eae5b315 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -79,6 +79,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 		 */
 		flags->bm_control = 0;
 	}
+	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17) {
+		/*
+		 * For all AMD Zen or newer CPUs that support C3, caches
+		 * should not be flushed by software while entering C3
+		 * type state. Set bm->check to 1 so that kernel doesn't
+		 * need to execute cache flush operation.
+		 */
+		flags->bm_check = 1;
+		/*
+		 * In current AMD C state implementation ARB_DIS is no longer
+		 * used. So set bm_control to zero to indicate ARB_DIS is not
+		 * required while entering C3 type state.
+		 */
+		flags->bm_control = 0;
+	}
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
-- 
2.25.1

