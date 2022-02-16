Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6C94B8EB2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 17:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiBPQ7e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 11:59:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiBPQ7d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 11:59:33 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AE22A5209
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 08:59:21 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 124so7334681ybn.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 08:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5on+y4a7NEzx/aXdqaTTQWJdJsqCO4WTjGbZUIA4tEo=;
        b=kg065FskxBAeanv6akHma6L+fsxFATZLxokCWRP/pZUz3ZxIM6933zbI4vSuoRoe0n
         HZ8QpwQKM21J/WxOb9KPFZ2EAa3cRnDSBEqxYsWNARqK11ea3d/r3XlZv/8l9FfMeGi7
         DE58oyj5d/1NXY6UpxDK+hjalzo1bFc03cKRKLGj9NFeMhO41/vAr7l1Xc/5krwi2JDL
         xzbB22nx7OCHEBWgV+b5cWVDfO7kySTRbQAS8xHLBJu6Fe0m0HjaC0A0m9bzppLU27A0
         fA9idVQ+4w0ph0LGWu6YgCkXTG4ZNvHb9VwaRhUoHbMMHUvUi61n3ZCRdB7sQRtGS++9
         GisQ==
X-Gm-Message-State: AOAM532e/q5SmbQ4+Vad+asK2IFXQPZz1OR+DJR3+nwWnJsD19IeFVTb
        Ga5oktQEqWaFK3+sKflZ70zE+RMHTeoViguwsdU=
X-Google-Smtp-Source: ABdhPJykr0YS1i2D8JNoLfsGUJMVkKRcydxczm15zIZ3oRNXoDKUuM7sU9Hkx+Xh4sc77HgBC3eiPtWz2Bc7EVrNF6E=
X-Received: by 2002:a25:ca05:0:b0:61d:8c0e:ce54 with SMTP id
 a5-20020a25ca05000000b0061d8c0ece54mr3055674ybg.624.1645030760583; Wed, 16
 Feb 2022 08:59:20 -0800 (PST)
MIME-Version: 1.0
References: <1643016384-11161-1-git-send-email-loic.poulain@linaro.org>
 <CAJZ5v0hJzZpLv69coibEApT9zOxZ43mmOixNo5TZtizbUCFSTA@mail.gmail.com>
 <CAMZdPi-72Yo3z6sM7Do7PxcfqQamXfoEG-9vj4SC=GqZj5-gVg@mail.gmail.com>
 <CAJZ5v0hVQxGbc=-adRLrPM-qYYz7ZgHzkEWr-zPy=ZG+bGguQA@mail.gmail.com> <CAMZdPi_TX=ac_3U5DXWvPrfHRFLBrYJOwz3Sh2nCz4rybyydkQ@mail.gmail.com>
In-Reply-To: <CAMZdPi_TX=ac_3U5DXWvPrfHRFLBrYJOwz3Sh2nCz4rybyydkQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Feb 2022 17:59:09 +0100
Message-ID: <CAJZ5v0jAchLLyjq78b2LCs4623fO=k=gsPrTGXJuhs8bFBA4ug@mail.gmail.com>
Subject: Re: [RESEND PATCH] PM: wakeup: Wakeup accounting for interrupts
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry for the delay.

On Fri, Jan 28, 2022 at 10:55 AM Loic Poulain <loic.poulain@linaro.org> wrote:
>
> On Thu, 27 Jan 2022 at 20:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jan 27, 2022 at 9:51 AM Loic Poulain <loic.poulain@linaro.org> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Wed, 26 Jan 2022 at 19:23, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Mon, Jan 24, 2022 at 10:14 AM Loic Poulain <loic.poulain@linaro.org> wrote:
> > > > >
> > > > > Most of the time, system wakeup is caused by a wakeup-enabled
> > > > > interrupt, but the accounting is not done for the related wakeup
> > > > > source, causing 'wrong' values reported by device's wakeup attributes
> > > > > and debugfs stats (debug/wakeup_sources).
> > > > >
> > > > > This change reports a wakeup event for any wakeup-sources the irq is
> > > > > attached with.
> > > > >
> > > > > Note: This only works for drivers explicitly attaching the irq to
> > > > > a given device (e.g. with dev_pm_set_wake_irq).
> > > > >
> > > > > Note2: Some drivers call pm_wakeup_event() in their irq handler, but
> > > > > not all, moreover, an interrupt can be disabled while being flagged
> > > > > as wakeup source, and so accounting must be performed. This solution
> > > > > ensures that accounting will always be done for the interrupt waking
> > > > > up the host.
> > > > >
> > > > > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > > > > ---
> > > > >  drivers/base/power/wakeup.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > >
> > > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > > > > index 99bda0da..2d75e057 100644
> > > > > --- a/drivers/base/power/wakeup.c
> > > > > +++ b/drivers/base/power/wakeup.c
> > > > > @@ -952,8 +952,19 @@ void pm_wakeup_clear(bool reset)
> > > > >  void pm_system_irq_wakeup(unsigned int irq_number)
> > > > >  {
> > > > >         if (pm_wakeup_irq == 0) {
> > > > > +               struct wakeup_source *ws;
> > > > > +               int srcuidx;
> > > > > +
> > > > >                 pm_wakeup_irq = irq_number;
> > > > >                 pm_system_wakeup();
> > > > > +
> > > > > +               /* wakeup accounting */
> > > > > +               srcuidx = srcu_read_lock(&wakeup_srcu);
> > > >
> > > > This is called from interrupt context, so srcu_read_lock() cannot be used here.
> > >
> > >
> > > AFAIU from srcu.h, it is not prohibited, right? and we are not
> > > blocking while locked here.
> >
> > OK, you can do that if you release it from the same context.
> >
> > There are other concerns regarding this change, though.
> >
> > First off, it adds overhead for all systems, but the benefit is there
> > only for the systems where wake IRQs are used.
>
> It adds very little overhead for interrupts with armed wakeup, during
> system suspend(ing/ed) only, other IRQs are not affected.
>
> >
> > Second, it may lead to reporting the same wakeup event twice in a row
> > if the driver decides to do that too.  Is this not a problem?
>
> That's a legitimate point, but I don't see it as a big concern
> compared to not recording the event at all. If a driver deliberately
> attaches an interrupt to a wake source, it seems sane to expect that
> this interrupt will cause a corresponding wakeup event (should
> probably be documented), whatever the driver's irq handler is doing.

This needs to be rebased on top of 5.17-rc4 after a somewhat related
bug fix that went into it.

Moreover, I think that you'd want to do the below for all of the
wakeup interrupts that trigger, not just for the first one.

Also, the problem mentioned in the changelog is not limited to devices
having dedicated wakeup IRQs, but the proposed approach to address it
is.  Why are the other cases not relevant?

> >
> > > > > +               list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> > > > > +                       if (ws->wakeirq && ws->wakeirq->irq == irq_number)
> > > > > +                               pm_wakeup_ws_event(ws, 0, false);
> > > > > +               }
> > > > > +               srcu_read_unlock(&wakeup_srcu, srcuidx);
> > > > >         }
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.7.4
> > > > >
