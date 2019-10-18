Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5764CDC2C8
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405197AbfJRKad (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 06:30:33 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33377 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfJRKad (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 06:30:33 -0400
Received: by mail-vk1-f193.google.com with SMTP id s21so1238329vkm.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2019 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBRSB47R5zdfT32KlX+aV4HkEYKUi3HGXtyDlZlyb9g=;
        b=Dss1BgqrjNvxuj0zYw0vhMToennUoBig/tBC3bNtaANNS1mXutL2nXPRNgUm9TjRR7
         4eX32k2Vni3lmF4HIV+5HHnMLh+zuaLl2alVyDHD6OfstLB8WN9T99dbFXQlBcibMymN
         Tnnoe0JRnYSo4BHGsvDVou6OdACw+OTwQxLtdZQ2uvflcvyJe0a1r4P0mEihlTLKBMMj
         BJVKfnlbyfxvalsJ6/NZSqVPMsoPGPhI1RTrh+nilz0ErmTzjWheU9vFgoUDHCMLdKJZ
         TsFTPOw6yd2MNTWd08IzfDoE5c13uu4RjJkCouYyNUXWjbo4v84d9ivQ2aAp0xDEEskt
         d1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBRSB47R5zdfT32KlX+aV4HkEYKUi3HGXtyDlZlyb9g=;
        b=ihl6VVBFF3qK8ad8nYO1h+cmlEUy3OimGr3VMeb0yxvOHFrOzYVPwIInSOTZmuoCLm
         rFaMbl/UarCMQEZ30uPBH+y5IKC3CiY4f7VWmZ5QNtv68ONxKE/+aPFmmskr+yZ37zmr
         I38Th+qhOFH4U7aEeKpEUfN8Zj+0Gg452a5NDHndt2JBRDzs4Yp24jgb3RT2s/+mLGPD
         Q8IaNt8J8P85/czWUGIyCKP+FHzN72h0QhH0rxApYyI1l7jOdAmcRcUJ0Q/sTH2Q8GHJ
         4Ds8a5DLXxmJSiokqHpLnaUE1xl3a9ujB5K7fzSx7InOOn3zXXoymnBBmmCOMpQDWuMo
         L9Zg==
X-Gm-Message-State: APjAAAVvQlCYtXO6Fo+fUn/p3rGGJFXKq4RuEQO3GGaC7ZVsh6SXmyWo
        r0PN9gQf1uWX99h8Ax+5F8tqhcu8XqiGmP+kidHiZw==
X-Google-Smtp-Source: APXvYqzU6e6q9t22pNva8KyfPNj9Pj4U12mHVaQ4OI5IfhQefBCPy5AbRQB8q7JWkerOtbOZWoMaHG5QAkVyTTZRZec=
X-Received: by 2002:a1f:a293:: with SMTP id l141mr4885218vke.43.1571394630718;
 Fri, 18 Oct 2019 03:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-2-ulf.hansson@linaro.org> <20191018093839.GB25918@e121166-lin.cambridge.arm.com>
 <CAPDyKFqcHY6+Eq9d6xTPYMDrUOtGs+64YuwZ1EbFtqQZe0+xEw@mail.gmail.com> <20191018100304.GA28830@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191018100304.GA28830@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:29:54 +0200
Message-ID: <CAPDyKFoEf1-2z8d2r15=fg-9sY5u93iOzuUmmsYYiG9+8uB9Dw@mail.gmail.com>
Subject: Re: [PATCH 01/13] cpuidle: psci: Fix potential access to unmapped memory
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 18 Oct 2019 at 12:03, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Oct 18, 2019 at 11:51:11AM +0200, Ulf Hansson wrote:
> > On Fri, 18 Oct 2019 at 11:38, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Thu, Oct 10, 2019 at 01:39:25PM +0200, Ulf Hansson wrote:
> > > > When the WFI state have been selected, the in-parameter idx to
> > > > psci_enter_idle_state() is zero. In this case, we must not index the state
> > > > array as "state[idx - 1]", as it means accessing data outside the array.
> > > > Fix the bug by pre-checking if idx is zero.
> > > >
> > > > Fixes: 9ffeb6d08c3a ("PSCI: cpuidle: Refactor CPU suspend power_state parameter handling")
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/cpuidle/cpuidle-psci.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > > > index f3c1a2396f98..2e91c8d6c211 100644
> > > > --- a/drivers/cpuidle/cpuidle-psci.c
> > > > +++ b/drivers/cpuidle/cpuidle-psci.c
> > > > @@ -27,10 +27,10 @@ static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> > > >  static int psci_enter_idle_state(struct cpuidle_device *dev,
> > > >                               struct cpuidle_driver *drv, int idx)
> > > >  {
> > > > -     u32 *state = __this_cpu_read(psci_power_state);
> > > > +     u32 *states = __this_cpu_read(psci_power_state);
> > > > +     u32 state = idx ? states[idx - 1] : 0;
> > > >
> > > > -     return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
> > > > -                                        idx, state[idx - 1]);
> > > > +     return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
> > >
> > > Technically we don't dereference that array entry but I agree this
> > > is ugly and potentially broken.
> >
> > No sure understand the non-deference part.
> >
> > If the governor selects WFI, the idx will be 0 - and thus we end up
> > using state[-1], doesn't that dereference an invalid address, no?
>
> No because CPU_PM_CPU_IDLE_ENTER_PARAM is a macro, the code it
> preprocesses to won't dereference state[idx - 1] if idx == 0.
>
> I agree it is *very* ugly but technically code is not broken.

Ahh, got it, thanks!

>
> > > My preference is aligning it with ACPI code and allocate one more
> > > entry in the psci_power_state array (useless for wfi, agreed but
> > > at least we remove this (-1) handling from the code).
> >
> > I can do that, but sounds like a slightly bigger change. Are you fine
> > if I do that on top, so we can get this sent as fix for v5.4-rc[n]?
>
> Technically we are not fixing anything; it is not such a big
> change, we need to allocate one entry more and update the array
> indexing.

Okay, let me do the change - and it seems like it doesn't even have to
be sent as a fix then. Right?

Kind regards
Uffe
