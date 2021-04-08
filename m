Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2A13584FE
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDHNmy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 09:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231534AbhDHNmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 09:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617889363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hluTaeBylD8MCBrLOJT9DErDs0QQPijJ44zl/bE/8NU=;
        b=ZSJgG1WW5EWL+ozfsffagRalspUj/nKyA2JSqAPnP+QfY2tZ4TdbVfCLxPmuAsMJjpy4Xp
        KRD2eYTQDO+/+tNqza+SNrt1dvGRtyvPNAWy4+obTl5H9HhQZ/Vd7k7Qivb7SgCZIR6sO8
        eTWUplxeqR0QjSLalSpNm1l2UTL+wyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-SG8_s51tMWu8Ke3vt6_vmQ-1; Thu, 08 Apr 2021 09:42:41 -0400
X-MC-Unique: SG8_s51tMWu8Ke3vt6_vmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0C541922962;
        Thu,  8 Apr 2021 13:42:39 +0000 (UTC)
Received: from ovpn-113-96.phx2.redhat.com (ovpn-113-96.phx2.redhat.com [10.3.113.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8B7160BF1;
        Thu,  8 Apr 2021 13:42:38 +0000 (UTC)
Message-ID: <ffd040598f1a033354c0b0f213bdd84d999b6b42.camel@redhat.com>
Subject: Re: [PATCH v5 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
From:   Simo Sorce <simo@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chris von Recklinghausen <crecklin@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 08 Apr 2021 09:42:37 -0400
In-Reply-To: <CAJZ5v0ib+jmbsD9taGW0RujY5c9BCK8yLHv065u44mb0AwO9vQ@mail.gmail.com>
References: <20210408131506.17941-1-crecklin@redhat.com>
         <CAJZ5v0ib+jmbsD9taGW0RujY5c9BCK8yLHv065u44mb0AwO9vQ@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-04-08 at 15:32 +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 8, 2021 at 3:15 PM Chris von Recklinghausen
> <crecklin@redhat.com> wrote:
> > Suspend fails on a system in fips mode because md5 is used for the e820
> > integrity check and is not available. Use crc32 instead.
> > 
> > This patch changes the integrity check algorithm from md5 to
> > crc32. This integrity check is used only to verify accidental
> > corruption of the hybernation data
> 
> It isn't used for that.
> 
> In fact, it is used to detect differences between the memory map used
> before hibernation and the one made available by the BIOS during the
> subsequent resume.  And the check is there, because it is generally
> unsafe to load the hibernation image into memory if the current memory
> map doesn't match the one used when the image was created.
> 
> > and is not intended as a cryptographic integrity check.
> 
> But this is true nevertheless, so I would write:
> 
> "The purpose of the integrity check is to detect possible differences
> between the memory map used at the time when the hibernation image is
> about to be loaded into memory and the memory map used at the image
> creation time, because it is generally unsafe to load the image if the
> current memory map doesn't match the one used when it was created. so
> it is not intended as a cryptographic integrity check."
> 
> And please make the md5 spelling consistent.

This sounds much better thanks, feel free to add my Acked-by as well if
it is useful.

Simo.

> > Md5 is overkill in this case and also disabled in FIPS mode because it
> > is known to be broken for cryptographic purposes.
> > 
> > Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
> >        by md5 digest")
> > 
> > Tested-by: Dexuan Cui <decui@microsoft.com>
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
> > ---
> > v1 -> v2
> >    bump up RESTORE_MAGIC
> > v2 -> v3
> >    move embelishment from cover letter to commit comments (no code change)
> > v3 -> v4
> >    add note to comments that md5 isn't used for encryption here.
> > v4 -> v5
> >    reword comment per Simo's suggestion
> > 
> >  arch/x86/power/hibernate.c | 35 +++++++++++++++++++----------------
> >  1 file changed, 19 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> > index cd3914fc9f3d..b56172553275 100644
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
> > 
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
> > @@ -134,15 +134,15 @@ static int hibernation_e820_save(void *buf)
> > 
> >  static bool hibernation_e820_mismatch(void *buf)
> >  {
> > -       /* If md5 is not builtin for restore kernel, let it go. */
> > +       /* If crc32 is not builtin for restore kernel, let it go. */
> >         return false;
> >  }
> >  #endif
> > 
> >  #ifdef CONFIG_X86_64
> > -#define RESTORE_MAGIC  0x23456789ABCDEF01UL
> > +#define RESTORE_MAGIC  0x23456789ABCDEF02UL
> >  #else
> > -#define RESTORE_MAGIC  0x12345678UL
> > +#define RESTORE_MAGIC  0x12345679UL
> >  #endif
> > 
> >  /**
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

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




