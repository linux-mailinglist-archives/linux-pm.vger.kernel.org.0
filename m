Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304CD3590B2
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 01:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhDHXzm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 19:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233009AbhDHXzm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 19:55:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1018861151;
        Thu,  8 Apr 2021 23:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617926130;
        bh=SUv1EmiHLV/4OjfzTusbiqGWcCkMUz2DyvyUUnJ+SZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiXVaVzfdo5Rr24r5RglJ24YvxSbVdSR9sUJMKrZNgIS5DA9xS7v9lUeDGp6SeG1P
         y4SWJnCy2xrKfe8M0sEyjIAgPZePczJVNorjOkijUz9h9FahY7iwPtcq5y8EWiJFlX
         DxHh/zmIhOd/GEfvrvvrfBu826zfgbBVRQAnlYDNZQD4M8zsGmJg00LKQiUyTWpahR
         q8oqYve83TKwtCYjHXIqxOJ2/VZFW2vswrEF3aSYC/nQLCCkLuw943eo28Bpp0BbuN
         zAy/6ORAIDY1L8DctfUMkLWcIa8AX7RtusWbAMPl0pXlIAb10NS/UnIbFbwY6E7fsQ
         2aX2RrxjLEToA==
Date:   Thu, 8 Apr 2021 16:55:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     ardb@kernel.org, simo@redhat.com, rafael@kernel.org,
        decui@microsoft.com, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YG+X8M6JfLY4cqmD@sol.localdomain>
References: <20210408131506.17941-1-crecklin@redhat.com>
 <YG8hgzBPQAvov9Vz@sol.localdomain>
 <f01021a0-2edd-da43-5f04-043b4f42be8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f01021a0-2edd-da43-5f04-043b4f42be8b@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 08, 2021 at 11:53:59AM -0400, Chris von Recklinghausen wrote:
> On 4/8/21 11:30 AM, Eric Biggers wrote:
> > On Thu, Apr 08, 2021 at 09:15:06AM -0400, Chris von Recklinghausen wrote:
> > > Suspend fails on a system in fips mode because md5 is used for the e820
> > > integrity check and is not available. Use crc32 instead.
> > > 
> > > This patch changes the integrity check algorithm from md5 to
> > > crc32. This integrity check is used only to verify accidental
> > > corruption of the hybernation data and is not intended as a
> > > cryptographic integrity check.
> > > Md5 is overkill in this case and also disabled in FIPS mode because it
> > > is known to be broken for cryptographic purposes.
> > > 
> > > Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
> > >         by md5 digest")
> > > 
> > > Tested-by: Dexuan Cui <decui@microsoft.com>
> > > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > > Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
> > > ---
> > > v1 -> v2
> > >     bump up RESTORE_MAGIC
> > > v2 -> v3
> > >     move embelishment from cover letter to commit comments (no code change)
> > > v3 -> v4
> > >     add note to comments that md5 isn't used for encryption here.
> > > v4 -> v5
> > >     reword comment per Simo's suggestion
> > > 
> > >   arch/x86/power/hibernate.c | 35 +++++++++++++++++++----------------
> > >   1 file changed, 19 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> > > index cd3914fc9f3d..b56172553275 100644
> > > --- a/arch/x86/power/hibernate.c
> > > +++ b/arch/x86/power/hibernate.c
> > > @@ -55,31 +55,31 @@ int pfn_is_nosave(unsigned long pfn)
> > >   }
> > > -#define MD5_DIGEST_SIZE 16
> > > +#define CRC32_DIGEST_SIZE 16
> > >   struct restore_data_record {
> > >   	unsigned long jump_address;
> > >   	unsigned long jump_address_phys;
> > >   	unsigned long cr3;
> > >   	unsigned long magic;
> > > -	u8 e820_digest[MD5_DIGEST_SIZE];
> > > +	u8 e820_digest[CRC32_DIGEST_SIZE];
> > >   };
> > > -#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
> > > +#if IS_BUILTIN(CONFIG_CRYPTO_CRC32)
> > Should CONFIG_CRYPTO_CRC32 be getting selected from somewhere?
> 
> 
> Yes, presumably from the same source that sets CONFIG_CRYPTO_MD5. Also
> presumably there's value to not forcing the check if the config value is not
> set.

I wouldn't be so sure about that.  It might just be a bug that CONFIG_CRYPTO_MD5
wasn't being selected.  Where is it documented that the user needed to set
CONFIG_CRYPTO_MD5=y if they wanted the hibernation image checksumming to work?

> > 
> > If that is too hard because it would pull in too much of the crypto API, maybe
> > using the library interface to CRC-32 (lib/crc32.c) would be a better fit?
> 
> 
> Based on my statement above, the intent is to provide a simple drop in
> replacement for md5 so that users of FIPS mode can suspend/resume without
> any errors.
> 

It's possible that most people have CONFIG_CRYPTO_MD5 enabled for some unrelated
reason so the hibernation image checksumming works by chance.
CONFIG_CRYPTO_CRC32 is a different option so the same is not necessarily true.

However, note that CONFIG_HIBERNATION already selects CONFIG_CRC32 (the library
interface to CRC-32) but not CONFIG_CRYPTO_CRC32 (shash interface to CRC-32).

So, if this code just used the library interface crc32_le(), it will always be
available and the IS_BUILTIN() checks can be removed...

- Eric
