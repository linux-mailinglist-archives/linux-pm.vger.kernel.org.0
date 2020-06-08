Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8221E1F185A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 13:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgFHL7b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 07:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgFHL7a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 07:59:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579D4C08C5C3
        for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2020 04:59:30 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jiGQy-0001B8-8R; Mon, 08 Jun 2020 13:59:20 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1jiGQv-0000kM-9H; Mon, 08 Jun 2020 13:59:17 +0200
Date:   Mon, 8 Jun 2020 13:59:17 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Grant Likely <grant.likely@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        artem.bityutskiy@linux.intel.com, Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        nd <nd@arm.com>, Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
Message-ID: <20200608115917.f5dhazixnxunl5o5@pengutronix.de>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com>
 <20200326163110.GD1922688@smile.fi.intel.com>
 <20200608091712.GA28093@pengutronix.de>
 <CAHp75VfQvT1VSXhNtfLMLzwYcN+4g=jVRkBHc=ZS0180BRzAJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfQvT1VSXhNtfLMLzwYcN+4g=jVRkBHc=ZS0180BRzAJg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:56:43 up 206 days,  3:15, 203 users,  load average: 0.25, 0.17,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-06-08 14:13, Andy Shevchenko wrote:
> On Mon, Jun 8, 2020 at 12:20 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > On 20-03-26 18:31, Andy Shevchenko wrote:
> > > On Thu, Mar 26, 2020 at 03:01:22PM +0000, Grant Likely wrote:
> > > > On 25/03/2020 12:51, Andy Shevchenko wrote:
> > > > > On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
> > > > > > On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > Consider the following scenario.
> > > > > > >
> > > > > > > The main driver of USB OTG controller (dwc3-pci), which has the following
> > > > > > > functional dependencies on certain platform:
> > > > > > > - ULPI (tusb1210)
> > > > > > > - extcon (tested with extcon-intel-mrfld)
> > > > > > >
> > > > > > > Note, that first driver, tusb1210, is available at the moment of
> > > > > > > dwc3-pci probing, while extcon-intel-mrfld is built as a module and
> > > > > > > won't appear till user space does something about it.
> > > > > > >
> > > > > > > This is depicted by kernel configuration excerpt:
> > > > > > >
> > > > > > >       CONFIG_PHY_TUSB1210=y
> > > > > > >       CONFIG_USB_DWC3=y
> > > > > > >       CONFIG_USB_DWC3_ULPI=y
> > > > > > >       CONFIG_USB_DWC3_DUAL_ROLE=y
> > > > > > >       CONFIG_USB_DWC3_PCI=y
> > > > > > >       CONFIG_EXTCON_INTEL_MRFLD=m
> > > > > > >
> > > > > > > In the Buildroot environment the modules are probed by alphabetical ordering
> > > > > > > of their modaliases. The latter comes to the case when USB OTG driver will be
> > > > > > > probed first followed by extcon one.
> > > > > > >
> > > > > > > So, if the platform anticipates extcon device to be appeared, in the above case
> > > > > > > we will get deferred probe of USB OTG, because of ordering.
> > > > > > >
> > > > > > > Since current implementation, done by the commit 58b116bce136 ("drivercore:
> > > > > > > deferral race condition fix") counts the amount of triggered deferred probe,
> > > > > > > we never advance the situation -- the change makes it to be an infinite loop.
> > > > > >
> > > > > > Hi Andy,
> > > > > >
> > > > > > I'm trying to understand this sequence of steps. Sorry if the questions
> > > > > > are stupid -- I'm not very familiar with USB/PCI stuff.
> > > > >
> > > > > Thank you for looking into this. My answer below.
> > > > >
> > > > > As a first thing I would like to tell that there is another example of bad
> > > > > behaviour of deferred probe with no relation to USB. The proposed change also
> > > > > fixes that one (however, less possible to find in real life).
> > > > >
> > > > > > > ---8<---8<---
> > > > > > >
> > > > > > > [   22.187127] driver_deferred_probe_trigger <<< 1
> > > > > > >
> > > > > > > ...here is the late initcall triggers deferred probe...
> > > > > > >
> > > > > > > [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
> > > > > > >
> > > > > > > ...dwc3.0.auto is the only device in the deferred list...
> > > > > >
> > > > > > Ok, dwc3.0.auto is the only unprobed device at this point?
> > > > >
> > > > > Correct.
> > > > >
> > > > > > > [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
> > > > > > >
> > > > > > > ...the counter before mutex is unlocked is kept the same...
> > > > > > >
> > > > > > > [   22.205663] platform dwc3.0.auto: Retrying from deferred list
> > > > > > >
> > > > > > > ...mutes has been unlocked, we try to re-probe the driver...
> > > > > > >
> > > > > > > [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
> > > > > > > [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
> > > > > > > [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
> > > > > > > [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
> > > > > > > [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
> > > > > > > [   22.263723] driver_deferred_probe_trigger <<< 2
> > > > > > >
> > > > > > > ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
> > > > > > >
> > > > > > > [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
> > > > > >
> > > > > > So where did this dwc3.0.auto.ulpi come from?
> > > > >
> > > > > > Looks like the device is created by dwc3_probe() through this call flow:
> > > > > > dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
> > > > > > dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
> > > > >
> > > > > Correct.
> > > > >
> > > > > > > [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > > > > >
> > > > > > Can you please point me to which code patch actually caused the probe
> > > > > > deferral?
> > > > >
> > > > > Sure, it's in drd.c.
> > > > >
> > > > > if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> > > > >    edev = extcon_get_extcon_dev(name);
> > > > >    if (!edev)
> > > > >      return ERR_PTR(-EPROBE_DEFER);
> > > > >    return edev;
> > > > > }
> > > > >
> > > > > > > ...but extcon driver is still missing...
> > > > > > >
> > > > > > > [   22.283174] platform dwc3.0.auto: Added to deferred list
> > > > > > > [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
> > > > > >
> > > > > > I'm not fully aware of all the USB implications, but if extcon is
> > > > > > needed, why can't that check be done before we add and probe the ulpi
> > > > > > device? That'll avoid this whole "fake" probing and avoid the counter
> > > > > > increase. And avoid the need for this patch that's touching the code
> > > > > > code that's already a bit delicate.
> > > > >
> > > > > > Also, with my limited experience with all the possible drivers in the
> > > > > > kernel, it's weird that the ulpi device is added and probed before we
> > > > > > make sure the parent device (dwc3.0.auto) can actually probe
> > > > > > successfully.
> > > > >
> > > > > As I said above the deferred probe trigger has flaw on its own.
> > > > > Even if we fix for USB case, there is (and probably will be) others.
> > > >
> > > > Right here is the driver design bug. A driver's probe() hook should *not*
> > > > return -EPROBE_DEFER after already creating child devices which may have
> > > > already been probed.
> > >
> > > Any documentation statement for this requirement?
> > >
> > > By the way, I may imagine other mechanisms that probe the driver on other CPU
> > > at the same time (let's consider parallel modprobes). The current code has a
> > > flaw with that.
> >
> > Hi,
> >
> > sorry for picking this up again but I stumbled above the same issue
> > within the driver imx/drm driver which is using the component framework.
> > I end up in a infinity boot loop if I enabled the HDMI (which is the
> > DesignWare bridge device) and the LVDS support and the LVDS bind return
> > with EPROBE_DEFER. There are no words within the component framework docs
> > which says that this is forbidden. Of course we can work-around the
> > driver-core framework but IMHO this shouldn't be the way to go. I do not
> > say that we should revert the commit introducing the regression but we
> > should address this not only by extending the docs since the most
> > drm-drivers are using the component framework and can end up in the same
> > situation.
> >
> > > > It can be solved by refactoring the driver probe routine. If a resource is
> > > > required to be present, then check that it is available early; before
> > > > registering child devices.
> > >
> > > We fix one and leave others.
> >
> > E.g. the imx-drm and the sunxi driver...
> 
> Just out of curiosity, does my patch fix an issue for you?

I didn't applied your patch yet. I can test it if you want.

Regards,
  Marco

> > > > The proposed solution to modify driver core is fragile and susceptible to
> > > > side effects from other probe paths. I don't think it is the right approach.
> > >
> > > Have you tested it on your case? Does it fix the issue?
