Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6ED2251AA
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jul 2020 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgGSLnM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Jul 2020 07:43:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40152 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSLnL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jul 2020 07:43:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id c25so10125347otf.7;
        Sun, 19 Jul 2020 04:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjnIe1TJ50gLn+p9kXcfYDqIZQuO/sCSJOJdD/xzjx0=;
        b=X6psrmqSkI7JFgKASbjz/rFUxtXiLUPBeOxXS9ZgO736vtLJJrNKGc5m638ITzi7Da
         58zxYFcPEdGbtilVWS8Ks4TuB0+WbU8yvTdReNAlWZzgiYJxyyEiDevFaOCBeptYEJq5
         ukwYDCbFVqMP/jMgcP1UXebs8nHa2xK74FW5FFwgcGedW32FG734dfcCgf1H2F6w/ABO
         k55aDjFmQdcunRiRguPH5BYCthZYTSpKNVRXEMXXkbQCPQk5A3vgg2QtjJNgsGQUKiz1
         uT4x8v5rbN4gJmeXof4tjHLyqzuJ82VVCQCQkF4jpswYFoM0C+MWpQTlELQTqgD5HeE6
         SzSw==
X-Gm-Message-State: AOAM531fOjF/fYcSU/T7eXVqpCfgky+vNNl9OfdyF5FHlr6JNkpANS+Z
        J2zgRTfAXpt/Wg2ilH7O1FjTJSJJL7yez7oImDU=
X-Google-Smtp-Source: ABdhPJxrVwgTX8eq+bgwXf+Nz2z5hRxNnikw7DU/gnXd1DP0all26S5yyODzsfs23Hf3e46sRHhV1LyHhMsG15j5jYo=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr15288802ots.118.1595158990718;
 Sun, 19 Jul 2020 04:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <3955470.QvD6XneCf3@kreacher> <000f01d65ae8$0c607990$25216cb0$@net>
 <CAJZ5v0jGbfqfqqoPLjneFD5HLb20Yv9p25juNTzaumL70iFogg@mail.gmail.com> <001201d65c3f$6e2371c0$4a6a5540$@net>
In-Reply-To: <001201d65c3f$6e2371c0$4a6a5540$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 19 Jul 2020 13:42:59 +0200
Message-ID: <CAJZ5v0j+gziYE0t+d2bBMZ3+4Daa0L_OiX+CeTtNU8Mkv0bCBA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Francisco Jerez <francisco.jerez.plata@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,

On Fri, Jul 17, 2020 at 3:37 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> Thank you for your reply.
>
> On 2020.07.16 05:08 Rafael J. Wysocki wrote:
> > On Wed, Jul 15, 2020 at 10:39 PM Doug Smythies <dsmythies@telus.net> wrote:
> >> On 2020.07.14 11:16 Rafael J. Wysocki wrote:
> >> >
> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ...
> >> > Since the passive mode hasn't worked with HWP at all, and it is not going to
> >> > the default for HWP systems anyway, I don't see any drawbacks related to making
> >> > this change, so I would consider this as 5.9 material unless there are any
> >> > serious objections.
> >>
> >> Good point.
>
> Actually, for those users that default to passive mode upon boot,
> this would mean they would find themselves using this.
> Also, it isn't obvious, from the typical "what driver and what governor"
> inquiry.

So the change in behavior is that after this patch
intel_pstate=passive doesn't imply no_hwp any more.

That's a very minor difference though and I'm not aware of any adverse
effects it can cause on HWP systems anyway.

The "what governor" is straightforward in the passive mode: that's
whatever cpufreq governor has been selected.

The driver is "intel_cpufreq" which means that the processor is
requested to run at a frequency selected by the governor or higher,
unless in the turbo range.  This works similarly in both the HWP and
non-HWP cases, except that in the HWP case it is possible to adjust
the EPP (through the additional sysfs knob) and the base frequency is
exported (the latter two things can be used to distinguish between the
two cases just fine IMO).

> >> Some of the tests I do involve labour intensive post processing of data.
> >> I want to automate some of that work, and it will take time.
> >> We might be into the 5.9-rc series before I have detailed feedback.
> >>
> >> However, so far:
> >>
> >> Inverse impulse response test [1]:
> >>
> >> High level test, i5-9600K, HWP-passive (this patch), ondemand:
> >> 3101 tests. 0 failures. (GOOD)
> >>
> >> From [1], re-stated:
> >> > . High level: i5-9600K: 2453 tests, 60 failures, 2.45% fail rate. (HWP-active - powersave)
> >> > . Verify acpi-cpufreq/ondemand works fine: i5-9600K: 8975 tests. 0 failures.
> >>
> >> My version of that cool Alexander named pipe test [2] serialized workflow:
> >>
> >> HWP-passive (this patch), performance: PASS.
> >>
> >> From [2], re-stated, and also re-tested.
> >> HWP-disabled passive - performance: FAIL.
> >
> > But I'm not quite sure how this is related to this patch?
>
> It isn't. The point being that it is different.

It is different, but kind of in a positive way IMO.

> But yes, that failure is because of our other discussion [3].

OK

> >
> > This test would still fail without the patch if the kernel was started
> > with intel_pstate=passive in the kernel command line, wouldn't it.
>
> Yes.

OK

Thanks!
