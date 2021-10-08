Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5994B426879
	for <lists+linux-pm@lfdr.de>; Fri,  8 Oct 2021 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbhJHLL5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Oct 2021 07:11:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:64772 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232629AbhJHLL4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Oct 2021 07:11:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226772890"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="226772890"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 04:09:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="624701232"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2021 04:09:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 Oct 2021 14:09:55 +0300
Date:   Fri, 8 Oct 2021 14:09:55 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Benson Leung <bleung@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "badhri@google.com" <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Message-ID: <YWAnA1mc5CrlEs7H@kuha.fi.intel.com>
References: <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com>
 <YULwz8NsoA3+vrhA@google.com>
 <YUMbGp0aemx1HCHv@kuha.fi.intel.com>
 <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUm5sdbceMcDTvYj@kuha.fi.intel.com>
 <DB9PR10MB46524E3817FB4D836CDC13E180A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CACeCKaem93dbJ11qOG=a+MkJhSrp0Nx-UAPG00Q-5WwMriJD0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaem93dbJ11qOG=a+MkJhSrp0Nx-UAPG00Q-5WwMriJD0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 07, 2021 at 03:32:27PM -0700, Prashant Malani wrote:
> Hi folks,
> 
> Thanks for the comments and discussion on this RFC series.
> 
> On Fri, Sep 24, 2021 at 8:38 AM Adam Thomson
> <Adam.Thomson.Opensource@diasemi.com> wrote:
> >
> > On 21 September 2021 11:54, Heikki Krogerus wrote:
> >
> > > If we can leave the decision about the selection to TCPM, that would
> > > be great! I'm not against that at all. As I said, I have not though
> > > through the control aspect. Right now I'm mostly concerned about how
> > > we expose the information to the user. The only reason why I have
> > > considered the control part at all is because how ever we decide to
> > > expose the information to the user, it has to work with control as
> > > well.
> >
> > Well part of the discussion has to be about the role that the user plays in
> > the control. What does and doesn't need to be controlled further up the stack,
> > and what will be taken care of by, for example, TCPM? Surely that dictates to
> > some degree what and how we expose all of this? Right now we have a simple means
> > to read and control voltages and currents through a PSY class, without the need
> > for the user to know any details of what a PDO/APDO is. Do we continue with
> > abstracting away to the user or instead let the user decipher this itself and
> > decide? Am just trying to understand the needs going forward.
> >
> > > The final PSYs and the supply chains they create as well as the
> > > individual properties I'm more than happy to talk about, but having a
> > > separate object for the smallest thing that we can see (PDO) is the
> > > right thing to do here IMO. Trying to concatenate things into single
> > > objects especially in sysfs, despite how nice it always would seem,
> > > has taken me to the brink of disaster in the past far too many times.
> > >
> > > In this case we don't need to take the risk of having to duplicated
> > > information or in worst case deprecate something that is also exposed
> > > to the sysfs in the future.
> > >
> > > So the question is not why should we registers every individual PDO
> > > separately. The question is, why shouldn't we do that? And saying that
> > > it's "heavyweight" I'm afraid is not good enough. :-)
> >
> > That was my initial feeling on the suggestion based on the idea of a PSY per PDO
> > and I still don't feel that fits as your creating a whole class of resources
> > to expose something that's pretty small. To me the PSY represents the source as
> > whole, and the PDOs are simply options/configurations for that source. If we're
> > needing to expose PDOs then I don't disagree with separating them out
> > individually and I certainly wouldn't want that all concatenated as one
> > property. However I think something like dynamically generated properties
> > might be a nicer solution to expose each PDO, or even groups of properties if
> > you wanted to split PDOs even further into constituent parts to the user.
> 
> To downscope this issue for the time being, one of our immediate goals
> is to expose the PDOs
> to userspace for metrics reporting and potentially for some power
> policy control through other
> channels (like Chrome OS Embedded Controller).
> 
> Would it be acceptable to revise this series to drop the power supply
> support for now (since I don't yet
> see a consensus on how to implement it for the partner), and just add
> sysfs nodes for each PDO ?
> This would be akin to how it's being done for identity VDOs right now.
> 
> So we would have :
> 
> /sys/class/typec/<port>-partner/source_pdos/pdo{1-13}
> 
> and
> 
> /sys/class/typec/<port>-partner/sink_pdos/pdo{1-13}
> 
> and similarly for the port device.
> 
> If we want to add additional parsing of the  Fixed Supply PDO into
> individual properties for the partner/port,
> those can of course be added later.
> 
> WDYT?

I don't think we should use sysfs to expose and control any of these
objects. It does not really matter under which subsystem we are
working. Sysfs is just the wrong interface for this kind of data.

I'm now preparing a proof-of-concept patches where I create character
device for every USB PD capable device (port, plug and partner). The
idea is that we could use those char devices to tap into the USB PD
protocol directly. Right now I'm thinking the nodes would look like
this (with the first Type-C port):

        /dev/pd0/port
        /dev/pd0/plug0 - you only get this node with full featured cables
        /dev/pd0/plug1 - ditto
        /dev/pd0/partner - and this is here only if you are connected

So in this case you would use those char devices to send the actual
Get_Source_Cap and Get_Sink_Cap messages to get the PDOs.

The problem is that it's not going to be possible to always support
every type of command. For example with UCSI we are pretty much
limited to the capability control messages. But I still think this is
the right way to do this.

Let me know what you think.

thanks,

-- 
heikki
