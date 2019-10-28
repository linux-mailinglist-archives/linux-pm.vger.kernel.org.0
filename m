Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B061AE7C75
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 23:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfJ1Wkx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 18:40:53 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46904 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJ1Wkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 18:40:53 -0400
Received: by mail-vs1-f65.google.com with SMTP id o21so3266830vsq.13
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 15:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbHWlc0+nebJGqRHkft0So8Qf87tbPWPZEk2OCB5L7k=;
        b=uoJWfdHBg4e2UJvDhf80dB6X0XM296yPXsBBn8t1aMMhnV0Pg6grSjQP1tA43WMskh
         XQL+YEgY9PWdYNA1/44uXNmZpLiQr74EbBMO0kd4dmU5U+IMpLd1+M+CgII+vKGdSZIH
         EDAKM20nlfrWO8zLEv5ssqfvicW1SKpoIuDbY7b2aCpX5r7Gz5u0Kl1CCXQKITvU3wRY
         LnXwkWgTpdCHvBd5UHWQAv9i0MUNv5KXskdLGafGW4I8h6IZ7tRji4sYIqBgdXXAhzlO
         NoHAqlkiHMqh86odCWrKAgptg42lB75m5wUj+Ri3GHzOgBlnKT6RxbEoY9O/Z0/Hyt0U
         P8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbHWlc0+nebJGqRHkft0So8Qf87tbPWPZEk2OCB5L7k=;
        b=fRHZT5LfOanHvq/C/8B/ZkkzjfZxnPhY7i6NYB1gXXiVN9nXl21Fz8zb/l75XEC1WJ
         RbPjLGOKl06Isv2y3pQ28Cdak3TpByAqxILxn4AzIlVAHANdAcLiX/hgMGvUpeXfXd0A
         HsSFgHyHABoIET5yJ1H0IWAEw8TzeKmp+7n1tk1XZ8RFVKwpKxQYiL8Pu/XSGGjEs7yb
         m7dSzGNAhWXzxTCtpnLuBGIWQfhwyyoaEWKPiNpzHKdRgHHEuvh73whgCYCKqj019PsG
         QnICh3vEXUd5keApqmjOJsKdQPW/arb5K4knUYcVxNdp3CLA9iPuZSXiAP4uSzHtvtcx
         p8+Q==
X-Gm-Message-State: APjAAAVnEcr6+t30zdD9cSh36s6Q2MyCW/oXzkzS68f08DyJwI+0Ukuf
        KQ969YZ4TKsG+wu512QLRePlMoTIwzKyGmw8ySqj1g==
X-Google-Smtp-Source: APXvYqwvgrSKNvgD0SzVjUsiTobckOY2eSt0wr5gmUCcZBLHvL1zQq+ew7oqw1cZhVYfkSqkHRRumj6qS7VkI+zjNOo=
X-Received: by 2002:a67:fb5a:: with SMTP id e26mr6327260vsr.200.1572302452026;
 Mon, 28 Oct 2019 15:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-13-ulf.hansson@linaro.org> <20191024163257.GC22036@bogus>
 <CAPDyKFpwrfHj-az5x5dW92VAxi887FgWW6GKhfPv_kuj14TDjQ@mail.gmail.com> <20191027023414.GE18111@e107533-lin.cambridge.arm.com>
In-Reply-To: <20191027023414.GE18111@e107533-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Oct 2019 23:40:16 +0100
Message-ID: <CAPDyKFoyEY+bwYnekXV=DuL5rqbRVDPiYUUL0cTeVAa8xE7n4A@mail.gmail.com>
Subject: Re: [PATCH 12/13] cpuidle: psci: Manage runtime PM in the idle path
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 27 Oct 2019 at 03:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 24, 2019 at 07:00:38PM +0200, Ulf Hansson wrote:
> > On Thu, 24 Oct 2019 at 18:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Oct 10, 2019 at 01:39:36PM +0200, Ulf Hansson wrote:
> > > > In case we have succeeded to attach a CPU to its PM domain, let's deploy
> > > > runtime PM support for the corresponding attached device, to allow the CPU
> > > > to be powered-managed accordingly.
> > > >
> > > > To set the triggering point for when runtime PM reference counting should
> > > > be done, let's store the index of deepest idle state for the CPU in the per
> > > > CPU struct. Then use this index to compare the selected idle state index
> > > > when entering idle, as to understand whether runtime PM reference counting
> > > > is needed or not.
> > > >
> > > > Note that, from the hierarchical point view, there may be good reasons to
> > > > do runtime PM reference counting even on shallower idle states, but at this
> > > > point this isn't supported, mainly due to limitations set by the generic PM
> > > > domain.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/cpuidle/cpuidle-psci.c | 21 +++++++++++++++++++--
> > > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > > > index 1510422c7a53..0919b40c1a85 100644
> > > > --- a/drivers/cpuidle/cpuidle-psci.c
> > > > +++ b/drivers/cpuidle/cpuidle-psci.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include <linux/of.h>
> > > >  #include <linux/of_device.h>
> > > >  #include <linux/psci.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/slab.h>
> > > >
> > > >  #include <asm/cpuidle.h>
> > > > @@ -25,6 +26,7 @@
> > > >
> > > >  struct psci_cpuidle_data {
> > > >       u32 *psci_states;
> > > > +     u32 rpm_state_id;
> > > >       struct device *dev;
> > > >  };
> > > >
> > > > @@ -50,14 +52,28 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
> > > >                               struct cpuidle_driver *drv, int idx)
> > > >  {
> > > >       int ret;
> > > > -     u32 *states = __this_cpu_read(psci_cpuidle_data.psci_states);
> > > > -     u32 state = psci_get_domain_state();
> > > > +     struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
> > > > +     u32 *states = data->psci_states;
> > > > +     struct device *pd_dev = data->dev;
> > > > +     bool runtime_pm = (pd_dev && data->rpm_state_id == idx);
> > > > +     u32 state;
> > >
> > > Wonder if we can have separate psci_enter_idle_state for OSI mode so
> > > that all these runtime extra check can be reduced ? It will also make
> > > sure there's no additional latency for PC mode because of OSI.
> >
> > Good idea, that's the plan. See previous answer.
> >
> > Perhaps if I add a patch on top, implementing your suggestion, would
> > you be happy with that?
>
> No, I prefer to amend this itself to keep it easy to be able to bisect.

Alright!

So I explored this a little bit more - and it actually forced me to
re-order some of the patches in the series, but it seems to have
turned out well.

In the new approach I have taken, I haven't replaced the actual
callback for the idle state, but instead make an early decision in
psci_enter_idle_state(), based on one single read of a per CPU
variable/struct. This tell what path to go.

I am running some final test, but should be able to post a new version
tomorrow. Although, if you still don't think the new approach is good
enough, we can always invent a callback, that we can assign when the
CPU is attached to PM domain. In any case, you will have to tell what
you think, after I posted the new version, just wanted to give you a
heads up.

Kind regards
Uffe
