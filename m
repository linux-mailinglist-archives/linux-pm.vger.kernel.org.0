Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822D111480D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 21:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfLEU0c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 15:26:32 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42394 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfLEU0c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 15:26:32 -0500
Received: by mail-vk1-f195.google.com with SMTP id u123so1563130vkb.9
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 12:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRZIeGTgLYe32xwj6wCkSy8WULcrgIUyS3clF5He5As=;
        b=Vv6YHYn/g7rA9ELgKQoYQBL4QdGjWvSx07OcIA+s9uJL79lPxzqHKScJ91kLi7GiAE
         GXHu3NHrNsWuSxMm9shl63nmOcnQvcD4lZUYki4NMrdMbd38NJ1Hd4PrUqRxiFDuNM4N
         uSujBoWplByotggU8Dzw/msWAkT+G02TE0YzmQdhqODbvLzKMQG3cCUT8hWM4hCtJ8N2
         9j1EUphxgvJkCDh6nwicSDpSbCmZGOWKOU+2nTLV92i9wY3JFDrwJ8IHz3BrFr6/RXjo
         OzPJd2Bdh7PNC7/wSbEi9b5GB5Odlo9aZDFwjDn70JelWkP3cMeEg4A0DSxQJfZrO7bx
         cCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRZIeGTgLYe32xwj6wCkSy8WULcrgIUyS3clF5He5As=;
        b=QkOGPkxIhdYbF68fxAAhueQHc11dQd4TCaQfXE6MC3526fxzOG5b7v1ur7DS6x2CiN
         UCJi+F6yrN/q1E7zOnrXiNCMjIGaDc7I+7Yh7kC5D/p6VUgbdwT9bv41iHxH51efXJUI
         od6TtLne/XUYebxT8gRA737HuctafcXA/7PmmVyIS26RMCzBP2b+mc385Zr8X0lujPOf
         ehgpWN3tFrQvc+prOjmNnFvDJJTLz26hhTYFM/OzT4iNNpra8ot+x8XIBlk+G6Y1RVKE
         x7k+tuwa8Elfvuf4/NHam0oN5F3JN5i8lKnV0ZHmtH3K+itkC1aejBqX2ftnLrPv5fbd
         a2nQ==
X-Gm-Message-State: APjAAAVTEepx8sZS2QCHlHRHk7ofEOySJ1d/8G+MdPV3m9tQrWQXXWuv
        bErpxJutDPZNKniixxAL3bq89PmpqAoHwtsU3y7jkA==
X-Google-Smtp-Source: APXvYqwJJ8Ov6kfOALtgEnyiA5wFf5YLHSlajlzw+cIFNSq6BfMBdVmzkt4dpZD618trXduh3PKpSjDTLxUI2kReD0M=
X-Received: by 2002:a1f:2f04:: with SMTP id v4mr8247656vkv.101.1575577591049;
 Thu, 05 Dec 2019 12:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
 <20191127102914.18729-11-ulf.hansson@linaro.org> <20191205183544.GB1516@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191205183544.GB1516@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Dec 2019 21:25:54 +0100
Message-ID: <CAPDyKFra-C_EKrcec6Yys2P10bB+KBtVAKNtVFgqDvV=tzbDRQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
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
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 5 Dec 2019 at 19:35, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Nov 27, 2019 at 11:29:11AM +0100, Ulf Hansson wrote:
>
> [...]
>
> > -static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> > +static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> > +                                     struct device_node *cpu_node,
> >                                       unsigned int state_count, int cpu)
> >  {
> >       int i, ret = 0;
> > @@ -118,6 +152,11 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
> >               goto free_mem;
> >       }
> >
> > +     /* Manage the deepest state via a dedicated enter-function. */
> > +     if (dev)
> > +             drv->states[state_count - 1].enter =
> > +                     psci_enter_domain_idle_state;
>
>
> It is unfortunate to make this arbitrary choice, it would be best
> if you could detect which states are "domain" states aka are governed
> by multiple cpus.

The domain states are managed and selected by the genpd providers, via
using runtime PM reference counting. Please have a closer look at the
code in cpuidle-psci-domain.c and in the generic PM domain, that
should give you the needed details.

I am overriding the enter callback for the *deepest* known idle state
of the CPU, which is according to what you requested [1].

So, unless I am missing your point, I think the above code does
exactly what you want, no?

In regards to the "arbitrary choice" of what cpuidle state to use,
there are more details about why that is, in the changelog.

>
> This inizialization though does not belong in here, it is done at driver
> level, it should not be done in this per-cpu path. IIUC the logic the
> enter pointer should only be overridden if and only if all cpus managed
> by the driver have a corresponding device associated.

I think you have overlooked the fact that there are one cpuidle driver
registered per CPU. The above doesn't make sense to me, sorry.

>
> To be frank I would even move the psci_has_osi_support() check from
> psci_dt_attach_cpu() to this path and prevent calling
> psci_dt_attach_cpu() and the tail of the function if
> (!psci_has_osi_support()).
>
> >       data->dev = dev;
>
> I think Sudeep already mentioned that, by using psci_has_osi_support()
> as above you can prevent running this code, there is really no point,
> the data->dev NULL sentinel is already initialized.

Yes, I discussed this with Sudeep, but we didn't reach a consensus.
Let me explain the reasons behind the selected approach, once more.

The data->dev is a pointer within a static declared struct. Are you
sure it's assigned NULL by initialization? Don't we explicitly need to
set it to NULL, else it will be undefined, no?

Of course, I can move the check for psci_has_osi_support() into here
and avoid calling psci_dt_attach_cpu(). Just wondering what that
actually gain us, especially if we need to explicitly set the pointer
to NULL anyway.

That said, can you please confirm your thoughts around this, I will
change to whatever you think is best.

[...]

Kind regards
Uffe

[1] https://www.spinics.net/lists/arm-kernel/msg770558.html
