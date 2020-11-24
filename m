Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF92C2D02
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbgKXQf5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 11:35:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgKXQf5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 11:35:57 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF5DF206F9;
        Tue, 24 Nov 2020 16:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606235756;
        bh=foyt3Sdsof8A/tOSmI4RMCw2Prkp9i6MW89/8Yspj+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/d2C2Yysn/58BfnYI0yICiGuEG9WNYYNy2Lya4lPQV3EXxYQizTNusGJuOZuFpgR
         smT90pvfe7sAMC8KXbc3RXoe0UBqJd5CwO4KC7lsHT5P4XgUzlWoSkVaPqnZE83xs2
         F1XkyvFUk23alo+57M+RsU7hc9w9u230vik4AApc=
Date:   Tue, 24 Nov 2020 17:35:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: How to enable auto-suspend by default
Message-ID: <X702aZ2x4mRn+Y73@kroah.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20201110172517.GC2495@lahna.fi.intel.com>
 <30957f1a-1fe5-5d9a-101b-25f12fb93907@redhat.com>
 <DM6PR19MB26366008D59FC94D384A1E3BFAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
 <X6wSFojYLvwGhY/g@kroah.com>
 <2585b668d9452c23902db46cf850ba7fa07167b7.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2585b668d9452c23902db46cf850ba7fa07167b7.camel@hadess.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 24, 2020 at 05:02:18PM +0100, Bastien Nocera wrote:
> On Wed, 2020-11-11 at 17:32 +0100, Greg KH wrote:
> > On Wed, Nov 11, 2020 at 04:03:30PM +0000, Limonciello, Mario wrote:
> > > > > > Given we're effectively ending up with the combination of
> > > > > > runtime PM turned
> > > > > > on by udev rules, do we need something like this for that ID:
> > > > > > 
> > > > > > 
> > > > https://github.com/torvalds/linux/commit/6a7c533d4a1854f54901a065d8c672e890400
> > > > d8a
> > > > > > 
> > > > > > @Mika Westerberg should 8086:a0ed be quirked like the TCSS
> > > > > > xHCI too?
> > > > > 
> > > > > I think this one is the TGL PCH xHCI. The quirk currently for
> > > > > xHCI
> > > > > controllers that are part of the TCSS (Type-C SubSystem) where
> > > > > it is
> > > > > important to put all devices into low power mode whenever
> > > > > possible,
> > > > > otherwise it keeps the whole block on.
> > > > 
> > > > Note that there are currently some IDs missing from the xHCIs
> > > > which
> > > > are part of the TCSS too. At least the id for the xHCI in the
> > > > thunderbolt
> > > > controller on the Lenovo T14 gen 1 is missing. I started a
> > > > discussion
> > > > about extending the kernel quirk list for this vs switching to
> > > > hwdb
> > > > a while a go:
> > > > 
> > > > https://lore.kernel.org/linux-usb/b8b21ba3-0a8a-ff54-5e12-
> > > > cf8960651086@redhat.com/
> > > > 
> > > > The conclusion back then was to switch to hwdb, but I never got
> > > > around to
> > > > this.
> > > 
> > > I guess the problem I see with switching to a hwdb for this type of
> > > thing is
> > > that if there is a "bug" in your kernel driver around autosuspend
> > > you will
> > > then be potentially causing it to occur more regularly on a kernel
> > > that didn't
> > > necessarily pick up the fix but does have the newer hwdb.
> > > 
> > > I don't know how common that will really be though.
> > > 
> > > Since Mika mentioned the really light userspace scenario, what
> > > about shipping
> > > the hwdb "with" the kernel in tree?  This could allow evicting all
> > > these quirk
> > > scenarios from the kernel at the same time as switching to a hwdb
> > > and also cover
> > > the problem I suggested might happen with a bug in older kernel and
> > > newer userspace.
> > 
> > We took things out of the kernel to put it in hwdb years ago as it
> > was
> > easier for people to update a "text file" than it was their kernel
> > image.  I don't think you want to go backwards here :)
> 
> There are (unfortunately) a couple of Linux based OSes that don't use
> systemd, which is one of the problems we see.

You don't have to use systemd to use hwdb.  If you want to handle quirks
for hardware issues that are done in userspace, the overall solution for
this in Linux is hwdb.  To try to reverse that decision we all made a
long time ago is just going to duplicate work for almost no gain that I
can see.

What distros need this that can not pick this up from hwdb today?

> I think it might be a good idea to have a repository or directory
> that's accessible to same contributions as the drivers, where this sort
> of data is kept, as close to the drivers as possible.

And who is going to maintain that?  The data that ends up in hwdb
already comes from multiple places today, why add yet-another-one?  Are
you going to somehow unify all of those existing data sources into a
single entity?  Who is going to run that service and what would the end
output look like (hint, you would have to provide hwdb support, so why
not just use that?)

> You could always split off your quirks into separate "works with any
> kernel" and "works from this version of the kernel" files,

We don't have those today, that's not a thing.

> the goal here would be to make sure that there is a canonical list of
> devices that can be autosuspended, without user-space always playing
> catch-up (especially as is the case now where systemd is being fed by
> ChromeOS which is fed in some other way).

There is no way we can ever create such a "canonical list".  Hint,
another operating system tried it, they failed, and they actually had
partnerships with most hardware vendors, and paid developers to do this
work.  What are you going to do differently than they did to solve this
problem?

> The Venn diagram of folks that contribute to hwdb quirks databases in
> systemd and that contribute to kernel drivers has a pretty small
> overlap. Moving much of those quirks to a kernel-controlled repository
> (whatever format it ends up being in) would make sense so that the
> "quirk enablement" and the "driver writing" sections overlap.

But they don't overlap today, why make us do more work for no gain?

thanks,

greg k-h
