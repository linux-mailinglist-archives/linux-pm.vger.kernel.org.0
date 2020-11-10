Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535932ADCD7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 18:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgKJRZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 12:25:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:61204 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKJRZ0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 12:25:26 -0500
IronPort-SDR: L0kOyrsKANivfp5SHOQIyw8ovcGchWZ2BfbyN3RVtjgdA5PjvGnQScmDmp4UIAWDxtBMoUYKrS
 98p1OcSZpJhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="187983038"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="187983038"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 09:25:22 -0800
IronPort-SDR: 89+SA59M9uozLTZpI8yPaKZus9uHxxs4ACMYnZPLspc8G+5pQikcItIA1+kSVOF5NG3aP4EoAQ
 y2JJZ/DGq4pA==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="541414921"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 09:25:19 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 10 Nov 2020 19:25:17 +0200
Date:   Tue, 10 Nov 2020 19:25:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: How to enable auto-suspend by default
Message-ID: <20201110172517.GC2495@lahna.fi.intel.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
> 
> The one item that stood out to me in that rules file was 8086:a0ed.
> It's listed as "Volteer XHCI", but that same device ID is actually present
> in an XPS 9310 in front of me as well and used by the xhci-pci kernel module.
> 
> Given we're effectively ending up with the combination of runtime PM turned
> on by udev rules, do we need something like this for that ID:
> 
> https://github.com/torvalds/linux/commit/6a7c533d4a1854f54901a065d8c672e890400d8a
> 
> @Mika Westerberg should 8086:a0ed be quirked like the TCSS xHCI too?

I think this one is the TGL PCH xHCI. The quirk currently for xHCI
controllers that are part of the TCSS (Type-C SubSystem) where it is
important to put all devices into low power mode whenever possible,
otherwise it keeps the whole block on.

Typically we haven't done that for PCH side xHCI controllers though, but
I don't see why not if it works that is. Adding Mathias to comment more
on that since he is the xHCI maintainer.
