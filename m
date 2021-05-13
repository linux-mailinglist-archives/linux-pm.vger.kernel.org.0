Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B6B37F8D4
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 15:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhEMNfG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhEMNfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 09:35:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0089EC061574;
        Thu, 13 May 2021 06:33:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q5so7451407wrs.4;
        Thu, 13 May 2021 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5p7OaMsl95Y8nXw4EgJp5Zo0yhz5t/eSIRI/VMwgO7M=;
        b=U+oSS7dbZMGEa/ZAoMThQ2jy3JU3b+FROv/Ba8CAWcNmTEp2dUwzdE+pmwQtrqiOWO
         5A/2f6FNclOdvnybdojB71Zzq+nFhEFKBzl6AkgdW2TvbMnwDBlYO7/zQ+XYSNYKB1fi
         P3V3W/SN2UQ+tZmNwGaV53GKz4MvbCot636uXzQAW8/I3ldrBiyqudZGwWSem9fgu0lN
         LyTSy643mzfDX38KZ1htPVDMOG2IReM+03RqbzVKwqsZ6KhsrvjjAMK/Pfej5oDHgZ4u
         u1R4JLbTzZqO9OCrtF8tTBerXXpW+Crq3QODBOsm327FrYfFn9+euBSiEyJV744Ok2Lj
         549g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5p7OaMsl95Y8nXw4EgJp5Zo0yhz5t/eSIRI/VMwgO7M=;
        b=Cudg/lD6/1kfliB2pCNUM+bpKPb37p1BSU3Jc13NNAM5dtzUoKNnO950DgzHL7o4Uo
         nnMjyND0EU9cf+b4TIPkoyUECeXg5X27BHkMXDYGCVPvu9ENB4Wl2gHwL/KfQ0r57xeK
         i13gLdIQa3SVk3MKxR5pvk7yOE+2y+9CL2hbFuECmu58VJX6DFWHT/NkVYGouerUB25k
         Fu2REZjzx6WbxIi6Y1PhhDKsEm/Zh7fwcqHcCreyBD5TiUKvb+1EfklnhvS+B/Vg+noS
         q7bM6BBS6b1xT9Tl39YGPG1/gpVOtsaqsqVgaw79Fh9oftPGjREQSWgYntBdtfqZRNWK
         /gTw==
X-Gm-Message-State: AOAM530A7Z/pTdsFvrzZf8PrCgQpLa81zddE0ONAvP6TrT5TfxGtp/Ck
        oaox35RTGXhXsDXE9PmdYNC6mPfCy8RIAg==
X-Google-Smtp-Source: ABdhPJzVn2ig4cuxqqS+dqDBDHBOTwC2KdGGdhqrQhjlMJhneNlzs6SXMzn8X51elL/u3X/OWblASw==
X-Received: by 2002:a5d:47a9:: with SMTP id 9mr52137332wrb.298.1620912830320;
        Thu, 13 May 2021 06:33:50 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:dc15:2d50:47c3:384f? (p200300ea8f384600dc152d5047c3384f.dip0.t-ipconnect.de. [2003:ea:8f38:4600:dc15:2d50:47c3:384f])
        by smtp.googlemail.com with ESMTPSA id b10sm3318691wrr.27.2021.05.13.06.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 06:33:49 -0700 (PDT)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] x86/acpi: Switch to pr_xxx log functions
Message-ID: <8436da08-4812-d383-8f2a-1c07181ebfb8@gmail.com>
Date:   Thu, 13 May 2021 15:33:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Switching to pr_debug et al has two benefits:
- We don't have to add PREFIX to each log statement
- Debug output is suppressed except DEBUG is defined or dynamic
  debugging is enabled for the respective code piece.

In addition ensure that longer messages aren't split to multiple lines
in source code, checkpatch complains otherwise.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/x86/kernel/acpi/boot.c | 118 ++++++++++++++----------------------
 1 file changed, 47 insertions(+), 71 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e90310cbe..e55e0c1fa 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *  Copyright (C) 2001 Jun Nakajima <jun.nakajima@intel.com>
  */
+#define pr_fmt(fmt) "ACPI: " fmt
 
 #include <linux/init.h>
 #include <linux/acpi.h>
@@ -42,8 +43,6 @@ EXPORT_SYMBOL(acpi_disabled);
 # include <asm/proto.h>
 #endif				/* X86 */
 
-#define PREFIX			"ACPI: "
-
 int acpi_noirq;				/* skip ACPI IRQ initialization */
 static int acpi_nobgrt;			/* skip ACPI BGRT */
 int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
@@ -130,15 +129,14 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 
 	madt = (struct acpi_table_madt *)table;
 	if (!madt) {
-		printk(KERN_WARNING PREFIX "Unable to map MADT\n");
+		pr_warn("Unable to map MADT\n");
 		return -ENODEV;
 	}
 
 	if (madt->address) {
 		acpi_lapic_addr = (u64) madt->address;
 
-		printk(KERN_DEBUG PREFIX "Local APIC address 0x%08x\n",
-		       madt->address);
+		pr_debug("Local APIC address 0x%08x\n", madt->address);
 	}
 
 	default_acpi_madt_oem_check(madt->header.oem_id,
@@ -161,7 +159,7 @@ static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
 	int cpu;
 
 	if (id >= MAX_LOCAL_APIC) {
-		printk(KERN_INFO PREFIX "skipped apicid that is too big\n");
+		pr_info("skipped apicid that is too big\n");
 		return -EINVAL;
 	}
 
@@ -213,13 +211,13 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	 */
 	if (!apic->apic_id_valid(apic_id)) {
 		if (enabled)
-			pr_warn(PREFIX "x2apic entry ignored\n");
+			pr_warn("x2apic entry ignored\n");
 		return 0;
 	}
 
 	acpi_register_lapic(apic_id, processor->uid, enabled);
 #else
-	printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
+	pr_warn("x2apic entry ignored\n");
 #endif
 
 	return 0;
@@ -306,7 +304,7 @@ acpi_parse_x2apic_nmi(union acpi_subtable_headers *header,
 	acpi_table_print_madt_entry(&header->common);
 
 	if (x2apic_nmi->lint != 1)
-		printk(KERN_WARNING PREFIX "NMI not connected to LINT 1!\n");
+		pr_warn("NMI not connected to LINT 1!\n");
 
 	return 0;
 }
@@ -324,7 +322,7 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 	acpi_table_print_madt_entry(&header->common);
 
 	if (lapic_nmi->lint != 1)
-		printk(KERN_WARNING PREFIX "NMI not connected to LINT 1!\n");
+		pr_warn("NMI not connected to LINT 1!\n");
 
 	return 0;
 }
@@ -514,14 +512,14 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
 
 	if (intsrc->source_irq == 0) {
 		if (acpi_skip_timer_override) {
-			printk(PREFIX "BIOS IRQ0 override ignored.\n");
+			pr_warn("BIOS IRQ0 override ignored.\n");
 			return 0;
 		}
 
 		if ((intsrc->global_irq == 2) && acpi_fix_pin2_polarity
 			&& (intsrc->inti_flags & ACPI_MADT_POLARITY_MASK)) {
 			intsrc->inti_flags &= ~ACPI_MADT_POLARITY_MASK;
-			printk(PREFIX "BIOS IRQ0 pin2 override: forcing polarity to high active.\n");
+			pr_warn("BIOS IRQ0 pin2 override: forcing polarity to high active.\n");
 		}
 	}
 
@@ -597,7 +595,7 @@ void __init acpi_pic_sci_set_trigger(unsigned int irq, u16 trigger)
 	if (old == new)
 		return;
 
-	printk(PREFIX "setting ELCR to %04x (from %04x)\n", new, old);
+	pr_warn("setting ELCR to %04x (from %04x)\n", new, old);
 	outb(new, 0x4d0);
 	outb(new >> 8, 0x4d1);
 }
@@ -754,7 +752,7 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
 
 	cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
 	if (cpu < 0) {
-		pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
+		pr_info("Unable to map lapic to logical cpu number\n");
 		return cpu;
 	}
 
@@ -870,8 +868,7 @@ static int __init acpi_parse_hpet(struct acpi_table_header *table)
 	struct acpi_table_hpet *hpet_tbl = (struct acpi_table_hpet *)table;
 
 	if (hpet_tbl->address.space_id != ACPI_SPACE_MEM) {
-		printk(KERN_WARNING PREFIX "HPET timers must be located in "
-		       "memory.\n");
+		pr_warn("HPET timers must be located in memory.\n");
 		return -1;
 	}
 
@@ -883,9 +880,7 @@ static int __init acpi_parse_hpet(struct acpi_table_header *table)
 	 * want to allocate a resource there.
 	 */
 	if (!hpet_address) {
-		printk(KERN_WARNING PREFIX
-		       "HPET id: %#x base: %#lx is invalid\n",
-		       hpet_tbl->id, hpet_address);
+		pr_warn("HPET id: %#x base: %#lx is invalid\n", hpet_tbl->id, hpet_address);
 		return 0;
 	}
 #ifdef CONFIG_X86_64
@@ -896,21 +891,17 @@ static int __init acpi_parse_hpet(struct acpi_table_header *table)
 	 */
 	if (hpet_address == 0xfed0000000000000UL) {
 		if (!hpet_force_user) {
-			printk(KERN_WARNING PREFIX "HPET id: %#x "
-			       "base: 0xfed0000000000000 is bogus\n "
-			       "try hpet=force on the kernel command line to "
-			       "fix it up to 0xfed00000.\n", hpet_tbl->id);
+			pr_warn("HPET id: %#x base: 0xfed0000000000000 is bogus, try hpet=force on the kernel command line to fix it up to 0xfed00000.\n",
+				hpet_tbl->id);
 			hpet_address = 0;
 			return 0;
 		}
-		printk(KERN_WARNING PREFIX
-		       "HPET id: %#x base: 0xfed0000000000000 fixed up "
-		       "to 0xfed00000.\n", hpet_tbl->id);
+		pr_warn("HPET id: %#x base: 0xfed0000000000000 fixed up to 0xfed00000.\n",
+			hpet_tbl->id);
 		hpet_address >>= 32;
 	}
 #endif
-	printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
-	       hpet_tbl->id, hpet_address);
+	pr_info("HPET id: %#x base: %#lx\n", hpet_tbl->id, hpet_address);
 
 	/*
 	 * Allocate and initialize the HPET firmware resource for adding into
@@ -955,24 +946,24 @@ late_initcall(hpet_insert_resource);
 static int __init acpi_parse_fadt(struct acpi_table_header *table)
 {
 	if (!(acpi_gbl_FADT.boot_flags & ACPI_FADT_LEGACY_DEVICES)) {
-		pr_debug("ACPI: no legacy devices present\n");
+		pr_debug("no legacy devices present\n");
 		x86_platform.legacy.devices.pnpbios = 0;
 	}
 
 	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
 	    !(acpi_gbl_FADT.boot_flags & ACPI_FADT_8042) &&
 	    x86_platform.legacy.i8042 != X86_LEGACY_I8042_PLATFORM_ABSENT) {
-		pr_debug("ACPI: i8042 controller is absent\n");
+		pr_debug("i8042 controller is absent\n");
 		x86_platform.legacy.i8042 = X86_LEGACY_I8042_FIRMWARE_ABSENT;
 	}
 
 	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_CMOS_RTC) {
-		pr_debug("ACPI: not registering RTC platform device\n");
+		pr_debug("not registering RTC platform device\n");
 		x86_platform.legacy.rtc = 0;
 	}
 
 	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_VGA) {
-		pr_debug("ACPI: probing for VGA not safe\n");
+		pr_debug("probing for VGA not safe\n");
 		x86_platform.legacy.no_vga = 1;
 	}
 
@@ -997,8 +988,7 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
 		pmtmr_ioport = acpi_gbl_FADT.pm_timer_block;
 	}
 	if (pmtmr_ioport)
-		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n",
-		       pmtmr_ioport);
+		pr_info("PM-Timer IO Port: %#x\n", pmtmr_ioport);
 #endif
 	return 0;
 }
@@ -1024,8 +1014,7 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE,
 				      acpi_parse_lapic_addr_ovr, 0);
 	if (count < 0) {
-		printk(KERN_ERR PREFIX
-		       "Error parsing LAPIC address override entry\n");
+		pr_err("Error parsing LAPIC address override entry\n");
 		return count;
 	}
 
@@ -1057,8 +1046,7 @@ static int __init acpi_parse_madt_lapic_entries(void)
 				sizeof(struct acpi_table_madt),
 				madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
 		if (ret < 0) {
-			printk(KERN_ERR PREFIX
-					"Error parsing LAPIC/X2APIC entries\n");
+			pr_err("Error parsing LAPIC/X2APIC entries\n");
 			return ret;
 		}
 
@@ -1066,11 +1054,11 @@ static int __init acpi_parse_madt_lapic_entries(void)
 		x2count = madt_proc[1].count;
 	}
 	if (!count && !x2count) {
-		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
+		pr_err("No LAPIC entries present\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return -ENODEV;
 	} else if (count < 0 || x2count < 0) {
-		printk(KERN_ERR PREFIX "Error parsing LAPIC entry\n");
+		pr_err("Error parsing LAPIC entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return count;
 	}
@@ -1080,7 +1068,7 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,
 				      acpi_parse_lapic_nmi, 0);
 	if (count < 0 || x2count < 0) {
-		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
+		pr_err("Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return count;
 	}
@@ -1139,7 +1127,7 @@ static void __init mp_config_acpi_legacy_irqs(void)
 		}
 
 		if (idx != mp_irq_entries) {
-			printk(KERN_DEBUG "ACPI: IRQ%d used by override.\n", i);
+			pr_debug("ACPI: IRQ%d used by override.\n", i);
 			continue;	/* IRQ already used */
 		}
 
@@ -1179,26 +1167,24 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	 * if "noapic" boot option, don't look for IO-APICs
 	 */
 	if (skip_ioapic_setup) {
-		printk(KERN_INFO PREFIX "Skipping IOAPIC probe "
-		       "due to 'noapic' option.\n");
+		pr_info("Skipping IOAPIC probe due to 'noapic' option.\n");
 		return -ENODEV;
 	}
 
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_IO_APIC, acpi_parse_ioapic,
 				      MAX_IO_APICS);
 	if (!count) {
-		printk(KERN_ERR PREFIX "No IOAPIC entries present\n");
+		pr_err("No IOAPIC entries present\n");
 		return -ENODEV;
 	} else if (count < 0) {
-		printk(KERN_ERR PREFIX "Error parsing IOAPIC entry\n");
+		pr_err("Error parsing IOAPIC entry\n");
 		return count;
 	}
 
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT_OVERRIDE,
 				      acpi_parse_int_src_ovr, nr_irqs);
 	if (count < 0) {
-		printk(KERN_ERR PREFIX
-		       "Error parsing interrupt source overrides entry\n");
+		pr_err("Error parsing interrupt source overrides entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return count;
 	}
@@ -1218,7 +1204,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_NMI_SOURCE,
 				      acpi_parse_nmi_src, nr_irqs);
 	if (count < 0) {
-		printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
+		pr_err("Error parsing NMI SRC entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return count;
 	}
@@ -1251,8 +1237,7 @@ static void __init early_acpi_process_madt(void)
 			/*
 			 * Dell Precision Workstation 410, 610 come here.
 			 */
-			printk(KERN_ERR PREFIX
-			       "Invalid BIOS MADT, disabling ACPI\n");
+			pr_err("Invalid BIOS MADT, disabling ACPI\n");
 			disable_acpi();
 		}
 	}
@@ -1289,8 +1274,7 @@ static void __init acpi_process_madt(void)
 			/*
 			 * Dell Precision Workstation 410, 610 come here.
 			 */
-			printk(KERN_ERR PREFIX
-			       "Invalid BIOS MADT, disabling ACPI\n");
+			pr_err("Invalid BIOS MADT, disabling ACPI\n");
 			disable_acpi();
 		}
 	} else {
@@ -1300,8 +1284,7 @@ static void __init acpi_process_madt(void)
  		 * Boot with "acpi=off" to use MPS on such a system.
  		 */
 		if (smp_found_config) {
-			printk(KERN_WARNING PREFIX
-				"No APIC-table, disabling MPS\n");
+			pr_warn("No APIC-table, disabling MPS\n");
 			smp_found_config = 0;
 		}
 	}
@@ -1311,11 +1294,9 @@ static void __init acpi_process_madt(void)
 	 * processors, where MPS only supports physical.
 	 */
 	if (acpi_lapic && acpi_ioapic)
-		printk(KERN_INFO "Using ACPI (MADT) for SMP configuration "
-		       "information\n");
+		pr_info("Using ACPI (MADT) for SMP configuration information\n");
 	else if (acpi_lapic)
-		printk(KERN_INFO "Using ACPI for processor (LAPIC) "
-		       "configuration information\n");
+		pr_info("Using ACPI for processor (LAPIC) configuration information\n");
 #endif
 	return;
 }
@@ -1323,8 +1304,7 @@ static void __init acpi_process_madt(void)
 static int __init disable_acpi_irq(const struct dmi_system_id *d)
 {
 	if (!acpi_force) {
-		printk(KERN_NOTICE "%s detected: force use of acpi=noirq\n",
-		       d->ident);
+		pr_notice("%s detected: force use of acpi=noirq\n", d->ident);
 		acpi_noirq_set();
 	}
 	return 0;
@@ -1333,8 +1313,7 @@ static int __init disable_acpi_irq(const struct dmi_system_id *d)
 static int __init disable_acpi_pci(const struct dmi_system_id *d)
 {
 	if (!acpi_force) {
-		printk(KERN_NOTICE "%s detected: force use of pci=noacpi\n",
-		       d->ident);
+		pr_notice("%s detected: force use of pci=noacpi\n", d->ident);
 		acpi_disable_pci();
 	}
 	return 0;
@@ -1343,11 +1322,10 @@ static int __init disable_acpi_pci(const struct dmi_system_id *d)
 static int __init dmi_disable_acpi(const struct dmi_system_id *d)
 {
 	if (!acpi_force) {
-		printk(KERN_NOTICE "%s detected: acpi off\n", d->ident);
+		pr_notice("%s detected: acpi off\n", d->ident);
 		disable_acpi();
 	} else {
-		printk(KERN_NOTICE
-		       "Warning: DMI blacklist says broken, but acpi forced\n");
+		pr_notice("Warning: DMI blacklist says broken, but acpi forced\n");
 	}
 	return 0;
 }
@@ -1574,9 +1552,9 @@ int __init early_acpi_boot_init(void)
 	 */
 	if (acpi_blacklisted()) {
 		if (acpi_force) {
-			printk(KERN_WARNING PREFIX "acpi=force override\n");
+			pr_warn("acpi=force override\n");
 		} else {
-			printk(KERN_WARNING PREFIX "Disabling ACPI support\n");
+			pr_warn("Disabling ACPI support\n");
 			disable_acpi();
 			return 1;
 		}
@@ -1692,9 +1670,7 @@ int __init acpi_mps_check(void)
 #if defined(CONFIG_X86_LOCAL_APIC) && !defined(CONFIG_X86_MPPARSE)
 /* mptable code is not built-in*/
 	if (acpi_disabled || acpi_noirq) {
-		printk(KERN_WARNING "MPS support code is not built-in.\n"
-		       "Using acpi=off or acpi=noirq or pci=noacpi "
-		       "may have problem\n");
+		pr_warn("MPS support code is not built-in, using acpi=off or acpi=noirq or pci=noacpi may have problem\n");
 		return 1;
 	}
 #endif
-- 
2.31.1

