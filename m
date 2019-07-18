Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2DA6D26A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 18:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfGRQz3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 12:55:29 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43085 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfGRQz3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 12:55:29 -0400
Received: by mail-vs1-f68.google.com with SMTP id j26so19592028vsn.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UbJA1LvVSBKZi34z8EvemKhQnL5/c6wyw0dFUXsJ7H4=;
        b=v+KXmWJJHgzxhzH/ByzH+UGInDESBlyCnkXDLOYXkFL108hatd/9puy+QFFba3m5WD
         bhtTKrLRw2YAQnFRC5M36S3T5i8Oe9gGBtNFE7ZdCJ/1I4gLyUmnIjKdORLB/9odeMnw
         FhmH4wyOwzolrzleyGwIui2FQ8MLa67j+7E28mZP0dcFPtbM1CXxugMkHsdZeP6VkJ9g
         pXT21JDk/94eK4JtwLYOUv7st8v723fVliWhRYVAZKpLQy8dM/d+IyfGekDqo5K749U+
         kzXKq432p3MGhIBhb+v8kvOZnTcKOkNOpxCcu9VamQd7Pt/FKJqG22ZTWj0nzsbngz0X
         0K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbJA1LvVSBKZi34z8EvemKhQnL5/c6wyw0dFUXsJ7H4=;
        b=A4emvM2wYFt/HTH/1L2qMtuyIPO4YDGsCq/bAMZu+SyEYTBTOL/5gkIIlvwJgB4zM0
         dDUf96hFKeIDlFHkdA/a3WA7FFnkMFKwfh9gfbNhBGvBfjB0Qy8HHdtuZqqLkJdIiUh1
         SehjObgK+Y+bafP8h1IjPswSDt9eQpPSq7LTWkTYjGt/gGOlrwVeUgtsyhc7He5oZeUE
         lPu/SXZogEb9LpMAaM9fZRTpNKfoigin6fKX3LOc79gKVzwExLWEvLLLzAppJWBMVfov
         Ecn/DeR0wL0qK+GGLs1SeW0kzAhp4DceyPYIJx6zraQ7Q5SO0Pls5KcSVxi65D+Z5NRZ
         63bg==
X-Gm-Message-State: APjAAAU4MZmLK0Dc3Dn2uikK8rF3LgLnWYH6bVN6Kn6vcg+iyO3M6Zz5
        BbQjFlQG5GQNSL+lD/jZZVeEv7Qel5yEyKgk1AyjQw==
X-Google-Smtp-Source: APXvYqz3H7NW9n8k3hccLVjUE4vzSLFYDceNlDN7TRygVSGTeYT1EPbUZoWXTC9qw+g+yzQp96xVbuz30qFeCiP1+X8=
X-Received: by 2002:a67:61c7:: with SMTP id v190mr28723774vsb.165.1563468928660;
 Thu, 18 Jul 2019 09:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-15-ulf.hansson@linaro.org>
 <20190716155317.GB32490@e121166-lin.cambridge.arm.com> <CAPDyKFrJ75mo+s6GuUCTQ-nVv7C+9YJyTVmwuBZ2RKFOvOi3Nw@mail.gmail.com>
 <20190718133053.GA27222@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190718133053.GA27222@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Jul 2019 18:54:52 +0200
Message-ID: <CAPDyKFr4NmichQk4uf+Wgbanh=5idKYY=37WCb6U_hNFDVYg=w@mail.gmail.com>
Subject: Re: [PATCH 14/18] drivers: firmware: psci: Manage runtime PM in the
 idle path for CPUs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Jul 2019 at 15:31, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Jul 18, 2019 at 12:35:07PM +0200, Ulf Hansson wrote:
> > On Tue, 16 Jul 2019 at 17:53, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Mon, May 13, 2019 at 09:22:56PM +0200, Ulf Hansson wrote:
> > > > When the hierarchical CPU topology layout is used in DT, let's allow the
> > > > CPU to be power managed through its PM domain, via deploying runtime PM
> > > > support.
> > > >
> > > > To know for which idle states runtime PM reference counting is needed,
> > > > let's store the index of deepest idle state for the CPU, in a per CPU
> > > > variable. This allows psci_cpu_suspend_enter() to compare this index with
> > > > the requested idle state index and then act accordingly.
> > >
> > > I do not see why a system with two CPU CPUidle states, say CPU retention
> > > and CPU shutdown, should not be calling runtime PM on CPU retention
> > > entry.
> >
> > If the CPU idle governor did select the CPU retention for the CPU, it
> > was probably because the target residency for the CPU shutdown state
> > could not be met.
>
> The kernel does not know what those cpu states represent, so, this is an
> assumption you are making and it must be made clear that this code works
> as long as your assumption is valid.
>
> If eg a "cluster" retention state has lower target_residency than
> the deepest CPU idle state this assumption is wrong.

Good point, you are right. I try to find a place to document this assumption.

>
> And CPUidle and genPD governor decisions are not synced anyway so,
> again, this is an assumption, not a certainty.
>
> > In this case, there is no point in allowing any other deeper idle
> > states for cluster/package/system, since those have even greater
> > residencies, hence calling runtime PM doesn't make sense.
>
> On the systems you are testing on.

So what you are saying typically means, that if all CPUs in the same
cluster have entered the CPU retention state, on some system the
cluster may also put into a cluster retention state (assuming the
target residency is met)?

Do you know of any systems that has these characteristics?

[...]

Kind regards
Uffe
