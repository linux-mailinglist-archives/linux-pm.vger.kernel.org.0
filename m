Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D75F27590A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 15:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIWNpb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 09:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgIWNpb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 09:45:31 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8CBC0613CE
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 06:45:31 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j185so18872vsc.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjI0iSBg64GGVo1mWqlElR7EI1Yyaa/VjKy83Rj/uJ0=;
        b=BE8SK6syeO7IeELLD8FS+CUt9gIV4vRv1vVvrbpS3vpCkQ3LwvDIsE1Zg19IOB8AVu
         PRMxmz8J5IG259ZUoxftBEgQWTiMEBxjpl3qSyDrDzYo8utRtnj2e8R4PQQZzsyVvQNz
         dmdHtd+VT8NfioCeQPKRSUYPgcq/IySeYF6NjXnBk+6nVhFvjQK/ltRmi8JGg41d6eeZ
         xI0Jq+Mtr2hwXD0TMZgCF74AYn+sQ7Fvr+68+wD1bx+5928LwLM5gZtjct90sSiuzjIB
         jpJS/4YpAXBuySBexqqFabI+FJxcAB8mVe0YS4JI02zwv4iA5kO8DRnnHUEv13WJuyrd
         XMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjI0iSBg64GGVo1mWqlElR7EI1Yyaa/VjKy83Rj/uJ0=;
        b=fh/G3TjwP6VX35E6pVoN05N77p2D5tu7vsYGMp4tAKKWed6iw7Ld8GPah9r06OjkYy
         sPo0AeKzq77B01ivSOQTWKCQiSznjyPnnsRMe+8wNSf2VEXQXT9AODEN2qqaoOX+9W+4
         dTad5iXWTrquULH/RL8sG/vjeJ6YmYlhGnD4QwM5ZnumZeTFgz5AmuuTw92BVWcHrmZJ
         mfiYUHcNWtVanHmrN5EPuLllXjeyZbbGwheKe1Gm/S9aA3+FCR427jPax5Em+9k6G24u
         Ie88NNaVKnSFkeZvzfQXDVpjCCxo9CgEsA2qbI+zneo/oAB/X+2B/41Z63Ug5M4nNvaM
         NYQA==
X-Gm-Message-State: AOAM533g8kxmxShSuhX/HFmMCXuE8KAlTragC2x9pqEFlrFCi3qABaQt
        STbOIdXar4UdyXct/6ynGhMdMIMvk335cEopNmk0Tg==
X-Google-Smtp-Source: ABdhPJyTYveW/NF4p2ti5E1llaWnAnFdIqk/Ut94UsOS3wNo17bmuwGD7sOE2Ars0CVKEc5uK2eRB7QwvAWkVuZna+Y=
X-Received: by 2002:a05:6102:910:: with SMTP id x16mr6860911vsh.42.1600868729751;
 Wed, 23 Sep 2020 06:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200814123716.61936-1-ulf.hansson@linaro.org>
 <CAJZ5v0g7EZVeF6GL8yqfALq-wgp+9igO3JkzR-as7Ng9ycbFJQ@mail.gmail.com> <20200923081106.GA30942@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200923081106.GA30942@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Sep 2020 15:44:53 +0200
Message-ID: <CAPDyKFrPRjgqzN2TXCh8A8P3H8g7FFQKRo8WZeLuCnMbMsT3bA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update section for cpuidle-psci
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 23 Sep 2020 at 10:11, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Sep 21, 2020 at 05:49:52PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 14, 2020 at 2:37 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Extend the file pattern to also include cpuidle-psci.h and
> > > cpuidle-psci-domain.c. Moreover, add myself as a co-maintainer,
> > > particularly to help with the support for PM domains.
> > >
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Any objections from the original maintainers?
>
> The PSCI driver providing support for platform coordinated idle states
> (that this patch is targeting AFAICS) does not require more maintainers,
> that support is complete and Sudeep and I will take care of refactoring
> and fixes.
>
> If the OSI bits in it require a specific maintainer I would prefer those
> bits to be moved into a specific file and maintainership added
> _explicitly_ for that file only.

My main concern is that the OSI support (and some related changes for
genpd) is still being worked upon. The corresponding code deserves to
be looked after by someone. I offer my help with this.

I guess we can split up the code as you suggest, but perhaps another
way would be to explicitly state my part of the responsibility in
MAINTAINERS. Along the lines of this:

M:     Ulf Hansson <ulf.hansson@linaro.org> # OSI support / PM domains

Would that be okay to you?

Kind regards
Uffe

>
> Thanks,
> Lorenzo
>
> > >  MAINTAINERS | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index f9ae8ea54e27..66821197175e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4556,10 +4556,11 @@ F:      drivers/cpuidle/cpuidle-exynos.c
> > >  CPUIDLE DRIVER - ARM PSCI
> > >  M:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > >  M:     Sudeep Holla <sudeep.holla@arm.com>
> > > +M:     Ulf Hansson <ulf.hansson@linaro.org>
> > >  L:     linux-pm@vger.kernel.org
> > >  L:     linux-arm-kernel@lists.infradead.org
> > >  S:     Supported
> > > -F:     drivers/cpuidle/cpuidle-psci.c
> > > +F:     drivers/cpuidle/cpuidle-psci*
> > >
> > >  CRAMFS FILESYSTEM
> > >  M:     Nicolas Pitre <nico@fluxnic.net>
> > > --
> > > 2.25.1
> > >
