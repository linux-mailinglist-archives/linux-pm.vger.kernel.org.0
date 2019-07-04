Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 045575F1AF
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 05:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfGDDDD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 23:03:03 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38500 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfGDDDC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 23:03:02 -0400
Received: by mail-oi1-f177.google.com with SMTP id v186so3813736oie.5
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2019 20:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1KdKTuWqrDXAP3v6txFR4h07qa+wUhZFnR5tE4YYSQ=;
        b=hUVB9KGT+H7UQfNOUX3f8B4+lpC0WQ7jkigFqMapZ34Gc3QrlBEgVm05bX452lh2mK
         5V8JABVi6UCATdXj0mw6GBIUkeEFZ7m6l9D8Ox7Y1BRx/3oLtliRfL0gOYrpwc3R2ud8
         DfRRN4sSLGCAe3EpsWDgNHrHEOYoKdB/N42af6R9484GB8Q1zu1unU3LkYecOQ5cXBJI
         Cu987fs1LoZ4TeAbolIrNTigcIHco5X8zZslJO/g5441i+XB0NKsXDf4FmdC5AftAAEP
         Cj1Nvt3YZEZ47Go2FCo590RcvnQiv/OJEvK7wwXdsecvMhHo2vRyVbQMlyDkZNDiO+5d
         Jt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1KdKTuWqrDXAP3v6txFR4h07qa+wUhZFnR5tE4YYSQ=;
        b=ugN/hL0bbu5uK7rUfYF0lWzeJYUoi7NgXvtyvC0JcqcoaiYnOC1pkObIZqn+ZVjQL5
         Divgv921e0N7dBQZVT15f3s4r2YNhm44UwgIEkjyPJ2fj74TKmzPjejelu08R65M5gas
         K1ds/UBWnC5+lLvuYSZ1Cd1swlpxZEFNGNGEF4kRof4ppKnq7BBFsqGYZsItQt9A5o/Z
         cS5KGPnHFnudJUziiNkiWvpHdw1guuReHRpNj9l0CcJH+b4YPAh4NFif3izA2SHSJib0
         Klur4uWVHRvel6qP40rXYdCfrVoY/DqML2Fa3BwN7wHni88QdpJQzi/NKescYxFtArDb
         rbRg==
X-Gm-Message-State: APjAAAV4yAwdfRSnBpFvxYflBpD6MFOoYA/aC8Qf+tmimLRmqdYMYpjp
        kd9UpUBnnh0Z2UFWmRDBq0NJxmO14JAnAK8UZBc9sw==
X-Google-Smtp-Source: APXvYqx4t9TJb0zhKWKpXdp+t0vLDo8QxG63nb2zHZEbXWHngIo59Bx47QJ4iboxakD5apU1NVxAFcglkoqPsv9oBoM=
X-Received: by 2002:aca:6104:: with SMTP id v4mr569905oib.172.1562209381525;
 Wed, 03 Jul 2019 20:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561707104.git.leonard.crestez@nxp.com> <CAGETcx_63KnP75qySbhX_P_=o4=ox9J8AsBqKsFHeQRjCpSeJA@mail.gmail.com>
 <DB7PR04MB505163FDCAD7BE9A0C71A65EEEFB0@DB7PR04MB5051.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB505163FDCAD7BE9A0C71A65EEEFB0@DB7PR04MB5051.eurprd04.prod.outlook.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Jul 2019 20:02:25 -0700
Message-ID: <CAGETcx-p4L3LBVpDBmBrPKXxMUtUXtsw-7AntpWs+AL3kaaP5Q@mail.gmail.com>
Subject: Re: [RFCv2 0/8] Add imx8mm bus frequency switching
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 3, 2019 at 4:30 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 7/4/2019 1:20 AM, Saravana Kannan wrote:
>
> >> The interconnect and devfreq parts do not communicate explicitly: they both
> >> just call clk_set_min_rate and the clk core picks the minimum value that can
> >> satisfy both. They are thus completely independent.
> >
> > Two different parts not talking to each other and just setting min
> > rate can cause problems for some concurrency use cases. ICC framework
> > is explicitly designed to handle cases like this and aggregate the
> > needs correctly. You might want to look into that more closely.
>
> The clk framework aggregates the min_rate requests from multiple
> consumers under a big "prepare_lock" so I expect it will deal with
> concurrent requests correctly. As for performance: frequency switching
> shouldn't be a fast path.

Sorry I wasn't clear. I was not talking about locking issues or race
conditions when I said concurrency use cases. What I meant was if GPU
wants 5 GB/s and at the same time (concurrent) camera wants 5 GB/s
you'll need to configure the interconnect for 10 GB/s. If both of them
just try to set the min freq equivalent for 5 GB/s the performance
would be bad or functionality might break.

> >> The clk_set_min_rate approach does not mesh very well with the OPP framework.
> >> Some of interconnect nodes on imx8m can run at different voltages: OPP can
> >> handle this well but not in response to a clk_set_min_rate from an unrelated
> >> subsystem. Maybe set voltage on a clk notifier?
> >
> > I think if you design it something like below, it might make your life
> > a whole lot easier.
> > Hopefully the formatting looks okay on your end. The arrow going up is
> > just connecting devfreq to ICC.
> >
> >                          Proactive -> ICC -> clk/OPP API to set freq/volt
> >                                        ^
> >                                        |
> > HW measure -> governor -> devfreq ----+
> >
> > That way, all voltage/frequency requirements are managed cleanly by
> > clk/OPP frameworks. The ICC deals with aggregating all the
> > requirements and devfreq lets you handle reactive scaling and policy.
>
> If icc and devfreq are to directly communicate it makes more sense to do
> it backwards: ICC should set a min_freq on nodes which have a devfreq
> instance attached and devfreq should implement actual freq switching.
>
> HW measurement is done on individual nodes while ICC deals with requests
> along a path. In particular on imx we have a performance monitor
> attached to the ddr controller and I doubt it can distinguish between
> masters so how could this be mapped usefully to an interconnect request?

Ah, that was the missing piece for me -- you are trying to use a
central performance monitor. I see what you are trying to do.

So you are looking at system wide traffic at DDR and then using that
to scale the interconnect/DDRC. I don't know how complicated or not
the IMX interconnect topology is, so please pardon my questions. If
you are using a performance monitor at the DDR controller, why do you
need the "proactive" requests from other clients? Wouldn't the
performance monitor account for all the traffic to DDR?

> As far as I understand with devfreq the ddrc node could use "ondemand"
> while the other nodes would default to the "passive" governor and run at
> predefined default ratios relative to DDRC.

Yes, that approach would also work but I'm not sure why you need the
ICC framework in that case.

> > If all of this makes sense, please take a look at [2] and provide your
> > thoughts. I've dropped a few patches from [1] to avoid confusion (too
> > much going on at once). I think BW OPP tables and having OPP tables
> > for interconnect paths will be something you'll need (if not now,
> > eventually) and something you can build on top of nicely.
>
> I found it very confusing that you're assigning BW OPP tables to
> devices. My initial understanding was that BW OPP would map "bandwidth"
> to "frequency" so BW OPPs should be assigned to links along the
> interconnect graph. But maybe what you want is to have OPPs for the BW
> values requested by devices?

I want to have OPPs for bandwidths requested for paths. Each
interconnect node can also use BW OPPs if that makes sense for them,
but I think they'd be better served by using frequency OPPs.

> Looking at the sdm845 icc provider source and it seems that those
> "peak/avg" values are actually parameters which go into a firmware
> command!? It makes sense that you want interconnect to be "below"
> devfreq since icc_provider.set maps very closely to what firmware exposes.

Even without the firmware (it's mainly there to aggregate requests for
some system wide resources) or if interconnects are scaled directly
using clock APIs (older chips), sdm845 would still want ICC to be
below devfreq. It's because 845 doesn't try to do ICC scaling by
measuring at the DDR. Each master makes separate requests and then the
ICC aggregates and sets the frequency. They have their reasons (good
ones) for doing that.

>  > Interconnects and interconnect paths quantify their performance
> levels > in terms of bandwidth and not in terms of frequency.
>
> On i.MX we just have a bunch of interconnect IPs for which frequencies
> can be adjusted (in hz)

This is true for every chip. In the end, they all set the Hz of hardware IPs.

> so the above statement doesn't really hold. It
> is up to an icc provider to convert aggregate bandwidth values to
> frequencies along the path.

That's the job of every ICC provider. In the case of i.MX you use
clock APIs and in the case of sdm845 they use some complicated
firmware interface. But in both cases, when the system is tuned for
performance/power everyone in the end cares about frequency and
voltage. If the frequency goes too high, they might reduce the
bandwidth to make sure the frequency remains reasonable for whatever
use case they are profiling.

I think the main difference is where the performance monitoring or
performance decision is done. If you don't have a central performance
monitor or don't want to use one, then the policy decision (which is
where devfreq fits in) will have to happen at the bandwidth decision
level.

-Saravana
