Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B22A49DCF2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 09:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbiA0Iva (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jan 2022 03:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiA0IvZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jan 2022 03:51:25 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD50C06173B
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 00:51:24 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b15so1919258plg.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 00:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMD/9KT+0TDljaGa6+Xx6yHp8r59EU0NUBXxz39pQOM=;
        b=RdmydcqeqgncQoexyiKF0qvD+iYb3UvwvaPQQkTzMU1ABrAcvs4W1hPBArqIqKOOsV
         G2IRn3NWEer1Fbg7LNLZsBtXVyhaHaBh/t+PNv4tfBXKvxrcbxPmOHAX5XMdJzCSG6i3
         GmyBwYJR42wAupeDaKSPnAw8BpLI1zqQu0i8v5X2Y3A5iUw8tlgxTils3xQcCb23kVrp
         XPhG+ECjj6eaFTN+nZU7dKCGaOfA22MGjfgmz8bzhMDRGf7Zwm7pdx7gE8CN8jjEysay
         cr6q7+ja1pNJuvLdWs5M5hCWsO4JxT5zkOAoI5Nwv6mulH2CplLmRE7x5xRUQUAqNM87
         b+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMD/9KT+0TDljaGa6+Xx6yHp8r59EU0NUBXxz39pQOM=;
        b=sP9YIZcDoceN+5DJ9lGthghv71+P8ddNTukyYZeKfUNPLP8fRpVwN/OuPvHI5pmnFq
         HTNig2xLfg2DwOU8pNuw4wrS7AIZa16OwCDU5yA3EG/HvFmtXWkhwwy6k5PaAob2xNcb
         Koi1/F4Ysbizc7xZAuk6mYZmMes+tju0Hyr/peEDB27yaOHQQ4rDtrqYtz9UgU5CLTxI
         X0EHha8f9RSY0VDWGe3sMiqv48j/1o+Bky4GQkTxODO+utxajHJxxs0K6METDYE0XSyM
         nsyht7XqLQBXVjliw8oBCoIUtBPde4rRrah0zTOSGTg/zXWObZZyovHTOckDRpSITu2Y
         dBaw==
X-Gm-Message-State: AOAM533YTOpKJHjAxIdQ4FE6+PzU1YGo9BmfTij8Sfb2RoFFhf3TI9KP
        hysHy4AaQMSSblq5A0a99E7SYqKmuu1ZmPV1JaV7Kw==
X-Google-Smtp-Source: ABdhPJyRLBTXy+KfSpCWBf/cLPKhzxPHc8Kp9H/B31USU1kA0EVKgH5mAnu1t0kCUvDAqyyLqM57LTq6vt1pgq7Vsi8=
X-Received: by 2002:a17:90a:1383:: with SMTP id i3mr3169897pja.40.1643273484010;
 Thu, 27 Jan 2022 00:51:24 -0800 (PST)
MIME-Version: 1.0
References: <1643016384-11161-1-git-send-email-loic.poulain@linaro.org> <CAJZ5v0hJzZpLv69coibEApT9zOxZ43mmOixNo5TZtizbUCFSTA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hJzZpLv69coibEApT9zOxZ43mmOixNo5TZtizbUCFSTA@mail.gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 27 Jan 2022 10:02:58 +0100
Message-ID: <CAMZdPi-72Yo3z6sM7Do7PxcfqQamXfoEG-9vj4SC=GqZj5-gVg@mail.gmail.com>
Subject: Re: [RESEND PATCH] PM: wakeup: Wakeup accounting for interrupts
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Wed, 26 Jan 2022 at 19:23, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jan 24, 2022 at 10:14 AM Loic Poulain <loic.poulain@linaro.org> wrote:
> >
> > Most of the time, system wakeup is caused by a wakeup-enabled
> > interrupt, but the accounting is not done for the related wakeup
> > source, causing 'wrong' values reported by device's wakeup attributes
> > and debugfs stats (debug/wakeup_sources).
> >
> > This change reports a wakeup event for any wakeup-sources the irq is
> > attached with.
> >
> > Note: This only works for drivers explicitly attaching the irq to
> > a given device (e.g. with dev_pm_set_wake_irq).
> >
> > Note2: Some drivers call pm_wakeup_event() in their irq handler, but
> > not all, moreover, an interrupt can be disabled while being flagged
> > as wakeup source, and so accounting must be performed. This solution
> > ensures that accounting will always be done for the interrupt waking
> > up the host.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > ---
> >  drivers/base/power/wakeup.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index 99bda0da..2d75e057 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -952,8 +952,19 @@ void pm_wakeup_clear(bool reset)
> >  void pm_system_irq_wakeup(unsigned int irq_number)
> >  {
> >         if (pm_wakeup_irq == 0) {
> > +               struct wakeup_source *ws;
> > +               int srcuidx;
> > +
> >                 pm_wakeup_irq = irq_number;
> >                 pm_system_wakeup();
> > +
> > +               /* wakeup accounting */
> > +               srcuidx = srcu_read_lock(&wakeup_srcu);
>
> This is called from interrupt context, so srcu_read_lock() cannot be used here.


AFAIU from srcu.h, it is not prohibited, right? and we are not
blocking while locked here.

Regards,
Loic

>
>
> > +               list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> > +                       if (ws->wakeirq && ws->wakeirq->irq == irq_number)
> > +                               pm_wakeup_ws_event(ws, 0, false);
> > +               }
> > +               srcu_read_unlock(&wakeup_srcu, srcuidx);
> >         }
> >  }
> >
> > --
> > 2.7.4
> >
