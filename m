Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE8133B95
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 07:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgAHGRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 01:17:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33497 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgAHGRC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 01:17:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id v140so1735983oie.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2020 22:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eJrxhaP/aaAfcxtlL9c20UfMMdfSSzkJiRKVZy1Dns=;
        b=eHZPn0qFgiwR3TqFdduhITPTiKflxh0LGckrcuBVonlJemqgmLHotGKYPwlHp1FJMi
         xNnCmo6tTnLgl2axxjjps13sWddlfqJLjuY7gDwHJgGruJMUq6NdN2PVTMetx8SRM4So
         +15FJC2MFVzhNDSkf3N433EGhGJBDxaDNMdrcbsPRbUB3kCnIlCCM4rQLlneQQI8gKsv
         lIttIgNYq4KMNjKAHWH+QBINXldzaIjxFu6EEkdCq+MQmui8YHyvI1PxwXY9taRR3pt1
         mjGO/QDtkelqlR9gjQuP7z6LR9nM/W+onOl3mqOcEmHmiYOvmiHX2A94xcqB8N4eWqTD
         a+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eJrxhaP/aaAfcxtlL9c20UfMMdfSSzkJiRKVZy1Dns=;
        b=HrT5C7GcVcBE9wnW/kuDLzx1rd9o91/vFz9YF4BMwj2a1OVZK6Hzn83N2hE2WMP20L
         H1/3zZL9xfIqgKdp7uX+Ujyrs4WXGxNi32cHlXeAjyoSedIdFAJYQ5LZZtDr50NFKRit
         ImkqED4f7uqIGzTly6PE78LSehWF9+b7qDKhHDe/SePbhyv0HTmQwZ0ODKh2CrzGqgGZ
         gL22VX9cge7fbpw+ruS9+XNC/Y3bnrl5gIPlxQq46nbhyc1PaId5+uZ2Ir/9AnYfpinS
         u+2SZsptXigfW/7rHKSpRz9VS+HsuulSuT+GQUHsTvrgrTCoYB59o04RFz+f2sBkm7K/
         5auA==
X-Gm-Message-State: APjAAAWtHxNf5atoi1Eu7+AxJ3cFjkieq6dYSKYuirJd0V5TJDq4wF7m
        E1mWRthzxfGTd7NN1Y0lF4MhpxddF1jkCKoef/dp2g==
X-Google-Smtp-Source: APXvYqwrxujGPx+8mslow3vxWpXeXFymV/tHcUenrLe4Wf7W57KW9I6GPXuC3PeiLqPMCiatJJf8YGVK7zVdiZMj9AA=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr1907823oig.172.1578464220518;
 Tue, 07 Jan 2020 22:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com> <20191207002424.201796-3-saravanak@google.com>
 <c701fe1d94631e3aba92a8c80070c6a4@codeaurora.org>
In-Reply-To: <c701fe1d94631e3aba92a8c80070c6a4@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 7 Jan 2020 22:16:24 -0800
Message-ID: <CAGETcx9Or==EEL6jRMEh4bG4cmFmLqk_n1ReKT=cg-MEsL9w0w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] OPP: Add support for bandwidth OPP tables
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 7, 2020 at 11:28 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Saravana,
>
> Spent some time testing this series while
> trying out dcvs on SDM845/SC7180. Apart from
> the few minor issues it works quite well!

Thanks a lot for testing Sibi. Can you give a tested-by? Glad to hear
it works well.

> On 2019-12-07 05:54, Saravana Kannan wrote:
> > Not all devices quantify their performance points in terms of
> > frequency.
> > Devices like interconnects quantify their performance points in terms
> > of
> > bandwidth. We need a way to represent these bandwidth levels in OPP.
> > So,
> > add support for parsing bandwidth OPPs from DT.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/opp/core.c | 15 +++++++++--
> >  drivers/opp/of.c   | 63 ++++++++++++++++++++++++++++++++--------------
> >  drivers/opp/opp.h  |  5 ++++
> >  3 files changed, 62 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index be7a7d332332..c79bbfac7289 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1282,11 +1282,21 @@ static bool
> > _opp_supported_by_regulators(struct dev_pm_opp *opp,
> >       return true;
> >  }
> >
> > +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
> > +{
> > +     if (opp1->rate != opp2->rate)
> > +             return opp1->rate < opp2->rate ? -1 : 1;
> > +     if (opp1->peak_bw != opp2->peak_bw)
> > +             return opp1->peak_bw < opp2->peak_bw ? -1 : 1;
> > +     return 0;
> > +}
> > +
> >  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp
> > *new_opp,
> >                            struct opp_table *opp_table,
> >                            struct list_head **head)
> >  {
> >       struct dev_pm_opp *opp;
> > +     int opp_cmp;
> >
> >       /*
> >        * Insert new OPP in order of increasing frequency and discard if
> > @@ -1297,12 +1307,13 @@ static int _opp_is_duplicate(struct device
> > *dev, struct dev_pm_opp *new_opp,
> >        * loop.
> >        */
> >       list_for_each_entry(opp, &opp_table->opp_list, node) {
> > -             if (new_opp->rate > opp->rate) {
> > +             opp_cmp = opp_compare_key(new_opp, opp);
> > +             if (opp_cmp > 0) {
> >                       *head = &opp->node;
> >                       continue;
> >               }
> >
> > -             if (new_opp->rate < opp->rate)
> > +             if (opp_cmp < 0)
> >                       return 0;
> >
> >               /* Duplicate OPPs */
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 1cbb58240b80..b565da5a2b1f 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -521,6 +521,44 @@ void dev_pm_opp_of_remove_table(struct device
> > *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> >
> > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct
> > device_node *np,
> > +                      bool *rate_not_available)
> > +{
> > +     int ret;
> > +     u64 rate;
> > +     u32 bw;
> > +
> > +     ret = of_property_read_u64(np, "opp-hz", &rate);
> > +     if (!ret) {
> > +             /*
> > +              * Rate is defined as an unsigned long in clk API, and so
> > +              * casting explicitly to its type. Must be fixed once rate is 64
> > +              * bit guaranteed in clk API.
> > +              */
> > +             new_opp->rate = (unsigned long)rate;
> > +             goto out;
> > +     }
> > +
> > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > +     if (!ret) {
> > +             new_opp->peak_bw = bw;
> > +
> > +             if (!of_property_read_u32(np, "opp-avg-kBps", &bw))
> > +                     new_opp->avg_bw = bw;
> > +     }
> > +
> > +out:
> > +     *rate_not_available = !!ret;
> > +     /*
> > +      * If ret is 0 at this point, we have already found a key. If we
> > +      * haven't found a key yet, then ret already has an error value. In
> > +      * either case, we don't need to update ret.
> > +      */
> > +     of_property_read_u32(np, "opp-level", &new_opp->level);
> > +
> > +     return ret;
> > +}
> > +
> >  /**
> >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT
> > bindings)
> >   * @opp_table:       OPP table
> > @@ -558,26 +596,12 @@ static struct dev_pm_opp
> > *_opp_add_static_v2(struct opp_table *opp_table,
> >       if (!new_opp)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     ret = of_property_read_u64(np, "opp-hz", &rate);
> > -     if (ret < 0) {
> > -             /* "opp-hz" is optional for devices like power domains. */
> > -             if (!opp_table->is_genpd) {
> > -                     dev_err(dev, "%s: opp-hz not found\n", __func__);
> > -                     goto free_opp;
> > -             }
> > -
> > -             rate_not_available = true;
> > -     } else {
> > -             /*
> > -              * Rate is defined as an unsigned long in clk API, and so
> > -              * casting explicitly to its type. Must be fixed once rate is 64
> > -              * bit guaranteed in clk API.
> > -              */
> > -             new_opp->rate = (unsigned long)rate;
> > +     ret = _read_opp_key(new_opp, np, &rate_not_available);
> > +     if (ret) {
>
> if (!opp_table->is_genpd) {
>
> _read_opp_key returns an error for genpd
> opps so please check if it is a genpd
> opp_table before erroring out here.

Thanks. I'll fix it in the next version.

> > +             dev_err(dev, "%s: opp key field not found\n", __func__);
> > +             goto free_opp;
> >       }
> >
> > -     of_property_read_u32(np, "opp-level", &new_opp->level);
> > -
> >       /* Check if the OPP supports hardware's hierarchy of versions or not
> > */
> >       if (!_opp_is_supported(dev, opp_table, np)) {
> >               dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> > @@ -616,7 +640,8 @@ static struct dev_pm_opp
> > *_opp_add_static_v2(struct opp_table *opp_table,
> >       if (of_property_read_bool(np, "opp-suspend")) {
> >               if (opp_table->suspend_opp) {
> >                       /* Pick the OPP with higher rate as suspend OPP */
> > -                     if (new_opp->rate > opp_table->suspend_opp->rate) {
> > +                     if (opp_compare_key(new_opp,
> > +                                         opp_table->suspend_opp) > 1) {
>
> shouldn't the condition be > 0?

Duh. Thanks. I'll fix it in the next version.

I'm guessing you tested with the fixes you pointed out?

-Saravana
