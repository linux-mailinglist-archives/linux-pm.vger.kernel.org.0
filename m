Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107C13B9055
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 12:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhGAKKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 06:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbhGAKKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 06:10:06 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF4CC061756
        for <linux-pm@vger.kernel.org>; Thu,  1 Jul 2021 03:07:35 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id j8so3524485vsd.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Jul 2021 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fsy59JmCVg9wIRw553TU269kL3+xAeRU1nsYXjldgz4=;
        b=JnRpdDxD1A2yN+SDzUAogsCY8SQBxlyvdSAo58DVfzL48Mb/U4nEBE2JBiBdd37kXi
         GVgaPPMNSaYcu+WOoBCDJeBByUqEhXzTiN8upY9/5SIL4VFgFrTDS9ZIKPw5eOjOJ+ay
         rq9z4CQ8nuiNHfhWGhL3BUO3P28Q0nuXTv1KCZC/PMeh6GrCfXWNg1V3tEPTpL4tum+/
         41dLUHQRR09RSoLOfTOVxpX9S75pxC3kqiUoKjBIkQDGvJYci5TUxQrhHJbk+/0GDWYB
         Bn+MovDBNvRMARAE7Aws6ixtJCAjFMxHMOFBKGHuTySMjqnhLBX7mmd6T4VQCqE9xaHk
         c0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fsy59JmCVg9wIRw553TU269kL3+xAeRU1nsYXjldgz4=;
        b=B8MxHPINf3RaG1sYT7/bI4C9ejYefydyWayQh7GtaQgNFTPfCBM1NHDXujFBovGK7G
         gC5T7Ii4pUiox0/nXgoixlD6yPwr7zDAC6thaJqTrrQy7C1TJS/4y033nCAiSmCiFhzd
         sfkX05BlD8CaygOLzaz5srBkELD+gNDSZsyuHG4JAjnT7195OBOUrDv/fpdlkfUIhLal
         uwz6ERLp9F4AbIfTlJtDUtdGS3VRHuEb8OwuLNIMznhbOI24kpcGxSDB5ct/FqLUObKv
         wX5LKFX3l09JfafljaR+4+qiqSxrv6xwvr1WZtrhf348MdnFQN3JSuKKMjDpHP0GAE8i
         /LSA==
X-Gm-Message-State: AOAM530cAZW0NDu/joBHprK76jR5DoLkBvqKg20Z2IpkFSIvnQZEK1/B
        /pwhSchAcWyusnF/qWLLBYqgsALQZ/Cx1PRsimFyLw==
X-Google-Smtp-Source: ABdhPJynxTlvIaBrgDAuYwMcsngknZHO/5b3IKWexZ/Up/Sftfl9DWWzjkELrV3hfTDdaO9jAPUy1vxrTdZL3nE4/ws=
X-Received: by 2002:a05:6102:502:: with SMTP id l2mr36934693vsa.19.1625134054938;
 Thu, 01 Jul 2021 03:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org> <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
 <YMjNaM0z+OzhAeO/@yoga> <CAPDyKFo_eNwEx5rryg3bHt_-pxBeeYfVrUZuTOHoL-x94LBwDA@mail.gmail.com>
 <c6e99362-56c1-f2bd-7170-7b001e0f96fe@linaro.org> <YNs3q0HI1WKrKOXx@yoga>
In-Reply-To: <YNs3q0HI1WKrKOXx@yoga>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Jul 2021 12:06:58 +0200
Message-ID: <CAPDyKFqSwPn7wUXB9mayT78hshDFBK+DO7cqbmZRjXNAJDQfZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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

On Tue, 29 Jun 2021 at 17:09, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 28 Jun 14:55 CDT 2021, Dmitry Baryshkov wrote:
>
> > Hi,
> >
> > On 17/06/2021 12:07, Ulf Hansson wrote:
> > > + Rajendra
> > >
> > > On Tue, 15 Jun 2021 at 17:55, Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> [..]
> > > > But I am unable to find a way for the gdsc driver to get hold of the
> > > > struct generic_pm_domain of the resources exposed by the rpmhpd driver.
> > >
> > > You don't need a handle to the struct generic_pm_domain, to assign a
> > > parent/child domain. Instead you can use of_genpd_add_subdomain(),
> > > which takes two "struct of_phandle_args*" corresponding to the
> > > parent/child device nodes of the genpd providers and then let genpd
> > > internally do the look up.
> >
> [..]
> >
> > I think I'd need this function anyway for the gdsc code. During gdsc_init()
> > we check gdsc status and this requires register access (and thus powering on
> > the parent domain) before the gdsc is registered itself as a power domain.
> >
>
> But this is a register access in the dispcc block, which is the context
> that our gdsc_init() operates. So describing that MMCX is the
> power-domain for dispcc should ensure that the power-domain is enabled.

Right.

As a note, when we assign a child domain to a parent domain, via
of_genpd_add_subdomain() for example - and the child domain has been
powered on, this requires the parent domain to be turned on as well.

>
> We do however need to make sure that dispcc doesn't hog its
> power-domain, and that any register accesses in runtime is done with the
> parenting power-domain enabled. E.g. the clock framework wraps all
> operations in pm_runtime_get/put(), but I don't see anything in the
> gnepd code for this.
>
>
> And for gcc I'm worried that we might have some GDSCs that are parented
> by CX and some by MX, but I do still think that the register accesses
> are only related to one of these.
>
> But this seems like a continuation of the special case in dispcc, so I
> think we should be able to focus on getting that right before we attempt
> the general case (and I don't know if we have a need for this today).
>
> Regards,
> Bjorn

Unfortunately, I didn't understand all the above things.

In any case, please tell me if there is anything else that blocks you
from moving forward with the power domain conversion? I am happy to
help.

Kind regards
Uffe
