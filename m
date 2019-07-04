Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD75F34C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 09:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfGDHMR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 03:12:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44890 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfGDHMR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 03:12:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so5056012ljc.11
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2019 00:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPlvvUElEXQQu57oN9739PFcLcrOAH/jcIa/9zZOQ5E=;
        b=j0rz+JrDLOJi0Q0Z0w4IeLNlOEQ7nyvFp6SQxzfm7MxEiZuBnCeT6+F84UxYhrvol7
         e4nPwBoJcqtaWuhdkXxkoImONLRRb72JHXS2eLazfwoJxRWTVjaOirRJXIQ0N6FSLFq+
         7+AQqYbmUzYxqMoU6ljktJwgAzbsU6y4T/wsPG1nYBwrnBJP5wp88EJqxIM0MRQH3YxN
         UFEF45YdqkwOlRXtwXrb3eNk4/rPW0NG0K25kVxPrM25MTqMaP7Ob3tebvrCB2+s+e6x
         tsK1u1vfHzbXpv5Hh5wzT1Ee6PN0eTdG6mHFb9ZyOI9F2Cn3xrrgHJXnzickLoMfnPSp
         Fy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPlvvUElEXQQu57oN9739PFcLcrOAH/jcIa/9zZOQ5E=;
        b=H43x6X09xDdqBQG3D9nqsCcMp3rgkyrkHNtxTw4PAW7UTvd76ZugQERSnxy1lbbZCO
         YAMYWl3O1IolXiVOIDvE9hjz4hvaNVl1H99VVFQWIS6SZ3WnUCG/GVOAyNNPVp0uuohe
         vYGlIwacinoK9URdCWV8fHnnKPvigLopAvufj5uqJzksrfhz5zzJFdZDIe/tPS/cca4L
         0VizENzQrydDsCz8l0D6WZhjN6koq1qqPY+j1XKt2JFycTxctdhN76UeLclgHPwuDpH2
         e1MzSuI73XWIU9mvWe4crYJ+ihDiIi9IUFyVX54Jk2na+12daBEQA4po9CYEdgLIZH6v
         RJ4g==
X-Gm-Message-State: APjAAAURH2NRhYq2HVpo/RGh0gt8RKPQrKJ6Mj0PkzSWPcjxEjAasNHP
        HLK6sFDi2VpPl2NClQeRwkoujTeH+kxt75bP2gTNuA==
X-Google-Smtp-Source: APXvYqzulk5cerVVUukpdsVnaaNxRqncA8d7C/1kL9UHnjVGNJ9dDR7aISpMsndl6Vuh6+isVdCQlCFAROPp+SlgJYE=
X-Received: by 2002:a2e:1290:: with SMTP id 16mr22813195ljs.88.1562224334465;
 Thu, 04 Jul 2019 00:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-7-saravanak@google.com>
 <CAKfTPtCJFaEfvu3Dnp9WSxQEwSfY=VS+xsoQ+4P+vg7_WL0BAQ@mail.gmail.com> <CAGETcx_5gu84FOVmELPnK5uJTE0NEhxYKtdFigoXGyFtjehQvw@mail.gmail.com>
In-Reply-To: <CAGETcx_5gu84FOVmELPnK5uJTE0NEhxYKtdFigoXGyFtjehQvw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 4 Jul 2019 09:12:03 +0200
Message-ID: <CAKfTPtBHrXG1QZzcaStWCtL3nx+vE_-WKtOhjiHbjFQiw9Yk8w@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] interconnect: Add OPP table support for interconnects
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        sibis@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 3 Jul 2019 at 23:33, Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Jul 2, 2019 at 11:45 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 3 Jul 2019 at 03:10, Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Interconnect paths can have different performance points. Now that OPP
> > > framework supports bandwidth OPP tables, add OPP table support for
> > > interconnects.
> > >
> > > Devices can use the interconnect-opp-table DT property to specify OPP
> > > tables for interconnect paths. And the driver can obtain the OPP table for
> > > an interconnect path by calling icc_get_opp_table().
> >
> > The opp table of a path must come from the aggregation of OPP tables
> > of the interconnect providers.
>
> The aggregation of OPP tables of the providers is certainly the
> superset of what a path can achieve, but to say that OPPs for
> interconnect path should match that superset is an oversimplification
> of the reality in hardware.
>
> There are lots of reasons an interconnect path might not want to use
> all the available bandwidth options across all the interconnects in
> the route.
>
> 1. That particular path might not have been validated or verified
>    during the HW design process for some of the frequencies/bandwidth
>    combinations of the providers.

All these constraint are provider's constraints and not consumer's one

The consumer asks for a bandwidth according to its needs and then the
providers select the optimal bandwidth of each interconnect after
aggregating all the request and according to what OPP have been
validated

>
> 2. Similarly during parts screening in the factory, some of the
>    combinations might not have been screened and can't be guaranteed
>    to work.

As above, it's the provider's job to select the final bandwidth
according to its constraint

>
> 3. Only a certain set of bandwidth levels might make sense to use from
>    a power/performance balance given the device using it. For example:
>    - The big CPU might not want to use some of the lower bandwidths
>      but the little CPU might want to.
>    - The big CPU might not want to use some intermediate bandwidth
>      points if they don't save a lot of power compared to a higher
>      bandwidth levels, but the little CPU might want to.
>    - The little CPU might never want to use the higher set of
>      bandwidth levels since they won't be power efficient for the use
>      cases that might run on it.

These example are quite vague about the reasons why little might never
want to use higher bandwidth.
But then, if little doesn't ask high bandwidth it will not use them.

>
> 4. It might not make sense from a system level power perspective.
> Let's take an example of a path S (source) -> A -> B -> C -> D
> (destination).
>    - A supports only 2, 5, 7 and 10 GB/s. B supports 1, 2 ... 10 GB/s.
>      C supports 5 and 10 GB/s
>    - If you combine and list the superset of bandwidth levels
>      supported in that path, that'd be 1, 2, 3, ... 10 GB/s.
>    - Which set of bandwidth levels make sense will depend on the
>      hardware characteristics of the interconnects.
>    - If B is the biggest power sink, then you might want to use all 10
>      levels.
>    - If A is the biggest power sink, then you might want to use all 2,
>      5 and 10 GB/s of the levels.
>    - If C is the biggest power sink then you might only want to use 5
>      and 10 GB/s
>    - The more hops and paths you get the more convoluted this gets.
>
> 5. The design of the interconnects themselves might have an impact on
> which bandwidth levels are used.
>    - For example, the FIFO depth between two specific interconnects
>      might affect the valid bandwidth levels for a specific path.
>    - Say S1 -> A -> B -> D1, S2 -> C -> B -> D1 and S2 -> C -> D2 are
>      three paths.
>    - If C <-> B FIFO depth is small, then there might be a requirement
>      that C and B be closely performance matched to avoid system level
>      congestion due to back pressure.
>    - So S2 -> D1 path can't use all the bandwidth levels supported by
>      C-B combination.
>    - But S2 -> D2 can use all the bandwidth levels supported by C.
>    - And S1 -> D1 can use all the levels supported by A-B combination.
>

All the examples above makes sense but have to be handle by the
provider not the consumer. The consumer asks for a bandwidth according
to its constraints. Then the provider which is the driver that manages
the interconnect IP, should manage all this hardware and platform
specific stuff related to the interconnect IP in order to set the
optimal bandwidth that fit both consumer constraint and platform
specific configuration.

> These are just some of the reasons I could recollect in a few minutes.
> These are all real world cases I had to deal with in the past several
> years of dealing with scaling interconnects. I'm sure vendors and SoCs
> I'm not familiar with have other good reasons I'm not aware of.
>
> Trying to figure this all out by aggregating OPP tables of
> interconnect providers just isn't feasible nor is it efficient. The
> OPP tables for an interconnect path is describing the valid BW levels
> supported by that path and verified in hardware and makes a lot of
> sense to capture it clearly in DT.
>
> > So such kind of OPP table should be at
> > provider level but not at path level.
>
> They can also use it if they want to, but they'll probably want to use
> a frequency OPP table.
>
>
> -Saravana
>
> >
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/interconnect/core.c  | 27 ++++++++++++++++++++++++++-
> > >  include/linux/interconnect.h |  7 +++++++
> > >  2 files changed, 33 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> > > index 871eb4bc4efc..881bac80bc1e 100644
> > > --- a/drivers/interconnect/core.c
> > > +++ b/drivers/interconnect/core.c
> > > @@ -47,6 +47,7 @@ struct icc_req {
> > >   */
> > >  struct icc_path {
> > >         size_t num_nodes;
> > > +       struct opp_table *opp_table;
> > >         struct icc_req reqs[];
> > >  };
> > >
> > > @@ -313,7 +314,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
> > >  {
> > >         struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> > >         struct icc_node *src_node, *dst_node;
> > > -       struct device_node *np = NULL;
> > > +       struct device_node *np = NULL, *opp_node;
> > >         struct of_phandle_args src_args, dst_args;
> > >         int idx = 0;
> > >         int ret;
> > > @@ -381,10 +382,34 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
> > >                 dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> > >         mutex_unlock(&icc_lock);
> > >
> > > +       opp_node = of_parse_phandle(np, "interconnect-opp-table", idx);
> > > +       if (opp_node) {
> > > +               path->opp_table = dev_pm_opp_of_find_table_from_node(opp_node);
> > > +               of_node_put(opp_node);
> > > +       }
> > > +
> > > +
> > >         return path;
> > >  }
> > >  EXPORT_SYMBOL_GPL(of_icc_get);
> > >
> > > +/**
> > > + * icc_get_opp_table() - Get the OPP table that corresponds to a path
> > > + * @path: reference to the path returned by icc_get()
> > > + *
> > > + * This function will return the OPP table that corresponds to a path handle.
> > > + * If the interconnect API is disabled, NULL is returned and the consumer
> > > + * drivers will still build. Drivers are free to handle this specifically, but
> > > + * they don't have to.
> > > + *
> > > + * Return: opp_table pointer on success. NULL is returned when the API is
> > > + * disabled or the OPP table is missing.
> > > + */
> > > +struct opp_table *icc_get_opp_table(struct icc_path *path)
> > > +{
> > > +       return path->opp_table;
> > > +}
> > > +
> > >  /**
> > >   * icc_set_bw() - set bandwidth constraints on an interconnect path
> > >   * @path: reference to the path returned by icc_get()
> > > diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> > > index dc25864755ba..0c0bc55f0e89 100644
> > > --- a/include/linux/interconnect.h
> > > +++ b/include/linux/interconnect.h
> > > @@ -9,6 +9,7 @@
> > >
> > >  #include <linux/mutex.h>
> > >  #include <linux/types.h>
> > > +#include <linux/pm_opp.h>
> > >
> > >  /* macros for converting to icc units */
> > >  #define Bps_to_icc(x)  ((x) / 1000)
> > > @@ -28,6 +29,7 @@ struct device;
> > >  struct icc_path *icc_get(struct device *dev, const int src_id,
> > >                          const int dst_id);
> > >  struct icc_path *of_icc_get(struct device *dev, const char *name);
> > > +struct opp_table *icc_get_opp_table(struct icc_path *path);
> > >  void icc_put(struct icc_path *path);
> > >  int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
> > >
> > > @@ -49,6 +51,11 @@ static inline void icc_put(struct icc_path *path)
> > >  {
> > >  }
> > >
> > > +static inline struct opp_table *icc_get_opp_table(struct icc_path *path)
> > > +{
> > > +       return NULL;
> > > +}
> > > +
> > >  static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
> > >  {
> > >         return 0;
> > > --
> > > 2.22.0.410.gd8fdbe21b5-goog
> > >
