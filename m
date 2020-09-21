Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047122726C1
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 16:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgIUOPR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 10:15:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34973 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgIUOPQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 10:15:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id o6so12468582ota.2;
        Mon, 21 Sep 2020 07:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSuNx5iI/OJ6Z/gYoNUI3kSkgsNrBIRpVHSXiUBoJ5w=;
        b=Zz6C9h7hwzCz1AmxTZ1iHFeSBowiybOPcYhmIbfPmKVNbN+9jTzrkqPx7DU1TVkdk2
         R8lT54g/+rHVsN4dRTfNsNIVD1/L6IEEIU0L1kGjTfH9w6yVUhM8VD8LPG+iIf7iQFLP
         omhG4Wj/B7zoAd0MH3OnadCvPwfEJ2Q1sbOAG48w2ZmUWHkZrlJDKUOK8qwxC4NXB0VU
         m6VbWrDsbReSLaJGhWVl6YxYlHWOPLJLY/4JtofKYKxTTh31ml7FOmRwve5eY4R4BEbI
         5k7tzxo7QfX46ltBX4gpukRFU68DmXf81TipX8TfoR+FT8MduImm9KAiq8v3a8bCPkQx
         Hl/g==
X-Gm-Message-State: AOAM532Dh/oSsXhag1+KnjkEZhJul6o2IfHanzwSOgp/iNeYSwgZ/Gcq
        w0UC8ZcYbN2Y7fI19SS1BpW6h3mvuRXX/6CtuNU=
X-Google-Smtp-Source: ABdhPJzkjPnsDI6GKmMx9reL3cE4Wwu3RkVhPxyLkDkECtfV3Ub2yNwh7ZDLrlXM6iT3pC+evVidlRkxKGGiXrUokjw=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr31722498otj.262.1600697715799;
 Mon, 21 Sep 2020 07:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200918165518.23246-1-grygorii.strashko@ti.com> <CAKfTPtApNLAYq-=UcD6bM8nhT3pp3DSp2bCxFsTF3AZKs6Qz3g@mail.gmail.com>
In-Reply-To: <CAKfTPtApNLAYq-=UcD6bM8nhT3pp3DSp2bCxFsTF3AZKs6Qz3g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 16:15:00 +0200
Message-ID: <CAJZ5v0jcTkQe68zgrxgpZvghFMAbnfui5wc=t3mh87fr0gu6Hw@mail.gmail.com>
Subject: Re: [PATCH] pm: runtime: fix timer_expires on 32bits arch
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 21, 2020 at 8:51 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 18 Sep 2020 at 18:55, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> >
> > The commit 8234f6734c5d ("PM-runtime: Switch autosuspend over to using
> > hrtimers") switched PM runtime autosuspend to use hrtimers and all related
> > time accounting in ns, but missed update the struct
> > dev_pm_info->timer_expires to u64. This causes timer_expires value to be
> > truncated on 32bits architectures when assignment is done from u64 values:
> >
> > rpm_suspend()
> > |- dev->power.timer_expires = expires;
> >
> > Hence, fix it by changing timer_expires type to u64.
> >
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

Applied as 5.9-rc7 material with some edits in the subject and
changelog, thanks!

> > ---
> >  include/linux/pm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index a30a4b54df52..47aca6bac1d6 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -590,7 +590,7 @@ struct dev_pm_info {
> >  #endif
> >  #ifdef CONFIG_PM
> >         struct hrtimer          suspend_timer;
> > -       unsigned long           timer_expires;
> > +       u64                     timer_expires;
> >         struct work_struct      work;
> >         wait_queue_head_t       wait_queue;
> >         struct wake_irq         *wakeirq;
> > --
> > 2.17.1
> >
