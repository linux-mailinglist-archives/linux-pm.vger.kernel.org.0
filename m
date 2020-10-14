Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5328E160
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgJNNdz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 09:33:55 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:41608 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgJNNdz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 09:33:55 -0400
Received: by mail-oo1-f68.google.com with SMTP id o184so780566ooo.8;
        Wed, 14 Oct 2020 06:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLZsxiXaFfiCuIg2Isc5xel2OxklQgIRV5Rf6fjT3rU=;
        b=gSa8aUOddV6odkJ0xmtPBBMQuBDU+6CgcaR5bPoPsNRlao3682JXhD3yV3szijs4QF
         b374+AOxMVdqT6Gh2xF/Uc0T/1BO1xehPq+mS4Ld7f13rBHxftURbXm1puImGaOBqmo0
         pTg5qfAZMle0hbvuiA1+ZxpJUusWQ7+qFSQ5T+ZOhQSxXb3RRIKhd1prS3TM/Yk9GjCg
         Lyt84LFz7HutbxmhNKNqZ+ZkrWn955ByFkuQlAT4CUJhbYy15PoCthfWlG1BexPfHNqP
         u4Q3sW+o5zR+Fk4XT1zIFejF3c6SMhI32A+Ykq5QyMbvgLWto73+5coBIz7r4LQYuIxi
         qneg==
X-Gm-Message-State: AOAM533PlKN8jb9xcKh53gXz2RJLn6se6vmRNcipfdL15v0Ukba2Asim
        9kgiKArolnxcxq8ehZo4t/AoXsaXdDEKg3syD54=
X-Google-Smtp-Source: ABdhPJze/+mVtMfKwe1eU7QJI0tDg1nbQ1rk2o6KUD1+ZZz17j9aRUzXfLkln3KTlzlAygI05Uqun+TqAE3J2zdC3YY=
X-Received: by 2002:a4a:d815:: with SMTP id f21mr3555508oov.44.1602682433294;
 Wed, 14 Oct 2020 06:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com> <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
 <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com> <CAJZ5v0gwc_d1vnwDVWXY+i4f0T2r0tAz8xuWV7oS_afsy7OocQ@mail.gmail.com>
 <63dfa6a1-0424-7985-7803-756c0c5cc4a5@redhat.com>
In-Reply-To: <63dfa6a1-0424-7985-7803-756c0c5cc4a5@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Oct 2020 15:33:42 +0200
Message-ID: <CAJZ5v0jpYpu3Tk7qq_MCVs0wUr-Dw0rY5EZELrVbQta0NZaoVA@mail.gmail.com>
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

Hi Hans,

On Tue, Oct 13, 2020 at 3:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> On 10/12/20 6:37 PM, Rafael J. Wysocki wrote:
> > On Mon, Oct 12, 2020 at 1:46 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> <snip>
>
> >>> A side note, related to your proposal, not this patch. IMO it suits
> >>> better to have /sys/power/profile.
> >>>
> >>> cat /sys/power/profile
> >>>
> >>> power
> >>> balanced_power *
> >>> balanced
> >>> balanced_performance
> >>> performance
> >>>
> >>> The (*) being the active profile.
> >>
> >> Interesting the same thing was brought up in the discussion surrounding
> >> RFC which I posted.
> >>
> >> The downside against this approach is that it assumes that there
> >> only is a single system-wide settings. AFAIK that is not always
> >> the case, e.g. (AFAIK):
> >>
> >> 1. The intel pstate driver has something like this
> >>      (might this be the rapl setting you mean? )
> >>
> >> 2. The X1C8 has such a setting for the embedded-controller, controlled
> >>      through the ACPI interfaces which thinkpad-acpi used
> >>
> >> 3. The hp-wmi interface allows selecting a profile which in turn
> >>      (through AML code) sets a bunch of variables which influence how
> >>      the (dynamic, through mjg59's patches) DPTF code controls various
> >>      things
> >>
> >> At least the pstate setting and the vendor specific settings can
> >> co-exist. Also the powercap API has a notion of zones, I can see the
> >> same thing here, with a desktop e.g. having separate performance-profile
> >> selection for the CPU and a discrete GPU.
> >>
> >> So limiting the API to a single /sys/power/profile setting seems a
> >> bit limited and I have the feeling we will regret making this
> >> choice in the future.
> >>
> >> With that said your proposal would work well for the current
> >> thinkpad_acpi / hp-wmi cases, so I'm not 100% against it.
> >>
> >> This would require adding some internal API to the code which
> >> owns the /sys/power root-dir to allow registering a profile
> >> provider I guess. But that would also immediately bring the
> >> question, what if multiple drivers try to register themselves
> >> as /sys/power/profile provider ?
> >
> > It doesn't need to work this way IMV.
> >
> > It may also work by allowing drivers (or whatever kernel entities are
> > interested in that) to subscribe to it, so that they get notified
> > whenever a new value is written to it by user space (eg. each driver
> > may be able to register a callback to be invoked when that happens).
> > The information coming from user space will just be passed to the
> > subscribers of that interface and they will do about it what they want
> > (eg. it may be translated into a value to be written to a
> > performance-vs-power interface provided by the platform or similar).
> >
> > This really is similar to having a class interface with one file per
> > "subscribed" device except that the aggregation is done in the kernel
> > and not in user space and the subscribers need not be related to
> > specific devices.  It still allows to avoid exposing the low-level
> > interfaces to user space verbatim and it just passes the "policy"
> > choice from user space down to the entities that can take it into
> > account.
>
> First of all thank you for your input, with your expertise in this
> area your input is very much appreciated, after all we only get
> one chance to get the userspace API for this right.
>
> Your proposal to have a single sysfs file for userspace to talk
> to and then use an in kernel subscription mechanism for drivers
> to get notified of writes to this file is interesting.
>
> But I see 2 issues with it:
>
> 1. How will userspace know which profiles are actually available ?
>
> An obvious solution is to pick a set of standard names and let
> subscribers map those as close to their own settings as possible,
> the most often mentioned set of profile names in this case seems to be:
>
> low_power
> balanced_power
> balanced
> balanced_performance
> performance
>
> Which works fine for the thinkpad_acpi case, but not so much for
> the hp-wmi case. In the HP case what happens is that a WMI call
> is made which sets a bunch of ACPI variables which influence
> the DPTF code (this assumes we have some sort of DPTF support
> such as mjg59's reverse engineered support) but the profile-names
> under Windows are: "Performance", "HP recommended", "Cool" and
> "Quiet".  If you read the discussion from the
> "[RFC] Documentation: Add documentation for new performance_profile sysfs class"
> thread you will see this was brought up as an issue there.

Two different things seem to be conflated here.  One is how to pass a
possible performance-vs-power preference coming from user space down
to device drivers or generally pieces of kernel code that can adjust
the behavior and/or hardware settings depending on what that
preference is and the other is how to expose OEM-provided DPTF system
profile interfaces to user space.

The former assumes that there is a common set of values that can be
understood and acted on in a consistent way by all of the interested
entities within the kernel and the latter is about passing information
from user space down to a side-band power control mechanism working in
its own way behind the kernel's back (and possibly poking at multiple
hardware components in the platform in its own way).

IMO there is no way to provide a common interface covering these two
cases at the same time.

> The problem here is that both "cool" and "quiet" could be
> interpreted as low-power. But it seems that they actually mean
> what they say, cool focuses on keeping temps low, which can
> also be done by making the fan-profile more aggressive. And quiet
> is mostly about keeping fan speeds down, at the cost of possible
> higher temperatures.  IOW we don't really have a 1 dimensional
> axis.

Well, AFAICS, DPTF system profile interfaces coming from different
OEMs will be different, but they are about side-band power control and
there can be only one thing like that in a platform at the same time.

> My class proposal fixes this by having a notion of both
> standardized names (because anything else would suck) combined
> with a way for drivers to advertise which standardized names
> the support. So in my proposal I simply add quiet and cool
> to the list of standard profile names, and then the HP-wmi
> driver can list those as supported, while not listing
> low_power as a supported profile.  This way we export the
> hardware interface to userspace as is (as much as possible)
> while still offering a standardized interface for userspace
> to consume.  Granted if userspace now actually want to set
> a low_power profile, we have just punted the problem to userspace
> but I really do not see a better solution.

First, a common place to register a DPTF system profile seems to be
needed and, as I said above, I wouldn't expect more than one such
thing to be present in the system at any given time, so it may be
registered along with the list of supported profiles and user space
will have to understand what they mean.

Second, irrespective of the above, it may be useful to have a
consistent way to pass performance-vs-power preference information
from user space to different parts of the kernel so as to allow them
to adjust their operation and this could be done with a system-wide
power profile attribute IMO.

> 2. This only works assuming that all performance-profiles
> are system wide. But given a big desktop case there might
> be very well be separate cooling zones for e.g. the CPU
> and the GPU and I can imagine both having separate
> performance-profile settings and some users will doubtlessly
> want to be able to control these separately ...

Let's say that I'm not convinced. :-)

They cannot be totally separate, because they will affect each other
and making possibly conflicting adjustments needs to be avoided.

Cheers!
