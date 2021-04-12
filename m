Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167B935CFA5
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbhDLRpx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 13:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239032AbhDLRpw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Apr 2021 13:45:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EA2F61354;
        Mon, 12 Apr 2021 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618249534;
        bh=hjXOIbROE3wx3QWF7DGqV3HSLhGxUvo3LHE4nDAEZa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJr0jyHk7pflX0oLpJJgsdtYEo0c/0ApOWTY3jpy6MrOQUXgRWbDsV7xmAbJk22NF
         +aBV65BwNrdz53qBGGPUvAFnVespNYQ1hOKY4VRJqrL0Q0wrM7WIUsGtK0ILDmyuR3
         y1ZlMJ9U5qKwJAXzvZL3oVhzonUyYL11zzkQm2E4lHv2ir2UNkdDeY2BgdQeEkxvTx
         IW0EqOURG+F3Oe2bwk9O5gcURJi77kNEq03P2TvaBO6pVRZzM/J/9RSKsct5Fn73n4
         3p13J0i2KgfOrdIqiEm1zsdYcXUJmR/uAyna3XznChoLgCk305sMS/y74B9/JBaHyG
         QN/UQdZshqwHg==
Date:   Mon, 12 Apr 2021 10:45:32 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YHSHPIXLhHjOu0jw@gmail.com>
References: <20210412140932.31162-1-crecklin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412140932.31162-1-crecklin@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 12, 2021 at 10:09:32AM -0400, Chris von Recklinghausen wrote:
> Suspend fails on a system in fips mode because md5 is used for the e820
> integrity check and is not available. Use crc32 instead.
> 
> This patch changes the integrity check algorithm from md5 to crc32.
> 
> The purpose of the integrity check is to detect possible differences
> between the memory map used at the time when the hibernation image is
> about to be loaded into memory and the memory map used at the image
> creation time, because it is generally unsafe to load the image if the
> current memory map doesn't match the one used when it was created. so
> it is not intended as a cryptographic integrity check.

This still doesn't actually explain why a non-cryptographic checksum is
sufficient.  "Detection of possible differences" could very well require
cryptographic authentication; it depends on whether malicious changes need to be
detected or not.

> 
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
>        by md5 digest")
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
> 	framework (crc32_le is in the core API and removes need for #defines)
> 
>  arch/x86/power/hibernate.c | 76 +++++++++++---------------------------
>  1 file changed, 22 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index cd3914fc9f3d..f39e507e34ca 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -13,6 +13,8 @@
>  #include <linux/kdebug.h>
>  #include <linux/cpu.h>
>  #include <linux/pgtable.h>
> +#include <linux/types.h>
> +#include <linux/crc32.h>
>  
>  #include <crypto/hash.h>

crypto/hash.h is no longer needed.

>  
> @@ -55,94 +57,60 @@ int pfn_is_nosave(unsigned long pfn)
>  }
>  
>  
> -#define MD5_DIGEST_SIZE 16
> +#define CRC32_DIGEST_SIZE (sizeof (u32))
>  
>  struct restore_data_record {
>  	unsigned long jump_address;
>  	unsigned long jump_address_phys;
>  	unsigned long cr3;
>  	unsigned long magic;
> -	u8 e820_digest[MD5_DIGEST_SIZE];
> +	u8 e820_digest[CRC32_DIGEST_SIZE];
>  };

It would be simpler to just make this field 'unsigned long'.  Then there would
be no need to deal with memcpy().

> -#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
>  /**
> - * get_e820_md5 - calculate md5 according to given e820 table
> + * get_e820_crc32 - calculate crc32 according to given e820 table

Calling this "compute_e820_crc32()" would avoid confusion with retrieving the
previously-stored crc32 value.

> +	ret = crc32_le(0, (unsigned char const *)table, size);

It would be better to do ~crc32_le(~0, ...) (i.e., invert at beginning and end)
to match the recommended usage of CRC-32.  Unfortunately the library function
doesn't do the inversions by default.

>  static int hibernation_e820_save(void *buf)
>  {
> -	return get_e820_md5(e820_table_firmware, buf);
> +	return get_e820_crc32(e820_table_firmware, buf);
>  }

This should be inlined into arch_hibernation_header_save().  Also note that it
can no longer fail.

>  
>  static bool hibernation_e820_mismatch(void *buf)
>  {

This should be inlined into arch_hibernation_header_restore().

>  	int ret;
> -	u8 result[MD5_DIGEST_SIZE];
> +	u8 result[CRC32_DIGEST_SIZE];
>  
> -	memset(result, 0, MD5_DIGEST_SIZE);
> +	memset(result, 0, CRC32_DIGEST_SIZE);
>  	/* If there is no digest in suspend kernel, let it go. */
> -	if (!memcmp(result, buf, MD5_DIGEST_SIZE))
> +	if (!memcmp(result, buf, CRC32_DIGEST_SIZE))
>  		return false;

There's no need to handle the "no digest" case anymore, right?  Since crc32_le()
is always available.

- Eric
