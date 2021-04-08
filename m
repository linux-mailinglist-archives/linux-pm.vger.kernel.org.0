Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903EF3584C7
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 15:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhDHNdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 09:33:01 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:40625 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHNdB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 09:33:01 -0400
Received: by mail-oi1-f173.google.com with SMTP id i3so2157555oik.7;
        Thu, 08 Apr 2021 06:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2KTccs1r6KMsvyGcpnk1L1c3mlfhar8+1tFvFGH2Bk=;
        b=s207iClIaM3DPQx2AXMB+PdCCYkyEQ0fEqRziuS3kfGVANYHuNGn9xbB6ttUmXf6sr
         SVDYD+jqvi6UoYvwEXJ6AtGAqRueDHs5Ny89XVga6jT2fSIiJzfDeb4Cm+quZ3uLzIif
         CDM30jDCqGUaLQZM460q/T1ix3+oHrxwnhf18iXyZ11oryfJVWvT1fjz8q3hyg5j/Iwh
         3ANUJGTXkxXpsYYK3CLyWfXj5YbFAE5ascZvP+L0gBpuCHv7TrSysPR3yZO6rtJZlpxt
         qlmoTZ22bKBT3YHW0HzDQFcr3MF7QCtlkYp8cDJ2vq7MyD6fUXt1qJ7UJO988s0tQ1we
         8kSA==
X-Gm-Message-State: AOAM531hzV7WjRMTFtmN5Au+WDYgvJY1cztcfJJ+H+1ycHyG2Mgz3lHg
        XcMKNqP7G+VPb2zbwfAQ4BdTzdhV06ZTQZ1s97Q=
X-Google-Smtp-Source: ABdhPJyQZca/x8aLTqJMzIHWHEJGBaZiyW5sloy1tvzcgYkCSQ6+hWE4gDoWh0C0Z/dCix6YFVB+Y2Flpz1PdU21trI=
X-Received: by 2002:aca:c4c5:: with SMTP id u188mr6169855oif.71.1617888769728;
 Thu, 08 Apr 2021 06:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210408131506.17941-1-crecklin@redhat.com>
In-Reply-To: <20210408131506.17941-1-crecklin@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 15:32:38 +0200
Message-ID: <CAJZ5v0ib+jmbsD9taGW0RujY5c9BCK8yLHv065u44mb0AwO9vQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Simo Sorce <simo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 8, 2021 at 3:15 PM Chris von Recklinghausen
<crecklin@redhat.com> wrote:
>
> Suspend fails on a system in fips mode because md5 is used for the e820
> integrity check and is not available. Use crc32 instead.
>
> This patch changes the integrity check algorithm from md5 to
> crc32. This integrity check is used only to verify accidental
> corruption of the hybernation data

It isn't used for that.

In fact, it is used to detect differences between the memory map used
before hibernation and the one made available by the BIOS during the
subsequent resume.  And the check is there, because it is generally
unsafe to load the hibernation image into memory if the current memory
map doesn't match the one used when the image was created.

> and is not intended as a cryptographic integrity check.

But this is true nevertheless, so I would write:

"The purpose of the integrity check is to detect possible differences
between the memory map used at the time when the hibernation image is
about to be loaded into memory and the memory map used at the image
creation time, because it is generally unsafe to load the image if the
current memory map doesn't match the one used when it was created. so
it is not intended as a cryptographic integrity check."

And please make the md5 spelling consistent.

> Md5 is overkill in this case and also disabled in FIPS mode because it
> is known to be broken for cryptographic purposes.
>
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
>        by md5 digest")
>
> Tested-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
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
>
>  arch/x86/power/hibernate.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index cd3914fc9f3d..b56172553275 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -55,31 +55,31 @@ int pfn_is_nosave(unsigned long pfn)
>  }
>
>
> -#define MD5_DIGEST_SIZE 16
> +#define CRC32_DIGEST_SIZE 16
>
>  struct restore_data_record {
>         unsigned long jump_address;
>         unsigned long jump_address_phys;
>         unsigned long cr3;
>         unsigned long magic;
> -       u8 e820_digest[MD5_DIGEST_SIZE];
> +       u8 e820_digest[CRC32_DIGEST_SIZE];
>  };
>
> -#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
> +#if IS_BUILTIN(CONFIG_CRYPTO_CRC32)
>  /**
> - * get_e820_md5 - calculate md5 according to given e820 table
> + * get_e820_crc32 - calculate crc32 according to given e820 table
>   *
>   * @table: the e820 table to be calculated
> - * @buf: the md5 result to be stored to
> + * @buf: the crc32 result to be stored to
>   */
> -static int get_e820_md5(struct e820_table *table, void *buf)
> +static int get_e820_crc32(struct e820_table *table, void *buf)
>  {
>         struct crypto_shash *tfm;
>         struct shash_desc *desc;
>         int size;
>         int ret = 0;
>
> -       tfm = crypto_alloc_shash("md5", 0, 0);
> +       tfm = crypto_alloc_shash("crc32", 0, 0);
>         if (IS_ERR(tfm))
>                 return -ENOMEM;
>
> @@ -107,24 +107,24 @@ static int get_e820_md5(struct e820_table *table, void *buf)
>
>  static int hibernation_e820_save(void *buf)
>  {
> -       return get_e820_md5(e820_table_firmware, buf);
> +       return get_e820_crc32(e820_table_firmware, buf);
>  }
>
>  static bool hibernation_e820_mismatch(void *buf)
>  {
>         int ret;
> -       u8 result[MD5_DIGEST_SIZE];
> +       u8 result[CRC32_DIGEST_SIZE];
>
> -       memset(result, 0, MD5_DIGEST_SIZE);
> +       memset(result, 0, CRC32_DIGEST_SIZE);
>         /* If there is no digest in suspend kernel, let it go. */
> -       if (!memcmp(result, buf, MD5_DIGEST_SIZE))
> +       if (!memcmp(result, buf, CRC32_DIGEST_SIZE))
>                 return false;
>
> -       ret = get_e820_md5(e820_table_firmware, result);
> +       ret = get_e820_crc32(e820_table_firmware, result);
>         if (ret)
>                 return true;
>
> -       return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
> +       return memcmp(result, buf, CRC32_DIGEST_SIZE) ? true : false;
>  }
>  #else
>  static int hibernation_e820_save(void *buf)
> @@ -134,15 +134,15 @@ static int hibernation_e820_save(void *buf)
>
>  static bool hibernation_e820_mismatch(void *buf)
>  {
> -       /* If md5 is not builtin for restore kernel, let it go. */
> +       /* If crc32 is not builtin for restore kernel, let it go. */
>         return false;
>  }
>  #endif
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
> @@ -160,6 +160,9 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>         rdr->jump_address = (unsigned long)restore_registers;
>         rdr->jump_address_phys = __pa_symbol(restore_registers);
>
> +       /* crc32 digest size is 4 but digest buffer size is 16 so zero it all */
> +       memset(rdr->e820_digest, 0, CRC32_DIGEST_SIZE);
> +
>         /*
>          * The restore code fixes up CR3 and CR4 in the following sequence:
>          *
> --
> 2.18.1
>
