Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CCC281A50
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgJBR7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387789AbgJBR7c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 13:59:32 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652ADC0613E4
        for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2020 10:59:32 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id s19so1770883ybc.5
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2020 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZbuayUw4nR5ldchYC0QJ2SKyNmd/sp/ZArDf0aVmf4=;
        b=hxne4JB9HZja3FImgOTwwGft+D9UZ0uS9fK4OcJP2Eg1oroqmn/9modjXkPJGSlN8g
         Lh5UDYM7CynmC7F+t8Uq5psnpU8Z5iPg+RgiXlsA6p/lD2mphiU75QAqHBKi1YSqj7XW
         7LoAJgH6xJq1blMl4m/G5sIIkMci/wvcZrPRhucqEIygDXBzfFT+Qf7VHFgFAyQk/z+1
         F/V36+u2ogFL7XMkvpu/ekSzZkW2RoA3QWTLoD2astGElGbvCRuXZLvLQNp8zSMbfqsI
         izqQ+mlyGkYqerxmFose6Nqt7AAsAnO9detgWoYY7GHj8Az83ZD5RLrYOddI9P+0V/ml
         IIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZbuayUw4nR5ldchYC0QJ2SKyNmd/sp/ZArDf0aVmf4=;
        b=rmQP4I8i/UV3Sgs5s4E3IwiaPZqWHQQT66Gl5YJ21ltNbtSUex+NUdkFPOBmRAcR/w
         ZX+r6b/XrJd4AIOaARkif5mGDQqHsXZHYCZDMJYpouSNCSMAJGWTrWYCAszjlxjh7rTc
         UMmxfICZEzvFluiCMbP5LzgexWWBtNKRCgEjr/B+zcnw3jIB7kvg40VKzA6/NMZ6KbnI
         hjWhBTKA1nKFznKkpxZ8nlQeqx87+QzZ/bLQ1AvC0ftKup6Awrwkc9D+65DNQ0k3hvh4
         TF5EQjx9nNiYiTVjTLTU87eRAZ0d9xVQXxBZnQFRL+lNcdTXSQkJdK8gJu8OLCGqPqKV
         Bp1A==
X-Gm-Message-State: AOAM531oFFaC9fda9TaEYlq66VPSMmsOjsDChv3XKS6LQs+kXSaMGg9n
        pLmTfR/k3Ej1nM7PGK4JA/Z3A0Fm4qhqrXSYuSx/Wg==
X-Google-Smtp-Source: ABdhPJy+2uWxMGaMD27VX8hqKxgrKfNstiISBRAtvv2ZfenCYYbpD2QB2rzAxASzDDq7221cpxy+ivvqhR77p6L+E3Y=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr4142164ybt.346.1601661571259;
 Fri, 02 Oct 2020 10:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com> <CAL_JsqKOUkKBKyxPtZ+BFXPiOfm2uPXhgJPxKP=WS-qX6kSB0w@mail.gmail.com>
 <CAGETcx-tq446JQN0RpKhtyCXB+Y_PUePN_tBZsUmtpO7othm4g@mail.gmail.com> <20201002175423.GE3933@pendragon.ideasonboard.com>
In-Reply-To: <20201002175423.GE3933@pendragon.ideasonboard.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 2 Oct 2020 10:58:55 -0700
Message-ID: <CAGETcx-7nJaU6pDo_KL-nKmCaxv57C5aaXq-pvo4XiN=N0K5Jg@mail.gmail.com>
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
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

On Fri, Oct 2, 2020 at 10:55 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Saravana,
>
> On Fri, Oct 02, 2020 at 10:51:51AM -0700, Saravana Kannan wrote:
> > On Fri, Oct 2, 2020 at 7:08 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > On Thu, Oct 1, 2020 at 5:59 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> > > > adding all top level devices") optimized the fwnode parsing when all top
> > > > level devices are added, it missed out optimizing this for platform
> > > > where the top level devices are added through the init_machine() path.
> > > >
> > > > This commit does the optimization for all paths by simply moving the
> > > > fw_devlink_pause/resume() inside of_platform_default_populate().
> > > >
> > > > Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/of/platform.c | 19 +++++++++++++++----
> > > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > > index 071f04da32c8..79972e49b539 100644
> > > > --- a/drivers/of/platform.c
> > > > +++ b/drivers/of/platform.c
> > > > @@ -501,8 +501,21 @@ int of_platform_default_populate(struct device_node *root,
> > > >                                  const struct of_dev_auxdata *lookup,
> > > >                                  struct device *parent)
> > > >  {
> > > > -       return of_platform_populate(root, of_default_bus_match_table, lookup,
> > > > -                                   parent);
> > > > +       int ret;
> > > > +
> > > > +       /*
> > > > +        * fw_devlink_pause/resume() are only safe to be called around top
> > > > +        * level device addition due to locking constraints.
> > > > +        */
> > > > +       if (!root)
> > > > +               fw_devlink_pause();
> > > > +
> > > > +       ret = of_platform_populate(root, of_default_bus_match_table, lookup,
> > > > +                                  parent);
> > >
> > > of_platform_default_populate() vs. of_platform_populate() is just a
> > > different match table. I don't think the behavior should otherwise be
> > > different.
> > >
> > > There's also of_platform_probe() which has slightly different matching
> > > behavior. It should not behave differently either with respect to
> > > devlinks.
> >
> > So I'm trying to do this only when the top level devices are added for
> > the first time. of_platform_default_populate() seems to be the most
> > common path. For other cases, I think we just need to call
> > fw_devlink_pause/resume() wherever the top level devices are added for
> > the first time. As I said in the other email, we can't add
> > fw_devlink_pause/resume() by default to of_platform_populate().
> >
> > Do you have other ideas for achieving "call fw_devlink_pause/resume()
> > only when top level devices are added for the first time"?
>
> I'm not an expert in this domain, but before investigating it, would you
> be able to share a hack patch that implements this (in the most simple
> way) to check if it actually fixes the delays I experience on my system
> ?

So I take it the patch I sent out didn't work for you? Can you tell me
what machine/DT you are using?

-Saravana
