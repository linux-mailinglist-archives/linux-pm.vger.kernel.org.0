Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B476590132
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 14:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfHPMRf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 08:17:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36584 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfHPMRf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 08:17:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id k18so9460219otr.3;
        Fri, 16 Aug 2019 05:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+E0MTqNRBEe9xkatPaAb5b/atYG4V6Eq0t4fHhQ7l4=;
        b=dDQgkJ3q2WSLbfBMIj1lyRVP/chzsLN2s4Kskym3ZXmVihRqJtsSNPfWrRxNmOITLm
         wqGUjOx3gt/LonlJByap5JWV1kHyEzoTmKK6ZVH8smY5rg/g0m2fe59oNtGshmcdTzcB
         XWXKWNKeeb+5zMkTBWs8YCZdUMr02xgjWoG162Sk7vXnnY0258oN9p19YTfGfWVlEn2Q
         DiS1+4YoquCWzFehjfgGdmnPkGQFAITxLCEHn07EDNAqXeEjdpnwD1n1vNy5DB6IqpIQ
         cXUp2J46NBdVRC7hMozcjilADGFV9xP4QGgo8RU+HggeYUhXK0O5UdntJvJR30eRss/6
         Q28A==
X-Gm-Message-State: APjAAAU6HZQ+Hoo//yFqQyYlGAhgUMElee5e1Oy3U+aB2Yafe29DdN3p
        aRICfd3qg+jvB0sgAVOHC0rR6oWjeU54JYuMp1Q=
X-Google-Smtp-Source: APXvYqym7NDB50zYH7Yf+KESWoi1XYETeRiF8Jl2l+B2HiC/WoKKQwMz5cIVLInotMH/464Z+6+J5+xRniM1FVCYjSY=
X-Received: by 2002:a9d:674c:: with SMTP id w12mr4137556otm.118.1565957854693;
 Fri, 16 Aug 2019 05:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <1565731976.8572.16.camel@lca.pw> <5d53b238.1c69fb81.d3cd3.cd53@mx.google.com>
 <20190814084014.GB52127@atomide.com> <CANA+-vDeSAYUNfTQzQPT2N_CUgvYr6i_LP_BdHT_zX+FPt8NHg@mail.gmail.com>
In-Reply-To: <CANA+-vDeSAYUNfTQzQPT2N_CUgvYr6i_LP_BdHT_zX+FPt8NHg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Aug 2019 14:17:23 +0200
Message-ID: <CAJZ5v0hY8=0j=heXuAS-5cBafDSE8ZakLDW4NGCjAbxUAt3j4Q@mail.gmail.com>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot warnings
To:     Tri Vo <trong@android.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <swboyd@chromium.org>, Qian Cai <cai@lca.pw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 14, 2019 at 8:37 PM Tri Vo <trong@android.com> wrote:
>
> On Wed, Aug 14, 2019 at 1:40 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Stephen Boyd <swboyd@chromium.org> [691231 23:00]:
> > > I also notice that device_set_wakeup_capable() has a check to see if the
> > > device is registered yet and it skips creating sysfs entries for the
> > > device if it isn't created in sysfs yet. Why? Just so it can be called
> > > before the device is created? I guess the same logic is handled by
> > > dpm_sysfs_add() if the device is registered after calling
> > > device_set_wakeup_*().
> >
> > Hmm just guessing.. It's maybe because drivers can enable and disable
> > the wakeup capability at any point for example like driver/net drivers
> > do based on WOL etc?
> >
> > > There's two approaches I see:
> > >
> > >       1) Do a similar check for device_set_wakeup_enable() and skip
> > >       adding the wakeup class until dpm_sysfs_add().
> > >
> > >       2) Find each case where this happens and only call wakeup APIs
> > >       on the device after the device is added.
> > >
> > > I guess it's better to let devices have wakeup modified on them before
> > > they're registered with the device core?
> >
> > I think we should at least initially handle case #1 above as multiple
> > places otherwise seem to break. Then maybe we could add a warning to
> > help fix all the #2 cases if needed?
>
> Makes sense. For case#1, we could also just register the wakeup source
> without specifying the parent device if the latter hasn't been
> registered yet. Userspace won't be able to associate a wakeup source
> to the parent device. But I think it's a reasonable fix, assuming we
> want to fix devices not being added before calling wakeup APIs #2.

Well, OK

I'm going to drop the entire series from linux-next at this point and
let's start over.

Also note that all of this is not an issue until we start to add
children under the device passed to device_set_wakeup_enable() and
friends so maybe that is not a good idea after all?
