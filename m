Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5667F4146DB
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 12:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhIVKoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 06:44:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:52938 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235403AbhIVKmF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Sep 2021 06:42:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="203059424"
X-IronPort-AV: E=Sophos;i="5.85,313,1624345200"; 
   d="scan'208";a="203059424"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 03:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,313,1624345200"; 
   d="scan'208";a="613368772"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 22 Sep 2021 03:40:31 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 22 Sep 2021 13:40:30 +0300
Date:   Wed, 22 Sep 2021 13:40:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Rajaram R <rajaram.officemail@gmail.com>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Message-ID: <YUsIHvNcEfX6dzZG@kuha.fi.intel.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com>
 <YULwz8NsoA3+vrhA@google.com>
 <YUMbGp0aemx1HCHv@kuha.fi.intel.com>
 <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAPTae5Kxmp0L35KnkYaHARrBmysX9wkMYZhGhJsu6tX4bcHuAA@mail.gmail.com>
 <CAOiXhaLpe7gHw6c8pCZDNeOC31WfxFum5G1RNiEbEG2Fn=6oeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiXhaLpe7gHw6c8pCZDNeOC31WfxFum5G1RNiEbEG2Fn=6oeQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rajaram,

I'm sorry for the late reply.

On Mon, Sep 20, 2021 at 06:50:22PM +0530, Rajaram R wrote:
> On Fri, Sep 17, 2021 at 6:25 AM Badhri Jagan Sridharan
> <badhri@google.com> wrote:
> >
> > On Thu, Sep 16, 2021 at 7:12 AM Adam Thomson
> > <Adam.Thomson.Opensource@diasemi.com> wrote:
> > >
> > > On 16 September 2021 11:23, Heikki Krogerus wrote:
> > >
> > > > > Thanks for providing the clarification. So you're proposing a port-psy and a
> > > > > port-partner-psy that are connected to each other (one supplying the other).
> > > > > If PD is not present, those two will exist per port and partner, and there
> > > > > will be information about Type-C current (and possibly BC 1.2 and other
> > > > > methods?)
> > > >
> > > > Yes, exactly.
> 
> 
>  As Benson mentioned PDOs contain more than power details like USB
> Suspend indicator etc or Type-C only devices as Badhri mentioned here
> may not integrate well with PSY class.  Additionally, it is also
> important to consider cable properties here for power as they also
> have a role to play in the power limits and necessitates change of
> existing PDOs or power limits. ( Type-C Monitor charging a computing
> system does not have captive cables)
> 
> Given too many possibilities, would an approach similar to
> gadgetfs/configfs or cpu scaling say like "type-configfs" or "typec
> scaling" ABI framework that allows USB=C port management under one
> path /sys/class/typec that allows:
> 
> - Provision to manage USB-C port power (  Power supply class should
> still represent power contract established, as remaining
> characteristics are nested with functional aspects and relevant on a
> power contract failure )
> + dynamically change Rp ( Rp(default) is required to enter USB suspend)
> + Set PDO Policy ( PPS, Fixed, etc)
> + Give back power
> + Expose complete PDO ( As we do for VDOs)
> + Change USB Suspend flag
> 
> - Provision for extended messages
> + Provides additional details regarding ports like Get Status etc.
> This shall allow us to take system level decisions.
> 
> - Provision to manage USB-C modes
> + Provision to enter modes as provided by interface standards like UCSI
> 
> With this user tools like Chrome OS "typecd" be able to use a single
> class and its ABIs to manage USB-C port power and mode. Kindly correct
> me if I am missing something here.

So I agree that we should have secondary interface to the USB Type-C
ports, cables and partners, and I think the secondary interface should
be "usbpdfs", something similar to usbfs, that you can use to tap into
the protocol layer of the PD stack.

We have to interpret things especially with UCSI, since we can't even
communicate raw VDOs with UCSI, but it will still not be a huge
problem.

I'm quite certain that we should be able to solve a lot of the control
related problems that we now have (so basically lack of control) with
it, but more importantly we would then not need to figure out what is
the correct way to represent every single thing in sysfs in order to
utilise it.

I would imagine this could then at least ideally be the only interface
that also the typecd would need to deal with.

thanks,

-- 
heikki
