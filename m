Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85854281CF5
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 22:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgJBUaC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 16:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJBU37 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Oct 2020 16:29:59 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08EF20738;
        Fri,  2 Oct 2020 20:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601670598;
        bh=Jq5FzMIKmv4HKvsTHTbzBndTI/C6/P9+f3xYup51fmQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WwK+A1Vq7uhVXQ6AEmIpf3a+ikFA9l00RGtIbRbn7svPlKReu3uJ2XDx4v9mTHkTd
         BqyTfMjccoipnL81D2qcj2Nf/t1e7JYGdsKdCM6HH9KysPZvHZjN5nznCks6UFbILu
         zbvX4qFnrZ4ZC2FKS/kcgfrWAK0tlbs3Ie0RdyW0=
Received: by mail-ot1-f53.google.com with SMTP id y5so2660532otg.5;
        Fri, 02 Oct 2020 13:29:58 -0700 (PDT)
X-Gm-Message-State: AOAM531eVWlxxd36c/4qpI9bV/qRpLrKVzhzU6yPnKlnnHyWgX5/ym4/
        z4K8THe8kfNFrue5aNeHGiKe9JPaug72PQiHMg==
X-Google-Smtp-Source: ABdhPJxjkMJXnwwneaZ30p+ovuBJv9kbNXIuM/tlm4T0DCPig5Sg2rY21BiwauWKc1Ygp6O0+2yBJfiJcTLJAo3+Voo=
X-Received: by 2002:a9d:7998:: with SMTP id h24mr3076133otm.192.1601670597975;
 Fri, 02 Oct 2020 13:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com> <CAL_JsqKOUkKBKyxPtZ+BFXPiOfm2uPXhgJPxKP=WS-qX6kSB0w@mail.gmail.com>
 <CAGETcx-tq446JQN0RpKhtyCXB+Y_PUePN_tBZsUmtpO7othm4g@mail.gmail.com>
In-Reply-To: <CAGETcx-tq446JQN0RpKhtyCXB+Y_PUePN_tBZsUmtpO7othm4g@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 2 Oct 2020 15:29:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+6mxtFei3+1ic4c5XCftJ8nZK6_S5_d15yEXQ02BTNKw@mail.gmail.com>
Message-ID: <CAL_Jsq+6mxtFei3+1ic4c5XCftJ8nZK6_S5_d15yEXQ02BTNKw@mail.gmail.com>
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 2, 2020 at 12:52 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, Oct 2, 2020 at 7:08 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Oct 1, 2020 at 5:59 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> > > adding all top level devices") optimized the fwnode parsing when all top
> > > level devices are added, it missed out optimizing this for platform
> > > where the top level devices are added through the init_machine() path.
> > >
> > > This commit does the optimization for all paths by simply moving the
> > > fw_devlink_pause/resume() inside of_platform_default_populate().
> > >
> > > Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/of/platform.c | 19 +++++++++++++++----
> > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > index 071f04da32c8..79972e49b539 100644
> > > --- a/drivers/of/platform.c
> > > +++ b/drivers/of/platform.c
> > > @@ -501,8 +501,21 @@ int of_platform_default_populate(struct device_node *root,
> > >                                  const struct of_dev_auxdata *lookup,
> > >                                  struct device *parent)
> > >  {
> > > -       return of_platform_populate(root, of_default_bus_match_table, lookup,
> > > -                                   parent);
> > > +       int ret;
> > > +
> > > +       /*
> > > +        * fw_devlink_pause/resume() are only safe to be called around top
> > > +        * level device addition due to locking constraints.
> > > +        */
> > > +       if (!root)
> > > +               fw_devlink_pause();
> > > +
> > > +       ret = of_platform_populate(root, of_default_bus_match_table, lookup,
> > > +                                  parent);
> >
> > of_platform_default_populate() vs. of_platform_populate() is just a
> > different match table. I don't think the behavior should otherwise be
> > different.
> >
> > There's also of_platform_probe() which has slightly different matching
> > behavior. It should not behave differently either with respect to
> > devlinks.
>
> So I'm trying to do this only when the top level devices are added for
> the first time. of_platform_default_populate() seems to be the most
> common path. For other cases, I think we just need to call
> fw_devlink_pause/resume() wherever the top level devices are added for
> the first time.

> As I said in the other email, we can't add
> fw_devlink_pause/resume() by default to of_platform_populate().

If you detect it's the first time, you could?

>
> Do you have other ideas for achieving "call fw_devlink_pause/resume()
> only when top level devices are added for the first time"?

Eliminate the cases not using of_platform_default_populate().

There's 2 main reasons for the non default cases. The first is
auxdata. Really, for any modern platform that people care about (and
care about the boot time), they should not be using auxdata. That's
just for the DT transition. You know, a temporary thing from 9 years
ago.

The 2nd is having some parent device. This is typically an soc_device.
I really think this is kind of dumb. We should either have the parent
device always or never. After all, everything's an SoC right? Of
course changing that will break some Android systems since they like
to use non-ABI sysfs device paths.

There could also be some initcall ordering issues. IIRC, in the last
round of cleanups in this area, at91 gpio/pinctrl had an issue with
that. I think I have a half done fix for that I started.

Rob
