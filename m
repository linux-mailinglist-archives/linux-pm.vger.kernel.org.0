Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7DB22094C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 11:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbgGOJyh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 05:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbgGOJyg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 05:54:36 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E4BC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 02:54:36 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id o184so776377vsc.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qH5uOPqjPkfFSArUrcmshSjzlap7LBh3zSvQcZr8Wvw=;
        b=WUugtmlv36izLRSOLMeCONyWCqpCrEkYZ6es23+yNSdy4qpHxN9Nf7PzfEqGT5gJaS
         7XG1hnjthdv/9SK7Ogmts5GQ983k7UMIzxgk/nib+TRIzUCsDlSX0GMoW6itZ6wlftUB
         SKb6GEAu/cyBUVqBN9AQct8IsVo2rzXQ0sHqquCQ6YMUv/w6RrotPHgsuMmXhogPsm/U
         bUdlyHY3K1f8ETrAj0g6wnAtfWeRI3VPRm1XKGNZRq5jjDPDizCtW/2W7aSPvX1hHHcW
         yTSQlTmusxTTMv2faYtOIGkELZxWAU9TSgkHRQmupcRGNRaQYw5bfQr2cdpOmQRTj5ao
         mMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qH5uOPqjPkfFSArUrcmshSjzlap7LBh3zSvQcZr8Wvw=;
        b=NQS+yKVqlTOLWt3zeNPIQkpFpERPK7vjBIwp8P+osq04qpTPO+HhtjRBX3cgK65r28
         dCZ60h4sSfY4ryZDVZMsjuOzTTPURXWkSo3pVO7eB+L5Vo78jLZTK9drnTW5kFaUYqEt
         G5+b1Cu7eyU/gUmEe3zEmBwOrnAm7+8dZpeYgU7ucChp+1aBHFCaTNQi1DVZ1O1VMf4f
         9fvdUAAyHWKOdo4mbH9oNYXoJsHyUopa2YJJHn6MkHkg6fGdCmVqUUJZ7JnNKXyxE3yv
         iDncx+LqlE/rdddeTPdas1Fxz1YGsskAJXBe58Af4zmyBdg1BHMOLxPqH3dmxuc5rD5H
         M7Gw==
X-Gm-Message-State: AOAM5309Mxs3GVyEYDpz+VvvoSYejBWxxZj4Du70B05j4VLvYKe15bwa
        8LrfhIQYcblVPlwDUBSPc6InUg4Wk48jgYBpwD5L7FI7Nsk=
X-Google-Smtp-Source: ABdhPJxgzC25YsBbI063o8ZxHEZ02H36KAxq+rU+gA2sbvRtYA6Vs8KcSuatQCEq17DDQi7rkEPNnRjVNhJDyrfEz48=
X-Received: by 2002:a67:f888:: with SMTP id h8mr6055678vso.165.1594806875806;
 Wed, 15 Jul 2020 02:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200707125804.13030-1-ulf.hansson@linaro.org>
In-Reply-To: <20200707125804.13030-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jul 2020 11:53:59 +0200
Message-ID: <CAPDyKFp6+kSHsgvjQQwyQtot2KqdhikbCJW0JUSQJZyfa9cRyw@mail.gmail.com>
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

On Tue, 7 Jul 2020 at 14:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v2:
>         - Put patch 3 as patch 1 and rebased accordingly. No other changes have
>         been made.
>         - Added reviewed-by and acked-by tags.

Rafael, I think this is ready to be picked up. In particular, the code
that Sudeep/Lorenzo cares most about has been reviewed by
Sudeep/Lukaz.

Kind regards
Uffe


>
> The main change in this series is done in patch 5/5, which implements support
> to prevent domain idlestates until all PSCI PM domain consumers are ready for
> it. To reach that point the corresponding code for cpuidle-psci and
> cpuidle-psci-domain, needed to be converted into platform drivers, which is
> done by the earlier changes in the series.
>
> Additionally, some improvements have been made to the error path, which becomes
> easier when the code gets converted to platform drivers.
>
> Deployment for a Qcom SoC, which actually takes full benefit of these changes
> are also in the pipe, but deferring then a bit until $subject series have been
> discussed.
>
> Kind regards
> Ulf Hansson
>
> Ulf Hansson (5):
>   cpuidle: psci: Split into two separate build objects
>   cpuidle: psci: Fail cpuidle registration if set OSI mode failed
>   cpuidle: psci: Fix error path via converting to a platform driver
>   cpuidle: psci: Convert PM domain to platform driver
>   cpuidle: psci: Prevent domain idlestates until consumers are ready
>
>  drivers/cpuidle/Kconfig.arm           |  10 ++
>  drivers/cpuidle/Makefile              |   5 +-
>  drivers/cpuidle/cpuidle-psci-domain.c |  74 +++++++++-----
>  drivers/cpuidle/cpuidle-psci.c        | 141 +++++++++++++++-----------
>  drivers/cpuidle/cpuidle-psci.h        |  11 +-
>  5 files changed, 150 insertions(+), 91 deletions(-)
>
> --
> 2.20.1
>
