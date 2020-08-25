Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD983251CB2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 17:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgHYPxO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 11:53:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46350 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYPxO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 11:53:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id v13so12012190oiv.13;
        Tue, 25 Aug 2020 08:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EXZxt6bvtlHUS5SX4TpE5JhZOZFVfpCdsIvD6bUnoY=;
        b=eBmQIPNECVy2CcgxQa/Y2XX4GSt7flZYz7lCx87e3ZF4uodPYtfTPrJgEFrmKdbG4Y
         2pRCoN5KS7EIUGgv6oCf2zwGr4xkExkZ8r3lBcBRTYC1QwxFnr1B3G1HnPibe8DSwZqk
         E6L5oDtBaMXVN937jFaaT0zX7NqK01TtQIUV0JHshBDIniZ7Az200CXwkYnsaNA5z1YR
         uvrR0FuiwzW9dSRo3xhzE7g5BCP75V9tvY8jU5Wocm2e87K5i3fyx0Ya4Ez+Ggihhcvp
         VMqEDfEwKkJfwgNgFCiJQOPJPMpxvScUpoN4hU5vNAQKVRDYh7uZlMdMQseS8LZ20e4v
         dYMA==
X-Gm-Message-State: AOAM531/401z5c0eUBBU29lk04O7cF5S0iy/gYXGykslLWghMEEh/7QB
        oMhO0RJY+edr9UaOv7Nz12D6nWgEccQiRiyWg9o=
X-Google-Smtp-Source: ABdhPJy0oxG3uzafUkAVrJQWE3ctgSPczZK9J9ZrAMpOIHMXOa0SFzh/Aa7gCYme+Job4EiPtI7eVf58hi5FOcjim8A=
X-Received: by 2002:a05:6808:3d5:: with SMTP id o21mr1468912oie.110.1598370793137;
 Tue, 25 Aug 2020 08:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <4169555.5IIHXK4Dsd@kreacher> <2064342.aRc67yb0pC@kreacher>
 <61ea43fce7dd8700d94f12236a86ffec6f76a898.camel@gmail.com>
 <CAJZ5v0hkmcAuCsnfjCSWTarr4pkQry2VCtk2aWM74fOW2guzmg@mail.gmail.com>
 <1341038e00d965e913ee9f0c7a1e739eadef42f7.camel@linux.intel.com>
 <CAJZ5v0gf9WCwm8Bdzo02Jfbz5vgdH8c_T9y89SaVvTNXH7p4hA@mail.gmail.com> <bb272be6e251129d0ec248ab53b8515907340e7a.camel@linux.intel.com>
In-Reply-To: <bb272be6e251129d0ec248ab53b8515907340e7a.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Aug 2020 17:53:02 +0200
Message-ID: <CAJZ5v0hLMboPt7jti5GZXgus2jbQ5z-9-NGwKiQjYbnu9mcA6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] cpufreq: intel_pstate: Always return last EPP
 value from sysfs
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 25, 2020 at 5:27 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2020-08-25 at 17:14 +0200, Rafael J. Wysocki wrote:
> > On Tue, Aug 25, 2020 at 5:06 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > On Tue, 2020-08-25 at 16:51 +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Aug 25, 2020 at 8:20 AM Artem Bityutskiy <
> > > > dedekind1@gmail.com
> > > > > wrote:
> > > > > On Mon, 2020-08-24 at 19:42 +0200, Rafael J. Wysocki wrote:
> > > > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > Make the energy_performance_preference policy attribute in
> > > > > > sysfs
> > > > > > always return the last EPP value written to it instead of the
> > > > > > one
> > > > > > currently in the HWP Request MSR to avoid possible confusion
> > > > > > when
> > > > > > the performance scaling algorithm is used in the active mode
> > > > > > with
> > > > > > HWP enabled (in which case the EPP is forced to 0 regardless
> > > > > > of
> > > > > > what value it has been set to via sysfs).
> > > > >
> > > > > Why is this a good idea, I wonder. If there was a prior
> > > > > discussion,
> > > > > please, point to it.
> > > > >
> > > > > The general approach to changing settings via sysfs is often
> > > > > like
> > > > > this:
> > > > >
> > > > > 1. Write new value.
> > > > > 2. Read it back and verify that it is the same. Because there
> > > > > is no
> > > > > better way to verify that the kernel "accepted" the value.
> > > >
> > > > If the write is successful (ie. no errors returned and the value
> > > > returned is equal to the number of written characters), the
> > > > kernel
> > > > *has* accepted the written value, but it may not have taken
> > > > effect.
> > > > These are two different things.
> > > >
> > > > The written value may take an effect immediately or it may take
> > > > an
> > > > effect later, depending on the current configuration etc.  If you
> > > > don't see the effect of it immediately, it doesn't matter that
> > > > there
> > > > was a failure of some sort.
> > > >
> > > > > Let's say I write 'balanced' to energy_performance_preference.
> > > > > I
> > > > > read
> > > > > it back, and it contains 'balanced', so I am happy, I trust the
> > > > > kernel
> > > > > changed EPP to "balanced".
> > > > >
> > > > > If the kernel, in fact, uses something else, I want to know
> > > > > about
> > > > > it
> > > > > and have my script fail.
> > > >
> > > > Why do you want it to fail then?
> > > >
> > > > > Why caching the value and making my script _think_ it succeeded
> > > > > is
> > > > > a good idea.
> > > >
> > > > Because when you change the scaling algorithm or the driver's
> > > > operation mode, the value you have written will take effect.
> > > >
> > > > In this particular case it is explained in the driver
> > > > documentation
> > > > that the performance scaling algorithm in the active mode
> > > > overrides
> > > > the sysfs value and that's the only case when it can be
> > > > overridden.
> > > > So whatever you write to this attribute will not take effect
> > > > immediately anyway, but it may take an effect later.
> > >
> > > In some cases without even changing active/passive this is
> > > happening
> > > when there was some error previously. For example:
> > >
> > > #cat energy_performance_preference
> > > 127
> > > [root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -p 1 0x774
> > > 8000ff00
> > >
> > > I think we should show reality. In mode change can be a special
> > > case
> > > and use the stored value to restore in new mode.
> >
> > OK, so I'll make it fail on attempts to change the EPP from 0
> > (performance) in the active mode with the performance "governor".
> >
> Here the scaling governor is powersave.
>
> # cat scaling_governor
> powersave

What I'm saying is that reads from energy_performance_preference will
still return the register value, but writes to it will fail on
attempts to change to anything different from "performance" when in
the active mode and the current governor is "performance".

Cheers!
