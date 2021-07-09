Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649B83C2571
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhGIOBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 10:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhGIOBa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 10:01:30 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369A8C0613E6
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 06:58:47 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id j2so3128247vsi.6
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+jqwXayeNUZ676AiS+w8n65h49A/Hu6kZF0Sox7IxU=;
        b=OKcT+/vMUbgm2ve+XWOxsIcC+mlyUwS7xzS+dj2h1FJV7htYdu/yqy+pzRoeZlfPtk
         JD09fRHiiFYQhf2QgwB279PuXp5aVCz3Hwz/x60G9wX+ZAzn1utbJqQhccUa0ainIEfu
         G5BeQfjFizSrxuvrWqPMrTbb0lKnKE7rlPJhDg84EUUlIPW8DELB+PJn0sBXGjkrwG6D
         UqVJuSMKom/v8tAp1OeSU8+UcNTB2t3lkccnCbMi/wopvW9gROVrBrJaMcDg6R2kup+q
         kpkJyIVBt63MikBplfNVI3uQU2FRVTAsGeLhFFRCON7v+C3a/SYCKSzCzYA3r6aojOUV
         7FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+jqwXayeNUZ676AiS+w8n65h49A/Hu6kZF0Sox7IxU=;
        b=LDYdz4HMbnYdOmG/Gb5qVTnon4fbwJf1Ho+9EkC+yWXBz6pQMQZTS1U820VOCMbcDy
         XVRLnx6uUN66tA+iEdwEJuVL4N8JALIso6Y8kbTzA/KW4xzPJPnBnvLhxIcLLa7W4Wd7
         9e4QUAQqBqwe1PkJp/CTyPTcwRN1ZkoiccAmTF8U7z2qAXpPJZUzaNlmiU/wu72FWqXH
         dR0NndahycnMerM7pwjob4s7F/cQ92K1FNexJH0Awy0LXs2VA87Y9bjRLPnLhkLUK90v
         fPEQUzP4j6TKRGX4sdMK70fBQazNmArHivb4c6nrWcRfI/EWXhXJSybuWrJNDLIaT7kh
         9zug==
X-Gm-Message-State: AOAM530bsY9yPAc2U+Qgm/MvMfjCZuVr6MBW90E5seL8tyNP9bnM6O9s
        xf+a5j7HdntjqXV3pJgyjW1Rc9/et2IBBBueggI8aQ==
X-Google-Smtp-Source: ABdhPJwT8DvqvEQUQWjDGhWJ5TcIUQa3R+OZE3pOVn9lHid3k8BqbKpDjfOb8KQMHzEqWy+1MF44SLU3G4+qvWcz8p0=
X-Received: by 2002:a67:8c46:: with SMTP id o67mr35490491vsd.34.1625839126328;
 Fri, 09 Jul 2021 06:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210709125611.135920-1-ulf.hansson@linaro.org>
 <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com>
 <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com> <YOhTU0xUShJQXrL5@yoga>
In-Reply-To: <YOhTU0xUShJQXrL5@yoga>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jul 2021 15:58:10 +0200
Message-ID: <CAPDyKFr+VtGvyfJip-Mu6Gdcj1jQNtkrHRg6tJsJtAKkg0Y9+g@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Don't attach a device to genpd that
 corresponds to a provider
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
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

On Fri, 9 Jul 2021 at 15:47, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Fri 09 Jul 08:22 CDT 2021, Ulf Hansson wrote:
>
> > On Fri, 9 Jul 2021 at 15:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Ulf,
> > >
> > > Thanks for your patch!
> > >
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
> >
> > So wrong or not, I guess it depends on what you expect to happen.
> >
> > Do you see an issue with changing this?
> >
>
> But this exactly what we have in the case of the "dispcc" in the
> Qualcomm platform that Dmitry is working on.
>
> The provider driver needs the parent power-domain to be powered in order
> to poke the registers and then it is the parent of the power-domains
> exposed.
>
> If I understand your proposed patch we'll have to manually attach the
> parent domain to the struct device of the controller with this patch?

Not even that would work after $subject patch, as it prevents
providers from being attached to a domain.

It sure sounds like you need to control power for the parent domain,
not only by registering a child domain to it.

>
> Is the Qualcomm case unique or will this change cut power do other genpd
> providers assuming the same?

I think the Qualcomm case is a bit unique or at least the first I
heard of. However, this change would affect all and of course we must
not break things.

>
>
>
> Worth mentioning as we discuss this is that we have another genpd
> provider, where I think the exposed genpds are parented by a few
> different (each one with a specific) parent domains. In this case we'd
> be forced to manually attach the genpd provider to the parent domain
> that it actually is powered by (as no automatic attachment happens when
> multiple domains are specified).

Yes, that's correct (assuming we don't apply $subject patch).

To sum up:

Rafael I am withdrawing the $subject patch, it seems like it may break
existing expectations of what will happen during attach.

Moreover, it may actually be beneficial to allow the attach to succeed
for the Qcom case, so let's leave this as is.

Kind regards
Uffe
