Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684DC194802
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 20:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgCZT4N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 15:56:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37283 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgCZT4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 15:56:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id u20so1960097oic.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7QzDUhfwhoGkLZ3zOdU9l1vGMKm29JvohHiM8YvFao=;
        b=BujfbLdPFBmzFoZbb00nCNM0ZruUKmCKibDCfwIAlqWJtdycm4MywllZGQGIHWKq7B
         fcclCvY3YwQvgvNkzQsGDtzbD9eGUV6q1es4smHMC/mIYSfGtHYFJ2dw1vD+E//eNEG1
         HiwDbnis+MgYiUlA8yoBU1rADvjJtgTgumyaWDHPBlouI939SiRloAq9uJN5eQ3mdB6p
         x+4EckDe1RF6WXRLO9PwkYpUqrITHPlskET+DScWgmW0RQSbX5i24PGXm1jcDp12KzQx
         iNu9V22UQ3WEY4yHQpeSRcDH3W88TUOdQxT2yzPeewuWYgpBv1PwTLDKR5liNqTTBGM3
         c19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7QzDUhfwhoGkLZ3zOdU9l1vGMKm29JvohHiM8YvFao=;
        b=KFdOhMK1icXL03ZvuxdqolGr5beH3fW3taxBXxFFESciEaAw712wkRmLnDlDZtQvzq
         Oy5m3PxboK6ETddhyqxBB6tfOJF0r/oh1aJo3VHaHOyM8jf3aJ7bRwmWBzCyGbrtqNZD
         6oGnJJO3NGL5iskobZEaaAoPpgg2UzMQdJmBH7HbsGohtGA19D8Vry0Rkkq9nv9KRn8p
         cG510gauNufERgdcL1xW3XrKpBWj77Ip2XTfCZZNjIL6gzRhw3KJM+Qgz6dVmpngjcw5
         jZuhVknImQRzPAQ2PIaH1FNFMAzuxileXfdjdBC5oYBDMGxAg5YzhP592ZiaZuWl/DJ9
         vGew==
X-Gm-Message-State: ANhLgQ390v0xI9sh9fQlzGIlZ/+WtQVx14SiNEFrhtCBgSH/F+Rc7igA
        nLZt+zMW8+hCsjF7OCaJ02Co4IzIg7whe4UjUgTc0A==
X-Google-Smtp-Source: ADFU+vuWVAeBxu9vm7NWou8KbIUNngFj9VIP9GdvfAIZd/0l2EIzprBFVrvbFEzn6tBQH/wl8pa9nO0qss/DHbpFyJc=
X-Received: by 2002:aca:849:: with SMTP id 70mr1553894oii.30.1585252571292;
 Thu, 26 Mar 2020 12:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com> <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com> <20200326115431.GP1922688@smile.fi.intel.com>
In-Reply-To: <20200326115431.GP1922688@smile.fi.intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 26 Mar 2020 12:55:34 -0700
Message-ID: <CAGETcx_3+YH_LmNUCAAk1OaXk6noHEXxcE+ckkoBqKJJhtpDjQ@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        grant.likely@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 26, 2020 at 4:54 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 25, 2020 at 03:08:29PM -0700, Saravana Kannan wrote:
> > On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
> > > > On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > Consider the following scenario.
> > > > >
> > > > > The main driver of USB OTG controller (dwc3-pci), which has the following
> > > > > functional dependencies on certain platform:
> > > > > - ULPI (tusb1210)
> > > > > - extcon (tested with extcon-intel-mrfld)
> > > > >
> > > > > Note, that first driver, tusb1210, is available at the moment of
> > > > > dwc3-pci probing, while extcon-intel-mrfld is built as a module and
> > > > > won't appear till user space does something about it.
> > > > >
> > > > > This is depicted by kernel configuration excerpt:
> > > > >
> > > > >     CONFIG_PHY_TUSB1210=y
> > > > >     CONFIG_USB_DWC3=y
> > > > >     CONFIG_USB_DWC3_ULPI=y
> > > > >     CONFIG_USB_DWC3_DUAL_ROLE=y
> > > > >     CONFIG_USB_DWC3_PCI=y
> > > > >     CONFIG_EXTCON_INTEL_MRFLD=m
> > > > >
> > > > > In the Buildroot environment the modules are probed by alphabetical ordering
> > > > > of their modaliases. The latter comes to the case when USB OTG driver will be
> > > > > probed first followed by extcon one.
> > > > >
> > > > > So, if the platform anticipates extcon device to be appeared, in the above case
> > > > > we will get deferred probe of USB OTG, because of ordering.
> > > > >
> > > > > Since current implementation, done by the commit 58b116bce136 ("drivercore:
> > > > > deferral race condition fix") counts the amount of triggered deferred probe,
> > > > > we never advance the situation -- the change makes it to be an infinite loop.
> > > >
> > > > Hi Andy,
> > > >
> > > > I'm trying to understand this sequence of steps. Sorry if the questions
> > > > are stupid -- I'm not very familiar with USB/PCI stuff.
> > >
> > > Thank you for looking into this. My answer below.
> > >
> > > As a first thing I would like to tell that there is another example of bad
> > > behaviour of deferred probe with no relation to USB. The proposed change also
> > > fixes that one (however, less possible to find in real life).
> >
> > Unless I see what the other issue is, I can't speak for the unknown.
>
> Okay, let's talk about other case (actually it's the one which I had noticed
> approximately at the time when culprit patch made the kernel).
>
> For some debugging purposes I have been using pin control table in board code.
>
> Since I would like to boot kernel on different systems I have some tables for
> non-existing pin control device. Pin control framework returns -EPROBE_DEFER
> when trying to probe device with attached table for wrong pin control. This is
> fine, the problem is that *any* successfully probed device, which happens in
> the deferred probe initcall will desynchronize existing counter. As a result ->
> infinite loop. For the record, I didn't realize and didn't investigate that
> time the issue and now I can confirm that this is a culprit which is fixed by
> this patch.
>
> > > > > ---8<---8<---
> > > > >
> > > > > [   22.187127] driver_deferred_probe_trigger <<< 1
> > > > >
> > > > > ...here is the late initcall triggers deferred probe...
> > > > >
> > > > > [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
> > > > >
> > > > > ...dwc3.0.auto is the only device in the deferred list...
> > > >
> > > > Ok, dwc3.0.auto is the only unprobed device at this point?
> > >
> > > Correct.
> > >
> > > > > [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
> > > > >
> > > > > ...the counter before mutex is unlocked is kept the same...
> > > > >
> > > > > [   22.205663] platform dwc3.0.auto: Retrying from deferred list
> > > > >
> > > > > ...mutes has been unlocked, we try to re-probe the driver...
> > > > >
> > > > > [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
> > > > > [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
> > > > > [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
> > > > > [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
> > > > > [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
> > > > > [   22.263723] driver_deferred_probe_trigger <<< 2
> > > > >
> > > > > ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
> > > > >
> > > > > [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
> > > >
> > > > So where did this dwc3.0.auto.ulpi come from?
> > >
> > > > Looks like the device is created by dwc3_probe() through this call flow:
> > > > dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
> > > > dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
> > >
> > > Correct.
> > >
> > > > > [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > > >
> > > > Can you please point me to which code patch actually caused the probe
> > > > deferral?
> > >
> > > Sure, it's in drd.c.
> > >
> > > if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> > >   edev = extcon_get_extcon_dev(name);
> > >   if (!edev)
> > >     return ERR_PTR(-EPROBE_DEFER);
> > >   return edev;
> > > }
> >
> > Thanks for the confirmations and pointers. I assume
> > "linux,extcon-name" is a property that's obtained from ACPI? Because I
> > couldn't find a relevant reference to it elsewhere in the kernel.
>
> Yes.
>
> > > > > ...but extcon driver is still missing...
> > > > >
> > > > > [   22.283174] platform dwc3.0.auto: Added to deferred list
> > > > > [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
> > > >
> > > > I'm not fully aware of all the USB implications, but if extcon is
> > > > needed, why can't that check be done before we add and probe the ulpi
> > > > device? That'll avoid this whole "fake" probing and avoid the counter
> > > > increase. And avoid the need for this patch that's touching the code
> > > > code that's already a bit delicate.
> > >
> > > > Also, with my limited experience with all the possible drivers in the
> > > > kernel, it's weird that the ulpi device is added and probed before we
> > > > make sure the parent device (dwc3.0.auto) can actually probe
> > > > successfully.
> > >
> > > As I said above the deferred probe trigger has flaw on its own.
> >
> > Definitely agree. I'm not saying deferred probe is perfect.
> >
> > > Even if we fix for USB case, there is (and probably will be) others.
> > >
> > > > Most of the platform device code I've seen in systems with OF (device
> > > > tree) add the child devices towards the end of the parent's probe
> > > > function.
>
> I realized also that your fix won't work if we change extcon to be compiled in
> and ULPI to be a module. So, any driver with two or more strict dependencies
> one of which is satisfied and one is not will end up in this infinite loop.
>
> > > > > ...and since we had a successful probe, we got counter mismatch...
> > > > >
> > > > > [   22.297490] driver_deferred_probe_trigger <<< 3
> > > > > [   22.302074] platform dwc3.0.auto: deferred_probe_work_func 2 <<< counter 3
> > > > >
> > > > > ...at the end we have a new counter and loop repeats again, see 22.198727...
> > > > >
> > > > > ---8<---8<---
> > > > >
> > > > > Revert of the commit helps, but it is probably not helpful for the initially
> > > > > found regression. Artem Bityutskiy suggested to use counter of the successful
> > > > > probes instead. This fixes above mentioned case and shouldn't prevent driver
> > > > > to reprobe deferred ones.
> > > > >
> > > > > Under "successful probe" we understand the state when a driver of the certain
> > > > > device is being kept bound after deferred probe trigger cycle. For instance,
> > > > > in the above mentioned case probing of tusb1210 is not successful because dwc3
> > > > > driver unbinds device dwc3.0.auto.ulpi. The atomic_dec() call is used to keep
> > > > > track of this. The amount of bindings is always great than or equal to the
> > > > > amount of unbindings as guaranteed by design of the driver binding mechanism.
> > > >
> > > > The unbindings count can increase for other unrelated drivers unbinding
> > > > too. Wouldn't it? Seems a bit fragile and racy in a fashion similar to
> > > > the issue the original patch was trying to fix.
> > >
> > > Yes, it's (unlikely) possible (*), but it will give one more iteration per such
> > > case. It's definitely better than infinite loop. Do you agree?
> >
> > Sorry I wasn't being clear (I was in a rush). I'm saying this patch
> > can reintroduce the bug where the deferred probe isn't triggered when
> > it should be.
>
> I don't think so. If I'm not mistaken we still have one more cycle to trigger probe.
>
> > Let's take a simple execution flow.
> >
> > probe_okay is at 10.
> >
> > Thread-A
> >   really_probe(Device-A)
> >     local_probe_okay_count = 10
> >     Device-A probe function is running...
> >
> > Thread-B
> >   really_probe(Device-B)
> >     Device-B probes successfully.
> >     probe_okay incremented to 11
>
> And probe trigger task is called. It goes to the loop because counters are not the same.

Good point. But Device-A is still not in any of the deferred probed
lists at this point AFAICU. So even the retriggered iteration can
complete before Device-A is back on the deferred probe list?

>
> > Thread-C
> >   Device-C (which had bound earlier) is unbound (say module is
> > unloaded or a million other reasons).
> >   probe_okay is decremented to 10.
>
>
> > Thread-A continues
> >   Device-A probe function returns -EPROBE_DEFER
> >   driver_deferred_probe_add_trigger() doesn't do anything because
> >     local_probe_okay_count == probe_okay
> >   But Device-A might have deferred probe waiting on Device-B.
> >   Device-A never probes.
>
> See above.

I think the key to fixing the original issue that commit 58b116bce136
fixes is to make sure the thread that has a device getting deferred is
the one that re-triggers the deferred probe if it sees another device
having probed successfully.

> > > *) It means during probe you have _intensive_ removing, of course you may keep
> > > kernel busy with iterations, but it has no practical sense. DoS attacks more
> > > effective in different ways.
> >
> > I wasn't worried about DoS attacks. More of a functional correctness
> > issue what I explained above.
> >
> > Anyway, if your issue and similar issues can be handles in driver core
> > in a clean way without breaking other cases, I don't have any problem
> > with that. Just that, I think the current solution breaks other cases.
>
> > As an alternate solution, assuming "linux,extcon-name" is coming
> > from some firmware, you might want to look into the fw_devlink
> > feature.
>
> Let's forget about USB. Don't be fixed on it. It one of the particular case out
> of others. I'm not going to comment USB particularities, sorry. It seems to me
> as not related.

Ok, but just FYI, fw_devlink helps a lot with avoiding deferred probe
issues. Has helped a ton with Android on ARM.

-Saravana
