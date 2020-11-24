Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29622C2C34
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 17:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbgKXQCX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 11:02:23 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47733 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390050AbgKXQCW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 11:02:22 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8FA102000F;
        Tue, 24 Nov 2020 16:02:18 +0000 (UTC)
Message-ID: <2585b668d9452c23902db46cf850ba7fa07167b7.camel@hadess.net>
Subject: Re: How to enable auto-suspend by default
From:   Bastien Nocera <hadess@hadess.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Date:   Tue, 24 Nov 2020 17:02:18 +0100
In-Reply-To: <X6wSFojYLvwGhY/g@kroah.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
         <X6p6ubTOoMPUPPXi@kroah.com>
         <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
         <20201110172517.GC2495@lahna.fi.intel.com>
         <30957f1a-1fe5-5d9a-101b-25f12fb93907@redhat.com>
         <DM6PR19MB26366008D59FC94D384A1E3BFAE80@DM6PR19MB2636.namprd19.prod.outlook.com>
         <X6wSFojYLvwGhY/g@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-11-11 at 17:32 +0100, Greg KH wrote:
> On Wed, Nov 11, 2020 at 04:03:30PM +0000, Limonciello, Mario wrote:
> > > > > Given we're effectively ending up with the combination of
> > > > > runtime PM turned
> > > > > on by udev rules, do we need something like this for that ID:
> > > > > 
> > > > > 
> > > https://github.com/torvalds/linux/commit/6a7c533d4a1854f54901a065d8c672e890400
> > > d8a
> > > > > 
> > > > > @Mika Westerberg should 8086:a0ed be quirked like the TCSS
> > > > > xHCI too?
> > > > 
> > > > I think this one is the TGL PCH xHCI. The quirk currently for
> > > > xHCI
> > > > controllers that are part of the TCSS (Type-C SubSystem) where
> > > > it is
> > > > important to put all devices into low power mode whenever
> > > > possible,
> > > > otherwise it keeps the whole block on.
> > > 
> > > Note that there are currently some IDs missing from the xHCIs
> > > which
> > > are part of the TCSS too. At least the id for the xHCI in the
> > > thunderbolt
> > > controller on the Lenovo T14 gen 1 is missing. I started a
> > > discussion
> > > about extending the kernel quirk list for this vs switching to
> > > hwdb
> > > a while a go:
> > > 
> > > https://lore.kernel.org/linux-usb/b8b21ba3-0a8a-ff54-5e12-
> > > cf8960651086@redhat.com/
> > > 
> > > The conclusion back then was to switch to hwdb, but I never got
> > > around to
> > > this.
> > 
> > I guess the problem I see with switching to a hwdb for this type of
> > thing is
> > that if there is a "bug" in your kernel driver around autosuspend
> > you will
> > then be potentially causing it to occur more regularly on a kernel
> > that didn't
> > necessarily pick up the fix but does have the newer hwdb.
> > 
> > I don't know how common that will really be though.
> > 
> > Since Mika mentioned the really light userspace scenario, what
> > about shipping
> > the hwdb "with" the kernel in tree?  This could allow evicting all
> > these quirk
> > scenarios from the kernel at the same time as switching to a hwdb
> > and also cover
> > the problem I suggested might happen with a bug in older kernel and
> > newer userspace.
> 
> We took things out of the kernel to put it in hwdb years ago as it
> was
> easier for people to update a "text file" than it was their kernel
> image.  I don't think you want to go backwards here :)

There are (unfortunately) a couple of Linux based OSes that don't use
systemd, which is one of the problems we see.

I think it might be a good idea to have a repository or directory
that's accessible to same contributions as the drivers, where this sort
of data is kept, as close to the drivers as possible.

You could always split off your quirks into separate "works with any
kernel" and "works from this version of the kernel" files, the goal
here would be to make sure that there is a canonical list of devices
that can be autosuspended, without user-space always playing catch-up
(especially as is the case now where systemd is being fed by ChromeOS
which is fed in some other way).

The Venn diagram of folks that contribute to hwdb quirks databases in
systemd and that contribute to kernel drivers has a pretty small
overlap. Moving much of those quirks to a kernel-controlled repository
(whatever format it ends up being in) would make sense so that the
"quirk enablement" and the "driver writing" sections overlap.

