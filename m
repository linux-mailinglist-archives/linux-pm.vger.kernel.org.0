Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70410040E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 12:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfKRL1K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 06:27:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40500 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfKRL1K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 06:27:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id m15so14170314otq.7;
        Mon, 18 Nov 2019 03:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VGp3OpF5GA2F7BU2LE4TwYF6X0125T01Rr+E1EqppI=;
        b=jCMLZMfmYQkoKN3iFC/0AuUf28FH7MDLubE6jSmZTvABJSU6ZYjmQ32KzTMLwEL/BE
         v0pJd7qp2EpS84gG91LfN2xUw7n83VVDK8v8gKacvB4uCupsDGv3xLa0iXh2atKSCn2D
         ynj/bzN3qT3Y/+1cvsNSvogzpIowAY/Bmqv5PCNk1ZfHYs1h6KyL8eKM8lDsl7SAAAR9
         S98uJrIdufRAh8CxeBEAlPkavt8T8v9nMghFZBCTRQ+RkQsbANyP8bo0C3keGkVv0agB
         C2e5g8OXIuVFCk6wfa9rAGNBcGvUk0UUuLf5id0AVE/0OfMenq6WE1UhSSiir9MWfK7e
         H4ng==
X-Gm-Message-State: APjAAAXTEGxk0JBBEnl/mVbB/Kdu4nLAvMZCpjnSpaFkO7Td4ulNnpww
        UbVtUHtSZ0Jf9RefQ6idRM450nBISiIbtgD/t/A=
X-Google-Smtp-Source: APXvYqxy13t3uLGFNSvy3wvHL6OJCqB1p2rtgvpSnNHM+tvUbQdNmTfWxjSP1ZfXrk3AUSM30/lBEFwcSxpYvZPNb+4=
X-Received: by 2002:a05:6830:232a:: with SMTP id q10mr22460237otg.262.1574076428641;
 Mon, 18 Nov 2019 03:27:08 -0800 (PST)
MIME-Version: 1.0
References: <2717750.dCEzHT3DVQ@kreacher> <CAJvTdKn9wuoXkKecZxCJHPZAG7XK_BqAZT5=7k9Mi4zo4SBL0g@mail.gmail.com>
 <CAJZ5v0ifOQaOm-8n5gUgud0sCn-Y1KQWWhzhtzdm+exvMLgL7Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0ifOQaOm-8n5gUgud0sCn-Y1KQWWhzhtzdm+exvMLgL7Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Nov 2019 12:26:57 +0100
Message-ID: <CAJZ5v0jsQG37VF3-tiSndE0pXX9jEfgucm0UyvpM0bsyoOcpuA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Consolidate disabled state checks
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 18, 2019 at 10:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Nov 18, 2019 at 5:46 AM Len Brown <lenb@kernel.org> wrote:
> >
> > On Mon, Nov 4, 2019 at 6:16 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > There are two reasons why CPU idle states may be disabled: either
> > > because the driver has disabled them or because they have been
> > > disabled by user space via sysfs.
> > >
> > > In the former case, the state's "disabled" flag is set once during
> > > the initialization of the driver and it is never cleared later (it
> > > is read-only effectively).
> >
> > for x86 (intel_idle and acpi_idle), no states with disabled=1 are  registered
> > with cpuidle.  Instead, intel_idle (currently) skips them in the loop
> > that registers states.
> > (and acpi_idle never touches the disabled field)
> >
> > And so for x86, governors checking for drv->states[i].disabled is a NOP,
> > and the condition described by CPUIDLE_STATE_DISABLED_BY_DRIVER
> > does not (yet) exist.
>
> OK
>
> > Looking at the ARM code, it seems that cpuidle-imx6q.c and cpuidle-tegra20.c
> > reach into the cpuidle states at run time and toggle the
> > drv->states[i].disabled.
>
> I might have overlooked that, let me check.
>
> > It seems that this patch takes the initial value of
> > drv->states->disabled, and sets the (per cpu)
> > usage.disable=..BY_DRIVER,
> > but that subsequent run-time toggles in drv->states[i]disabled by
> > these drivers would be missed,
> > because you're removed the run-time checking of drv->states->disabled?
>
> If it is updated at run time, then yes, the updates will be missed, so
> thanks for pointing that out.
>
> > Finally, I'd like to change intel_idle so that it *can* register a
> > state that is disabled, by default.
> > If I change the driver to NOT skip registering disabled states, and
> > the cpuidle copy has cpuidle_state.disabled=1,
> > then the state is indeed, unused at run-time.  But as you said,
> > it is effectively read-only, and is not indicated in sysfs, and can
> > not be changed via sysfs.
> >
> > One way to do this is to do what you do here and initialize
> > usage.disabled to drv->state.disabled. (not distinguishing between
> > DRIVER and USER)
> > That way the user could later over-ride what a driver set, by clearing
> > the disabled attribute.

I'd rather get rid of the "disabled" field from struct cpuidle_state
entirely and introduce a new state flag to indicate the "disabled by
default" status.

I also would expose that new flag in a new sysfs attribute of idle
states, say "disable_default".

Then, the DISABLED_BY_DRIVER bit would be reserved for driver quirks
(as per https://patchwork.kernel.org/patch/11249519/) and the
DISABLED_BY_USER one could be used for all of the other purposes.

Cheers,
Rafael
