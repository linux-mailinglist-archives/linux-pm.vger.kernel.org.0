Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7377F6A01C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 02:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbfGPA4W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 20:56:22 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41509 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732407AbfGPA4V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 20:56:21 -0400
Received: by mail-ot1-f48.google.com with SMTP id o101so19145103ota.8
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2019 17:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUZLyniF7fu1RXAeXxl0HstRsTysKzhc0o2JtfQ94P4=;
        b=Z9+u09tzea1uOfCb4cZh34YuRGCNmbZZ25KT3cUeRV7V9vgid9Xme6o5xb5VvqLYjI
         TTY0zNrHwQLlnffMEVNZyxk0Jpp2O0IsF5SF8RbzgeV+slNvQk7GDc/YgldhuljoZpOQ
         HujD5fwF8l3cWMX1wipwarnFpBIeEW9k6G/odNytRe03bDo3LBY9mjhx6/qOXRSkn01x
         b7GDURI+RRujxAL5MY5+Lc/oatH1kK7DoA/tqNp4ctdoRnmNzQvV9KY5u4yflUBbEWMb
         8XyOQfUvRQQhXAmroD4iR/y0UDcueIDEXDptFcNwwExPZB4ZLphd3m4jiLaqGwmSRMuB
         EB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUZLyniF7fu1RXAeXxl0HstRsTysKzhc0o2JtfQ94P4=;
        b=RGi3LnWEbhgnFzneZsZbw6Qy9brRhc87iHl7E2F5ybB43Uc5vkrAAUSSeWsfjb8PRO
         +X/bHfMqy5lRJ4qiGLuk3FkXUA8vPYSdym25Rq1OA7jUoKOwK91VSueyzRsKUmXn9fWx
         ibpyOp9mcrB+XxTd7oRMQE6qjrS8b27q37WjZzwO4kSfK5wJRy5DW177uTIpQvoN6rDB
         LGI4bYFzRYDUMniA7amIsIWGOFE41+Y0q4VodYxR6onLtwfwYnqXfbU9s/Yn40OpWZmo
         85ls2jVvXqlDn7C5uUgSItR3N1CIdalZqoNhrwtU8z7S+LvPLupPGRdTuD9whIgcpxN0
         DYZg==
X-Gm-Message-State: APjAAAXM8kp+vMRqmyg7ADVxS7lKN7aKAWLwYInB3yipH/LL2ftfUOkK
        bui6yAUMeTMELCuAvNZ4sPdr3Tbp//YZpWva+RXvAg==
X-Google-Smtp-Source: APXvYqz7RJYLmsEIk072vbzfVP+LEjuR9juOg8kqZoveJ+g/uUgIcMsIUrUuIym83WxTmd40sgSDRHaqe5PYFOl1PqQ=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr23637672otr.231.1563238579054;
 Mon, 15 Jul 2019 17:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-7-saravanak@google.com>
 <CAKfTPtCJFaEfvu3Dnp9WSxQEwSfY=VS+xsoQ+4P+vg7_WL0BAQ@mail.gmail.com>
 <CAGETcx_5gu84FOVmELPnK5uJTE0NEhxYKtdFigoXGyFtjehQvw@mail.gmail.com>
 <CAKfTPtBHrXG1QZzcaStWCtL3nx+vE_-WKtOhjiHbjFQiw9Yk8w@mail.gmail.com>
 <CAGETcx912kpi9DejPCoWMUF5AMm4=o1C0C45zwMfUy6aX_jcYg@mail.gmail.com>
 <CAKfTPtBngOT__TfmHXmmim-b9YhExOOvwVRaxYM9g9M6ffr_zQ@mail.gmail.com>
 <CAGETcx90WC2o+ZmkyhOPp1xJbfSk1wpAv2RA-4VgnhJfcsmJiA@mail.gmail.com> <CAKfTPtBE7e+hc55TY43JC0XPONvrS4FBPkZcRZ4EbzyCJKNhfg@mail.gmail.com>
In-Reply-To: <CAKfTPtBE7e+hc55TY43JC0XPONvrS4FBPkZcRZ4EbzyCJKNhfg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 15 Jul 2019 17:55:42 -0700
Message-ID: <CAGETcx_w=yVDiwVWT1+mmoj54FuLC37Eh2E-s0BfrtEa0AqEjw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] interconnect: Add OPP table support for interconnects
To:     Vincent Guittot <vincent.guittot@linaro.org>
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

On Mon, Jul 15, 2019 at 1:16 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 9 Jul 2019 at 21:03, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Jul 9, 2019 at 12:25 AM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Sun, 7 Jul 2019 at 23:48, Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Thu, Jul 4, 2019 at 12:12 AM Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > On Wed, 3 Jul 2019 at 23:33, Saravana Kannan <saravanak@google.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 2, 2019 at 11:45 PM Vincent Guittot
> > > > > > <vincent.guittot@linaro.org> wrote:
> > > > > > >
> > > > > > > On Wed, 3 Jul 2019 at 03:10, Saravana Kannan <saravanak@google.com> wrote:
> > > > > > > >
> > > > > > > > Interconnect paths can have different performance points. Now that OPP
> > > > > > > > framework supports bandwidth OPP tables, add OPP table support for
> > > > > > > > interconnects.
> > > > > > > >
> > > > > > > > Devices can use the interconnect-opp-table DT property to specify OPP
> > > > > > > > tables for interconnect paths. And the driver can obtain the OPP table for
> > > > > > > > an interconnect path by calling icc_get_opp_table().
> > > > > > >
> > > > > > > The opp table of a path must come from the aggregation of OPP tables
> > > > > > > of the interconnect providers.
> > > > > >
> > > > > > The aggregation of OPP tables of the providers is certainly the
> > > > > > superset of what a path can achieve, but to say that OPPs for
> > > > > > interconnect path should match that superset is an oversimplification
> > > > > > of the reality in hardware.
> > > > > >
> > > > > > There are lots of reasons an interconnect path might not want to use
> > > > > > all the available bandwidth options across all the interconnects in
> > > > > > the route.
> > > > > >
> > > > > > 1. That particular path might not have been validated or verified
> > > > > >    during the HW design process for some of the frequencies/bandwidth
> > > > > >    combinations of the providers.
> > > > >
> > > > > All these constraint are provider's constraints and not consumer's one
> > > > >
> > > > > The consumer asks for a bandwidth according to its needs and then the
> > > > > providers select the optimal bandwidth of each interconnect after
> > > > > aggregating all the request and according to what OPP have been
> > > > > validated
> > > >
> > > > Not really. The screening can be a consumer specific issue. The
> > > > consumer IP itself might have some issue with using too low of a
> > > > bandwidth or bandwidth that's not within some range. It should not be
> > >
> > > How can an IP ask for not enough bandwidth ?
> > > It asks the needed bandwidth based on its requirements
> >
> > The "enough bandwidth" is not always obvious. It's only for very
> > simple cases that you can calculate the required bandwidth. Even for
> > cases that you think might be "obvious/easy" aren't always easy.
> >
> > For example, you'd think a display IP would have a fixed bandwidth
> > requirement for a fixed resolution screen. But that's far from the
> > truth. It can also change as the number of layers change per frame.
> > For video decoder/encoder, it depends on how well the frames compress
> > with a specific compression scheme.
> > So the "required" bandwidth is often a heuristic based on the IP
> > frequency or traffic measurement.
> >
> > But that's not even the point I was making in this specific "bullet".
> >
> > A hardware IP might be screen/verified with only certain bandwidth
> > levels. Or it might have hardware bugs that prevent it from using
> > lower bandwidths even though it's technically sufficient. We need a
> > way to capture that per path. This is not even a fictional case. This
> > has been true multiple times over widely used IPs.
>
> here you are mixing HW constraint on the soc and OPP screening with
> bandwidth request from consumer
> ICC framework is about getting bandwidth request not trying to fix
> some HW/voltage dependency of the SoC
>
> >
> > > > the provider's job to take into account all the IP that might be
> > > > connected to the interconnects. If the interconnect HW itself didn't
> > >
> > > That's not what I'm saying. The provider knows which bandwidth the
> > > interconnect can provide as it is the ones which configures it. So if
> > > the interconnect has a finite number of bandwidth point based probably
> > > on the possible clock frequency and others config of the interconnect,
> > > it selects the best final config after aggregating the request of the
> > > consumer.
> >
> > I completely agree with this. What you are stating above is how it
> > should work and that's the whole point of the interconnect framework.
> >
> > But this is orthogonal to the point I'm making.
>
> It's not orthogonal because you want to add a OPP table pointer in the
> ICC path structure to fix your platform HW constraint whereas it's not
> the purpose of the framework IMO
>
> >
> > > > change, the provider driver shouldn't need to change. By your
> > > > definition, a provider driver will have to account for all the
> > > > possible bus masters that might be connected to it across all SoCs.
> > >
> > > you didn't catch my point
> >
> > Same. I think we are talking over each other. Let me try again.
> >
> > You are trying to describe how and interconnect provider and framework
> > should work. There's no disagreement there.
> >
> > My point is that consumers might not want to or can not always use all
> > the available bandwidth levels offered by the providers. There can be
> > many reasons for that (which is what I listed in my earlier emails)
> > and we need a good and generic way to capture that so that everyone
> > isn't trying to invent their own property.
>
> And my point is that you want to describe some platform or even UCs
> specific constraint in the ICC framework which is not the place to do.
>
> If the consumers might not want to use all available bandwidth because
> this is not power efficient as an example, this should be describe
> somewhere else to express  that there is a shared power domain
> between some devices and we shoudl ensure that all devices in this
> power domain should use the  Optimal Operating Point (optimal freq for
> a voltage)

My patch series has nothing to do with shared power domains. I think
the examples have made it amply clear.

> ICC framework describes the bandwidth request that are expressed by
> the consumers for the current running state of their IP but it doesn't
> reflect the fact that on platform A, the consumer should use bandwidth
> X because it will select a voltage level of a shared power domain that
> is optimized for the other devices B, C ... . It's up to the provider
> to know HW details of the bus that it drives and to make such
> decision;  the consumer should always request the same

The change to ICC framework is practically just this. I don't have any
future changes planned for the ICC framework. This is the entirety of
it.

+       opp_node = of_parse_phandle(np, "interconnect-opp-table", idx);
+       if (opp_node) {
+               path->opp_table = dev_pm_opp_of_find_table_from_node(opp_node);
+               of_node_put(opp_node);
+       }

It's quite a stretch and bit hyperbolic to say this one change is
getting ICC framework to do all the things you claim above.

It's literally a simple helper function so that the consumer doesn't
have to make assumptions about indices and it's a bit more explicit
about which OPP table of the device (a device can have multiple OPP
tables) corresponds to which ICC path.

Going by your extreme argument, one can also claim that it's not the
ICC framework's job to make it easy for consumers to figure out the
source/destination endpoints or give them names and delete the
interconnect and interconnect-names properties. That's clearly just as
absurd a claim.


-Saravana

> > > > That's not good design nor is it scalable.
> > > >
> > > > > >
> > > > > > 2. Similarly during parts screening in the factory, some of the
> > > > > >    combinations might not have been screened and can't be guaranteed
> > > > > >    to work.
> > > > >
> > > > > As above, it's the provider's job to select the final bandwidth
> > > > > according to its constraint
> > > >
> > > > Same reply as above.
> > > >
> > > > > >
> > > > > > 3. Only a certain set of bandwidth levels might make sense to use from
> > > > > >    a power/performance balance given the device using it. For example:
> > > > > >    - The big CPU might not want to use some of the lower bandwidths
> > > > > >      but the little CPU might want to.
> > > > > >    - The big CPU might not want to use some intermediate bandwidth
> > > > > >      points if they don't save a lot of power compared to a higher
> > > > > >      bandwidth levels, but the little CPU might want to.
> > > > > >    - The little CPU might never want to use the higher set of
> > > > > >      bandwidth levels since they won't be power efficient for the use
> > > > > >      cases that might run on it.
> > > > >
> > > > > These example are quite vague about the reasons why little might never
> > > > > want to use higher bandwidth.
> > > >
> > > > How is it vague? I just said because of power/performance balance.
> > > >
> > > > > But then, if little doesn't ask high bandwidth it will not use them.
> > > >
> > > > If you are running a heuristics based algorithm to pick bandwidth,
> > > > this is how it'll know NOT to use some of the bandwidth levels.
> > >
> > > so you want to set a bandwidth according to the cpu frequency which is
> > > what has been proposed in other thread
> >
> > Nope, that's just one heuristic. Often times it's based on hardware
> > monitors measuring interconnect activity. If you go look at the SDM845
> > in a Pixel 3, almost nothing is directly tied to the CPU frequency.
> >
> > Even if you are scaling bandwidth based on other hardware
> > measurements, you might want to avoid some bandwidth level provided by
> > the interconnect providers because it's suboptimal.
> >
> > For example, when making bandwidth votes to accommodate the big CPUs,
> > you might never want to use some of the lower bandwidth levels because
> > they are not power efficient for any CPU frequency or any bandwidth
> > level. Because at those levels the memory/interconnect is so slow that
> > it has a non-trivial utilization increase (because the CPU is
> > stalling) of the big CPUs.
> >
> > Again, this is completely different from what the providers/icc
> > framework does. Which is, once the request is made, they aggregate and
> > set the actual interconnect frequencies correctly.
> >
> > > >
> > > > > >
> > > > > > 4. It might not make sense from a system level power perspective.
> > > > > > Let's take an example of a path S (source) -> A -> B -> C -> D
> > > > > > (destination).
> > > > > >    - A supports only 2, 5, 7 and 10 GB/s. B supports 1, 2 ... 10 GB/s.
> > > > > >      C supports 5 and 10 GB/s
> > > > > >    - If you combine and list the superset of bandwidth levels
> > > > > >      supported in that path, that'd be 1, 2, 3, ... 10 GB/s.
> > > > > >    - Which set of bandwidth levels make sense will depend on the
> > > > > >      hardware characteristics of the interconnects.
> > > > > >    - If B is the biggest power sink, then you might want to use all 10
> > > > > >      levels.
> > > > > >    - If A is the biggest power sink, then you might want to use all 2,
> > > > > >      5 and 10 GB/s of the levels.
> > > > > >    - If C is the biggest power sink then you might only want to use 5
> > > > > >      and 10 GB/s
> > > > > >    - The more hops and paths you get the more convoluted this gets.
> > > > > >
> > > > > > 5. The design of the interconnects themselves might have an impact on
> > > > > > which bandwidth levels are used.
> > > > > >    - For example, the FIFO depth between two specific interconnects
> > > > > >      might affect the valid bandwidth levels for a specific path.
> > > > > >    - Say S1 -> A -> B -> D1, S2 -> C -> B -> D1 and S2 -> C -> D2 are
> > > > > >      three paths.
> > > > > >    - If C <-> B FIFO depth is small, then there might be a requirement
> > > > > >      that C and B be closely performance matched to avoid system level
> > > > > >      congestion due to back pressure.
> > > > > >    - So S2 -> D1 path can't use all the bandwidth levels supported by
> > > > > >      C-B combination.
> > > > > >    - But S2 -> D2 can use all the bandwidth levels supported by C.
> > > > > >    - And S1 -> D1 can use all the levels supported by A-B combination.
> > > > > >
> > > > >
> > > > > All the examples above makes sense but have to be handle by the
> > > > > provider not the consumer. The consumer asks for a bandwidth according
> > > > > to its constraints. Then the provider which is the driver that manages
> > > > > the interconnect IP, should manage all this hardware and platform
> > > > > specific stuff related to the interconnect IP in order to set the
> > > > > optimal bandwidth that fit both consumer constraint and platform
> > > > > specific configuration.
> > > >
> > > > Sure, but the provider itself can have interconnect properties to
> > > > indicate which other interconnects it's tied to. And the provider will
> > > > still need the interconnect-opp-table to denote which bandwidth levels
> > > > are sensible to use with each of its connections.
> >
> > You seem to have missed this comment.
> >
> > Thanks,
> > Saravana
> >
> > > > So in some instances the interconnect-opp-table covers the needs of
> > > > purely consumers and in some instances purely providers. But in either
> > > > case, it's still needed to describe the hardware properly.
> > > >
> > > > -Saravana
> > > >
> > > > > > These are just some of the reasons I could recollect in a few minutes.
> > > > > > These are all real world cases I had to deal with in the past several
> > > > > > years of dealing with scaling interconnects. I'm sure vendors and SoCs
> > > > > > I'm not familiar with have other good reasons I'm not aware of.
> > > > > >
> > > > > > Trying to figure this all out by aggregating OPP tables of
> > > > > > interconnect providers just isn't feasible nor is it efficient. The
> > > > > > OPP tables for an interconnect path is describing the valid BW levels
> > > > > > supported by that path and verified in hardware and makes a lot of
> > > > > > sense to capture it clearly in DT.
> > > > > >
> > > > > > > So such kind of OPP table should be at
> > > > > > > provider level but not at path level.
> > > > > >
> > > > > > They can also use it if they want to, but they'll probably want to use
> > > > > > a frequency OPP table.
> > > > > >
> > > > > >
> > > > > > -Saravana
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > > > ---
> > > > > > > >  drivers/interconnect/core.c  | 27 ++++++++++++++++++++++++++-
> > > > > > > >  include/linux/interconnect.h |  7 +++++++
> > > > > > > >  2 files changed, 33 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> > > > > > > > index 871eb4bc4efc..881bac80bc1e 100644
> > > > > > > > --- a/drivers/interconnect/core.c
> > > > > > > > +++ b/drivers/interconnect/core.c
> > > > > > > > @@ -47,6 +47,7 @@ struct icc_req {
> > > > > > > >   */
> > > > > > > >  struct icc_path {
> > > > > > > >         size_t num_nodes;
> > > > > > > > +       struct opp_table *opp_table;
> > > > > > > >         struct icc_req reqs[];
> > > > > > > >  };
> > > > > > > >
> > > > > > > > @@ -313,7 +314,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
> > > > > > > >  {
> > > > > > > >         struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> > > > > > > >         struct icc_node *src_node, *dst_node;
> > > > > > > > -       struct device_node *np = NULL;
> > > > > > > > +       struct device_node *np = NULL, *opp_node;
> > > > > > > >         struct of_phandle_args src_args, dst_args;
> > > > > > > >         int idx = 0;
> > > > > > > >         int ret;
> > > > > > > > @@ -381,10 +382,34 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
> > > > > > > >                 dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> > > > > > > >         mutex_unlock(&icc_lock);
> > > > > > > >
> > > > > > > > +       opp_node = of_parse_phandle(np, "interconnect-opp-table", idx);
> > > > > > > > +       if (opp_node) {
> > > > > > > > +               path->opp_table = dev_pm_opp_of_find_table_from_node(opp_node);
> > > > > > > > +               of_node_put(opp_node);
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +
> > > > > > > >         return path;
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL_GPL(of_icc_get);
> > > > > > > >
> > > > > > > > +/**
> > > > > > > > + * icc_get_opp_table() - Get the OPP table that corresponds to a path
> > > > > > > > + * @path: reference to the path returned by icc_get()
> > > > > > > > + *
> > > > > > > > + * This function will return the OPP table that corresponds to a path handle.
> > > > > > > > + * If the interconnect API is disabled, NULL is returned and the consumer
> > > > > > > > + * drivers will still build. Drivers are free to handle this specifically, but
> > > > > > > > + * they don't have to.
> > > > > > > > + *
> > > > > > > > + * Return: opp_table pointer on success. NULL is returned when the API is
> > > > > > > > + * disabled or the OPP table is missing.
> > > > > > > > + */
> > > > > > > > +struct opp_table *icc_get_opp_table(struct icc_path *path)
> > > > > > > > +{
> > > > > > > > +       return path->opp_table;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  /**
> > > > > > > >   * icc_set_bw() - set bandwidth constraints on an interconnect path
> > > > > > > >   * @path: reference to the path returned by icc_get()
> > > > > > > > diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> > > > > > > > index dc25864755ba..0c0bc55f0e89 100644
> > > > > > > > --- a/include/linux/interconnect.h
> > > > > > > > +++ b/include/linux/interconnect.h
> > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > >
> > > > > > > >  #include <linux/mutex.h>
> > > > > > > >  #include <linux/types.h>
> > > > > > > > +#include <linux/pm_opp.h>
> > > > > > > >
> > > > > > > >  /* macros for converting to icc units */
> > > > > > > >  #define Bps_to_icc(x)  ((x) / 1000)
> > > > > > > > @@ -28,6 +29,7 @@ struct device;
> > > > > > > >  struct icc_path *icc_get(struct device *dev, const int src_id,
> > > > > > > >                          const int dst_id);
> > > > > > > >  struct icc_path *of_icc_get(struct device *dev, const char *name);
> > > > > > > > +struct opp_table *icc_get_opp_table(struct icc_path *path);
> > > > > > > >  void icc_put(struct icc_path *path);
> > > > > > > >  int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
> > > > > > > >
> > > > > > > > @@ -49,6 +51,11 @@ static inline void icc_put(struct icc_path *path)
> > > > > > > >  {
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static inline struct opp_table *icc_get_opp_table(struct icc_path *path)
> > > > > > > > +{
> > > > > > > > +       return NULL;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
> > > > > > > >  {
> > > > > > > >         return 0;
> > > > > > > > --
> > > > > > > > 2.22.0.410.gd8fdbe21b5-goog
> > > > > > > >
> > > > >
> > > > > --
> > > > > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> > > > >
