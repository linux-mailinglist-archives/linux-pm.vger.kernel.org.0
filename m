Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3D03C25B8
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhGIOTE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhGIOTD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 10:19:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59155C0613E5
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 07:16:20 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id z18-20020a9d7a520000b02904b28bda1885so8085724otm.7
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bxxtzhSqQ30ofxYR2wWVen9xadmyBMEFbPzU4Bge/7c=;
        b=cZf6fFb7XZoW2XKC56KpK+eeM8OXh80i4CztX45RhXCNhmg1i0UIs4elevIQL3TC57
         oDuSscvnClKFrdO7K67Hw/FPskzXYeHsJp4MRN0jgbS5fT1ixvWaflTgbJeOIPhG/EcP
         GLTKSZy3GexSbMaz8CviEOADL1EPmE1bhx7tw2SOl9x89Q9ZMaJ1W7mMt5at6SAcUUvf
         8e6P0f2BdmxIoa/zRgkSJGqjpxOdJ2u8qvQEcRY+3EdC+nqQGJEU92gh46aC7uhMYayX
         MOix9SFPrEXKeUErZ6ebMYalGBVlRw3w3+wGzqxbLaLQnj6FHhwpi9agbAtWu7oLuyoK
         o2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bxxtzhSqQ30ofxYR2wWVen9xadmyBMEFbPzU4Bge/7c=;
        b=ajj/XgjFUd+vc+khnHit2OtK/QF/BwHu5h+23Tx8szNHJFtgAdfl982EVOazhIEK2S
         I/9VlhD+67xShSUgMSpAWoZke+fg78y42Z3fRR05L4VVUlS71EdI3xSk2yMcp0vM7KWx
         8Wv/JdKACwxItMP6hPWjXGJVim3Ncrpr47wWdP0kEqRjMjuxZJDEVzp90kTlhPpL1Afs
         3w7DX4C91YFfo2UlvjhAqEoOWNjrCPFQvy5E+DAsKNdziA77nmsepQl8oAM1iH0yZqHh
         U+DCnEa2kRbQzoy8rQLYPFn09CF/BXIWVKey7p3LdJ33vgb8kyMAE1OvyBEh9a66rFAD
         +ohw==
X-Gm-Message-State: AOAM5303AZcURMqqkTGEBtUufUga9PVobMKEDOMrevhRW8h/3zDqq85G
        0h+Djn5pUv3H/71NZwuEuq1TLw==
X-Google-Smtp-Source: ABdhPJwud6BO9hWdFsO/4Wc/TioM7Cxa1/RTd2pqEJKFpQ/qRrxfYgYNRrztJ5OSG+CePaw8a+GTVw==
X-Received: by 2002:a9d:4ea:: with SMTP id 97mr28601933otm.324.1625840179553;
        Fri, 09 Jul 2021 07:16:19 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l9sm1233261oii.20.2021.07.09.07.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:16:18 -0700 (PDT)
Date:   Fri, 9 Jul 2021 09:16:16 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: domains: Don't attach a device to genpd that
 corresponds to a provider
Message-ID: <YOhaMFHd6QD6olpg@yoga>
References: <20210709125611.135920-1-ulf.hansson@linaro.org>
 <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com>
 <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com>
 <YOhTU0xUShJQXrL5@yoga>
 <CAPDyKFr+VtGvyfJip-Mu6Gdcj1jQNtkrHRg6tJsJtAKkg0Y9+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr+VtGvyfJip-Mu6Gdcj1jQNtkrHRg6tJsJtAKkg0Y9+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 09 Jul 08:58 CDT 2021, Ulf Hansson wrote:

> On Fri, 9 Jul 2021 at 15:47, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> >
> > On Fri 09 Jul 08:22 CDT 2021, Ulf Hansson wrote:
> >
> > > On Fri, 9 Jul 2021 at 15:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > >
> > > > Hi Ulf,
> > > >
> > > > Thanks for your patch!
> > > >
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
> > >
> > > So wrong or not, I guess it depends on what you expect to happen.
> > >
> > > Do you see an issue with changing this?
> > >
> >
> > But this exactly what we have in the case of the "dispcc" in the
> > Qualcomm platform that Dmitry is working on.
> >
> > The provider driver needs the parent power-domain to be powered in order
> > to poke the registers and then it is the parent of the power-domains
> > exposed.
> >
> > If I understand your proposed patch we'll have to manually attach the
> > parent domain to the struct device of the controller with this patch?
> 
> Not even that would work after $subject patch, as it prevents
> providers from being attached to a domain.
> 

That's definitely going to be a problem.

> It sure sounds like you need to control power for the parent domain,
> not only by registering a child domain to it.
> 

Yes, we certainly need power to the genpd provider.

> >
> > Is the Qualcomm case unique or will this change cut power do other genpd
> > providers assuming the same?
> 
> I think the Qualcomm case is a bit unique or at least the first I
> heard of. However, this change would affect all and of course we must
> not break things.
> 

I'm surprised that we'd be alone one that needs power to our genpd
provider. Does everyone else have their genpd providers in some
always-on power domain?

> >
> >
> >
> > Worth mentioning as we discuss this is that we have another genpd
> > provider, where I think the exposed genpds are parented by a few
> > different (each one with a specific) parent domains. In this case we'd
> > be forced to manually attach the genpd provider to the parent domain
> > that it actually is powered by (as no automatic attachment happens when
> > multiple domains are specified).
> 
> Yes, that's correct (assuming we don't apply $subject patch).
> 

Afaict this patch wouldn't change the case where the genpd provider has
multiple power-domains, as it wouldn't automatically attach the device
to any one of them anyways.

Regards,
Bjorn

> To sum up:
> 
> Rafael I am withdrawing the $subject patch, it seems like it may break
> existing expectations of what will happen during attach.
> 
> Moreover, it may actually be beneficial to allow the attach to succeed
> for the Qcom case, so let's leave this as is.
> 
> Kind regards
> Uffe
