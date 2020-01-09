Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD04213522C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 05:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgAIEbN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 23:31:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46023 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIEbN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 23:31:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so2559837pgk.12
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 20:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RbHjM0wg62cWEianIkLtCJW1X5EzJpKvrs71soaeoPo=;
        b=xy0GMMRi3LpivqEhjmd3Niy/3CDXdyzZc4meM+jjBObf/6hOF1cWTN7l/ZdK4B41sQ
         kxXIhOG0+DqTmlX5BoJvnO70csEiuOfsQgIWnoTF9z+xjKfquLw0G2HPYQUhRgWkZrbm
         RmERBCidfmC6Sad+LyNZ2MHl5KvGin5CuBlvbsv5fN8uj8NotL5S5Rhj1mPf9BqM56bL
         QjOfXz9hod/P/9shnZCXDktla8gpMQOqscKKwAJXk15FUSXRNrEtvJ867yY0rnV+0zV/
         3mhA29y1DdjTlw9UrctKvz3GD28jt1IwmfROrCx9vctZGTiBqMnCvOE0HWwhXxbVGstY
         PAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RbHjM0wg62cWEianIkLtCJW1X5EzJpKvrs71soaeoPo=;
        b=FmMicTd52wH+nkaeO+XQ7xR/bvDSZYBL604uKdU7IKzPVuH4P33plKKiyh8cZKjqSX
         D+de8nE5faJh+Q3Y5S+Nv0yD8WQVN47Gie4Z+iu0OYKE3gybVNWeUyu7AtfnENu9u5aR
         xypyvXbl67D9dWA9JHTHCG/emX1ErnaxDdu6STGXx4jGflBy9abue5HSquEfx4GaOne6
         K41AM7tDBcph0Y2DBB5uGYFgs5QGC72x/C29Lj506Q9CSJ+xz01OsenFDlt+wZHYPItY
         d6nsuAA4xh2/CBH506M9J6qR+YM3rkGeeoxaifyg4cFhsTgtnfwqZ2rcac9YjMrZ+sLi
         RZ+A==
X-Gm-Message-State: APjAAAXbM80ERs6tul/W7kgzYkZl3S7QrYyXROWlghamXY8MbUb4IOYx
        PIspeiBXo6kD42Y6zn9NOgjgPA==
X-Google-Smtp-Source: APXvYqyPPlKBAwfC//N4cbCcGppvgRthgjc5wns7FMRVy/ezHB4QROyqdIP/FxTlFcM7wvRUTUXQjQ==
X-Received: by 2002:a63:2ac2:: with SMTP id q185mr9172175pgq.417.1578544271706;
        Wed, 08 Jan 2020 20:31:11 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id w11sm5647434pfi.77.2020.01.08.20.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 20:31:10 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:01:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
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
Subject: Re: [PATCH v6 2/3] OPP: Add support for bandwidth OPP tables
Message-ID: <20200109043108.fzvk3hp7vodtw6zy@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-3-saravanak@google.com>
 <20200108105348.p4y3s2mbuchiu4mf@vireshk-i7>
 <CAGETcx8QEV+_+d2yt_+bE09mi4qyHZDHPJqPiDXv_HgJPgQJoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8QEV+_+d2yt_+bE09mi4qyHZDHPJqPiDXv_HgJPgQJoQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-01-20, 16:58, Saravana Kannan wrote:
> On Wed, Jan 8, 2020 at 2:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 06-12-19, 16:24, Saravana Kannan wrote:
> > > Not all devices quantify their performance points in terms of frequency.
> > > Devices like interconnects quantify their performance points in terms of
> > > bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> > > add support for parsing bandwidth OPPs from DT.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/opp/core.c | 15 +++++++++--
> > >  drivers/opp/of.c   | 63 ++++++++++++++++++++++++++++++++--------------
> > >  drivers/opp/opp.h  |  5 ++++
> > >  3 files changed, 62 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > index be7a7d332332..c79bbfac7289 100644
> > > --- a/drivers/opp/core.c
> > > +++ b/drivers/opp/core.c
> > > @@ -1282,11 +1282,21 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
> > >       return true;
> > >  }
> > >
> > > +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
> > > +{
> > > +     if (opp1->rate != opp2->rate)
> > > +             return opp1->rate < opp2->rate ? -1 : 1;
> > > +     if (opp1->peak_bw != opp2->peak_bw)
> > > +             return opp1->peak_bw < opp2->peak_bw ? -1 : 1;
> >
> > Please also add level here.
> 
> I can, but I vaguely remember finding opp-levels could have
> duplicates? Am I wrong? If so I can add the opp-level comparison too.

No they can't have duplicates.

> > > +     return 0;
> > > +}
> > > +
> > >  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
> > >                            struct opp_table *opp_table,
> > >                            struct list_head **head)
> > >  {
> > >       struct dev_pm_opp *opp;
> > > +     int opp_cmp;
> > >
> > >       /*
> > >        * Insert new OPP in order of increasing frequency and discard if
> > > @@ -1297,12 +1307,13 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
> > >        * loop.
> > >        */
> > >       list_for_each_entry(opp, &opp_table->opp_list, node) {
> > > -             if (new_opp->rate > opp->rate) {
> > > +             opp_cmp = opp_compare_key(new_opp, opp);
> > > +             if (opp_cmp > 0) {
> > >                       *head = &opp->node;
> > >                       continue;
> > >               }
> > >
> > > -             if (new_opp->rate < opp->rate)
> > > +             if (opp_cmp < 0)
> > >                       return 0;
> > >
> > >               /* Duplicate OPPs */
> > > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > > index 1cbb58240b80..b565da5a2b1f 100644
> > > --- a/drivers/opp/of.c
> > > +++ b/drivers/opp/of.c
> > > @@ -521,6 +521,44 @@ void dev_pm_opp_of_remove_table(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> > >
> > > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
> > > +                      bool *rate_not_available)
> > > +{
> > > +     int ret;
> > > +     u64 rate;
> > > +     u32 bw;
> > > +
> > > +     ret = of_property_read_u64(np, "opp-hz", &rate);
> > > +     if (!ret) {
> > > +             /*
> > > +              * Rate is defined as an unsigned long in clk API, and so
> > > +              * casting explicitly to its type. Must be fixed once rate is 64
> > > +              * bit guaranteed in clk API.
> > > +              */
> > > +             new_opp->rate = (unsigned long)rate;
> > > +             goto out;
> > > +     }
> > > +
> > > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > > +     if (!ret) {
> > > +             new_opp->peak_bw = bw;
> > > +
> > > +             if (!of_property_read_u32(np, "opp-avg-kBps", &bw))
> > > +                     new_opp->avg_bw = bw;
> >
> > Maybe
> >                 of_property_read_u32(np, "opp-avg-kBps", &new_opp->avg_bw);
> >
> > and same for opp-peak-kbps as well.
> 
> But those are not u32. Is it always safe to directly read into it
> across all endian-ness and unsigned int sizes? I get tripped up by
> that occasionally.

It may not be safe.

> > > +     }
> > > +
> > > +out:
> > > +     *rate_not_available = !!ret;
> > > +     /*
> > > +      * If ret is 0 at this point, we have already found a key. If we
> > > +      * haven't found a key yet, then ret already has an error value. In
> > > +      * either case, we don't need to update ret.
> > > +      */
> > > +     of_property_read_u32(np, "opp-level", &new_opp->level);
> >
> > Yes, it wasn't done earlier but we should do it now. Check level as
> > well and treat it as any other key.
> >
> > I think add a preparatory patch first which does all the cleanup
> > before bandwidth thing is added.
> 
> Ah come on man! You are making this too painful. It's okay to add a
> few more error checks as part of implementing a new feature. Please
> don't make me add more patches before this.

It will only make your life easier and not painful in my opinion as
the reviews are getting mixed/confused between the new things and the
old fields right now. With a separate patch introducing just the
bandwidth part, it will get reviewed in maximum 1-2 versions, else you
will keep updating the unrelated patch and I will keep reviewing it as
it is all a single patch.

It is always suggested to break patches into the smallest possible
meaningful separate things you want to achieve. You are introducing
something here and adding cleanup to that.

> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  /**
> > >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> > >   * @opp_table:       OPP table
> > > @@ -558,26 +596,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> > >       if (!new_opp)
> > >               return ERR_PTR(-ENOMEM);
> > >
> > > -     ret = of_property_read_u64(np, "opp-hz", &rate);
> > > -     if (ret < 0) {
> > > -             /* "opp-hz" is optional for devices like power domains. */
> > > -             if (!opp_table->is_genpd) {
> > > -                     dev_err(dev, "%s: opp-hz not found\n", __func__);
> > > -                     goto free_opp;
> > > -             }
> > > -
> > > -             rate_not_available = true;
> > > -     } else {
> > > -             /*
> > > -              * Rate is defined as an unsigned long in clk API, and so
> > > -              * casting explicitly to its type. Must be fixed once rate is 64
> > > -              * bit guaranteed in clk API.
> > > -              */
> > > -             new_opp->rate = (unsigned long)rate;
> > > +     ret = _read_opp_key(new_opp, np, &rate_not_available);
> > > +     if (ret) {
> > > +             dev_err(dev, "%s: opp key field not found\n", __func__);
> > > +             goto free_opp;
> > >       }
> > >
> > > -     of_property_read_u32(np, "opp-level", &new_opp->level);
> > > -
> > >       /* Check if the OPP supports hardware's hierarchy of versions or not */
> > >       if (!_opp_is_supported(dev, opp_table, np)) {
> > >               dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> > > @@ -616,7 +640,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> > >       if (of_property_read_bool(np, "opp-suspend")) {
> > >               if (opp_table->suspend_opp) {
> > >                       /* Pick the OPP with higher rate as suspend OPP */
> > > -                     if (new_opp->rate > opp_table->suspend_opp->rate) {
> > > +                     if (opp_compare_key(new_opp,
> > > +                                         opp_table->suspend_opp) > 1) {
> >
> > Maybe leave this place as is as we never want to compare anything else
> > but rate.
> 
> We do want to support suspend bandwidth.

Yeah, I understood that from a later patch.

> So I think I should have this
> fix here so it works in general. Also, why not suspend opp-level?

Because we don't want/need to set a specific value to the
voltage-corners during suspend directly from the PM domain driver.
This should happen automatically via a call from the underlying
cpufreq or device driver.

And that's what I expected out of the interconnect thing. For example,
say during suspend you put the interconnect or PM domains to a low
bandwidth/level value, while the underlying device driver (which uses
the interconnect or domain) never requested for it. Who will be
responsible to restore the value during resume as we would be out of
sync here.

-- 
viresh
