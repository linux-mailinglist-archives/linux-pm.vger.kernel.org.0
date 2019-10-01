Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02039C3036
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfJAJbp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 05:31:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45417 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJAJbp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 05:31:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so10911225oti.12;
        Tue, 01 Oct 2019 02:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTJZse+SbdPMDD1qqqBwjeMw24Hq9Hp0zN9VfWRxdY8=;
        b=ubgzn34KvhKY2ebsttIiG3RQjj1eFRueVwXkToI9F/8lti/4KIatGOfLFYdQ41FBwA
         hUcjpFKip39lUyfMUb0yLPKUtPi82NNnakzD2+Kh18yGM/RHOQwOvyBlDn6HaYfppC6E
         gA3kcqttb1Z5N4YTRQRXiBrQsHaChtg540nHaLRZz2BuWZvrkg9Dtea7x20oocNnt7Kx
         X8siT0m1J+z0DBXLleuQjgyJjaKeIoYe5srRZSHgpY7P0amH8ld41bebFAVWpbWcc7za
         WEBqNg6x8qSnR07x17QOxAXXiPCX6HfqseFT8utINoof4L/hPZL0KaHAjzKIKkTXi7zs
         /tIA==
X-Gm-Message-State: APjAAAUhclVYldT4OZcMxpHlpj3VYJDIPHf493UohHVOU1YMgMZF+QQ2
        NNhST9s3xE1i2ss7/w0N3g0/q6AdN9opGKjxI54=
X-Google-Smtp-Source: APXvYqxgy6O5gLjryUiztR7kAgkA0bgy3TFCjqSQaRnqWj5Ee7E3NcWx+6DlXs2JYQI3woIAZuai6vgI4CIUbeEtT44=
X-Received: by 2002:a9d:6301:: with SMTP id q1mr1125046otk.262.1569922304073;
 Tue, 01 Oct 2019 02:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <001601d57487$e1029ef0$a307dcd0$@net> <000f01d576df$a6b87a30$f4296e90$@net>
In-Reply-To: <000f01d576df$a6b87a30$f4296e90$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Oct 2019 11:31:32 +0200
Message-ID: <CAJZ5v0gu=rALS9ZLNMDT3cw_sT2m8XCKP6+AW3488x2Q9EXM3g@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor
 for tickless systems
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Chen, Hu" <hu1.chen@intel.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 29, 2019 at 6:05 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.09.26 09:32 Doug Smythies wrote:
>
> > If the deepest idle state is disabled, the system
> > can become somewhat unstable, with anywhere between no problem
> > at all, to the occasional temporary jump using a lot more
> > power for a few seconds, to a permanent jump using a lot more
> > power continuously. I have been unable to isolate the exact
> > test load conditions under which this will occur. However,
> > temporarily disabling and then enabling other idle states
> > seems to make for a somewhat repeatable test. It is important
> > to note that the issue occurs with only ever disabling the deepest
> > idle state, just not reliably.
> >
> > I want to know how you want to proceed before I do a bunch of
> > regression testing.
>
> I did some regression testing anyhow, more to create and debug
> a methodology than anything else.
>
> > On 2018.12.11 03:50 Rafael J. Wysocki wrote:
> >
> >> v7 -> v8:
> >>  * Apply the selection rules to the idle deepest state as well as to
> >>    the shallower ones (the deepest idle state was treated differently
> >>    before by mistake).
> >>  * Subtract 1/2 of the exit latency from the measured idle duration
> >>    in teo_update() (instead of subtracting the entire exit latency).
> >>    This makes the idle state selection be slightly more performance-
> >>   oriented.
> >
> > I have isolated the issue to a subset of the v7 to v8 changes, however
> > it was not the exit latency changes.
> >
> > The partial revert to V7 changes I made were (on top of 5.3):
>
> The further testing showed a problem or two with my partial teo-v7 reversion
> (I call it teo-v12) under slightly different testing conditions.
>
> I also have a 5.3 based kernel with the current teo reverted and the entire
> teo-v7 put in its place. I have yet to find a idle state disabled related issue
> with this kernel.
>
> I'll come back to this thread at a later date with better details and test results.

Thanks for this work!

Please also note that there is a teo patch in 5.4-rc1 that may make a
difference in principle.
