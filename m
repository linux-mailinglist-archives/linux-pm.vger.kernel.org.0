Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BD2AF398
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 15:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgKKObv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 09:31:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:33114 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKKObv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Nov 2020 09:31:51 -0500
IronPort-SDR: aHq9fg0BIOu273VAnueNRIog0IS3c+N0hHAJ75gh73nMNCGzoPVmOtXTO7EUs/Dpr6ZPi6kQwc
 Q+38XHxVcNHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="188133466"
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="188133466"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 06:31:48 -0800
IronPort-SDR: /GAd6FrjIoMAvecKIXIlQS01mub9ZzqUpUEZ60UAqJFlgUltR/WnRbSmIucFMm3JZaBYrMnNoR
 5IvMC625ywHQ==
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="541821140"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 06:31:45 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 11 Nov 2020 16:31:43 +0200
Date:   Wed, 11 Nov 2020 16:31:43 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: How to enable auto-suspend by default
Message-ID: <20201111143143.GV2495@lahna.fi.intel.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20201110172517.GC2495@lahna.fi.intel.com>
 <30957f1a-1fe5-5d9a-101b-25f12fb93907@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30957f1a-1fe5-5d9a-101b-25f12fb93907@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 12:27:32PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/10/20 6:25 PM, Mika Westerberg wrote:
> > On Tue, Nov 10, 2020 at 04:02:33PM +0000, Limonciello, Mario wrote:
> >>>
> >>> On Tue, Nov 10, 2020 at 11:57:07AM +0100, Bastien Nocera wrote:
> >>>> Hey,
> >>>>
> >>>> systemd has been shipping this script to enable auto-suspend on a
> >>>> number of USB and PCI devices:
> >>>>
> >>> https://github.com/systemd/systemd/blob/master/tools/chromiumos/gen_autosuspen
> >>> d_rules.py
> >>>>
> >>>> The problem here is twofold. First, the list of devices is updated from
> >>>> ChromeOS, and the original list obviously won't be updated by ChromeOS
> >>>> developers unless a device listed exists in a ChromeBook computer,
> >>>> which means a number of devices that do support autosuspend aren't
> >>>> listed.
> >>>>
> >>>> The other problem is that this list needs to exist at all, and that it
> >>>> doesn't seem possible for device driver developers (at various levels
> >>>> of the stack) to opt-in to auto-suspend when all the variants of the
> >>>> device (or at least detectable ones) support auto-suspend.
> >>>
> >>> A driver can say they support autosuspend today, but I think you are
> >>> concerned about the devices that are controlled by class-compliant
> >>> drivers, right?  And for those, no, we can't do this in the kernel as
> >>> there are just too many broken devices out there.
> >>>
> >>
> >> I guess what Bastien is getting at is for newer devices supported by class
> >> drivers rather than having to store an allowlist in udev rules, can we set
> >> the allowlist in the kernel instead.  Then distributions that either don't
> >> use systemd or don't regularly update udev rules from systemd can take
> >> advantage of better defaults on modern hardware.
> >>
> >> The one item that stood out to me in that rules file was 8086:a0ed.
> >> It's listed as "Volteer XHCI", but that same device ID is actually present
> >> in an XPS 9310 in front of me as well and used by the xhci-pci kernel module.
> >>
> >> Given we're effectively ending up with the combination of runtime PM turned
> >> on by udev rules, do we need something like this for that ID:
> >>
> >> https://github.com/torvalds/linux/commit/6a7c533d4a1854f54901a065d8c672e890400d8a
> >>
> >> @Mika Westerberg should 8086:a0ed be quirked like the TCSS xHCI too?
> > 
> > I think this one is the TGL PCH xHCI. The quirk currently for xHCI
> > controllers that are part of the TCSS (Type-C SubSystem) where it is
> > important to put all devices into low power mode whenever possible,
> > otherwise it keeps the whole block on.
> 
> Note that there are currently some IDs missing from the xHCIs which
> are part of the TCSS too. At least the id for the xHCI in the thunderbolt
> controller on the Lenovo T14 gen 1 is missing. I started a discussion
> about extending the kernel quirk list for this vs switching to hwdb
> a while a go:
> 
> https://lore.kernel.org/linux-usb/b8b21ba3-0a8a-ff54-5e12-cf8960651086@redhat.com/
> 
> The conclusion back then was to switch to hwdb, but I never got around to this.

The reason I've added these to the xHCI driver is that it works even if
you are running some really small userspace (like busybox). Also for the
xHCI in TCSS we know for sure that it fully supports D3cold.

(The one you refer above is actually mistake from my side as I never
 tested Alpine Ridge LP controller which I think this is).

> > Typically we haven't done that for PCH side xHCI controllers though, but
> > I don't see why not if it works that is. Adding Mathias to comment more
> > on that since he is the xHCI maintainer.
> 
> If we are also going to enable this for the non TCSS Intel XHCI controllers,
> maybe just uncondtionally enable it for all Intel XHCI controllers, or
> if necessary do a deny-list for some older models and enable it for anything
> not on the deny-list (so all newer models). That should avoid the game of
> whack-a-mole which we will have with this otherwise.

This is really up to Mathias to decide. I'm fine either way :)
