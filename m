Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8E1F175C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 13:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgFHLNm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 07:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbgFHLNm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 07:13:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEE6C08C5C2;
        Mon,  8 Jun 2020 04:13:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so6538718plt.5;
        Mon, 08 Jun 2020 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKXPhoY6HVJeNlOao56Nm2X+3XpuuTaKzxedeSCFrv0=;
        b=jZXBlIsP62TU5pcs0aK7YgjsFwD5EJieJvYD3TknKQqsM8DXuutppMUuoF+oYjySRY
         wnfwFS72fq9laUI4r9SgrU/THu8FhAbxcVDcy8tLI9n2cmRgGgTyOpf9TtuLaljwW9zl
         MIvJ3qjiUy/Eqg9kl9wO3bI6ZQUsBii0CT90idIy6TqbKG8/0gXKTNUBU/cVw5VFTOmr
         2iq92uFwol0vhIL1GPB6aDFpze7qUbR+ACE5i2WxxybYlM8hBjej7NphNUzNkSl0NPN1
         kdp37kUxQ8qhbv5Sk1KkV4ziXYzYZwLDM9/AU96yr6DXN60aLoNfovrnHta+Pa43G/to
         Cg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKXPhoY6HVJeNlOao56Nm2X+3XpuuTaKzxedeSCFrv0=;
        b=nxKaWQGChmagGVt1jdCHzXQlr0TuQ0Z9KUhTcxzGt4yoBPI0hlPqfoSqZR2MtLsUmK
         qQynKBVKHs1Ec3nVB0ElD/xnQ3NZq4oTH7GE51B9laSW7EY0tdvs7bUDo5+39G/FRDAg
         j281Hp6uDKYn4JWiG6nxrTO0LRnSEmxycVpSJZG/9PFTQwapSntPXS9PNj/UlX/LHBco
         Z0LZ19A3Jlk0S7cFldTtTO547jUrSit/Q/Si34NiiY25saOmeU09qXopwh2wnnvRdNS8
         KaSllVTnNwyUUZem5JVV9IdjtjBWLjj3i+UDEBbqek7SEQ5DsNs8hYcSM+4TrXJ4gUHS
         pPrA==
X-Gm-Message-State: AOAM531m2kRV9v17RYT14lgJAUOWgI7Y7dOMdBlMtlupnXkB8JA/bYUx
        vWpuVpjC686pXXpmcKCS+/9U0inyOSVQko+nR68=
X-Google-Smtp-Source: ABdhPJwcOamXWVnHkSAxITqb9OzSjvYDeJXplnj5BKTotJxscWgbamqbstckEmW62K3N060UBzoCi5pQy5uoGNSsrJM=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr16962010pjq.228.1591614821799;
 Mon, 08 Jun 2020 04:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com> <20200325125120.GX1922688@smile.fi.intel.com>
 <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com> <20200326163110.GD1922688@smile.fi.intel.com>
 <20200608091712.GA28093@pengutronix.de>
In-Reply-To: <20200608091712.GA28093@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Jun 2020 14:13:30 +0300
Message-ID: <CAHp75VfQvT1VSXhNtfLMLzwYcN+4g=jVRkBHc=ZS0180BRzAJg@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Marco Felsch <m.felsch@pengutronix.de>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 8, 2020 at 12:20 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> On 20-03-26 18:31, Andy Shevchenko wrote:
> > On Thu, Mar 26, 2020 at 03:01:22PM +0000, Grant Likely wrote:
> > > On 25/03/2020 12:51, Andy Shevchenko wrote:
> > > > On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
> > > > > On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > Consider the following scenario.
> > > > > >
> > > > > > The main driver of USB OTG controller (dwc3-pci), which has the following
> > > > > > functional dependencies on certain platform:
> > > > > > - ULPI (tusb1210)
> > > > > > - extcon (tested with extcon-intel-mrfld)
> > > > > >
> > > > > > Note, that first driver, tusb1210, is available at the moment of
> > > > > > dwc3-pci probing, while extcon-intel-mrfld is built as a module and
> > > > > > won't appear till user space does something about it.
> > > > > >
> > > > > > This is depicted by kernel configuration excerpt:
> > > > > >
> > > > > >       CONFIG_PHY_TUSB1210=y
> > > > > >       CONFIG_USB_DWC3=y
> > > > > >       CONFIG_USB_DWC3_ULPI=y
> > > > > >       CONFIG_USB_DWC3_DUAL_ROLE=y
> > > > > >       CONFIG_USB_DWC3_PCI=y
> > > > > >       CONFIG_EXTCON_INTEL_MRFLD=m
> > > > > >
> > > > > > In the Buildroot environment the modules are probed by alphabetical ordering
> > > > > > of their modaliases. The latter comes to the case when USB OTG driver will be
> > > > > > probed first followed by extcon one.
> > > > > >
> > > > > > So, if the platform anticipates extcon device to be appeared, in the above case
> > > > > > we will get deferred probe of USB OTG, because of ordering.
> > > > > >
> > > > > > Since current implementation, done by the commit 58b116bce136 ("drivercore:
> > > > > > deferral race condition fix") counts the amount of triggered deferred probe,
> > > > > > we never advance the situation -- the change makes it to be an infinite loop.
> > > > >
> > > > > Hi Andy,
> > > > >
> > > > > I'm trying to understand this sequence of steps. Sorry if the questions
> > > > > are stupid -- I'm not very familiar with USB/PCI stuff.
> > > >
> > > > Thank you for looking into this. My answer below.
> > > >
> > > > As a first thing I would like to tell that there is another example of bad
> > > > behaviour of deferred probe with no relation to USB. The proposed change also
> > > > fixes that one (however, less possible to find in real life).
> > > >
> > > > > > ---8<---8<---
> > > > > >
> > > > > > [   22.187127] driver_deferred_probe_trigger <<< 1
> > > > > >
> > > > > > ...here is the late initcall triggers deferred probe...
> > > > > >
> > > > > > [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
> > > > > >
> > > > > > ...dwc3.0.auto is the only device in the deferred list...
> > > > >
> > > > > Ok, dwc3.0.auto is the only unprobed device at this point?
> > > >
> > > > Correct.
> > > >
> > > > > > [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
> > > > > >
> > > > > > ...the counter before mutex is unlocked is kept the same...
> > > > > >
> > > > > > [   22.205663] platform dwc3.0.auto: Retrying from deferred list
> > > > > >
> > > > > > ...mutes has been unlocked, we try to re-probe the driver...
> > > > > >
> > > > > > [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
> > > > > > [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
> > > > > > [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
> > > > > > [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
> > > > > > [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
> > > > > > [   22.263723] driver_deferred_probe_trigger <<< 2
> > > > > >
> > > > > > ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
> > > > > >
> > > > > > [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
> > > > >
> > > > > So where did this dwc3.0.auto.ulpi come from?
> > > >
> > > > > Looks like the device is created by dwc3_probe() through this call flow:
> > > > > dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
> > > > > dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
> > > >
> > > > Correct.
> > > >
> > > > > > [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > > > >
> > > > > Can you please point me to which code patch actually caused the probe
> > > > > deferral?
> > > >
> > > > Sure, it's in drd.c.
> > > >
> > > > if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> > > >    edev = extcon_get_extcon_dev(name);
> > > >    if (!edev)
> > > >      return ERR_PTR(-EPROBE_DEFER);
> > > >    return edev;
> > > > }
> > > >
> > > > > > ...but extcon driver is still missing...
> > > > > >
> > > > > > [   22.283174] platform dwc3.0.auto: Added to deferred list
> > > > > > [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
> > > > >
> > > > > I'm not fully aware of all the USB implications, but if extcon is
> > > > > needed, why can't that check be done before we add and probe the ulpi
> > > > > device? That'll avoid this whole "fake" probing and avoid the counter
> > > > > increase. And avoid the need for this patch that's touching the code
> > > > > code that's already a bit delicate.
> > > >
> > > > > Also, with my limited experience with all the possible drivers in the
> > > > > kernel, it's weird that the ulpi device is added and probed before we
> > > > > make sure the parent device (dwc3.0.auto) can actually probe
> > > > > successfully.
> > > >
> > > > As I said above the deferred probe trigger has flaw on its own.
> > > > Even if we fix for USB case, there is (and probably will be) others.
> > >
> > > Right here is the driver design bug. A driver's probe() hook should *not*
> > > return -EPROBE_DEFER after already creating child devices which may have
> > > already been probed.
> >
> > Any documentation statement for this requirement?
> >
> > By the way, I may imagine other mechanisms that probe the driver on other CPU
> > at the same time (let's consider parallel modprobes). The current code has a
> > flaw with that.
>
> Hi,
>
> sorry for picking this up again but I stumbled above the same issue
> within the driver imx/drm driver which is using the component framework.
> I end up in a infinity boot loop if I enabled the HDMI (which is the
> DesignWare bridge device) and the LVDS support and the LVDS bind return
> with EPROBE_DEFER. There are no words within the component framework docs
> which says that this is forbidden. Of course we can work-around the
> driver-core framework but IMHO this shouldn't be the way to go. I do not
> say that we should revert the commit introducing the regression but we
> should address this not only by extending the docs since the most
> drm-drivers are using the component framework and can end up in the same
> situation.
>
> > > It can be solved by refactoring the driver probe routine. If a resource is
> > > required to be present, then check that it is available early; before
> > > registering child devices.
> >
> > We fix one and leave others.
>
> E.g. the imx-drm and the sunxi driver...

Just out of curiosity, does my patch fix an issue for you?

> > > The proposed solution to modify driver core is fragile and susceptible to
> > > side effects from other probe paths. I don't think it is the right approach.
> >
> > Have you tested it on your case? Does it fix the issue?

-- 
With Best Regards,
Andy Shevchenko
