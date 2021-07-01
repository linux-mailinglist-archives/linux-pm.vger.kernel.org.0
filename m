Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721203B93C8
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhGAPRS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhGAPRS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 11:17:18 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF5C061762
        for <linux-pm@vger.kernel.org>; Thu,  1 Jul 2021 08:14:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r16so8941013ljk.9
        for <linux-pm@vger.kernel.org>; Thu, 01 Jul 2021 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7SjopVfMaoe2w1JGzt6b1vmcs3L6pEjOQkXiBAboM4=;
        b=jARjQAjpT1Pteq9LIloPJ12XXwl3ru2QtvI5Xyczm8P1DnqizCjMAl6CGFsaVZSQXW
         UH4Hu60KYVYF33Hpi9nO6zdgMaS+2YIGUXKBSPFlxAdHDHMhRuR4rzAD4t/vYAhqfwhf
         UuK0ki44hCoY3jV9pO5abEx/wbgBBDgqCPPKi4atuI3TRAuzGOsLwAaKRUd77/2Pcred
         YVpKBTYxixUj/pefHVMp8kWpL0P4HpitZPWHiGgF1LhzQjm07sbXNVX6+8HvXimBvaEG
         iEPQ4+NHYEmpPXAdTc1NIJ5fflduLSi3PXyvmNoIBxgKI6+557v4NSvF/kNgoR/siOvB
         ZHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7SjopVfMaoe2w1JGzt6b1vmcs3L6pEjOQkXiBAboM4=;
        b=GqLm4yAfNRAUBEwKJN6BPu8B9EhUvaopgR4EX48iA2U9zk3h+MW+aFmYa+fEWKH8B/
         rPwNozk9YQK1GUxa22zyvtmqHdwwxSa1AzL7c9M8bopy61vuYOjksCnyRvxUD0VoSDKD
         otTaAPlXSjy+YbHAiYNYoxD8P8GnAJbmOfTA45v6e++BUXHRLlujZFSpTmBrbnt8pgBp
         vQfuRWzPmcpxMAn6TshIZvn7a9CBkELGMpLPNu1et/1b507iiP0TOisxaQtwKbEppu+J
         MkFRGV7iQaR/qz6AXXgnqAo8zzUuLv+QKZNlCo8QBh4suXpFFdq3Oy0p1pLqwCJg5HcU
         GZCA==
X-Gm-Message-State: AOAM533eEulLIh6fBgopf3ADIWTC3KgjB8KWjGJ48VcLxgG5vyX6o3//
        vcF/PA4LLXNqx3QxFa4IenIZ7K/bhvE9TE6Pm52qug==
X-Google-Smtp-Source: ABdhPJxC4w3fPVooBAMn4WWUnwrS5E6in2N7SPbQK1SBNtse+qOq2rotFBO6pLxfWd1Qv0cPwWy3J+dvg9FTY5HP/+4=
X-Received: by 2002:a2e:b4ce:: with SMTP id r14mr70353ljm.76.1625152484773;
 Thu, 01 Jul 2021 08:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org> <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
 <YMjNaM0z+OzhAeO/@yoga> <CAPDyKFo_eNwEx5rryg3bHt_-pxBeeYfVrUZuTOHoL-x94LBwDA@mail.gmail.com>
 <c6e99362-56c1-f2bd-7170-7b001e0f96fe@linaro.org> <YNs3q0HI1WKrKOXx@yoga>
 <CAPDyKFqSwPn7wUXB9mayT78hshDFBK+DO7cqbmZRjXNAJDQfZw@mail.gmail.com> <CAA8EJpoOFyFh8vp4Q5w0DMT7-1MrN930gQiv6dk-Mu05B2dT3Q@mail.gmail.com>
In-Reply-To: <CAA8EJpoOFyFh8vp4Q5w0DMT7-1MrN930gQiv6dk-Mu05B2dT3Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Jul 2021 17:14:07 +0200
Message-ID: <CAPDyKFrC-ibr1bOKndS0_NirW=B5E1CetB3OwgS9jfQadAQWjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 1 Jul 2021 at 13:01, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 1 Jul 2021 at 13:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 29 Jun 2021 at 17:09, Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Mon 28 Jun 14:55 CDT 2021, Dmitry Baryshkov wrote:
> > >
> > > > Hi,
> > > >
> > > > On 17/06/2021 12:07, Ulf Hansson wrote:
> > > > > + Rajendra
> > > > >
> > > > > On Tue, 15 Jun 2021 at 17:55, Bjorn Andersson
> > > > > <bjorn.andersson@linaro.org> wrote:
> > > [..]
> > > > > > But I am unable to find a way for the gdsc driver to get hold of the
> > > > > > struct generic_pm_domain of the resources exposed by the rpmhpd driver.
> > > > >
> > > > > You don't need a handle to the struct generic_pm_domain, to assign a
> > > > > parent/child domain. Instead you can use of_genpd_add_subdomain(),
> > > > > which takes two "struct of_phandle_args*" corresponding to the
> > > > > parent/child device nodes of the genpd providers and then let genpd
> > > > > internally do the look up.
> > > >
> > > [..]
> > > >
> > > > I think I'd need this function anyway for the gdsc code. During gdsc_init()
> > > > we check gdsc status and this requires register access (and thus powering on
> > > > the parent domain) before the gdsc is registered itself as a power domain.
> > > >
> > >
> > > But this is a register access in the dispcc block, which is the context
> > > that our gdsc_init() operates. So describing that MMCX is the
> > > power-domain for dispcc should ensure that the power-domain is enabled.
> >
> > Right.
> >
> > As a note, when we assign a child domain to a parent domain, via
> > of_genpd_add_subdomain() for example - and the child domain has been
> > powered on, this requires the parent domain to be turned on as well.
>
> Most probably we should also teach genpd code to call pm_runtime
> functions on respective devices when the genpd is powered on or off.
> For now I had to do this manually.

No, that's not the way it works or should work for that matter.

It's the runtime PM status of the devices that are attached to a
genpd, that controls whether a genpd should be powered on/off.
Additionally, if there is a child domain powered on, then its parent
needs to be powered on too and so forth.

>
> >
> > >
> > > We do however need to make sure that dispcc doesn't hog its
> > > power-domain, and that any register accesses in runtime is done with the
> > > parenting power-domain enabled. E.g. the clock framework wraps all
> > > operations in pm_runtime_get/put(), but I don't see anything in the
> > > gnepd code for this.
> > >
> > >
> > > And for gcc I'm worried that we might have some GDSCs that are parented
> > > by CX and some by MX, but I do still think that the register accesses
> > > are only related to one of these.
> > >
> > > But this seems like a continuation of the special case in dispcc, so I
> > > think we should be able to focus on getting that right before we attempt
> > > the general case (and I don't know if we have a need for this today).
> > >
> > > Regards,
> > > Bjorn
> >
> > Unfortunately, I didn't understand all the above things.
> >
> > In any case, please tell me if there is anything else that blocks you
> > from moving forward with the power domain conversion? I am happy to
> > help.
>
> Patch series was submitted:
> https://lore.kernel.org/linux-arm-msm/20210630133149.3204290-1-dmitry.baryshkov@linaro.org/

Okay, I will have a look over there. Thanks!

Kind regards
Uffe
