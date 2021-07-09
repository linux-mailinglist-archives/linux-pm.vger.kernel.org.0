Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF723C256D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 15:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhGIOAx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 10:00:53 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:42977 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhGIOAv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 10:00:51 -0400
Received: by mail-vk1-f170.google.com with SMTP id u24so2164083vkn.9;
        Fri, 09 Jul 2021 06:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqwrPtiUbUVxHTFg3pSH8MqoUSojXNob/7BriSdkrf8=;
        b=gnRRvKrPWANHwC1xE+Axg63VL4BUvwmQPhvaMDqYRvYZji+5xnilfJOUV8hX2pKCK7
         NidO0XowM0rwN5fw/9aIYQjcTc4ZlbEnm5wkqKFm1vM8B09EYeSC82g52OYDryhIhHLp
         jIJg0+wkLzPWfMa5/PN/kmOZJwTHRfU72teR4AfXpLtyiFWM8zwpPYyN7QOjLgz7E/0m
         aeog13Sezcqm2HbAJLTjpc6JjswIDVUYVejicZnffuQN2xETplrQPMpbCvGZQwHNowaN
         SK0B14ZX7W20iHzUQdQkTTjOKG0mcad74R6XmSghX/7NUBOwDpQkFNQXn8x0X3bafl09
         37Tw==
X-Gm-Message-State: AOAM533cqKjjCZ4QRXOshiJTSfTmPnqyAI9dCasM2T1fowqfhe8hi7Fu
        czYqosN2JAFOsyP1YH3ubhPkteQWUhuea0pXRN8=
X-Google-Smtp-Source: ABdhPJyKpb/CWPGeZyz112QJCtJJ35km7e2llXNdGdPmlumQm3JOCAyb/oib9Guj7mXMYqb2sdN+wgZU9UyiRAr8mA4=
X-Received: by 2002:a05:6122:1207:: with SMTP id v7mr32752631vkc.2.1625839087123;
 Fri, 09 Jul 2021 06:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210709125611.135920-1-ulf.hansson@linaro.org>
 <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com>
 <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com>
 <CAMuHMdWcvAeeif6HwBMrQUs2z+jKcfY1DuKRYeyB+GTkiXGjSw@mail.gmail.com> <CAPDyKFo8SCbmJXQJJ4OR8_Tg=+YdK76k2Sg=KcO3t7ve2zzaHw@mail.gmail.com>
In-Reply-To: <CAPDyKFo8SCbmJXQJJ4OR8_Tg=+YdK76k2Sg=KcO3t7ve2zzaHw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Jul 2021 15:57:56 +0200
Message-ID: <CAMuHMdW8f0YGwNBAzwG65OE+Wq59SqUFmHhDPE0Nju7OpDzLYA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Don't attach a device to genpd that
 corresponds to a provider
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

Hi Ulf,

On Fri, Jul 9, 2021 at 3:48 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Fri, 9 Jul 2021 at 15:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jul 9, 2021 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Fri, 9 Jul 2021 at 15:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Fri, Jul 9, 2021 at 2:56 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > According to the common power domain DT bindings, a power domain provider
> > > > > must have a "#power-domain-cells" property in its OF node. Additionally, if
> > > > > a provider has a "power-domains" property, it means that it has a parent
> > > > > domain.
> > > >
> > > > OK.
> > > >
> > > > > It has turned out that some OF nodes that represents a genpd provider may
> > > > > also be compatible with a regular platform device. This leads to, during
> > > > > probe, genpd_dev_pm_attach(), genpd_dev_pm_attach_by_name() and
> > > > > genpd_dev_pm_attach_by_id() tries to attach the corresponding struct device
> > > > > to the genpd provider's parent domain, which is wrong. Instead the genpd
> > > >
> > > > Why is that wrong?
> > >
> > > It may lead to that the struct device that corresponds to a genpd
> > > provider may be attached to the parent domain. In other words, the
> > > parent domain will not only be controlled by a child domain
> > > (corresponding to the provider), but also through the provider's
> > > struct device. As far as I can tell, this has never been the intent
> > > for how things should work in genpd.
> >
> > Ah, you're worried about the case where the subdomain is a child of
> > the parent domain, but the actual subdomain controller (represented
> > by the platform device) isn't?
>
> Well, even if the platform device represents a subdomain controller,
> should it really be attached to the parent domain?

That's what the presence of the "power-domains" property means,
isn't it?
If the subdomain controller itself is not part of the parent power
domain, there should not be a "power-domains" property.  So perhaps
we need a new property ("power-domain-parent"?) to indicate what is
the parent domain for the subdomains in this case?

> In any case, it means that the provider needs to manage runtime PM,
> etc for its struct device to not prevent the parent domain from being
> powered off.

Shouldn't all drivers for devices that can be somewhere in a PM Domain
hierarchy do that anyway? :-)  See e.g. commit 3a611e26e958b037
("net/smsc911x: Add minimal runtime PM support").

If "simple-bus" would do that, we could get rid of "simple-pm-bus"...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
