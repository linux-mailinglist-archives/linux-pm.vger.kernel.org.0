Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA6B179030
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 13:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgCDMUu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 07:20:50 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35374 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgCDMUu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 07:20:50 -0500
Received: by mail-ua1-f67.google.com with SMTP id c4so527561uaq.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2020 04:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqkG/bhqrYT0KI1bQ7LTANEUR/JJcWsfoTV7hOjxbYk=;
        b=mJIGctIoq6J7/fX0YIeKjPMmUkNgZRPXylwKm2DvLr5ssq89k+ZxCUgm9DWAtg4VNN
         pcEQ2mEv5P6qw7sb1i788ajaBrcAJPv2xZqD+qEoZE9PlKOjbsAMBVkDYat1tXguAsrb
         5ZQ74b7neMNKy4b6+6MqegiUaWYxw2dCvAD6fdseLxkI45U26Usjl4O1VhDUAeXJiTZA
         7CNDMG+szzAHk/0BaA1rOgTK7JlrQxqlJH+KI1AlsyJ9P/7MhfKho01LeOTmI7UVAGrd
         wWYW9VD64wFvrclyNKKKAfPFB8dPthsPhdoBv0yYnbrmCWxmbij8pbPvAenawz+EshWP
         OYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqkG/bhqrYT0KI1bQ7LTANEUR/JJcWsfoTV7hOjxbYk=;
        b=TjV7I5F3t5Ed35AgNOvo95QI9S6luVxv/HLhlDuJ1g28qpBPoHKv2/k9cDMuKUhnSi
         58AxWet8dtF6wrax2CaBYCKEyH0HQNGTT/VSR8qEgH5IZblgq1Y6ndg4T9PnB03R0GWD
         R1VlujCWARWH1leTZVgJMy02cNnZFhbW4viaFRJr5zCsKbL+zKVeDPl8IH8iz+TN5z+b
         DQFPc/bkQkpFzAzPgTQ3nH1pRlqnFT7vBiiFwMkWZmKxZJsdrRLz9mNf5lL/wHf7S5wP
         cvubQ6xc+mPFxpaGqlnWQztURMMOWMTN8bK3XcVjIMUyoavnCKgsOsidQndjiwRmqscW
         5JGQ==
X-Gm-Message-State: ANhLgQ1nJPXWMseF+pE+xizoGfkfouIhesRj2bhIfCdikTwOKwgDaCus
        RthDVIcV1kYHcBwBkxYI/niylnJA+bKRI95p4tZYlw==
X-Google-Smtp-Source: ADFU+vsoYL2SwwLyTOmmzRjMZQmnCIyUFDxkpiyZH9m9IHmHIRtOrB+VwoBC0ztP1VD8t+WEykeA5UXfnN9itygk2jI=
X-Received: by 2002:ab0:24d2:: with SMTP id k18mr1286564uan.104.1583324449448;
 Wed, 04 Mar 2020 04:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-4-ulf.hansson@linaro.org> <20200304121250.GD25004@bogus>
In-Reply-To: <20200304121250.GD25004@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 13:20:13 +0100
Message-ID: <CAPDyKFo15UPXh5uGHa98Wgg+HHuo5D4cdEUucP9Yiw9JtLhKCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cpuidle: psci: Split psci_dt_cpu_init_idle()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 4 Mar 2020 at 13:12, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Mar 03, 2020 at 09:35:58PM +0100, Ulf Hansson wrote:
> > To make the code a bit more readable, but also to prepare some code to be
> > re-used, let's move the OSI specific initialization out of the
> > psci_dt_cpu_init_idle() and into a separate function.
> >
> > Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
>
> Not sure if this fixes anything but I am fine to have this if next one is
> a real fix.

Yep, that's what I had in mind as well.

>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Adopted suggestions from Stephen to use IS_ERR_OR_NULL and
> >       PTR_ERR_OR_ZERO, which further clarified the code.
> >
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 46 ++++++++++++++++++++--------------
> >  1 file changed, 27 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index edd7a54ef0d3..bae9140a65a5 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -160,6 +160,29 @@ int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
> >       return 0;
> >  }
> >
> > +static int __init psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
> > +                                         struct psci_cpuidle_data *data,
> > +                                         unsigned int state_count, int cpu)
> > +{
> > +     /* Currently limit the hierarchical topology to be used in OSI mode. */
> > +     if (!psci_has_osi_support())
> > +             return 0;
> > +
> > +     data->dev = psci_dt_attach_cpu(cpu);
> > +     if (IS_ERR_OR_NULL(data->dev))
> > +             return PTR_ERR_OR_ZERO(data->dev);
> > +
>
> This is what I was asking to do before this was merged when I meant to drop
> if(data->dev) check. So happy to see it :)

I probably didn't get you point well enough. Sorry.

>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks!

Kind regards
Uffe
