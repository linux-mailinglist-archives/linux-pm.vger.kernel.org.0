Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148B9273C41
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgIVHpo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 03:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbgIVHpo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 03:45:44 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9813C061755
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 00:45:43 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id q124so4037546vkb.8
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/qDHs1yp5YGxVUqY+FFXs/DSgehselwFHtYNQTy3w8=;
        b=ABKmy8+aTSRGcPU2D6WrGg35ubfBYCqcVSgDPjJ3Iwnwi4C/EG0RHj622FuDQoE/sz
         RjVRM2RIzFGY3MRdRKP9NBN+S2ScUVwgm37S3RTW2luvGZGOEQljurNLvFeHrbqO+Zw3
         f8m8tHud6R2+ksqYmTinK3Yozkx1HjXVYn9ai3z0+l3lLeJi+XGISawDV4mVvO5CMQMu
         KKCk3iZgw32GuAtgteognlTuC8XMAuxQ8/2gFqY2nPwLQjXq5C4PyBbkfUy8DhNrY2oA
         GTbAWfN25PrUGC8wJ+SXJgGCd8PWGxsTl2xuAWsqf3BfwGdjS6WVweb2NcokxbN0pI9k
         hvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/qDHs1yp5YGxVUqY+FFXs/DSgehselwFHtYNQTy3w8=;
        b=DNa9b7b3HppBk2MPa+b3PxFtg2tiFCOgl12rSSzlGbPOGYBRwCCYMf+knNuHAFkAUb
         5ljDyKv2lymm2Kqr99nJJme5Si56uiKTZFHbOOKyb7hwEDJBRKfnMJVil2ZQXh/U56z9
         HLx5nCGtaZkTJSahjptuG3ZkC2uD7r+Mc8HgqTq/CYNy1g+whwhCM+bM5eps5WCIM8hD
         9RBzOVQ6gUMmzUWcjED0UZeiZ2w8vc3d2SxhBANgoBm1rypOl3hw4TqCZbMQ4iAjHin+
         1+V+H/nUjP6VbUv3n5l9miCmECTi/013wSRU95aAzJJsT04LAukuaSLtyeeFLk1zbJ1U
         zX4w==
X-Gm-Message-State: AOAM531smqF196xuH67ceW2EJ/5YiAL2JzOZarZMnzvvY16jqd8WGNxw
        YF/kREkh19K38WTy9WRKeQQcsTtaRhCfhzJXweKDZ1CA/AeHSw==
X-Google-Smtp-Source: ABdhPJyD8h5cegXXIVw4B2gZA/oaZdFUhXob7KkezpsJ20i7w57tXHeak0On2ELj3MpuFHydoc+LQD9pCzppHsi6Cik=
X-Received: by 2002:ac5:c748:: with SMTP id b8mr2520439vkn.6.1600760742971;
 Tue, 22 Sep 2020 00:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200819104057.318230-1-ulf.hansson@linaro.org>
 <20200819104057.318230-4-ulf.hansson@linaro.org> <20200825161602.GE12523@codeaurora.org>
 <CAPDyKFrMUf4y5kVjr=dW-wf2kqBwcGePf=55U1Ck8O6tp-OuqQ@mail.gmail.com> <CAJZ5v0jXn-O3xQzpW_0QahDOLeGZC58cCeOnVF66HWAsRNT4zg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jXn-O3xQzpW_0QahDOLeGZC58cCeOnVF66HWAsRNT4zg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Sep 2020 09:45:06 +0200
Message-ID: <CAPDyKFpyNXgPveqUEha58S977k5=bX3P9h8raExEqRS-pZvvBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM / Domains: Add support for PM domain on/off
 notifiers for genpd
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lina Iyer <ilina@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 21 Sep 2020 at 18:11, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 26, 2020 at 8:38 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 25 Aug 2020 at 18:16, Lina Iyer <ilina@codeaurora.org> wrote:
> > >
> > > On Wed, Aug 19 2020 at 04:41 -0600, Ulf Hansson wrote:
> > > >A device may have specific HW constraints that must be obeyed to, before
> > > >its corresponding PM domain (genpd) can be powered off - and vice verse at
> > > >power on. These constraints can't be managed through the regular runtime PM
> > > >based deployment for a device, because the access pattern for it, isn't
> > > >always request based. In other words, using the runtime PM callbacks to
> > > >deal with the constraints doesn't work for these cases.
> > > >
> > > >For these reasons, let's instead add a PM domain power on/off notification
> > > >mechanism to genpd. To add/remove a notifier for a device, the device must
> > > >already have been attached to the genpd, which also means that it needs to
> > > >be a part of the PM domain topology.
> > > >
> > > >To add/remove a notifier, let's introduce two genpd specific functions:
> > > > - dev_pm_genpd_add|remove_notifier()
> > > >
> > > >Note that, to further clarify when genpd power on/off notifiers may be
> > > >used, one can compare with the existing CPU_CLUSTER_PM_ENTER|EXIT
> > > >notifiers. In the long run, the genpd power on/off notifiers should be able
> > > >to replace them, but that requires additional genpd based platform support
> > > >for the current users.
> > > >
> > > >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > >---
> > > > drivers/base/power/domain.c | 130 ++++++++++++++++++++++++++++++++++--
> > > > include/linux/pm_domain.h   |  15 +++++
> > > > 2 files changed, 141 insertions(+), 4 deletions(-)
> > > >
> > > >diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > >index 4b787e1ff188..9cb85a5e8342 100644
> > > >--- a/drivers/base/power/domain.c
> > > >+++ b/drivers/base/power/domain.c
> > > >@@ -545,13 +545,21 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> > > >       if (!genpd->gov)
> > > >               genpd->state_idx = 0;
> > > >
> > > >+      /* Notify consumers that we are about to power off. */
> > > >+      ret = raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_OFF,
> > > >+                                    NULL);
> > > >+      if (ret)
> > > >+              return ret;
> > > >+
> > > >       /* Don't power off, if a child domain is waiting to power on. */
> > > >-      if (atomic_read(&genpd->sd_count) > 0)
> > > >-              return -EBUSY;
> > > >+      if (atomic_read(&genpd->sd_count) > 0) {
> > > >+              ret = -EBUSY;
> > > >+              goto busy;
> > > >+      }
> > > >
> > > >       ret = _genpd_power_off(genpd, true);
> > > >       if (ret)
> > > >-              return ret;
> > > >+              goto busy;
> > > >
> > > >       genpd->status = GENPD_STATE_OFF;
> > > >       genpd_update_accounting(genpd);
> > > >@@ -564,6 +572,9 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> > > >       }
> > > >
> > > >       return 0;
> > > >+busy:
> > > >+      raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
> > > It would be helpful to abstract these notification related calls into
> > > functions of their own. So, for CPU PM domains, it would help to add
> > > RCU_NONIDLE() around the notifiers, allowing the callbacks to add trace
> > > functions.
> >
> > Thanks for the suggestion! It makes perfect sense to me - and would
> > also be consistent with how CPU PM notifiers are managed,
>
> So I thought that you wanted to send a v2, but I cannot find it.

Yes, I am about to post it. I just wanted to give people more time to comment.

Kind regards
Uffe
