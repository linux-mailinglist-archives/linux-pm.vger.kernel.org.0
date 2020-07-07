Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FEE216D2A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 14:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGMwd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 08:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMwd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 08:52:33 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CB1C061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 05:52:33 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id n137so9369382vkf.7
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mccdrVF4oLoKQclUhOrW5fngvBVj8VNRdTVBq4tIgxs=;
        b=R4+21DYaf6eemSb4/CbgyAImm10EW3yr7zLGvUXjG9DKbJUdhnYL/jep1ZCsipgBxy
         8SSQ/QbHIhpqhrvtBFejMdr9vu4Pq+42Pen/GXdLrY2Nn6JXgjpKFdBd3W+s//vpdvpF
         b90PNFLgQxRz++xxdEFHaCeXXB8CJNEUyUyg7XffYj7iWohjMCWiD6R7RW9Xw9Nbunf8
         SlRhDExUKtpDAicf80MeDhuFDExuKUT+xkI36isUp3TLlj2l26O2+z+/5cx9IVgfDUah
         6nFJdA7O9/k3z1Dcvm4h2eB7PwtPs2HbOWXcX+iMc0CyAU3yEYjwIaAxNnXHdy4F3Pvd
         yEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mccdrVF4oLoKQclUhOrW5fngvBVj8VNRdTVBq4tIgxs=;
        b=ukIliIbwVhOTRvcD4rKtFcOhOxAOpnkeGX+pVJVdSZEzOE500cJctiSlgm0/5eavP9
         Rdne2gVMqX+VFt7HJdE5vQuPnkn8dhbM3z1TG2UOnqTHnexiFDc3yuyYhPk2tZz67BxR
         iTnbXWJtVeYUSndYf7vAWaKVdNkJhJawB8KoRyNc2etzdqiMwrhhglDzghCHKEmr6mMx
         7Au+N/hK16aYl6PJvmgOX0as6leLBxJknFlvSdxnmyHa9lkJp+8AccFkd7j+mG7N/k8g
         jHUy+Y4RxzxWm4IIoYMc/YjbGnZ62vgKidVF86iYB+JQIkZkBLN8LOO0nckhoe99ZNKO
         5ftA==
X-Gm-Message-State: AOAM530BFKsXeM6XQ1jra+BnWLKRvur/b2EkbENJmGz/61YlLiG0qex3
        iPQpqcqVtM8uBLmgrZPT8/qijUTE1fNk9wdIK4sf2g==
X-Google-Smtp-Source: ABdhPJwaiO5NorUxLputA/SnsfA54HypHtrgadfvFccPTnCbyKbC5nsTx3KvCD3qsGWSaat9B+gJQx5r8t0hExtsRjw=
X-Received: by 2002:a1f:3f0f:: with SMTP id m15mr38376278vka.53.1594126352552;
 Tue, 07 Jul 2020 05:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200615152054.6819-1-ulf.hansson@linaro.org> <f924de32-f780-e921-fe45-cf26e70e1c66@arm.com>
 <CAPDyKFrQfjL2kBOOJj49Pf1An5ubng9_nE5=urPZM5yATR2HBg@mail.gmail.com> <cf424e19-de17-8fa8-f2a3-9e8f996fa7ad@arm.com>
In-Reply-To: <cf424e19-de17-8fa8-f2a3-9e8f996fa7ad@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jul 2020 14:51:55 +0200
Message-ID: <CAPDyKFpc+LKZ8Khjau9iLD0YJTHvqav2HD4+aDhMaPpSEXPawA@mail.gmail.com>
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

On Tue, 7 Jul 2020 at 14:37, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/7/20 12:53 PM, Ulf Hansson wrote:
> > Hi Lukaz,
> >
> > On Tue, 30 Jun 2020 at 12:23, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> Hi Ulf,
> >>
> >> On 6/15/20 4:20 PM, Ulf Hansson wrote:
> >>> The main change in this series is done in patch 5/5, which implements support
> >>> to prevent domain idlestates until all PSCI PM domain consumers are ready for
> >>> it. To reach that point the corresponding code for cpuidle-psci and
> >>> cpuidle-psci-domain, needed to be converted into platform drivers, which is
> >>> done by the earlier changes in the series.
> >>>
> >>> Additionally, some improvements have been made to the error path, which becomes
> >>> easier when the code gets converted to platform drivers.
> >>>
> >>> Deployment for a Qcom SoC, which actually takes full benefit of these changes
> >>> are also in the pipe, but deferring then a bit until $subject series have been
> >>> discussed.
> >>>
> >>> Kind regards
> >>> Ulf Hansson
> >>>
> >>> Ulf Hansson (5):
> >>>     cpuidle: psci: Fail cpuidle registration if set OSI mode failed
> >>>     cpuidle: psci: Fix error path via converting to a platform driver
> >>>     cpuidle: psci: Split into two separate build objects
> >>>     cpuidle: psci: Convert PM domain to platform driver
> >>>     cpuidle: psci: Prevent domain idlestates until consumers are ready
> >>>
> >>>    drivers/cpuidle/Kconfig.arm           |  10 ++
> >>>    drivers/cpuidle/Makefile              |   5 +-
> >>>    drivers/cpuidle/cpuidle-psci-domain.c |  74 +++++++++-----
> >>>    drivers/cpuidle/cpuidle-psci.c        | 141 +++++++++++++++-----------
> >>>    drivers/cpuidle/cpuidle-psci.h        |  11 +-
> >>>    5 files changed, 150 insertions(+), 91 deletions(-)
> >>>
> >>
> >> Since I am interested in some CPU idle statistics (residency, etc),
> >> I would like to help you and Sudeep in reviewing the patch set.
> >
> > Thanks, much appreciated!
> >
> >>
> >> Could you clarify some bit below?
> >> 1. There is Qcom SoC which has dependencies between PSCI PM domain
> >> consumers and this CPU idle - thus we cannot register and use CPU
> >> idle driver till related drivers fully setup.
> >
> > I think you got it right, but let me clarify.
> >
> > On Qcom SoC, PSCI PM domain consumers aren't solely CPU devices, but
> > also the 'qcom,rpmh-rsc' device is a consumer, for example.
> >
> > That doesn't mean the CPU idle driver can't be probed/initialized, but
> > rather that the PSCI PM domain must not be powered off. The power off
> > needs to wait until all the consumers of the PSCI PM domain have been
> > registered/probed.
> >
> > See more details in the commit message of patch5.
> >
> >> 2. The proposed solution is to use platform driver and plat. device
> >> for this CPU idle driver, to have access to deferred probe mechanism and
> >> wait for the consumer drivers fully probed state.
> >
> > Correct, but let me fill in some more.
> >
> > I would like to use the ->sync_state() callback of the PSCI PM domain
> > driver, as a way to understand that all consumers have been probed.
> >
> >> 3. Do you have maybe some estimations how long it takes for these
> >> consumers to be fully probed?
> >
> > I am not sure I understand the reason for the question.
>
> I was wondering if this is because of HW issue of long setup, thus
> we need to wait a bit longer with drivers deferred probing.
> But this is not the case as I can see now.
>
>
> >
> > Anyway, at this point, I am looking at the qcom,rpmh-rsc device, which
> > is being probed by the drivers/soc/qcom/rpmh-rsc.c driver. Moving
> > forward, in principle it can be any device/driver that is a consumer
> > of the PSCI PM domain. I am not even excluding that drivers can be
> > modules. It should work for all cases.
>
> The late_initcall won't help, this is a really tough requirement:
> being a module...
>
>
> >
> >> 4. Changing just this CPU idle driver registration point (to
> >> late_initcall()) phase in time is not a solution.
> >
> > Correct, it doesn't work.
> >
> > Playing with initcalls doesn't guarantee anything when it comes to
> > making sure all consumers are ready.
>
> I agree, especially when modules are involved.
>
> >
> > Hope this clarifies things a bit for you, but just tell me if there is
> > anything more I can do to further explain things.
>
> Yes, thank you. I can see now why you need this explicit ->sync_state()
> callback.
> I don't see better solution to what you have proposed here.
> I will go through the patches once again to check and add some
> reviewed-by.
>

Thanks a lot for your time! I am just about to post a v2, to re-order
the series so patch 3 comes first, according to suggestions from Lina.

Please move over to review that version instead, in a few minutes.

Kind regards
Uffe
