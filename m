Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C51519BED2
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 11:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbgDBJpE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 05:45:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44750 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBJpE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 05:45:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id a49so2723537otc.11
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 02:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QsAWgv2Ltj0RJCtE6KJA+MjYMln5Gouk6TC2Ox8jgH4=;
        b=A5B8otgffhWEKaC7+bvUpXuzsPZom3TlCRbIIs2AK9SlRKyJ5fiuoMVBaTuwgem3tn
         UWck9+AKyPah78YXIl6+bvf7BtogQcqoh+h/5O8mhjxmYo5FVhw6PhxQjyaPfIM2QirT
         asrFKYcFRBUa5s3chAvC08FZ/4sPuW/Cp0euF9QOpCrm70hUlZzf/WnPvMnK1AcR2Jk/
         GzlNaxBbFIuZKSpOYyREYtD3EVcQX+Py1X97HNLds9SPdQr1dhQyLFBDIybrHeIaZcQs
         DWo7mmO7TtwJyk7SkO2T2lrqYGN3Of73s9BC5ayvEtNtMMBQJjZcVXKp0JLkkMZK7DWU
         Z+9A==
X-Gm-Message-State: AGi0PuaYiEw1JVdj1xnHNI8SFqO3ZZpWzvsYYvaLOVSf3hiHb0O2kx/L
        j20QERsS8YyMIqKILdWmx1aI45DJnBSfy8rY+ps=
X-Google-Smtp-Source: APiQypL3aEbK3qOHNFc8UUfG1eVBIVhIQbKqstnxpQiJYGdX95SEeZH23cRMjtqmXh9u9LqdYz8tHj6ZjdF2jD/UzHQ=
X-Received: by 2002:a4a:e08b:: with SMTP id w11mr2039415oos.62.1585820703485;
 Thu, 02 Apr 2020 02:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200402080239.7471-1-linus.walleij@linaro.org> <20200402091446.GA19366@bogus>
In-Reply-To: <20200402091446.GA19366@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Apr 2020 11:44:51 +0200
Message-ID: <CAJZ5v0hm0Ubj4OXqu497njn-AaD0HAEDXaFQzjrQg1pfD35VLA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Select schedutil when using big.LITTLE
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 2, 2020 at 11:15 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Apr 02, 2020 at 10:02:39AM +0200, Linus Walleij wrote:
> > When we are using a system with big.LITTLE HMP
> > configuration, we need to use EAS to schedule the
> > system.
> >
> > As can be seen from kernel/sched/topology.c:
> >
> >  "EAS can be used on a root domain if it meets all the following conditions:
> >   1. an Energy Model (EM) is available;
> >   2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
> >   3. no SMT is detected.
> >   4. the EM complexity is low enough to keep scheduling overheads low;
> >   5. schedutil is driving the frequency of all CPUs of the rd;"
> >
> > This means that at the very least, schedutil needs to be
> > available as a scheduling policy for EAS to work on these
> > systems. Make this explicit by defaulting to the schedutil
> > governor if BIG_LITTLE is selected.
> >
> > Currently users of the TC2 board (like me) has to figure these
> > dependencies out themselves and it is not helpful.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
>
> Good to see another user of TC2 ;)
>
> FWIW:
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

This slightly clashes with
https://patchwork.kernel.org/patch/11463531/, so I'm going to queue up
them both.

Thanks!
