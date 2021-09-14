Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1840AB7A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Sep 2021 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhINKP1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Sep 2021 06:15:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:39614 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhINKP0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Sep 2021 06:15:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221988087"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="221988087"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 03:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="609554195"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Sep 2021 03:14:03 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Sep 2021 13:14:02 +0300
Date:   Tue, 14 Sep 2021 13:14:02 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "badhri@google.com" <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Message-ID: <YUB16up3JDwi3HfI@kuha.fi.intel.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mon, Sep 13, 2021 at 03:15:46PM +0000, Adam Thomson kirjoitti:
> On 13 September 2021 14:30, Heikki Krogerus wrote:
> 
> > > Add support for reporting Source and Sink Capabilities
> > > Power Data Object (PDO) property. These are reported by USB
> > > Power Delivery (PD) capable power sources.
> > >
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-power | 30 +++++++++++++++++++++
> > >  drivers/power/supply/power_supply_sysfs.c   | 18 ++++++++++++-
> > >  include/linux/power_supply.h                |  5 ++++
> > >  3 files changed, 52 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power
> > b/Documentation/ABI/testing/sysfs-class-power
> > > index ca830c6cd809..90d4198e6dfb 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > @@ -562,6 +562,36 @@ Description:
> > >  			      "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
> > >  			      "PD_DRP", "PD_PPS", "BrickID"
> > >
> > > +What:
> > 	/sys/class/power_supply/<supply_name>/source_cap_pdos
> > > +Date:		September 2021
> > > +Contact:	linux-pm@vger.kernel.org
> > > +Description:
> > > +		Reports the Source Capabilities Power Data Objects (PDO)
> > reported by the USB
> > > +		PD-capable power source. 13 PDOs are listed. PDOs 1-7 represent
> > the Source Caps
> > > +		for devices which only support Standard Power Range (SPR),
> > whereas PDOs 8-13
> > > +		are for Extended Power Range (EPR) capable sources.
> > > +		NOTE: The EPR Source Caps message is a superset of the Source
> > Cap message, so on
> > > +		SPR-only sources, PDOs 8-13 will be 0.
> > > +
> > > +		Access: Read-Only
> > > +
> > > +		Valid values: Represented as a list of 13 32-bit PDO objects in
> > hexadecimal format.
> > > +
> > > +What:
> > 	/sys/class/power_supply/<supply_name>/sink_cap_pdos
> > > +Date:		September 2021
> > > +Contact:	linux-pm@vger.kernel.org
> > > +Description:
> > > +		Reports the Sink Capabilities Power Data Objects (PDO) reported
> > by the USB
> > > +		PD-capable power source. 13 PDOs are listed. PDOs 1-7 represent
> > the Sink Caps
> > > +		for devices which only support Standard Power Range (SPR),
> > whereas PDOs 8-13
> > > +		are for Extended Power Range (EPR) capable sinks.
> > > +		NOTE: The EPR Sink Caps message is a superset of the Sink Cap
> > message, so on
> > > +		SPR-only sinks, PDOs 8-13 will be 0.
> > > +
> > > +		Access: Read-Only
> > > +
> > > +		Valid values: Represented as a list of 13 32-bit PDO objects in
> > hexadecimal format.
> >
> > My plan is to register a separate power supply for each PDO. So for
> > every source PDO and every sink PDO a port has in its capabilities,
> > you'll have a separate power supply registered, and the same for the
> > partner when it's connected. With every connection there should always
> > be one active (online) source psy and active sink psy (if the port is
> > source, one of the port's source psys will be active and the partner
> > will have the active sink psy, or vise versa - depending on the role).
> >
> > Each PDO represents a "Power Supply" so to me that approach just
> > makes the most sense. It will require a bit of work in kernel, however
> > in user space it should mean that we only have a single new attribute
> > file for the power supplies named "pdo" that returns a single PDO.
> >
> > Let me know if you guys see any obvious problems with the idea.
> > Otherwise, that is how we really need to do this. That will make
> > things much more clear in user space. I have a feeling it will make
> > things easier in kernel as well in the long run.
> >
> > Adding Adam and Guenter. It would be good if you guys could comment
> > the idea as well.
> 
> Hi Heikki,
> 
> Thanks for CCing me. My two pence worth is that I always envisaged the PSY
> representation as being 1 PSY for 1 power source. I consider this in a
> similar manner to the Regulator framework, where 1 regulator can support a range
> of voltages and currents, but this is covered by 1 regulator instance as it's
> just a single output. For USB-PD we have a number of options for voltage/current
> combos, including PPS which is even lower granularity, but it's still only one
> port. I get the feeling that having PSY instances for each and every PDO might
> be a little confusing and these will never be concurrent.
> 
> However, I'd be keen to understand further and see what restrictions/issues are
> currently present as I probably don't have a complete view of this right now. I
> wouldn't want to dismiss something out of turn, especially when you obviously
> have good reason to suggest such an approach.

I'm not proposing that we drop the port-psys. I'm sorry if I've been
unclear about that. The port-psy we can not drop because of several
reasons. For starters, we still can not assume that USB PD is always
supported.

What I'm trying to propose is that we take advantage of the
power-supply framework by building a "dynamic" hierarchy of power
supplies that supply each other in order to represent the actual
situation as closely as possible. For example, a port-psy that is
supplied by port-Fixed-sink-psy that is supplied by
port-partner-Fixed-source (that is supplied by port-partner-psy).
Something like that. The only "static" part in the hierarchy is the
port-psy, as everything else about it can change, even without
disconnection.

So the port-psy always either supplies another psy or is supplied by
another psy in this hierarchy, depending on the role of the port. But
most importantly, the properties of the port-psy itself are _newer_
adjustable - they are read-only. The psy that supplies the port-psy
can be adjustable, if it's for example PPS, but not the port-psy
itself.

The problem with having only a single psy per port (and possibly
partners) is that it does not work well enough when the capabilities
change, and the capabilities can really change at any moment, we don't
need to disconnect for that to happen - simply by plugging another
device to another port can change the power budget for your port and
change your capabilities. The biggest problem is when we loose the
ability to adjust the values if we for example loose the PPS that we
were using in the middle of operation. The single psy has to attempt
to handle the situation by adjusting something like the ranges of the
properties, because it can't change the actual property set itself.
That is hacky, and to be honest, a little bit risky, because it leaves
us at the mercy of programmers completely unnecessarily.

With my proposal, if the capabilities change, it only means we rebuild
the psy hierarchy, and that's it. Nothing else needs to be done in
kernel, and all changes are super visible and clear in user space.

thanks,

-- 
heikki
