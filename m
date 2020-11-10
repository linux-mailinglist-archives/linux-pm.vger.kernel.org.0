Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9F02ADCB1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 18:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgKJRRM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 12:17:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKJRRM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 12:17:12 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8ADF206F1;
        Tue, 10 Nov 2020 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605028631;
        bh=IDiwP0RhYpD80ItMS9pgKMzinJ2j4RtNCNx75zFTLog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rTE23E2QGj8kKIvhyewqMnyCvmBtSLIvI6AS3O7CXzihw1ZjpE+2bvb94mXPkcsoI
         SVG6lnO9M8KRECXAnxI94EM3ZlstbwM1R8BmKPWvV2Jrq5FBn/QhsOsLKYb8c+bFPw
         FS81r8caaLa+AF3dXMajMDqYq2OjVmAfvjYe5Sos=
Date:   Tue, 10 Nov 2020 18:18:08 +0100
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
Message-ID: <X6rLUDuG0N98jz18@kroah.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 10, 2020 at 04:02:33PM +0000, Limonciello, Mario wrote:
> > 
> > On Tue, Nov 10, 2020 at 11:57:07AM +0100, Bastien Nocera wrote:
> > > Hey,
> > >
> > > systemd has been shipping this script to enable auto-suspend on a
> > > number of USB and PCI devices:
> > >
> > https://github.com/systemd/systemd/blob/master/tools/chromiumos/gen_autosuspen
> > d_rules.py
> > >
> > > The problem here is twofold. First, the list of devices is updated from
> > > ChromeOS, and the original list obviously won't be updated by ChromeOS
> > > developers unless a device listed exists in a ChromeBook computer,
> > > which means a number of devices that do support autosuspend aren't
> > > listed.
> > >
> > > The other problem is that this list needs to exist at all, and that it
> > > doesn't seem possible for device driver developers (at various levels
> > > of the stack) to opt-in to auto-suspend when all the variants of the
> > > device (or at least detectable ones) support auto-suspend.
> > 
> > A driver can say they support autosuspend today, but I think you are
> > concerned about the devices that are controlled by class-compliant
> > drivers, right?  And for those, no, we can't do this in the kernel as
> > there are just too many broken devices out there.
> > 
> 
> I guess what Bastien is getting at is for newer devices supported by class
> drivers rather than having to store an allowlist in udev rules, can we set
> the allowlist in the kernel instead.  Then distributions that either don't
> use systemd or don't regularly update udev rules from systemd can take
> advantage of better defaults on modern hardware.

That's what the "hardware ids" database is supposed to be handling.
It's easier to manage this in userspace than in the kernel.

I just love systems where people feel it is safer to update the kernel
than it is to update a hardware database file :)

> The one item that stood out to me in that rules file was 8086:a0ed.
> It's listed as "Volteer XHCI", but that same device ID is actually present
> in an XPS 9310 in front of me as well and used by the xhci-pci kernel module.

That's an Intel PCI device id.  If someone else is abusing that number,
I'm sure Intel would want to know about it and would be glad to go after
them.

But note, PCI devices can be behind lots of different types of busses,
so maybe the "can this device autosuspend" differs for them because of
different implementations of where the device is, right?

> Given we're effectively ending up with the combination of runtime PM turned
> on by udev rules, do we need something like this for that ID:
> 
> https://github.com/torvalds/linux/commit/6a7c533d4a1854f54901a065d8c672e890400d8a
> 
> @Mika Westerberg should 8086:a0ed be quirked like the TCSS xHCI too?

Submit a patch!

thanks,

greg k-h
