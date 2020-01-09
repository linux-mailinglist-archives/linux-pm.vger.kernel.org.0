Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47041350B6
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 01:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgAIA7J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 19:59:09 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45191 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgAIA7J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 19:59:09 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so5510411otp.12
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 16:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuIZsqo9UeRSk4/TnTRSL/BMf1IA3NGdXRfpceX2Xks=;
        b=FNUYrsna8KPM2qp/hcRah+OlZdZO4XxDpwHNv24Fud+r01fSgWsfiMj7N9F9dqS83h
         BSmrUkUMjQSPCiHbR9gc55NXMsSMR9H1EWBwKh+eXPdgUht7fFdYKuMYI13leXvHKXMP
         mLFLlCp53kwfgHes5YJnvv1Gbj4LsO6gRaItIvoZpQ2LrgieGYNATzU3J9HZySvNQVOc
         Wi93OIBrGd84cCUBofXEUsnDFc1MLxsiF245E96Y7z0s2JM7j3YScf3kcnHPCIakSCEh
         FbAGWub18fUjBDKjwxqNdc+X3wCWICesdTI1yTbzGT/oCroJBYyBhLR2M8fkyI6g33AC
         8kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuIZsqo9UeRSk4/TnTRSL/BMf1IA3NGdXRfpceX2Xks=;
        b=WFAyGncWPoHE7EpHF7/Y3xOIEFZBqEGEuKEobC/sOxzqby1ggtKWFk6uEECMX98crL
         WadpJzMae7qYjwZbtr7dCkwVqrs7LQU0rOaiaKw0FknzkH9efN7ibLFCIB7kw3nDQwhF
         0DQbcXxKf0mCcXQMIjq20mzQYuueUUV2Q1q+ebMIjVTXOC8lYveBwFq0rzDlEEbIJPro
         6s2TZNSMTCh3MMUU+lNHnjz8SZZsbWMjF7xBZXw6ew+5rYpqU3/KwbPQj9m0ecRLchuG
         DY+qn4atPufO15IhNspyYepHgPAkyaVvr/DDY0wUmbgt/Rb+JZLue5E/GWHYlTmsIisk
         RRfA==
X-Gm-Message-State: APjAAAUTyovSAZWspRsuxz4yQ60ql/fNy6dllOuYr8ga5D4Ik2fnAqjL
        21J9x9+HNd1lrhQLtpt35jF/mbMZFEZX0i1JHL4pPQ==
X-Google-Smtp-Source: APXvYqy4xJojn/QVQEgwIJnTyqqrQjpAVhzjN+VIkhCK44nKFJGM0ZB9NDNlm/542WrsAy5qRkdkgHqIAVAy4b7a3Fo=
X-Received: by 2002:a9d:70d9:: with SMTP id w25mr6757437otj.231.1578531548163;
 Wed, 08 Jan 2020 16:59:08 -0800 (PST)
MIME-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com> <20191207002424.201796-3-saravanak@google.com>
 <20200108105348.p4y3s2mbuchiu4mf@vireshk-i7>
In-Reply-To: <20200108105348.p4y3s2mbuchiu4mf@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Jan 2020 16:58:32 -0800
Message-ID: <CAGETcx8QEV+_+d2yt_+bE09mi4qyHZDHPJqPiDXv_HgJPgQJoQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] OPP: Add support for bandwidth OPP tables
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
        Sibi Sankar <sibis@codeaurora.org>,
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

On Wed, Jan 8, 2020 at 2:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 06-12-19, 16:24, Saravana Kannan wrote:
> > Not all devices quantify their performance points in terms of frequency.
> > Devices like interconnects quantify their performance points in terms of
> > bandwidth. We need a way to represent these bandwidth levels in OPP. So,
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
> > @@ -1282,11 +1282,21 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
> >       return true;
> >  }
> >
> > +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
> > +{
> > +     if (opp1->rate != opp2->rate)
> > +             return opp1->rate < opp2->rate ? -1 : 1;
> > +     if (opp1->peak_bw != opp2->peak_bw)
> > +             return opp1->peak_bw < opp2->peak_bw ? -1 : 1;
>
> Please also add level here.

I can, but I vaguely remember finding opp-levels could have
duplicates? Am I wrong? If so I can add the opp-level comparison too.

> > +     return 0;
> > +}
> > +
> >  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
> >                            struct opp_table *opp_table,
> >                            struct list_head **head)
> >  {
> >       struct dev_pm_opp *opp;
> > +     int opp_cmp;
> >
> >       /*
> >        * Insert new OPP in order of increasing frequency and discard if
> > @@ -1297,12 +1307,13 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
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
> > @@ -521,6 +521,44 @@ void dev_pm_opp_of_remove_table(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> >
> > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
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
>
> Maybe
>                 of_property_read_u32(np, "opp-avg-kBps", &new_opp->avg_bw);
>
> and same for opp-peak-kbps as well.

But those are not u32. Is it always safe to directly read into it
across all endian-ness and unsigned int sizes? I get tripped up by
that occasionally.

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
>
> Yes, it wasn't done earlier but we should do it now. Check level as
> well and treat it as any other key.
>
> I think add a preparatory patch first which does all the cleanup
> before bandwidth thing is added.

Ah come on man! You are making this too painful. It's okay to add a
few more error checks as part of implementing a new feature. Please
don't make me add more patches before this.

> > +
> > +     return ret;
> > +}
> > +
> >  /**
> >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> >   * @opp_table:       OPP table
> > @@ -558,26 +596,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
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
> > +             dev_err(dev, "%s: opp key field not found\n", __func__);
> > +             goto free_opp;
> >       }
> >
> > -     of_property_read_u32(np, "opp-level", &new_opp->level);
> > -
> >       /* Check if the OPP supports hardware's hierarchy of versions or not */
> >       if (!_opp_is_supported(dev, opp_table, np)) {
> >               dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> > @@ -616,7 +640,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> >       if (of_property_read_bool(np, "opp-suspend")) {
> >               if (opp_table->suspend_opp) {
> >                       /* Pick the OPP with higher rate as suspend OPP */
> > -                     if (new_opp->rate > opp_table->suspend_opp->rate) {
> > +                     if (opp_compare_key(new_opp,
> > +                                         opp_table->suspend_opp) > 1) {
>
> Maybe leave this place as is as we never want to compare anything else
> but rate.

We do want to support suspend bandwidth. So I think I should have this
fix here so it works in general. Also, why not suspend opp-level?

> >                               opp_table->suspend_opp->suspend = false;
> >                               new_opp->suspend = true;
> >                               opp_table->suspend_opp = new_opp;
> > diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> > index 01a500e2c40a..0def3154d07b 100644
> > --- a/drivers/opp/opp.h
> > +++ b/drivers/opp/opp.h
> > @@ -57,6 +57,8 @@ extern struct list_head opp_tables;
> >   * @suspend: true if suspend OPP
> >   * @pstate: Device's power domain's performance state.
> >   * @rate:    Frequency in hertz
> > + * @peak_bw: Peak bandwidth in kilobytes per second
> > + * @avg_bw:  Average bandwidth in kilobytes per second
> >   * @level:   Performance level
> >   * @supplies:        Power supplies voltage/current values
> >   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
> > @@ -78,6 +80,8 @@ struct dev_pm_opp {
> >       bool suspend;
> >       unsigned int pstate;
> >       unsigned long rate;
> > +     unsigned int peak_bw;
> > +     unsigned int avg_bw;
> >       unsigned int level;
> >
> >       struct dev_pm_opp_supply *supplies;
> > @@ -213,6 +217,7 @@ struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_
> >  void _dev_pm_opp_find_and_remove_table(struct device *dev);
> >  struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
> >  void _opp_free(struct dev_pm_opp *opp);
> > +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
>
> make it _opp_compare_key() instead.

Ack.

-Saravana
