Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE97179020
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 13:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgCDMS0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 07:18:26 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41406 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgCDMS0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 07:18:26 -0500
Received: by mail-ua1-f67.google.com with SMTP id d19so572939uak.8
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2020 04:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ENDQdK0BnTgBrmbo1z33qY08hnGuLOjFToJM+EoACQ=;
        b=dAcvZ6LIDOcMeA4h8UWulv+NWq+8i2LMIfn4ZJ/bK+tyXrXb63qiJ3FWzP2+iXu5AD
         Bv2EGQi1kO/CG2yr6MHW18uOVD8P+728bCK6CcqUYAGPGnHaDDzRqriswg794wxTvJFj
         4jJ4CJQP8cILOiZ4idsLda7HIE9ig7ZvfxHbw+Z7/nsNeolzjOebgBijlLOLiFXCenuZ
         E2tjdHg5/NdwbqF3FxUlnn/j1EEav4+2q/GL4kf7BxvvYYSSnot6pRUYKUayaKMo9Qig
         7nZqEuw69VfrGRIQ50xEb+2yABixBOayBmcG5hMLBPGWqrSzWhIRJUcJy7euMkBTI/Jh
         FYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ENDQdK0BnTgBrmbo1z33qY08hnGuLOjFToJM+EoACQ=;
        b=rrEoRQ8/Dtgg93ciVPaH2Dlcx24ygqjB5l3GEs+76jyd3Y+nlshgFXJ3po0jKz3DjA
         7Xo/J74+yCIdAbJteAiIDMavvd2nq8o88QvKq2AD8psMY6W/3lvoAzhrk0KLKJrledt6
         z3N8xazFc9NzLpYO0Wj4GxjOP4o/F0Q6xUNgE87uqnR5bMISCh0KLrAMnv4lJvX+vRV/
         Ls54B4Deoc6AsOcMp5vqpcsNvrSbSc3nDaERjkB+zHuUy9utNmp495UameiQ366cux2H
         2t48WLBHmI6UXU1zhglGYMuEqtkudQfA5ywF9pBfEC4WqcZy89ozBUgagT8EBSKKX2yu
         Zkkg==
X-Gm-Message-State: ANhLgQ083H+cAYjiZkQC2MfHSLUe/c4HEYYexihXYoGUf31FsqWrDPNy
        0B/i2xvClNoyXJ6ZnBgjdS+H0tfvOU3epJGP8Ll4/w==
X-Google-Smtp-Source: ADFU+vs64WAXYstjh/9mMgNerdas9d2I6hWXLhFl8/qXXr1kzUvzPo2E7WUlATihcSCippJscfqookVKFmvVz0feZLE=
X-Received: by 2002:ab0:20a:: with SMTP id 10mr1206957uas.19.1583324304979;
 Wed, 04 Mar 2020 04:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-3-ulf.hansson@linaro.org> <20200304105039.GC25004@bogus>
In-Reply-To: <20200304105039.GC25004@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 13:17:49 +0100
Message-ID: <CAPDyKFqd0DswuyLCFQ1F6G7agCEEgf0vzofRVyBVVPQTn-vK+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] cpuidle: psci: Fixup support for domain idle
 states being zero
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

On Wed, 4 Mar 2020 at 11:50, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Mar 03, 2020 at 09:35:57PM +0100, Ulf Hansson wrote:
> > The current code intends to allow a PSCI PM domain to have none domain idle
> > states defined in DT. However, a few minor things needs to be fixed to make
> > this correctly supported, so let's do that.
> >
> > Reported-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index 423f03bbeb74..c34b12c4069a 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -49,6 +49,9 @@ static int __init psci_pd_parse_state_nodes(struct genpd_power_state *states,
> >       int i, ret;
> >       u32 psci_state, *psci_state_buf;
> >
> > +     if (!states)
> > +             return 0;
> > +
>
> Was any issue found ? Or just code inspection ? If states = NULL,
> state_count = 0, and I don't see anything blowing up. It may save couple
> of extra instruction execution.

Code inspection, the real problem was fixed in patch 1.

>
> >       for (i = 0; i < state_count; i++) {
> >               ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
> >                                       &psci_state);
> > @@ -96,6 +99,9 @@ static void psci_pd_free_states(struct genpd_power_state *states,
> >  {
> >       int i;
> >
> > +     if (!states)
> > +             return;
> > +
>
> Same here and kfree(NULL) is also valid.

Yep, let's drop $subject patch from the series, it's not needed.

Thanks for reviewing!

Kind regards
Uffe
