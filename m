Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33982AF68D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 17:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgKKQbX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 11:31:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgKKQbX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Nov 2020 11:31:23 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06267206B5;
        Wed, 11 Nov 2020 16:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605112282;
        bh=u1W79eBhFJDijrV1bXsrDHc02dojBuPzlmTjNRwzECM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTJO7zCDEAIc4ENcSgzN9lsMdGt7wXtmAxlhGhYh9RxxpVjT7DGXoeXUS10GeaFoJ
         TqdEeulUJiiE6h4kRf+qbVUdou0DBrWTQpZdIfznMNMFg0Uy+wXHd5P9E0SvPkdoXw
         eDeNfg3jKEyZgGrNPO6pRBc2UXlWpwDPeeHKE9T4=
Date:   Wed, 11 Nov 2020 17:32:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: How to enable auto-suspend by default
Message-ID: <X6wSFojYLvwGhY/g@kroah.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20201110172517.GC2495@lahna.fi.intel.com>
 <30957f1a-1fe5-5d9a-101b-25f12fb93907@redhat.com>
 <DM6PR19MB26366008D59FC94D384A1E3BFAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB26366008D59FC94D384A1E3BFAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 04:03:30PM +0000, Limonciello, Mario wrote:
> > >> Given we're effectively ending up with the combination of runtime PM turned
> > >> on by udev rules, do we need something like this for that ID:
> > >>
> > >>
> > https://github.com/torvalds/linux/commit/6a7c533d4a1854f54901a065d8c672e890400
> > d8a
> > >>
> > >> @Mika Westerberg should 8086:a0ed be quirked like the TCSS xHCI too?
> > >
> > > I think this one is the TGL PCH xHCI. The quirk currently for xHCI
> > > controllers that are part of the TCSS (Type-C SubSystem) where it is
> > > important to put all devices into low power mode whenever possible,
> > > otherwise it keeps the whole block on.
> > 
> > Note that there are currently some IDs missing from the xHCIs which
> > are part of the TCSS too. At least the id for the xHCI in the thunderbolt
> > controller on the Lenovo T14 gen 1 is missing. I started a discussion
> > about extending the kernel quirk list for this vs switching to hwdb
> > a while a go:
> > 
> > https://lore.kernel.org/linux-usb/b8b21ba3-0a8a-ff54-5e12-
> > cf8960651086@redhat.com/
> > 
> > The conclusion back then was to switch to hwdb, but I never got around to
> > this.
> 
> I guess the problem I see with switching to a hwdb for this type of thing is
> that if there is a "bug" in your kernel driver around autosuspend you will
> then be potentially causing it to occur more regularly on a kernel that didn't
> necessarily pick up the fix but does have the newer hwdb.
> 
> I don't know how common that will really be though.
> 
> Since Mika mentioned the really light userspace scenario, what about shipping
> the hwdb "with" the kernel in tree?  This could allow evicting all these quirk
> scenarios from the kernel at the same time as switching to a hwdb and also cover
> the problem I suggested might happen with a bug in older kernel and newer userspace.

We took things out of the kernel to put it in hwdb years ago as it was
easier for people to update a "text file" than it was their kernel
image.  I don't think you want to go backwards here :)

thanks,

greg k-h
