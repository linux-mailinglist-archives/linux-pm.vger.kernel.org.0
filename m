Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD31A251BFB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 17:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHYPPD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 11:15:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36044 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYPOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 11:14:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id x24so10655482otp.3;
        Tue, 25 Aug 2020 08:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SuxOmAQqZZFaDvKNEg/FnVPjE4bxt3cvqZyJwNFitw=;
        b=U5QfGkHm4UygzPoNmhFGBlXRf9C24r7otGtxmHg/Y3aoPqtdGS6qpdWaDVz2heWDpz
         8MjjKvIj3ODMrU6JCk1lD6QsXowDu6d1rlsQsxytGXebH0cZNbgq0YQs3XOx7l2PSmSs
         1Yd6UT8DqLvHpkEpGtn5IpBmw/l2jcw3nTzFslBdPvvaMYFkzsnF2GuoPARkFCqQI2PE
         EjUevCC3cCmxyOvfRGcZ9vmvSn4R+mPFl/c9NeXqN7YSnR4B1bBLITQZaLe3zuqqoc10
         D2S+Efzy1seljYwruwTLfuvsqf9XPHlRYaG0XMVjgJaL0EOPDaOsX77TLWmbA8+AcDuh
         0zyg==
X-Gm-Message-State: AOAM5319q6ZYL7buiUmcVvZ5+EbPIrj78yMdmZ6O3A1hI3Q4HN8Cldy2
        zMh8kLdXhdpdwzwwfDzmQPC239h7kuEuufqaef3krSES
X-Google-Smtp-Source: ABdhPJwUfmlKxhswVBxCwo67zMwlc6fUHpc4thJYu0l2U5cAZJk40Ip4v9q2g8F8U5V+K3WAMfKhqwjQV+f1mp7KHR0=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr7145886otk.262.1598368490533;
 Tue, 25 Aug 2020 08:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <4169555.5IIHXK4Dsd@kreacher> <2064342.aRc67yb0pC@kreacher>
 <61ea43fce7dd8700d94f12236a86ffec6f76a898.camel@gmail.com>
 <CAJZ5v0hkmcAuCsnfjCSWTarr4pkQry2VCtk2aWM74fOW2guzmg@mail.gmail.com> <1341038e00d965e913ee9f0c7a1e739eadef42f7.camel@linux.intel.com>
In-Reply-To: <1341038e00d965e913ee9f0c7a1e739eadef42f7.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Aug 2020 17:14:39 +0200
Message-ID: <CAJZ5v0gf9WCwm8Bdzo02Jfbz5vgdH8c_T9y89SaVvTNXH7p4hA@mail.gmail.com>
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

On Tue, Aug 25, 2020 at 5:06 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2020-08-25 at 16:51 +0200, Rafael J. Wysocki wrote:
> > On Tue, Aug 25, 2020 at 8:20 AM Artem Bityutskiy <dedekind1@gmail.com
> > > wrote:
> > > On Mon, 2020-08-24 at 19:42 +0200, Rafael J. Wysocki wrote:
> > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > >
> > > > Make the energy_performance_preference policy attribute in sysfs
> > > > always return the last EPP value written to it instead of the one
> > > > currently in the HWP Request MSR to avoid possible confusion when
> > > > the performance scaling algorithm is used in the active mode with
> > > > HWP enabled (in which case the EPP is forced to 0 regardless of
> > > > what value it has been set to via sysfs).
> > >
> > > Why is this a good idea, I wonder. If there was a prior discussion,
> > > please, point to it.
> > >
> > > The general approach to changing settings via sysfs is often like
> > > this:
> > >
> > > 1. Write new value.
> > > 2. Read it back and verify that it is the same. Because there is no
> > > better way to verify that the kernel "accepted" the value.
> >
> > If the write is successful (ie. no errors returned and the value
> > returned is equal to the number of written characters), the kernel
> > *has* accepted the written value, but it may not have taken effect.
> > These are two different things.
> >
> > The written value may take an effect immediately or it may take an
> > effect later, depending on the current configuration etc.  If you
> > don't see the effect of it immediately, it doesn't matter that there
> > was a failure of some sort.
> >
> > > Let's say I write 'balanced' to energy_performance_preference. I
> > > read
> > > it back, and it contains 'balanced', so I am happy, I trust the
> > > kernel
> > > changed EPP to "balanced".
> > >
> > > If the kernel, in fact, uses something else, I want to know about
> > > it
> > > and have my script fail.
> >
> > Why do you want it to fail then?
> >
> > > Why caching the value and making my script _think_ it succeeded is
> > > a good idea.
> >
> > Because when you change the scaling algorithm or the driver's
> > operation mode, the value you have written will take effect.
> >
> > In this particular case it is explained in the driver documentation
> > that the performance scaling algorithm in the active mode overrides
> > the sysfs value and that's the only case when it can be overridden.
> > So whatever you write to this attribute will not take effect
> > immediately anyway, but it may take an effect later.
>
> In some cases without even changing active/passive this is happening
> when there was some error previously. For example:
>
> #cat energy_performance_preference
> 127
> [root@otcpl-perf-test-skx-i9 cpufreq]# rdmsr -p 1 0x774
> 8000ff00
>
> I think we should show reality. In mode change can be a special case
> and use the stored value to restore in new mode.

OK, so I'll make it fail on attempts to change the EPP from 0
(performance) in the active mode with the performance "governor".

Cheers!
