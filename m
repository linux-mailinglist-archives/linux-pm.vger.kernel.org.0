Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D152AE000
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 20:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgKJTpD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 14:45:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32845 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJTpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 14:45:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id k26so15800650oiw.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 11:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWfi/DqKsjZXrTt91ATdAsWK0cE9b0QipXQIBHlzIJI=;
        b=SqQO8RYoa04jylNYgMlxipde+1hlILxvp4QvwiHtp0HFvW2btmd/3c8M5VPkwGRuNI
         YS8vEA3VeXtmItRhE0XRkna1AU1nH68SAykDrBfsxFy2T8ujWXqii4ecgHZ0KTt4RaDi
         wM5RTRnl/n0UmSGN/xAPneGeagx20sUupKLSLUXCfAow/4hpEfKPTjJrWMMOpaZNbJvD
         PWbyEi086AZsoLNTYggI9ldfQCYJ4PHPNyp4yquUwegD9cXrmTH8ZyMoc7YlgFOizZgM
         Jc3bhVdd2ySmFJD0xAIigU44Pg+7xMhq1YCO0BgBvl3DH13FKtc8ovPcrRnXrGJ0I1db
         oM5A==
X-Gm-Message-State: AOAM530FAgQRGpQ5RJ8LKcJo+SXf/osp7AWMCo4UlKoSjEQOI+4nRS0x
        iUEMNrgGMyw0jggWCw13nVxQdQrwW65p/Gw0mfLDnUHx
X-Google-Smtp-Source: ABdhPJwwNtcm28nJkm+SwfvnKWltL4rPRzszRkwI0iTGCNEvwxE3zSlTPa601AF+Rpfi6w7Okp9WtMSrooXzcIMAb8E=
X-Received: by 2002:aca:1c0b:: with SMTP id c11mr471054oic.71.1605037502321;
 Tue, 10 Nov 2020 11:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20201103150627.233438-1-ulf.hansson@linaro.org>
In-Reply-To: <20201103150627.233438-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 20:44:51 +0100
Message-ID: <CAJZ5v0jFCa+CD39rjNao_x3=b_n9ySzbbx7s10Gb9t3XB8mp_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] cpuidle: psci: Enable s2idle when using PSCI OSI
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 3, 2020 at 4:07 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v2:
>         - See changelog for each patch.
>
> When using PSCI OSI together with the PM domain topology, the domain idle
> states becomes selected via calls to pm_runtime_put_sync_suspend(). This works
> fine for the regular idle path, but not for system wide suspend-to-idle.
>
> This problem is because runtime PM gets disabled by the PM core, during system
> wide suspend. In this small series, these issues are being fixed.
>
> Kind regards
> Ulf Hansson
>
> Ulf Hansson (3):
>   PM: domains: Rename pm_genpd_syscore_poweroff|poweron()
>   PM: domains: Enable dev_pm_genpd_suspend|resume() for suspend-to-idle
>   cpuidle: psci: Enable suspend-to-idle for PSCI OSI mode
>
>  drivers/base/power/domain.c           | 51 ++++++++++++++++++---------
>  drivers/clocksource/sh_cmt.c          |  8 ++---
>  drivers/clocksource/sh_mtu2.c         |  4 +--
>  drivers/clocksource/sh_tmu.c          |  8 ++---
>  drivers/cpuidle/cpuidle-psci-domain.c |  2 ++
>  drivers/cpuidle/cpuidle-psci.c        | 34 +++++++++++++++---
>  include/linux/pm_domain.h             |  8 ++---
>  7 files changed, 81 insertions(+), 34 deletions(-)
>
> --

Applied as 5.11 material, thanks!
