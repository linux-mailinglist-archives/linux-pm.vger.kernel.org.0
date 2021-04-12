Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20D35C860
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 16:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbhDLOKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 10:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240501AbhDLOJ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 10:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618236581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=SbIHlRt5xnwBUezOuapEzl2m40Nh7kvApwj+aK9cf3Y=;
        b=C0V/I05iEUO6F+ZvymhBLsd8t68quj1Zo8j7TOQBVbSP7wzKvxDMH7w3JMbIpvUT4xskUo
        Q/vErqFecQcub/8rsSzUcxno0SoE/lOEoYhGHmNwsqloUuugdWiTPznp+sRmrB49FOkS0F
        Wc+INygTqvQmtGt70uskDRm+sd9hSns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-FCLC3kK9N0uQ_opseESiCA-1; Mon, 12 Apr 2021 10:09:39 -0400
X-MC-Unique: FCLC3kK9N0uQ_opseESiCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F1B3800D53;
        Mon, 12 Apr 2021 14:09:37 +0000 (UTC)
Received: from crecklin.bos.com (ovpn-113-158.rdu2.redhat.com [10.10.113.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77B06100238C;
        Mon, 12 Apr 2021 14:09:33 +0000 (UTC)
From:   Chris von Recklinghausen <crecklin@redhat.com>
To:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/1] use crc32 instead of md5 for hibernation e820 integrity check
Date:   Mon, 12 Apr 2021 10:09:32 -0400
Message-Id: <20210412140932.31162-1-crecklin@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Suspend fails on a system in fips mode because md5 is used for the e820
integrity check and is not available. Use crc32 instead.

This patch changes the integrity check algorithm from md5 to crc32.

The purpose of the integrity check is to detect possible differences
between the memory map used at the time when the hibernation image is
about to be loaded into memory and the memory map used at the image
creation time, because it is generally unsafe to load the image if the
current memory map doesn't match the one used when it was created. so
it is not intended as a cryptographic integrity check.

Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
       by md5 digest")

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

 arch/x86/power/hibernate.c | 76 +++++++++++---------------------------
 1 file changed, 22 insertions(+), 54 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index cd3914fc9f3d..f39e507e34ca 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -13,6 +13,8 @@
 #include <linux/kdebug.h>
 #include <linux/cpu.h>
 #include <linux/pgtable.h>
+#include <linux/types.h>
+#include <linux/crc32.h>
 
 #include <crypto/hash.h>
 
@@ -55,94 +57,60 @@ int pfn_is_nosave(unsigned long pfn)
 }
 
 
-#define MD5_DIGEST_SIZE 16
+#define CRC32_DIGEST_SIZE (sizeof (u32))
 
 struct restore_data_record {
 	unsigned long jump_address;
 	unsigned long jump_address_phys;
 	unsigned long cr3;
 	unsigned long magic;
-	u8 e820_digest[MD5_DIGEST_SIZE];
+	u8 e820_digest[CRC32_DIGEST_SIZE];
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
+static int get_e820_crc32(struct e820_table *table, void *buf)
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
+	int size = offsetof(struct e820_table, entries) +
+                sizeof(struct e820_entry) * table->nr_entries;
+	u32 ret;
 
-	size = offsetof(struct e820_table, entries) +
-		sizeof(struct e820_entry) * table->nr_entries;
-
-	if (crypto_shash_digest(desc, (u8 *)table, size, buf))
-		ret = -EINVAL;
-
-	kfree_sensitive(desc);
-
-free_tfm:
-	crypto_free_shash(tfm);
-	return ret;
+	ret = crc32_le(0, (unsigned char const *)table, size);
+	memset(buf, 0, CRC32_DIGEST_SIZE);
+	memcpy(buf, (char *)&ret, sizeof (ret));
+	return 0;
 }
 
 static int hibernation_e820_save(void *buf)
 {
-	return get_e820_md5(e820_table_firmware, buf);
+	return get_e820_crc32(e820_table_firmware, buf);
 }
 
 static bool hibernation_e820_mismatch(void *buf)
 {
 	int ret;
-	u8 result[MD5_DIGEST_SIZE];
+	u8 result[CRC32_DIGEST_SIZE];
 
-	memset(result, 0, MD5_DIGEST_SIZE);
+	memset(result, 0, CRC32_DIGEST_SIZE);
 	/* If there is no digest in suspend kernel, let it go. */
-	if (!memcmp(result, buf, MD5_DIGEST_SIZE))
+	if (!memcmp(result, buf, CRC32_DIGEST_SIZE))
 		return false;
 
-	ret = get_e820_md5(e820_table_firmware, result);
+	ret = get_e820_crc32(e820_table_firmware, result);
 	if (ret)
 		return true;
 
-	return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
+	return memcmp(result, buf, CRC32_DIGEST_SIZE) ? true : false;
 }
-#else
-static int hibernation_e820_save(void *buf)
-{
-	return 0;
-}
-
-static bool hibernation_e820_mismatch(void *buf)
-{
-	/* If md5 is not builtin for restore kernel, let it go. */
-	return false;
-}
-#endif
 
 #ifdef CONFIG_X86_64
-#define RESTORE_MAGIC	0x23456789ABCDEF01UL
+#define RESTORE_MAGIC	0x23456789ABCDEF02UL
 #else
-#define RESTORE_MAGIC	0x12345678UL
+#define RESTORE_MAGIC	0x12345679UL
 #endif
 
 /**
-- 
2.27.0

