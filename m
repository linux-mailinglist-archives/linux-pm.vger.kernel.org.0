Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB94B8FAB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiBPRtC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 12:49:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiBPRs7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 12:48:59 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1430B254A55
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 09:48:45 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id k15so1647682vkn.13
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 09:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRe5LckmNhq+Nd6hET/bBHpqk9iRW+hx59hq1a3uWLs=;
        b=iNcLStc9wkCear1pL1UFW0/GFWW9J/lj6z36yMQAqXwgxAkrzGXo54uQyfvJbDvWAx
         49tK4bd9qKy9fGVHXbzeoeu4kDuR84IzA+syu6EAakDlUgzlm84ttMCtDekIHAfjj12S
         kYOl+iCoYLS9Mc9y26Dh/KUHYKeTiyCZN4hBS/gKbVeqETk7Aw7j1jA8R+b42oIy7z8F
         nreR4oFtiTQSs1bd526jyj+C3XJrsRY3+QMEW01mO7GhNZXTKoBzHML/qBCRwodgUdPI
         +L7Eup1hyH8s6d+mRpbjSkIaoa95CvgL5buVz5VpVjuS/Hrxfj2tGQSa7pzUkHvZKqIX
         nG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRe5LckmNhq+Nd6hET/bBHpqk9iRW+hx59hq1a3uWLs=;
        b=MZ3KRJ2FNh8Jyg9xWHiD1cht2y3Frm6eOwpMoh195T7pMPb5byNTcAGbVBjcbrDG9A
         h6aJ8+RC5YQK9AUmtUbyTNYucOBVsiT7xE/YKGkH6BgneTY+0arOjH+HKpru3uGt4z5m
         nsE9ALqGzAVgZEg1F867+dfeunfZGaKyrnwjbely1WQL2QjAEvGqMyGEj3uMcERvkhmV
         LOOwC8F6vIlGck8+asL4+XfeVdH8BlwZPDpISkmISbnxO4U+LNjijE/Trzvskj5Ej+s6
         bJDONgBeIrq3tNsBdOMssOVtSjEX8Rg7+BQXoKhgTTRkaF1honkVxuJhlhI9Pmb3uR+t
         zzMA==
X-Gm-Message-State: AOAM531QDOtIfPmL+/5xC233x5dFxvmiHUy4hefBNHPrHZTHgLuUzzuC
        KHVlPvb8dvH8Lr6qjgccqiJ3x9gw/UBl52yffNDC6Q==
X-Google-Smtp-Source: ABdhPJzp17nOhCXbRdkG5tWAPWYhg2rIFMfBovWUDUb+vC75v6UHpfPsnMVNbKBpapJAhQvLAslBn9//mUQgmio7qAQ=
X-Received: by 2002:a1f:2ecc:0:b0:329:675:c7c5 with SMTP id
 u195-20020a1f2ecc000000b003290675c7c5mr1498375vku.23.1645033724022; Wed, 16
 Feb 2022 09:48:44 -0800 (PST)
MIME-Version: 1.0
References: <1643016384-11161-1-git-send-email-loic.poulain@linaro.org>
 <CAJZ5v0hJzZpLv69coibEApT9zOxZ43mmOixNo5TZtizbUCFSTA@mail.gmail.com>
 <CAMZdPi-72Yo3z6sM7Do7PxcfqQamXfoEG-9vj4SC=GqZj5-gVg@mail.gmail.com>
 <CAJZ5v0hVQxGbc=-adRLrPM-qYYz7ZgHzkEWr-zPy=ZG+bGguQA@mail.gmail.com>
 <CAMZdPi_TX=ac_3U5DXWvPrfHRFLBrYJOwz3Sh2nCz4rybyydkQ@mail.gmail.com> <CAJZ5v0jAchLLyjq78b2LCs4623fO=k=gsPrTGXJuhs8bFBA4ug@mail.gmail.com>
In-Reply-To: <CAJZ5v0jAchLLyjq78b2LCs4623fO=k=gsPrTGXJuhs8bFBA4ug@mail.gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 16 Feb 2022 18:48:08 +0100
Message-ID: <CAMZdPi_VNbB5wbMVY--i1Fg1q0ubjiF9EbfiiRJM_ytiYdrE3Q@mail.gmail.com>
Subject: Re: [RESEND PATCH] PM: wakeup: Wakeup accounting for interrupts
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 16 Feb 2022 at 17:59, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Sorry for the delay.
>
> On Fri, Jan 28, 2022 at 10:55 AM Loic Poulain <loic.poulain@linaro.org> wrote:
> >
> > On Thu, 27 Jan 2022 at 20:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Jan 27, 2022 at 9:51 AM Loic Poulain <loic.poulain@linaro.org> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > On Wed, 26 Jan 2022 at 19:23, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Mon, Jan 24, 2022 at 10:14 AM Loic Poulain <loic.poulain@linaro.org> wrote:
> > > > > >
> > > > > > Most of the time, system wakeup is caused by a wakeup-enabled
> > > > > > interrupt, but the accounting is not done for the related wakeup
> > > > > > source, causing 'wrong' values reported by device's wakeup attributes
> > > > > > and debugfs stats (debug/wakeup_sources).
> > > > > >
> > > > > > This change reports a wakeup event for any wakeup-sources the irq is
> > > > > > attached with.
> > > > > >
> > > > > > Note: This only works for drivers explicitly attaching the irq to
> > > > > > a given device (e.g. with dev_pm_set_wake_irq).
> > > > > >
> > > > > > Note2: Some drivers call pm_wakeup_event() in their irq handler, but
> > > > > > not all, moreover, an interrupt can be disabled while being flagged
> > > > > > as wakeup source, and so accounting must be performed. This solution
> > > > > > ensures that accounting will always be done for the interrupt waking
> > > > > > up the host.
> > > > > >
> > > > > > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > > > > > ---
> > > > > >  drivers/base/power/wakeup.c | 11 +++++++++++
> > > > > >  1 file changed, 11 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > > > > > index 99bda0da..2d75e057 100644
> > > > > > --- a/drivers/base/power/wakeup.c
> > > > > > +++ b/drivers/base/power/wakeup.c
> > > > > > @@ -952,8 +952,19 @@ void pm_wakeup_clear(bool reset)
> > > > > >  void pm_system_irq_wakeup(unsigned int irq_number)
> > > > > >  {
> > > > > >         if (pm_wakeup_irq == 0) {
> > > > > > +               struct wakeup_source *ws;
> > > > > > +               int srcuidx;
> > > > > > +
> > > > > >                 pm_wakeup_irq = irq_number;
> > > > > >                 pm_system_wakeup();
> > > > > > +
> > > > > > +               /* wakeup accounting */
> > > > > > +               srcuidx = srcu_read_lock(&wakeup_srcu);
> > > > >
> > > > > This is called from interrupt context, so srcu_read_lock() cannot be used here.
> > > >
> > > >
> > > > AFAIU from srcu.h, it is not prohibited, right? and we are not
> > > > blocking while locked here.
> > >
> > > OK, you can do that if you release it from the same context.
> > >
> > > There are other concerns regarding this change, though.
> > >
> > > First off, it adds overhead for all systems, but the benefit is there
> > > only for the systems where wake IRQs are used.
> >
> > It adds very little overhead for interrupts with armed wakeup, during
> > system suspend(ing/ed) only, other IRQs are not affected.
> >
> > >
> > > Second, it may lead to reporting the same wakeup event twice in a row
> > > if the driver decides to do that too.  Is this not a problem?
> >
> > That's a legitimate point, but I don't see it as a big concern
> > compared to not recording the event at all. If a driver deliberately
> > attaches an interrupt to a wake source, it seems sane to expect that
> > this interrupt will cause a corresponding wakeup event (should
> > probably be documented), whatever the driver's irq handler is doing.
>
> This needs to be rebased on top of 5.17-rc4 after a somewhat related
> bug fix that went into it.

Ok

>
>
> Moreover, I think that you'd want to do the below for all of the
> wakeup interrupts that trigger, not just for the first one.

Yes you're right, it makes sense.

>
>
> Also, the problem mentioned in the changelog is not limited to devices
> having dedicated wakeup IRQs, but the proposed approach to address it
> is.  Why are the other cases not relevant?

Not sure to understand what other cases you are referring to? here we
ensure that interrupts bound to a wakeup-source trigger the
corresponding wakeup event. So the ones configured via one of the
dev_pm_set_(dedicated_)wake_irq functions. But many drivers do not
explicitly attach IRQ as device's wake-irq, so there is no attached
wakeup-source to manage in that case.


>
>
> > >
> > > > > > +               list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> > > > > > +                       if (ws->wakeirq && ws->wakeirq->irq == irq_number)
> > > > > > +                               pm_wakeup_ws_event(ws, 0, false);
> > > > > > +               }
> > > > > > +               srcu_read_unlock(&wakeup_srcu, srcuidx);
> > > > > >         }
> > > > > >  }
> > > > > >
> > > > > > --
> > > > > > 2.7.4
> > > > > >
