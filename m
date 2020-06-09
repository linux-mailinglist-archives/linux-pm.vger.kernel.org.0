Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614B01F34DA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 09:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgFIHam (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 03:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFIHal (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 03:30:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC11C05BD43
        for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2020 00:30:41 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v13so15851083otp.4
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2020 00:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLy6eUAtGnvNRuBVPLvPPB4x/ePRcKM+zvqM1T2LZ1g=;
        b=G9DZqTNsJ9rRPo1qFjn0ejXsJ/PEaeRaEI3op7x6r3leM1lkET9P1YKIouZkm78mNU
         IF4AfftHN6zFAGasCVGrKTwwFFlMHYabdg01TMhJKsONUZPZSOZuAu2vuLAcsBzJg65Q
         SW0nqO3ImY/DSaRUDo7g+Et3OjamaO6pPleDy/2S/+nde/jU327BhOTor2wa7nJ71D/N
         1HKpLYOzQLE5/4rtINe2uez0Hw3hMBetrNlqX/wcJLLLzHVD+3DN3KoKTgAHImXaVZ88
         FN+A/8Jn20aTRw0gFqIPuOO5DT1pvAFe5xQJSqcEXYGrf0vMCZ3Fh+mHF1t/WXN9HcEN
         kM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLy6eUAtGnvNRuBVPLvPPB4x/ePRcKM+zvqM1T2LZ1g=;
        b=AmccCi/6e3VTNAzmMTTXFWlQne6F7ZV3/wbamXZF5kH3V5P3VufaINVd3u1S0ll0lR
         gohkyltZSVUdnI1KTwFRN7mXVmCcMzvUrCYqwv3vz1DceM+pJAweDctgxz+4TSUDdSeb
         4jZxypW7eUO1SSdJmz67UCX8nA9uVRh8E3/kx0e2t6+LFz/FkEtfkhH+S/JqBafqJOYR
         JXToSVG25g0gfOCXKT0arSmglIvEsNPsvWPcLdbyHt8WMa0BhuYhMqsKw8sweyXET0kM
         yS2ymLV41PGMOZDNmYasnBlZtSf1NnR8ndoZ87TA8sAkzTocltDJ6BHf9/mMAPcSUZ6a
         +zeg==
X-Gm-Message-State: AOAM530LSD4p1Ddn4mOpi8+5cagvWRbUdCw3gWjvbUPhlj1N5MjjDxmy
        MSj07Q2AXSybhiedwxO1RabIuiJi6vpl5rMssvTasA==
X-Google-Smtp-Source: ABdhPJxNel+xLmjescDVgnDxwc3G58F00Eh5cXcECAB3ybXX8qsMRqhkBZB7YK/1aDeKtxe22HFH2wiKnNnXB2J/llA=
X-Received: by 2002:a9d:6048:: with SMTP id v8mr15461661otj.231.1591687840358;
 Tue, 09 Jun 2020 00:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com> <20200325125120.GX1922688@smile.fi.intel.com>
 <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com> <20200326163110.GD1922688@smile.fi.intel.com>
 <CGME20200608091722eucas1p2fa8a4ac15c70e5a6e03c4babdf9f96b7@eucas1p2.samsung.com>
 <20200608091712.GA28093@pengutronix.de> <437de51b-37e9-d8d1-19c7-137a9265bf45@samsung.com>
 <20200609064511.7nek2rhk6ebfjaia@pengutronix.de>
In-Reply-To: <20200609064511.7nek2rhk6ebfjaia@pengutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 9 Jun 2020 00:30:04 -0700
Message-ID: <CAGETcx_aSnVfdng5U7s7KNABxNwQQTuZXMWwUi7SPDNMJDh1bw@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Grant Likely <grant.likely@arm.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        nd <nd@arm.com>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 8, 2020 at 11:45 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> On 20-06-08 13:11, Andrzej Hajda wrote:
> >
> > On 08.06.2020 11:17, Marco Felsch wrote:
> > > On 20-03-26 18:31, Andy Shevchenko wrote:
> > >> On Thu, Mar 26, 2020 at 03:01:22PM +0000, Grant Likely wrote:
> > >>> On 25/03/2020 12:51, Andy Shevchenko wrote:
> > >>>> On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
> > >>>>> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >>>>>> Consider the following scenario.
> > >>>>>>
> > >>>>>> The main driver of USB OTG controller (dwc3-pci), which has the following
> > >>>>>> functional dependencies on certain platform:
> > >>>>>> - ULPI (tusb1210)
> > >>>>>> - extcon (tested with extcon-intel-mrfld)
> > >>>>>>
> > >>>>>> Note, that first driver, tusb1210, is available at the moment of
> > >>>>>> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
> > >>>>>> won't appear till user space does something about it.
> > >>>>>>
> > >>>>>> This is depicted by kernel configuration excerpt:
> > >>>>>>
> > >>>>>>        CONFIG_PHY_TUSB1210=y
> > >>>>>>        CONFIG_USB_DWC3=y
> > >>>>>>        CONFIG_USB_DWC3_ULPI=y
> > >>>>>>        CONFIG_USB_DWC3_DUAL_ROLE=y
> > >>>>>>        CONFIG_USB_DWC3_PCI=y
> > >>>>>>        CONFIG_EXTCON_INTEL_MRFLD=m
> > >>>>>>
> > >>>>>> In the Buildroot environment the modules are probed by alphabetical ordering
> > >>>>>> of their modaliases. The latter comes to the case when USB OTG driver will be
> > >>>>>> probed first followed by extcon one.
> > >>>>>>
> > >>>>>> So, if the platform anticipates extcon device to be appeared, in the above case
> > >>>>>> we will get deferred probe of USB OTG, because of ordering.
> > >>>>>>
> > >>>>>> Since current implementation, done by the commit 58b116bce136 ("drivercore:
> > >>>>>> deferral race condition fix") counts the amount of triggered deferred probe,
> > >>>>>> we never advance the situation -- the change makes it to be an infinite loop.
> > >>>>> Hi Andy,
> > >>>>>
> > >>>>> I'm trying to understand this sequence of steps. Sorry if the questions
> > >>>>> are stupid -- I'm not very familiar with USB/PCI stuff.
> > >>>> Thank you for looking into this. My answer below.
> > >>>>
> > >>>> As a first thing I would like to tell that there is another example of bad
> > >>>> behaviour of deferred probe with no relation to USB. The proposed change also
> > >>>> fixes that one (however, less possible to find in real life).
> > >>>>
> > >>>>>> ---8<---8<---
> > >>>>>>
> > >>>>>> [   22.187127] driver_deferred_probe_trigger <<< 1
> > >>>>>>
> > >>>>>> ...here is the late initcall triggers deferred probe...
> > >>>>>>
> > >>>>>> [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
> > >>>>>>
> > >>>>>> ...dwc3.0.auto is the only device in the deferred list...
> > >>>>> Ok, dwc3.0.auto is the only unprobed device at this point?
> > >>>> Correct.
> > >>>>
> > >>>>>> [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
> > >>>>>>
> > >>>>>> ...the counter before mutex is unlocked is kept the same...
> > >>>>>>
> > >>>>>> [   22.205663] platform dwc3.0.auto: Retrying from deferred list
> > >>>>>>
> > >>>>>> ...mutes has been unlocked, we try to re-probe the driver...
> > >>>>>>
> > >>>>>> [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
> > >>>>>> [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
> > >>>>>> [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
> > >>>>>> [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
> > >>>>>> [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
> > >>>>>> [   22.263723] driver_deferred_probe_trigger <<< 2
> > >>>>>>
> > >>>>>> ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
> > >>>>>>
> > >>>>>> [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
> > >>>>> So where did this dwc3.0.auto.ulpi come from?
> > >>>>> Looks like the device is created by dwc3_probe() through this call flow:
> > >>>>> dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
> > >>>>> dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
> > >>>> Correct.
> > >>>>
> > >>>>>> [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > >>>>> Can you please point me to which code patch actually caused the probe
> > >>>>> deferral?
> > >>>> Sure, it's in drd.c.
> > >>>>
> > >>>> if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> > >>>>     edev = extcon_get_extcon_dev(name);
> > >>>>     if (!edev)
> > >>>>       return ERR_PTR(-EPROBE_DEFER);
> > >>>>     return edev;
> > >>>> }
> > >>>>
> > >>>>>> ...but extcon driver is still missing...
> > >>>>>>
> > >>>>>> [   22.283174] platform dwc3.0.auto: Added to deferred list
> > >>>>>> [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
> > >>>>> I'm not fully aware of all the USB implications, but if extcon is
> > >>>>> needed, why can't that check be done before we add and probe the ulpi
> > >>>>> device? That'll avoid this whole "fake" probing and avoid the counter
> > >>>>> increase. And avoid the need for this patch that's touching the code
> > >>>>> code that's already a bit delicate.
> > >>>>> Also, with my limited experience with all the possible drivers in the
> > >>>>> kernel, it's weird that the ulpi device is added and probed before we
> > >>>>> make sure the parent device (dwc3.0.auto) can actually probe
> > >>>>> successfully.
> > >>>> As I said above the deferred probe trigger has flaw on its own.
> > >>>> Even if we fix for USB case, there is (and probably will be) others.
> > >>> Right here is the driver design bug. A driver's probe() hook should *not*
> > >>> return -EPROBE_DEFER after already creating child devices which may have
> > >>> already been probed.
> > >> Any documentation statement for this requirement?
> > >>
> > >> By the way, I may imagine other mechanisms that probe the driver on other CPU
> > >> at the same time (let's consider parallel modprobes). The current code has a
> > >> flaw with that.
> > > Hi,
> > >
> > > sorry for picking this up again but I stumbled above the same issue
> > > within the driver imx/drm driver which is using the component framework.
> > > I end up in a infinity boot loop if I enabled the HDMI (which is the
> > > DesignWare bridge device) and the LVDS support and the LVDS bind return
> > > with EPROBE_DEFER. There are no words within the component framework docs
> > > which says that this is forbidden. Of course we can work-around the
> > > driver-core framework but IMHO this shouldn't be the way to go. I do not
> > > say that we should revert the commit introducing the regression but we
> > > should address this not only by extending the docs since the most
> > > drm-drivers are using the component framework and can end up in the same
> > > situation.
> >
> > I am not sure why do you think this is similar issue.
>
> Because I see trying to bind the device over and over..
>
> > Please describe the issue in more detail. Which drivers defers probe and
> > why, and why do you have infinite loop.
>
> As said I'm currently on the imx-drm driver. The iMX6 devices are
> using the synopsis HDMI IP core and so they are using this bridge device
> driver (drivers/gpu/drm/bridge/synopsys/). The imx-drm driver can be
> build module wise. As example I enabled the LDB and the HDMI support.
> The HDMI driver is composed as platform driver with different
> (sub-)drivers and devices. Those devices are populated by the HDMI core
> driver _probe() function and triggers a driver_deferred_probe_trigger()
> after the driver successfully probed. The LDB driver bind() returns
> -EPROBE_DEFER because the panel we are looking for depends on a defered
> regulator device. Now the defered probe code tries to probe the defered
> devices again because the local-trigger count was changed by the HDMI
> driver and we are in the never ending loop.
>
> > In general deferring probe from bind is not forbidden, but it should be
> > used carefully (as everything in kernel :) ). Fixing deferring probe
> > issues in many cases it is a matter of figuring out 'dependency loops'
> > and breaking them by splitting device initialization into more than one
> > phase.
>
> We are on the way of splitting the imx-drm driver but there are many
> other DRM drivers using the component framework. As far as I can see the
> sunxi8 driver is component based and uses the same HDMI driver. I'm with
> Andy that we should fix that on the common/core place.

I'm not opposed to fixing this at the common/core level if that's
possible, but Andy's patch still has a bug where it might never probe
a device. I still haven't seen an answer to this.
https://lore.kernel.org/lkml/CAGETcx_3+YH_LmNUCAAk1OaXk6noHEXxcE+ckkoBqKJJhtpDjQ@mail.gmail.com/

-Saravana
