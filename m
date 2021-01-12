Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260E12F3D0B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 01:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437151AbhALVhZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 16:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436996AbhALUj5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 15:39:57 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235BC061575
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 12:39:16 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id k78so3384101ybf.12
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 12:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ysk/rqQWIHOWjbl6v0yKfWqhSSuHRhQojoV0+hQXA4c=;
        b=SJQupXq58577qdvAJY69b/AUMLS9bXfAs4Vsz59rP2LNfnpLBYbmUA/7NtwqRLAA2g
         1BZx2Hy7x1V+Wu9FETNIi6Ntpn71jjS269WeGCRsh9QZrp/eeEJkLROwqeUO88ijV71C
         7gJ+gq5H+D29bjeHUDj58En7UmiDtiX2bJTLR4WQis0VjGEAWFYYDz01c+cJhlJf+Tyl
         wY3pt+/EOe65jSY9IOQu+tuvg42nAX5SrxWSxHfYpY3yZlHdXP54bYqI6Nda7G01zboA
         ZQ0kA5sEF8WWAZEKJu1i1RB9jp+l0qJXRsbLEwOJ+mS+XSYI3UlACGWOIwkr8fzyo6Y3
         n1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ysk/rqQWIHOWjbl6v0yKfWqhSSuHRhQojoV0+hQXA4c=;
        b=XtHMjVW3/ij+kqirlmDJiihGysIHF9GKIuvjOgP9kYwLIFY6VKaU9Aqj0jXxOHVinz
         01KrRvIoIX/MtI3pUieRJ1gxNncFNzuzQMGp3cAo9IxuPGfTKsVU9pq7D1VO2c4T4bsw
         TxNrXnX75ZQEegvgBjWTJiFLYB3eS0c1EQgJwO63i+JMFni5rkTirDzX3QtGdALkbfWw
         hpInTqc7brV4/ES3oGwaOiNJ+E/F8Y5YaT8+9ZPdG5B+yLBTQdeKoYnA5sgUbxy5iEKx
         5aPXk4V6wvn5JC9xnCr12YbZIqKGQUs47U2sx5QEHQk8ETQWVp9pPjsyK5wrcfI/e4qz
         tRVw==
X-Gm-Message-State: AOAM532lL2gtB7bNYfH9jyBSa5jnQbHX6iKTI1MdsniO+jAqVTbN2CGL
        ntt7ZCedQ2k44NYV8V9KhWcR4VD5rJuMk7446YEB3g==
X-Google-Smtp-Source: ABdhPJziGaSFzNul3T3+jslrR7sVqwVops5TVnO4U1azhvc4r7YG6OGW34Oj9tT/SS5/Cu/xqdfu0RDPo5A0/9fT8m0=
X-Received: by 2002:a25:6604:: with SMTP id a4mr1934516ybc.412.1610483955843;
 Tue, 12 Jan 2021 12:39:15 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils>
 <X/xV7ZV5jzI7RvAe@ulmo> <CAJZ5v0iriRkEN8dVJ9gE3+Wyn_96=SNhav1QaQ59i9O0genTNQ@mail.gmail.com>
 <X/x49o3EtrUh6vuO@ulmo> <CAJZ5v0hyvdcKsPJ7U5WioXb1c8Pg_F1BLC_dbKesFBLTUSiVaw@mail.gmail.com>
 <X/3jBzWEVrguB8H2@ulmo>
In-Reply-To: <X/3jBzWEVrguB8H2@ulmo>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 12 Jan 2021 12:38:39 -0800
Message-ID: <CAGETcx-6Ccn2N9vMXZc5NZu2DwsBOYunRsbCeHiMeHxEj7iMbQ@mail.gmail.com>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
To:     Thierry Reding <treding@nvidia.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I'm just going to combine my response to the 2-3 emails in this one response.

On Tue, Jan 12, 2021 at 9:57 AM Thierry Reding <treding@nvidia.com> wrote:
>
> On Mon, Jan 11, 2021 at 05:57:17PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 11, 2021 at 5:12 PM Thierry Reding <treding@nvidia.com> wrote:
> > >
> > > On Mon, Jan 11, 2021 at 03:57:37PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Jan 11, 2021 at 2:43 PM Thierry Reding <treding@nvidia.com> wrote:
> > > > >
> > > > > On Sun, Jan 10, 2021 at 08:44:13PM -0800, Hugh Dickins wrote:
> > > > > > Hi Rafael,
> > > > > >
> > > > > > Synaptics RMI4 SMBus touchpad on ThinkPad X1 Carbon (5th generation)
> > > > > > fails to suspend when running 5.11-rc kernels: bisected to
> > > > > > 5b6164d3465f ("driver core: Reorder devices on successful probe"),
> > > > > > and reverting that fixes it.  dmesg.xz attached, but go ahead and ask
> > > > > > me to switch on a debug option to extract further info if that may help.
> > > > >
> > > > > Hi Hugh,
> > > > >
> > > > > Quoting what I think are the relevant parts of that log:
> > > > >
> > > > > [   34.373742] printk: Suspending console(s) (use no_console_suspend to debug)
> > > > > [   34.429015] rmi4_physical rmi4-00: Failed to read irqs, code=-6
> > > > > [   34.474973] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -6.
> > > > > [   34.474994] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> > > > > [   34.475001] rmi4_physical rmi4-00: Failed to suspend functions: -6
> > > > > [   34.475105] rmi4_smbus 6-002c: Failed to suspend device: -6
> > > > > [   34.475113] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c returns -6
> > > > > [   34.475130] PM: Device 6-002c failed to suspend: error -6
> > > > > [   34.475187] PM: Some devices failed to suspend, or early wake event detected
> > > > > [   34.480324] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX register (-6).
> > > > > [   34.480748] rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX register (-6).
> > > > > [   34.481558] rmi4_physical rmi4-00: rmi_driver_clear_irq_bits: Failed to change enabled interrupts!
> > > > > [   34.487935] acpi LNXPOWER:02: Turning OFF
> > > > > [   34.488707] acpi LNXPOWER:01: Turning OFF
> > > > > [   34.489554] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to change enabled interrupts!
> > > > > [   34.489669] psmouse: probe of serio2 failed with error -1
> > > > > [   34.489882] OOM killer enabled.
> > > > > [   34.489891] Restarting tasks ... done.
> > > > > [   34.589183] PM: suspend exit
> > > > > [   34.589839] PM: suspend entry (s2idle)
> > > > > [   34.605884] Filesystems sync: 0.017 seconds
> > > > > [   34.607594] Freezing user space processes ... (elapsed 0.006 seconds) done.
> > > > > [   34.613645] OOM killer disabled.
> > > > > [   34.613650] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > > > > [   34.615482] printk: Suspending console(s) (use no_console_suspend to debug)
> > > > > [   34.653097] rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -6.
> > > > > [   34.653108] rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
> > > > > [   34.653115] rmi4_physical rmi4-00: Failed to suspend functions: -6
> > > > > [   34.653123] rmi4_smbus 6-002c: Failed to suspend device: -6
> > > > > [   34.653129] PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x3c returns -6
> > > > > [   34.653160] PM: Device 6-002c failed to suspend: error -6
> > > > > [   34.653174] PM: Some devices failed to suspend, or early wake event detected
> > > > > [   34.660515] OOM killer enabled.
> > > > > [   34.660524] Restarting tasks ...
> > > > > [   34.661456] rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to change enabled interrupts!
> > > > > [   34.661591] psmouse: probe of serio2 failed with error -1
> > > > > [   34.669469] done.
> > > > > [   34.748386] PM: suspend exit
> > > > >
> > > > > I think what might be happening here is that the offending patch causes
> > > > > some devices to be reordered in a way different to how they were ordered
> > > > > originally and the rmi4 driver currently depends on that implicit order.
> > > >
> > > > Actually, the only possible case in which the commit in question can
> > > > introduce suspend failures like this is when some dependency
> > > > information is missing and so the reordering causes the ordering to
> > > > change from the (working) implicit one.
> > > >
> > > > > Interestingly one of the bugs that the offending patch fixes is similar
> > > > > in the failure mode but for the reverse reason: the implicit order
> > > > > causes suspend/resume to fail.
> > > >
> > > > And that happens because some dependency information is missing.
> > > >
> > > > So we have failing cases when dependency information is missing, so
> > > > instead of fixing those we have tried to make the core change the
> > > > ordering after every successful probe in the hope that this will take
> > > > care of the problem without introducing new breakage.
> > > >
> > > > However, it evidently has introduced new breakage and in order to fix
> > > > it we need to figure out what dependency information is missing in the
> > > > failing cases and put that information in, but we may as well do the
> > > > same for the cases that are failing without the offending change.
> > > >
> > > > So why don't we revert the commit in question and do just that?
> > >
> > > Unfortunately it isn't that easy. In fact, all the dependency
> > > information already exists in the case that I cited in 5b6164d3465f
> > > ("driver core: Reorder devices on successful probe"), but it's the
> > > driver core that suspends/resumes the devices in the wrong order.
> > >
> > > The reason is because the ACONNECT device depends on the BPMP device
> > > (via a power-domains property), but it's also instantiated before the
> > > BPMP device (because it is listed earlier in device tree, which is
> > > sorted by unit-address first, then alphabetically). BPMP being a CPU
> > > non-addressable device it doesn't have a unit-address and hence is
> > > listed very late in device tree (by convention). Normally this is would
> > > not be a problem because deferred probe would take care of it. But there
> > > is one corner-case which happens when the BPMP is built into the kernel
> > > (which it usually is, as it provides access to resources necessary for
> > > booting, such as clocks and resets) and ACONNECT is built as a loadable
> > > module. In that case, BPMP gets probed before ACONNECT and hence when
> > > ACONNECT does eventually get loaded, the BPMP is already there, meaning
> > > ACONNECT won't defer probe and hence the DPM suspend/resume order is not
> > > fixed up by the deferred probe code.
> >
> > What about using a device link to enforce the right ordering, then?
>
> I was going to implement that, but then I realized that the specific
> problem I was facing with ACONNECT had been solved differently in the
> meantime. I wasn't able to exactly pinpoint what fixed it, but I suspect
> it might have been some of Saravana's fw_devlink code.

I'd be very surprised if fw_devlink code fixed anything for you when
you don't see the issue with fw_devlink=off/permissive. In those two
modes, fw_devlink is pretty much a NOP when it comes to probe/suspend
ordering.

> It's a bit
> difficult to find out what exactly changed, because it happened after
> the offending commit was already merged, so I would have to go through
> all linux-next releases since early December and revert my patch to find
> out when the change happened and then bisect which change exactly did
> it.
>
> But yes, using a device link would've done the trick as well. However
> the idea had been to potentially fix many more subtle cases like the one
> we faced in ACONNECT at the same time. It's unfortunate that it breaks a
> bunch of other cases that apparently are also missing dependency
> information and just happen to work fine with the status quo.
>
> > Deferred probing is not a way to ensure the suitable suspend/resume ordering.
>
> Well, it is in the majority of cases because deferred probe causes the
> reordering of the suspend/resume queue. And that all makes sense because
> suppliers should always be suspended after all their consumers.
>
> But that's not what the offending patch was doing. The purpose was to
> ensure that the default suspend/resume ordering matches the probe order,
> which is both more logical (though I suppose that can be subjective)

I agree with you too that the suspend order matching the probe order
is more logical than device add order. However, I'm now completely
changing my position on the patch (the one that reorder on probe). I
think we should revert it because reordering on probe has a bunch of
problems. Take this example:

1. Device-A probe() starts running.
    a. Device-A probe adds two devices - Device-B and Device-C. But
        incorrectly doesn't mark Device-A as their parents.
    b. Say the driver for B has already been loaded, so then
        Device-B's probe() runs.
    c. Device-B is reordered to the end of list dpm_list (and so are
        it's children).
4. Device-A probe() completes.
5. Device-A is reordered to the end of dpm_list but device-B and
    device-C are incorrectly NOT reorder to come after device-A.

And this gets worse when async probing is enabled or if a driver-B is
registered by another thread during Device-A probe. The same problem
also exists for supplier-consumer relationships. A consumer's probe
can finish before the supplier's probe. This is because the supplier
would have registered with the frameworks before the supplier's probe
completes. And that's all that's needed for the consumer's probe to
finish.

There's no way to fix this without the complete dependency info
(parent-child _and_ supplier-consumer info) being shared with the
driver core. So, even the reordering of dpm_list after a deferred
probe is broken/wrong and it's pretty racy. It just happens to work
for what's already working with the current boot timing in those
devices. If the complete dependency info was provided, we could delete
the reorder after the deferred probe. But that's obviously not going
to happen for existing devices and we just have to live with the code
being there.

So for future issues related to ordering, we should just focus on
fixing/adding parent-child relationships (Eg: Hugh's rmi4 driver
issue) or adding more device links (Eg: Thierry's issue).

As for adding device links, hopefully fw_devlink=on as default will
happen soon and at least take care of this for DT based systems.
Hopefully someone can add fw_devlink support for ACPI (it's closer to
the bottom of my long TODO list).


> and
> ensures that deferred probing can work properly for all cases.
>
> Anyway, this is ultimately just switching out one set of broken cases
> for another, so might as well revert the offending patch and concentrate
> on fixing the broken cases one by one as we find them.

Can you see if fw_devlink=on boots for you? If so, that's the fix. If
it doesn't, let's fix it to make sure it works for you. In the
linux-next tree, it should be limited to driver fixes (no changes
needed to the fw_devlink code). Can you make it the default for your
test platform (add it to your command line) so that it doesn't break
in the future if it's already working?

> Like I said, I'm slightly concerned about drivers like rmi4 breaking
> unexpectedly down the road

I think we should fix these too as we find them. At a minimum the rmi4
driver isn't capturing parent/child relationship correctly.

-Saravana

> because some other patch caused the ordering
> to change, so reverting now may just be putting off the inevitable. But
> you're obviously right that we shouldn't randomly break working setups,
> so I'm fine with the revert.
>
> Thierry
