Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5E2040D0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 22:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgFVUCP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgFVUCO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 16:02:14 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A44C061799;
        Mon, 22 Jun 2020 12:45:48 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id g5so14134167otg.6;
        Mon, 22 Jun 2020 12:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFdwqUBGOKpOca1lCZxVxlB36FkBn0nL9aGlhv7LobQ=;
        b=mrE8dhiZyWSJCooMpy21gElfdlMaAnNp9S4hl13ZtuiGMzf/ygBGunFbF5dmV5mM/p
         QEdNGQRCRelWjMeSbRkrB4Ee6T1l+Mn3IQ5BUOYLLwJrrOhvNctfo9SBqIP1g9JZRJ1j
         W3zZ0LZyjLHsJRiW39Nfr3s0zrPOhvq3fbaCj/gvTwEeWuvy3sd6Orbmw7/JyuB+Bvvb
         +pRSPATYij9WIgepBHhadboL9Hdq4LJNn589ASrqxthDNQsXR6ZdhbTmYajRu0hvu1BP
         XBURiO+zCKMPHVDvFxGW4KEtasblhBHwfAy5VwWVK/ryo9VP1d+PVTFFHHdaD3ab/5t+
         Ouuw==
X-Gm-Message-State: AOAM531gnZC40uY2G0YSCwLmpYu2aFkcbX7ALzSx85vORPkRfWkz9c/F
        7zCEVNRVBm1m9OFLDEBmzDhOZwM79yj0BvAZPy4=
X-Google-Smtp-Source: ABdhPJzFBhhKiuOVJLgp/6u2eHYaM+BdlaOVk5hNruUWVQp/mkDCmKEpqA1WyHR1hMiGQclups9bzxfH49OF60PMmK8=
X-Received: by 2002:a4a:6513:: with SMTP id y19mr15673738ooc.75.1592855147614;
 Mon, 22 Jun 2020 12:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200616040442.21515-1-yu.c.chen@intel.com> <CAJZ5v0gBVBAjdCOXsM-Fa-iAkuv2JMi2mVkG5w7ADcg9dWencA@mail.gmail.com>
 <20200622171759.GA26527@chenyu-office.sh.intel.com>
In-Reply-To: <20200622171759.GA26527@chenyu-office.sh.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Jun 2020 21:45:35 +0200
Message-ID: <CAJZ5v0grJZyOX7fFx_nNjtOLT1NGyu1L10H3TY+e0HR3+T8JZA@mail.gmail.com>
Subject: Re: [PATCH][v2] PM / s2idle: Clear _TIF_POLLING_NRFLAG before suspend
 to idle
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 22, 2020 at 7:16 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Hi Rafael,
> On Mon, Jun 22, 2020 at 06:19:35PM +0200, Rafael J. Wysocki wrote:
> [cut]
> > > +{
> > > +       if (!current_clr_polling_and_test())
> > > +               s2idle_enter(drv, dev, index);
> > > +
> > > +       return index;
> >
> > Is the value returned here used at all?
> >
> It is not used for now IMO.
> > >          */
> > >         index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> > >         if (index > 0)
> > > -               enter_s2idle_proper(drv, dev, index);
> > > +               call_s2idle(drv, dev, index);
> >
> > I'm wondering why this can't be
> >
> >     if (index > 0 && !current_clr_polling_and_test())
> >             enter_s2idle_proper(drv, dev, index);
> >
> Yes, it should be simpler, but I guess Peter was trying to
> make call_s2idle() consistent with call_cpuidle(),
> and also s2idle_enter() is analogous to cpuidle_enter().

So IMO it would be better to do the simplest fix first and then do the
cleanup on top of it.

Thanks!
