Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62E2351877
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 19:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhDARpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 13:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234753AbhDARlD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 13:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617298863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:in-reply-to:in-reply-to:references:references;
        bh=N2tZyDHI8yuulr5oAhszdAg4BY1xZKCEFn3sL3MLBYo=;
        b=galdsy1+CdkhH9pYA81TjfWRJWxZbjYTR1sffoxnVgOEh4D+GVFc40FMAEFsjAkz9XI1xN
        xEVmfkYisY9NnHZHj8EnWkG7glh3g2ScA9jCDYn3w1lzwGZ2KbltfCAEyZVrHteHqdtGRH
        /41VWg6xLd+SKy+voPlwa1Ubxxt7mMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-862U-t2IMrOje033oNCdkA-1; Thu, 01 Apr 2021 08:25:11 -0400
X-MC-Unique: 862U-t2IMrOje033oNCdkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26D4E881283;
        Thu,  1 Apr 2021 12:25:10 +0000 (UTC)
Received: from crecklin.bos.com (unknown [10.22.8.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 656805C233;
        Thu,  1 Apr 2021 12:25:04 +0000 (UTC)
From:   Chris von Recklinghausen <crecklin@redhat.com>
To:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] use crc32 instead of md5 for hibernation e820 integrity check
Date:   Thu,  1 Apr 2021 08:24:58 -0400
Message-Id: <20210401122458.12663-2-crecklin@redhat.com>
In-Reply-To: <20210401122458.12663-1-crecklin@redhat.com>
References: <20210401122458.12663-1-crecklin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Suspend fails on a system in fips mode because md5 is used for the e820
integrity check and is not available. Use crc32 instead.

Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
       by md5 digest")
Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
---
 arch/x86/power/hibernate.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index cd3914fc9f3d..6a3f4e32e49c 100644
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
@@ -134,7 +134,7 @@ static int hibernation_e820_save(void *buf)
 
 static bool hibernation_e820_mismatch(void *buf)
 {
-	/* If md5 is not builtin for restore kernel, let it go. */
+	/* If crc32 is not builtin for restore kernel, let it go. */
 	return false;
 }
 #endif
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

