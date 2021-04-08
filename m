Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801A2358108
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 12:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhDHKqu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 06:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhDHKqt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 06:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617878797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=STb3jemIR0oAseGZ4IZyjWqpuAar06/ylX4SI0DH0XM=;
        b=F98xxvgNkCNc09BcUlgdpP3RVhmcQN+PyZhnpArq3Oq+G+FrV3eCk5RmEQdLLkrUuibUZK
        qTZNKDOzXCP0oaLwOPKq9g/dVV+WwZiyWnLZ3XBPThDFlT+0Wq/+4OxBhVSUySe8LFIkDR
        fhpaNDHYlovp/BvdXXmrgftxvxKFYTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-1UrL5Wv3MrmZ4_OmNDd8vw-1; Thu, 08 Apr 2021 06:46:36 -0400
X-MC-Unique: 1UrL5Wv3MrmZ4_OmNDd8vw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F39781006701;
        Thu,  8 Apr 2021 10:46:34 +0000 (UTC)
Received: from crecklin.bos.com (ovpn-113-158.rdu2.redhat.com [10.10.113.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED50660C0F;
        Thu,  8 Apr 2021 10:46:30 +0000 (UTC)
From:   Chris von Recklinghausen <crecklin@redhat.com>
To:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] use crc32 instead of md5 for hibernation e820 integrity check
Date:   Thu,  8 Apr 2021 06:46:29 -0400
Message-Id: <20210408104629.31357-1-crecklin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Suspend fails on a system in fips mode because md5 is used for the e820
integrity check and is not available. Use crc32 instead.

Prior to this patch, MD5 is used only to create a digest to ensure integrity of
the region, no actual encryption is done. This patch set changes the integrity
check to use crc32 instead of md5 since crc32 is available in both FIPS and
non-FIPS modes.

Note that the digest is only used as an integrity check. No actual encryption
is done.

Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
       by md5 digest")

Tested-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
---
v1 -> v2
   bump up RESTORE_MAGIC
v2 -> v3
   move embelishment from cover letter to commit comments (no code change)
v3 -> v4
   add note to comments that md5 isn't used for encryption here.

 arch/x86/power/hibernate.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index cd3914fc9f3d..b56172553275 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -55,31 +55,31 @@ int pfn_is_nosave(unsigned long pfn)
 }
 
 
-#define MD5_DIGEST_SIZE 16
+#define CRC32_DIGEST_SIZE 16
 
 struct restore_data_record {
 	unsigned long jump_address;
 	unsigned long jump_address_phys;
 	unsigned long cr3;
 	unsigned long magic;
-	u8 e820_digest[MD5_DIGEST_SIZE];
+	u8 e820_digest[CRC32_DIGEST_SIZE];
 };
 
-#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
+#if IS_BUILTIN(CONFIG_CRYPTO_CRC32)
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
 	struct crypto_shash *tfm;
 	struct shash_desc *desc;
 	int size;
 	int ret = 0;
 
-	tfm = crypto_alloc_shash("md5", 0, 0);
+	tfm = crypto_alloc_shash("crc32", 0, 0);
 	if (IS_ERR(tfm))
 		return -ENOMEM;
 
@@ -107,24 +107,24 @@ static int get_e820_md5(struct e820_table *table, void *buf)
 
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
 #else
 static int hibernation_e820_save(void *buf)
@@ -134,15 +134,15 @@ static int hibernation_e820_save(void *buf)
 
 static bool hibernation_e820_mismatch(void *buf)
 {
-	/* If md5 is not builtin for restore kernel, let it go. */
+	/* If crc32 is not builtin for restore kernel, let it go. */
 	return false;
 }
 #endif
 
 #ifdef CONFIG_X86_64
-#define RESTORE_MAGIC	0x23456789ABCDEF01UL
+#define RESTORE_MAGIC	0x23456789ABCDEF02UL
 #else
-#define RESTORE_MAGIC	0x12345678UL
+#define RESTORE_MAGIC	0x12345679UL
 #endif
 
 /**
@@ -160,6 +160,9 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	rdr->jump_address = (unsigned long)restore_registers;
 	rdr->jump_address_phys = __pa_symbol(restore_registers);
 
+	/* crc32 digest size is 4 but digest buffer size is 16 so zero it all */
+	memset(rdr->e820_digest, 0, CRC32_DIGEST_SIZE);
+
 	/*
 	 * The restore code fixes up CR3 and CR4 in the following sequence:
 	 *
-- 
2.18.1

