Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F6069922E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Feb 2023 11:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjBPKtS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Feb 2023 05:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjBPKtQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Feb 2023 05:49:16 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D93AAC
        for <linux-pm@vger.kernel.org>; Thu, 16 Feb 2023 02:49:01 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b5so1627136plz.5
        for <linux-pm@vger.kernel.org>; Thu, 16 Feb 2023 02:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6+xi2ME8ZX2lb6ot9Rsw+Ht+BNOAfGS96KosqYuxn8=;
        b=eYVCCu/R+7i18PIF6WHGGVYA67YPCk4fHm3eavzS4L73+VYTt48nVESZg3MOhmf4ho
         8+hqRWB8N3G/TaxbQ8cOf89OI3QlgTDkLAotGfm1su3fBe8y+51mDrTeLdrmAU1rUO81
         dhDL9v65NSFU9d+FCA2uRmw+/rQ8kJYQ83bocUk3d1XXgbltSqdYeTbeVzIX9hSozXNq
         qaln9IeQm5BMA+w9iDosmMbwZ+g4qsy0NLVyCLX/g5zYhYxdaXF2t9aFu1vvCjk6Fo1u
         8Fh+X2dGaqjJpTQHsCRYk7uCjqS/Xn/RhCrizyxwMgzRl33fJZpMgsTjB42e6Dk61Kyh
         L4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6+xi2ME8ZX2lb6ot9Rsw+Ht+BNOAfGS96KosqYuxn8=;
        b=fJSuawsxbdSY3jEU1onIIcyICBiY8sVCAQj8qhlDSMCguuhC7tik+SwnXp27RG8zYF
         C+gnCsznVLCTbm79lQjwD7owO0SL//nxXFI8UW9Ju+AXGNPqcMranSTzvpVME3HCf6tZ
         wBcu3udCtaNcSE5UXCyjEAJdzp+GB3MGEUj0jgSdBEM93z/bSm7ja+NwfC0Z704zJZVw
         7U1cXbgtJenQ/o4TWEBb5jFLMP8jBZe4Kcj7JQQ9KAKJhmOnmQQxwhpTJ4gGkw6ea7i9
         lvJIohVJaFGDXKZdD7MKPFxLXQ6T6sioezuSv7cs8q9rVY29/yTTLJecX1DIgdHX1WXK
         SLQQ==
X-Gm-Message-State: AO0yUKVWQOekInlWAudLQbG6BVKFCTl7Gvq+N/oo5M4RVVwGZZjkna/V
        sLXWoANgs7yo5i81qb7skMMTHANOf4FCkMXVGri0zg==
X-Google-Smtp-Source: AK7set+Um+pSF64uUoc2CSXdSt/T59upWjiP7tjnsX9rT/J3jSz7hvPvYo2xapIh3vPjsQsNJYsC8Lo0O15i7BZF0AQ=
X-Received: by 2002:a17:903:268a:b0:19b:68e:47df with SMTP id
 jf10-20020a170903268a00b0019b068e47dfmr36637plb.6.1676544540214; Thu, 16 Feb
 2023 02:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20221108013517.749665-1-marex@denx.de> <CAPDyKFoUdfUjZMgzU-3SS0gVstj-04FbTSjxihdar2wxu5c97w@mail.gmail.com>
 <52578b45-cf4c-e949-b2b1-a0f251815337@denx.de> <CAPDyKFrQ0Uvhsa2AXwTdzOC1xhQ6qjRP=1TzVXC3StLv5FOoBA@mail.gmail.com>
 <cf304d09c26416eb286f03bfe1e292aa8399b349.camel@pengutronix.de>
 <CAPDyKFqONWFj86FbhhGXmxVTMvdwdwWUNLDqEK5gg2-bDitmxg@mail.gmail.com>
 <6d1f2a1a-437e-01b7-cf25-af1a09ce7f3f@oss.nxp.com> <CAPDyKFo8ekN3e8kzbtftKuyYY1wv0=gn3L=oz5zBjTebRT84+w@mail.gmail.com>
 <d04c9522-ee19-ec8f-5614-c0a805b8964e@oss.nxp.com>
In-Reply-To: <d04c9522-ee19-ec8f-5614-c0a805b8964e@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Feb 2023 11:48:24 +0100
Message-ID: <CAPDyKFrzbpF-F2Quxh4QH_HwGc5MbJ=qOcWb-yGQo+WHYNK6PQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] [RFC] PM: domains: Introduce .power_pre/post_on/off callbacks
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>, Marek Vasut <marex@denx.de>,
        linux-pm@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Len Brown <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 16 Feb 2023 at 02:47, Peng Fan <peng.fan@oss.nxp.com> wrote:
>
> Hi Ulf,
>
> On 1/18/2023 8:55 PM, Ulf Hansson wrote:
> ...
> >>
> >> Honestly I not have idea on how to rework the clk part to avoid holding
> >> the clk-prepare lock when power on the phy and its power domain.
> >
> > I understand. Let me try to prepare a hackish patch that we can use to
> > run some tests.
> >
> > Unfortunately, I can't make any promises for when, but I will do my best.
> >
>
> Have you got time to give a look on this part? Or do you have any
> suggestions that I could help with?

I have looked closer at this, but haven't yet got the time to actually
post a patch. Let me see if I can do some re-prioritization of things
at my side...

Anyway, my plan is to post a "hackish" patch that we should use solely
for testing, to make sure that the approach works. Then, I intend to
continue to work on the complete solution, which seems to be requiring
some reworks of locking parts in the clock framework. Although, it's
too early for me, to say exactly how, so I can't really give you any
pointers in this regard, sorry.

>
> Thanks,
> Peng.
>
> >>
> >> [1]https://github.com/nxp-imx/linux-imx/commit/c85126180a10439a8c7db1800529b4857d91c609
> >>

Kind regards
Uffe
