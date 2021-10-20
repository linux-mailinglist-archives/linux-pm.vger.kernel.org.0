Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE97C434CC5
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 15:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJTN4z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 09:56:55 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46672 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhJTN4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 09:56:54 -0400
Received: by mail-oi1-f180.google.com with SMTP id o204so9679336oih.13;
        Wed, 20 Oct 2021 06:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxJiAliR822Ap4nMWOC5hT1lje/81qui5YptLN3A2Fk=;
        b=OPex8Y6es7USqwyV50cYVrj2uk7jEzHN6PiNilkZE93rnoyUCKIIDjAyz+eicalE9K
         yTfVpXNdXsQ1AkmBZ9FPC9mWPh1Y6HJ2mGvnoEuVdbhOmp7XjUDut2+ZuXAv5rWP8+Mc
         Bq5YgFNnKs4YplmxLlzIQ84f51dEzRfAKir/80RWye/guiwGtePzd+VooTt1orn9nuN+
         ac2LPn+SKn4j5NmKNzA4X3Ofomcn35imYAlENANzaSxAwfsW3CK4Mmwz1LljKlJaAQJg
         4poeiQu6Vy4Kj8fSbc6ayov5Yn0TsWFkHdjshViYp9otseipOQZ+JmgOy8eFQcvapQiG
         98cg==
X-Gm-Message-State: AOAM5336BViIVUFZ2BY92/ihjWoLifrlYhJD9SBoDtNnj9rFvsHdQQMT
        Xe+HdFvBGFokmNSU8kDgjyHrlOaPB5nRmywfW8IAAUnXVD4=
X-Google-Smtp-Source: ABdhPJxKTHBXdWABwBe7wzwUKotTUsWe9KMiiPZP4Lqd1a9M35s+vLpnawXILVn+0Ci673HRldUqAFkxN19W5yI3K4Y=
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr9786126oif.51.1634738080369;
 Wed, 20 Oct 2021 06:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210915022328.56702-1-f.fainelli@gmail.com> <CAJZ5v0hEjQn-yr29RdpfYcsfqMCv_BK8obZy7kFP1q0SeM0Zxg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hEjQn-yr29RdpfYcsfqMCv_BK8obZy7kFP1q0SeM0Zxg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Oct 2021 15:54:29 +0200
Message-ID: <CAJZ5v0hFSswvvuRwNttpMbTo1Ni1DHNiBkk1wznOs+ts_oEvUg@mail.gmail.com>
Subject: Re: [PATCH] PM / sleep: Do not assume that "mem" is always present
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 15, 2021 at 2:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Sep 15, 2021 at 4:23 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > An implementation of suspend_ops is allowed to reject the PM_SUSPEND_MEM
> > suspend type from its ->valid() callback, we should not assume that it
> > is always present as this is not a correct reflection of what a firmware
> > interface may support.
> >
> > Fixes: 406e79385f32 ("PM / sleep: System sleep state selection interface rework")
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  kernel/power/suspend.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index eb75f394a059..02e306ad8db8 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -171,8 +171,7 @@ static bool valid_state(suspend_state_t state)
> >
> >  void __init pm_states_init(void)
> >  {
> > -       /* "mem" and "freeze" are always present in /sys/power/state. */
> > -       pm_states[PM_SUSPEND_MEM] = pm_labels[PM_SUSPEND_MEM];
> > +       /* "freeze" is always present in /sys/power/state. */
> >         pm_states[PM_SUSPEND_TO_IDLE] = pm_labels[PM_SUSPEND_TO_IDLE];
> >         /*
> >          * Suspend-to-idle should be supported even without any suspend_ops,
> > @@ -214,6 +213,7 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
> >         }
> >         if (valid_state(PM_SUSPEND_MEM)) {
> >                 mem_sleep_states[PM_SUSPEND_MEM] = mem_sleep_labels[PM_SUSPEND_MEM];
> > +               pm_states[PM_SUSPEND_MEM] = pm_labels[PM_SUSPEND_MEM];
> >                 if (mem_sleep_default >= PM_SUSPEND_MEM)
> >                         mem_sleep_current = PM_SUSPEND_MEM;
> >         }
> > --
>
> Applied as 5.16 material, thanks!

And reverted as per
https://lore.kernel.org/linux-pm/d36f79b4-472c-4852-7370-a011f9f556ce@intel.com/
