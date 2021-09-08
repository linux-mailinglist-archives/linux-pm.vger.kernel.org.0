Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DD6404097
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 23:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhIHVmu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 17:42:50 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:19200
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233502AbhIHVmt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 17:42:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv6RbGP8LflTUmL1I7PnRGb2VUL86zI/JhOfUjR1L5W7i1tgQh5ST7qA/RJpUilFhC5HGokbQKdRMjfwLhVbwJo1EsYt5N8L6EUuC4VTddG1D+WYMAnC2lOaEdO0xzj1D1iU0tKQPFD4TpvU8aZS8sFTvuyP5e/FLNGrk8JfKTBtUrLyYq2+WR8bLtXgqwPtQQCgkNaxYs5enGj9NtbllTnUOQ17+dR/S5Fe1pDJbIkPTh4RsnTbFRhE427qQfubKgfB09Hws66IrXc5iSv0eq2Fm8QlL7+1lUVb7Br3FQwB7lnc5MEAHbUZ45ICGrOvFx0so5nq5/m9pJaQw0rUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tnOFoOWj/NX5Pg1K7xVcyEGYUs0Pa8qqtw+/l0l7MQg=;
 b=jDyZii13kPOn92fdtrwnei4MIvm6BbiGJkvPqJ4BXsrtrRbSZSc+TweF7YjVaBDHy+uJkoM+BFB3JF0MKhrXT8Xq+Y5vEkN4hRn84Hj4GzrlXeLXOIEc5y3ZuxZrxQNJi1PYX7sdXndqiGvu8GKye3gz2PivUiXQKOvOgEzIrAzAyDjFINpkDjQ4KRjQemrPVQuV74Ece2RFFboXs1pLNtzm3So82UZSaI+/swLKMW4Nh7Jd418agSrWZP3UIKym6DQaWCStM3P52GfJvji1WbMpvEKo3tuovBs/ffwHFUJL27g/uOOiHTT46WLrjmDrSdH+MS9Wjof1qb+JC1V3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnOFoOWj/NX5Pg1K7xVcyEGYUs0Pa8qqtw+/l0l7MQg=;
 b=3gedtlvNXYanKqOXyysY0gDTRGd2PFVXBVgcUoXsm4jY5jWkSqnyPkHSwB/GG2kdabioaPalVKzW+9eA0wPJ3ZPj8+owjnbFkrhteIbhRFof5yS/79y+BTEb68GvEwvlOsJFtJV53RwxnYlL0xyh8Q4J/P2Y4o54x84SjiphQcg=
Received: from DM5PR2001CA0012.namprd20.prod.outlook.com (2603:10b6:4:16::22)
 by BYAPR12MB3494.namprd12.prod.outlook.com (2603:10b6:a03:ad::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 21:41:38 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::9a) by DM5PR2001CA0012.outlook.office365.com
 (2603:10b6:4:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 21:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 21:41:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 16:41:36 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] x86/acpi: Don't add CPUs that are not online capable
Date:   Wed, 8 Sep 2021 16:41:46 -0500
Message-ID: <20210908214146.8640-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908214146.8640-1-mario.limonciello@amd.com>
References: <20210908214146.8640-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6630aba6-d889-4c01-c1ce-08d973116fda
X-MS-TrafficTypeDiagnostic: BYAPR12MB3494:
X-Microsoft-Antispam-PRVS: <BYAPR12MB34941EDD950A6B5F3DA52A1DE2D49@BYAPR12MB3494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qtua7FOb/W7xd2Y6AmIEkGmB5MjPZaxt0WWMIXIbaPGerCNRX431jkE6E0relC4bfbPgUDfaKWFFH297xr5M3Ho61lWhMhOmiyTdEJQPdHVyI/fdfU5nQ5qyA0fWlFmotq9HbvKNhT1nbo3VZBL8ctqVcp94jOTOmTRJ5Zf5SavTipMeVAzlEFHprHzuFstpok/M4pDwJX19189CzOTCjMY3Xgmk/iHvQ9PH1Xm14xX+E2AmA72Q/+yU/6nodUV7nofc1Q2AF6WtvlwygEArP+IKE7qGN5QXk82CFaUJMHeUBRhaB2kbX/9Y/Ftp8Ib+qFmkRDdXJFT76Mi8lm0s2HsR5yvzzD4qRDF06d1n/YU7m4u+qpKWm3VqlgFiSyPJoswKM72n1/+B2eNpOBrr+7U/LQx51+bQhP58UKjMiNDIRH6Sgn3UgT2XYMt08a0vAD3JuCTt+GhzEK3f5FIroRpp5gCkXySbD41bnZ1mu+UNkjTR3+602IWj2nn+P160xyHXY4Nq41RbrhggCp9QY3EkAaNjq5ZFBHNpydvFVz328e9XW4zEOKfztvzxthPmU4kNe6hGVuqi//IS/TFMlNH56iI97sWPeWmvv+fwmF/n8nwWyNe9t8lOC2SlE0DjP5Jmtfm04rujHUxiVww76xqvXp5/5WvhGmXZeM3mGoxeAhQWb73UzXGUaCIq0TvM+b5NvhkV0jstkilZPbiYOe/HTQzpmG5Z8DR4etrbuRN2lpLB5rfqvhS+6yrJHSKxBZr0P3mfFqLd+cbh6tmFuzSTqwhzUT9aZh9/sYTlIkfrgEXJFRDhjA/w5F8JtAwP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(47076005)(2906002)(44832011)(316002)(81166007)(1076003)(36860700001)(2616005)(8676002)(4326008)(6916009)(426003)(966005)(6666004)(26005)(54906003)(83380400001)(36756003)(70206006)(82740400003)(7416002)(70586007)(186003)(16526019)(86362001)(478600001)(5660300002)(336012)(356005)(7696005)(8936002)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 21:41:37.6852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6630aba6-d889-4c01-c1ce-08d973116fda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3494
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A number of systems are showing "hotplug capable" CPUs when they
are not really hotpluggable.  This is because the MADT has extra
CPU entries to support different CPUs that may be inserted into
the socket with different numbers of cores.

Starting with ACPI 6.3 the spec has an Online Capable bit in the
MADT used to determine whether or not a CPU is hotplug capable
when the enabled bit is not set.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html?#local-apic-flags
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/boot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

Changes from v1 -> v2:
 * Make the change only apply on ACPI 6.3 or later
Changes from v2 -> v3:
 * Make acpi_support_online_capable static and only valid if CONFIG_X86_LOCAL_APIC is defined
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e55e0c1fad8c..d915f01b582b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -62,6 +62,7 @@ int acpi_fix_pin2_polarity __initdata;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
+static bool acpi_support_online_capable;
 #endif
 
 #ifdef CONFIG_X86_IO_APIC
@@ -138,6 +139,8 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 
 		pr_debug("Local APIC address 0x%08x\n", madt->address);
 	}
+	if (madt->header.revision >= 5)
+		acpi_support_online_capable = true;
 
 	default_acpi_madt_oem_check(madt->header.oem_id,
 				    madt->header.oem_table_id);
@@ -239,6 +242,12 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 	if (processor->id == 0xff)
 		return 0;
 
+	/* don't register processors that can not be onlined */
+	if (acpi_support_online_capable &&
+	    !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
+	    !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+		return 0;
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
-- 
2.25.1

