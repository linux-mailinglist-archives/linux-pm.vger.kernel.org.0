Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3928E36B
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 17:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgJNPmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 11:42:24 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:41886 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgJNPmY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 11:42:24 -0400
Received: by mail-oo1-f66.google.com with SMTP id o184so892540ooo.8;
        Wed, 14 Oct 2020 08:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrkV8mFFv0dBfuHUHMBCqlhs29wEgefG1IN2G7yumGo=;
        b=Vq0YziNIrXHV4QIGTEesf+8rd55XlqDgsFMH0IP9atMaCb6Mx55qrrEyIP1iGdK3jY
         h6T69ayPrWXG4bOj8jgghihr2YpPZgBj1kdHvRix6wPKKLplSL8k3dR5rljlp6vNk+Yv
         lIL59vMBwaQ5ufVW0keGng4PafaAPB1xmwZngStGUYd9wMNq3pvrhVP7wR1jVDMBfF41
         L3gOc11+B89FC5frGzzF085Kxgk11ayNi2AsdXhXsezpxsFHHlJqjE8e9WxgZK9T1xej
         jSKTcN2EK9ACvbblUviiycNswZfauJ7dBRh+NGaOv4ro1uXKcwZCzx9crL5Uwsa+bSud
         2BcQ==
X-Gm-Message-State: AOAM530PcFwgbIvKtTRVrNZ3honYQFk0jxtk8rdYQKRteYWhn9WQOI21
        kJUMIeTkQ+FX0sf4ziPQZ+MXDGXavnfiI/EMiVw=
X-Google-Smtp-Source: ABdhPJxw1lKooycL87Ij+cAEDhXvTAPYUMXE5Z0l0fAZeMqQJQTlbIbkqb/dxTYHbehg0mM8xlVmhvh9AMvMIIGSQ8Q=
X-Received: by 2002:a4a:d157:: with SMTP id o23mr3977562oor.2.1602690141225;
 Wed, 14 Oct 2020 08:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com> <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
 <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com> <CAJZ5v0gwc_d1vnwDVWXY+i4f0T2r0tAz8xuWV7oS_afsy7OocQ@mail.gmail.com>
 <63dfa6a1-0424-7985-7803-756c0c5cc4a5@redhat.com> <CAJZ5v0jpYpu3Tk7qq_MCVs0wUr-Dw0rY5EZELrVbQta0NZaoVA@mail.gmail.com>
 <87d9a808-39d6-4949-c4f9-6a80d14a3768@redhat.com>
In-Reply-To: <87d9a808-39d6-4949-c4f9-6a80d14a3768@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Oct 2020 17:42:10 +0200
Message-ID: <CAJZ5v0iWmmu5WV7cX7uNb61NMYQ7s0dnhg1K+T0x90b3sBfU9w@mail.gmail.com>
Subject: Re: [PATCH 0/4] powercap/dtpm: Add the DTPM framework
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        Mark Pearson <mpearson@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 14, 2020 at 4:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 10/14/20 3:33 PM, Rafael J. Wysocki wrote:
> > Hi Hans,
> >
> > On Tue, Oct 13, 2020 at 3:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 10/12/20 6:37 PM, Rafael J. Wysocki wrote:
> >>> On Mon, Oct 12, 2020 at 1:46 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> <snip>
> >>
> >>>>> A side note, related to your proposal, not this patch. IMO it suits
> >>>>> better to have /sys/power/profile.
> >>>>>
> >>>>> cat /sys/power/profile
> >>>>>
> >>>>> power
> >>>>> balanced_power *
> >>>>> balanced
> >>>>> balanced_performance
> >>>>> performance
> >>>>>
> >>>>> The (*) being the active profile.
> >>>>
> >>>> Interesting the same thing was brought up in the discussion surrounding
> >>>> RFC which I posted.
> >>>>
> >>>> The downside against this approach is that it assumes that there
> >>>> only is a single system-wide settings. AFAIK that is not always
> >>>> the case, e.g. (AFAIK):
> >>>>
> >>>> 1. The intel pstate driver has something like this
> >>>>       (might this be the rapl setting you mean? )
> >>>>
> >>>> 2. The X1C8 has such a setting for the embedded-controller, controlled
> >>>>       through the ACPI interfaces which thinkpad-acpi used
> >>>>
> >>>> 3. The hp-wmi interface allows selecting a profile which in turn
> >>>>       (through AML code) sets a bunch of variables which influence how
> >>>>       the (dynamic, through mjg59's patches) DPTF code controls various
> >>>>       things
> >>>>
> >>>> At least the pstate setting and the vendor specific settings can
> >>>> co-exist. Also the powercap API has a notion of zones, I can see the
> >>>> same thing here, with a desktop e.g. having separate performance-profile
> >>>> selection for the CPU and a discrete GPU.
> >>>>
> >>>> So limiting the API to a single /sys/power/profile setting seems a
> >>>> bit limited and I have the feeling we will regret making this
> >>>> choice in the future.
> >>>>
> >>>> With that said your proposal would work well for the current
> >>>> thinkpad_acpi / hp-wmi cases, so I'm not 100% against it.
> >>>>
> >>>> This would require adding some internal API to the code which
> >>>> owns the /sys/power root-dir to allow registering a profile
> >>>> provider I guess. But that would also immediately bring the
> >>>> question, what if multiple drivers try to register themselves
> >>>> as /sys/power/profile provider ?
> >>>
> >>> It doesn't need to work this way IMV.
> >>>
> >>> It may also work by allowing drivers (or whatever kernel entities are
> >>> interested in that) to subscribe to it, so that they get notified
> >>> whenever a new value is written to it by user space (eg. each driver
> >>> may be able to register a callback to be invoked when that happens).
> >>> The information coming from user space will just be passed to the
> >>> subscribers of that interface and they will do about it what they want
> >>> (eg. it may be translated into a value to be written to a
> >>> performance-vs-power interface provided by the platform or similar).
> >>>
> >>> This really is similar to having a class interface with one file per
> >>> "subscribed" device except that the aggregation is done in the kernel
> >>> and not in user space and the subscribers need not be related to
> >>> specific devices.  It still allows to avoid exposing the low-level
> >>> interfaces to user space verbatim and it just passes the "policy"
> >>> choice from user space down to the entities that can take it into
> >>> account.
> >>
> >> First of all thank you for your input, with your expertise in this
> >> area your input is very much appreciated, after all we only get
> >> one chance to get the userspace API for this right.
> >>
> >> Your proposal to have a single sysfs file for userspace to talk
> >> to and then use an in kernel subscription mechanism for drivers
> >> to get notified of writes to this file is interesting.
> >>
> >> But I see 2 issues with it:
> >>
> >> 1. How will userspace know which profiles are actually available ?
> >>
> >> An obvious solution is to pick a set of standard names and let
> >> subscribers map those as close to their own settings as possible,
> >> the most often mentioned set of profile names in this case seems to be:
> >>
> >> low_power
> >> balanced_power
> >> balanced
> >> balanced_performance
> >> performance
> >>
> >> Which works fine for the thinkpad_acpi case, but not so much for
> >> the hp-wmi case. In the HP case what happens is that a WMI call
> >> is made which sets a bunch of ACPI variables which influence
> >> the DPTF code (this assumes we have some sort of DPTF support
> >> such as mjg59's reverse engineered support) but the profile-names
> >> under Windows are: "Performance", "HP recommended", "Cool" and
> >> "Quiet".  If you read the discussion from the
> >> "[RFC] Documentation: Add documentation for new performance_profile sysfs class"
> >> thread you will see this was brought up as an issue there.
> >
> > Two different things seem to be conflated here.  One is how to pass a
> > possible performance-vs-power preference coming from user space down
> > to device drivers or generally pieces of kernel code that can adjust
> > the behavior and/or hardware settings depending on what that
> > preference is and the other is how to expose OEM-provided DPTF system
> > profile interfaces to user space.
>
> I was hoping / thinking that we could use a single API for both of
> these. But I guess that it makes sense to see them as 2 separate
> things, esp. since DPTF profiles seem to be somewhat free-form
> where as a way to pass a performance-pref to a device could use
> a fixes set of values.
>
> So lets say that we indeed want to treat these 2 separately,
> then I guess that the issue at hand / my reason to start a
> discussion surrounding this is allowing userspace to selecting
> the DPTF system profile.
>
> The thinkpad_acpi case at hand is not using DPTF, but that is
> because Lenovo decided to implement dynamic DPTF like behavior
> inside their embedded controller (for when running Linux) since
> DPTF is atm not really supported all that well under Linux and
> Lenovo was getting a lot of complaints about sub-optimal
> performance because of this.
>
> So the thinkpad_acpi solution is in essence a replacement
> for DPTF and it should thus use the same userspace API as
> other mechanisms to select DPTF system profiles.
>
> And if we limit this new userspace API solely to setting DPTF
> system profiles, then their will indeed be only 1 provider for
> this for the entire system.
>
> > The former assumes that there is a common set of values that can be
> > understood and acted on in a consistent way by all of the interested
> > entities within the kernel and the latter is about passing information
> > from user space down to a side-band power control mechanism working in
> > its own way behind the kernel's back (and possibly poking at multiple
> > hardware components in the platform in its own way).
>
> Ack.
>
> > IMO there is no way to provide a common interface covering these two
> > cases at the same time.
>
> I see your point, esp. the free form vs common set of values
> argument seems to be exactly what we have been going in circles
> about during the discussion about this so far.
>
> >> The problem here is that both "cool" and "quiet" could be
> >> interpreted as low-power. But it seems that they actually mean
> >> what they say, cool focuses on keeping temps low, which can
> >> also be done by making the fan-profile more aggressive. And quiet
> >> is mostly about keeping fan speeds down, at the cost of possible
> >> higher temperatures.  IOW we don't really have a 1 dimensional
> >> axis.
> >
> > Well, AFAICS, DPTF system profile interfaces coming from different
> > OEMs will be different, but they are about side-band power control and
> > there can be only one thing like that in a platform at the same time.
>
> Ack.
>
> >> My class proposal fixes this by having a notion of both
> >> standardized names (because anything else would suck) combined
> >> with a way for drivers to advertise which standardized names
> >> the support. So in my proposal I simply add quiet and cool
> >> to the list of standard profile names, and then the HP-wmi
> >> driver can list those as supported, while not listing
> >> low_power as a supported profile.  This way we export the
> >> hardware interface to userspace as is (as much as possible)
> >> while still offering a standardized interface for userspace
> >> to consume.  Granted if userspace now actually want to set
> >> a low_power profile, we have just punted the problem to userspace
> >> but I really do not see a better solution.
> >
> > First, a common place to register a DPTF system profile seems to be
> > needed and, as I said above, I wouldn't expect more than one such
> > thing to be present in the system at any given time, so it may be
> > registered along with the list of supported profiles and user space
> > will have to understand what they mean.
>
> Mostly Ack, I would still like to have an enum for DPTF system
> profiles in the kernel and have a single piece of code map that
> enum to profile names. This enum can then be extended as
> necessary, but I want to avoid having one driver use
> "Performance" and the other "performance" or one using
> "performance-balanced" and the other "balanced-performance", etc.
>
> With the goal being that new drivers use existing values from
> the enum as much as possible, but we extend it where necessary.

IOW, just a table of known profile names with specific indices assigned to them.

This sounds reasonable.

> > Second, irrespective of the above, it may be useful to have a
> > consistent way to pass performance-vs-power preference information
> > from user space to different parts of the kernel so as to allow them
> > to adjust their operation and this could be done with a system-wide
> > power profile attribute IMO.
>
> I agree, which is why I tried to tackle both things in one go,
> but as you said doing both in 1 API is probably not the best idea.
> So I believe we should park this second issue for now and revisit it
> when we find a need for it.

Agreed.

> Do you have any specific userspace API in mind for the
> DPTF system profile selection?

Not really.

> And to get one thing out of the way, in the other thread we had some
> discussion about using a single attribute where a cat would result in:
>
> low-power [balanced] performance
>
> Where the [] indicate the active profile, vs having 2 sysfs attributes
> one ro with space-separated available (foo_available) values and one
> wr with the actual/current value. FWIW userspace folks have indicated
> they prefer the solution with 2 separate sysfs-attributes and that is
> also what e.g. cpufreq is currently using for governor selection.

Right.

It also uses that for the EPP "profiles" selection which kind of
belongs to the same broad category of settings.

> I don't really have a strong opinion either way.

Me neither. :-)

I guess from the perspective of a script accessing the interface it is
somewhat more straightforward to read what is available as a
white-space-separated list without the need for extra parsing.

Cheers!
