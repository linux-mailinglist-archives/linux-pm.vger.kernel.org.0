Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ABA2908AB
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408617AbgJPPlq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 11:41:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38966 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408610AbgJPPlp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 11:41:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id c13so2890334oiy.6;
        Fri, 16 Oct 2020 08:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLNdAZob0B/HfCZfs4SRDuNnBT+b5bjOmS6VwnBTk1c=;
        b=gZuxKBhr+2gI5vd8J1O6KXoEA3SA9DknL8NhW/oteOljvvJSQW7RlnYRKMKo22Z2Ce
         dKSkvzLOUK0TYrrnppYl2DIakKMHOzCKcB1hGPpQX1vgp7HrujRPILK4OFjLHRd7jhcE
         rOd7v97r3isHCO9EUqy9vUTX916PtPS/oSnAcN0RS68NYw/7G9YS17rcwvuyP3D7tPqW
         fWrij8xUj4sWX4DcECkbVqCTg7v9HENOAYYK7olyVng3NdhcDzoGlB/XlxtcwfGvPmbk
         LgJAQBkfpOO2EatDoOMXdC7sVP2WoJCkpk+stFc2X57ylUc72mmYB8hlveSs6JZMQmV0
         m1mw==
X-Gm-Message-State: AOAM533hw92m4nvZzDX2NVwjtqPZmi21zQAKm3m2lR3oMtD5w45nhWh/
        4Y3uJr8lfpWfw25A5y8T9ypsZLopDVN49EvzXWU=
X-Google-Smtp-Source: ABdhPJxNIl2elS5L/rj8wJdj9B92T+Gl6g2IY9jJsgPxco/8aXyzrkAkbfQGBxSIsFSjtao5ufV2VdflVfFtIsMrxCE=
X-Received: by 2002:aca:724a:: with SMTP id p71mr2891999oic.157.1602862904691;
 Fri, 16 Oct 2020 08:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201013122339.450955-1-ulf.hansson@linaro.org>
In-Reply-To: <20201013122339.450955-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 17:41:33 +0200
Message-ID: <CAJZ5v0iTn34nE6u2SK2Niz_NmQi8O7QUjPAkCZY2Mo42WzDAiw@mail.gmail.com>
Subject: Re: [PATCH v3] PM: domains: Add support for PM domain on/off
 notifiers for genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 2:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> A device may have specific HW constraints that must be obeyed to, before
> its corresponding PM domain (genpd) can be powered off - and vice verse at
> power on. These constraints can't be managed through the regular runtime PM
> based deployment for a device, because the access pattern for it, isn't
> always request based. In other words, using the runtime PM callbacks to
> deal with the constraints doesn't work for these cases.
>
> For these reasons, let's instead add a PM domain power on/off notification
> mechanism to genpd. To add/remove a notifier for a device, the device must
> already have been attached to the genpd, which also means that it needs to
> be a part of the PM domain topology.
>
> To add/remove a notifier, let's introduce two genpd specific functions:
>  - dev_pm_genpd_add|remove_notifier()
>
> Note that, to further clarify when genpd power on/off notifiers may be
> used, one can compare with the existing CPU_CLUSTER_PM_ENTER|EXIT
> notifiers. In the long run, the genpd power on/off notifiers should be able
> to replace them, but that requires additional genpd based platform support
> for the current users.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - Adopted suggestions from Peng Fan to allow more fine grained levels of
>         notifications, which is needed on some NXP platforms.
>         - Move the code that fires the notifications into _genpd_power_on|off(),
>         as it simply fits better in there.
>
> Note that, I understand that some of us may be occupied with dealing with the
> merge window, but I still wanted to get this submitted to allow those that have
> some time to review and test.

Appreciated. :-)

Anyway, applied as 5.10-rc material, thanks!
