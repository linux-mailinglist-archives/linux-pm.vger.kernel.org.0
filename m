Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04FC3670E4
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 19:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244606AbhDURGg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 13:06:36 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41557 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244596AbhDURGb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 13:06:31 -0400
Received: by mail-ot1-f41.google.com with SMTP id v19-20020a0568300913b029028423b78c2dso30927674ott.8;
        Wed, 21 Apr 2021 10:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsDWAsLLfUtjbqjtHu6nAv3JUs01/2OwwaMFeL9gHnM=;
        b=XUdCG08ydCUetKPyatJ8nxnzExmWLUYxXT+64HEJT1AlkIrox4q/lMIT2s61h/gzbh
         CfQWM13RBUwJLpxhhS0io+ZusOir7yuqH6WDuT8GkLmpmgVVOUbTUONrqn4wpmxXN8eA
         +pRvMI76zvjcwGpgXEGDL5W9E6qQknkw9VTRl4X60krv+Pi37lm9+6GiZPI8jfhrzzhC
         oO+6jEZNwwuu4a6kQokJi8CxLjW8NhHYqX51QEwz7wXltS7KSAbq40fcUrVE3dwBG4XJ
         HY4cnWvQtccTeiSXKcpt0F6RG7hjokGbtkrtGCalMCpo1R/EsQS/rrDl0pFpB3yfQtqo
         +n1A==
X-Gm-Message-State: AOAM5324wwg0+5/a2fHVsZ10lLUoHy8xJmH09O0y6BxUJcS5MiIjN1kh
        mW/Kv8fS3K7xph6bS4Xx6S3O1lYTxPFeacKpte4=
X-Google-Smtp-Source: ABdhPJxODUbrFvWWlxhNXDqo0FDjzznas5ykswVpgTi7zEHI9pUhoaKlhmmFq8q5LpogZciGJaCtu2j/O8JHA8arhlc=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr23511627otb.260.1619024757549;
 Wed, 21 Apr 2021 10:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210420125739.29353-1-crecklin@redhat.com>
In-Reply-To: <20210420125739.29353-1-crecklin@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Apr 2021 19:05:46 +0200
Message-ID: <CAJZ5v0hKbi1qmGtD4YAUBBkQX9FZTyb3KbityUkj4E1UsmW7Pw@mail.gmail.com>
Subject: Re: [PATCH 1/1 v10] x86/power use crc32 instead of md5 for
 hibernation e820 integrity check
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Simo Sorce <simo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 20, 2021 at 3:00 PM Chris von Recklinghausen
<crecklin@redhat.com> wrote:
>
> Hibernation fails on a system in fips mode because md5 is used for the e820
> integrity check and is not available. Use crc32 instead.
>
> The check is intended to detect whether the E820 memory map provided
> by the firmware after cold boot unexpectedly differs from the one that
> was in use when the hibernation image was created. In this case, the
> hibernation image cannot be restored, as it may cover memory regions
> that are no longer available to the OS.
>
> A non-cryptographic checksum such as CRC-32 is sufficient to detect such
> inadvertent deviations.
>
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map by md5 digest")
>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Tested-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
>
> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
> ---
> v1 -> v2
>    bump up RESTORE_MAGIC
> v2 -> v3
>    move embelishment from cover letter to commit comments (no code change)
> v3 -> v4
>    add note to comments that md5 isn't used for encryption here.
> v4 -> v5
>    reword comment per Simo's suggestion
> v5 -> v6
>    use wording from Eric Biggers, use crc32_le instead of crc32 from crypto
>         framework (crc32_le is in the core API and removes need for #defines)
> v6 -> v7
>    reword with input from Eric/Ard/Simo, code changed per Eric's feedback
> v7 -> v8
>    More feedback per Eric -
>    change 'Suspend' to 'Hibernation' in commit comments, rename e820_digest to
>    e820_checksum and change it to an unsigned long. rename get_e820_md5 to
>    compute_e820_crc32 and have it return the checksum value instead of writing
>    it into a user supplied buffer, get rid of hibernation_e820_save in favor of
>    calling compute_e820_crc32 directly, likewise, get rid of
>    hibernation_e820_mismatch in favor of comparing e820_checksum to the return
>    value of compute_e820_crc32()
> v8 -> v9
>    Make comment for compute_e820_crc32 more kerneldoc friendly. Also update
>    comment about the e820 firmware table in arch/x86/kernel/e820.c since it
>    also referred to MD5 and hibernation.
> v9 -> v10
>    Don't line wrap Fixes: line, add Reviewed-by lines from Eric and Dexuan and
>    Tested-by line from Dexuan. No code changed.
>
>  arch/x86/kernel/e820.c     |  4 +-
>  arch/x86/power/hibernate.c | 89 ++++++--------------------------------
>  2 files changed, 16 insertions(+), 77 deletions(-)
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 22aad412f965..629c4994f165 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -31,8 +31,8 @@
>   *       - inform the user about the firmware's notion of memory layout
>   *         via /sys/firmware/memmap
>   *
> - *       - the hibernation code uses it to generate a kernel-independent MD5
> - *         fingerprint of the physical memory layout of a system.
> + *       - the hibernation code uses it to generate a kernel-independent CRC32
> + *         checksum of the physical memory layout of a system.
>   *
>   * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
>   *   passed to us by the bootloader - the major difference between
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index cd3914fc9f3d..e94e0050a583 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -13,8 +13,8 @@
>  #include <linux/kdebug.h>
>  #include <linux/cpu.h>
>  #include <linux/pgtable.h>
> -
> -#include <crypto/hash.h>
> +#include <linux/types.h>
> +#include <linux/crc32.h>
>
>  #include <asm/e820/api.h>
>  #include <asm/init.h>
> @@ -54,95 +54,33 @@ int pfn_is_nosave(unsigned long pfn)
>         return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
>  }
>
> -
> -#define MD5_DIGEST_SIZE 16
> -
>  struct restore_data_record {
>         unsigned long jump_address;
>         unsigned long jump_address_phys;
>         unsigned long cr3;
>         unsigned long magic;
> -       u8 e820_digest[MD5_DIGEST_SIZE];
> +       unsigned long e820_checksum;
>  };
>
> -#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
>  /**
> - * get_e820_md5 - calculate md5 according to given e820 table
> + * compute_e820_crc32 - calculate crc32 of a given e820 table
>   *
>   * @table: the e820 table to be calculated
> - * @buf: the md5 result to be stored to
> + *
> + * Return: the resulting checksum
>   */
> -static int get_e820_md5(struct e820_table *table, void *buf)
> +static inline u32 compute_e820_crc32(struct e820_table *table)
>  {
> -       struct crypto_shash *tfm;
> -       struct shash_desc *desc;
> -       int size;
> -       int ret = 0;
> -
> -       tfm = crypto_alloc_shash("md5", 0, 0);
> -       if (IS_ERR(tfm))
> -               return -ENOMEM;
> -
> -       desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
> -                      GFP_KERNEL);
> -       if (!desc) {
> -               ret = -ENOMEM;
> -               goto free_tfm;
> -       }
> -
> -       desc->tfm = tfm;
> -
> -       size = offsetof(struct e820_table, entries) +
> +       int size = offsetof(struct e820_table, entries) +
>                 sizeof(struct e820_entry) * table->nr_entries;
>
> -       if (crypto_shash_digest(desc, (u8 *)table, size, buf))
> -               ret = -EINVAL;
> -
> -       kfree_sensitive(desc);
> -
> -free_tfm:
> -       crypto_free_shash(tfm);
> -       return ret;
> -}
> -
> -static int hibernation_e820_save(void *buf)
> -{
> -       return get_e820_md5(e820_table_firmware, buf);
> -}
> -
> -static bool hibernation_e820_mismatch(void *buf)
> -{
> -       int ret;
> -       u8 result[MD5_DIGEST_SIZE];
> -
> -       memset(result, 0, MD5_DIGEST_SIZE);
> -       /* If there is no digest in suspend kernel, let it go. */
> -       if (!memcmp(result, buf, MD5_DIGEST_SIZE))
> -               return false;
> -
> -       ret = get_e820_md5(e820_table_firmware, result);
> -       if (ret)
> -               return true;
> -
> -       return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
> -}
> -#else
> -static int hibernation_e820_save(void *buf)
> -{
> -       return 0;
> -}
> -
> -static bool hibernation_e820_mismatch(void *buf)
> -{
> -       /* If md5 is not builtin for restore kernel, let it go. */
> -       return false;
> +       return ~crc32_le(~0, (unsigned char const *)table, size);
>  }
> -#endif
>
>  #ifdef CONFIG_X86_64
> -#define RESTORE_MAGIC  0x23456789ABCDEF01UL
> +#define RESTORE_MAGIC  0x23456789ABCDEF02UL
>  #else
> -#define RESTORE_MAGIC  0x12345678UL
> +#define RESTORE_MAGIC  0x12345679UL
>  #endif
>
>  /**
> @@ -179,7 +117,8 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>          */
>         rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
>
> -       return hibernation_e820_save(rdr->e820_digest);
> +       rdr->e820_checksum = compute_e820_crc32(e820_table_firmware);
> +       return 0;
>  }
>
>  /**
> @@ -200,7 +139,7 @@ int arch_hibernation_header_restore(void *addr)
>         jump_address_phys = rdr->jump_address_phys;
>         restore_cr3 = rdr->cr3;
>
> -       if (hibernation_e820_mismatch(rdr->e820_digest)) {
> +       if (rdr->e820_checksum != compute_e820_crc32(e820_table_firmware)) {
>                 pr_crit("Hibernate inconsistent memory map detected!\n");
>                 return -ENODEV;
>         }
> --

Applied as 5.13 material under edited subject, thanks a lot to
everyone involved!
