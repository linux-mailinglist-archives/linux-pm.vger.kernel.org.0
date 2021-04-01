Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ABA351DF7
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhDASda (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239990AbhDAS0t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 14:26:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBCF56023C;
        Thu,  1 Apr 2021 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617301609;
        bh=XM/eKl64AYtF/NjYhxGawQinsb3OUrzVM5Yt/ORJnc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUfU1tk4s1agyreSXqTLRnrvXWc+nxCQOErH69opvfdFYdsoEWg3KkBNDPgCuFwkh
         kxFFooCipCdAUjy1yQZpJ+7ae23TJMUXguBCmTMUVmLeAT/pEpRP11mgNz1EFqrKbn
         MK2i5goUcObSnNYFwLi3t6fspZqfNL9gm7bdPZRtc4gMbVoknzIdAYBVPwlmz7eX0l
         EXBa5y9Bm1jZ/UAzVYQwGPwGtKCqtSGZ27mdjKa+DnJvqWwfdMESOo3thUAy5B32cT
         eMbzuDTT2IEU8qjxDnHspVTP5eaODb/RPTyebX5eL3oXIAzgZ5AN29QOqOoVA7RSEC
         3ALbNShPAU1dQ==
Date:   Thu, 1 Apr 2021 11:26:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Simo Sorce <simo@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fix hibernation in FIPS mode?
Message-ID: <YGYQZwRhpVkwVBjw@gmail.com>
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
 <4e95307db43e2f7cc8516e645b81db7db0dd8ad4.camel@redhat.com>
 <CAMj1kXHg2RDgwmOhJkaAPoWeHpxnd6tixp94Kha1-bzNvCaQUg@mail.gmail.com>
 <504652e70f0a4e42e4927583b9ed47cd78590329.camel@redhat.com>
 <CAMj1kXHRduBs0TJcLC4iMkyoGXyyrXPM_WpVVij33ki8THf9Kw@mail.gmail.com>
 <CAJZ5v0hKPBtUzGKfGHD6KX-c2QEETfatCkNjCK8ukh-AhVfUhA@mail.gmail.com>
 <2b452865-ca6c-892d-f04e-3e6e2a74b598@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b452865-ca6c-892d-f04e-3e6e2a74b598@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 01, 2021 at 09:54:21AM -0400, Chris von Recklinghausen wrote:
> On 4/1/21 9:38 AM, Rafael J. Wysocki wrote:
> > On Thu, Apr 1, 2021 at 10:47 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Tue, 30 Mar 2021 at 21:56, Simo Sorce <simo@redhat.com> wrote:
> > > > On Tue, 2021-03-30 at 21:45 +0200, Ard Biesheuvel wrote:
> > > > > On Tue, 30 Mar 2021 at 20:05, Simo Sorce <simo@redhat.com> wrote:
> > > > > > On Tue, 2021-03-30 at 16:46 +0200, Rafael J. Wysocki wrote:
> > > > > > > On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
> > > > > > > > Hi,
> > > > > > > > MD5 was marked incompliant with FIPS in 2009:
> > > > > > > > a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
> > > > > > > > a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
> > > > > > > > 
> > > > > > > > But hibernation_e820_save() is still using MD5, and fails in FIPS mode
> > > > > > > > due to the 2018 patch:
> > > > > > > > 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
> > > > > > > > 
> > > > > > > > As a result, hibernation doesn't work when FIPS is on.
> > > > > > > > 
> > > > > > > > Do you think if hibernation_e820_save() should be changed to use a
> > > > > > > > FIPS-compliant algorithm like SHA-1?
> > > > > > > I would say yes, it should.
> > > > > > > 
> > > > > > > > PS, currently it looks like FIPS mode is broken in the mainline:
> > > > > > > > https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html
> > > > > > FYI, SHA-1 is not a good choice, it is only permitted in HMAC
> > > > > > constructions and only for specified uses. If you need to change
> > > > > > algorithm you should go straight to SHA-2 or SHA-3 based hashes.
> > > > > > 
> > > > > What is the reason for using a [broken] cryptographic hash here? if
> > > > > this is just an integrity check, better use CRC32
> > Not really.
> > 
> > CRC32 is not really sufficient for integrity checking here AFAICS.  It
> > might be made a fallback option if MD5 is not available, but making it
> > the default would be somewhat over the top IMO.
> 
> 
> Would ghash be a better choice? It produces the same size digest as md5.
> 
> Does anyone have any other suggestions of algorithms to try?
> 
> Thanks,
> 
> Chris
> 
> > 
> > > > If the integrity check is used exclusively to verify there were no
> > > > accidental changes and is not used as a security measure, by all means
> > > > I agree that using crc32 is a better idea.
> > > > 
> > > Looking at 62a03defeabd58f74e07ca030d6c21e069d4d88e which introduced
> > > this, it is only a best effort check which is simply omitted if md5
> > > happens to be unavailable, so there is definitely no need for crypto
> > > here.
> > Yes, it is about integrity checking only.  No, CRC32 is not equivalent
> > to MD5 in that respect AFAICS.
> > 

If you need to detect intentional changes (ensure authenticity, not just
integrity) then you need a cryptographic MAC, such as HMAC-SHA256.

If you only need to detect accidental changes (ensure integrity-only), then a
checksum such as CRC-32 or xxHash64 is sufficient.  A cryptographic hash
function such as SHA-256 would also be sufficient, though much slower.  Using a
broken cryptographic hash function such as MD5 doesn't make sense because it is
broken (so doesn't actually provide cryptographic security), and is much slower
than a checksum.

If the 1 in 4 billion collision rate of a CRC-32 isn't sufficient, then use
CRC-64 or xxHash64 for a 1 in 2^64 collision rate.

Don't use GHASH, as it is neither a checksum nor a cryptographic hash function.

- Eric
