Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85A335186D
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 19:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhDARpu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 13:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234604AbhDARiY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3884361165;
        Thu,  1 Apr 2021 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617285558;
        bh=47oSCm6wz3F6fLZ1XMnrJFATTDJ7ZR3krNCKwoLXG90=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kkynDdy5gPI90SI9CBruiqdlhvmOeggzosyGIgvY7cFTy+Jl7z3KYBxBGAl16CKuA
         QCiHmd+K369thuxMKTMzgFj3JDW3sWv75nYehUqJrDiTs1nEUQCd1TeYnpJFy7w69r
         dn4rllk1YzShI8aDlArZAlaisImgsvAB8KGO4t+Y5rJ6xAX72AZHyX0qAggqVWMQFM
         Ecj1letEH580OkN8tuaGcxBh7wPpks5UJJmOS24SpgumOfQMGLi9v3H4U8Op1v1wSw
         npXwGS3KJWoVECSJMx6DCQLVlGX1zxJpeOnT1qxH5vxUTKEkudUkXkrWfQVnn60ZCL
         HueKhXxmTX3ug==
Received: by mail-ot1-f48.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so2217957oto.2;
        Thu, 01 Apr 2021 06:59:18 -0700 (PDT)
X-Gm-Message-State: AOAM532Mhqikat5ngfBSPmpeVHV0wiyNh8dMz3DBc52c+X5IHfP5DrUr
        chIojgWRo4dJYcrTmbiYLosOU2OXm0yusZZfwew=
X-Google-Smtp-Source: ABdhPJyTWrS7cfq7+7xqSBSG5hvKv0zIAfBXdZdG9bSR1ftItk5kGAGFWyZ+y8kGd2BonZmoQ5Zir+jUlpgUrZ9fMBE=
X-Received: by 2002:a9d:12cb:: with SMTP id g69mr6823869otg.77.1617285557578;
 Thu, 01 Apr 2021 06:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210401122458.12663-1-crecklin@redhat.com> <20210401122458.12663-2-crecklin@redhat.com>
 <CAJZ5v0gCkhoKC_81WP6wdehZBYpEpmNhHwDygYawFdrWk3K6vg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gCkhoKC_81WP6wdehZBYpEpmNhHwDygYawFdrWk3K6vg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Apr 2021 15:59:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKRtB_YNGCKAGmRfvZTERCYJHR3hRdZ9-vyiRrB67rdg@mail.gmail.com>
Message-ID: <CAMj1kXFKRtB_YNGCKAGmRfvZTERCYJHR3hRdZ9-vyiRrB67rdg@mail.gmail.com>
Subject: Re: [PATCH 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        Simo Sorce <simo@redhat.com>, Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 1 Apr 2021 at 15:34, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 1, 2021 at 2:25 PM Chris von Recklinghausen
> <crecklin@redhat.com> wrote:
> >
> > Suspend fails on a system in fips mode because md5 is used for the e820
> > integrity check and is not available. Use crc32 instead.
> >
> > Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
> >        by md5 digest")
> > Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
> > ---
> >  arch/x86/power/hibernate.c | 31 +++++++++++++++++--------------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> > index cd3914fc9f3d..6a3f4e32e49c 100644
> > --- a/arch/x86/power/hibernate.c
> > +++ b/arch/x86/power/hibernate.c
> > @@ -55,31 +55,31 @@ int pfn_is_nosave(unsigned long pfn)
> >  }
> >
> >
> > -#define MD5_DIGEST_SIZE 16
> > +#define CRC32_DIGEST_SIZE 16
> >
> >  struct restore_data_record {
> >         unsigned long jump_address;
> >         unsigned long jump_address_phys;
> >         unsigned long cr3;
> >         unsigned long magic;
> > -       u8 e820_digest[MD5_DIGEST_SIZE];
> > +       u8 e820_digest[CRC32_DIGEST_SIZE];
> >  };
>
> No.
>
> CRC32 was used here before and it was deemed insufficient.
>

Why? The git commit log does not have an explanation of this.



> Please find a different way to address this issue.
>
> > -#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
> > +#if IS_BUILTIN(CONFIG_CRYPTO_CRC32)
> >  /**
> > - * get_e820_md5 - calculate md5 according to given e820 table
> > + * get_e820_crc32 - calculate crc32 according to given e820 table
> >   *
> >   * @table: the e820 table to be calculated
> > - * @buf: the md5 result to be stored to
> > + * @buf: the crc32 result to be stored to
> >   */
> > -static int get_e820_md5(struct e820_table *table, void *buf)
> > +static int get_e820_crc32(struct e820_table *table, void *buf)
> >  {
> >         struct crypto_shash *tfm;
> >         struct shash_desc *desc;
> >         int size;
> >         int ret = 0;
> >
> > -       tfm = crypto_alloc_shash("md5", 0, 0);
> > +       tfm = crypto_alloc_shash("crc32", 0, 0);
> >         if (IS_ERR(tfm))
> >                 return -ENOMEM;
> >
> > @@ -107,24 +107,24 @@ static int get_e820_md5(struct e820_table *table, void *buf)
> >
> >  static int hibernation_e820_save(void *buf)
> >  {
> > -       return get_e820_md5(e820_table_firmware, buf);
> > +       return get_e820_crc32(e820_table_firmware, buf);
> >  }
> >
> >  static bool hibernation_e820_mismatch(void *buf)
> >  {
> >         int ret;
> > -       u8 result[MD5_DIGEST_SIZE];
> > +       u8 result[CRC32_DIGEST_SIZE];
> >
> > -       memset(result, 0, MD5_DIGEST_SIZE);
> > +       memset(result, 0, CRC32_DIGEST_SIZE);
> >         /* If there is no digest in suspend kernel, let it go. */
> > -       if (!memcmp(result, buf, MD5_DIGEST_SIZE))
> > +       if (!memcmp(result, buf, CRC32_DIGEST_SIZE))
> >                 return false;
> >
> > -       ret = get_e820_md5(e820_table_firmware, result);
> > +       ret = get_e820_crc32(e820_table_firmware, result);
> >         if (ret)
> >                 return true;
> >
> > -       return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
> > +       return memcmp(result, buf, CRC32_DIGEST_SIZE) ? true : false;
> >  }
> >  #else
> >  static int hibernation_e820_save(void *buf)
> > @@ -134,7 +134,7 @@ static int hibernation_e820_save(void *buf)
> >
> >  static bool hibernation_e820_mismatch(void *buf)
> >  {
> > -       /* If md5 is not builtin for restore kernel, let it go. */
> > +       /* If crc32 is not builtin for restore kernel, let it go. */
> >         return false;
> >  }
> >  #endif
> > @@ -160,6 +160,9 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
> >         rdr->jump_address = (unsigned long)restore_registers;
> >         rdr->jump_address_phys = __pa_symbol(restore_registers);
> >
> > +       /* crc32 digest size is 4 but digest buffer size is 16 so zero it all */
> > +       memset(rdr->e820_digest, 0, CRC32_DIGEST_SIZE);
> > +
> >         /*
> >          * The restore code fixes up CR3 and CR4 in the following sequence:
> >          *
> > --
> > 2.18.1
> >
