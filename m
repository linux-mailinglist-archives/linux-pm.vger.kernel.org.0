Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1BD10D3AF
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 11:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfK2KJj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 05:09:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46051 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2KJi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 05:09:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id r24so24409770otk.12;
        Fri, 29 Nov 2019 02:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNyUDcz45IQkbN6FN8vsNmcKtbsR7kxWExYLkWcp/ec=;
        b=Q0LelyAJDPmr27tcNtsk+vDKvACG1YS6Coa+tGiAxJzezggy/i9TZS9mHeJ6jE1/nY
         Yjx4QmE3rEtx873gd9mLz8Ey28c3WjTEnMpe+w8fk1zE3LBVsmq9GW7u+CeA3ez+7sX7
         XEh0yclxoxA3kBTfZTYJMhJLYERFWP7p1HEqAAOJrmgwwhJgDk4uDZtTSxHF+CTsBKBZ
         AoYDYEbHZR45K0c/lXAp7Fmeky8Pe77WYJA0VJv4SUamAaCVZWb5aXwCeBth8Ul8EEwV
         LqnkZtUhEgluXmi5LxbrAUJX5HM4q3s5ucaJGfIqMb0+enyTX4toxoFCTQAd1l/zghMk
         V2NQ==
X-Gm-Message-State: APjAAAXBe9vZ5WcLXL8VNEtVvVq7oul0T5Qeu3kGMZI1RQpjopWQeVen
        hSe5ltIUqLluX1eYeanB8TYiyi4imkn9q3bQ+Ec=
X-Google-Smtp-Source: APXvYqykEHpKyENTwhQ7DE5ySMHUSzenpLhFvqoJReYxgjhi2o4LpzP4qxKQIk6LnSWoah24b8GzvsTaZ2JX/fm/EcM=
X-Received: by 2002:a9d:6955:: with SMTP id p21mr6559810oto.189.1575022177252;
 Fri, 29 Nov 2019 02:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20191128160314.2381249-1-thierry.reding@gmail.com>
 <CAJZ5v0haOB1vc8aKk11RR-OnfLHChcqa+z7QkeKyN66s6xM3OA@mail.gmail.com>
 <20191128163623.GA2382107@ulmo> <2310325.iNVD75376c@kreacher> <20191129093357.GA2770902@ulmo>
In-Reply-To: <20191129093357.GA2770902@ulmo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Nov 2019 11:09:26 +0100
Message-ID: <CAJZ5v0j56xrmiO6bvs3W-_pY0HjGhSUEbZYzjZHfm6gA-k605g@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / runtime: Allow drivers to override runtime PM
 behaviour on sleep
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 29, 2019 at 10:34 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Thu, Nov 28, 2019 at 11:03:57PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, November 28, 2019 5:50:26 PM CET Thierry Reding wrote:
> > >
> > > --0F1p//8PRICkK4MW
> > > Content-Type: text/plain; charset=us-ascii
> > > Content-Disposition: inline
> > > Content-Transfer-Encoding: quoted-printable
> > >
> > > On Thu, Nov 28, 2019 at 05:14:51PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Nov 28, 2019 at 5:03 PM Thierry Reding <thierry.reding@gmail.com>=
> > >  wrote:
> > > > >
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >
> > > > > Currently the driver PM core will automatically acquire a runtime PM
> > > > > reference for devices before system sleep is entered. This is needed
> > > > > to avoid potential issues related to devices' parents getting put to
> > > > > runtime suspend at the wrong time and causing problems with their
> > > > > children.
> > > >=20
> > > > Not only for that.
> > > >=20
> > > > > In some cases drivers are carefully written to avoid such issues and
> > > > > the default behaviour can be changed to allow runtime PM to operate
> > > > > regularly during system sleep.
> > > >=20
> > > > But this change breaks quite a few assumptions in the core too, so no,
> > > > it can't be made.
> > >
> > > Anything in particular that I can look at? I'm not seeing any issues
> > > when I test this, which could of course mean that I'm just getting
> > > lucky.
> >
> > There are races and such that you may never hit during casual testing.
> >
> > > One thing that irritated me is that I think this used to work. I do
> > > recall testing suspend/resume a few years ago and devices would get
> > > properly runtime suspended/resumed.
> >
> > Not true at all.
> >
> > The PM core has always taken PM-runtime references on all devices pretty much
> > since when PM-runtime was introduced.
>
> You're right. I was finally able to find a toolchain that I could build
> an old version of the kernel with. I tested system suspend/resume on the
> v4.8 release, which is the first one that had the runtime PM changes as
> well as the subsystem suspend/resume support wired up, and I can't see
> the runtime PM callbacks invoked during system suspend/resume.
>
> So I must be misremembering, or I'm confusing it with some other tests I
> was running at the time.
>
> > > I did some digging but couldn't
> > > find anything that would have had an impact on this.
> > >
> > > Given that this is completely opt-in feature, why are you categorically
> > > NAK'ing this?
> >
> > The general problem is that if any device has been touched by system-wide
> > suspend code, it should not be subject to PM-runtime any more until the
> > subsequent system-wide resume is able to undo whatever the suspend did.
> >
> > Moreover, if a device is runtime-suspended, the system-wide suspend code
> > may mishandle it, in general.  That's why PM-runtime suspend is not allowed
> > during system-wide transitions at all.  And it has always been like that.
>
> For this particular use-case the above should all be irrelevant. None of
> the drivers involved here do anything special at system suspend, because
> runtime suspend already puts the devices into the lowest possible power
> state. Basically when these devices are put into runtime suspend, they
> are completely turned off. The only exception is for things like HDMI
> where the +5V pin remains powered, so that hotplug detection will work.
>
> The runtime PM state of the devices involved is managed by the subsystem
> system suspend/resume helpers in DRM/KMS. Basically those helpers turn
> off all the devices in the composite device, which ultimately results in
> their last runtime PM reference being released. So for system suspend
> and resume, these devices aren't touched, other than maybe for the PM
> core's internal book-keeping.

OK, so you actually want system-wide PM to work like PM-runtime on the
platform in question, but there are substantial differences.

First, PM-runtime suspend can be effectively disabled by user space
and system-wide suspend is always expected to work.

Second, if system wakeup devices are involved, their handling during
system-wide suspend depends on the return value of device_may_wakeup()
which depends on what user space does, whereas PM-runtime assumes
device wakeup to be always enabled.

> > For a specific platform you may be able to overcome these limitations if
> > you are careful enough, but certainly they are there in general and surely
> > you cannot prevent people from using your opt-in just because they think
> > that they know what they are doing.
>
> That's true. But the same thing is true for pretty much all other APIs.
> People obviously have to make sure they know what they're doing, just
> like they have to with any other API.
>
> I suppose the documentation for this new function is currently lacking a
> bit. Perhaps adding a big warning to this and listing the common
> pitfalls would help people make the right call about whether or not they
> can use this.

And then *somebody* would have to chase a ton of subtle issues
resulting from that.  No, thanks, but no thanks.

> > > Is there some other alternative that I can look into?
> >
> > First of all, ensure that the dpm_list ordering is what it should be on the
> > system/platform in question.  That can be done with the help of device links.
>
> I don't think we have device links for everything, but the deferred
> probe code should take care of ordering the dpm_list correctly because
> we do handle deferred probe properly in all cases.
>
> Also, the dpm_list ordering isn't very critical in this case. If the
> devices are allowed to runtime suspend during system sleep, the
> subsystem sleep helper will put them into runtime suspend at the correct
> time. This is propagated all the way through the display pipeline and
> that order is ensured by the subsystem helpers.

You are still not saying what happens if user space doesn't allow
PM-runtime to suspend the devices (by writing "on" to their "control"
files).

> > In addition, make sure that the devices needed to suspend other devices are
> > suspended in the noirq phase of system-wide suspend and resumed in the
> > noirq phase of system-wide resume.  Or at least all of the other devices
> > need to be suspended before them and resumed after them.
>
> We're fine on this front as well. We have run into such issues in the
> past, but I don't think there are any such issue left at the moment. I
> do have one pending fix for I2C suspend/resume which fixes an issue
> where some pinmuxing changes needed to get the HDMI DDC channel to work
> were not getting applied during resume.
>
> That I2C issue is related to this, I think. What I'm seeing is that when
> the system goes to sleep, the pinmux looses its programming at a
> hardware level, but the I2C driver doesn't know about it because it does
> not get runtime suspended.

Well, no, that's not the reason.  The real reason is that the handling
of that device during system-wide suspend does not follow the rules
followed by PM-runtime for it.

Switching system-wide PM over to PM-runtime to address that is not
going to work, because PM-runtime is not mandatory and system-wide PM
is.

> At runtime suspend it would switch the pinmux
> state to "idle" which would then match the system suspend state. Upon
> runtime resume it sets the "default" pinmux state, which will then
> restore the register programming.

So this logic needs to be implemented in the system-wide suspend flow as well.

> In the current case where runtime suspend/resume is prohibited during

Runtime suspend is, runtime resume isn't until the "late" suspend phase.

> system sleep, upon resume the I2C driver will assume that the pinmux
> state is still "default" and it won't reapply the state (it's actually
> the pinmux subsystem that makes this decision) and causes HDMI DDC
> transactions to time out.

So this is a bug in the system-wide suspend/resume flow that needs to
be addressed, but not by switching it over to PM-runtime.

> One simple fix for that is to use pm_runtime_force_suspend() and
> pm_runtime_force_resume() as system suspend/resume callbacks to make
> sure the I2C controller is runtime suspended/resumed during system
> sleep.
>
> Note that forcing runtime suspend/resume this way is suboptimal in the
> DRM/KMS case because the suspend/resume happens disconnected from the
> subsystem suspend/resume callbacks, which is not desired as that breaks
> some of the assumptions in those callbacks.

So there needs to be another way.

Have you looked at DPM_FLAG_SMART_SUSPEND?

> > These two things should allow you to cover the vast majority of cases if
> > not all of them without messing up with the rules.
>
> One alternative that I had thought about was to just ditch the runtime
> PM callbacks for this. However, there's one corner case where this may
> break. On early Tegra generations, the two display controllers are
> "coupled" in that the second one doesn't work if the first one is
> disabled. We describe that using a device link from the second to the
> first controller. This causes the first controller to be automatically
> be runtime resumed when the second controller is used. This only works
> via runtime PM, so if I don't use runtime PM I'd have to add special
> handling for that case.

Runtime resume during system-wide suspend and resume is basically fine
unless you try to do it in the "late" suspend phase or later, but that
limitation is kind of artificial.  [I was talking about that at the
LPC this year.]  It basically cannot be carried out in the part of
system-wide suspend after the core regards the device and its parent
etc as "suspended", but the definition of that may be adjusted IMO.

And using PM-runtime resume during system-wide resume may be fine too,
basically (as long as the ordering of that is not lead to any kind of
loop dependencies).

On the other hand, there is *zero* need for runtime suspend during
system-wide transitions and it is known problematic.

> Actually, there's another problem as well. Most of these devices use
> generic PM domains to power on/off the SoC partitions that they're in.
> If I side-step runtime PM, then I'd have to somehow find a way to
> explicitly control the PM domains.

That's a problem with genpd, I'd say.

> Another alternative would be to have a kind of hybrid approach where I
> leave runtime PM calls in the drivers, but disconnect the runtime PM
> callback implementations from that. That would at least fix the issue
> with the generic PM domains.
>
> However, it would not fix the problem with coupled display controllers
> because empty runtime PM callbacks wouldn't actually power up the first
> display controller when it is needed by the second controller. I would
> have to add infrastructure that basically duplicates some of runtime PM
> to fix that.
>
> So the bottom line is that runtime PM is still the best solution for
> this problem. It works really nice and is very consistent.
>
> Do you think adding better documentation to this new flag and the
> accessors would help remove your concerns about this?

No, it wouldn't.

Also your arguments are mostly about PM-runtime resume, which is a
different story.
