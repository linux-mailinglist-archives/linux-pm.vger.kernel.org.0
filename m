Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A928E2338AA
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 21:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgG3TH6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbgG3TH5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 15:07:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C083C06174A
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 12:07:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so3690165pje.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQqZ2MMm/8Cs5yn8qC9wISuJd6WR3cQ7bq1kU0X78gY=;
        b=njK4CKRSnqz/4kzXOci0zfsSuCFC++5HVfGahiUteSV13O0mQJuO4aCpWv6gZZbvPh
         /m8TZ8bDXUx4J2okW5Qy7Ct1B4UP5g7A9E0bqr9q2RraQGCBw/WCZPaqz+arHMQvWJpB
         ZC8tFcP2gD3NkWjH9GRLocJugT/Q5jT2htO+tAq+nwrBPNtl+6amILJRHuK/7QNHs99J
         SV3fxiK0BgmIIG2A0cotkrNX7RxZ7n/RxaNatkGjuiGPHx7yNBbe9lcz6Qe26zmMQ2at
         l0uU8JLfKul+uv8ay8RejwYPELo/WJb1or5SErxVz9ycVOIbZzEl2SOcasTlJxb597cy
         YKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQqZ2MMm/8Cs5yn8qC9wISuJd6WR3cQ7bq1kU0X78gY=;
        b=Grj0gNvpw1yz5BGGZ8KOIH4bwcnNSe+hkx6OrzfQ2vsfKydFzNKO+vsNFx+f6qp7M6
         n4A2Cz+DnhwVLXPOXityxVUThSvqF8j5lazD9Bc0UrFly28Ji4A1sepluqaSO1DDHeNb
         NI0mZIGh8reH4LxaQiXLQTRBGOK8luTIWuWlhyDPpNVhkX2KkKxQqLEkEWjhG48tx8PO
         liGxdEKIjgOl08kh+U/1XH4gUXUf4vXwHKbqI+XXBiZzip/oJm3khWMQ/mGCNZvcpnW7
         nckKPo212EmhtWhy8vGNT3F1YdTLJ2oyTuA83oc/wvBeJE/97Yqegh6Wv0LiufsR8vJ/
         eMug==
X-Gm-Message-State: AOAM531K5SlieErYHvfLiHN0Ld5VD9RQQN2bLOxPNWDlOGv8XxIqZLk3
        O1pSQLhk72LMDOILBRexYvMMFKuYa7FS3GTbzsjPZVAs
X-Google-Smtp-Source: ABdhPJxpUre/sCyL5KQFAnJGST7trqtf7jiZxfkce+e8aNDKmYfAKlPnyRtQ8OFxu8QIw05HJaoAQiMCoHz2raocdGo=
X-Received: by 2002:a17:90a:17e9:: with SMTP id q96mr526355pja.91.1596136076328;
 Thu, 30 Jul 2020 12:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200722110139.24778-1-georgi.djakov@linaro.org>
 <20200722110139.24778-2-georgi.djakov@linaro.org> <CAGETcx-QM8P2nVxcQJZz+m5Zwi==2qLfinb0FkDXJ7dNVP5bEA@mail.gmail.com>
 <e4f68ae5-5cf7-bac4-e7f2-c074327ea659@codeaurora.org>
In-Reply-To: <e4f68ae5-5cf7-bac4-e7f2-c074327ea659@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Jul 2020 12:07:20 -0700
Message-ID: <CAGETcx-i=wBB4Ooch734B0ejK6F5mGPLQ6c_K4FeFyNmMLsL=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] interconnect: Add sync state support
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>, okukatla@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 27, 2020 at 11:18 PM Mike Tipton <mdtipton@codeaurora.org> wrote:
>
> On 7/22/2020 10:07 AM, Saravana Kannan wrote:
> > On Wed, Jul 22, 2020 at 4:01 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >>
> >> The bootloaders often do some initial configuration of the interconnects
> >> in the system and we want to keep this configuration until all consumers
> >> have probed and expressed their bandwidth needs. This is because we don't
> >> want to change the configuration by starting to disable unused paths until
> >> every user had a chance to request the amount of bandwidth it needs.
> >>
> >> To accomplish this we will implement an interconnect specific sync_state
> >> callback which will synchronize (aggregate and set) the current bandwidth
> >> settings when all consumers have been probed.
> >>
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>   drivers/interconnect/core.c           | 61 +++++++++++++++++++++++++++
> >>   include/linux/interconnect-provider.h |  5 +++
> >>   2 files changed, 66 insertions(+)
> >>
> >> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> >> index e5f998744501..0c4e38d9f1fa 100644
> >> --- a/drivers/interconnect/core.c
> >> +++ b/drivers/interconnect/core.c
> >> @@ -26,6 +26,8 @@
> >>
> >>   static DEFINE_IDR(icc_idr);
> >>   static LIST_HEAD(icc_providers);
> >> +static int providers_count;
> >> +static bool synced_state;
> >>   static DEFINE_MUTEX(icc_lock);
> >>   static struct dentry *icc_debugfs_dir;
> >>
> >> @@ -255,6 +257,12 @@ static int aggregate_requests(struct icc_node *node)
> >>                          continue;
> >>                  p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
> >>                               &node->avg_bw, &node->peak_bw);
> >> +
> >> +               /* during boot use the initial bandwidth as a floor value */
> >> +               if (!synced_state) {
> >> +                       node->avg_bw = max(node->avg_bw, node->init_avg);
> >> +                       node->peak_bw = max(node->peak_bw, node->init_peak);
> >> +               }
> >
> > Sorry I didn't reply earlier.
> >
> > I liked your previous approach with the get_bw ops. The v2 approach
> > forces every interconnect provider driver to set up these values even
> > if they are okay with just maxing out the bandwidth. Also, if they can
> > actually query their hardware, this adds additional steps for them.
>
> The problem with using something like get_bw() is that while we can
> dynamically query the HW, we have far less granularity in HW than we
> have nodes in the framework. We vote at BCM-level granularity, but each
> BCM can have many nodes. For example, the sdm845 CN0 BCM has 47 nodes.
> If we implement get_bw() generically, then it would return the BW for
> each node, which would be the queried BCM vote scaled to account for
> differences in BCM/node widths. While this could be useful in general as
> an informational callback, we wouldn't want to use this as a proxy for
> our initial BW vote requirements. For CN0, we wouldn't want or need to
> vote 47 times for the same CN0 BCM. Each of the 47 node requests would
> result in the same BCM request.

Firstly most people in the list don't know what BCM means. Also, all
of this is your provider driver specific issues. If you are exposing
more nodes than available HW granularity, then you might want to
question why it needs to be done (probably to make aggregation easier
for the driver). If it's needed, then optimize your get/set() calls by
caching the value in an internal variable so that you don't send a
request to your BCM if you haven't changed the value since the last
request. This is not a reason to not have get_bw() calls at the
framework level. Other providers might support it and it'd make their
lives easier.

> All we'd really need is a single node per-BCM to serve as the proxy
> node. We'd query the HW, scale the queried value for the chosen proxy
> node, and set init_avg/init_peak appropriately. This would save a lot of
> unnecessary votes. Based on the current implementation, the set() call
> in icc_node_add() for initial BW wouldn't trigger any actual HW requests
> since we only queue BCMs that require updating in the aggregate()
> callback. However, the set() call in icc_sync_state() would, since we
> re-aggregate each node that has a non-zero init_avg/init_peak.

Having a fake "proxy node" seems like a bad internal design. Also,
have you timed the cost of these calls to justify your concern? If you
cache the values after aggregation and check before you send it down
to a "BCM", at worst you get one additional call to rpmh per BCM due
to this feature. I'm guessing any time delta would be lost as noise
compared to the boot up time.

> There's nothing stopping us from implementing get_bw() as if it were
> get_initial_bw(), but that only works until the framework decides to use
> get_bw() for more things than just the initial vote. I suppose we could
> also just have a "get_initial_bw" callback, but it only needs to be
> called once, so doesn't necessarily need a callback as opposed to
> additional init_avg/init_peak members in the icc_node struct.

The benefit of "ops" vs "fill up these variables" is that you can
differentiate between "I don't care, framework can decide" vs "I need
it to be 0". Put another way, there's no way to say "I don't care" if
you use variables. And by default drivers that don't really care (as
in, okay if it's set to INT_MAX) shouldn't have to do extra code/work.

Long story short, there's nothing wrong with get_bw(). If your
specific driver needs to optimize the calls to your RPMH hardware,
that should be hidden inside your driver.

-Saravana
