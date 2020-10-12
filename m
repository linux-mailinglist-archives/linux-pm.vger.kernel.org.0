Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD528BE20
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 18:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbgJLQhf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 12 Oct 2020 12:37:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38207 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390610AbgJLQhf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 12:37:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id h10so6649370oie.5;
        Mon, 12 Oct 2020 09:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xcurelh7vW13up8NGtRLhHtfhV2S8gnGHhSt9Nr+B8w=;
        b=ZpEJsQ4xVXrGaJ8B/u7Tm33bHmDKLY8BZcXu10rEQpGPukohGqzIX/hcYIHKny1/n2
         euTgJGe2G7xghOHjofIBc/5dnzlXygP+ErFTUZXwWnYRM1k71+PLlsfhVMNX9laqIJPK
         nbDbM7BXei1+Yn8yOjkJTCGuDOdM7Gagt8lYrFZP4HzeARsQsMQUNfU2yGVfWOOqCrLS
         favU+EYs53pnCH1c4HhCEKrtQD2XPNvWXI07F/9k7qnCVQmPDew0Ap/aP+zVMnIEchuq
         NWEKIuiKLRQPVwwYWphrcYNryBoTE3M2dDeC5vyubomwtU7U61FRa6QCtc1Y8v23Iu6s
         B+Vw==
X-Gm-Message-State: AOAM531PhfHdsE42njG7wamDuwAQjMX3mh9LTYWdQOYITgLvnQjbKHCt
        00WLGOhaWCwd+8XJ3b6MjlduhksKwsUCzU86XCqU4bSJ
X-Google-Smtp-Source: ABdhPJxfau0lc7K8/8I7s0oJxNL9bNNG4B7A9PFASkmEgL4HVwcQrC47ED3ixAZN/+7PnjDdLr7cHAAD8KBfi4pLvp0=
X-Received: by 2002:aca:724a:: with SMTP id p71mr11474381oic.157.1602520653510;
 Mon, 12 Oct 2020 09:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com> <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
 <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com>
In-Reply-To: <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Oct 2020 18:37:22 +0200
Message-ID: <CAJZ5v0gwc_d1vnwDVWXY+i4f0T2r0tAz8xuWV7oS_afsy7OocQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] powercap/dtpm: Add the DTPM framework
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 12, 2020 at 1:46 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Daniel,
>
> On 10/12/20 12:30 PM, Daniel Lezcano wrote:
> >
> > Hi Hans,
> >
> > On 07/10/2020 12:43, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 10/6/20 2:20 PM, Daniel Lezcano wrote:
> >>> The density of components greatly increased the last decade bringing a
> >>> numerous number of heating sources which are monitored by more than 20
> >>> sensors on recent SoC. The skin temperature, which is the case
> >>> temperature of the device, must stay below approximately 45°C in order
> >>> to comply with the legal requirements.
> >>>
> >>> The skin temperature is managed as a whole by an user space daemon,
> >>> which is catching the current application profile, to allocate a power
> >>> budget to the different components where the resulting heating effect
> >>> will comply with the skin temperature constraint.
> >>>
> >>> This technique is called the Dynamic Thermal Power Management.
> >>>
> >>> The Linux kernel does not provide any unified interface to act on the
> >>> power of the different devices. Currently, the thermal framework is
> >>> changed to export artificially the performance states of different
> >>> devices via the cooling device software component with opaque values.
> >>> This change is done regardless of the in-kernel logic to mitigate the
> >>> temperature. The user space daemon uses all the available knobs to act
> >>> on the power limit and those differ from one platform to another.
> >>>
> >>> This series provides a Dynamic Thermal Power Management framework to
> >>> provide an unified way to act on the power of the devices.
> >>
> >> Interesting, we have a discussion going on about a related
> >> (while at the same time almost orthogonal) discussion for
> >> setting policies for if the code managing the restraints
> >> (which on x86 is often hidden in firmware or ACPI DPTF tables)
> >> should have a bias towards trying to have as long a battery life
> >> as possible, vs maximum performance. I know those 2 aren't
> >> always opposite ends of a spectrum with race-to-idle, yet most
> >> modern x86 hardware has some notion of what I call performance-profiles
> >> where we can tell the firmware managing this to go for a bias towards
> >> low-power / balanced / performance.
> >>
> >> I've send a RFC / sysfs API proposal for this here:
> >> https://lore.kernel.org/linux-pm/20201003131938.9426-1-hdegoede@redhat.com/
> >>
> >> I've read the patches in this thread and as said already I think
> >> the 2 APIs are mostly orthogonal. The API in this thread is giving
> >> userspace direct access to detailed power-limits allowing userspace
> >> to configure things directly (and for things to work optimal userspace
> >> must do this). Where as in the x86 case with which I'm dealing everything
> >> is mostly handled in a black-box and userspace can merely configure
> >> the low-power / balanced / performance bias (*) of that black-box.
> >>
> >> Still I think it is good if we are aware of each-others efforts here.
> >>
> >> So Daniel, if you can take a quick look at my proposal:
> >> https://lore.kernel.org/linux-pm/20201003131938.9426-1-hdegoede@redhat.com/
> >>
> >> That would be great. I think we definitely want to avoid having 2
> >> APIs for the same thing here. Again I don't think that is actually
> >> the case, but maybe you see this differently ?
> >
> > Thanks for pointing this out. Actually, it is a different feature as you
> > mentioned. The profile is the same knob we have with the BIOS where we
> > can choose power/ balanced power / balanced/balanced
> > performance / performance, AFAICT.
>
> Right.
>
> > Here the proposed interface is already exported in userspace via the
> > powercap framework which supports today the backend driver for the RAPL
> > register.
>
> You say that some sort of power/ balanced power / balanced /
> balanced performance / performance setting in is already exported
> through the powercap interface today (if I understand you correctly)?
>
> But I'm not seeing any such setting in:
> Documentation/ABI/testing/sysfs-class-powercap
>
> Nor can I find it under /sys/class/powercap/intel-rapl* on a ThinkPad
> X1 carbon 8th gen.
>
> Note, if there indeed is an existing userspace API for this I would
> greatly prefer for the thinkpad_acpi and hp-wmi (and possibly other)
> drivers to use this, so if you can point me to this interface then
> that would be great.
>
> > The userspace will be in charge of handling the logic to have the
> > correct power/performance profile tuned against the current application
> > running foreground. The DTPM framework gives the unified access to the
> > power limitation to the individual devices the userspace logic can act on.
> >
> > A side note, related to your proposal, not this patch. IMO it suits
> > better to have /sys/power/profile.
> >
> > cat /sys/power/profile
> >
> > power
> > balanced_power *
> > balanced
> > balanced_performance
> > performance
> >
> > The (*) being the active profile.
>
> Interesting the same thing was brought up in the discussion surrounding
> RFC which I posted.
>
> The downside against this approach is that it assumes that there
> only is a single system-wide settings. AFAIK that is not always
> the case, e.g. (AFAIK):
>
> 1. The intel pstate driver has something like this
>     (might this be the rapl setting you mean? )
>
> 2. The X1C8 has such a setting for the embedded-controller, controlled
>     through the ACPI interfaces which thinkpad-acpi used
>
> 3. The hp-wmi interface allows selecting a profile which in turn
>     (through AML code) sets a bunch of variables which influence how
>     the (dynamic, through mjg59's patches) DPTF code controls various
>     things
>
> At least the pstate setting and the vendor specific settings can
> co-exist. Also the powercap API has a notion of zones, I can see the
> same thing here, with a desktop e.g. having separate performance-profile
> selection for the CPU and a discrete GPU.
>
> So limiting the API to a single /sys/power/profile setting seems a
> bit limited and I have the feeling we will regret making this
> choice in the future.
>
> With that said your proposal would work well for the current
> thinkpad_acpi / hp-wmi cases, so I'm not 100% against it.
>
> This would require adding some internal API to the code which
> owns the /sys/power root-dir to allow registering a profile
> provider I guess. But that would also immediately bring the
> question, what if multiple drivers try to register themselves
> as /sys/power/profile provider ?

It doesn't need to work this way IMV.

It may also work by allowing drivers (or whatever kernel entities are
interested in that) to subscribe to it, so that they get notified
whenever a new value is written to it by user space (eg. each driver
may be able to register a callback to be invoked when that happens).
The information coming from user space will just be passed to the
subscribers of that interface and they will do about it what they want
(eg. it may be translated into a value to be written to a
performance-vs-power interface provided by the platform or similar).

This really is similar to having a class interface with one file per
"subscribed" device except that the aggregation is done in the kernel
and not in user space and the subscribers need not be related to
specific devices.  It still allows to avoid exposing the low-level
interfaces to user space verbatim and it just passes the "policy"
choice from user space down to the entities that can take it into
account.
