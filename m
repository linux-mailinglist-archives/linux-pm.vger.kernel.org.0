Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C437A650
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfG3K51 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 06:57:27 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36065 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfG3K51 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 06:57:27 -0400
Received: by mail-vs1-f68.google.com with SMTP id y16so43116841vsc.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PU2Fv6R/P/i3mcSRuoPPGRfAr6wNs2iQGjXmUbGxWxs=;
        b=lkRzDG3pOo++tgaJ/bk6mpSVrJ4U+eY8OcNTWGQUVYUYttxgttg75uet9SsFVlFj5X
         56vVKNNShTVrkciES8RZLgERCq6Eu0inKgLrUXv+UHknTTkko1Me/AOYQaVhrvr9ul74
         k1ZTN/KKq9M1A97FcfnuCHs66ezrP2LfZjt5Jh4mNTvBZ+Qa5vBvXihKX09g1pwef9ah
         1RwV0XnWUyYYde3qxBhhETbVOtbuTv60HpbxbZL2DhePWYOkqd7U1ATi3lvbR2YHhSiJ
         BqxzRofIdR8rdaLCo1QBqSHc2QbtkbxrWoMWZkIvC311uMEgvbJ1WhFqqUpQRgGI02/r
         jRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PU2Fv6R/P/i3mcSRuoPPGRfAr6wNs2iQGjXmUbGxWxs=;
        b=c2E1hpKVuxk0oGYw8LHGs2oo5YTXJZF1prABKCP6oD9PAJkELyWfOOi6pfjbucv1n8
         T89yWtlNcteo+muF8xLrJV5XK5f8eibgFOnlGhMYQ10XbpIioSGUbOiqTcVdG88aC1jb
         N1mCd7LzfUO4b8Sxd99EC12y5l8+6lZf4uB99UEPOjec6eUUhHgMfA48fgzQywSBjr5x
         RK5vC52Wz2BUYqp2QBUicYHLgsBUEOC0qHKW/6TIpv2YrudjhJz/lXW+kn9pxP00nyi3
         EzOcTO6yO/QtH5fgV/yZ0fTV9JM90yOz0Qpj0SO/jx6zy/lv4siQsAdPLuNApKETGjUK
         LnRg==
X-Gm-Message-State: APjAAAUjlGLlMVDA53fooAdUAmPK/bPb/oWvnAzUQZze302LKMRqlgE+
        KV4iCJJbm2p7yMytAdHnmvg+LxmlAgTeVIqajE0=
X-Google-Smtp-Source: APXvYqxdHlZ4vF5yKTPQPNGjlJ/ek0vmLnEB8hjWQ9oAZTWBvgX+iEXTp/PoBM1Tn6vGEE1EyjhPaEe2qNC/+UygfcM=
X-Received: by 2002:a67:fb87:: with SMTP id n7mr42648957vsr.9.1564484245706;
 Tue, 30 Jul 2019 03:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-3-saravanak@google.com>
In-Reply-To: <20190703011020.151615-3-saravanak@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 30 Jul 2019 16:27:14 +0530
Message-ID: <CAHLCerP81Eotae5s4-Qye77SSF6-BbqFhckvkTEQWBD9biwzbw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] OPP: Add support for bandwidth OPP tables
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        evgreen@chromium.org, kernel-team@android.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 3, 2019 at 6:40 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Not all devices quantify their performance points in terms of frequency.
> Devices like interconnects quantify their performance points in terms of
> bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> add support for parsing bandwidth OPPs from DT.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/opp/of.c  | 34 ++++++++++++++++++++++++++++++++--
>  drivers/opp/opp.h |  4 +++-
>  2 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index c10c782d15aa..54fa70ed2adc 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -552,6 +552,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>
> +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np)
> +{
> +       int ret;
> +       u64 rate;
> +       u32 bw;
> +
> +       ret = of_property_read_u64(np, "opp-hz", &rate);
> +       if (!ret) {
> +               /*
> +                * Rate is defined as an unsigned long in clk API, and so
> +                * casting explicitly to its type. Must be fixed once rate is 64
> +                * bit guaranteed in clk API.
> +                */
> +               new_opp->rate = (unsigned long)rate;
> +               return 0;
> +       }
> +
> +       ret = of_property_read_u32(np, "opp-peak-KBps", &bw);
> +       if (ret)
> +               return ret;
> +       new_opp->rate = (unsigned long) &bw;
> +
> +       ret = of_property_read_u32(np, "opp-avg-KBps", &bw);
> +       if (!ret)
> +               new_opp->avg_bw = (unsigned long) &bw;
> +
> +       return 0;
> +}
> +
>  /**
>   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
>   * @opp_table: OPP table
> @@ -589,11 +618,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>         if (!new_opp)
>                 return ERR_PTR(-ENOMEM);
>
> -       ret = of_property_read_u64(np, "opp-hz", &rate);
> +       ret = _read_opp_key(new_opp, np);
>         if (ret < 0) {
>                 /* "opp-hz" is optional for devices like power domains. */
>                 if (!opp_table->is_genpd) {
> -                       dev_err(dev, "%s: opp-hz not found\n", __func__);
> +                       dev_err(dev, "%s: opp-hz or opp-peak-bw not found\n",
> +                               __func__);
>                         goto free_opp;
>                 }
>
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 569b3525aa67..ead2cdafe957 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -59,7 +59,8 @@ extern struct list_head opp_tables;
>   * @turbo:     true if turbo (boost) OPP
>   * @suspend:   true if suspend OPP
>   * @pstate: Device's power domain's performance state.
> - * @rate:      Frequency in hertz
> + * @rate:      Frequency in hertz OR Peak bandwidth in kilobytes per second

rate is most often used for clk rates. Let us not overload this just
to save one struct member. IMO, you should introduce a peak_bw member
and then have an error check if the DT provides both rate and peak_bw
during parsing.

> + * @avg_bw:    Average bandwidth in kilobytes per second
>   * @level:     Performance level
>   * @supplies:  Power supplies voltage/current values
>   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
> @@ -81,6 +82,7 @@ struct dev_pm_opp {
>         bool suspend;
>         unsigned int pstate;
>         unsigned long rate;
> +       unsigned long avg_bw;
>         unsigned int level;
>
>         struct dev_pm_opp_supply *supplies;
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
