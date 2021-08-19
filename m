Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17FA3F0F90
	for <lists+linux-pm@lfdr.de>; Thu, 19 Aug 2021 02:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhHSAoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 20:44:18 -0400
Received: from mail-bn8nam08on2061.outbound.protection.outlook.com ([40.107.100.61]:57618
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234523AbhHSAoR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Aug 2021 20:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DECeeFxWpa30+AJAvpoqyIuwX3C6+hfHkqM9zCDLZF/GK1oGDSVgQTsyQjA/BF1o920HjWN3BtNPr22pThi6mSiubByUqzLLGb0qGfKRXxJ+ViIBBvqorH1OfTxZ56nDmqhNH2/1Wn6oqPzRBPBFoHbUXjx2kHd/n7gE1fesCI8ZP5/Dgi37g1R20wI3tOL2+Ts0MteuL7/TQPp3DgmQ4nkw4vnKobtB3aF2BBQlJJj1W6ktbFhKGfJrgzme6tr8gECzhjNhp8aaKNBpZZvpK75noeBRcqkLK1J6lmDpdYh297yqS1dYdo+IQWBpjat+Wob6F91u52hFq2ny4SyoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7auMgbe5JGYVH7LCtbeSPf9I7Y6OxqX1xf2l6WLf5o=;
 b=hL1SiB5teWwBocQnqNvqho+Fxv5NQmsZCdG5Fc+fm3XXu/Cyk27O5JFhezS/k53DRUqno6bB0YUggild8CBP/wI5E56va5RX1fAkOqPYK+eQ6VEEs76Pfs43RPDBHgSyLXimbV2TxXwOJGN6v3MGz96ptpdq91NH6s3PoZ5D6Gx50HbQanvRZQs6yo1afwJekUflaP18MHF0bPgklcGAkEV2i6GbXw2r8LCVyCfoUqapT26I71SUvX4RWQGzXL0tGV3V6Tu8cAPHN9R0L4T9BXPSMJhfRrXpq6VtIFPH2s1TfH19fUnDULU7u6ouSWbAbF9Yze2GXav7pXfr+nzC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7auMgbe5JGYVH7LCtbeSPf9I7Y6OxqX1xf2l6WLf5o=;
 b=C7kmJT17u0UXXZmqD5b1APxeijnwSy/VNwjwrS34Z9nUv9htqAeMiICS+22Bhs2tzcqHQ0qB/mE5ILA6IyqDusuzbSQAP7GBbzdKAUq0RpM1kLOsvRz14xcZ+zMOCYFA6dJxHL5X6pmBSDq5A/qloFZunQNXti1cK/uPlJYQeCg=
Received: from DM5PR19CA0054.namprd19.prod.outlook.com (2603:10b6:3:116::16)
 by BN6PR12MB1428.namprd12.prod.outlook.com (2603:10b6:404:21::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 00:43:40 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::39) by DM5PR19CA0054.outlook.office365.com
 (2603:10b6:3:116::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend
 Transport; Thu, 19 Aug 2021 00:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:43:39 +0000
Received: from ubuntu20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 18 Aug
 2021 19:43:37 -0500
From:   Deepak Sharma <deepak.sharma@amd.com>
To:     <deepak.sharma@amd.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/ACPI/State: Optimize C3 entry on AMD CPUs
Date:   Wed, 18 Aug 2021 17:43:05 -0700
Message-ID: <20210819004305.20203-1-deepak.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac244470-954a-44f5-5682-08d962aa6320
X-MS-TrafficTypeDiagnostic: BN6PR12MB1428:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1428A7E88EC719BFEEAA037DE9C09@BN6PR12MB1428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fv/N1Q0U62hz4dhA2wRdf2jvWfTDi5MT+WpgOYicDeJhw0+jVhio+9HoiaFeirFgtGHUhFPM5USZvrAHWz7pJAWXQOjCqnrd86eUpcu026sQ9DGwaWyzLtK/j8BETnpJH/O2lJ6Jg0ZeELv/rh6kC/oRNuNqfIrQ9ommutC5rvPuQWXMmg6O1tD4w7QoWiqypSUxc0ZcArIacQMoloYS5IQJGP7w+gVtewccbZumAW9JiPLl/eR/EhE5IHKyg4nOAbXizETHog7tcPVDUiRfwO8sRWsfARRL8l+/HJvU1QvgK6Iadyw+lXcexY15kWeKYMlbLeq/wTM4Lt01Ymv1RVCF9S6nRKJxKL7g179Idn2e5dcW/qjTIXYncOWZST5R64Zxjtk0ic1RW/SnEU/eOoLPGoPteZngK0kS6r+P0f8wmMjwsNxHxm/mEb1yAlNhU42ZGkzwggJ+U0RtZ+9DI/DDDpIlZ9JU4+lZHFv9+Hdd43S2PsFRjS8pkbg6LqgI/Vu7f9FD3xHD7Z7nv+H8mfH6vX5+vqrVz3WcgAEvt3F6BHByx8voUkVcMRNirvIJ2qo3RFJJXkODIss1i0aCwinJTFvszCtq4AjOnxTf92wnR+hxb4T1zc2q6vSb9xXI29bX0qIwwoHgxtO3SdYP5pyJVMJOpbO04uc4fGwCHXsDS8LacKzcnsR0U9fmgkeiH8qGbRYNX9RYmdoXozjl8Nef+DaiZxDwwXW3W9adOgjbJ/Ot8WElFAsxmgtjApGud9I5F6yJ3BCoqQgxCfcXLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966006)(36840700001)(7049001)(356005)(1076003)(37006003)(5660300002)(7696005)(16526019)(47076005)(6666004)(26005)(6862004)(4326008)(316002)(6200100001)(36756003)(82310400003)(7416002)(36860700001)(44832011)(81166007)(8936002)(34020700004)(82740400003)(2906002)(54906003)(8676002)(70586007)(70206006)(186003)(336012)(2616005)(478600001)(426003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:43:39.5742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac244470-954a-44f5-5682-08d962aa6320
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1428
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

AMD CPU which support C3 shares cache. Its not necessary to flush the
caches in software before entering C3. This will cause performance drop
for the cores which share some caches. ARB_DIS is not used with current
AMD C state implementation. So set related flags correctly.

Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
---
 arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 7de599eba7f0..62a5986d625a 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -79,6 +79,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 		 */
 		flags->bm_control = 0;
 	}
+	if (c->x86_vendor == X86_VENDOR_AMD) {
+		/*
+		 * For all AMD CPUs that support C3, caches should not be
+		 * flushed by software while entering C3 type state. Set
+		 * bm->check to 1 so that kernel doesn't need to execute
+		 * cache flush operation.
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

