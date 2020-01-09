Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA221350B9
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 01:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgAIA7P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 19:59:15 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36468 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIA7P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 19:59:15 -0500
Received: by mail-ot1-f65.google.com with SMTP id 19so5592001otz.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 16:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Fgy4gBsnNDhvVOVnNjUhXi1MEMb8Zuk1lMJfG95h70=;
        b=Gfa4k3DW+bK3x+Fb5EJ7YEGcSey+eNjFZEw7HfBF0DTflbvNacUsFd5DDahJnij83j
         /Z36JmzQlEbgDubnN/NTi9LB7SNhaxmPYSvWtLtQc/czukrG2y3+ndOuHGjO1DkI2E4T
         ZwfPxLUFkVkV6czF2pFrOIGjeUC+eLWLQMoDOreu6s2VHgG9g223fRjVcj6KU+RtcobH
         uIgYMz44sn2W4a8ifK9z5HZj/qo3kVn1/fJOEfsNg3JoxoBLGNwJ7464QL0Tyo8chjtL
         BwMMxa/IeE2Kfs1gUkothnSfSA+r5wrx6UOG0u0TFag1GYxRm6pTogkejtm0D5LZ/U7q
         0sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Fgy4gBsnNDhvVOVnNjUhXi1MEMb8Zuk1lMJfG95h70=;
        b=mBwhjTbnMd5TriXXqnltYF7KJpR9mqUt2NUgu/B7C0xzwbhMSYIgMjzzQXSjRoddr6
         keTG1qODvlQKtXAtEVhRFe1OB1wBVjiwre7UwX6a6rywoUNZJ050Jzqq2f6/YpowaoRe
         9QS5u1Hpn9OmbWmvRF+YAEf+YsLTKomMQKSw/RiDHEWuteNXGUZqIURTl4kHsIElwHLJ
         T5h8UuXH7kQou8gv0JfxJ3vEDzUYBaoyygMkqth5rSw5uPbaks5gQoD05XWdBPdHydWa
         Tl7YrIPSs+R+GTSZDcGbshb8ZWcPhXiHyZsdWDQUnTPsP6uRChRM2HwE2TZjikPzXW49
         bKLw==
X-Gm-Message-State: APjAAAXD6jFjeJ7desCny7sWtMc1kSKtTeVAhzZd0hcRl9UOt4Z14T4s
        0fTCCCG7ArAAJLROjGRdxxNHB0PTuvsD072CofM6aA==
X-Google-Smtp-Source: APXvYqwjwFClxrTy/XuUbDeOil0j1vYMARYAI98fBCmBlP5FWFo8hJswWYfeoJtxQGvZURgI56ERiVn6apAi6N2UaVY=
X-Received: by 2002:a05:6830:22ee:: with SMTP id t14mr6258010otc.236.1578531553965;
 Wed, 08 Jan 2020 16:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com> <20191207002424.201796-4-saravanak@google.com>
 <20200108111947.q5aafrlz26tnk3nq@vireshk-i7>
In-Reply-To: <20200108111947.q5aafrlz26tnk3nq@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Jan 2020 16:58:38 -0800
Message-ID: <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] OPP: Add helper function for bandwidth OPP tables
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

On Wed, Jan 8, 2020 at 3:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 06-12-19, 16:24, Saravana Kannan wrote:
> > The frequency OPP tables have helper functions to search for entries in the
> > table based on frequency and get the frequency values for a given (or
> > suspend) OPP entry.
> >
> > Add similar helper functions for bandwidth OPP tables to search for entries
> > in the table based on peak bandwidth and to get the peak and average
> > bandwidth for a given (or suspend) OPP entry.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/opp/core.c     | 301 +++++++++++++++++++++++++++++++++++------
> >  include/linux/pm_opp.h |  43 ++++++
> >  2 files changed, 305 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index c79bbfac7289..3ff33a08198e 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -127,6 +127,29 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
> >
> > +/**
> > + * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an available opp
> > + * @opp:     opp for which peak bandwidth has to be returned for
>
> s/peak //

Ack

>
> > + * @avg_bw:  Pointer where the corresponding average bandwidth is stored.
> > + *           Can be NULL.
> > + *
> > + * Return: Peak bandwidth in kBps corresponding to the opp, else
> > + * return 0
> > + */
> > +unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, unsigned long *avg_bw)
> > +{
> > +     if (IS_ERR_OR_NULL(opp) || !opp->available) {
> > +             pr_err("%s: Invalid parameters\n", __func__);
> > +             return 0;
> > +     }
> > +
> > +     if (avg_bw)
>
> Do you see this being NULL in practice ? If no, then we can make it
> mandatory for now ?

Yes, very likely. A lot of OPP tables might not have avg bandwidth listed.

> > +             *avg_bw = opp->avg_bw;
> > +
> > +     return opp->peak_bw;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_opp_get_bw);
> > +
> >  /**
> >   * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
> >   * @opp:     opp for which level value has to be returned for
> > @@ -299,6 +322,34 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
> >
> > +/**
> > + * dev_pm_opp_get_suspend_opp_bw() - Get peak bandwidth of suspend opp in kBps
>
> Hmm, I wasn't expecting this. So the interconnects will also have a
> suspend OPP ?

Yes, device voting for interconnect paths might want to lower the
bandwidth to a suspend bandwidth when they suspend.

> > + * @dev:     device for which we do this operation
> > + * @avg_bw:  Pointer where the corresponding average bandwidth is stored.
> > + *           Can be NULL.
> > + *
> > + * Return: This function returns the peak bandwidth of the OPP marked as
> > + * suspend_opp if one is available, else returns 0;
> > + */
> > +unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
> > +                                         unsigned long *avg_bw)
> > +{
> > +     struct opp_table *opp_table;
> > +     unsigned long peak_bw = 0;
> > +
> > +     opp_table = _find_opp_table(dev);
> > +     if (IS_ERR(opp_table))
> > +             return 0;
> > +
> > +     if (opp_table->suspend_opp && opp_table->suspend_opp->available)
> > +             peak_bw = dev_pm_opp_get_bw(opp_table->suspend_opp, avg_bw);
> > +
> > +     dev_pm_opp_put_opp_table(opp_table);
> > +
> > +     return peak_bw;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_bw);
> > +
> >  int _get_opp_count(struct opp_table *opp_table)
> >  {
> >       struct dev_pm_opp *opp;
> > @@ -343,6 +394,40 @@ int dev_pm_opp_get_opp_count(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
> >
>
> I think we should add function header here instead of the helpers
> which get exact match for freq, bw or level. And then pass a enum
> value to it, which tells what we are looking to compare. After that
> rest of the routines will be just one liners, make them macros in
> header file itself.

Not sure I understand what you are saying here.


> > +struct dev_pm_opp *dev_pm_opp_find_opp_exact(struct device *dev,
> > +                                           struct dev_pm_opp *opp_key,
> > +                                           bool available)
>

-Saravana
