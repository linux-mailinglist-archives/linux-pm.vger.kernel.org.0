Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D504449EAC4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 20:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiA0TFJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jan 2022 14:05:09 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:45785 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiA0TFJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jan 2022 14:05:09 -0500
Received: by mail-yb1-f181.google.com with SMTP id h14so11539567ybe.12
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 11:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1U679GeRmwDsEeE4q7sRmalIaEnPsnxxQ8AZgPCb1ek=;
        b=qqmWTByH7HBUQ/O+zYCY8xdSxYefMqVcwIeHP12xHr/GuNOlH6x2C1pX5wJxdsyazg
         Tt+oHlEJvf8bJ0F5OKqH91WrhF9CSgqZcUZapQ45S61syC4RMoA+m4GYcN72muLzkxKL
         fuPhD2jmgAx2BbdSfy0NiPnsb15FOKcjS2B9p0XxB9IlZ8ahuzQpVnwecFjjRNfec/mJ
         MBTeI3reIRHGL2c3DoGjN+oSLJvOfloRnfOPcvW2/d93gIXdjI4Xrv0GA0fn2342GXEz
         GWJRIvy6N8wjh53cj7v8KbfOp8wdHX12zAXi/XO1v9RFs15tb7JcIWT1FHPlLlpLDWPu
         o1jw==
X-Gm-Message-State: AOAM531pJCh5xWTGOrN1KcuLPFuBZnk3REj/qK4WcnsMU3Ngic10Mkol
        z8oAMBzGlI4QnWQWmQj7tt+JoIQdoy5/nuprzt4g+IBR
X-Google-Smtp-Source: ABdhPJyaWS0T120koYMAgoYJihiGnQCIgzmSlhnholKcMds+/fq7bDc8JNU7AL3cpUEDx8nXTD13BsGEPrg7+Z+eH8M=
X-Received: by 2002:a05:6902:54c:: with SMTP id z12mr7050502ybs.624.1643310308921;
 Thu, 27 Jan 2022 11:05:08 -0800 (PST)
MIME-Version: 1.0
References: <1643016384-11161-1-git-send-email-loic.poulain@linaro.org>
 <CAJZ5v0hJzZpLv69coibEApT9zOxZ43mmOixNo5TZtizbUCFSTA@mail.gmail.com> <CAMZdPi-72Yo3z6sM7Do7PxcfqQamXfoEG-9vj4SC=GqZj5-gVg@mail.gmail.com>
In-Reply-To: <CAMZdPi-72Yo3z6sM7Do7PxcfqQamXfoEG-9vj4SC=GqZj5-gVg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jan 2022 20:04:57 +0100
Message-ID: <CAJZ5v0hVQxGbc=-adRLrPM-qYYz7ZgHzkEWr-zPy=ZG+bGguQA@mail.gmail.com>
Subject: Re: [RESEND PATCH] PM: wakeup: Wakeup accounting for interrupts
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 27, 2022 at 9:51 AM Loic Poulain <loic.poulain@linaro.org> wrote:
>
> Hi Rafael,
>
> On Wed, 26 Jan 2022 at 19:23, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Jan 24, 2022 at 10:14 AM Loic Poulain <loic.poulain@linaro.org> wrote:
> > >
> > > Most of the time, system wakeup is caused by a wakeup-enabled
> > > interrupt, but the accounting is not done for the related wakeup
> > > source, causing 'wrong' values reported by device's wakeup attributes
> > > and debugfs stats (debug/wakeup_sources).
> > >
> > > This change reports a wakeup event for any wakeup-sources the irq is
> > > attached with.
> > >
> > > Note: This only works for drivers explicitly attaching the irq to
> > > a given device (e.g. with dev_pm_set_wake_irq).
> > >
> > > Note2: Some drivers call pm_wakeup_event() in their irq handler, but
> > > not all, moreover, an interrupt can be disabled while being flagged
> > > as wakeup source, and so accounting must be performed. This solution
> > > ensures that accounting will always be done for the interrupt waking
> > > up the host.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > > ---
> > >  drivers/base/power/wakeup.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > > index 99bda0da..2d75e057 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -952,8 +952,19 @@ void pm_wakeup_clear(bool reset)
> > >  void pm_system_irq_wakeup(unsigned int irq_number)
> > >  {
> > >         if (pm_wakeup_irq == 0) {
> > > +               struct wakeup_source *ws;
> > > +               int srcuidx;
> > > +
> > >                 pm_wakeup_irq = irq_number;
> > >                 pm_system_wakeup();
> > > +
> > > +               /* wakeup accounting */
> > > +               srcuidx = srcu_read_lock(&wakeup_srcu);
> >
> > This is called from interrupt context, so srcu_read_lock() cannot be used here.
>
>
> AFAIU from srcu.h, it is not prohibited, right? and we are not
> blocking while locked here.

OK, you can do that if you release it from the same context.

There are other concerns regarding this change, though.

First off, it adds overhead for all systems, but the benefit is there
only for the systems where wake IRQs are used.

Second, it may lead to reporting the same wakeup event twice in a row
if the driver decides to do that too.  Is this not a problem?

> > > +               list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> > > +                       if (ws->wakeirq && ws->wakeirq->irq == irq_number)
> > > +                               pm_wakeup_ws_event(ws, 0, false);
> > > +               }
> > > +               srcu_read_unlock(&wakeup_srcu, srcuidx);
> > >         }
> > >  }
> > >
> > > --
> > > 2.7.4
> > >
