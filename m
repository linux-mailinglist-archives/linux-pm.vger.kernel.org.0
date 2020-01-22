Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993D8144A88
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 04:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgAVDrg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 22:47:36 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16388 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729146AbgAVDrf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 22:47:35 -0500
X-IronPort-AV: E=Sophos;i="5.70,347,1574092800"; 
   d="scan'208";a="82364064"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Jan 2020 11:47:30 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 78257406AB15;
        Wed, 22 Jan 2020 11:38:14 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Wed, 22 Jan 2020 11:47:25 +0800
Received: from TEST.g08.fujitsu.local (10.167.226.147) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Wed, 22 Jan 2020 11:47:25 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
Subject: [RFC PATCH 1/2] x86/acpi: Improve code readablity of early madt processing
Date:   Wed, 22 Jan 2020 11:47:22 +0800
Message-ID: <20200122034723.1863-2-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200122034723.1863-1-caoj.fnst@cn.fujitsu.com>
References: <20200122034723.1863-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 78257406AB15.A89D3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Current processing logic is confusing.

Return value of early_acpi_parse_madt_lapic_addr_ovr() indicates error(< 0),
parsed entry number(>= 0). So, it makes no sense to initialize acpi_lapic &
smp_found_config seeing no override entry, instead, initialize them seeing
MADT.

Put register_lapic_address() into override entry processing doesn't make
sense either.

Improved all the related comments too.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/acpi/boot.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 04205ce127a1..2131035bba98 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1003,11 +1003,7 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
 }
 
 #ifdef	CONFIG_X86_LOCAL_APIC
-/*
- * Parse LAPIC entries in MADT
- * returns 0 on success, < 0 on error
- */
-
+/* Returns >= 0 on success, indicates parsed entry number; < 0 on error. */
 static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 {
 	int count;
@@ -1025,11 +1021,8 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 	if (count < 0) {
 		printk(KERN_ERR PREFIX
 		       "Error parsing LAPIC address override entry\n");
-		return count;
 	}
 
-	register_lapic_address(acpi_lapic_addr);
-
 	return count;
 }
 
@@ -1234,19 +1227,16 @@ static inline int acpi_parse_madt_ioapic_entries(void)
 static void __init early_acpi_process_madt(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	int error;
+	int ret;
 
 	if (!acpi_table_parse(ACPI_SIG_MADT, acpi_parse_madt)) {
+		/* Found MADT */
+		acpi_lapic = 1;
+		smp_found_config = 1;
 
-		/*
-		 * Parse MADT LAPIC entries
-		 */
-		error = early_acpi_parse_madt_lapic_addr_ovr();
-		if (!error) {
-			acpi_lapic = 1;
-			smp_found_config = 1;
-		}
-		if (error == -EINVAL) {
+		/* See if override entry exists. */
+		ret = early_acpi_parse_madt_lapic_addr_ovr();
+		if (ret == -EINVAL) {
 			/*
 			 * Dell Precision Workstation 410, 610 come here.
 			 */
@@ -1254,6 +1244,8 @@ static void __init early_acpi_process_madt(void)
 			       "Invalid BIOS MADT, disabling ACPI\n");
 			disable_acpi();
 		}
+
+		register_lapic_address(acpi_lapic_addr);
 	}
 #endif
 }
-- 
2.21.0



