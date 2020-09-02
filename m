Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546C025A884
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIBJVj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 05:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBJVj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 05:21:39 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3D0C061244
        for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2020 02:21:38 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id q67so2182806vsd.5
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2020 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrlLihNE/bhYMUvIudYc2may7ZLfgIXY/IZv6kMEadI=;
        b=Ml6IZUHedpOkDuhJAhnEwncz5yz8WzGD6hhvcoD+omPCHoHj0x7XN7Jv7izzypYcgp
         XI+6eaWltJDL7LFtw7muCvQXny3PYFdMSmbaWhPiyoEomqAurN6ZrWB/OcNfxnTisQKW
         RdW2PuEbsktE7gweCHMMhFNqcdHdi64Txyyti0f63koA+vriqMjnOmomA+oXXzzwOlSG
         Y23Qi90FWml2XZ46zVoX285P0WDX3sO01rSwRMevsTpYhq3IzdZfFSoxEb/WJMh2hEpS
         q4Op6VXKBPc0mED/XmNccEI/fboQu2bnT24TZduqWnkzDtdzOlnVJPzP/2cwAfhYu8Pr
         vVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrlLihNE/bhYMUvIudYc2may7ZLfgIXY/IZv6kMEadI=;
        b=hTP3SODJ5IvZGEiJgVLpqGJk/IqecEOrAvXTmaH5rtuNNth10TT2SdQxT0g1qtUd8N
         ntuEWfnM0VtRtMJPTuPNxOicGOgHOnMu3VKKsu4mKRkQ2pjPXkZBziJmqehyWbNWRQMU
         mx/Q9uVeYJyEfSnDwbTYLgrJ5fSH4cZovNHww2jA5r0VguOnF235ppSA1gUOwPRHDUSO
         OjwH+2pdVXl/x7Ybbar43ZoWgTULn3QbL8ERDyDVbOkj9ct2ey0gMhdqwMWTSHnt9qWU
         YNEdcwV64xJ+sNVCLcnIaJvnLQlGUyDkbRpwIvcg8fCofpdzkKCYkpjH/Awdlym406H8
         rJzQ==
X-Gm-Message-State: AOAM533e6vpyirSxqlHe/0M08P0h2/tgY1ksiYa3YAJM0vIYPhfPCES8
        U6BwaKfN9XVlFwaW6CuH9CpHlys7C8+ZyUKDbeoJZYi1EV68wK7m
X-Google-Smtp-Source: ABdhPJwhz+hd4ibZIuWsKjM8elShB1LtA0b9iprsUiAE2lQSSaWfPpa8eHDtdyIcEZLuTssS78RJNqMDA4CR8W98AYQ=
X-Received: by 2002:a67:b44a:: with SMTP id c10mr4516073vsm.35.1599038498055;
 Wed, 02 Sep 2020 02:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142859.224381-1-ulf.hansson@linaro.org>
In-Reply-To: <20200901142859.224381-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:21:01 +0200
Message-ID: <CAPDyKFqa6L368_rBetNCVDt5TUHHHHUqp4taexEqLM6HV-Gh6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] cpuidle: psci: Always create the PM domains
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 1 Sep 2020 at 16:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> This coverletter is mainly to help keeping track of the patches part in the
> series. Please have a look at each patch for more details.
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (2):
>   firmware: psci: Extend psci_set_osi_mode() to allow reset to PC mode
>   cpuidle: psci: Allow PM domain to be initialized even if no OSI mode
>
>  drivers/cpuidle/cpuidle-psci-domain.c | 59 ++++++++++++++-------------
>  drivers/firmware/psci/psci.c          | 12 +++---
>  include/linux/psci.h                  |  2 +-
>  3 files changed, 39 insertions(+), 34 deletions(-)
>
> --
> 2.25.1
>

Rafael, I am having various small series related to cpuidle-psci
that's flying around - and it may start to become a bit confusing of
what belongs where.

Therefore, I would appreciate it if you could pick up @subject series
as soon as you can, to get this off the backlog.

Kind regards
Uffe
