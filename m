Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20307251B50
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHYOwA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 10:52:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34009 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHYOvw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 10:51:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id z22so11831213oid.1;
        Tue, 25 Aug 2020 07:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ylVPg9/PXce4pT2IR4gKle+fSVW1ZRt1vDCYod4rN8=;
        b=HI0uJ5ca375SW36B0Qqv9rSR83yIsIobvbzGIRzOQokQ2xOtYOF4HMA2qnS50c7/rm
         ilV6/LXdBsNwKLht5ZAW6hgoJddexutbxZzuDT2PU3+tHzn33mbt7Vp30EMFjMZVJaWe
         nHkJSPAJyuGZ4IvSVIgVGHMjF/Ai/z/M7fB6FLbV1h/r1mmoaKPWcZXZR76BOqQ/W8pt
         UrGWqXRS+8QqNg3MUPPE2MXmkIqa/5tag0xRTb3h8/30+0rQOxJF/g5ckiTfQkiFYYUP
         mJZilsuNasJxrr/OtcZVf/gQfzuSkgPGUf2NgYEV3hO2BTrcHsrzPUMNcBcVXKUQzZpx
         lYdw==
X-Gm-Message-State: AOAM532xjSD7xyK7iPzJX3gfTvKc9kNOwfKWAVTFHhklDXWNvq7k4ksq
        dR4U3xXPrCDG7tAy1os2lUNSTOuA48x+mOQORhQ=
X-Google-Smtp-Source: ABdhPJwqJQS2tbUF7jqx3k1gHhGfoM4gKMhNdMHaSpRuHkR0DsUvna55zZygMHn8se8UyztTq7pobqnChzlnhKJ6j+4=
X-Received: by 2002:a05:6808:3d5:: with SMTP id o21mr1287215oie.110.1598367111572;
 Tue, 25 Aug 2020 07:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <4169555.5IIHXK4Dsd@kreacher> <2064342.aRc67yb0pC@kreacher> <61ea43fce7dd8700d94f12236a86ffec6f76a898.camel@gmail.com>
In-Reply-To: <61ea43fce7dd8700d94f12236a86ffec6f76a898.camel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Aug 2020 16:51:40 +0200
Message-ID: <CAJZ5v0hkmcAuCsnfjCSWTarr4pkQry2VCtk2aWM74fOW2guzmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] cpufreq: intel_pstate: Always return last EPP
 value from sysfs
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 25, 2020 at 8:20 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Mon, 2020-08-24 at 19:42 +0200, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Make the energy_performance_preference policy attribute in sysfs
> > always return the last EPP value written to it instead of the one
> > currently in the HWP Request MSR to avoid possible confusion when
> > the performance scaling algorithm is used in the active mode with
> > HWP enabled (in which case the EPP is forced to 0 regardless of
> > what value it has been set to via sysfs).
>
> Why is this a good idea, I wonder. If there was a prior discussion,
> please, point to it.
>
> The general approach to changing settings via sysfs is often like this:
>
> 1. Write new value.
> 2. Read it back and verify that it is the same. Because there is no
> better way to verify that the kernel "accepted" the value.

If the write is successful (ie. no errors returned and the value
returned is equal to the number of written characters), the kernel
*has* accepted the written value, but it may not have taken effect.
These are two different things.

The written value may take an effect immediately or it may take an
effect later, depending on the current configuration etc.  If you
don't see the effect of it immediately, it doesn't matter that there
was a failure of some sort.

> Let's say I write 'balanced' to energy_performance_preference. I read
> it back, and it contains 'balanced', so I am happy, I trust the kernel
> changed EPP to "balanced".
>
> If the kernel, in fact, uses something else, I want to know about it
> and have my script fail.

Why do you want it to fail then?

> Why caching the value and making my script _think_ it succeeded is a good idea.

Because when you change the scaling algorithm or the driver's
operation mode, the value you have written will take effect.

In this particular case it is explained in the driver documentation
that the performance scaling algorithm in the active mode overrides
the sysfs value and that's the only case when it can be overridden.
So whatever you write to this attribute will not take effect
immediately anyway, but it may take an effect later.

> In other words, in my usage scenarios at list, I prefer kernel telling
> the true EPP value, not some "cached, but not used" value.

An alternative is to fail writes to energy_performance_preference if
the driver works in the active mode and the scaling algorithm for the
scaling CPU is performance and *then* to make reads from it return the
value in the register.

Accepting a write and returning a different value in a subsequent read
is confusing.

Thanks!
