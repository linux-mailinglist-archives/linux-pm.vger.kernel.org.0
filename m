Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4A49F6B9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jan 2022 10:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiA1Jz2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 04:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347766AbiA1Jz2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 04:55:28 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE13C061748
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 01:55:28 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i17so5632940pfq.13
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 01:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prOuvUSJK87MWBdi/JiyFRnn/iVOs3ZVY+2L9vzr/IE=;
        b=BnI8/WtgnyYQY5ztvCbESIVwBXI/J/TteUqgBvUfKPXSM0kC4rOs0Mq9GGrgjaNZuF
         BmF1wlwbsEEqHs4v7MqsFdGidJCKnAvdLNQAmJspNBWT+w/+bO2WHe/TOxIbTSQR1dvq
         NzN7zOtGFk3+0h+GgX6COrwlSjxYy+fGRAv/hLDW3gTi3VOCF5YtWA6ILcXPZJ6hcrDz
         VadW3Fq1TCjg0K1wWHkLM1MU8oIQxFdkHhC9Y+mSpAvPBF+ShECMvs9i86UL9DfWJokI
         KryLGwEZnUB0XXvJnrfqzc2Kl+FBuog9I/bA7zy4UvzG6SdEAmzGTqrh1U9jiEQUq+LQ
         VAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prOuvUSJK87MWBdi/JiyFRnn/iVOs3ZVY+2L9vzr/IE=;
        b=uOHsiUauEuJG/MOX7Q3EKmnXDGRcnWyucB9uIPzkqyDQFDCfu0ymZZ2R2ZbO4CmfnQ
         6qPP7tVYr9AZYYF/Wbw3Q7QZXu8La18EQAC4XFt/5DTg60V8wGGX7rPil0ZS+vHGQYYG
         +OJNQplcPpOcN+Ti1neTFlsznuMz9omgLOeBhZ4cyAEiPOaFMxrunBjQWdfDJhPIg2BB
         MC9PSJDU8PSEZY8Y9YkwYgT3xvSnw0R3kTetM3QzUlrFncQdn64xGJSo5NaWhBbejcaN
         SjXPEDtg8ghp3u7WuT46mY9bGJEyh5HsAQJVeWzSlcAB9eBNOxYMvGPlr4CCQjEYbeXe
         45+A==
X-Gm-Message-State: AOAM531YDjWGawYanGTSdaRYjO6YYl5MLnHhnpYf4CRzp1kZkN5ziHOT
        cjgEHKRO1oHPTrHkaR5NslUY3AluVQGIXOygJT+kPg==
X-Google-Smtp-Source: ABdhPJwykIMgWVCgnUOwKlc4GIw3w3ab2QN+FIV7G6rAaJMcCldtKxO+zgWKoHx05FaLlGXSuTRXcsTaMlgNfsJ4k2A=
X-Received: by 2002:a05:6a00:1514:: with SMTP id q20mr1280158pfu.74.1643363727606;
 Fri, 28 Jan 2022 01:55:27 -0800 (PST)
MIME-Version: 1.0
References: <1643016384-11161-1-git-send-email-loic.poulain@linaro.org>
 <CAJZ5v0hJzZpLv69coibEApT9zOxZ43mmOixNo5TZtizbUCFSTA@mail.gmail.com>
 <CAMZdPi-72Yo3z6sM7Do7PxcfqQamXfoEG-9vj4SC=GqZj5-gVg@mail.gmail.com> <CAJZ5v0hVQxGbc=-adRLrPM-qYYz7ZgHzkEWr-zPy=ZG+bGguQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hVQxGbc=-adRLrPM-qYYz7ZgHzkEWr-zPy=ZG+bGguQA@mail.gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 28 Jan 2022 11:08:04 +0100
Message-ID: <CAMZdPi_TX=ac_3U5DXWvPrfHRFLBrYJOwz3Sh2nCz4rybyydkQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] PM: wakeup: Wakeup accounting for interrupts
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 27 Jan 2022 at 20:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 27, 2022 at 9:51 AM Loic Poulain <loic.poulain@linaro.org> wrote:
> >
> > Hi Rafael,
> >
> > On Wed, 26 Jan 2022 at 19:23, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Jan 24, 2022 at 10:14 AM Loic Poulain <loic.poulain@linaro.org> wrote:
> > > >
> > > > Most of the time, system wakeup is caused by a wakeup-enabled
> > > > interrupt, but the accounting is not done for the related wakeup
> > > > source, causing 'wrong' values reported by device's wakeup attributes
> > > > and debugfs stats (debug/wakeup_sources).
> > > >
> > > > This change reports a wakeup event for any wakeup-sources the irq is
> > > > attached with.
> > > >
> > > > Note: This only works for drivers explicitly attaching the irq to
> > > > a given device (e.g. with dev_pm_set_wake_irq).
> > > >
> > > > Note2: Some drivers call pm_wakeup_event() in their irq handler, but
> > > > not all, moreover, an interrupt can be disabled while being flagged
> > > > as wakeup source, and so accounting must be performed. This solution
> > > > ensures that accounting will always be done for the interrupt waking
> > > > up the host.
> > > >
> > > > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > > > ---
> > > >  drivers/base/power/wakeup.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > > > index 99bda0da..2d75e057 100644
> > > > --- a/drivers/base/power/wakeup.c
> > > > +++ b/drivers/base/power/wakeup.c
> > > > @@ -952,8 +952,19 @@ void pm_wakeup_clear(bool reset)
> > > >  void pm_system_irq_wakeup(unsigned int irq_number)
> > > >  {
> > > >         if (pm_wakeup_irq == 0) {
> > > > +               struct wakeup_source *ws;
> > > > +               int srcuidx;
> > > > +
> > > >                 pm_wakeup_irq = irq_number;
> > > >                 pm_system_wakeup();
> > > > +
> > > > +               /* wakeup accounting */
> > > > +               srcuidx = srcu_read_lock(&wakeup_srcu);
> > >
> > > This is called from interrupt context, so srcu_read_lock() cannot be used here.
> >
> >
> > AFAIU from srcu.h, it is not prohibited, right? and we are not
> > blocking while locked here.
>
> OK, you can do that if you release it from the same context.
>
> There are other concerns regarding this change, though.
>
> First off, it adds overhead for all systems, but the benefit is there
> only for the systems where wake IRQs are used.

It adds very little overhead for interrupts with armed wakeup, during
system suspend(ing/ed) only, other IRQs are not affected.

>
> Second, it may lead to reporting the same wakeup event twice in a row
> if the driver decides to do that too.  Is this not a problem?

That's a legitimate point, but I don't see it as a big concern
compared to not recording the event at all. If a driver deliberately
attaches an interrupt to a wake source, it seems sane to expect that
this interrupt will cause a corresponding wakeup event (should
probably be documented), whatever the driver's irq handler is doing.


>
> > > > +               list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> > > > +                       if (ws->wakeirq && ws->wakeirq->irq == irq_number)
> > > > +                               pm_wakeup_ws_event(ws, 0, false);
> > > > +               }
> > > > +               srcu_read_unlock(&wakeup_srcu, srcuidx);
> > > >         }
> > > >  }
> > > >
> > > > --
> > > > 2.7.4
> > > >
