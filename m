Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF92B272B38
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 18:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIUQL5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 12:11:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45630 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgIUQL5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 12:11:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id z26so17520111oih.12;
        Mon, 21 Sep 2020 09:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5xopPVHQvCwupw2qPGnrX8/IM5yBS9FV37XxNdou08=;
        b=hFZdYqZltOTB4rxpY60SKn37N2VRAga5blC8T3EM36HN5qEf1/wLnVAmzk4NlLgVtP
         8kfa5flq13GGqlRtrbOyNyrOfWtI9nJ3nozrIoY7jAKEGTWg2cVxscq1HrCKuTTELmlV
         /D6ie6v7hgbcaCTqc3i91OKPWTeW/aYerOSvYtnrqJQ/pDQCwHlrKKxAm0W/eYc2JIWj
         B0TeBgBGzEOIHE4nzH0bBWCMtRcmFDibuA8uFdbjlM+Vi0iPziVcnSMddwqlfKEV5oBE
         t2LideYA+VsKSnlYy9SxBEHNAecuSNV8uwRP4BCGsEnEWXczr6z94/0RrDI9O9rmrJWZ
         PEBQ==
X-Gm-Message-State: AOAM532B3SQg03PfGe4pkTTn6vfaUzYzt6eT4mz+yg6MIFf4W/vW74yj
        2n0M1SxIYqRfD4Kyj3l+9+CkITFnlBgLctsFejA=
X-Google-Smtp-Source: ABdhPJxGSsJ7wpuVxd0sTGjXqj0IvtjRadaXaA0vQ3zuWQjZAQjSobuRQ6HP8HZViuRxvTdCU9lcxi9EUCJP5vAKYJ4=
X-Received: by 2002:aca:df84:: with SMTP id w126mr76245oig.103.1600704716385;
 Mon, 21 Sep 2020 09:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200819104057.318230-1-ulf.hansson@linaro.org>
 <20200819104057.318230-4-ulf.hansson@linaro.org> <20200825161602.GE12523@codeaurora.org>
 <CAPDyKFrMUf4y5kVjr=dW-wf2kqBwcGePf=55U1Ck8O6tp-OuqQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrMUf4y5kVjr=dW-wf2kqBwcGePf=55U1Ck8O6tp-OuqQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 18:11:44 +0200
Message-ID: <CAJZ5v0jXn-O3xQzpW_0QahDOLeGZC58cCeOnVF66HWAsRNT4zg@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM / Domains: Add support for PM domain on/off
 notifiers for genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Wed, Aug 26, 2020 at 8:38 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 25 Aug 2020 at 18:16, Lina Iyer <ilina@codeaurora.org> wrote:
> >
> > On Wed, Aug 19 2020 at 04:41 -0600, Ulf Hansson wrote:
> > >A device may have specific HW constraints that must be obeyed to, before
> > >its corresponding PM domain (genpd) can be powered off - and vice verse at
> > >power on. These constraints can't be managed through the regular runtime PM
> > >based deployment for a device, because the access pattern for it, isn't
> > >always request based. In other words, using the runtime PM callbacks to
> > >deal with the constraints doesn't work for these cases.
> > >
> > >For these reasons, let's instead add a PM domain power on/off notification
> > >mechanism to genpd. To add/remove a notifier for a device, the device must
> > >already have been attached to the genpd, which also means that it needs to
> > >be a part of the PM domain topology.
> > >
> > >To add/remove a notifier, let's introduce two genpd specific functions:
> > > - dev_pm_genpd_add|remove_notifier()
> > >
> > >Note that, to further clarify when genpd power on/off notifiers may be
> > >used, one can compare with the existing CPU_CLUSTER_PM_ENTER|EXIT
> > >notifiers. In the long run, the genpd power on/off notifiers should be able
> > >to replace them, but that requires additional genpd based platform support
> > >for the current users.
> > >
> > >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >---
> > > drivers/base/power/domain.c | 130 ++++++++++++++++++++++++++++++++++--
> > > include/linux/pm_domain.h   |  15 +++++
> > > 2 files changed, 141 insertions(+), 4 deletions(-)
> > >
> > >diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > >index 4b787e1ff188..9cb85a5e8342 100644
> > >--- a/drivers/base/power/domain.c
> > >+++ b/drivers/base/power/domain.c
> > >@@ -545,13 +545,21 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> > >       if (!genpd->gov)
> > >               genpd->state_idx = 0;
> > >
> > >+      /* Notify consumers that we are about to power off. */
> > >+      ret = raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_OFF,
> > >+                                    NULL);
> > >+      if (ret)
> > >+              return ret;
> > >+
> > >       /* Don't power off, if a child domain is waiting to power on. */
> > >-      if (atomic_read(&genpd->sd_count) > 0)
> > >-              return -EBUSY;
> > >+      if (atomic_read(&genpd->sd_count) > 0) {
> > >+              ret = -EBUSY;
> > >+              goto busy;
> > >+      }
> > >
> > >       ret = _genpd_power_off(genpd, true);
> > >       if (ret)
> > >-              return ret;
> > >+              goto busy;
> > >
> > >       genpd->status = GENPD_STATE_OFF;
> > >       genpd_update_accounting(genpd);
> > >@@ -564,6 +572,9 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> > >       }
> > >
> > >       return 0;
> > >+busy:
> > >+      raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
> > It would be helpful to abstract these notification related calls into
> > functions of their own. So, for CPU PM domains, it would help to add
> > RCU_NONIDLE() around the notifiers, allowing the callbacks to add trace
> > functions.
>
> Thanks for the suggestion! It makes perfect sense to me - and would
> also be consistent with how CPU PM notifiers are managed,

So I thought that you wanted to send a v2, but I cannot find it.

Cheers!
