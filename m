Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8F31660D1
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 16:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgBTPVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 10:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgBTPVK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Feb 2020 10:21:10 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF4C82465D;
        Thu, 20 Feb 2020 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582212069;
        bh=Jr3BWrhsllQ1DF1MQCjfFXACRtqZmspAzYArSVEj5+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TL58v9oTxIh/6x3CPObWfQoagzAyUVKmsKLn2kVGkA3UArYNxrMP39+/hjF++rNgB
         TpmrVN4xuwA16r3g4qvlIKi83oip3+KTooo3ojoCp4ibZnWwk3fSjiEtWCo99+qYFK
         HRQUNJVyKyqlsL1s2cIMGGd6kQbGI1yR6ujFL050=
Received: by mail-qt1-f178.google.com with SMTP id i14so3078589qtv.13;
        Thu, 20 Feb 2020 07:21:08 -0800 (PST)
X-Gm-Message-State: APjAAAUXk6Sfp/Oq3nxQWNd18Ylr8+5O8/e2sySCcTc+jkHbfilREZEH
        BvhFPW8KWFzFkn4GcEUXjwn2i0z7z27mqsqVZA==
X-Google-Smtp-Source: APXvYqxahB0DdtVXsXo8CCTblmFIGiLWE5gmtmpVH3sti1SnTFcPlL/14AbUA98nETeVV+5NRkq397jGl9D4wia5Rxs=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr27506651qtj.300.1582212067802;
 Thu, 20 Feb 2020 07:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org> <20200220052739.87057-1-saravanak@google.com>
In-Reply-To: <20200220052739.87057-1-saravanak@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Feb 2020 09:20:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-dd0deUWw43StoBdNOQM8E63axWRafwKZY2SGkdMzHw@mail.gmail.com>
Message-ID: <CAL_JsqK-dd0deUWw43StoBdNOQM8E63axWRafwKZY2SGkdMzHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Todd Kjos <tkjos@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 19, 2020 at 11:27 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Apologies in advance for replying to this one email but discussing the
> points raised in all the other replies. I'm not cc'ed in this thread and
> replying to each email individually is a pain.
>
> On Tue, Feb 18, 2020 at 4:07 PM John Stultz wrote:
> > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > at the end of initcall"), along with commit 25b4e70dcce9
> > ("driver core: allow stopping deferred probe after init") after
> > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > instead see an error causing the driver to fail to load.
>
> Both of those patches were the best solution at that point in time. But
> the kernel has changed a lot since then. Power domain and IOMMU drivers
> can work as modules now. We have of_devlink and sync_state().
>
> So, while a delay might have been the ideal solution back then, I think
> we need to work towards removing arbitrary timeouts instead of making
> the timeout mechanism more elaborate.

If you don't have some way to say all the dependencies that can be
resolved have been resolved already, how do you get away from a
timeout? Nothing has changed in that respect.

If a dtb+kernel works, updating just the dtb with new dependencies
should not break things.

> I think driver_deferred_probe_check_state() logic should boiled down
> to something like:
>
> int driver_deferred_probe_check_state(struct device *dev)
> {
>         /* No modules and init done, deferred probes are pointless from
>          * now. */
>         if (!defined(CONFIG_MODULES) && initcall_done)
>                 return -ENODEV;
>
>         /* If modules and of_devlink then you clean want dependencies to
>          * be enforced.
>          */
>         if (defined(CONFIG_MODULES) && of_devlink)
>                 return -EPROBE_DEFER;
>
>         /* Whatever other complexity (including timeouts) we want to
>          * add. Hopefully none - we can discuss in this thread. */
>         if (.....)
>                 return -Exxxx;
>
>         /* When in doubt, allow probe deferral. */
>         return -EPROBE_DEFER;
> }

Mostly makes sense to me. I think using CONFIG_MODULES is good.

However, there is the case in pinctrl that we have a DT flag
'pinctrl-use-default' and we stop deferring at the end of initcalls if
set. With the above, there's no way to detect that. I'm pretty sure
that's broken now with of_devlink and maybe from Thierry's change too.

> Rob, for the original use case those two patches were added for, do they need
> to support CONFIG_MODULES?

At the time since the subsystems involved were not typically modules
so using CONFIG_MODULES didn't really matter. As you said, that's
changed now.

> > That change causes trouble when trying to use many clk drivers
> > as modules, as the clk modules may not load until much later
> > after init has started. If a dependent driver loads and gets an
> > error instead of EPROBE_DEFER, it won't try to reload later when
> > the dependency is met, and will thus fail to load.
>
> Once we add of_devlink support for power-domains, you won't even hit the
> genpd error path if you have of_devlink enabled. I believe in the case
> you are testing DB 845c, of_devlink is enabled?
>
> If of_devlink is enabled, the devices depending on the unprobed power
> domains would be deferred without even calling the driver's probe()
> function.
>
> Adding power-domain support to of_devlink is a 2 line change. I'll send
> it out soon.
>
> Also, regulator_init_complete() can be replaced by a sync_state() based
> implementation. I have a downstream implementation that works. But it's
> definitely not upstream ready. I plan to rewrite it and send it upstream
> at some point, but it's fairly straightforward if anyone else want to
> implement it. My main point being, we shouldn't have to make the timeout
> logic more complex (or even need one) for regulator clean up either.
>
> On Tue, Feb 18, 2020 at 6:07 PM Rob Herring wrote:
> > The one complication which I mentioned already is with consoles. A
> > timeout (and dependencies in modules) there doesn't work. You have to
> > probe and register the console before init is done.
>
> Rob,
>
> I've seen you say this a couple of times before. But I don't think this
> is true any more. With of_devlink enabled I've booted hardware countless
> times with the console device probing after userspace comes up. The only
> limitation for console drivers is that they need to be built-in if they
> need to support earlycon. If you don't care to support earlycon (very
> useful for bringup debugging), I think the console driver can even be a
> module. I don't think even of_devlink needs to be enabled technically if
> you load the modules in the right order.

Every serial driver has to be built-in to enable console support.
That's not because of earlycon. It's been that way for as long as I've
worked on linux. Now of course, a driver could be built-in and still
probe after userspace starts, but in my testing with the timeout that
didn't work. I don't see how of_devlink changes that.

It could depend on what userspace you have. Certainly, booting with
'console=ttyS0 init=/bin/sh' would not work for example. What I
probably tested with was a busybox based rootfs. What are you testing
with? Android?

Rob
