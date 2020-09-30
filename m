Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809C227E57F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 11:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgI3Jq5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgI3Jq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 05:46:57 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0081BC061755
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 02:46:56 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id v5so314319uau.10
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTQYjCq5PNSIwySRvoi59maLMfBV9JdHJkldX5iUoZ4=;
        b=ZHzlxdfhZA3Wfloq1wV0wEVqBRwiTvDXWw9PEpZ2INkBgK5sywoRfqBZR/7Kif7xLM
         9xwK8nFIvef1W1WucmfISdHrX7Q5nlbEjGx4CQQGj3fa1bF1bgDczr9S2Fb9XgKvcSNN
         shYWEA1ur97ZmlVRbnu6W5o70HRz5P+vslTk8ZYXsRuyCxwQUj3/Z4FZiZhDbc9SYfjm
         rrrL/t2bh3BMbhStqCY9I9Ucn7seNar7U56EkxkJpg+LqS9cs0qgUvqnCxia1e4piyOj
         cVXY69FYqVvEtRLnsTEooFqN/nOw8WHmMCtuItaB5oerj9Z3CvvzlBcUN/7Mr/RU88OU
         CI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTQYjCq5PNSIwySRvoi59maLMfBV9JdHJkldX5iUoZ4=;
        b=FKGuLvyzGSqDyI7ZTE/nvuI++JGeqYp4+e5ArOfmC8y1BL3TWFvQv8FHl+SftuOJOu
         V/4Yo7CN2sPoPgFI5e7qmXMzshctyw1WV9/SbBGgFSH/uZrU+5mKpe5SLrvXhTwWHfld
         8ZQTZRBl4DwHVpqqn83u5eLwGwPLJwq65bhkeG3eFygz+IIE/huEsB6hn2C04smnftWy
         uNUytnvoJ4U1v36iRooWn1OxuZOO53MnPDtiSvo7bFHitwvX9odrhHzDoQvZ9KRxdFm9
         PKaSoo92Ivo3p8lwcglo1r09Y7q24tNc6957rli4PrNDWRktWj5FTuagJ1cs9R2lmb6X
         7u4A==
X-Gm-Message-State: AOAM532kszxvYXr7VzixWq1UtcPt8qb5E76A7QBO5MQQKAfY5qgSycT1
        xDljBGw/5Z5OqU/5tTHgLZI2dua4WKMnQYANLuq9cw==
X-Google-Smtp-Source: ABdhPJx2M0kQzKQI7NhIgCZG7xPvYqIGEkWpPCqAOAuaC7Ezhi8LD8XmUHZtVgRD3byfhx8obSma7uJSkKISNH65QOU=
X-Received: by 2002:ab0:2904:: with SMTP id v4mr804947uap.15.1601459215976;
 Wed, 30 Sep 2020 02:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200814123716.61936-1-ulf.hansson@linaro.org>
 <CAJZ5v0g7EZVeF6GL8yqfALq-wgp+9igO3JkzR-as7Ng9ycbFJQ@mail.gmail.com>
 <20200923081106.GA30942@e121166-lin.cambridge.arm.com> <CAPDyKFrPRjgqzN2TXCh8A8P3H8g7FFQKRo8WZeLuCnMbMsT3bA@mail.gmail.com>
 <20200930091254.GA16862@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200930091254.GA16862@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Sep 2020 11:46:19 +0200
Message-ID: <CAPDyKFq6gaht-x-iKD0wvoD-p7o_2GdR-ac3SpH6c7soU2AvnA@mail.gmail.com>
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

On Wed, 30 Sep 2020 at 11:13, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Sep 23, 2020 at 03:44:53PM +0200, Ulf Hansson wrote:
> > On Wed, 23 Sep 2020 at 10:11, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Mon, Sep 21, 2020 at 05:49:52PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, Aug 14, 2020 at 2:37 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > Extend the file pattern to also include cpuidle-psci.h and
> > > > > cpuidle-psci-domain.c. Moreover, add myself as a co-maintainer,
> > > > > particularly to help with the support for PM domains.
> > > > >
> > > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > > Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > >
> > > > Any objections from the original maintainers?
> > >
> > > The PSCI driver providing support for platform coordinated idle states
> > > (that this patch is targeting AFAICS) does not require more maintainers,
> > > that support is complete and Sudeep and I will take care of refactoring
> > > and fixes.
> > >
> > > If the OSI bits in it require a specific maintainer I would prefer those
> > > bits to be moved into a specific file and maintainership added
> > > _explicitly_ for that file only.
> >
> > My main concern is that the OSI support (and some related changes for
> > genpd) is still being worked upon. The corresponding code deserves to
> > be looked after by someone. I offer my help with this.
>
> All OSI changes can go into cpuidle-psci-domain.c, you can add a
> maintainer entry for that.

Alright. Most of the things are already in there, but I will try to
move the rest as well then.

>
> > I guess we can split up the code as you suggest, but perhaps another
> > way would be to explicitly state my part of the responsibility in
> > MAINTAINERS. Along the lines of this:
> >
> > M:     Ulf Hansson <ulf.hansson@linaro.org> # OSI support / PM domains
> >
> > Would that be okay to you?
>
> No because there should be no need, as I have already said. If you need
> to change cpuidle-psci.c send patches please and we will review them.

I sent a small series "Enable s2idle when using PSCI OSI [1]" a month
ago, but haven't received any feedback. I guess moving all OSI parts
to cpuidle-psci-domain.c would help, as we wouldn't need to bother you
with these OSI specific things then.

[...]

Kind regards
Uffe

[1]
https://www.spinics.net/lists/arm-kernel/msg833933.html
