Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D393C2583
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGIOGU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhGIOGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 10:06:18 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E6CC0613DD
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 07:03:33 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id m12so5615050vst.8
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBkQv3Hb+EzyUp0xx15eV4nVWdwYInxQXj14j/hSkTw=;
        b=cV0PX7CieMyXh9iNqKRndqDwrdVktE8MpkQGh7gIJGtMwzmg139Lp1mpUyvfOxJwJ9
         I9sgKO0Sin7o6j0hGdqAXONJfIj/MmANYUFLh8P1zCMChpnL7cNJA1aaVerT1WIN8dLn
         ymggkU6DMHnL8ZciNxRaMJ3n2zDGgNTaxPhtRjmbb7kuBsIf6CT0YHlUpFkWmLKeN7uc
         WFJwo6YHGgAyLe/mr1osIlySOLdQa5Trmz/RkFLYDd9EFDGefzxGMrJxNvM1RxFdAIZG
         AVrIZksQ7rmo+q6tH7fbS5k5KZXDBHa/vX08tU8exMfpC9kwwT6mOfWu9Z6fZ213MBSr
         yNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBkQv3Hb+EzyUp0xx15eV4nVWdwYInxQXj14j/hSkTw=;
        b=drSe8b3W+dZfRvF/vTkHfpp2+5D/OL+JJEVScLA7x7N60uh+GWWatiiFDN8w/i2f+m
         SVPsck4elHfN1hwtMi3udGNeqkRMwll6cxSeUHhDUVVzu24s9j4Hi6UGATfiKgbv0md/
         hH5oJBTNKNVynaLpCh0SCacwhRubWV0iUVmXNX2VKmDbspIPejOuimBTKx9LOWJQWOpG
         FxGemsXfCoNmGj+BgO95NM4nMdMbrz8HNSydmnnzv/5fR4Z4SYTeBZj/+WULXON5GOMK
         tZFboL4kuuidLeoHzS7MePoQTMc3mjDGNkgyEa0O8dQsvAYB+Agt7fh4SURPrKmq8pix
         Iivw==
X-Gm-Message-State: AOAM532gOP5HhFOEglD1vNCe7nqQH8GY4+7D8qfCJm5jWtKdD3tXmPQw
        fm11wU+pL28gGHF2KVqpTQCyrP6xMiUoEomuuUAU0Q==
X-Google-Smtp-Source: ABdhPJyPpoCp87aEuVQW5m5FI3Cui8FxZacZGxGIMAD4zSwLzIbB62U+qZsOhXQBE5CTcJBuq51KlID1ViB9HjqKgBo=
X-Received: by 2002:a67:8c46:: with SMTP id o67mr35531294vsd.34.1625839412692;
 Fri, 09 Jul 2021 07:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210709125611.135920-1-ulf.hansson@linaro.org>
 <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com>
 <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com>
 <CAMuHMdWcvAeeif6HwBMrQUs2z+jKcfY1DuKRYeyB+GTkiXGjSw@mail.gmail.com>
 <CAPDyKFo8SCbmJXQJJ4OR8_Tg=+YdK76k2Sg=KcO3t7ve2zzaHw@mail.gmail.com> <CAMuHMdW8f0YGwNBAzwG65OE+Wq59SqUFmHhDPE0Nju7OpDzLYA@mail.gmail.com>
In-Reply-To: <CAMuHMdW8f0YGwNBAzwG65OE+Wq59SqUFmHhDPE0Nju7OpDzLYA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jul 2021 16:02:55 +0200
Message-ID: <CAPDyKFp3p0Ly9UDBxNo2qOE=N9VH1nzW=JkH_R_xfw4D=XkCGA@mail.gmail.com>
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

On Fri, 9 Jul 2021 at 15:58, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, Jul 9, 2021 at 3:48 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 9 Jul 2021 at 15:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Jul 9, 2021 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > On Fri, 9 Jul 2021 at 15:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Fri, Jul 9, 2021 at 2:56 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > According to the common power domain DT bindings, a power domain provider
> > > > > > must have a "#power-domain-cells" property in its OF node. Additionally, if
> > > > > > a provider has a "power-domains" property, it means that it has a parent
> > > > > > domain.
> > > > >
> > > > > OK.
> > > > >
> > > > > > It has turned out that some OF nodes that represents a genpd provider may
> > > > > > also be compatible with a regular platform device. This leads to, during
> > > > > > probe, genpd_dev_pm_attach(), genpd_dev_pm_attach_by_name() and
> > > > > > genpd_dev_pm_attach_by_id() tries to attach the corresponding struct device
> > > > > > to the genpd provider's parent domain, which is wrong. Instead the genpd
> > > > >
> > > > > Why is that wrong?
> > > >
> > > > It may lead to that the struct device that corresponds to a genpd
> > > > provider may be attached to the parent domain. In other words, the
> > > > parent domain will not only be controlled by a child domain
> > > > (corresponding to the provider), but also through the provider's
> > > > struct device. As far as I can tell, this has never been the intent
> > > > for how things should work in genpd.
> > >
> > > Ah, you're worried about the case where the subdomain is a child of
> > > the parent domain, but the actual subdomain controller (represented
> > > by the platform device) isn't?
> >
> > Well, even if the platform device represents a subdomain controller,
> > should it really be attached to the parent domain?
>
> That's what the presence of the "power-domains" property means,
> isn't it?
> If the subdomain controller itself is not part of the parent power
> domain, there should not be a "power-domains" property.  So perhaps
> we need a new property ("power-domain-parent"?) to indicate what is
> the parent domain for the subdomains in this case?

Hmm, but perhaps it's just a matter of expectations of what will
happen during attach.

On the other hand a new binding for the parent would make it more
clear. I wouldn't mind.

>
> > In any case, it means that the provider needs to manage runtime PM,
> > etc for its struct device to not prevent the parent domain from being
> > powered off.
>
> Shouldn't all drivers for devices that can be somewhere in a PM Domain
> hierarchy do that anyway? :-)  See e.g. commit 3a611e26e958b037
> ("net/smsc911x: Add minimal runtime PM support").
>
> If "simple-bus" would do that, we could get rid of "simple-pm-bus"...

Right, I totally forgot about that. Thanks for reminding me.

As I said in the other thread, let's drop this patch for now.

Kind regards
Uffe
