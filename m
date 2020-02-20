Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC0166AC7
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 00:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgBTXIe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 18:08:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34949 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgBTXIe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 18:08:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so360791otd.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 15:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vq9epyIrHcN2P4XdXzWMjBg4z7X1Q3DaaqUydM8VLqk=;
        b=ABTeiGJwbhKNAqnD6Z8HupUZ7wKALHCjm1hb2M83ENTc200O2HPW/yFsg7RQKqTYCy
         5rT59ueWmRwVEjNo+NWZG1SxKxdHdXm3Ko6TEzWIr4kyWEX4xywBMK6LuFjanBeNC3sr
         mSNUYeOXQIpOT/u3WYgzpB9hNeBITAv9cqt4vnoFOUoGnq3XC7oRrHltSQxneFvCaiez
         pPK7C/Y/6yMOpUyNLzTX1cyAjMgKEAcxy95pHhRxM2LPZ1nAEGZkgNLVZ+Kih8uxp5yS
         jzl355ajWVk9W08x4Sv9el4JSpRR8gZm8UxpY7Kdv8h3yDap7r8uZc0IZF7il3T/zakC
         cakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vq9epyIrHcN2P4XdXzWMjBg4z7X1Q3DaaqUydM8VLqk=;
        b=E17bC5V9epkVcsNvuedfJ9J7r4KImAQhtqMvwY/0yxKOdt5bviaOs5vVJvqPIGdf9O
         rLb2ypXvJME5ORPqrOcAHgtX0VjmtsWd3n0+bPOpLaccMzm8eyTMqJRXejkTCs57yytb
         Xg9rAI3oiC0ljENWTZKgQ+jfWXEL/KbhVB5QTyxx/D1gAk6mpBZ3Mkf2PBcWk7vcxFE3
         iL8Nf6DbCEcb9FNmWwWN4obbR9/64KL0hQWdvXWErmXe4Beaa4rTPCgVDJ/wuMtHjswq
         NCqKiJ7+7aLjuRtxe/9mnSIjJll0HmobshlZu6bouPywYVK3dKcSm3/2zzFrcDMZbl5/
         TmZw==
X-Gm-Message-State: APjAAAXaYiT6WSUi/3xRxC+iVBsJmiT8zWkuOTWiAxSZqQqx78gZwB1I
        jxlMHiJoQj7bp4IHHIsCqEDwQm7cj8fKx4GDgkh3wg==
X-Google-Smtp-Source: APXvYqxPCtxyXxf8s/1nMY24FTf6EVdiWxJEwH84wm2asT4JnDA8p8cMaa+l7rK0RJMNoNs9YEOaw/PGmGaRwXwNyuw=
X-Received: by 2002:a05:6830:22ee:: with SMTP id t14mr25024485otc.236.1582240112363;
 Thu, 20 Feb 2020 15:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <20200220052739.87057-1-saravanak@google.com> <CAL_JsqK-dd0deUWw43StoBdNOQM8E63axWRafwKZY2SGkdMzHw@mail.gmail.com>
In-Reply-To: <CAL_JsqK-dd0deUWw43StoBdNOQM8E63axWRafwKZY2SGkdMzHw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 20 Feb 2020 15:07:56 -0800
Message-ID: <CAGETcx-s-c7ozKAbq8pYUEotaDRcxpy-9bXdiUYbyN7kK2moWA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Rob Herring <robh@kernel.org>
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

On Thu, Feb 20, 2020 at 7:21 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Feb 19, 2020 at 11:27 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Apologies in advance for replying to this one email but discussing the
> > points raised in all the other replies. I'm not cc'ed in this thread and
> > replying to each email individually is a pain.
> >
> > On Tue, Feb 18, 2020 at 4:07 PM John Stultz wrote:
> > > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > > at the end of initcall"), along with commit 25b4e70dcce9
> > > ("driver core: allow stopping deferred probe after init") after
> > > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > > instead see an error causing the driver to fail to load.
> >
> > Both of those patches were the best solution at that point in time. But
> > the kernel has changed a lot since then. Power domain and IOMMU drivers
> > can work as modules now. We have of_devlink and sync_state().
> >
> > So, while a delay might have been the ideal solution back then, I think
> > we need to work towards removing arbitrary timeouts instead of making
> > the timeout mechanism more elaborate.
>
> If you don't have some way to say all the dependencies that can be
> resolved have been resolved already, how do you get away from a
> timeout? Nothing has changed in that respect.

Right, we can't get away from timeout if we need to support
CONFIG_MODULES AND mix-n-matched dtc+kernel versions.

But hopefully we can simplify the timeout logic by reducing the
configurations it needs to support (because other checks take care of
those configurations).

> If a dtb+kernel works, updating just the dtb with new dependencies
> should not break things.

I'm not sold on that policy (I agree newer kernel + old dtb shouldn't
break), but that's a discussion for another time.

>
> > I think driver_deferred_probe_check_state() logic should boiled down
> > to something like:
> >
> > int driver_deferred_probe_check_state(struct device *dev)
> > {
> >         /* No modules and init done, deferred probes are pointless from
> >          * now. */
> >         if (!defined(CONFIG_MODULES) && initcall_done)
> >                 return -ENODEV;
> >
> >         /* If modules and of_devlink then you clean want dependencies to
> >          * be enforced.
> >          */
> >         if (defined(CONFIG_MODULES) && of_devlink)
> >                 return -EPROBE_DEFER;
> >
> >         /* Whatever other complexity (including timeouts) we want to
> >          * add. Hopefully none - we can discuss in this thread. */
> >         if (.....)
> >                 return -Exxxx;
> >
> >         /* When in doubt, allow probe deferral. */
> >         return -EPROBE_DEFER;
> > }
>
> Mostly makes sense to me. I think using CONFIG_MODULES is good.

Good to know. I'll see if John wants to do that. If not, I'll get around to it.

> However, there is the case in pinctrl that we have a DT flag
> 'pinctrl-use-default' and we stop deferring at the end of initcalls if
> set.

Ugh! That code hurts my head! Mainly because the
driver_deferred_probe_check_state[_continue]() function names are so
similar and confusing. And their implementation is also a bit twisty
(like using triple negatives in a sentence). But I also noticed there
is no user of pinctrl-use-default in the upstream kernel. So,
whatever.

> With the above, there's no way to detect that. I'm pretty sure
> that's broken now with of_devlink and maybe from Thierry's change too.

of_devlink doesn't parse pinctrl yet. I have some simple changes
downstream for that which just parses -0, -1, -2 and -3 -- I'll get
around to upstreaming those sometime. However, adding support for
pinctrl-use-default is not hard. But I'd rather not do it unless
someone actually needs to use that along with of_devlink enabled and
asks for it in LKML.

> > Rob, for the original use case those two patches were added for, do they need
> > to support CONFIG_MODULES?
>
> At the time since the subsystems involved were not typically modules
> so using CONFIG_MODULES didn't really matter. As you said, that's
> changed now.
>
> > > That change causes trouble when trying to use many clk drivers
> > > as modules, as the clk modules may not load until much later
> > > after init has started. If a dependent driver loads and gets an
> > > error instead of EPROBE_DEFER, it won't try to reload later when
> > > the dependency is met, and will thus fail to load.
> >
> > Once we add of_devlink support for power-domains, you won't even hit the
> > genpd error path if you have of_devlink enabled. I believe in the case
> > you are testing DB 845c, of_devlink is enabled?
> >
> > If of_devlink is enabled, the devices depending on the unprobed power
> > domains would be deferred without even calling the driver's probe()
> > function.
> >
> > Adding power-domain support to of_devlink is a 2 line change. I'll send
> > it out soon.
> >
> > Also, regulator_init_complete() can be replaced by a sync_state() based
> > implementation. I have a downstream implementation that works. But it's
> > definitely not upstream ready. I plan to rewrite it and send it upstream
> > at some point, but it's fairly straightforward if anyone else want to
> > implement it. My main point being, we shouldn't have to make the timeout
> > logic more complex (or even need one) for regulator clean up either.
> >
> > On Tue, Feb 18, 2020 at 6:07 PM Rob Herring wrote:
> > > The one complication which I mentioned already is with consoles. A
> > > timeout (and dependencies in modules) there doesn't work. You have to
> > > probe and register the console before init is done.
> >
> > Rob,
> >
> > I've seen you say this a couple of times before. But I don't think this
> > is true any more. With of_devlink enabled I've booted hardware countless
> > times with the console device probing after userspace comes up. The only
> > limitation for console drivers is that they need to be built-in if they
> > need to support earlycon. If you don't care to support earlycon (very
> > useful for bringup debugging), I think the console driver can even be a
> > module. I don't think even of_devlink needs to be enabled technically if
> > you load the modules in the right order.
>
> Every serial driver has to be built-in to enable console support.
> That's not because of earlycon. It's been that way for as long as I've
> worked on linux. Now of course, a driver could be built-in and still
> probe after userspace starts, but in my testing with the timeout that
> didn't work.

>I don't see how of_devlink changes that.

of_devlink sometimes helps because it avoids running probe() functions
with poor error handling (Eg: returning -Esomethingelse when they
should return -EPROBE_DEFER). Also, I did say "I don't think even
of_devlink needs to be enabled..."

> It could depend on what userspace you have.

Right, and because of that I think we should say the following going forward:
"Every serial driver has to be built-in to enable console support, but
it can still probe after userspace starts"

Instead of:
"You have to probe and register the console before init is done".

Because the former statement gives a clearer picture and doesn't
discourage people from trying to modularize their platforms more
thoroughly :)

> Certainly, booting with 'console=ttyS0 init=/bin/sh' would not work for example.
> What I probably tested with was a busybox based rootfs. What are you testing
> with? Android?

Yeah, with Android. Happen to know why busybox (or whatever other
shell) might not work? Is it because they exit immediately if console
device is not available instead of continuing to run the scripts?

-Saravana
