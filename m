Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F97B367140
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 19:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhDURYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 13:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244752AbhDURYc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 13:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619025817;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKVIGMoYHkPb1ZwaNURx+wIDmkDCqhZ+JE1+XfiIuO0=;
        b=B3VplnSVFiSVQXLZrBZY5OHJLqxgQqTFznD2XOV87GMq427chC5/fWlXmCIuh7lG4STzD2
        XS5TJm/icLOlIca/WI9JcxLB6kag2Wobii4+5WFp0E5Xt1Hjb/h/QlK2/vBQiT6n/7yZZL
        KfBEjUXkutQWtnbMP4ewkEm6Brd/MTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-kipzBvtsNJ2BMJDIIpjl4w-1; Wed, 21 Apr 2021 13:23:33 -0400
X-MC-Unique: kipzBvtsNJ2BMJDIIpjl4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51BE8801971;
        Wed, 21 Apr 2021 17:23:32 +0000 (UTC)
Received: from crecklin.bos.csb (ovpn-112-60.rdu2.redhat.com [10.10.112.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC6CD5D9F2;
        Wed, 21 Apr 2021 17:23:27 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH 1/1 v10] x86/power use crc32 instead of md5 for
 hibernation e820 integrity check
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Simo Sorce <simo@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210420125739.29353-1-crecklin@redhat.com>
 <CAJZ5v0hKbi1qmGtD4YAUBBkQX9FZTyb3KbityUkj4E1UsmW7Pw@mail.gmail.com>
From:   Chris von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <76c0d185-8b97-f68c-9fbc-76e4c3020048@redhat.com>
Date:   Wed, 21 Apr 2021 13:23:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hKbi1qmGtD4YAUBBkQX9FZTyb3KbityUkj4E1UsmW7Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/21/21 1:05 PM, Rafael J. Wysocki wrote:
> On Tue, Apr 20, 2021 at 3:00 PM Chris von Recklinghausen
> <crecklin@redhat.com> wrote:
>> Hibernation fails on a system in fips mode because md5 is used for the e820
>> integrity check and is not available. Use crc32 instead.
>>
>> The check is intended to detect whether the E820 memory map provided
>> by the firmware after cold boot unexpectedly differs from the one that
>> was in use when the hibernation image was created. In this case, the
>> hibernation image cannot be restored, as it may cover memory regions
>> that are no longer available to the OS.
>>
>> A non-cryptographic checksum such as CRC-32 is sufficient to detect such
>> inadvertent deviations.
>>
>> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map by md5 digest")
>>
>> Reviewed-by: Eric Biggers <ebiggers@google.com>
>> Tested-by: Dexuan Cui <decui@microsoft.com>
>> Reviewed-by: Dexuan Cui <decui@microsoft.com>
>>
>> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
>> ---
>> v1 -> v2
>>     bump up RESTORE_MAGIC
>> v2 -> v3
>>     move embelishment from cover letter to commit comments (no code change)
>> v3 -> v4
>>     add note to comments that md5 isn't used for encryption here.
>> v4 -> v5
>>     reword comment per Simo's suggestion
>> v5 -> v6
>>     use wording from Eric Biggers, use crc32_le instead of crc32 from crypto
>>          framework (crc32_le is in the core API and removes need for #defines)
>> v6 -> v7
>>     reword with input from Eric/Ard/Simo, code changed per Eric's feedback
>> v7 -> v8
>>     More feedback per Eric -
>>     change 'Suspend' to 'Hibernation' in commit comments, rename e820_digest to
>>     e820_checksum and change it to an unsigned long. rename get_e820_md5 to
>>     compute_e820_crc32 and have it return the checksum value instead of writing
>>     it into a user supplied buffer, get rid of hibernation_e820_save in favor of
>>     calling compute_e820_crc32 directly, likewise, get rid of
>>     hibernation_e820_mismatch in favor of comparing e820_checksum to the return
>>     value of compute_e820_crc32()
>> v8 -> v9
>>     Make comment for compute_e820_crc32 more kerneldoc friendly. Also update
>>     comment about the e820 firmware table in arch/x86/kernel/e820.c since it
>>     also referred to MD5 and hibernation.
>> v9 -> v10
>>     Don't line wrap Fixes: line, add Reviewed-by lines from Eric and Dexuan and
>>     Tested-by line from Dexuan. No code changed.
>>
>>   arch/x86/kernel/e820.c     |  4 +-
>>   arch/x86/power/hibernate.c | 89 ++++++--------------------------------
>>   2 files changed, 16 insertions(+), 77 deletions(-)
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index 22aad412f965..629c4994f165 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -31,8 +31,8 @@
>>    *       - inform the user about the firmware's notion of memory layout
>>    *         via /sys/firmware/memmap
>>    *
>> - *       - the hibernation code uses it to generate a kernel-independent MD5
>> - *         fingerprint of the physical memory layout of a system.
>> + *       - the hibernation code uses it to generate a kernel-independent CRC32
>> + *         checksum of the physical memory layout of a system.
>>    *
>>    * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
>>    *   passed to us by the bootloader - the major difference between
>> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
>> index cd3914fc9f3d..e94e0050a583 100644
>> --- a/arch/x86/power/hibernate.c
>> +++ b/arch/x86/power/hibernate.c
>> @@ -13,8 +13,8 @@
>>   #include <linux/kdebug.h>
>>   #include <linux/cpu.h>
>>   #include <linux/pgtable.h>
>> -
>> -#include <crypto/hash.h>
>> +#include <linux/types.h>
>> +#include <linux/crc32.h>
>>
>>   #include <asm/e820/api.h>
>>   #include <asm/init.h>
>> @@ -54,95 +54,33 @@ int pfn_is_nosave(unsigned long pfn)
>>          return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
>>   }
>>
>> -
>> -#define MD5_DIGEST_SIZE 16
>> -
>>   struct restore_data_record {
>>          unsigned long jump_address;
>>          unsigned long jump_address_phys;
>>          unsigned long cr3;
>>          unsigned long magic;
>> -       u8 e820_digest[MD5_DIGEST_SIZE];
>> +       unsigned long e820_checksum;
>>   };
>>
>> -#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
>>   /**
>> - * get_e820_md5 - calculate md5 according to given e820 table
>> + * compute_e820_crc32 - calculate crc32 of a given e820 table
>>    *
>>    * @table: the e820 table to be calculated
>> - * @buf: the md5 result to be stored to
>> + *
>> + * Return: the resulting checksum
>>    */
>> -static int get_e820_md5(struct e820_table *table, void *buf)
>> +static inline u32 compute_e820_crc32(struct e820_table *table)
>>   {
>> -       struct crypto_shash *tfm;
>> -       struct shash_desc *desc;
>> -       int size;
>> -       int ret = 0;
>> -
>> -       tfm = crypto_alloc_shash("md5", 0, 0);
>> -       if (IS_ERR(tfm))
>> -               return -ENOMEM;
>> -
>> -       desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
>> -                      GFP_KERNEL);
>> -       if (!desc) {
>> -               ret = -ENOMEM;
>> -               goto free_tfm;
>> -       }
>> -
>> -       desc->tfm = tfm;
>> -
>> -       size = offsetof(struct e820_table, entries) +
>> +       int size = offsetof(struct e820_table, entries) +
>>                  sizeof(struct e820_entry) * table->nr_entries;
>>
>> -       if (crypto_shash_digest(desc, (u8 *)table, size, buf))
>> -               ret = -EINVAL;
>> -
>> -       kfree_sensitive(desc);
>> -
>> -free_tfm:
>> -       crypto_free_shash(tfm);
>> -       return ret;
>> -}
>> -
>> -static int hibernation_e820_save(void *buf)
>> -{
>> -       return get_e820_md5(e820_table_firmware, buf);
>> -}
>> -
>> -static bool hibernation_e820_mismatch(void *buf)
>> -{
>> -       int ret;
>> -       u8 result[MD5_DIGEST_SIZE];
>> -
>> -       memset(result, 0, MD5_DIGEST_SIZE);
>> -       /* If there is no digest in suspend kernel, let it go. */
>> -       if (!memcmp(result, buf, MD5_DIGEST_SIZE))
>> -               return false;
>> -
>> -       ret = get_e820_md5(e820_table_firmware, result);
>> -       if (ret)
>> -               return true;
>> -
>> -       return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
>> -}
>> -#else
>> -static int hibernation_e820_save(void *buf)
>> -{
>> -       return 0;
>> -}
>> -
>> -static bool hibernation_e820_mismatch(void *buf)
>> -{
>> -       /* If md5 is not builtin for restore kernel, let it go. */
>> -       return false;
>> +       return ~crc32_le(~0, (unsigned char const *)table, size);
>>   }
>> -#endif
>>
>>   #ifdef CONFIG_X86_64
>> -#define RESTORE_MAGIC  0x23456789ABCDEF01UL
>> +#define RESTORE_MAGIC  0x23456789ABCDEF02UL
>>   #else
>> -#define RESTORE_MAGIC  0x12345678UL
>> +#define RESTORE_MAGIC  0x12345679UL
>>   #endif
>>
>>   /**
>> @@ -179,7 +117,8 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>>           */
>>          rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
>>
>> -       return hibernation_e820_save(rdr->e820_digest);
>> +       rdr->e820_checksum = compute_e820_crc32(e820_table_firmware);
>> +       return 0;
>>   }
>>
>>   /**
>> @@ -200,7 +139,7 @@ int arch_hibernation_header_restore(void *addr)
>>          jump_address_phys = rdr->jump_address_phys;
>>          restore_cr3 = rdr->cr3;
>>
>> -       if (hibernation_e820_mismatch(rdr->e820_digest)) {
>> +       if (rdr->e820_checksum != compute_e820_crc32(e820_table_firmware)) {
>>                  pr_crit("Hibernate inconsistent memory map detected!\n");
>>                  return -ENODEV;
>>          }
>> --
> Applied as 5.13 material under edited subject, thanks a lot to
> everyone involved!
>
...and thanks all for bearing with me on this.

Chris

