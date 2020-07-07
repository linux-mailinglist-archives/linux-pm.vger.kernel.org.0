Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF47F216C57
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 13:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGGLy1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 07:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGLy1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 07:54:27 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C08EC061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 04:54:27 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 64so16101681vsl.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOD5KW2xkwc2QlGWsfi1qdga3zBMvY24/8sEo20iUw8=;
        b=aTYTctNQZeAoac54vHmIP9W7Y0JRqDu5419ojvMwzYIZexJ4vBPSThMwxmI75u8jYW
         +4rbAMudphEUbkzyKlEvGnSGLxBdNB3cy036Zd0EJxfCXGXolpgO0BuIPhHnCW8o3lfa
         4JbEIbuqFteu2YZtnjYRACSz6+UUABBlZ0CZt6xIvbTKg0Ouse9vvKkDePUriBd/q4kW
         6Z3qf7thpOz+eY0dTj3EDbWs+6cGz4fbKdeuVv4i3QkzZd1uvRbpt5D8UYWJ0m+6Y00d
         /3Zi3ab/8mNNTGV2tYSyptYlQUNPJBr8TZ8Ls0uEsZEfDfQ2eRII70tCvP8usyPtxuT+
         l+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOD5KW2xkwc2QlGWsfi1qdga3zBMvY24/8sEo20iUw8=;
        b=i2E2FHgq8gttXGyf363pIp1wBqs1HbPG4cnYIq/Z/IySFDvSrWXHlqOzcyFwf1yc/r
         Jbn3Pho9+AEY4ytnIABWv1MLe3BtRnyLDRlgkeIKzG+IbyG3NqMpFhM57UEUcceILppb
         bb5rL2OLFvldhnJObxRkrXdBMQxxHLFuPZgHgGvqDVMWom2C9l2N4id+4F4EJp+3H/OY
         hJo9KwwvpaxQidWHyfT6oF1SodkzOw7gMJlXr9u08AwqQaxPHi2YgGv4Vd+++54EIBJ/
         X8uO9iqlsYKpKXeD0iGg7IWjsZNERSjB8cY83HcGVtg+c2g9DMWqWt7AWWHNBnQS/xqj
         RFag==
X-Gm-Message-State: AOAM530FVYNRMWh1QGr0axoP1u3QppcuHQD6V8amMG9VtYWMtKF9IUOk
        1T3KjaSeGhkgNZD3TZTS48EcQQ8YaTUQj9UA+m3K0g==
X-Google-Smtp-Source: ABdhPJxpQsMPVM75lkDsTthQ9AGtmVpdTdXfZ7HIoxbhIG8ohV55xG/29lKJsKtM4gEttqMZzLXqX1I2OxSM3BETG3Q=
X-Received: by 2002:a67:ca03:: with SMTP id z3mr32214766vsk.34.1594122866538;
 Tue, 07 Jul 2020 04:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200615152054.6819-1-ulf.hansson@linaro.org> <f924de32-f780-e921-fe45-cf26e70e1c66@arm.com>
In-Reply-To: <f924de32-f780-e921-fe45-cf26e70e1c66@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jul 2020 13:53:50 +0200
Message-ID: <CAPDyKFrQfjL2kBOOJj49Pf1An5ubng9_nE5=urPZM5yATR2HBg@mail.gmail.com>
Subject: Re: [PATCH 0/5] cpuidle: psci: Various improvements for PSCI PM domains
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukaz,

On Tue, 30 Jun 2020 at 12:23, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Ulf,
>
> On 6/15/20 4:20 PM, Ulf Hansson wrote:
> > The main change in this series is done in patch 5/5, which implements support
> > to prevent domain idlestates until all PSCI PM domain consumers are ready for
> > it. To reach that point the corresponding code for cpuidle-psci and
> > cpuidle-psci-domain, needed to be converted into platform drivers, which is
> > done by the earlier changes in the series.
> >
> > Additionally, some improvements have been made to the error path, which becomes
> > easier when the code gets converted to platform drivers.
> >
> > Deployment for a Qcom SoC, which actually takes full benefit of these changes
> > are also in the pipe, but deferring then a bit until $subject series have been
> > discussed.
> >
> > Kind regards
> > Ulf Hansson
> >
> > Ulf Hansson (5):
> >    cpuidle: psci: Fail cpuidle registration if set OSI mode failed
> >    cpuidle: psci: Fix error path via converting to a platform driver
> >    cpuidle: psci: Split into two separate build objects
> >    cpuidle: psci: Convert PM domain to platform driver
> >    cpuidle: psci: Prevent domain idlestates until consumers are ready
> >
> >   drivers/cpuidle/Kconfig.arm           |  10 ++
> >   drivers/cpuidle/Makefile              |   5 +-
> >   drivers/cpuidle/cpuidle-psci-domain.c |  74 +++++++++-----
> >   drivers/cpuidle/cpuidle-psci.c        | 141 +++++++++++++++-----------
> >   drivers/cpuidle/cpuidle-psci.h        |  11 +-
> >   5 files changed, 150 insertions(+), 91 deletions(-)
> >
>
> Since I am interested in some CPU idle statistics (residency, etc),
> I would like to help you and Sudeep in reviewing the patch set.

Thanks, much appreciated!

>
> Could you clarify some bit below?
> 1. There is Qcom SoC which has dependencies between PSCI PM domain
> consumers and this CPU idle - thus we cannot register and use CPU
> idle driver till related drivers fully setup.

I think you got it right, but let me clarify.

On Qcom SoC, PSCI PM domain consumers aren't solely CPU devices, but
also the 'qcom,rpmh-rsc' device is a consumer, for example.

That doesn't mean the CPU idle driver can't be probed/initialized, but
rather that the PSCI PM domain must not be powered off. The power off
needs to wait until all the consumers of the PSCI PM domain have been
registered/probed.

See more details in the commit message of patch5.

> 2. The proposed solution is to use platform driver and plat. device
> for this CPU idle driver, to have access to deferred probe mechanism and
> wait for the consumer drivers fully probed state.

Correct, but let me fill in some more.

I would like to use the ->sync_state() callback of the PSCI PM domain
driver, as a way to understand that all consumers have been probed.

> 3. Do you have maybe some estimations how long it takes for these
> consumers to be fully probed?

I am not sure I understand the reason for the question.

Anyway, at this point, I am looking at the qcom,rpmh-rsc device, which
is being probed by the drivers/soc/qcom/rpmh-rsc.c driver. Moving
forward, in principle it can be any device/driver that is a consumer
of the PSCI PM domain. I am not even excluding that drivers can be
modules. It should work for all cases.

> 4. Changing just this CPU idle driver registration point (to
> late_initcall()) phase in time is not a solution.

Correct, it doesn't work.

Playing with initcalls doesn't guarantee anything when it comes to
making sure all consumers are ready.

Hope this clarifies things a bit for you, but just tell me if there is
anything more I can do to further explain things.

Kind regards
Uffe
