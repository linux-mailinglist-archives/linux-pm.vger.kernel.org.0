Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6F22C435
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 13:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgGXLP2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 07:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXLP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 07:15:27 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EADC0619D3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2020 04:15:27 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id x205so4679796vsc.11
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2020 04:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLYnfhepgNYpjm9RxTTGrTgmOXkZq+Gr9tFUTfKpv+A=;
        b=FU6weO/oBcvm0aWRhfSCfHv4La6mrxHd94hI+RArQQ98Ws9b7mXm8YWAF3D9nr7ObZ
         wuoYWsp+IHq9W8flbOKRQQX/Gp2sUeyDHw6H2EWuNfHHODi6gTTzE2SQukP0fhhMPWcw
         UVTt7ClpL2BmxuhNwphCQRWwGh2oDtwRmeD/R1HdwxE0dcHpwvYO25LvylsNqFNUlvxA
         uLD9eq4zwnzHIbTMf1fY1I5Jy2LC/vQc9ryWDJ/vUiLFKCaAAnxTiQzqxiTilG2duM/Z
         pb4e2oYU+IR80A574AV3g5joxpCwShDv4NRVc6EhYFVeKdS4Xa2pUmJxswAVsc9xUona
         1M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLYnfhepgNYpjm9RxTTGrTgmOXkZq+Gr9tFUTfKpv+A=;
        b=eA6QUpJvL+Iw1fJk8/cT2iWtGQsS8AW9SkaVnyetWglYEH3Ytr5XlOTBcjsJMgoA9o
         U/8AtGTgQtlejWoeasrMq4oOdGxHghAvoOAHyTng3grKrEPfadSpLMrFQxqgRYKOn2Qo
         ukCQ9DFkSuYzzMDO9bZ4SOIvnEJYzSUw8CBnpJAS99f2QNX8i5OJFjOBxjFQLLUPk4US
         pMsMhKHpkrbczugrBI6UPPxkDSO4cPkctzxwCxlmZeGApwBnM2KJwqjBESxJ3u+4RwbE
         DvkjhZoXomjkWllcew2p4zMIWwh3OsPnuZLYDwjgQvlr3TZXCQNHtVBVyhFs/7qtmt6F
         kyLQ==
X-Gm-Message-State: AOAM533PJhS+NaBKdWhxsH1AsWJscqCtAHT0CkiKryRY6eMk2Pt2Dp1G
        ub2mxDHEZyKLAW9YsanD76UV7LPenlq9ZygoXvDMwQ==
X-Google-Smtp-Source: ABdhPJyDHDagKTvL/x/AlOQlbHyG9WVDCsrClOLGTJxnt+WoTrnDXdE//NEIEIsVgy32AxTax3z0in9kVAC37geudZ8=
X-Received: by 2002:a67:d01a:: with SMTP id r26mr7427338vsi.200.1595589326678;
 Fri, 24 Jul 2020 04:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200707125804.13030-1-ulf.hansson@linaro.org> <CAPDyKFp6+kSHsgvjQQwyQtot2KqdhikbCJW0JUSQJZyfa9cRyw@mail.gmail.com>
In-Reply-To: <CAPDyKFp6+kSHsgvjQQwyQtot2KqdhikbCJW0JUSQJZyfa9cRyw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jul 2020 13:14:49 +0200
Message-ID: <CAPDyKFpi0jy1OQu7X4KEQVvTCDAHK=A5WueD1XPGj9dxDeNS3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] cpuidle: psci: Various improvements for PSCI PM domains
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Saravana Kannan <saravanak@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020 at 11:53, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 7 Jul 2020 at 14:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v2:
> >         - Put patch 3 as patch 1 and rebased accordingly. No other changes have
> >         been made.
> >         - Added reviewed-by and acked-by tags.
>
> Rafael, I think this is ready to be picked up. In particular, the code
> that Sudeep/Lorenzo cares most about has been reviewed by
> Sudeep/Lukaz.

Rafael, apologies for nagging. Any reasons you see why this can't be
queued up by now?

Kind regards
Uffe

>
>
> >
> > The main change in this series is done in patch 5/5, which implements support
> > to prevent domain idlestates until all PSCI PM domain consumers are ready for
> > it. To reach that point the corresponding code for cpuidle-psci and
> > cpuidle-psci-domain, needed to be converted into platform drivers, which is
> > done by the earlier changes in the series.
> >
> > Additionally, some improvements have been made to the error path, which becomes
> > easier when the code gets converted to platform drivers.
> >
> > Deployment for a Qcom SoC, which actually takes full benefit of these changes
> > are also in the pipe, but deferring then a bit until $subject series have been
> > discussed.
> >
> > Kind regards
> > Ulf Hansson
> >
> > Ulf Hansson (5):
> >   cpuidle: psci: Split into two separate build objects
> >   cpuidle: psci: Fail cpuidle registration if set OSI mode failed
> >   cpuidle: psci: Fix error path via converting to a platform driver
> >   cpuidle: psci: Convert PM domain to platform driver
> >   cpuidle: psci: Prevent domain idlestates until consumers are ready
> >
> >  drivers/cpuidle/Kconfig.arm           |  10 ++
> >  drivers/cpuidle/Makefile              |   5 +-
> >  drivers/cpuidle/cpuidle-psci-domain.c |  74 +++++++++-----
> >  drivers/cpuidle/cpuidle-psci.c        | 141 +++++++++++++++-----------
> >  drivers/cpuidle/cpuidle-psci.h        |  11 +-
> >  5 files changed, 150 insertions(+), 91 deletions(-)
> >
> > --
> > 2.20.1
> >
