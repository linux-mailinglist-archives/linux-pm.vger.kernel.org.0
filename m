Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3B3518E9
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 19:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhDARsH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhDARoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 13:44:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78B0C08EADC;
        Thu,  1 Apr 2021 06:34:27 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id d12so1757865oiw.12;
        Thu, 01 Apr 2021 06:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FWGYGFl/q/RksH9elhWIRdaES8PRAXWHrFmVuENWB4=;
        b=GTeChfiMPnkoodzdhfPOUBirOBvRXjbbGdc2RJD655/vvvG9bStfPvTudLgj61H4Nj
         n9/p/NRWUxyS5Lw7F2Xml5rS1xXuV2sGik0PPGPtHvSpCpUhR/3GUFFHdRTgptmR12MX
         6K8jVM1RmAU2KS9kTMiTYP5kIJEUetMZWEUJKy3fqiIOG+ZVkKHJOWhXizTH3Abc+9PG
         uNioX+g7zUopb6Jf8OeNhc58yCNuD+atp0Khcwcz6Hty0fV4k5imRXeYMa8P6T6Wn63u
         FVbwK8uKOIWPPTTaHYPcdGbNgFzCP2v2hqtrN2d/FeDUlnQF57selQ4N0o/xpaqEwqW+
         33jg==
X-Gm-Message-State: AOAM531hrdZzrk0c71a/2AOzjrpy435C3qAM9sGLRY8xVOiDEtbHZZit
        dWNIvRZMh/fz7Yr6dDvgzSDCfNopOKtB+2miqOg=
X-Google-Smtp-Source: ABdhPJxy5cvNVArY7YtmFVwj2bftPEF9/Fi0jNClW4lM+qdCXnk+a0ThuQW3ynp5/rwcBik4xoJf8bq32A9F3IvNj3I=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr5776955oib.69.1617284067177;
 Thu, 01 Apr 2021 06:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210401122458.12663-1-crecklin@redhat.com> <20210401122458.12663-2-crecklin@redhat.com>
In-Reply-To: <20210401122458.12663-2-crecklin@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Apr 2021 15:34:13 +0200
Message-ID: <CAJZ5v0gCkhoKC_81WP6wdehZBYpEpmNhHwDygYawFdrWk3K6vg@mail.gmail.com>
Subject: Re: [PATCH 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, simo@redhat.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 1, 2021 at 2:25 PM Chris von Recklinghausen
<crecklin@redhat.com> wrote:
>
> Suspend fails on a system in fips mode because md5 is used for the e820
> integrity check and is not available. Use crc32 instead.
>
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
>        by md5 digest")
> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
> ---
>  arch/x86/power/hibernate.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index cd3914fc9f3d..6a3f4e32e49c 100644
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

No.

CRC32 was used here before and it was deemed insufficient.

Please find a different way to address this issue.

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
> @@ -134,7 +134,7 @@ static int hibernation_e820_save(void *buf)
>
>  static bool hibernation_e820_mismatch(void *buf)
>  {
> -       /* If md5 is not builtin for restore kernel, let it go. */
> +       /* If crc32 is not builtin for restore kernel, let it go. */
>         return false;
>  }
>  #endif
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
