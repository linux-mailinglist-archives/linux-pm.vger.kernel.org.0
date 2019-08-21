Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F41B9717C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 07:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfHUFXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 01:23:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40214 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfHUFXe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 01:23:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so622707pgj.7
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2019 22:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gk5hBFL+zVsGTiYjgXO/Fpozdyng3BO4uoV137GL+GU=;
        b=e1jxa3Q2588Ob9x6kW+s98HVpKflZuV51sDkqtp1W7M8fFuoqNQieOx7XZgYvhjCk0
         ptDwUw++oSPtE+AvV6FIcHMe/DX7cQFvbBIMEEAzzuWl9ycVL+cHnh13QfH7c2ZUUDzR
         9/gA3TfjozoAmsjCnQ4yO9ysbAYro+Q0yOlsCS7kfY/L2L6We8rjnip9UtW7ADIAJNMi
         +aT12kxKsenm1fwscCl+gPp5DeI5envtkvKy7dkQbJz3taB7zyIBNdM/ZbO1DWU9630R
         5SbnJh1dVsilH3YyeEMFNknte5bbP2l/TtEVu86taqh1PatWR97T7F0peZwnIVmypl1h
         /z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gk5hBFL+zVsGTiYjgXO/Fpozdyng3BO4uoV137GL+GU=;
        b=B0R0Zr9s+oRx/DvCO0ALCNHohnqmOgXpmCP4Wk4oQ2fzIKxk9f4LAzz1nExOnclAgL
         grVyOHcLcADWqBwHduQHcamlXw+VFW7QDsfVdqucIUGFG6rTScjTwvIOd6p3YnFPvyN6
         kYafZmuDC6pWzdOjJij0dokWoGQVy0+O00K8djFgAyNlT5rcS0GQnJGFraOMUVUkc6nJ
         Y6ltR2+BadKHdaQ+GTEvlwli5gpB/KefnppogtCVV2PjsfIYzB678qtsZsfGsp0ZbZpm
         LDadkQWnFTLSGCu8vBKXS3jIN++cuj+p2CmUyeHWMZwLm7WFfid2ePbB41FuPbElB/rZ
         CGBA==
X-Gm-Message-State: APjAAAXUtP4xNN8qFVDfq8nUU7wn4Y8278cUN2M7sbKnqnTChXGuPP/h
        5vkzV/4MpU7f/BftfjY7iBvK8A==
X-Google-Smtp-Source: APXvYqxjps2jGsMWRHNpKkH8xofYKtLT/1SGtm5kRxow16cEqA032NNAf8R3+ys1S/HHdRNNzwhbIQ==
X-Received: by 2002:a62:c584:: with SMTP id j126mr33906007pfg.21.1566365013017;
        Tue, 20 Aug 2019 22:23:33 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id l4sm1781386pjq.9.2019.08.20.22.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 22:23:32 -0700 (PDT)
Date:   Wed, 21 Aug 2019 10:53:30 +0530
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
Subject: Re: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
Message-ID: <20190821052330.7zufh7hhurq7ictp@vireshk-i7>
References: <20190807223111.230846-1-saravanak@google.com>
 <20190807223111.230846-3-saravanak@google.com>
 <20190820061300.wa2dirylb7fztsem@vireshk-i7>
 <CAGETcx9BV9qj17LY30vgAaLtz+3rXt_CPpu4wB_AQCC5M7qOdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9BV9qj17LY30vgAaLtz+3rXt_CPpu4wB_AQCC5M7qOdA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-08-19, 15:27, Saravana Kannan wrote:
> On Mon, Aug 19, 2019 at 11:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 07-08-19, 15:31, Saravana Kannan wrote:
> > > Not all devices quantify their performance points in terms of frequency.
> > > Devices like interconnects quantify their performance points in terms of
> > > bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> > > add support for parsing bandwidth OPPs from DT.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/opp/of.c  | 41 ++++++++++++++++++++++++++++++++---------
> > >  drivers/opp/opp.h |  4 +++-
> > >  2 files changed, 35 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > > index 1813f5ad5fa2..e1750033fef9 100644
> > > --- a/drivers/opp/of.c
> > > +++ b/drivers/opp/of.c
> > > @@ -523,6 +523,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
> > >
> > > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np)
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
> > > +             return 0;
> > > +     }
> > > +
> >
> > Please read opp-level also here and do error handling.
> 
> Can you please explain what's the reasoning? opp-level doesn't seem to
> be a "key" based on looking at the code.

Because opp-level is the thing that distinguishes OPPs for power domains, those
nodes don't have opp-hz or bw.

> > > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > > +     if (ret)
> > > +             return ret;
> > > +     new_opp->rate = (unsigned long) bw;
> > > +
> > > +     ret = of_property_read_u32(np, "opp-avg-kBps", &bw);
> > > +     if (!ret)
> > > +             new_opp->avg_bw = (unsigned long) bw;
> >
> > If none of opp-hz/level/peak-kBps are available, print error message here
> > itself..
> 
> But you don't print any error for opp-level today. Seems like it's optional?

Yeah, probably it should have been there. It will be better to do it now as we
are creating a separate routine for that.

> >
> > > +
> > > +     return 0;
> >
> > You are returning 0 on failure as well here.
> 
> Thanks.
> 
> > > +}
> > > +
> > >  /**
> > >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> > >   * @opp_table:       OPP table
> > > @@ -560,22 +589,16 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
> > >       if (!new_opp)
> > >               return ERR_PTR(-ENOMEM);
> > >
> > > -     ret = of_property_read_u64(np, "opp-hz", &rate);
> > > +     ret = _read_opp_key(new_opp, np);
> > >       if (ret < 0) {
> > >               /* "opp-hz" is optional for devices like power domains. */
> > >               if (!opp_table->is_genpd) {
> > > -                     dev_err(dev, "%s: opp-hz not found\n", __func__);
> > > +                     dev_err(dev, "%s: opp-hz or opp-peak-kBps not found\n",
> > > +                             __func__);
> > >                       goto free_opp;
> > >               }
> > >
> > >               rate_not_available = true;
> >
> > Move all above as well to read_opp_key().
> 
> Ok. I didn't want to print an error at the API level and instead print
> at the caller level. But if that's what you want, that's fine by me.

That would be fine, you can keep the print message here (but a generic one, like
key missing).

> > > -     } else {
> > > -             /*
> > > -              * Rate is defined as an unsigned long in clk API, and so
> > > -              * casting explicitly to its type. Must be fixed once rate is 64
> > > -              * bit guaranteed in clk API.
> > > -              */
> > > -             new_opp->rate = (unsigned long)rate;
> > >       }
> > >
> > >       of_property_read_u32(np, "opp-level", &new_opp->level);
> > > diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> > > index 01a500e2c40a..6bb238af9cac 100644
> > > --- a/drivers/opp/opp.h
> > > +++ b/drivers/opp/opp.h
> > > @@ -56,7 +56,8 @@ extern struct list_head opp_tables;
> > >   * @turbo:   true if turbo (boost) OPP
> > >   * @suspend: true if suspend OPP
> > >   * @pstate: Device's power domain's performance state.
> > > - * @rate:    Frequency in hertz
> > > + * @rate:    Frequency in hertz OR Peak bandwidth in kilobytes per second
> > > + * @avg_bw:  Average bandwidth in kilobytes per second
> >
> > Please add separate entry for peak_bw here.
> >
> > I know you reused rate because you don't want to reimplement the helpers we
> > have. Maybe we can just update them to return peak_bw when opp-hz isn't present.
> 
> How about I just rename this to "key"? That makes a lot more sense
> than trying to save 3 different keys and going through them one at a
> time.

I would still like to keep separate fields for now. We are still in continuous
development and don't know how things will be going forward. We may end up
having bw and hz in the OPP table as well. Over that I like to have separate
fields for readability.

Thanks.

-- 
viresh
