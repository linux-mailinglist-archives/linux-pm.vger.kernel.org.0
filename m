Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972CA36F0C0
	for <lists+linux-pm@lfdr.de>; Thu, 29 Apr 2021 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhD2UB4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 29 Apr 2021 16:01:56 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51808 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbhD2UAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Apr 2021 16:00:33 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 339D01C0BA4; Thu, 29 Apr 2021 21:59:45 +0200 (CEST)
Date:   Thu, 29 Apr 2021 21:59:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, Simo Sorce <simo@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] use crc32 instead of md5 for hibernation e820
 integrity check
Message-ID: <20210429195944.GB1067@bug>
References: <20210408131506.17941-1-crecklin@redhat.com>
 <CAJZ5v0ib+jmbsD9taGW0RujY5c9BCK8yLHv065u44mb0AwO9vQ@mail.gmail.com>
 <YG8gqZoZGutPmROz@sol.localdomain>
 <CAJZ5v0g65irXKmy7pdgD8-5KWrxdtwiWbJsBD2A=PKf1D3RVZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAJZ5v0g65irXKmy7pdgD8-5KWrxdtwiWbJsBD2A=PKf1D3RVZg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> > > > Suspend fails on a system in fips mode because md5 is used for the e820
> > > > integrity check and is not available. Use crc32 instead.
> > > >
> > > > This patch changes the integrity check algorithm from md5 to
> > > > crc32. This integrity check is used only to verify accidental
> > > > corruption of the hybernation data
> > >
> > > It isn't used for that.
> > >
> > > In fact, it is used to detect differences between the memory map used
> > > before hibernation and the one made available by the BIOS during the
> > > subsequent resume.  And the check is there, because it is generally
> > > unsafe to load the hibernation image into memory if the current memory
> > > map doesn't match the one used when the image was created.
> >
> > So what types of "differences" are you trying to detect?  If you need to detect
> > differences caused by someone who maliciously made changes ("malicious" implies
> > they may try to avoid detection), then you need to use a cryptographic hash
> > function (or a cryptographic MAC if the hash value isn't stored separately).  If
> > you only need to detect non-malicious changes (normally these would be called
> > "accidental" changes, but sure, it could be changes that are "intentionally"
> > made provided that the other side can be trusted to not try to avoid
> > detection...)
> 
> That's the case here.

md5 is fine for this purpose. crc32 may be too weak. I don't see why this needs changing.

Maybe fips should understand that md5 has other uses than crypto?

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
