Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9522113603B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 19:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgAISfj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 13:35:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36075 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbgAISfi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 13:35:38 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so6763328oic.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2020 10:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmvSr2mzmrRq+l3ZQk2B1GL9COS1rF8Vn1oWheNtkZE=;
        b=oC6Q4lA6oU3JAgCnxLfNSA+TF08QnqsuxqJZbgwHEudI2pEIZsQ1nrGaP4A7mI0EJY
         M0S5bEhrCBW0uTR2PHP7zKG9Ngm9vY3hPp3uhle+w7AQwtvbKuyrx1BfvXBJ+LkDRHeL
         0tjHmjwYpC9W1AmPxoWMY3OQzMA2IJVcmngkURv7vtXk0WFhQFKkKS7+Jh7y3yeIqP1M
         mZKJe7ltjGyiHXY20XPpAZRFkr6QXJLy63PwWmYlBWb5nirmCCVzXYnmPfT6z/OFv11S
         6r7n6bKj4NbCpotN5hJ/cQZO5TSoZVh5ZPcsvJdmkr1kg1I2DhAvh4nI4On9Y5zSxsiG
         /NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmvSr2mzmrRq+l3ZQk2B1GL9COS1rF8Vn1oWheNtkZE=;
        b=ZskNj2G4WIh6o6c6kVIsnyQVE7zbDTqeETc8zLw+QfkGBCnWoMAZFvHd2vE4vAJ/wA
         XqL11d4D5xGYtHKEbmL0QlRx4E2CBoEmZycKfRfDVXYz1owi3HjgXraJf78Zg/29kIGs
         myOnw5G4SuUQT31GoIbiiaiy0bD7r4QUU9O8RsqmeA1/3pOE5PlW2IaTUV0SxSzXgWYU
         58HwoVgNBZoMeBup3OVXhDYghzjrpaoyi/3eL4s63WAzKKGX5QaUJJGiU5ThM69BO0la
         u3xSk487SF4uNqe+mPYri86dhIs21/L1Ndbgfq0amswvQBHU9fbzRJg/p4vAsS3Z0DNE
         1Gyw==
X-Gm-Message-State: APjAAAX1+Z8mpw/qB07AasaPniT2b3cu/V1bDIWboFmE2vNiVqkUCvtb
        sRyINcCukzWkTPt4JWrU2hr1mwavOtlIf9L2svQ95g==
X-Google-Smtp-Source: APXvYqxeg43koNnpBHaMggqdEav07DfYLsSu2xOzoP2Y/zzJzAcGHBEJCOpPO7lKIokUUug4FsP0h1PlowvFAuyIvYk=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr4437841oig.172.1578594937570;
 Thu, 09 Jan 2020 10:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com> <20191207002424.201796-3-saravanak@google.com>
 <20200108105348.p4y3s2mbuchiu4mf@vireshk-i7> <CAGETcx8QEV+_+d2yt_+bE09mi4qyHZDHPJqPiDXv_HgJPgQJoQ@mail.gmail.com>
 <20200109043108.fzvk3hp7vodtw6zy@vireshk-i7>
In-Reply-To: <20200109043108.fzvk3hp7vodtw6zy@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 9 Jan 2020 10:35:01 -0800
Message-ID: <CAGETcx_1B8AfxBuJ9Mbq8BNx-fYyP8pOnF6caN=ooyPARaaJ3A@mail.gmail.com>
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

On Wed, Jan 8, 2020 at 8:31 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-01-20, 16:58, Saravana Kannan wrote:
> > On Wed, Jan 8, 2020 at 2:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 06-12-19, 16:24, Saravana Kannan wrote:
> > > > Not all devices quantify their performance points in terms of frequency.
> > > > Devices like interconnects quantify their performance points in terms of
> > > > bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> > > > add support for parsing bandwidth OPPs from DT.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/opp/core.c | 15 +++++++++--
> > > >  drivers/opp/of.c   | 63 ++++++++++++++++++++++++++++++++--------------
> > > >  drivers/opp/opp.h  |  5 ++++
> > > >  3 files changed, 62 insertions(+), 21 deletions(-)
> > > >
> > > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > > index be7a7d332332..c79bbfac7289 100644
> > > > --- a/drivers/opp/core.c
> > > > +++ b/drivers/opp/core.c
> > > > @@ -1282,11 +1282,21 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
> > > >       return true;
> > > >  }
> > > >
> > > > +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
> > > > +{
> > > > +     if (opp1->rate != opp2->rate)
> > > > +             return opp1->rate < opp2->rate ? -1 : 1;
> > > > +     if (opp1->peak_bw != opp2->peak_bw)
> > > > +             return opp1->peak_bw < opp2->peak_bw ? -1 : 1;
> > >
> > > Please also add level here.
> >
> > I can, but I vaguely remember finding opp-levels could have
> > duplicates? Am I wrong? If so I can add the opp-level comparison too.
>
> No they can't have duplicates.
>
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
> > > >                            struct opp_table *opp_table,
> > > >                            struct list_head **head)
> > > >  {
> > > >       struct dev_pm_opp *opp;
> > > > +     int opp_cmp;
> > > >
> > > >       /*
> > > >        * Insert new OPP in order of increasing frequency and discard if
> > > > @@ -1297,12 +1307,13 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
> > > >        * loop.
> > > >        */
> > > >       list_for_each_entry(opp, &opp_table->opp_list, node) {
> > > > -             if (new_opp->rate > opp->rate) {
> > > > +             opp_cmp = opp_compare_key(new_opp, opp);
> > > > +             if (opp_cmp > 0) {
> > > >                       *head = &opp->node;
> > > >                       continue;
> > > >               }
> > > >
> > > > -             if (new_opp->rate < opp->rate)
> > > > +             if (opp_cmp < 0)
> > > >                       return 0;
> > > >
> > > >               /* Duplicate OPPs */
> > > > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > > > index 1cbb58240b80..b565da5a2b1f 100644
> > > > --- a/drivers/opp/of.c
> > > > +++ b/drivers/opp/of.c
> > > > @@ -521,6 +521,44 @@ void dev_pm_opp_of_remove_table(struct device *dev)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> > > >
> > > > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
> > > > +                      bool *rate_not_available)
> > > > +{
> > > > +     int ret;
> > > > +     u64 rate;
> > > > +     u32 bw;
> > > > +
> > > > +     ret = of_property_read_u64(np, "opp-hz", &rate);
> > > > +     if (!ret) {
> > > > +             /*
> > > > +              * Rate is defined as an unsigned long in clk API, and so
> > > > +              * casting explicitly to its type. Must be fixed once rate is 64
> > > > +              * bit guaranteed in clk API.
> > > > +              */
> > > > +             new_opp->rate = (unsigned long)rate;
> > > > +             goto out;
> > > > +     }
> > > > +
> > > > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > > > +     if (!ret) {
> > > > +             new_opp->peak_bw = bw;
> > > > +
> > > > +             if (!of_property_read_u32(np, "opp-avg-kBps", &bw))
> > > > +                     new_opp->avg_bw = bw;
> > >
> > > Maybe
> > >                 of_property_read_u32(np, "opp-avg-kBps", &new_opp->avg_bw);
> > >
> > > and same for opp-peak-kbps as well.
> >
> > But those are not u32. Is it always safe to directly read into it
> > across all endian-ness and unsigned int sizes? I get tripped up by
> > that occasionally.
>
> It may not be safe.

Ok, so I'll leave it as is then.

>
> > > > +     }
> > > > +
> > > > +out:
> > > > +     *rate_not_available = !!ret;
> > > > +     /*
> > > > +      * If ret is 0 at this point, we have already found a key. If we
> > > > +      * haven't found a key yet, then ret already has an error value. In
> > > > +      * either case, we don't need to update ret.
> > > > +      */
> > > > +     of_property_read_u32(np, "opp-level", &new_opp->level);
> > >
> > > Yes, it wasn't done earlier but we should do it now. Check level as
> > > well and treat it as any other key.
> > >
> > > I think add a preparatory patch first which does all the cleanup
> > > before bandwidth thing is added.
> >
> > Ah come on man! You are making this too painful. It's okay to add a
> > few more error checks as part of implementing a new feature. Please
> > don't make me add more patches before this.
>
> It will only make your life easier and not painful in my opinion as
> the reviews are getting mixed/confused between the new things and the
> old fields right now. With a separate patch introducing just the
> bandwidth part, it will get reviewed in maximum 1-2 versions, else you
> will keep updating the unrelated patch and I will keep reviewing it as
> it is all a single patch.
>
> It is always suggested to break patches into the smallest possible
> meaningful separate things you want to achieve. You are introducing
> something here and adding cleanup to that.

Ok I completely misunderstood (in a stupid way) what you were asking
me to do. I don't mind breaking it up into smaller patches at all.
Will do so.

> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > >  /**
> > > >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> > > >   * @opp_table:       OPP table
> > > > @@ -558,26 +596,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> > > >       if (!new_opp)
> > > >               return ERR_PTR(-ENOMEM);
> > > >
> > > > -     ret = of_property_read_u64(np, "opp-hz", &rate);
> > > > -     if (ret < 0) {
> > > > -             /* "opp-hz" is optional for devices like power domains. */
> > > > -             if (!opp_table->is_genpd) {
> > > > -                     dev_err(dev, "%s: opp-hz not found\n", __func__);
> > > > -                     goto free_opp;
> > > > -             }
> > > > -
> > > > -             rate_not_available = true;
> > > > -     } else {
> > > > -             /*
> > > > -              * Rate is defined as an unsigned long in clk API, and so
> > > > -              * casting explicitly to its type. Must be fixed once rate is 64
> > > > -              * bit guaranteed in clk API.
> > > > -              */
> > > > -             new_opp->rate = (unsigned long)rate;
> > > > +     ret = _read_opp_key(new_opp, np, &rate_not_available);
> > > > +     if (ret) {
> > > > +             dev_err(dev, "%s: opp key field not found\n", __func__);
> > > > +             goto free_opp;
> > > >       }
> > > >
> > > > -     of_property_read_u32(np, "opp-level", &new_opp->level);
> > > > -
> > > >       /* Check if the OPP supports hardware's hierarchy of versions or not */
> > > >       if (!_opp_is_supported(dev, opp_table, np)) {
> > > >               dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
> > > > @@ -616,7 +640,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> > > >       if (of_property_read_bool(np, "opp-suspend")) {
> > > >               if (opp_table->suspend_opp) {
> > > >                       /* Pick the OPP with higher rate as suspend OPP */
> > > > -                     if (new_opp->rate > opp_table->suspend_opp->rate) {
> > > > +                     if (opp_compare_key(new_opp,
> > > > +                                         opp_table->suspend_opp) > 1) {
> > >
> > > Maybe leave this place as is as we never want to compare anything else
> > > but rate.
> >
> > We do want to support suspend bandwidth.
>
> Yeah, I understood that from a later patch.
>
> > So I think I should have this
> > fix here so it works in general. Also, why not suspend opp-level?
>
> Because we don't want/need to set a specific value to the
> voltage-corners during suspend directly from the PM domain driver.
> This should happen automatically via a call from the underlying
> cpufreq or device driver.

Agreed for the example you are giving where PM domains/voltages are
dropped automatically when dropping the device freq to suspend freq.
I'm just wondering about a different scenario where if some power
domain needed to be at say 0.5v when it's suspended (no consumer using
it) to not lose state, or to come back up without brownouts, etc then
suspend OPP for PM domains might be useful. But I don't know enough
about that to speak with authority, so I'll leave it at this.

> And that's what I expected out of the interconnect thing. For example,
> say during suspend you put the interconnect or PM domains to a low
> bandwidth/level value, while the underlying device driver (which uses
> the interconnect or domain) never requested for it. Who will be
> responsible to restore the value during resume as we would be out of
> sync here.

I see this suspend-opp as a way to mark to what level the bandwidth
needs to be dropped to/brought back up from during suspend/resume by
the driver making interconnect bandwidth requests. For example, what
if the CPU -> DDR needed to be at some level to avoid suspend/resume
issues (say CPU bug with respect to timing/latencies)? In this
example, the CPU driver would be the one making bandwidth requests for
CPU -> DDR bandwidth during normal operation and during
suspend/resume. So it's basically exactly the same way it would treat
CPU freq OPP.

Btw, I don't have a strong opinion on this. But, even if we do only a
rate comparison, what does it even mean to compare rates for genpd or
BW opp tables? It's just weird. So I think it's nicer to just allow
marking any OPP as suspend OPP in any OPP table type. If there's a
need people can use it, if not, nothing is lost.

-Saravana
