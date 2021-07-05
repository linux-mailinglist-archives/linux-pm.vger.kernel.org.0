Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60763BBD75
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 15:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhGEN1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jul 2021 09:27:36 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40538 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGEN1g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jul 2021 09:27:36 -0400
Received: by mail-ot1-f47.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so18292192otk.7;
        Mon, 05 Jul 2021 06:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBFZgrsOPrbsUN1uPwodsfr1xtraggXX60tVKBlbJAE=;
        b=ui6ffD0Aw8+5ke1KvHOZmydv/xAvupCwcfenFq7tjaZwA1WzTIBaMm0pvyNlSRWNi+
         2O717kFhp8jZSs7DZr8+4g6iDHKyf4ghB+i57JDYWgXkWAR5xSOcfP0WffMF+RPYXMn7
         +fAVu8dqnfUiR2TAClaNijmllRSX95+fH/bWWm1V+tApHmZmF42pQis/mcAc1ioIlIeJ
         /8T8mCLbVET6JXVuFA8LsNVEqMVbYrKjpN65/Mg3bAYlLWwKXqqFkXoVP6gyQ8G3qlRB
         ND53/af+w7mm6IDF+6QD0LIrIl7ftjhr4h6SHVhRUBgKjGes/foHgZfAVKmWvOO9ApHc
         RY7g==
X-Gm-Message-State: AOAM531Tx7yaoTDQKiHVzFHj1QMxK2YDO7oZoTCQSXYgDk8q79tpShRJ
        3rtf7jkC9K85Pteg5L9QRuVUQ4mrcolRVDPUcbQ=
X-Google-Smtp-Source: ABdhPJwNj0BbvjrdzGAJ0ts+MYxii4BhPeMSPLcInedbRaacxy889Ea/5IE4yjfljc9RQRrEmHU9dqUJ4e9Y66P1h4g=
X-Received: by 2002:a05:6830:1d8:: with SMTP id r24mr11413386ota.206.1625491498880;
 Mon, 05 Jul 2021 06:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <1867445.PYKUYFuaPT@kreacher> <007101d77117$b3b837a0$1b28a6e0$@telus.net>
In-Reply-To: <007101d77117$b3b837a0$1b28a6e0$@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jul 2021 15:24:43 +0200
Message-ID: <CAJZ5v0jH6pXs07r9xvUwUDWz7A8DbDO-2UfMUTmMygO1PJ76=Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] cpuidle: teo: Rework the idle state selection logic
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jul 4, 2021 at 11:01 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> On 2021.06.02 11:14 Rafael J. Wysocki wrote:
>
> > Hi All,
> >
> > This series of patches addresses some theoretical shortcoming in the
> > TEO (Timer Events Oriented) cpuidle governor by reworking its idle
> > state selection logic to some extent.
> >
> > Patches [1-2/5] are introductory cleanups and the substantial changes are
> > made in patches [3-4/5] (please refer to the changelogs of these two
> > patches for details).  The last patch only deals with documentation.
> >
> > Even though this work is mostly based on theoretical considerations, it
> > shows a measurable reduction of the number of cases in which the
> shallowest
> > idle state is selected while it would be more beneficial to select a
> deeper
> > one or the deepest idle state is selected while it would be more
> beneficial to
> > select a shallower one, which should be a noticeable improvement.
>
> Do you have any test results to share? Or test methods that I can try?
> I have done a few tests, and generally don't notice much difference.
> Perhaps an increase in idle state 2 below (was to shallow) numbers.
> I am searching for some results that would offset the below:
>
> The difficulty I am having with this patch set is the additional overhead
> which becomes significant at the extremes, where idle state 0 is dominant.
> Throughout the history of teo, I have used multiple one core pipe-tests
> for this particular test. Some results:
>
> CPU: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> HWP: disabled
> CPU frequency scaling driver: intel_pstate, active, powersave
> Pipe-tests are run forever, printing average loop time for the
> Last 2.5 million loops. 1021 of those are again averaged.
> Total = 2.5525e9 loops
> The power and idle data is sampled for 100 minutes.
>
> Note 1: other tests were also done and also with passive,
> schedutil, but it isn't relevant for this test because the
> CPU frequency stays pinned at maximum.
>
> Note 2: I use TCC offset for thermal throttling, but I disabled it
> for these tests, because the temperature needed to go higher
> than my normal throttling point.
>
> Idle configuration 1: As a COMETLAKE processor, with 4 idle states.
> Kernel 5.13-RC4.
>
> Before patch set average:
> 2.8014 uSec/loop
> 113.9 watts
> Idle state 0 residency: 9.450%
> Idle state 0 entries per minute: 256,812,896.6
>
> After patch set average:
> 2.8264 uSec/loop, 0.89% slower
> 114.0 watts
> Idle state 0 residency: 8.677%
> Idle state 0 entries per minute: 254,560,049.9
>
> Menu governor:
> 2.8051 uSec/loop, 0.13% slower
> 113.9 watts
> Idle state 0 residency: 8.437%
> Idle state 0 entries per minute: 256,436,417.2
>
> O.K., perhaps not so bad, but also not many idle states.
>
> Idle configuration 2: As a SKYLAKE processor, with 9 idle states.
> i.e.:
> /drivers/idle/intel_idle.c
> static const struct x86_cpu_id intel_idle_ids[] __initconst
> ...
>    X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, &idle_cpu_skx),
> + X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, &idle_cpu_skl),
>
> Purpose: To demonstrate increasing overhead as a function of number
> of idle states.
> Kernel 5.13.
>
> Before patch set average:
> 2.8394 uSec/loop
> 114.2 watts
> Idle state 0 residency: 7.212%
> Idle state 0 entries per minute: 253,391,954.3
>
> After patch set average:
> 2.9103 uSec/loop, 2.5% slower
> 114.4 watts, 0.18% more
> Idle state 0 residency: 6.152%, 14.7% less.
> Idle state 0 entries per minute: 244,024,752.1
>
> Menu governor:
> 2.8141 uSec/loop, 0.89% faster
> 113.9 watts,  0.26% less
> Idle state 0 residency: 7.167%, 0.6% less
> Idle state 0 entries per minute: 255,650,610.7
>
> Another potentially interesting test was the ebizzy test:
> Records per second, averaged over many tests, varying
> threads and intervals:
>
> passive, schedutil:
> Before: 6771.977
> After: 5502.643, -18.7%
> Menu: 10728.89, +58.4%
>
> Active, powersave:
> Before: 8361.82
> After: 8463.31, +1.2%
> Menu: 8225.58, -1.6%
>
> I think it has more to do with CPU scaling governors
> than this patch set, so:
>
> performance:
> Before: 12137.33
> After: 12083.26, -0.4%
> Menu: 11983.73, -1.3%
>
> These and other test results available here:
> (encoded to prevent a barrage of bots)
>
> double u double u double u dot smythies dot com
> /~doug/linux/idle/teo-2021-06/
>
> ... a day later ...
>
> I might have an answer to my own question.
> By switching to cross core pipe-tests, and only loading down one
> CPU per core, I was able to get a lot more activity in other idle states.
> The test runs for 100 minutes, and the results change with time, but
> I'll leave that investigation for another day (there is no throttling):
>
> 1st 50 tests:
> Before: 3.888 uSec/loop
> After: 3.764 uSec/loop
> Menu: 3.464 uSec/loop
>
> Tests 50 to 100:
> Before: 4.329 uSec/loop
> After: 3.919 uSec/loop
> Menu: 3.514 uSec/loop
>
> Tests 200 to 250:
> Before: 5.089 uSec/loop
> After: 4.364 uSec/loop
> Menu: 4.619 uSec/loop
>
> Tests 280 to 330:
> Before: 5.142 uSec/loop
> After: 4.464 uSec/loop
> Menu: 4.619 uSec/loop
>
> Notice that the "after" this patch set is applied eventually does
> better than using the menu governor. Its processor package power
> always remains less, than the menu governor.

That's good news, thanks!

> The results can be viewed graphically at the above link, but the
> most dramatic results are:
>
> Idle state 3 above % goes from 70% to 5%.
> Idle state 2 below % goes from 13% to less than 1%.

This also looks promising.

Thank you for all of the results!
