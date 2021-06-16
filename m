Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538903A9237
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 08:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFPG2Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 02:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhFPG2X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 02:28:23 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD6EC061574
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:26:17 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i17so1355142ilj.11
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5xLP1A2Y8bJVbnozl56zTBiPTdrZwPIJB0fz7axLbRs=;
        b=XBzVx1c1DLb6ZOHvOj4si5MZ9wDSKBbbO3iW9lLx3RU72t6g0mNJFWOjhv/j8/ARKv
         NPeMHHhMA082I3PS03WSAbNp8MfSElP3XEmycpm2qaSJPz9zcKS9G4eJ3KrdRThMDu4R
         lYIiRQw6BRGRn4FPkmUAcdlpAYkn1J9gn5kxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5xLP1A2Y8bJVbnozl56zTBiPTdrZwPIJB0fz7axLbRs=;
        b=QxzmE98s2Yua5URcLL9/H1J6tbgL8NpudFHt5j4DGSHwiu0VoSrAEzR5FfMi+veYFn
         2vnuKoEgJhnbYe0bMlWrj6Bf2qFRykMURA6XPwSuL+/35rarOQinOLWca4TPw9+a2ZRg
         ES9FCMQiAau/r5XuN+NFzukHaqjmpflJuKQGnfAzjkxqH8lZwQAgNe2TawZDzbBupO3P
         KJd50PQMLatxuAQQ6IlFitCKcZD9Z/Ni0LDgAkq+7f7nBDMH7MroOcoxJoleQARAISDn
         i4jPyXG0BkhVPVz5/S1YhfvktF3VCf9y18pkY/h5hHQooFpKYwNwI84DJZzmPTwXFyFj
         fwnA==
X-Gm-Message-State: AOAM5323vvKE68h33LammG/2G/oP6kA5UO2ld35wrlQ/BxVfhAX1VRBI
        Rchmbtx30d3xSyWbarELhjQ3lHzuvDEbLQ7umPs4vg==
X-Google-Smtp-Source: ABdhPJxsx/vchpXbeOAmUGWL8dNLaRCEg6HhvuuT5yRGw7Ge6UBtGB2ucC62AXaNaXjHKLy3wLbTxs2UUi788nCxeKI=
X-Received: by 2002:a92:7b07:: with SMTP id w7mr2444984ilc.308.1623824776960;
 Tue, 15 Jun 2021 23:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210616053335.4181780-1-hsinyi@chromium.org> <20210616055841.4m7y6nxnxbgw5rzi@vireshk-i7>
In-Reply-To: <20210616055841.4m7y6nxnxbgw5rzi@vireshk-i7>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 16 Jun 2021 14:25:51 +0800
Message-ID: <CAJMQK-h2R5s6rWWjr1YHO1jqZdtBkT3LYjcVg4QNMUuXJSiMTg@mail.gmail.com>
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non genpd
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Viresh Kumar )" <vireshk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 16, 2021 at 1:58 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-06-21, 13:33, Hsin-Yi Wang wrote:
> > Don't limit required_opp_table to genpd only. One possible use case is
> > cpufreq based devfreq governor, which can use required-opps property to
> > derive devfreq from cpufreq.
> >
> > Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > This is tested with the non genpd case mt8183-cci with passive
> > governor[1].
> > [1] https://patchwork.kernel.org/project/linux-mediatek/patch/1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com/
> > ---
> >  drivers/opp/of.c | 20 +-------------------
> >  1 file changed, 1 insertion(+), 19 deletions(-)
> >
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index aa75a1caf08a3..9573facce53a5 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -201,17 +201,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >                       lazy = true;
> >                       continue;
> >               }
> > -
> > -             /*
> > -              * We only support genpd's OPPs in the "required-opps" for now,
> > -              * as we don't know how much about other cases. Error out if the
> > -              * required OPP doesn't belong to a genpd.
> > -              */
> > -             if (!required_opp_tables[i]->is_genpd) {
> > -                     dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
> > -                             required_np);
> > -                     goto free_required_tables;
> > -             }
> >       }
> >
> >       /* Let's do the linking later on */
> > @@ -379,13 +368,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
> >       struct dev_pm_opp *opp;
> >       int i, ret;
> >
> > -     /*
> > -      * We only support genpd's OPPs in the "required-opps" for now,
> > -      * as we don't know much about other cases.
> > -      */
> > -     if (!new_table->is_genpd)
> > -             return;
> > -
> >       mutex_lock(&opp_table_lock);
> >
> >       list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
> > @@ -873,7 +855,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> >               return ERR_PTR(-ENOMEM);
> >
> >       ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
> > -     if (ret < 0 && !opp_table->is_genpd) {
> > +     if (ret < 0) {
> >               dev_err(dev, "%s: opp key field not found\n", __func__);
> >               goto free_opp;
> >       }
>
> How are you setting the required OPPs ? I mean when someone tries to
> change frequency of a device which has some required-opps, who is
> configuring those required OPPs ?
>
When cpufreq changes, the (cpufreq based) passive governor will
calculate a target devfreq based on that, and the device governor
(mt8183-cci-devfreq) will change the actual opp of the device.

The required-opp is set in the cpufreq table:

cpufreq_opp_table: opp_table0 {
    compatible = "operating-points-v2";
    opp-shared;
    ...
    opp0_01 {
        opp-hz = /bits/ 64 <910000000>;
        opp-microvolt = <687500>;
        required-opps = <&opp2_01>;
    };
    ...
};

devfreq_opp_table: opp_table2 {
    compatible = "operating-points-v2";
    opp-shared;
    ...
    opp2_01: opp-338000000 {
        opp-hz = /bits/ 64 <338000000>;
        opp-microvolt = <687500>;
    };
    ...
};



> --
> viresh
