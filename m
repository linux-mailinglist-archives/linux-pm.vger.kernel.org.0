Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8699310A1BB
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 17:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfKZQMp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 11:12:45 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:47080 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfKZQMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 11:12:45 -0500
Received: by mail-oi1-f174.google.com with SMTP id n14so17086210oie.13
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2019 08:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nENT5zZGvr/OZgtY1rn8vciNTC+OKABafSND442R6eU=;
        b=XS4gnmTghYJtI7Mec5VtF/pl0SFSDEGDOVom7g2lKwKf3VAhokikHUkPD83wSydq/d
         IZLarqdKDPcGuzB55IS3k8rdApI+voV4AilWNV++loTPClMJSP5OvYYa0rxPH6ys0Gc+
         QJ041ev/R44P4Pc3J2a7Chnn0VgLvWyvPn2o8N4SMC09LDSfMhligpLzQluf0pQ4LO3D
         Nx20pzmEH1oblo1qjg42vESpO3e/9wSV326xG+fGqURZhRiiI+A/KsnWVbfwY1R1VJ/D
         3XV4WZFQVnX67kELmmBhyX+pwJcXbFkuM2567JSiV+yhbf6HH0D4d1vEof1+cAKKb82M
         gNyA==
X-Gm-Message-State: APjAAAUBf+bG8y0+94P5mOsWMzXUcDcFAKhaPXn1II7gSxveuX2d2ijz
        QbIm1ylr1LNHvckIufUND+Fp/2/L3jzGCWb9JHHPFw==
X-Google-Smtp-Source: APXvYqxSZJlwfRbKL7sVKIv1gAkLxvXLaTF31UVWE+WWuBYF2Ed579HhqPjj9q4WjrYQrhm3M+tDzQLm7NwphWXG6xE=
X-Received: by 2002:aca:c753:: with SMTP id x80mr4028049oif.115.1574784763708;
 Tue, 26 Nov 2019 08:12:43 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n>
 <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com>
 <2977390.9qzeJo7xji@kreacher> <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
 <alpine.DEB.2.21.1911251155440.2817@hp-x360n> <CAJZ5v0hMR8_i=oA1ovX0-xfa_w1x7nHhTwmmKRPu27ceFxpFow@mail.gmail.com>
 <alpine.DEB.2.21.1911251502490.13123@hp-x360n> <CAJZ5v0jR8OQVOniR++NJeDukDn9Bgp+DZtvmSCF_d0pH1LDr6w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jR8OQVOniR++NJeDukDn9Bgp+DZtvmSCF_d0pH1LDr6w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Nov 2019 17:12:32 +0100
Message-ID: <CAJZ5v0jbU3ikuju-oV6Y0g0f_F44w-3bkfvBZTFT8tUPycC69w@mail.gmail.com>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep:
 Simplify suspend-to-idle control flow)
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 26, 2019 at 9:50 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 26, 2019 at 12:32 AM Kenneth R. Crudup <kenny@panix.com> wrote:
> >
> >
> > On Mon, 25 Nov 2019, Rafael J. Wysocki wrote:
> >
> > > It looks like the platform has problems with switching power between
> > > AC and battery while suspended.  Also this appears to be related to the EC.
> >
> > That being said, I always keep a stock kernel on this machine (latest is Kubuntu
> > vmlinuz-5.0.0-35-generic) and the failure mode isn't reproducible on that. I'm
> > still wondering what's substantially different between the versions.
> >
> > BTW, I've got breaking it down to a science now:
> >
> > - Let the battery drain pretty well down (< ~80%)
> > - Boot the kernel I wish to test, while still on battery
> > - Intiate a suspend/resume, which will come back OK
> > - Initiate another suspend
> > - Plug in the charger. If I have my power meter in, I see it do the PD
> >   negotiation (it'll start off at 20V/150mA, then it'll PD ramp up to
> >   a full 2.5-2.75A @20v to charge the battery)
> > - Try to resume. It'll be totally dead and I have to long-power-button
> >   to get it back
> >
> > - If I have "ec_no_wakeup=1" set, then the first time it seems to resume
> >   OK from the procedure above, then I'll wait about two minutes then
> >   flip the laptop around a bunch (apparently getting the accelerometer
> >   involved, which I guess happens during a car ride) which can also
> >   trigger the hard hangup when I plug it in before suspending
> >
> > > Also I'm wondering if the problem is reproducible with ec_no_wakeup
> > > and the last patch I posted applied.
> >
> > With the stock -rc kernel, I used to be able to work around this issue with
> > "ec_no_wakeup=1", but sometimes the battery would drain while "suspended"
> > far higher than idle at random.
> >
> > With the second patchset (the introduction of acpi_s2idle_sync()) the
> > *second* resume while the battery is charging locks it up hard.
> >
> > > But with that patch applied, please try to comment out the
> > > acpi_s2idle_sync() in acpi_s2idle_wake() and retest.
> >
> > So get this- I took it out of acpi_s2idle_wake() and left it in acpi_s2idle_restore() ;
> > when I do this, I get the issue where it seems to no longer care about the
> > charging state, BUT it is back to responding to charger events (i.e., it won't
> > go to sleep as long as it's plugged in, and "ec_no_wakeup=1" has no effect on this.
> >
> > It also turns out that it doesn't apparently matter if I remove the call of acpi_s2idle_sync()
> > from either of acpi_s2idle_wake() or acpi_s2idle_restore() but I get the behavior above.
> > I took a shot in the dark and commented out the call to acpi_ec_flush_work() in acpi_s2idle_sync()
> > and left the calls to acpi_s2idle_sync() in both _wake and _restore and also get this
> > behavior, which to me implies that whatever is in the acpi_ec_flush_work() call (and I
> > looked at it, but didn't go any further) is where it's hanging up.
>
> It doesn't have to be like that.
>
> What acpi_ec_flush_work() does it to process the EC events received so
> far and they may trigger notifications that are processed
> subsequently.  The next acpi_os_wait_events_complete() is there to
> wait for that processing to finish.
>
> It looks like it hangs somewhere in the platform firmware, but it is
> hard to say where exactly.
>
> > I can put WARN_ON(cond)
> > calls in places that'll write to EFI pstore, if you think that would be useful.
> >
> > As this workaround does at least (so far, anyway) keep the machine from going off into
> > a black hole,
>
> So to be precise you mean commenting out acpi_ec_flush_work() in
> acpi_s2idle_sync() with the
>
> https://lore.kernel.org/linux-pm/alpine.DEB.2.21.1911220920500.24730@hp-x360n/T/#m199e175157c9cddf48fdee16681f6c2f0549a364
>
> patch applied?
>
> And does the power button/lid wakeup work without that?
>
> > I'm willing to live with it until/as we find a workaround that gets it
> > right; even though it'll be somewhat annoying to not go to sleep when charged AND
> > automatically wake up on power connection/disconnection events (can those be filtered
> > out of /proc/acpi/wakeup_sources ? Nothing looked obvious) at least I have a laptop
> > when I need it.
>
> There should be a way to filter them out.
>
> From the above it looks like this happens with "ec_no_wakeup=1" too,
> is that correct?
>
> > Can you think of any other strategy to try (and I'm all ears at this point; this
> > kind of breakage- while almost certainly that something in this HP BIOS/ACPI
> > is doing wrong, should be properly worked around for the rest of us poor suckers
> > who got these devices so I'm willing to help either fix it,
>
> It's rather that the platform firmware has expectations that we don't
> know about.
>
> Yes, it should be possible to diagnose it further with some extra work.

To that end, please send me the output of dmidecode and acpidump from
your laptop.
