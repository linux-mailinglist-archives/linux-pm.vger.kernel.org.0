Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5D439F71D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhFHMzO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 08:55:14 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:15956 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhFHMzO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 08:55:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623156791; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iktalfMGhuFVVPNe7abSgfi4HUwMHxxpDQH1UJgQ9DELDCrJg1q9oqCSd9XDuAxR1C
    a/yhUAK1LXmRCx9iXBH1jG6t6PPVmD89SCbqfbxd3h2E5708hA3P9JEB8a+VjJhoqeEO
    iLlpLh270aajLKaok0WLaDvUVoFcav37A87WZSXzseYryBaLaQMr7/UkInD0xd67gDtf
    1kgZaVrdWhV87M1Xad0j1bNd/OKg6jrrVrbpXtEF1pK31rkEungcXQDnO0xcXYgEDazX
    nc2K/DiKGKg3GTbzF9IJr3rZ/oy5qo4FejKxFDzt6QA8rYoIb0TUFe4fnF7rGUPNsHP1
    pgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623156791;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=rB+uyQ8t9oJZLhbyMwCpJlNoKpSqnO6KJlB/IeAfyXs=;
    b=czBP43zxiD1A5Ce+yiwu0AVqYPfGVLfcJcaA2lBhQCEUktHZmjlVYaOTOX5D87BMLS
    ub+P3u0nIHJqSlU48IPN2+SRYcwMvNnd1PdeiU7QziLZe2GWVN0Wk4Z14fchOHL9vg6H
    3D6WC/ywyUrEWW8isvvlwX4z8zGRbFhNJxWKfPtF9jKDMTytEcJXPEZsStxjr9xug76a
    wItmSNYt4LtUfKYWMTsMVgF0oCc21RLvS7eGMNQg6VN5oQ3GC+jXehRymGxIdeHnxKAi
    aIxPYWyQcHljZirK0ZTXOG5w4jM2ylksm1dfR8FZKmTd4uZKUxWELeY1iTKpZ+JGlKV3
    r8sA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623156791;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=rB+uyQ8t9oJZLhbyMwCpJlNoKpSqnO6KJlB/IeAfyXs=;
    b=nlHcBPMtMpUSi4lZpVA2ijF3vPYRH9hHAFeiJcdrtMJSY+Qw4siKU5/MdXUXKM5fsu
    //+S13URJ8OJ+mAHKVzcaH3Bn1ykyVZ7P943T3Yyh+y7P+CLVQlQCnZfeoT/ff+cS/1j
    9hhC5McQoRJmgN6IOy2tYFALrCZ07X7bVQTwP6SK6h3sLL3M9LHbn6FNQuVMT5IcveFB
    Wt+VV4b2J273qeJYll0v7lJHB5mL3DSq8rhlYFB9ck8AV0W4Jd4VN1wXuU7mQ47a/e34
    egZIulhKwxDmcqV55qTUXuajiCVKkIRqoyCdWxUa/ZLdBIFWzTVIKMkL+Dpqx4rlcvHk
    qfsw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7IcbDBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x58CrBdLb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 8 Jun 2021 14:53:11 +0200 (CEST)
Date:   Tue, 8 Jun 2021 14:53:05 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>,
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
Message-ID: <YL9oMVqox7GVASen@gerhold.net>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-5-ulf.hansson@linaro.org>
 <CAPDyKFp2dKFQpLMgazXumCxf=FHQ9bdadXUkGsjiAwniF8p2dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp2dKFQpLMgazXumCxf=FHQ9bdadXUkGsjiAwniF8p2dw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, Jun 03, 2021 at 12:20:57PM +0200, Ulf Hansson wrote:
> + Mark Brown, Dmitry Baryshkov
> 
> On Thu, 3 Jun 2021 at 11:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Recent changes in genpd drops and restore performance state votes for
> > devices during runtime PM.
> >
> > For the similar reasons, but to avoid the same kind of boilerplate code in
> > device PM callbacks for system sleep in subsystems/drivers, let's drop and
> > restore performance states votes in genpd for the attached devices during
> > system sleep.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> After a second thought, it looks like we maybe should defer to apply
> this final patch of the series. At least until we figured out how to
> address the below issue:
> 
> So, I noticed that we have things like "regulator-fixed-domain", that
> uses "required-opps" to enable/disable a regulator through the
> dev_pm_set_performance_state() interface.

Not directly related to your concern, but related to another discussion
we had recently: To me, this looks mostly like another solution for
voting for performance states without doing full DVFS, also known as
assigned-performance-states [1] or required-opps on devices [2]. :)

It's just wrapped in a regulator interface here. Actually, if we
implement [2], the regulator-fixed-domain should mostly just become some
sort of simple wrapper around runtime PM for the regulator device, since
the required-opp might be applied automatically then.

[1]: https://lore.kernel.org/linux-arm-msm/1622095949-2014-1-git-send-email-rnayak@codeaurora.org/
[2]: https://lore.kernel.org/linux-arm-msm/YLYV3ov%2FiBffZMg4@gerhold.net/

> We likely don't want to drop the performance state internally in genpd
> when genpd_suspend_noirq() gets called, for the corresponding struct
> device for the regulator.
> 

So your concern is that the performance state is dropped during suspend
even though the regulator core thinks the regulator stays enabled?

I played with regulator-fixed-domain a bit and I would say this is
already broken (unless you rely on one of the side effects I mentioned
in [3]). The power domain gets powered off entirely during system
suspend, and then the performance state won't have any effect either.

I guess we would need some way to say that this device should only be
managed through runtime PM and never automatically suspended during
system suspend?

Stephan

[3]: https://lore.kernel.org/linux-pm/YLkOAyydZMnxkEy+@gerhold.net/
