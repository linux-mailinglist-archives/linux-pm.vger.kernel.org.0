Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89DC48549E
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 22:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfHGUqw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 16:46:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44674 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbfHGUqw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 16:46:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so59555011otl.11
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1drnZsNJ30h8VB1p7exPq6Ba5yiKi2dka+MQPDhn2UQ=;
        b=jWK9JgU9V08mGULS627pv+JWIbES/c1ddmqDJQCSA18TSPZ65qxQOlPswgfzd06XFf
         DRuWrk80lcdXWpPZRX+lIiOY93ECSJoiQCGKN/wDU+EHHTbLZ8A9wjLZy2dhklRZT0SV
         ykhyFs4wnZb/eB8ScZ1OXkw5hUNFhxlruQsR0XTMfWapA9vp6BDhr992fOZ3AEoL2FLA
         lTbqUyJLr0fHXCfTQ5bhr8BrSoe2tf84CsXyxhWG3n/xTeJIcF9wZwunMgBBHsjHoYc3
         1k3vEGC/zWh0DYG+xWHddiDWHVd0EVvrz8u2z/NZYuLxsh34HPkSdCGcEmk1//SEwzBY
         GK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1drnZsNJ30h8VB1p7exPq6Ba5yiKi2dka+MQPDhn2UQ=;
        b=jOOBAIoTqS5i8a4dQb9ekcR5InSYPmuP4gov2bx8lK4hqKjjSHIWjXaXBGiAuM5tTX
         2DcgYemvcuWO1HnG3FZlhp9k8k1+qEPeq2/odiKADIJ29w4mdqOlAVdx2VweeGSF2TSx
         R/y4KCyLVDOLl7LOM+Ag6Kkn+f64018Diw2IfnxiKKjOnhSLSxQtAACdrbXFz/7UqMfL
         11MGzObqwdjumZ2Hp34B10ydbIIC/2PiXBBVf0q697JgLhdob3miFQeCUy/ZiwYQd393
         QY9qHsKcMG8XooHRoKZ5vwqJPVpRbmJwMfhL6E3mR3TDARnEzWDhxofsb/licI75D5nD
         ZQQQ==
X-Gm-Message-State: APjAAAUn5ldDLHpdnmTpkzbIFziu0G7uRPVk/pFAM7kr0wJSsY9uquwx
        AjK/IKicMpw0x/2MDdU6wDj6vh8MI5qMrUsd9TjRTw==
X-Google-Smtp-Source: APXvYqwL+5I/uBwlSg65FPxVLioe2KXP4DO+byd51b7MUvPmh84Vp0qaLSYhdhuW8vbescgu2ff0lZyh/Irbvl1/Cbc=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr9805438otk.139.1565210810189;
 Wed, 07 Aug 2019 13:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190726231558.175130-1-saravanak@google.com> <20190726231558.175130-3-saravanak@google.com>
 <fc8e4a77-5544-0dd7-f103-147f87e44a28@linaro.org>
In-Reply-To: <fc8e4a77-5544-0dd7-f103-147f87e44a28@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 7 Aug 2019 13:46:14 -0700
Message-ID: <CAGETcx8n_YfPH1Fbvb2ay5A=AqG60V6nvtfE0s1OAJMhVQjDmA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] OPP: Add support for bandwidth OPP tables
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Aug 7, 2019 at 5:53 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Saravana,
>
> On 7/27/19 02:15, Saravana Kannan wrote:
> > Not all devices quantify their performance points in terms of frequency.
> > Devices like interconnects quantify their performance points in terms of
> > bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> > add support for parsing bandwidth OPPs from DT.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/opp/of.c  | 41 ++++++++++++++++++++++++++++++++---------
> >  drivers/opp/opp.h |  4 +++-
> >  2 files changed, 35 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index b313aca9894f..ac73512f4416 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -523,6 +523,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> >
> > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np)
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
> > +             return 0;
>
> So we can't have a single OPP table with both frequency and bandwidth?

Right, because we can have only 1 "key" for the OPP table. Having more
than one "key" for an OPP table makes a lot of things pretty messy.
Most of the helper functions need to be rewritten to say which key is
being referred to when searching. A lot of the error checking when
creating OPP tables becomes convoluted -- can we allow more than one
OPP entry with the same frequency just because the opp-peak-kBps is
different? Etc. Seems like a lot of code change for something that I
don't think is a very useful.

Also, an OPP table is either going to represent performance levels of
a clock domain (opp-hz) or the performance levels of an interconnect
path (opp-peak-kBps) or an OPP table for genpd. Mixing them all up is
just going to make it convoluted with not enough benefit or use case
that can't be handled as is (separate BW and freq OPP tables).

> > +     }
> > +
> > +     ret = of_property_read_u32(np, "opp-peak-KBps", &bw);
> > +     if (ret)
> > +             return ret;
> > +     new_opp->rate = (unsigned long) bw;
> > +
> > +     ret = of_property_read_u32(np, "opp-avg-KBps", &bw);
> > +     if (!ret)
> > +             new_opp->avg_bw = (unsigned long) bw;
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> >   * @opp_table:       OPP table
> > @@ -560,22 +589,16 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> >       if (!new_opp)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     ret = of_property_read_u64(np, "opp-hz", &rate);
> > +     ret = _read_opp_key(new_opp, np);
> >       if (ret < 0) {
> >               /* "opp-hz" is optional for devices like power domains. */
> >               if (!opp_table->is_genpd) {
> > -                     dev_err(dev, "%s: opp-hz not found\n", __func__);
> > +                     dev_err(dev, "%s: opp-hz or opp-peak-bw not found\n",
>
> s/opp-peak-bw/opp-peak-kBps/

Thanks. Will fix.

-Saravana
