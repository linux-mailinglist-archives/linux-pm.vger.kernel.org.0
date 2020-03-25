Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E31928E2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 13:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCYMvW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 08:51:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:41398 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgCYMvW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 08:51:22 -0400
IronPort-SDR: ReFhl/8dJkKl3Sh4AR0pR/HAJ9Q9dDdK7HMBtQ3jMzTs9OtfNB00nDQK4UWi03VQOXhuQnjasy
 LmMvNeFaC44w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 05:51:21 -0700
IronPort-SDR: 4UGOnkfEhu4Ai8WJKJ2ypyQu+d+OroBtb+6YtpHLTuRjp98guUTsQehfiURK8bHRpDek9WlnAC
 deR7pdkEcGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="448255548"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 25 Mar 2020 05:51:18 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jH5VA-00Couf-OH; Wed, 25 Mar 2020 14:51:20 +0200
Date:   Wed, 25 Mar 2020 14:51:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     a.hajda@samsung.com, artem.bityutskiy@linux.intel.com,
        balbi@kernel.org, broonie@kernel.org, fntoth@gmail.com,
        grant.likely@arm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peter.ujfalusi@ti.com, rafael@kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
Message-ID: <20200325125120.GX1922688@smile.fi.intel.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325032901.29551-1-saravanak@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > Consider the following scenario.
> > 
> > The main driver of USB OTG controller (dwc3-pci), which has the following
> > functional dependencies on certain platform:
> > - ULPI (tusb1210)
> > - extcon (tested with extcon-intel-mrfld)
> > 
> > Note, that first driver, tusb1210, is available at the moment of
> > dwc3-pci probing, while extcon-intel-mrfld is built as a module and
> > won't appear till user space does something about it.
> > 
> > This is depicted by kernel configuration excerpt:
> > 
> >	CONFIG_PHY_TUSB1210=y
> >	CONFIG_USB_DWC3=y
> >	CONFIG_USB_DWC3_ULPI=y
> >	CONFIG_USB_DWC3_DUAL_ROLE=y
> >	CONFIG_USB_DWC3_PCI=y
> >	CONFIG_EXTCON_INTEL_MRFLD=m
> > 
> > In the Buildroot environment the modules are probed by alphabetical ordering
> > of their modaliases. The latter comes to the case when USB OTG driver will be
> > probed first followed by extcon one.
> > 
> > So, if the platform anticipates extcon device to be appeared, in the above case
> > we will get deferred probe of USB OTG, because of ordering.
> > 
> > Since current implementation, done by the commit 58b116bce136 ("drivercore:
> > deferral race condition fix") counts the amount of triggered deferred probe,
> > we never advance the situation -- the change makes it to be an infinite loop.
> 
> Hi Andy,
> 
> I'm trying to understand this sequence of steps. Sorry if the questions
> are stupid -- I'm not very familiar with USB/PCI stuff.

Thank you for looking into this. My answer below.

As a first thing I would like to tell that there is another example of bad
behaviour of deferred probe with no relation to USB. The proposed change also
fixes that one (however, less possible to find in real life).

> > ---8<---8<---
> > 
> > [   22.187127] driver_deferred_probe_trigger <<< 1
> > 
> > ...here is the late initcall triggers deferred probe...
> > 
> > [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
> > 
> > ...dwc3.0.auto is the only device in the deferred list...
> 
> Ok, dwc3.0.auto is the only unprobed device at this point?

Correct.

> > [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
> > 
> > ...the counter before mutex is unlocked is kept the same...
> > 
> > [   22.205663] platform dwc3.0.auto: Retrying from deferred list
> > 
> > ...mutes has been unlocked, we try to re-probe the driver...
> > 
> > [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
> > [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
> > [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
> > [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
> > [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
> > [   22.263723] driver_deferred_probe_trigger <<< 2
> > 
> > ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
> > 
> > [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
> 
> So where did this dwc3.0.auto.ulpi come from?

> Looks like the device is created by dwc3_probe() through this call flow:
> dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
> dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()

Correct.

> > [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> 
> Can you please point me to which code patch actually caused the probe
> deferral?

Sure, it's in drd.c.

if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
  edev = extcon_get_extcon_dev(name);
  if (!edev)
    return ERR_PTR(-EPROBE_DEFER);
  return edev;
}

> > ...but extcon driver is still missing...
> > 
> > [   22.283174] platform dwc3.0.auto: Added to deferred list
> > [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
> 
> I'm not fully aware of all the USB implications, but if extcon is
> needed, why can't that check be done before we add and probe the ulpi
> device? That'll avoid this whole "fake" probing and avoid the counter
> increase. And avoid the need for this patch that's touching the code
> code that's already a bit delicate.

> Also, with my limited experience with all the possible drivers in the
> kernel, it's weird that the ulpi device is added and probed before we
> make sure the parent device (dwc3.0.auto) can actually probe
> successfully.

As I said above the deferred probe trigger has flaw on its own.
Even if we fix for USB case, there is (and probably will be) others.

> Most of the platform device code I've seen in systems with OF (device
> tree) add the child devices towards the end of the parent's probe
> function.

> > ...and since we had a successful probe, we got counter mismatch...
> > 
> > [   22.297490] driver_deferred_probe_trigger <<< 3
> > [   22.302074] platform dwc3.0.auto: deferred_probe_work_func 2 <<< counter 3
> > 
> > ...at the end we have a new counter and loop repeats again, see 22.198727...
> > 
> > ---8<---8<---
> > 
> > Revert of the commit helps, but it is probably not helpful for the initially
> > found regression. Artem Bityutskiy suggested to use counter of the successful
> > probes instead. This fixes above mentioned case and shouldn't prevent driver
> > to reprobe deferred ones.
> > 
> > Under "successful probe" we understand the state when a driver of the certain
> > device is being kept bound after deferred probe trigger cycle. For instance,
> > in the above mentioned case probing of tusb1210 is not successful because dwc3
> > driver unbinds device dwc3.0.auto.ulpi. The atomic_dec() call is used to keep
> > track of this. The amount of bindings is always great than or equal to the
> > amount of unbindings as guaranteed by design of the driver binding mechanism.
> 
> The unbindings count can increase for other unrelated drivers unbinding
> too. Wouldn't it? Seems a bit fragile and racy in a fashion similar to
> the issue the original patch was trying to fix.

Yes, it's (unlikely) possible (*), but it will give one more iteration per such
case. It's definitely better than infinite loop. Do you agree?

*) It means during probe you have _intensive_ removing, of course you may keep
kernel busy with iterations, but it has no practical sense. DoS attacks more
effective in different ways.

-- 
With Best Regards,
Andy Shevchenko


