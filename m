Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99803A95F6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFPJWu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhFPJWu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 05:22:50 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE76C06175F
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 02:20:43 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z1so1800735ils.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 02:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIrdHCxP+eNu9RDYSBtvb989XhIMr5N4tWo/LdXTbrI=;
        b=RAW318u+hQF1wf7yhBNK6SanQy9VNJrs3eEff5oUIT9qZgcyh4hrl4j8RMyGVbvC0V
         QizCKWORSGGbsV6EzbKFRu4PfCU0zgJ12f5hU7I9nDaeBO4i27REIN93JM0o9MBJZuOW
         /66abXD+7u7nyHjsHo1cbQxzG9qD9YNbXc24Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIrdHCxP+eNu9RDYSBtvb989XhIMr5N4tWo/LdXTbrI=;
        b=EJCzgROtLXhNkyZX0rGroBw7nD9PXiyAzuMfqwUf6zeS0n1+wlfZybkeObDtGWvhSg
         TQJJU34BSI5Sdw3wQ09kW84uZjh4446nTf+Gci4ibE5UMcpDzAveMYoHRYGUxEvAYhVh
         ZSzu0deLYT0Tntr9b5Krn8HLeKtTt8zlaItyyrbhmLGWOYaM/hCsmMPgmpxqvZZUCr84
         PX+zWyVROwyMb8e+xvM1t0ZEce7Y14IvkJNMEfg5bKkwlEak8xzYGQsVb2jec0zqlCHy
         iE4jA3A3OVP+RUbiBA8YjBy8vyc0UnbrTr+m7hXi+LtZ9XqVDLTxjUBUe5Ode1XCLe9d
         hVnw==
X-Gm-Message-State: AOAM533CNFjYwP5y2/GRep7IHsh9UdFXLLsclh9pS7h6WVFq/cqUUTEt
        RpEOHjpNv+yCt19eXt+Imze6bnGetC34NwJ9DaZp6g==
X-Google-Smtp-Source: ABdhPJxlqLkzHebAGro9aRD6l8ybazeFhkkKwg/voI/xiYOhMYf5Qwb2bd+Ofv4/b3TJrNAXjH0I3JOqFYKMZh+mO5A=
X-Received: by 2002:a92:360e:: with SMTP id d14mr2965475ila.106.1623835242824;
 Wed, 16 Jun 2021 02:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210616053335.4181780-1-hsinyi@chromium.org> <CGME20210616075555epcas1p136129544501878b4bedaf8e46f9a43dc@epcas1p1.samsung.com>
 <20210616075548.ghp3lmjf4y6pyxoy@vireshk-i7> <b9310754-2105-2a93-ecbf-513d9a80a91a@samsung.com>
 <20210616090945.sn337tftdcp7y7y6@vireshk-i7>
In-Reply-To: <20210616090945.sn337tftdcp7y7y6@vireshk-i7>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 16 Jun 2021 17:20:16 +0800
Message-ID: <CAJMQK-gXDcXhvR04hax7GnqW72FtUj4Hm5aheLtqzrhVm8av9w@mail.gmail.com>
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non genpd
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        "Viresh Kumar )" <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 16, 2021 at 5:09 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-06-21, 17:47, Chanwoo Choi wrote:
> > On 6/16/21 4:55 PM, Viresh Kumar wrote:
> > > On 16-06-21, 13:33, Hsin-Yi Wang wrote:
> > >> Don't limit required_opp_table to genpd only. One possible use case is
> > >> cpufreq based devfreq governor, which can use required-opps property to
> > >> derive devfreq from cpufreq.
> > >>
> > >> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> > >> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > >> ---
> > >> This is tested with the non genpd case mt8183-cci with passive
> > >> governor[1].
> > >> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com/
> > >> ---
> > >>  drivers/opp/of.c | 20 +-------------------
> > >>  1 file changed, 1 insertion(+), 19 deletions(-)
> > >>
> > >> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > >> index aa75a1caf08a3..9573facce53a5 100644
> > >> --- a/drivers/opp/of.c
> > >> +++ b/drivers/opp/of.c
> > >> @@ -201,17 +201,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> > >>                    lazy = true;
> > >>                    continue;
> > >>            }
> > >> -
> > >> -          /*
> > >> -           * We only support genpd's OPPs in the "required-opps" for now,
> > >> -           * as we don't know how much about other cases. Error out if the
> > >> -           * required OPP doesn't belong to a genpd.
> > >> -           */
> > >> -          if (!required_opp_tables[i]->is_genpd) {
> > >> -                  dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
> > >> -                          required_np);
> > >> -                  goto free_required_tables;
> > >> -          }
> > >>    }
> > >>
> > >>    /* Let's do the linking later on */
> > >> @@ -379,13 +368,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
> > >>    struct dev_pm_opp *opp;
> > >>    int i, ret;
> > >>
> > >> -  /*
> > >> -   * We only support genpd's OPPs in the "required-opps" for now,
> > >> -   * as we don't know much about other cases.
> > >> -   */
> > >> -  if (!new_table->is_genpd)
> > >> -          return;
> > >> -
> > >>    mutex_lock(&opp_table_lock);
> > >>
> > >>    list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
> > >> @@ -873,7 +855,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> > >>            return ERR_PTR(-ENOMEM);
> > >>
> > >>    ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
> > >> -  if (ret < 0 && !opp_table->is_genpd) {
> > >> +  if (ret < 0) {
> > >>            dev_err(dev, "%s: opp key field not found\n", __func__);
> > >>            goto free_opp;
> > >>    }
> > >
> > > Plus this and few changes to commit log.
> > >
> > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > index e366218d6736..b335c077f215 100644
> > > --- a/drivers/opp/core.c
> > > +++ b/drivers/opp/core.c
> > > @@ -893,6 +893,16 @@ static int _set_required_opps(struct device *dev,
> > >         if (!required_opp_tables)
> > >                 return 0;
> > >
> > > +       /*
> > > +        * We only support genpd's OPPs in the "required-opps" for now, as we
> > > +        * don't know much about other use cases. Error out if the required OPP
> > > +        * doesn't belong to a genpd.
> > > +        */
> > > +       if (unlikely(!required_opp_tables[0]->is_genpd)) {
> > > +               dev_err(dev, "required-opps don't belong to a genpd\n");
> > > +               return -ENOENT;
> > > +       }
> > > +
> >
> > If you add this checking statement, I think that
> > when using dev_pm_opp_set_rate with required-opp property, it will be failed.
>
> Yes, that is exactly what I am trying to do here. Hsin already
> confirmed that you guys won't use this API, isn't ?

we used clk_set_rate() and regulator_set_voltage().
>
> The point here is that the _set_required_opps() function only updates
> the performance state of genpds today. So it won't work for you guys
> anyway.
>
> --
> viresh
