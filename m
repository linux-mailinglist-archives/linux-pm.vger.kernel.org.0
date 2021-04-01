Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7D351ECF
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhDASrG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238975AbhDASpE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 14:45:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81EF461006;
        Thu,  1 Apr 2021 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617302588;
        bh=gPMdy3d4CLHzKWzfd7ezMz440irTyvpHOZ8nXWr+MbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhAOqSK+iKAH6Jy26UnFwYDMYsX8UjoW2i5Az4epG4PKe/d8+W6zTUhGrNFbCT9Z/
         A14SNnLScohYBEfGUbHaRwYyXdXjGbWUm2k9yQBbd7gLhD1lVg85rYjtmrDjnkShaE
         XChaJLEjnW5ET2qqbx2ZnAImyAATpBBY8343uTqg0VZTqgRi/Kz4/U9NFc9GWRIhEH
         qKde8gmVL0HefCwwhjxYIbdKzsj5/uh1wCIHhZZhpCCC/hA6dmsmR/zKwK/feE6Fec
         KzA2RsRxECMAk8fk+bhqtPUMowUrNFh14pmNsdf5BSYTJKHSPGiaNIC7S9pa+BV1lx
         c99J8lft+HQaQ==
Date:   Thu, 1 Apr 2021 11:43:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Simo Sorce <simo@redhat.com>, Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YGYUO077mjFaiJ0G@gmail.com>
References: <20210401122458.12663-1-crecklin@redhat.com>
 <20210401122458.12663-2-crecklin@redhat.com>
 <CAJZ5v0gCkhoKC_81WP6wdehZBYpEpmNhHwDygYawFdrWk3K6vg@mail.gmail.com>
 <CAMj1kXFKRtB_YNGCKAGmRfvZTERCYJHR3hRdZ9-vyiRrB67rdg@mail.gmail.com>
 <CAJZ5v0iqB7h1i_wuHTHTV-cvX+uQsbuae8W7wcFS8QffitD4aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iqB7h1i_wuHTHTV-cvX+uQsbuae8W7wcFS8QffitD4aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 01, 2021 at 06:19:57PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 1, 2021 at 3:59 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 1 Apr 2021 at 15:34, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Apr 1, 2021 at 2:25 PM Chris von Recklinghausen
> > > <crecklin@redhat.com> wrote:
> > > >
> > > > Suspend fails on a system in fips mode because md5 is used for the e820
> > > > integrity check and is not available. Use crc32 instead.
> > > >
> > > > Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map
> > > >        by md5 digest")
> > > > Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
> > > > ---
> > > >  arch/x86/power/hibernate.c | 31 +++++++++++++++++--------------
> > > >  1 file changed, 17 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> > > > index cd3914fc9f3d..6a3f4e32e49c 100644
> > > > --- a/arch/x86/power/hibernate.c
> > > > +++ b/arch/x86/power/hibernate.c
> > > > @@ -55,31 +55,31 @@ int pfn_is_nosave(unsigned long pfn)
> > > >  }
> > > >
> > > >
> > > > -#define MD5_DIGEST_SIZE 16
> > > > +#define CRC32_DIGEST_SIZE 16
> > > >
> > > >  struct restore_data_record {
> > > >         unsigned long jump_address;
> > > >         unsigned long jump_address_phys;
> > > >         unsigned long cr3;
> > > >         unsigned long magic;
> > > > -       u8 e820_digest[MD5_DIGEST_SIZE];
> > > > +       u8 e820_digest[CRC32_DIGEST_SIZE];
> > > >  };
> > >
> > > No.
> > >
> > > CRC32 was used here before and it was deemed insufficient.
> > >
> >
> > Why? The git commit log does not have an explanation of this.
> 
> IIRC there was an example of a memory map that would produce the same
> CRC32 value as the original or something like that.

Collisions can easily be found for MD5 as well, as it is heavily broken.

Either you need a cryptographic hash function, *or* a (non-cryptographic)
checksum would be sufficient.  There isn't really any in-between.

And if a checksum suffices, MD5 is a bad choice because it was designed as a
cryptographic hash function, so it is much slower than a checksum.

> 
> But that said this code is all about failing more gracefully, so I
> guess it isn't a big deal if the failure is more graceful in fewer
> cases ...

If the 1 in 2^32 chance of a CRC-32 collision is too high, then use CRC-64 or
xxHash64 for a 1 in 2^64 chance of a collision.

- Eric
