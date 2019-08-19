Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC5991EC1
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 10:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfHSIUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 04:20:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35517 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfHSIUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 04:20:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id g17so908983otl.2;
        Mon, 19 Aug 2019 01:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xS8pnTXr+3PwEje+y6dB7oMHpWB4o5rNXOdh/Rkk++Q=;
        b=Bh00pV3P2Tc1HHvbUwcmcyHK7qdEFnNeS6c007CgKYO/XFQ/4AgjFEZpYLqGcszjlQ
         7mTj+4p9AtuKr2cxXYxoEwn4W+wRVb6Kgf11wr//5Exm7ERuD7x+cWqN738/ZR/2X+1/
         fKMB6imCQxkbSfAhCTumTC65XYuUMJS+xQ2ZTtHGwAUNNB/9qr5+tb6evgUFg/5nIG09
         qmOrrSGHvA4tfJJB51iPvF5KXQZF/XmeluahA5Wa1plGRDSnzkvJikFJ0EaZmyWI9ism
         YgEI+lo23U0QkR32t9r4ZGPEK8PSb0q48jmZT8aWltS/shmZF44vQBEp5nXJqQ2eK1dy
         OBZQ==
X-Gm-Message-State: APjAAAWeKojBLxvADFXLcJQRGquIS687sM0XvJSj4kHA5QUnfjd3seQ5
        /YoNzvaNQsz5yCLc6X6hjOVef7vrAXClwZ0JEYY=
X-Google-Smtp-Source: APXvYqzWpuiaz71ScmIyZbNRmxlq1ByZY1iRfxME8FhAce0Jv5HInimy281JwzZBnuDa9m2zO5ABaIRP6MB3pyYh/eI=
X-Received: by 2002:a9d:674c:: with SMTP id w12mr13640118otm.118.1566202822686;
 Mon, 19 Aug 2019 01:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190724074722.12270-1-ran.wang_1@nxp.com> <4158639.B12JYek7R7@kreacher>
 <DB8PR04MB682632A586827032F8D6EA2DF1A80@DB8PR04MB6826.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB682632A586827032F8D6EA2DF1A80@DB8PR04MB6826.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Aug 2019 10:20:11 +0200
Message-ID: <CAJZ5v0i58p-GsswzMGEsgD5OXDqJ_G5zXDYf8jq8JJbWxZv+nQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] PM: wakeup: Add routine to help fetch wakeup
 source object.
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Biwen Li <biwen.li@nxp.com>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 19, 2019 at 10:15 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Hi Rafael,
>
> On Monday, August 05, 2019 17:59, Rafael J. Wysocki wrote:
> >
> > On Wednesday, July 24, 2019 9:47:20 AM CEST Ran Wang wrote:
> > > Some user might want to go through all registered wakeup sources and
> > > doing things accordingly. For example, SoC PM driver might need to do
> > > HW programming to prevent powering down specific IP which wakeup
> > > source depending on. So add this API to help walk through all
> > > registered wakeup source objects on that list and return them one by one.
> > >
> > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > ---
> > > Change in v5:
> > >     - Update commit message, add decription of walk through all wakeup
> > >     source objects.
> > >     - Add SCU protection in function wakeup_source_get_next().
> > >     - Rename wakeup_source member 'attached_dev' to 'dev' and move it
> > up
> > >     (before wakeirq).
> > >
> > > Change in v4:
> > >     - None.
> > >
> > > Change in v3:
> > >     - Adjust indentation of *attached_dev;.
> > >
> > > Change in v2:
> > >     - None.
> > >
> > >  drivers/base/power/wakeup.c | 24 ++++++++++++++++++++++++
> > >  include/linux/pm_wakeup.h   |  3 +++
> > >  2 files changed, 27 insertions(+)
> > >
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > > index ee31d4f..2fba891 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/suspend.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/debugfs.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/pm_wakeirq.h>
> > >  #include <trace/events/power.h>
> > >
> > > @@ -226,6 +227,28 @@ void wakeup_source_unregister(struct
> > wakeup_source *ws)
> > >     }
> > >  }
> > >  EXPORT_SYMBOL_GPL(wakeup_source_unregister);
> > > +/**
> > > + * wakeup_source_get_next - Get next wakeup source from the list
> > > + * @ws: Previous wakeup source object, null means caller want first one.
> > > + */
> > > +struct wakeup_source *wakeup_source_get_next(struct wakeup_source
> > > +*ws) {
> > > +   struct list_head *ws_head = &wakeup_sources;
> > > +   struct wakeup_source *next_ws = NULL;
> > > +   int idx;
> > > +
> > > +   idx = srcu_read_lock(&wakeup_srcu);
> > > +   if (ws)
> > > +           next_ws = list_next_or_null_rcu(ws_head, &ws->entry,
> > > +                           struct wakeup_source, entry);
> > > +   else
> > > +           next_ws = list_entry_rcu(ws_head->next,
> > > +                           struct wakeup_source, entry);
> > > +   srcu_read_unlock(&wakeup_srcu, idx);
> > > +
> >
> > This is incorrect.
> >
> > The SRCU cannot be unlocked until the caller of this is done with the object
> > returned by it, or that object can be freed while it is still being accessed.
>
> Thanks for the comment. Looks like I was not fully understanding your point on
> v4 discussion. So I will implement 3 APIs by referring wakeup_sources_stats_seq_start/next/stop()
>
> > Besides, this patch conflicts with some general wakeup sources changes in the
> > works, so it needs to be deferred and rebased on top of those changes.
>
> Could you please tell me which is the right code base I should developing on?
> I just tried applying v5 patch on latest git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git branch master (d1abaeb Linux 5.3-rc5)
> and no conflict encountered.

It is better to use the most recent -rc from Linus (5.3-rc5 as of
today) as the base unless your patches depend on some changes that are
not in there.
