Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D692ADD91
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 18:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKJR7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 12:59:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKJR7p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 12:59:45 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E11920781;
        Tue, 10 Nov 2020 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605031184;
        bh=jwu8PRKrsHfDgpGZ+z6S9+0XZR1/nw57zMqpHjt+PXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFAucTu5ZAAAQH7vf4p2SqwNLuAMx/4OkNrFgjqL4U6YGOyt4kMCbn5AYamDKyYA6
         t6ra/iIzcSxLYWVmgwgUO89Sub+nQNeIKWwCVQXJx0fh2PV0/7SV0elcpVzJM6R9Us
         gh+vaxgFKASCyEWCDrCE1hI/uA6SGTi+4SfeFq1g=
Date:   Tue, 10 Nov 2020 19:00:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: How to enable auto-suspend by default
Message-ID: <X6rVT6IXHYQpqjic@kroah.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <X6rLUDuG0N98jz18@kroah.com>
 <DM6PR19MB2636460E97BD5E47957BB43AFAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB2636460E97BD5E47957BB43AFAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 10, 2020 at 05:45:43PM +0000, Limonciello, Mario wrote:
> > > I guess what Bastien is getting at is for newer devices supported by class
> > > drivers rather than having to store an allowlist in udev rules, can we set
> > > the allowlist in the kernel instead.  Then distributions that either don't
> > > use systemd or don't regularly update udev rules from systemd can take
> > > advantage of better defaults on modern hardware.
> > 
> > That's what the "hardware ids" database is supposed to be handling.
> > It's easier to manage this in userspace than in the kernel.
> > 
> > I just love systems where people feel it is safer to update the kernel
> > than it is to update a hardware database file :)
> > 
> > > The one item that stood out to me in that rules file was 8086:a0ed.
> > > It's listed as "Volteer XHCI", but that same device ID is actually present
> > > in an XPS 9310 in front of me as well and used by the xhci-pci kernel
> > module.
> > 
> > That's an Intel PCI device id.  If someone else is abusing that number,
> > I'm sure Intel would want to know about it and would be glad to go after
> > them.
> 
> Sorry I wasn't intending to insinuate an abuse of the number, but rather that
> the PCI device in the "Volteer" product and that in XPS 9310 appear are the
> same so they are possibly using the same hardware for this device.

Ok, but again, given that the device might be on different transports,
the ability for the device to properly autosuspend might be different,
right?

thanks,

greg k-h
