Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283E939B3B6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 09:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFDHW4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 03:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhFDHW4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 03:22:56 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3EEC061760
        for <linux-pm@vger.kernel.org>; Fri,  4 Jun 2021 00:21:10 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id u188so4342832vsu.8
        for <linux-pm@vger.kernel.org>; Fri, 04 Jun 2021 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nCIk2b978NRaiPpxcs7JKBmxKvucKceuB6IoMZqIS40=;
        b=ZIGAtPQqaZj90ijBOhbtEN6UbSW6JDVTb3skQKkXyT7Sn8IvLOfzgadfZRY+oDP2ID
         ZMeBsOwwcqZcFugcOcHXtY5NNpDK+2mU546LBKww5h4NYDSyrNNNsPOhiKTevnFXHH7s
         0U2yhPk1/rJWZJPYZfaMSj6RpkI4MmEGE0LNF+9212qjK96rXls7smV///j/yT19szGZ
         zV/+K4IkUhuy6teg8RCFhVj+4B8zaNhuuigYYBAHNSpRrklQVsDvjM18XvIWkDp3T7fB
         AWzPc5qfW0mv0KB9xl74Mu1d++YeHgt9Zxn09avq9zUdP4iqQWompMQewBjWqHT095AE
         87+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nCIk2b978NRaiPpxcs7JKBmxKvucKceuB6IoMZqIS40=;
        b=UcDkJZAQIGSb9pFcxra3M2ZJJGJkqkM7okt3JrHlM09DSk7zhRlcR0UIusnQPt4as6
         9guMHde3+ayBxDgHdnvpSA4YB9zCrd/S8RpAqeRZzIjERgUD7396xm5om8VFCixzsBTP
         GB6AWZdDIIYJEXErNPPOz8dY1JAfYoLShHs4vUyxj4Yb7fuFJS93mU0ydqw0YC7FOfBQ
         sShC9YuSkeqTmSQy/DTInfVTMAwqbN79Qh3b9MqSErfSDf+T80GCkmYJ1GIDdfah3XT8
         fgi2tYdvvBlmHAYP2ga0grVzt1kOegJOOcA+miXAfI40fnNNaArgTlVLg2aFUw7zOi/A
         Vfig==
X-Gm-Message-State: AOAM531ccKu5mpaNPUD8NrWsBHqYOG4H/mL7Cw5fraSRc9FJLV1op7AD
        oIyU56b13mSX3sOILAbnezS1pL+P9fGuXAB4XIwM6w==
X-Google-Smtp-Source: ABdhPJx5LVF77+hXRLP6Iocuj5CeDKlWwwZ7lwd/nIiXox/AjZbXcYFteL6sHSFjp+AhUFPXr1xPKRfuCImE/idcoWc=
X-Received: by 2002:a67:1087:: with SMTP id 129mr1490364vsq.42.1622791269253;
 Fri, 04 Jun 2021 00:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-4-ulf.hansson@linaro.org> <a7f55fce-dd4a-22ab-f7e2-4821e765a634@gmail.com>
 <1f71868c-7274-b4f8-e66d-dfb47cf44731@gmail.com>
In-Reply-To: <1f71868c-7274-b4f8-e66d-dfb47cf44731@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Jun 2021 09:20:33 +0200
Message-ID: <CAPDyKFrLcVQQ4pH3wyjCu8Ysjr6=Bjjd=WDwTiOagAZe2ohWMQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 3 Jun 2021 at 21:08, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 03.06.2021 22:02, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 03.06.2021 12:34, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> A subsystem/driver that need to manage OPPs for its device, should
> >> typically drop its vote for the OPP when the device becomes runtime
> >> suspended. In this way, the corresponding aggregation of the performan=
ce
> >> state votes that is managed in genpd for the attached PM domain, may f=
ind
> >> that the aggregated vote can be decreased. Hence, it may allow genpd t=
o set
> >> the lower performance state for the PM domain, thus avoiding to waste
> >> energy.
> >>
> >> To accomplish this, typically a subsystem/driver would need to call
> >> dev_pm_opp_set_rate|opp() for its device from its ->runtime_suspend()
> >> callback, to drop the vote for the OPP. Accordingly, it needs another =
call
> >> to dev_pm_opp_set_rate|opp() to restore the vote for the OPP from its
> >> ->runtime_resume() callback.
> >>
> >> To avoid boilerplate code in subsystems/driver to deal with these thin=
gs,
> >> let's instead manage this internally in genpd.
> >>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> ---
> >>
> >> Changes in v2:
> >>      - Rebased.
> >>      - A few minor cosmetic changes.
> >>      - Deal with the error path in genpd_runtime_resume().
> >
> > I tested this on NVIDIA Tegra by removing the boilerplate code from
> > drivers' RPM and haven't noticed any problems, the performance state is
> > dropped/restored as expected. Thank you.
> >
>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

Thanks a lot, much appreciated!

Kind regards
Uffe
