Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9353A1449
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 14:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFIM1y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 08:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFIM1x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 08:27:53 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87DC06175F
        for <linux-pm@vger.kernel.org>; Wed,  9 Jun 2021 05:25:59 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id z15so12713574vsn.13
        for <linux-pm@vger.kernel.org>; Wed, 09 Jun 2021 05:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hucOmK/CjweQJSSO1Hf7ZZzsD4aQuXOkD7vA3MTZoGs=;
        b=x9aAzg/x5G9mUEdZDORGkYQ24KtiAFvlulFcNv4ktthMC/3J6t3F4t+kdB69qCFRaX
         ut5simhYHjRbFuAeYs8lYlRmz4HULtCyugBU0WouLgYznvTJx9Wyok44ow82WkwvGdRe
         /Msa7dX2PiGH0gafRD2/nPxCLsg2SY2J4Yqt7dn9DzRqmiH1hNDITFiOnG9ZYQHTOuKE
         0ShI1IdrLCvAPWH07Z2e9KitGYkaiCX7QcmH9NKIeTIVcxH5kaOdChmaEd1M5xkGV6GA
         MvNLNu2utrcE9S/O1HkcN10HUs5iPjY6ipic8Dss80q/4PA/+ndM1zDSXp4pE7n8lo1U
         fiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hucOmK/CjweQJSSO1Hf7ZZzsD4aQuXOkD7vA3MTZoGs=;
        b=KxABuVAA81s/T+7D/JdDb6HTlI+toqJwirYe4Hw0mLC5m1b3jsCwPKBOAl73KV8XPy
         l2v5+KJKAMKNSKKGxfdnQuTUyo7uHd9hqzm1YbkEUVnZgAx2uJsSjC5TG0Z+6oxFFLMr
         0Vhx6iiUFXPEgd1q+YiYCTBffil0TeWJruoYFjyqEpFiLLgI53b7jlUD1qEdmTexPAWg
         1gumbKKdHGr81McYIOil/KZ8oLglMWIhCjCFX3jUe4+/201ymSfEGrSp6N9QyhSnYiQW
         ANmRiHcGVMj1RTtqkI4gk+I7MSHXBygaimS2VZr1tjEJKrkeTueZOXW0lxJMIIt1ZwOH
         15tw==
X-Gm-Message-State: AOAM5303kmzZygsA3xP2tLc7XeqQB5aU7NKobJgaIRupZKJNADgamHUH
        rQ+BhWkqR607C4F0ISudKElXEUU9wQPGiP4EAQhLZA==
X-Google-Smtp-Source: ABdhPJy7KcEHCwAaiCIys8J7qxz/MxxcEvspJjZuO7G2eUL4pwe+yKUl4aJ7ZCGjugmoNSNSxDBg2LHunhYoGIRskvA=
X-Received: by 2002:a05:6102:d1:: with SMTP id u17mr4787199vsp.48.1623241557705;
 Wed, 09 Jun 2021 05:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-4-ulf.hansson@linaro.org> <20210603095538.b2t3cq25tq7v7kih@vireshk-i7>
 <CAPDyKFqNNeeMo6+gKgaPtPvgC_NuMxxYKkr+TzyP3vjYoHoDOw@mail.gmail.com>
 <CAPDyKFofsuY_RAMGsRLtKo=JxJ11DgGqOijZEEf1HEANCvomzg@mail.gmail.com>
 <20210604035312.jp2gshfigsodwvcg@vireshk-i7> <CAPDyKFq=mGOqYrX5322JOmJXm6Yg-zNh+g66BdaVVfE5JgciAQ@mail.gmail.com>
 <20210607044738.3aec6o4imq6u3x6e@vireshk-i7>
In-Reply-To: <20210607044738.3aec6o4imq6u3x6e@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Jun 2021 14:25:21 +0200
Message-ID: <CAPDyKFrQWUWsuEn6NfT5zjXbSDArgmceW=JpKNwwH2Rm19=iXw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 7 Jun 2021 at 06:47, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 04-06-21, 09:45, Ulf Hansson wrote:
> > Starting calls from the subsystem/driver:
> >
> > ------
> > dev_pm_genpd_set_performance_state(dev, 100);
> > "run a use case with device runtime resumed"
> > ...
> > "use case ends"
> > dev_pm_genpd_set_performance_state(dev, 0);
> > pm_runtime_put()
> >     ->genpd_runtime_suspend()
> >     gpd_data->performance_state == 0, -> gpd_data->rpm_pstate = 0;
> > ...
> > "new use case start"
> > dev_pm_genpd_set_performance_state(dev, 100);
> > pm_runtime_get_sync()
> >     ->genpd_runtime_resume()
> >     gpd_data->performance_state == 100, -> gpd_data->rpm_pstate = 0;
> > (This is where we need to check for "zero" to not override the value)
> > .....
> > ------
> >
> > I wouldn't say that the above is the way how I see the calls to
> > dev_pm_genpd_set_performance_state (or actually
> > dev_pm_opp_set_rate|opp()) being deployed. The calls should rather be
> > done from the subsystem/driver's ->runtime_suspend|resume() callback,
> > then the path above would work in the way you suggest.
> >
> > Although, as we currently treat performance states and power states in
> > genpd orthogonally, I wanted to make sure we could cope with both
> > situations.
>
> I think letting the drivers to call
> dev_pm_genpd_set_performance_state(dev, 0) from suspend/resume makes
> it really ugly/racy as both depend on the gpd_data->performance_state
> for this. It doesn't look nice. And we shouldn't try to protect such
> drivers.
>
> Anyway, your call :)

Well, I am not sure we have an option at this point. As long as we
allow performance states to be managed orthogonally to on/off states
in genpd, the check in genpd_restore_performance_state() is needed.

I have started to prepare a new version of the series - and will add a
comment about this in the code to try to clarify this.

[...]

Kind regards
Uffe
