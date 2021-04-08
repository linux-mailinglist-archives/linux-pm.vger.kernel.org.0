Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A05358869
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhDHPaY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 11:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhDHPaY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C927961108;
        Thu,  8 Apr 2021 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617895813;
        bh=ObSC29eEIMMYQErKHg+/HPZxQbS/5NvRx9UKVloQqZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKoN8GMHJU6D5ourC8Tj4kmhM+ANhLHVHkFY26bU6rNFfEQkfHfZ195bG7NveJi5W
         OqxLiP68H5znnvcagrwb19JWVDBdyI7Na7UJEbRByq+TveIgfayqnZMEXuNt+v+V+z
         Rf7bDUq2cUpr9RfvpSKR4LMCZCuqkCufhb7xNvtUGxEGP067tQwpT8dPf+f3ncgeiv
         AuY37KNIERk2uH3SAcGksjiWCi9JWKrBhVXvu9V4+igKSUtVgfOnnK+o/WWWvp7c9W
         AGNQzJVt7HKYjRRk/N+lPB1/lAJUKm9wBdQULenJp/1ZiB1lCtOc1E6W0FWbX18FG+
         6axkT+V5BGULg==
Date:   Thu, 8 Apr 2021 08:30:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YG8hgzBPQAvov9Vz@sol.localdomain>
References: <20210408131506.17941-1-crecklin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408131506.17941-1-crecklin@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 08, 2021 at 09:15:06AM -0400, Chris von Recklinghausen wrote:
> Suspend fails on a system in fips mode because md5 is used for the e820
> integrity check and is not available. Use crc32 instead.
> 
> This patch changes the integrity check algorithm from md5 to
> crc32. This integrity check is used only to verify accidental
> corruption of the hybernation data and is not intended as a
> cryptographic integrity check.
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
>  	unsigned long jump_address;
>  	unsigned long jump_address_phys;
>  	unsigned long cr3;
>  	unsigned long magic;
> -	u8 e820_digest[MD5_DIGEST_SIZE];
> +	u8 e820_digest[CRC32_DIGEST_SIZE];
>  };
>  
> -#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
> +#if IS_BUILTIN(CONFIG_CRYPTO_CRC32)

Should CONFIG_CRYPTO_CRC32 be getting selected from somewhere?

If that is too hard because it would pull in too much of the crypto API, maybe
using the library interface to CRC-32 (lib/crc32.c) would be a better fit?

- Eric
