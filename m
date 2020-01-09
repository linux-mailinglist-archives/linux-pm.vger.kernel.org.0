Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2BA135201
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 04:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgAIDha (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 22:37:30 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38760 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgAIDh3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 22:37:29 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so4703882oii.5
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 19:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBxPdPI6aGH8o6hu5DCWy787QjzgPIZLXI5gO+WcD1Y=;
        b=QriXxRhHliJ3F/O3q0F2UmNA0QcFD7cijma9/Wt6o+qK90uPmfucUNK0n87888Y3Ke
         3aufsx2bK7ekHdLdoK4qcpIJbn1zaW7R5dXT9D7tbxC2KwIgg/F5SWxbkCpRZn23VNxI
         VYfYenU2XvlqEaadnZWM1rkSQtrCbBveapwdS5lWiBh5rTbellnWqG72eF/z3hrr5c7n
         /x8YuKYUEt0jWq0gKzxLSniEMZi4/A16mjHl8/j4hu+L7eSeLXr3e8xTWP6dHmGeurQg
         sTo9pbNc2bfNfN7pBwDkbCoywkC+LzWeOz+aIAbkYKK4DYiXEzke9wl26C6FNRT47X9z
         PmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBxPdPI6aGH8o6hu5DCWy787QjzgPIZLXI5gO+WcD1Y=;
        b=XCZR8etboXAzkb/WmKJloTg3gTsIUYK+lpnOt84QOeiu/kCPanB/oaBxH1Gm0RCdx0
         0E0gt8h0H585Ng93EnoP9xpYxe1QXTqs3tbJSzwXYEC+CZdxim22yh8DqwZfpYg2tRGU
         ZUtL4TxM2ZYRe96HQKJtXTswQmELo/TuxpkwUcaHF161uHUurgVXFoPCKENrnQZ6Y+Tf
         Yla2Kmmel3OMX/YM5MEZb+sNJE0jrXxUi3cjkbFx1I5Ngoe4fZIaamIhPuemN941otq4
         Fs22RdDXjG04o06fqG3J/qfhCwoRKUno1IUGIpzKX/d9Gs5eoQFJB9HhzOL3VFFZOV2S
         hwMQ==
X-Gm-Message-State: APjAAAUUak+bdVQKFoq/vtcYiD2U0R4TVE8l2vRQ/Scvy2wHm4o+bLVX
        jQuLNsbriRiPaMs+25WZM9sUMrQMYU7ynyDHwWanXA==
X-Google-Smtp-Source: APXvYqx3Uob/RWYjP3Mq5nseaUALTA1i4stN0ZiBAI3/wbVgdUWsj38KXuEm4Va+vnVVWxZ1CTr9+sKRSuUfGnQT+hg=
X-Received: by 2002:aca:5490:: with SMTP id i138mr1579922oib.69.1578541048669;
 Wed, 08 Jan 2020 19:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com> <20191207002424.201796-4-saravanak@google.com>
 <20200108111947.q5aafrlz26tnk3nq@vireshk-i7> <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
In-Reply-To: <CAGETcx_T7VONkSd-r9CY-5OpZBZ2iD0tFoCf0+d8CY2b5zgr9g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Jan 2020 19:36:52 -0800
Message-ID: <CAGETcx8cro3FHqZhbia6ZUy41XGHwMMSTZgX7QN_2wToWa-Yww@mail.gmail.com>
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

On Wed, Jan 8, 2020 at 4:58 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Jan 8, 2020 at 3:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 06-12-19, 16:24, Saravana Kannan wrote:
> > > The frequency OPP tables have helper functions to search for entries in the
> > > table based on frequency and get the frequency values for a given (or
> > > suspend) OPP entry.
> > >
> > > Add similar helper functions for bandwidth OPP tables to search for entries
> > > in the table based on peak bandwidth and to get the peak and average
> > > bandwidth for a given (or suspend) OPP entry.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/opp/core.c     | 301 +++++++++++++++++++++++++++++++++++------
> > >  include/linux/pm_opp.h |  43 ++++++
> > >  2 files changed, 305 insertions(+), 39 deletions(-)
> > >
> > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > index c79bbfac7289..3ff33a08198e 100644
> > > --- a/drivers/opp/core.c
> > > +++ b/drivers/opp/core.c
> > > @@ -127,6 +127,29 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
> > >
> > > +/**
> > > + * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an available opp
> > > + * @opp:     opp for which peak bandwidth has to be returned for
> >
> > s/peak //
>
> Ack

Actually, isn't this correct as is? peak bandwidth is "returned".
Average bandwidth is updated through the pointer.

-Saravana
