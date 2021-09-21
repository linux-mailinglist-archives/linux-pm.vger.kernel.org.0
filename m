Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDE34131FC
	for <lists+linux-pm@lfdr.de>; Tue, 21 Sep 2021 12:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhIUKzL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Sep 2021 06:55:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:26569 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231969AbhIUKzK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Sep 2021 06:55:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="202823384"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="202823384"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 03:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="612931945"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 21 Sep 2021 03:53:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Sep 2021 13:53:37 +0300
Date:   Tue, 21 Sep 2021 13:53:37 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Benson Leung <bleung@google.com>,
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
Message-ID: <YUm5sdbceMcDTvYj@kuha.fi.intel.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com>
 <YULwz8NsoA3+vrhA@google.com>
 <YUMbGp0aemx1HCHv@kuha.fi.intel.com>
 <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 16, 2021 at 02:12:23PM +0000, Adam Thomson wrote:
> On 16 September 2021 11:23, Heikki Krogerus wrote:
> 
> > > Thanks for providing the clarification. So you're proposing a port-psy and a
> > > port-partner-psy that are connected to each other (one supplying the other).
> > > If PD is not present, those two will exist per port and partner, and there
> > > will be information about Type-C current (and possibly BC 1.2 and other
> > > methods?)
> > 
> > Yes, exactly.
> > 
> > > Do you have an example hierarchy you could share that explains what it would
> > > look like in /sys/class/power_supply with PD with Source Caps and Sink Caps on
> > > both sides?
> > 
> > I don't yet, but I'll prepare something. I did notice already that the
> > power supply class does not seem to display the suppliers nor
> > supplicants in sysfs. But we can always improve the class.
> > 
> > I probable should not talk about "hierarchy". Maybe taking about
> > simply "chain" of power supplies is more correct?
> > 
> > > I think this all makes sense if the connector class is a read interface
> > > for this info. Have you considered how the type-c connector class and this pd
> > > psy support will handle dynamic PDO changes for advertisement FROM the
> > ports?
> > >
> > > For example, let's say you wanted the kernel and user to manage two USB-C
> > ports
> > > with higher power support (meaning, 5V, 9V, 15V, 20V capable), but then your
> > > kernel and user needs to edit the Source Caps on the fly based on load
> > > balancing.
> > >
> > > If caps are represented as a group of psys together, how do you as a kernel
> > > and user create an modify the set of Source_Caps you put out on a port?
> > 
> > My idea is to utilise the "present" property with the ports. You would
> > always display all the possible supplies, but only the ones that you
> > expose in your current capabilities will be present.
> > 
> > The idea is also that the ports are always supplied by normal power
> > supplies of type "battery", "AC" and what have you. Those you can use
> > to see the maximum power your port can get, and to determine the
> > currently available power by checking the other ports that consume the
> > same supply.

Going back here a bit... It now looks like this second part is not
possible, which sucks, but it only means registering a separate object
(psy) for each PDO is even more important.

> > So if you need more power for one port, you most likely will need to
> > attempt to adjust the power levels of the source PDO power supplies of
> > the other ports that share the base supply (like battery), or possibly
> > disable them, and that way enable (make present) more source supplies
> > for your port. That is the idea, but I admit I have not thought of
> > everything, so I'm not completely sure would it work exactly like
> > that, but the power balancing should in any case be possible with the
> > chain of power supplies one way or the other.
> > 
> > I hope I understood your question correctly, and I hope I was able to
> > give you an answer :-)
> 
> Thanks for the additional updates. So is the intention here to move control of
> PDO selection away from TCPM, or add more flexibility to it? As I understand it
> from previous efforts around all of this, the intention was that TCPM makes the
> decision as to which PDO to select (and which APDO for PPS) based on the offered
> capabilities of the source and the sink capabilities which are described in FW.
> Am just trying to envisage the use-cases here and how the kernel/user is
> involved in selecting PDOs/voltages/currents.

If we can leave the decision about the selection to TCPM, that would
be great! I'm not against that at all. As I said, I have not though
through the control aspect. Right now I'm mostly concerned about how
we expose the information to the user. The only reason why I have
considered the control part at all is because how ever we decide to
expose the information to the user, it has to work with control as
well.

> IIRC there used to be functions for updating source/sink capabilities but these
> never had users and were subsequently removed. I guess this would be essentially
> the functional replacement for those APIs?
> 
> Personally, I think the idea of source/sink PSY instances supplying each other
> seems reasonable. Right now we represent the external PD/Type-C supply (partner)
> through TCPM as a PSY instance which is always present for the associated port,
> although obviously when no source partner exists we're marked as offline. For
> the partner side I'm guessing the PSY instance will be dynamically
> created/destroyed? From previous experience PSY classes have tended to be
> statically included so would be interested in seeing what this looks like in
> reality.

If there is anything that should be improved in the PSY class itself
(and I'm sure there's plenty), then we improve it.

> Am still unsure on using PSY to expose individual PDOs though and this still
> feels quite heavyweight. I assume we're not wanting to expose everything in PDOs
> really, just the voltage/current info? Feels like we should be able to do this
> with individual properties which a user can be notified of changes to through
> the normal prop notifier, rather than a collection of PSY class instances.
> However, I'm happy to be convinced the other way so will await further
> details. :)

The final PSYs and the supply chains they create as well as the
individual properties I'm more than happy to talk about, but having a
separate object for the smallest thing that we can see (PDO) is the
right thing to do here IMO. Trying to concatenate things into single
objects especially in sysfs, despite how nice it always would seem,
has taken me to the brink of disaster in the past far too many times.

In this case we don't need to take the risk of having to duplicated
information or in worst case deprecate something that is also exposed
to the sysfs in the future.

So the question is not why should we registers every individual PDO
separately. The question is, why shouldn't we do that? And saying that
it's "heavyweight" I'm afraid is not good enough. :-)

Right now I simply don't see any other way that would be as flexible,
or that could even handle all the different platforms in uniform way
(this needs to work with TCPM, UCSI, and everything else), as
registering separate object (psy) for every single PDO.

thanks,

-- 
heikki
