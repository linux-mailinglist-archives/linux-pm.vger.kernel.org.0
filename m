Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BD840D751
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 12:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbhIPKYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 06:24:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:25201 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233913AbhIPKYt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Sep 2021 06:24:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="209762836"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="209762836"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 03:23:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="610600778"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Sep 2021 03:23:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 16 Sep 2021 13:23:22 +0300
Date:   Thu, 16 Sep 2021 13:23:22 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@google.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "badhri@google.com" <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Message-ID: <YUMbGp0aemx1HCHv@kuha.fi.intel.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com>
 <YULwz8NsoA3+vrhA@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YULwz8NsoA3+vrhA@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 16, 2021 at 12:22:55AM -0700, Benson Leung wrote:
> Hi Heikki,
> 
> On Tue, Sep 14, 2021 at 01:14:02PM +0300, Heikki Krogerus wrote:
> > Mon, Sep 13, 2021 at 03:15:46PM +0000, Adam Thomson kirjoitti:
> > > 
> > > Hi Heikki,
> > > 
> > > Thanks for CCing me. My two pence worth is that I always envisaged the PSY
> > > representation as being 1 PSY for 1 power source. I consider this in a
> > > similar manner to the Regulator framework, where 1 regulator can support a range
> > > of voltages and currents, but this is covered by 1 regulator instance as it's
> > > just a single output. For USB-PD we have a number of options for voltage/current
> > > combos, including PPS which is even lower granularity, but it's still only one
> > > port. I get the feeling that having PSY instances for each and every PDO might
> > > be a little confusing and these will never be concurrent.
> > > 
> > > However, I'd be keen to understand further and see what restrictions/issues are
> > > currently present as I probably don't have a complete view of this right now. I
> > > wouldn't want to dismiss something out of turn, especially when you obviously
> > > have good reason to suggest such an approach.
> > 
> > I'm not proposing that we drop the port-psys. I'm sorry if I've been
> > unclear about that. The port-psy we can not drop because of several
> > reasons. For starters, we still can not assume that USB PD is always
> > supported.
> > 
> > What I'm trying to propose is that we take advantage of the
> > power-supply framework by building a "dynamic" hierarchy of power
> > supplies that supply each other in order to represent the actual
> > situation as closely as possible. For example, a port-psy that is
> > supplied by port-Fixed-sink-psy that is supplied by
> > port-partner-Fixed-source (that is supplied by port-partner-psy).
> > Something like that. The only "static" part in the hierarchy is the
> > port-psy, as everything else about it can change, even without
> > disconnection.
> > 
> > So the port-psy always either supplies another psy or is supplied by
> > another psy in this hierarchy, depending on the role of the port. But
> > most importantly, the properties of the port-psy itself are _newer_
> > adjustable - they are read-only. The psy that supplies the port-psy
> > can be adjustable, if it's for example PPS, but not the port-psy
> > itself.
> > 
> > The problem with having only a single psy per port (and possibly
> > partners) is that it does not work well enough when the capabilities
> > change, and the capabilities can really change at any moment, we don't
> > need to disconnect for that to happen - simply by plugging another
> > device to another port can change the power budget for your port and
> > change your capabilities. The biggest problem is when we loose the
> > ability to adjust the values if we for example loose the PPS that we
> > were using in the middle of operation. The single psy has to attempt
> > to handle the situation by adjusting something like the ranges of the
> > properties, because it can't change the actual property set itself.
> > That is hacky, and to be honest, a little bit risky, because it leaves
> > us at the mercy of programmers completely unnecessarily.
> > 
> > With my proposal, if the capabilities change, it only means we rebuild
> > the psy hierarchy, and that's it. Nothing else needs to be done in
> > kernel, and all changes are super visible and clear in user space.
> > 
> 
> Thanks for providing the clarification. So you're proposing a port-psy and a
> port-partner-psy that are connected to each other (one supplying the other).
> If PD is not present, those two will exist per port and partner, and there
> will be information about Type-C current (and possibly BC 1.2 and other
> methods?)

Yes, exactly.

> Do you have an example hierarchy you could share that explains what it would
> look like in /sys/class/power_supply with PD with Source Caps and Sink Caps on
> both sides?

I don't yet, but I'll prepare something. I did notice already that the
power supply class does not seem to display the suppliers nor
supplicants in sysfs. But we can always improve the class.

I probable should not talk about "hierarchy". Maybe taking about
simply "chain" of power supplies is more correct?

> I think this all makes sense if the connector class is a read interface
> for this info. Have you considered how the type-c connector class and this pd
> psy support will handle dynamic PDO changes for advertisement FROM the ports?
> 
> For example, let's say you wanted the kernel and user to manage two USB-C ports
> with higher power support (meaning, 5V, 9V, 15V, 20V capable), but then your
> kernel and user needs to edit the Source Caps on the fly based on load
> balancing.
> 
> If caps are represented as a group of psys together, how do you as a kernel
> and user create an modify the set of Source_Caps you put out on a port?

My idea is to utilise the "present" property with the ports. You would
always display all the possible supplies, but only the ones that you
expose in your current capabilities will be present.

The idea is also that the ports are always supplied by normal power
supplies of type "battery", "AC" and what have you. Those you can use
to see the maximum power your port can get, and to determine the
currently available power by checking the other ports that consume the
same supply.

So if you need more power for one port, you most likely will need to
attempt to adjust the power levels of the source PDO power supplies of
the other ports that share the base supply (like battery), or possibly
disable them, and that way enable (make present) more source supplies
for your port. That is the idea, but I admit I have not thought of
everything, so I'm not completely sure would it work exactly like
that, but the power balancing should in any case be possible with the
chain of power supplies one way or the other.

I hope I understood your question correctly, and I hope I was able to
give you an answer :-)


thanks,

-- 
heikki
