Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02182F8239
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKKV3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:29:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46985 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfKKV3U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:29:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id n23so12469530otr.13;
        Mon, 11 Nov 2019 13:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0EaaQakc/Olt1+inLfsxuVhU6rWXEXlsy8c5lcy0DyE=;
        b=EY8xtl227uo8kNI6SRAs/fKXX6zV4w8eokSbQtFhTMHQ+Ft5DjcRES+dwSRB4kBYP2
         VYL1QpVxCXjKrjfaW1quhar7B1+oohZBeNolNLG5JizOlwcRVfLiWYaUwdkonKWIF+RY
         xb0Q14jHmRJ4j3288BRZEWdfO+xJlqXC8WoYvPpX+5hCa5a2stbSjdj0gUPYXQNPEEdc
         tpLGShN17Fk2wFDUDJW3tp40wmsQ2pcmIj3NBO43YzFsOSNuUogPoolAobATTOfSQQME
         I/w948Y+iQ/IeNeOAHWrPsKpvSP9XTAx7gH/+cMv/6HucluMgObxCryfYLJ+/rTMzBlJ
         9hpw==
X-Gm-Message-State: APjAAAUGh8J08O/kE5CpLVGnZO2St/BlkXkUaSWBaZy08DrH3DDhTwBu
        /inSbFcyD+ymKFzZntvb9dmfy4bW7HRNWcX8cbQ=
X-Google-Smtp-Source: APXvYqyn3HyV29I3Exmg96+ZNvBAEDMds2v9BIW3fBJWmGtjU2xIWKaEiub/FOFmNk8ZD2+N7/GBfNsXpdv1kiMswvQ=
X-Received: by 2002:a05:6830:232a:: with SMTP id q10mr22974750otg.262.1573507759372;
 Mon, 11 Nov 2019 13:29:19 -0800 (PST)
MIME-Version: 1.0
References: <10494959.bKODIZ00nm@kreacher> <000a01d59656$99798710$cc6c9530$@net>
 <CAJZ5v0gZDJ2=PiiGw2mcCcVKBM2OyM1G9nRvJ+iWLFUQcXqZuw@mail.gmail.com>
 <6163696.37NBKbymtj@kreacher> <000b01d597f2$06403a50$12c0aef0$@net> <002301d59813$ee18c920$ca4a5b60$@net>
In-Reply-To: <002301d59813$ee18c920$ca4a5b60$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Nov 2019 22:29:08 +0100
Message-ID: <CAJZ5v0hFjNHgNz-MfbLhXkxPvcJzEmBBvGF7mi8v52jV3CPy2Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Use nanoseconds as the unit of time
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 10, 2019 at 11:12 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.11.10 10:10 Doug Smythies wrote:
> > On 2019.11.10 09:24 Rafael J. Wysocki wrote:
> >> On Sunday, November 10, 2019 5:48:21 PM CET Rafael J. Wysocki wrote:
> >>
> >> I have found a bug, which should be addressed by the patch below.
> >>
> >> If it still doesn't reduce the discrepancy, we'll need to look further.
> >>
> >> ---
> >> drivers/cpuidle/governors/menu.c |    4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> Index: linux-pm/drivers/cpuidle/governors/menu.c
> >> ===================================================================
> >> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> >> +++ linux-pm/drivers/cpuidle/governors/menu.c
> >> @@ -516,8 +516,8 @@ static void menu_update(struct cpuidle_d
> >>      new_factor -= new_factor / DECAY;
> >>
> >>      if (data->next_timer_ns > 0 && measured_ns < MAX_INTERESTING)
> >> -            new_factor += RESOLUTION * div64_u64(measured_ns,
> >> -                                                 data->next_timer_ns);
> >> +            new_factor += div64_u64(RESOLUTION * measured_ns,
> >> +                                    data->next_timer_ns);
> >>      else
> >>              /*
> >>               * we were idle so long that we count it as a perfect
> >
> > Yes, that was the exact bit of code I focused on yesterday.
> > However, my attempt to fix was different, and made no difference,
> > with the new graph being exactly on top of the old bad one.
> > I had defined new_factor as u64 and RESOLUTION as ULL.
>
> Your patch does fix the problem.
> I now also understand why my attempt did not.
>
> New data added to previous graphs. For those that don't
> want to go to the graphs, the nanosecond menu graphs are now
> almost identical to the microsecond based one.
>
> http://www.smythies.com/~doug/linux/idle/nano-second-conversion/sweep/index.html
>
> Legend:
> teo-base : linux-next 2019.11.07
> menu-base: linux-next 2019.11.07
> teo-v2   : linux-next 2019.11.07 + cpuidle: Consolidate disabled state checks + this v2
> menu-v2  : linux-next 2019.11.07 + cpuidle: Consolidate disabled state checks + this v2
> rjw1     : menu-v2 + above patch.
>
> Acked-by and tested-by Doug Smythies <dsmythies@telus.net>

Thanks a lot!

> Disclaimer: Only teo and menu, not ladder or haltpoll governors.
>
> Additional suggestions:
>
> Header comments:
>
> > microseconds provided by drivers.  In addition to that, change
> > cpuidle_governor_latency_req() to return the idle state exit
> > latency constraint in nanoseconds.
>
> Suggest:
>
> microseconds provided by drivers.  Additionally, change
> cpuidle_governor_latency_req() to return the idle state exit
> latency constraint in nanoseconds.
>
> > With that, meeasure idle state residency (last_residency_ns in
>              ^^^^^^^^
> Suggest:
>
> Also measure idle state residency (last_residency_ns in
>
> Code:
> Suggest deletion of this note:
>
> /*
>  * Please note when changing the tuning values:
>  * If (MAX_INTERESTING-1) * RESOLUTION > UINT_MAX, the result of
>  * a scaling operation multiplication may overflow on 32 bit platforms.
>  * In that case, #define RESOLUTION as ULL to get 64 bit result:
>  * #define RESOLUTION 1024ULL
>  *
>  * The default values do not overflow.
>  */
>
> Because you have managed the extra bit requirements as part of the patch.

Good suggestion! :-)

I have folded the fix and the removal of the comment as suggested
above into to v2 and applied the resulting patch with tags from you
and Peter.

Also the changelog has been updated as suggested.

Thanks!
