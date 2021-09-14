Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B440ABAA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Sep 2021 12:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhINKaO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Sep 2021 06:30:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:52961 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231527AbhINKaN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Sep 2021 06:30:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307502397"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="307502397"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 03:28:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="609558479"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Sep 2021 03:28:50 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Sep 2021 13:28:49 +0300
Date:   Tue, 14 Sep 2021 13:28:49 +0300
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
Message-ID: <YUB5Ya1/DbeKm1mS@kuha.fi.intel.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YT+m8jr8Ehe3R55G@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT+m8jr8Ehe3R55G@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mon, Sep 13, 2021 at 12:30:58PM -0700, Benson Leung kirjoitti:
> Hi Adam and Heikki,
> 
> On Mon, Sep 13, 2021 at 03:15:46PM +0000, Adam Thomson wrote:
> > On 13 September 2021 14:30, Heikki Krogerus wrote:
> > >
> > > My plan is to register a separate power supply for each PDO. So for
> > > every source PDO and every sink PDO a port has in its capabilities,
> > > you'll have a separate power supply registered, and the same for the
> > > partner when it's connected. With every connection there should always
> > > be one active (online) source psy and active sink psy (if the port is
> > > source, one of the port's source psys will be active and the partner
> > > will have the active sink psy, or vise versa - depending on the role).
> > >
> > > Each PDO represents a "Power Supply" so to me that approach just
> > > makes the most sense. It will require a bit of work in kernel, however
> > > in user space it should mean that we only have a single new attribute
> > > file for the power supplies named "pdo" that returns a single PDO.
> > >
> > > Let me know if you guys see any obvious problems with the idea.
> > > Otherwise, that is how we really need to do this. That will make
> > > things much more clear in user space. I have a feeling it will make
> > > things easier in kernel as well in the long run.
> > >
> > > Adding Adam and Guenter. It would be good if you guys could comment
> > > the idea as well.
> > 
> > Hi Heikki,
> > 
> > Thanks for CCing me. My two pence worth is that I always envisaged the PSY
> > representation as being 1 PSY for 1 power source. I consider this in a
> > similar manner to the Regulator framework, where 1 regulator can support a range
> > of voltages and currents, but this is covered by 1 regulator instance as it's
> > just a single output. For USB-PD we have a number of options for voltage/current
> > combos, including PPS which is even lower granularity, but it's still only one
> > port. I get the feeling that having PSY instances for each and every PDO might
> > be a little confusing and these will never be concurrent.
> > 
> > However, I'd be keen to understand further and see what restrictions/issues are
> > currently present as I probably don't have a complete view of this right now. I
> > wouldn't want to dismiss something out of turn, especially when you obviously
> > have good reason to suggest such an approach.
> 
> I thought of one more potential downside to one-psy-per-pdo:
> 
> Remember that a source or sink's Capabilities may dynamically change without
> a port disconnect, and this could make one-psy-per-pdo much more chatty with
> power supply deletions and re-registrations on load balancing events.
> 
> At basically any time, a power source may send a new SRC_CAP to the sink which
> adjusts, deletes, or adds to the list of PDOs, without the connection state
> machine registering a disconnect.
> 
> In a real world case, I have a charger in my kitchen that has 2 USB-C ports
> and supports a total of 30W output. When one device is plugged in:
> 5V 3A, 9V 3A, 15V 2A
> However, when two devices are plugged in, each sees:
> 5V 3A
> 
> The load balancing event would result in two power supply deletions, whereas
> if it were a single psy per power supply (incorporating the list of PDO choices)
> it would just be a single PROP_CHANGED event.
> 
> It seems cleaner to me to have deletions and additions only possible when the
> thing is unplugged or plugged.

I just argued to Adam that because the capabilities can change in
reality at any time, just like you pointed out here, using a psy
hierarchy instead of trying to handle everything with a single psy is
not only more clear, it's actually safer, and definitely less "hacky"
approach.

I don't really see why would it be a problem to unregister and
register the psys in the hierarchy be a problem?

thanks,

-- 
heikki
