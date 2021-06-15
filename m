Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1F3A8418
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhFOPho (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 11:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhFOPho (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 11:37:44 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0905EC06175F
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 08:35:39 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id l7so5024196vkk.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12lusgJKqZ+mFXJMQojBCjBzeRiohhHShT1Rj6cPMlA=;
        b=KdTeL4xhOG1Ni08Mf6x0ZpT6rt9j9qQv+4GuFufpy9Ao2aplllacUO3i6KB3Pr9Rgk
         cjToMFZjWR8QRk/rF8v8/zAq0KQUiUUIut6Il99rIFXXsL0A6iRURQpQwmP7JLNU9dGV
         16lYhsXZqzVIHA6Nd1LZ3FHGpIGSUOztR2O2pGXx+032trMRf7rBFhneKGe4kPt95zFV
         R5FllI9cUcq7JTYkk0/oNUCDgZZyvZOQzcsEvNMaJTtmrS27nJcDGWbx0svynNj/g3zd
         0znOSVeB+ZGyrQQqpqmr5qg1dHMHomeu919bunVoA21KJ2U2g4qqzTFVRE0g/iSNt6nA
         khZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12lusgJKqZ+mFXJMQojBCjBzeRiohhHShT1Rj6cPMlA=;
        b=fuv60hCh15NukvjD4f1B/9u3UKMPP7pYaOoNsiBTTBquTRuBpsDsf1hWx7HsukRrip
         oTEIfwmKWVo1RSlDgy1mX5s3Oa5Zi2+4YTg6Y0ni8Rum096IodP+qaQjQN+bcWOrAJGD
         +el5W9H/4nfQKkjhUhIuwwpPwgT5E2tMRiIm4J2u2qsYVUANnmDWOZ7VrGJV4sUKbIGJ
         3aKXxVkSKkYR2eFJqWR63as4H3F8AOln4c8vvaSyRt6/kSAFmaGqrW7D7BvccWgbQN68
         nQiMhvUtbLCeypzpjrQ/KTGT+54BT8K5gNHkNeh8h3akLBT+PXybByJlSY9yvrHvTq35
         pSIA==
X-Gm-Message-State: AOAM531ITzwUQKtIEXKDIZMgS2wWkrzNwLPBxZfl8Gv5mcB4Ela0L2B7
        s8dzX930pVczycByX4bHppsoAaqM9IS/HPfU+u2XFA==
X-Google-Smtp-Source: ABdhPJyEAEOe6I6qtvLHO5Hm3e/awBYGqKLv+Jhmw2CzujYFMTLYGKPub/BltgkGnQPNw58/mXrSs/TP1Z6+jggvyRM=
X-Received: by 2002:a1f:3dd8:: with SMTP id k207mr4287282vka.7.1623771338193;
 Tue, 15 Jun 2021 08:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org> <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
 <20210615111012.GA5149@sirena.org.uk> <CAPDyKFreV-RPzweG8SqFQtvZMOyFbaG2+tMFKc2JkbEj+erb=g@mail.gmail.com>
 <20210615152620.GH5149@sirena.org.uk>
In-Reply-To: <20210615152620.GH5149@sirena.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Jun 2021 17:35:01 +0200
Message-ID: <CAPDyKFrthc_6rXt1UscKTQnctFXw0XjReEF5bqCGot2n=ChKaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 15 Jun 2021 at 17:26, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 15, 2021 at 04:55:24PM +0200, Ulf Hansson wrote:
> > On Tue, 15 Jun 2021 at 13:10, Mark Brown <broonie@kernel.org> wrote:
> > > On Tue, Jun 15, 2021 at 12:17:20PM +0200, Ulf Hansson wrote:
>
> > > > Beyond this, perhaps we should consider removing the
> > > > "regulator-fixed-domain" DT property, as to avoid similar problems
> > > > from cropping up?
>
> > > > Mark, what do you think?
>
> > > We need to maintain compatibility for existing users...
>
> > Normally, yes, I would agree.
>
> > In this case, it looks like there is only one user, which is somewhat
> > broken in regards to this, so what's the point of keeping this around?
>
> Only one user in mainline and you were just suggesting removing the
> property (you mean binding I think?) - at the very least we'd need to
> transition that upstream user away to something else before doing
> anything.

Yes, I am referring to the binding.

Let's see where we end up with this. My concern at this point is that
it could spread to more users, which would make it even more difficult
to remove.

Kind regards
Uffe
