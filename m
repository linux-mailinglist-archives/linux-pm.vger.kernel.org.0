Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B308010011A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 10:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKRJWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 04:22:17 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39829 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRJWR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 04:22:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id v138so14666050oif.6;
        Mon, 18 Nov 2019 01:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vN0gbv6vMevkHM5ujao5cMfwNZPe4ICulhsutFl+h+s=;
        b=uK67ZnoQIB5oF4aBmoDBRoo4U93stEHOE929uZVKdDQ0avOC9cW7bFhGbtwAk4rwuE
         pFIXLI2Ty57D3mZeYhxbzBi/4l2IZCudPPMvjvZzj/E4kBNjsIU7z6/REBuSMTHWbUdZ
         VpqElpuhUjc8+ru+U8uLlEBWbnLUPCZB+thVOBV8s93eRZyXUFYFY6UBKlsnvhQU0gqv
         uPkrXCdOcqDHRXYqtcW0rWlgsn78qKL5TeRXAecYZAPE+9EzgM0w+i9M6SO7ad8MR/Dr
         2bveCLyBe0cPxKfvs5WYHrSX/DwpqTxtm2bOQSr6OkFeLcaO7QpD+HmpKvMm3B3DqCYU
         DjSA==
X-Gm-Message-State: APjAAAVBsLsU/0qrYW3Ps7JWxRntVWRVxMryJ+xqN/JP0jvQFpHwNWtr
        0I28FP5a6lxT6Y9/HeFfEpQC/FIZnfDOSz8wT7g=
X-Google-Smtp-Source: APXvYqzVGw6LcmsntT7RikJ3h0TXYgHRO6zqFsV9A+cQJGlF79UeisbnyqCJEVHwmExdzjAxV/3jKUcRo15Sdmf7bQI=
X-Received: by 2002:aca:1101:: with SMTP id 1mr20107108oir.103.1574068936447;
 Mon, 18 Nov 2019 01:22:16 -0800 (PST)
MIME-Version: 1.0
References: <2717750.dCEzHT3DVQ@kreacher> <CAJvTdKn9wuoXkKecZxCJHPZAG7XK_BqAZT5=7k9Mi4zo4SBL0g@mail.gmail.com>
In-Reply-To: <CAJvTdKn9wuoXkKecZxCJHPZAG7XK_BqAZT5=7k9Mi4zo4SBL0g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Nov 2019 10:22:05 +0100
Message-ID: <CAJZ5v0ifOQaOm-8n5gUgud0sCn-Y1KQWWhzhtzdm+exvMLgL7Q@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Consolidate disabled state checks
To:     Len Brown <lenb@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Mon, Nov 18, 2019 at 5:46 AM Len Brown <lenb@kernel.org> wrote:
>
> On Mon, Nov 4, 2019 at 6:16 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There are two reasons why CPU idle states may be disabled: either
> > because the driver has disabled them or because they have been
> > disabled by user space via sysfs.
> >
> > In the former case, the state's "disabled" flag is set once during
> > the initialization of the driver and it is never cleared later (it
> > is read-only effectively).
>
> for x86 (intel_idle and acpi_idle), no states with disabled=1 are  registered
> with cpuidle.  Instead, intel_idle (currently) skips them in the loop
> that registers states.
> (and acpi_idle never touches the disabled field)
>
> And so for x86, governors checking for drv->states[i].disabled is a NOP,
> and the condition described by CPUIDLE_STATE_DISABLED_BY_DRIVER
> does not (yet) exist.

OK

> Looking at the ARM code, it seems that cpuidle-imx6q.c and cpuidle-tegra20.c
> reach into the cpuidle states at run time and toggle the
> drv->states[i].disabled.

I might have overlooked that, let me check.

> It seems that this patch takes the initial value of
> drv->states->disabled, and sets the (per cpu)
> usage.disable=..BY_DRIVER,
> but that subsequent run-time toggles in drv->states[i]disabled by
> these drivers would be missed,
> because you're removed the run-time checking of drv->states->disabled?

If it is updated at run time, then yes, the updates will be missed, so
thanks for pointing that out.

> Finally, I'd like to change intel_idle so that it *can* register a
> state that is disabled, by default.
> If I change the driver to NOT skip registering disabled states, and
> the cpuidle copy has cpuidle_state.disabled=1,
> then the state is indeed, unused at run-time.  But as you said,
> it is effectively read-only, and is not indicated in sysfs, and can
> not be changed via sysfs.
>
> One way to do this is to do what you do here and initialize
> usage.disabled to drv->state.disabled. (not distinguishing between
> DRIVER and USER)
> That way the user could later over-ride what a driver set, by clearing
> the disabled attribute.
>
> However, the ARM drivers, at least, seem to want to reserve the right
> to set and clear the drv->state.disabled,
> and to have them continue to have that right, we have to continue
> checking that field at run-time.

Alternatively, the drivers in question can be changed to update the
disable field in state_usage instead (maybe under a lock to prevent
them from racing with user space).

> And giving drivers the opportunity to do that disabling driver-wide,
> instead of per-cpu (usage) wide,
> seems to be something we may want to keep.

So it looks like you want me to revert this patch which is something
that I really don't want to do, because of the extra checks all over
the place which are simply pointless in the majority of cases.

Cheers,
Rafael
