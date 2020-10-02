Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078762818FE
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 19:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgJBRR4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 13:17:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41310 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgJBRR4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 13:17:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id q21so2067544ota.8;
        Fri, 02 Oct 2020 10:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxhZhafBoUYpGMDO7DAvPnhoms7qKvjXarS56dh880Y=;
        b=KI88S/vVgUGff1XF9sLo8m+hVQrvafP3O7MS4i+2VLdM+mnI8AICyFksQhnABPZ8bK
         GE1Qq5g0l5/aggD/+H1RIWjbXvAJGzKTgRE9FccTXgoMBmJq8S8yk09LUN3lzgBUZnHK
         IcCTwGsqG+RVo2bU9EJRX/JcvuGbl9wCE+IkVqu8aimEdj27uTK6a9ioo7pkbWs5IKcE
         89poV8UuKjuxHEuDti/7DgGCFBPJz5jLPCIS5viAeMNQsHYI1ZUH5lCmGHOQiloLlYxw
         WuwQ2IVkp0Sv0Sh/nMLIUAzU/3pDZQFbbAcOXavwSAsVn+iFxgCI8ILDHgusPcpoGXYf
         9NLQ==
X-Gm-Message-State: AOAM531Q+Jwlw+nxGiDM/6G7Q6s0iO8Ap2vrWOHriJ8ohNLh2w6VR8P8
        mcKOtnezwpX7bCLgsQgP0kbKfytNWzwkZqMRBPY=
X-Google-Smtp-Source: ABdhPJwixukqpToB+CsY0ktX6276p9c7JUx4pLN4+6W8XcCaZKdQYNeinamZoaELQMGIfLvHP+2NddBYIyjlFiF11UA=
X-Received: by 2002:a05:6830:1f16:: with SMTP id u22mr2360199otg.118.1601659073683;
 Fri, 02 Oct 2020 10:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200924110449.329523-1-ulf.hansson@linaro.org> <CAPDyKFo0Tw0K_i4QjqN_CzHt_d=HCOeudmTBsSrf1-4maD_jog@mail.gmail.com>
In-Reply-To: <CAPDyKFo0Tw0K_i4QjqN_CzHt_d=HCOeudmTBsSrf1-4maD_jog@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 19:17:42 +0200
Message-ID: <CAJZ5v0idFpiUq+7i8D7TckzLB9V3ygNap9PfWgcvHv3-Awfp8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PM / Domains: Add power on/off notifiers for genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Mon, Sep 28, 2020 at 1:57 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Rafael,
>
> On Thu, 24 Sep 2020 at 13:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v2:
> >         - Improved error handling in patch3.
> >
> > A device may have specific HW constraints that must be obeyed to, before its
> > corresponding PM domain (genpd) can be powered off - and vice verse at power
> > on. These constraints can't be managed through the regular runtime PM based
> > deployment for a device, because the access pattern for it, isn't always
> > request based. In other words, using the runtime PM callbacks to deal with the
> > constraints doesn't work for these cases.
> >
> > For these reasons, this series introduces a power on/off notification mechanism
> > to genpd. To add/remove a notifier for a device, the device must already have
> > been attached to the genpd, which also means that it needs to be a part of the
> > PM domain topology.
> >
> > The intent is to allow these genpd power on/off notifiers to replace the need
> > for the existing CPU_CLUSTER_PM_ENTER|EXIT notifiers. For example, those would
> > otherwise be needed in psci_pd_power_off() in cpuidle-psci-domain.c, when
> > powering off the CPU cluster.
> >
> > Another series that enables drivers/soc/qcom/rpmh-rsc.c to make use of the new
> > genpd on/off notifiers, are soon to be posted. However, I would appreciate any
> > feedback on the approach taken, even before that series hits LKML.
> >
> > Kind regards
> > Ulf Hansson
> >
> >
> > Ulf Hansson (3):
> >   PM / Domains: Rename power state enums for genpd
> >   PM / Domains: Allow to abort power off when no ->power_off() callback
> >   PM / Domains: Add support for PM domain on/off notifiers for genpd
> >
> >  drivers/base/power/domain.c | 187 +++++++++++++++++++++++++++++-------
> >  include/linux/pm_domain.h   |  19 +++-
> >  2 files changed, 171 insertions(+), 35 deletions(-)
> >
> > --
> > 2.25.1
> >
>
> I will need to iterate patch 3, potentially even a couple of more times.
>
> As I expect patch 1 and patch2 to not get changed, may I suggest that
> you pick up those so we can move focus to patch3?

OK, [1-2/3] applied as 5.10 material with minor subject edits, thanks!
