Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B65127038
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 23:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLSWDT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 17:03:19 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36034 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSWDT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 17:03:19 -0500
Received: by mail-vs1-f67.google.com with SMTP id u14so4786437vsu.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 14:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGg/VPhjljPEVy0oiqQLSbznsgjjJxXVog0U+hn/ESU=;
        b=joZKWf1bgg/jx0Kz2E85dVdv/+g9mz4KnfA/da0PI7njX4kfc6A7WxGZHdGvygjeMu
         PKwReZgOihjo6JjJjDSA46biM2iDfKwWe1KOU5vznQSQzwj/+Pz0RmAP8kf3EyGKmR4x
         u2iGLpz4CPnsW/9smhDMXJJYGTrOyOfzyyBglbxrMrIZp9onbgnkRlcoilGe67zIWR+r
         1rUwqG4zCzTuJ+cg1OCuWVBsBT5FJOicQPk+8kVjx2P55RwrBpheKrJBTmh7eDzJwxSw
         LupcdqxTI4+0csD+EHLvwC2b6eZyFSQuFAX3RScM4PccDgPLm+Nb3Otpc4fLMIGbR8+N
         1xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGg/VPhjljPEVy0oiqQLSbznsgjjJxXVog0U+hn/ESU=;
        b=O10VMaKGGl3uZflUD240bcjBRi/2DknY0jFPHXbVlDfAhOqmyBxObDJZCyz7ODg+GB
         3+wrmmFArRYIXcBjxNNENZgBBRIxCbtXfFVTvGmQ7ucr8VoEUvCkFRx4lgLb7DZujgQc
         qb+Ik3A9J3rrh6b+cmqqmUj42Zv5OW+yQ2t5CwVc9udKe6RDe9+bn9wFtG66q5VzMaIO
         Z3Pii4yfafLvwy0CZghu43jHhw0g55bAvpFNtuWsZC94DHBcWagZsJ8VULfkvj3EAoXF
         97DDy6dzJqynj6I95A8e3Dn3rlB36NFeUZNF5bz1dB5zrGiBBTwLQJiHJkQ0UO+p2wkq
         YAAg==
X-Gm-Message-State: APjAAAUkSQtH0bPScDtJLL7Hta883mNf42DKJ+0qxJAZjADClyR1wkKc
        AHLf9AucgMMqlW5SczJPOHErESXojyB8GIMXzl6HgA==
X-Google-Smtp-Source: APXvYqyRX1pzAqviTPuOSBvVIlNW5JOH5lKka+Li4LQDMkaCXYVWnDzP2Pq7TaLzmcw8QKgibrbnbOZiNhJVtiWy+jo=
X-Received: by 2002:a67:f499:: with SMTP id o25mr6341165vsn.165.1576792996509;
 Thu, 19 Dec 2019 14:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-14-ulf.hansson@linaro.org> <20191219143427.GF20746@bogus>
 <CAPDyKFpPmtXkP6LSNWBbfyTJowjQXF39_4LN5YEcDtW1BzVw-g@mail.gmail.com> <20191219180629.GC21846@bogus>
In-Reply-To: <20191219180629.GC21846@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 23:02:40 +0100
Message-ID: <CAPDyKFrtrkASV4d2+x+A2P=TMrnLGh4LK9nzNeqZCg71Hs2TEQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] cpuidle: psci: Add support for PM domains by
 using genpd
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Dec 2019 at 19:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Dec 19, 2019 at 04:48:39PM +0100, Ulf Hansson wrote:
> > On Thu, 19 Dec 2019 at 15:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Wed, Dec 11, 2019 at 04:43:42PM +0100, Ulf Hansson wrote:
> > > > When the hierarchical CPU topology layout is used in DT and the PSCI OSI
> > > > mode is supported by the PSCI FW, let's initialize a corresponding PM
> > > > domain topology by using genpd. This enables a CPU and a group of CPUs,
> > > > when attached to the topology, to be power-managed accordingly.
> > > >
> > > > To trigger the attempt to initialize the genpd data structures let's use a
> > > > subsys_initcall, which should be early enough to allow CPUs, but also other
> > > > devices to be attached.
> > > >
> > > > The initialization consists of parsing the PSCI OF node for the topology
> > > > and the "domain idle states" DT bindings. In case the idle states are
> > > > compatible with "domain-idle-state", the initialized genpd becomes
> > > > responsible of selecting an idle state for the PM domain, via assigning it
> > > > a genpd governor.
> > > >
> > > > Note that, a successful initialization of the genpd data structures, is
> > > > followed by a call to psci_set_osi_mode(), as to try to enable the OSI mode
> > > > in the PSCI FW. In case this fails, we fall back into a degraded mode
> > > > rather than bailing out and returning an error code.
> > > >
> > > > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >
> > > > Changes in v4:
> > > >       - None.
> > > >
> > > > ---
> > > >  drivers/cpuidle/cpuidle-psci-domain.c | 267 ++++++++++++++++++++++++++
> > > >  drivers/cpuidle/cpuidle-psci.c        |   4 +-
> > > >  drivers/cpuidle/cpuidle-psci.h        |   5 +
> > > >  3 files changed, 274 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > > index 656ef3d59149..c2f94ba42222 100644
> > > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > > @@ -7,14 +7,281 @@
> > > >   *
> > > >   */
> > > >
> > > > +#define pr_fmt(fmt) "CPUidle PSCI: " fmt
> > > > +
> > > >  #include <linux/cpu.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/pm_domain.h>
> > > >  #include <linux/pm_runtime.h>
> > > > +#include <linux/psci.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/string.h>
> > > >
> > > >  #include "cpuidle-psci.h"
> > > >
> > > > +struct psci_pd_provider {
> > > > +     struct list_head link;
> > > > +     struct device_node *node;
> > > > +};
> > > > +
> > > > +static LIST_HEAD(psci_pd_providers);
> > > > +static bool osi_mode_enabled;
> > > > +
> > > > +static int psci_pd_power_off(struct generic_pm_domain *pd)
> > > > +{
> > > > +     struct genpd_power_state *state = &pd->states[pd->state_idx];
> > > > +     u32 *pd_state;
> > > > +
> > > > +     /* If we have failed to enable OSI mode, then abort power off. */
> > > > +     if (!osi_mode_enabled)
> > > > +             return -EBUSY;
> > > > +
> > >
> > > Why is above check needed ? Shouldn't we have disable/remove pd of
> > > OSI is not enabled ?
> >
> > Well, failing to enable OSI should in practice not happen, while it
> > theoretically it could.
> >
>
> I won't assume that. Since it's new and not tested yet, I prefer to assume
> it can fail.

Yes, I agree. Hence the degraded mode.

>
> > My approach to this has been to fall back to use a "degraded mode",
> > which seems quite common for these kind of situations. The degraded
> > mode means, we are preventing domain states from being used.
> >
>
> But why can't we just fail registering or remove if already added.

We can, but there are more problems with that than leaving this in a
degraded mode, I think. See more below.

> They are useless for "degraded mode" anyways. And it will ensure that
> data->dev is NULL. Sorry now I see why you said it can be NULL but I
> would rather not leave those unused genpd in place in case of error.

data->dev would not be NULL in this case, because the
dev_pm_domain_attach_by_name() which is called when we attach the CPU
is going to return an error code, not NULL.

That's because the connection is there in the DTB and thus it must
fail, in this case it would be with -EPROBE_DEFER (waiting for a genpd
provider to be registered).

That would then lead to that the entire cpuidle-psci driver would fail
to initiate/probe. In my opinion, I think it's better to fall back
into a degraded mode, using all the idle states for the CPUs, but just
preventing the cluster idle states.

Just wanted to make this more clear for you to consider. I am happy to
change in any way you suggest, but please confirm that you really want
another behaviour than the degraded mode.

>
> > More importantly, it also keeps the code registering the PM domains, a
> > bit simpler.
> >
>
> I feel it is simpler other way around especially if I am testing and
> seeing failures but I see genpd succeeding. That's confusing.

There is an warning message printed if psci_set_osi_mode() fails,
"failed to enable OSI mode", in psci_idle_init_domains().

We could potentially add some more information to that message, that
this also leads into using a "degraded mode". Would that be sufficient
to satisfy your concerns?

Kind regards
Uffe
