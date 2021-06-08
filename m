Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF7839FAF9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 17:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhFHPjL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 11:39:11 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:11208 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhFHPjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 11:39:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623166631; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EnvGpLsDw8LPc/Rc6cr3BPkqC40XdGd+VVFdx6Ignc2zJR+u6BXgu/eAHdh7pSoPpn
    RjLWquYBeyxQP4Rgd3438GRR6o87VOoxEZlpDqhyXniCOUsYAbTCjrghshuxSJvIymBc
    7VN+orq80SSgGdjIsnl07YMWBASnElzPhm10up3Nb375l0lrjW84emutK2/VlT8lk8X3
    jlspbdGGOuKxpkEv7xn/RQPxWyH6sdXYRK9yagLCMkb9j/uv8d9hqOqlhEXo1jU+Ujmj
    jOXwkyhRxancwbLBiFFRkfcoDdIeihcmshoCgwPmtDRp3x8ByLviughDOyyWiFSPcDHA
    8NNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623166631;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=f0l5oelStxWG/FGeI/VF3liF+0lq8YAeBbESVm14aVU=;
    b=BHQnUWQyNVDOKmfVskx9O3BgCWtFevdR4hVJsxAqZNbEGUKo6uPb1vQ7rehx9csK+1
    aFfMZ4IISkeKWs+/J3OJTxSm5S6sRT2fqzuSVc9N67KNuFo/r2ko52wqMFj5cxaiUYJ/
    VgZAADhAVcFXfj6jDwjybeJX7T7qm9Li3Uz1i1Swc1w7lAfNZFxh/yCTszuWvB/opoQ5
    gFIHusyrshA5Pdyb8pScYP4JUWS76rJzjLL9p0Eo09Cvc1KEbV0SbE4ky66scqUQZd7W
    KJwsvvtEG0DqLkDB954GSRVqxBwAS91tlLOJ/kKwwXv9Kvcb5z7y9fryG0NFkiEM9+rN
    8ceg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623166631;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=f0l5oelStxWG/FGeI/VF3liF+0lq8YAeBbESVm14aVU=;
    b=rChKsULgDJSfiz0xrBQgTNk/jQa+1MUszgCwz+/n4b3m/XBKx/VHiVloONk2DGlKoI
    eF2kUzAiMN85f87sw9o+dxwvkbznzO9OjZGM1At2QJlKVZHl0i/4Qkj7UBM7bAW2+KII
    AjqUSAexnjj5NSbGcJOeAMQvLtfDgkJnjmYCDkBH7cYFNT1vVa0kd5XM16gd49pB8C12
    qPnPvEqhi/cctdMZuyLhsvg7yFOcqCErQgA4fz52wu9JUbYFwyVE5+ltRgo0F2IIcpMJ
    I9mVkcxESDbW2qO4JXD4GenEvEcoREfp09GrHsBDJozOXj+y4PDZg6isD/PtdxiJ6z3H
    SX5g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7IcbDBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x58FbBfzZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 8 Jun 2021 17:37:11 +0200 (CEST)
Date:   Tue, 8 Jun 2021 17:37:04 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 4/4] PM: domains: Drop/restore performance state votes
 for devices at system PM
Message-ID: <YL+OoJWJ0VsrHmWk@gerhold.net>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-5-ulf.hansson@linaro.org>
 <CAPDyKFp2dKFQpLMgazXumCxf=FHQ9bdadXUkGsjiAwniF8p2dw@mail.gmail.com>
 <YL9oMVqox7GVASen@gerhold.net>
 <CAPDyKFrvrikCZLX1EvmLZumeCnfAxUUssO2OWc130TG8oey=qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrvrikCZLX1EvmLZumeCnfAxUUssO2OWc130TG8oey=qw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 08, 2021 at 04:08:55PM +0200, Ulf Hansson wrote:
> On Tue, 8 Jun 2021 at 14:53, Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > Hi,
> >
> > On Thu, Jun 03, 2021 at 12:20:57PM +0200, Ulf Hansson wrote:
> > > + Mark Brown, Dmitry Baryshkov
> > >
> > > On Thu, 3 Jun 2021 at 11:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > Recent changes in genpd drops and restore performance state votes for
> > > > devices during runtime PM.
> > > >
> > > > For the similar reasons, but to avoid the same kind of boilerplate code in
> > > > device PM callbacks for system sleep in subsystems/drivers, let's drop and
> > > > restore performance states votes in genpd for the attached devices during
> > > > system sleep.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > After a second thought, it looks like we maybe should defer to apply
> > > this final patch of the series. At least until we figured out how to
> > > address the below issue:
> > >
> > > So, I noticed that we have things like "regulator-fixed-domain", that
> > > uses "required-opps" to enable/disable a regulator through the
> > > dev_pm_set_performance_state() interface.
> >
> > Not directly related to your concern, but related to another discussion
> > we had recently: To me, this looks mostly like another solution for
> > voting for performance states without doing full DVFS, also known as
> > assigned-performance-states [1] or required-opps on devices [2]. :)
> >
> > It's just wrapped in a regulator interface here. Actually, if we
> > implement [2], the regulator-fixed-domain should mostly just become some
> > sort of simple wrapper around runtime PM for the regulator device, since
> > the required-opp might be applied automatically then.
> 
> Honestly, I am not sure about what the regulator-fixed-domain intends
> to model, but I assume it's something that fits well to be modelled as
> a plain regulator, to start with.
> 
> Perhaps Mark can chime in and spread some light over this?
> 
> >
> > [1]: https://lore.kernel.org/linux-arm-msm/1622095949-2014-1-git-send-email-rnayak@codeaurora.org/
> > [2]: https://lore.kernel.org/linux-arm-msm/YLYV3ov%2FiBffZMg4@gerhold.net/
> >
> > > We likely don't want to drop the performance state internally in genpd
> > > when genpd_suspend_noirq() gets called, for the corresponding struct
> > > device for the regulator.
> > >
> >
> > So your concern is that the performance state is dropped during suspend
> > even though the regulator core thinks the regulator stays enabled?
> 
> Yes.
> 
> >
> > I played with regulator-fixed-domain a bit and I would say this is
> > already broken (unless you rely on one of the side effects I mentioned
> > in [3]). The power domain gets powered off entirely during system
> > suspend, and then the performance state won't have any effect either.
> 
> Right, I get your point.
> 
> Although, this isn't a problem, because the on/off and performance
> states are today considered as orthogonal in gendp. Well, at least
> currently until/if we decide to change this.
> 

And in practice applying your patch should not be a problem either. :)
The main user so far is arch/arm64/boot/dts/qcom/sm8250.dtsi with the
rpmhpd genpd provider. That one drops the performance states anyway
when the power domain gets powered off.

> >
> > I guess we would need some way to say that this device should only be
> > managed through runtime PM and never automatically suspended during
> > system suspend?
> 
> Yes!
> 
> For the on/off state, genpd uses the system wakeup interface to
> understand whether the device is used in a wakeup path, see the call
> to device_wakeup_path() in genpd_finish_suspend().
> If that's the case the PM domain stays powered on during system suspend.
> 
> Potentially we could use the same interface (or something similar) to
> support these kinds of cases.
> 

Hmm, I wonder if I need something similar for my CPU DVFS case as well.
In my testing back then the power domain for the CPU was powered off
during system suspend. This doesn't make sense, since it's the CPU that
is running all the system suspend code. :)

Actually in my case there is no need to do anything during system
suspend. I use a special MSM8916_VDDMX_AO power domain from the "rpmpd"
genpd provider where _AO means "active-only". I think it's some kind of
firmware mechanism to only apply the performance state vote if the CPU
is actually active and the cluster is not powered down.
(I hope that MSM8916 actually powers down the CPU cluster during
 system suspend/s2idle after all your PSCI cpuidle patches :))

So I think I will also need to opt-out from the effects of this patch.

Stephan
