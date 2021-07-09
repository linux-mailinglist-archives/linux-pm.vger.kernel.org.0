Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092703C253B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhGINvW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhGINvV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 09:51:21 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5703BC0613E5
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 06:48:38 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id q20so3602298uaa.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRCNV6ZFXJBs7PclJlD2iVg5/YJ4bok8pXgNIFrGMCg=;
        b=D8weDgVP9EZ6NE1BrJTnQpXcjrMNbz6dvAHF9BhcWGd8eoy+R/hdnzmyd8aKXNysFg
         cEpjEMsrTF/wPnc3XCy9a0ukDS/2/v+0GKJTv8f7/Yr6++wMXcCpY06ZPVDICwgxrZWb
         /5idRWlyo5bwnmJbAvZPI0zmZxN/JH0anz3lBYBV8bfxpjDukdpEqst336HMXRimz+tv
         E1X4wsXYwk8zQVBQ0AFdyFr/nzF6gPLBmd3QWIpy1hBRkrySF2UBqpnxAU54N6R07hsL
         0Uao7+rDqyppSQ8BSb0HaJy04YII2rv2Mh9lqmidT2IZwDkD7w333VUUfy4ZMtkVzGTL
         UdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRCNV6ZFXJBs7PclJlD2iVg5/YJ4bok8pXgNIFrGMCg=;
        b=oEo3wmrBw2RujGhbjtDUX8WLQcpqQ9wEB+lzLWUB8tAGz15U6A7ms1DnMzERfVRKAb
         sRs3k4hkV52fIa/qzDLebwdlCRCwU387K6XEvX+FLW77HRwS/P5mL62vDlwrrOKvgGGl
         XRc5Hp0tAgQV5hOCWTQYu6vhD0KAvGgnDjSX4uTxRjr3sAwl3nY1O5F8z9C5cJ29M/EH
         T8wbFxwonL1ICJxrE8fzFKHVKguFNpixpJk0tjbHVtB7HwZeAv/mFTxMxZHqsGJmsanh
         rE907G+C7yMn2RCo88ExQ+wpUSiEHRL0fjaNSV16TJpG1HBgPHAZBFhN+cICIoqQuJYo
         PS6w==
X-Gm-Message-State: AOAM531pwXAfq3fxPfq8RKAKIiLBGiKnzKT+m+6CyYluEhiPk/c6Z93g
        ogHG2vFoKOt6uRY5YHrX/8V25mq2SgsY2eglNWJoeA==
X-Google-Smtp-Source: ABdhPJxTkyvoa54J3Do+B5qntDhoazM0lWih9gehETjT94wFgYdJD2Vf42Bi655Hk/alRbkSfWJgef4zVRhXPf5FUzE=
X-Received: by 2002:a9f:2f14:: with SMTP id x20mr38311816uaj.104.1625838517384;
 Fri, 09 Jul 2021 06:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210709125611.135920-1-ulf.hansson@linaro.org>
 <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com>
 <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com> <CAMuHMdWcvAeeif6HwBMrQUs2z+jKcfY1DuKRYeyB+GTkiXGjSw@mail.gmail.com>
In-Reply-To: <CAMuHMdWcvAeeif6HwBMrQUs2z+jKcfY1DuKRYeyB+GTkiXGjSw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jul 2021 15:48:01 +0200
Message-ID: <CAPDyKFo8SCbmJXQJJ4OR8_Tg=+YdK76k2Sg=KcO3t7ve2zzaHw@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Don't attach a device to genpd that
 corresponds to a provider
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 9 Jul 2021 at 15:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, Jul 9, 2021 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 9 Jul 2021 at 15:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Jul 9, 2021 at 2:56 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > According to the common power domain DT bindings, a power domain provider
> > > > must have a "#power-domain-cells" property in its OF node. Additionally, if
> > > > a provider has a "power-domains" property, it means that it has a parent
> > > > domain.
> > >
> > > OK.
> > >
> > > > It has turned out that some OF nodes that represents a genpd provider may
> > > > also be compatible with a regular platform device. This leads to, during
> > > > probe, genpd_dev_pm_attach(), genpd_dev_pm_attach_by_name() and
> > > > genpd_dev_pm_attach_by_id() tries to attach the corresponding struct device
> > > > to the genpd provider's parent domain, which is wrong. Instead the genpd
> > >
> > > Why is that wrong?
> >
> > It may lead to that the struct device that corresponds to a genpd
> > provider may be attached to the parent domain. In other words, the
> > parent domain will not only be controlled by a child domain
> > (corresponding to the provider), but also through the provider's
> > struct device. As far as I can tell, this has never been the intent
> > for how things should work in genpd.
>
> Ah, you're worried about the case where the subdomain is a child of
> the parent domain, but the actual subdomain controller (represented
> by the platform device) isn't?

Well, even if the platform device represents a subdomain controller,
should it really be attached to the parent domain?

In any case, it means that the provider needs to manage runtime PM,
etc for its struct device to not prevent the parent domain from being
powered off.

Hmm, in the end this is just a matter of expectation of what will
happen during the attach. Perhaps it's just my worries that are wrong.
:-)

>
> > So wrong or not, I guess it depends on what you expect to happen.
> >
> > Do you see an issue with changing this?
>
> I don't have any hardware where the DTS describes a node as being
> both a power domain consumer and a provider.
> SH/R-Mobile uses a nested domain description in DT, but there are
> no platform devices created for the nested child domains, only for
> the top domain.

Okay, thanks for reviewing!

Kind regards
Uffe
