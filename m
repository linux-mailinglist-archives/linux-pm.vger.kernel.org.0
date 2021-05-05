Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431E63733F7
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 05:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhEEDqj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 23:46:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhEEDqi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 May 2021 23:46:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB7526112F;
        Wed,  5 May 2021 03:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620186343;
        bh=R/JyAKDyJKGKvvQXuafoRRyXBimPMKueTQ6KKgAKfww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGmV119In9JTgyt66QPQey4xSOUN9ETJKt3aUfFPmf5mBZha78nVjwmOZSingGZha
         bU9FPN1fKrFz7WemS0arBiEx3RZstPdpSLsnovX3p8CenjO+JKlwJT4VOne3Z6cyuS
         axOUJqdK1vjQTWGEhIKgwJGoVo7xDssJoFIKQxM7bZK8O0oStov4B3foK/i1jBVcmh
         hYVmmzXegpD3wTxNDkcYdfDE+C0kkOP3OnQDNg7QMU82FzsH5x14fHzcPAmvd2MIPr
         c05BBd0xm9gzpeOd9VDOr7c0dyk4Dp+Y7QT5bbP+V502O7buNx++7zX55U8OyMyS88
         urCvI/cSjB9lw==
Date:   Tue, 4 May 2021 20:45:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, Simo Sorce <simo@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <YJIU5fd5e2FwrEB/@gmail.com>
References: <20210408131506.17941-1-crecklin@redhat.com>
 <CAJZ5v0ib+jmbsD9taGW0RujY5c9BCK8yLHv065u44mb0AwO9vQ@mail.gmail.com>
 <YG8gqZoZGutPmROz@sol.localdomain>
 <CAJZ5v0g65irXKmy7pdgD8-5KWrxdtwiWbJsBD2A=PKf1D3RVZg@mail.gmail.com>
 <20210429195944.GB1067@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429195944.GB1067@bug>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 29, 2021 at 09:59:44PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > Suspend fails on a system in fips mode because md5 is used for the e820
> > > > > integrity check and is not available. Use crc32 instead.
> > > > >
> > > > > This patch changes the integrity check algorithm from md5 to
> > > > > crc32. This integrity check is used only to verify accidental
> > > > > corruption of the hybernation data
> > > >
> > > > It isn't used for that.
> > > >
> > > > In fact, it is used to detect differences between the memory map used
> > > > before hibernation and the one made available by the BIOS during the
> > > > subsequent resume.  And the check is there, because it is generally
> > > > unsafe to load the hibernation image into memory if the current memory
> > > > map doesn't match the one used when the image was created.
> > >
> > > So what types of "differences" are you trying to detect?  If you need to detect
> > > differences caused by someone who maliciously made changes ("malicious" implies
> > > they may try to avoid detection), then you need to use a cryptographic hash
> > > function (or a cryptographic MAC if the hash value isn't stored separately).  If
> > > you only need to detect non-malicious changes (normally these would be called
> > > "accidental" changes, but sure, it could be changes that are "intentionally"
> > > made provided that the other side can be trusted to not try to avoid
> > > detection...)
> > 
> > That's the case here.
> 
> md5 is fine for this purpose. crc32 may be too weak. I don't see why this needs changing.
> 
> Maybe fips should understand that md5 has other uses than crypto?
> 
> Best regards,
> 									Pavel

This would be a good change even if FIPS didn't exist, because either you need a
cryptographic digest or you don't.  Using MD5 is a big red flag as there isn't
really any valid use case for it anymore.  We should be working to eliminate all
uses of MD5 from the kernel, and likewise for other broken crypto algorithms
like RC4.  Note that that includes not just upgrading crypto algorithms, but
also eliminating cases where crypto was improperly used when it isn't needed.

As far as non-cryptographic checksums go, CRC-32 has less than a 1 in 4 billion
chance of a collision.  People seemed happy with that for this use case.  But if
a stronger checksum is desired, then CRC-64 or xxHash64 would give a 1 in 2^64
chance of collision instead.

- Eric
