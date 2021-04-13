Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B8335E38E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhDMQOA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 12:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231778AbhDMQN7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Apr 2021 12:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618330419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=LLXU2dTylv5ipT3YmLnGJ0wp/qM9UOc9AHkdtf2+w+o=;
        b=f+s80TeIwl34SO2Jx6Iz6wBvXY+7qLaQiq06iNW3PpgzkxMrzcjM8e2rw22n8u1ruUpKbq
        dxV2VCQHbruQPw8ver3vq/krcay97CoHNOpN2XqmBigb70UMGatJQj8l+a3XIbaMa/Azb3
        XQlJs3hRKtOeEXf7eDiFphH02G9+kns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-hZOQzzdoPVGIdCzt3_KOjg-1; Tue, 13 Apr 2021 12:13:37 -0400
X-MC-Unique: hZOQzzdoPVGIdCzt3_KOjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB66F839A55;
        Tue, 13 Apr 2021 16:13:35 +0000 (UTC)
Received: from crecklin.bos.com (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B9F25C26D;
        Tue, 13 Apr 2021 16:13:31 +0000 (UTC)
From:   Chris von Recklinghausen <crecklin@redhat.com>
To:     ardb@kernel.org, ebiggers@kernel.org, simo@redhat.com,
        rafael@kernel.org, decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/1] use crc32 instead of md5 for hibernation e820 integrity check
Date:   Tue, 13 Apr 2021 12:13:30 -0400
Message-Id: <20210413161330.20024-1-crecklin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Suspend fails on a system in fips mode because md5 is used for the e820
integrity check and is not available. Use crc32 instead.

This patch changes the integrity check algorithm from md5 to crc32.

The check is intended to detect whether the E820 memory map provided
by the firmware after cold boot unexpectedly differs from the one that
was in use when the hibernation image was created. In this case, the
hibernation image cannot be restored, as it may cover memory regions
that are no longer available to the OS.

A non-cryptographic checksum such as CRC-32 is sufficient to detect such
inadvertent deviations.

Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
---
v1 -> v2
   bump up RESTORE_MAGIC
v2 -> v3
   move embelishment from cover letter to commit comments (no code change)
v3 -> v4
   add note to comments that md5 isn't used for encryption here.
v4 -> v5
   reword comment per Simo's suggestion
v5 -> v6
   use wording from Eric Biggers, use crc32_le instead of crc32 from crypto
	framework (crc32_le is in the core API and removes need for #defines)
v6 -> v7
   reword with input from Eric/Ard/Simo, code changed per Eric's feedback

 arch/x86/power/hibernate.c | 87 +++++++++-----------------------------
 1 file changed, 21 insertions(+), 66 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index cd3914fc9f3d..0c42400d30b3 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -14,7 +14,8 @@
 #include <linux/cpu.h>
 #include <linux/pgtable.h>
 
-#include <crypto/hash.h>
+#include <linux/types.h>
+#include <linux/crc32.h>
 
 #include <asm/e820/api.h>
 #include <asm/init.h>
@@ -55,94 +56,47 @@ int pfn_is_nosave(unsigned long pfn)
 }
 
 
-#define MD5_DIGEST_SIZE 16
-
 struct restore_data_record {
 	unsigned long jump_address;
 	unsigned long jump_address_phys;
 	unsigned long cr3;
 	unsigned long magic;
-	u8 e820_digest[MD5_DIGEST_SIZE];
+	unsigned long e820_digest;
 };
 
-#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
 /**
- * get_e820_md5 - calculate md5 according to given e820 table
+ * get_e820_crc32 - calculate crc32 according to given e820 table
  *
  * @table: the e820 table to be calculated
- * @buf: the md5 result to be stored to
+ * @buf: the crc32 result to be stored to
  */
-static int get_e820_md5(struct e820_table *table, void *buf)
+static inline void get_e820_crc32(struct e820_table *table, void *buf)
 {
-	struct crypto_shash *tfm;
-	struct shash_desc *desc;
-	int size;
-	int ret = 0;
-
-	tfm = crypto_alloc_shash("md5", 0, 0);
-	if (IS_ERR(tfm))
-		return -ENOMEM;
-
-	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
-		       GFP_KERNEL);
-	if (!desc) {
-		ret = -ENOMEM;
-		goto free_tfm;
-	}
-
-	desc->tfm = tfm;
-
-	size = offsetof(struct e820_table, entries) +
+	int size = offsetof(struct e820_table, entries) +
 		sizeof(struct e820_entry) * table->nr_entries;
+	u32 ret;
 
-	if (crypto_shash_digest(desc, (u8 *)table, size, buf))
-		ret = -EINVAL;
-
-	kfree_sensitive(desc);
-
-free_tfm:
-	crypto_free_shash(tfm);
-	return ret;
+	ret = ~crc32_le(~0, (unsigned char const *)table, size);
+	*(unsigned long *)buf = ret;
 }
 
-static int hibernation_e820_save(void *buf)
+static inline void hibernation_e820_save(void *buf)
 {
-	return get_e820_md5(e820_table_firmware, buf);
+	get_e820_crc32(e820_table_firmware, buf);
 }
 
-static bool hibernation_e820_mismatch(void *buf)
+static inline bool hibernation_e820_mismatch(void *buf)
 {
-	int ret;
-	u8 result[MD5_DIGEST_SIZE];
+	unsigned long result;
 
-	memset(result, 0, MD5_DIGEST_SIZE);
-	/* If there is no digest in suspend kernel, let it go. */
-	if (!memcmp(result, buf, MD5_DIGEST_SIZE))
-		return false;
-
-	ret = get_e820_md5(e820_table_firmware, result);
-	if (ret)
-		return true;
-
-	return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
-}
-#else
-static int hibernation_e820_save(void *buf)
-{
-	return 0;
+	get_e820_crc32(e820_table_firmware, &result);
+	return result != *(unsigned long *)buf;
 }
 
-static bool hibernation_e820_mismatch(void *buf)
-{
-	/* If md5 is not builtin for restore kernel, let it go. */
-	return false;
-}
-#endif
-
 #ifdef CONFIG_X86_64
-#define RESTORE_MAGIC	0x23456789ABCDEF01UL
+#define RESTORE_MAGIC	0x23456789ABCDEF02UL
 #else
-#define RESTORE_MAGIC	0x12345678UL
+#define RESTORE_MAGIC	0x12345679UL
 #endif
 
 /**
@@ -179,7 +133,8 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	 */
 	rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
 
-	return hibernation_e820_save(rdr->e820_digest);
+	hibernation_e820_save(&rdr->e820_digest);
+	return 0;
 }
 
 /**
@@ -200,7 +155,7 @@ int arch_hibernation_header_restore(void *addr)
 	jump_address_phys = rdr->jump_address_phys;
 	restore_cr3 = rdr->cr3;
 
-	if (hibernation_e820_mismatch(rdr->e820_digest)) {
+	if (hibernation_e820_mismatch(&rdr->e820_digest)) {
 		pr_crit("Hibernate inconsistent memory map detected!\n");
 		return -ENODEV;
 	}
-- 
2.18.1

