Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8027FE98
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbgJALpJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbgJALpJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2020 07:45:09 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2B6C0613D0
        for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2020 04:45:07 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id o64so1328347uao.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2020 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FP35DV8IQOIekzcUcYdap9/cas861nZ2JnwzMVLmNZY=;
        b=NHPBmrkd/i70Lfv1cItFp8Z0J+Fqgvz1d9bNTL6T4MxOc6nETC09ZT2aPQOV4Zrz2k
         FUNg3OFB821CJfEbD4BCYHIZmgV1h7IwCNbAwzN9QMai7X2KQ6iYf1ULX9EjTla4SyJB
         kZMItdO5LtTv5V/u7sSbPamMKpemQIYt8oUk82K6PsSPgCefqVRLtx+o3f4JhD83StuG
         KOhM+uB8WNnylQvtj73DsjH9Y3ckly82wwoje3bysxDHQfHe94KtOdSSjkA0W9EkMM52
         uGj6Vq4YVdXYp0U9RPiBOf5+89aBjYAa7iZWgFIFbQnb0IbWrmAOREeUivRFHaEObLV+
         EptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FP35DV8IQOIekzcUcYdap9/cas861nZ2JnwzMVLmNZY=;
        b=U6M0zv8ZwNkYC70GZZ29FdeggqARrA49sd/z1vcTocIEVFu2fqWK+OSbcc0aZ7gaoV
         OYkJC++QfFYYlReFVjlJr0Suc+lC/bRt698BlgCcIUvHZv9wQ9UbqTUfyhwfmMdgPwr+
         aGMOQWz9SoWAJTgh1AetNqbvVWa2vbVsKOvcj3qALOvptZ5uChJdjUnWbvrFS52i6GH/
         REbkpA07EM/+pFL+ZrKN787foSJKzy9V2xYxnOBUOQBKjksCchFmlNu6rk03Lfz79EXi
         Jey+Sa5i+7v1BJaPFMmTzl5dAGL2n9Zsx+SDSu0gWY9BAt5Ip5dYlo4ftZSEAsUjZ5gc
         ta3w==
X-Gm-Message-State: AOAM530yIkDvkSKGdN0KZO3T9MOqO0vJ5R86oWFW6pHxpzGVPsCQvGZx
        1/XjsHJgK+2H8/t+LfhD6n5F0h5lKVyvKRUTi6xsWg==
X-Google-Smtp-Source: ABdhPJwalayFW1spawBp1XLRvGYQgrm5fU0lIND6yHdzVy+atOGWefemUXzvJAD+noPu0UWXBAVd3ifZ3F/+EbMDA4U=
X-Received: by 2002:ab0:2ea1:: with SMTP id y1mr4318305uay.104.1601552706436;
 Thu, 01 Oct 2020 04:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200901082707.106860-1-ulf.hansson@linaro.org>
 <20200901082707.106860-3-ulf.hansson@linaro.org> <20201001101756.GB906@bogus> <CAPDyKFqNrCo=jGWMp67bKstErE5ZYR+3JzoPyYUtb4y2rK+dOA@mail.gmail.com>
In-Reply-To: <CAPDyKFqNrCo=jGWMp67bKstErE5ZYR+3JzoPyYUtb4y2rK+dOA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Oct 2020 13:44:30 +0200
Message-ID: <CAPDyKFqarjOgK1Ryfe37pUkv-LmA+_oxT6bi=gpgwaM9G5PjsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpuidle: psci: Enable s2idle when using OSI with the
 PM domain topology
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Thu, 1 Oct 2020 at 13:32, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 1 Oct 2020 at 12:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Tue, Sep 01, 2020 at 10:27:07AM +0200, Ulf Hansson wrote:
> > > To select domain idle states for cpuidle-psci, the PM domains via genpd are
> > > being managed by using runtime PM. This works fine for the regular idle
> > > path, but it doesn't when doing s2idle.
> > >
> > > More precisely, the domain idle states becomes temporarily disabled, which
> > > is because the PM core disables runtime PM for devices during system
> > > suspend.
> >
> > When you refer system suspend above, you mean both S2R and S2I ?
>
> Correct.
>
> Although, there is no problem with S2R to reach the proper idlestate,
> because of the way we offline all but the boot CPU.
>
> >
> > > Even if genpd tries to power off the PM domain in the
> > > suspend_noirq phase, that doesn't help to properly select a domain idle
> > > state, as this needs to be done on per CPU basis.
> > >
> >
> > And what prevents doing per CPU basis ?
>
> The PM core doesn't execute the system suspend callbacks on a per CPU basis.
>
> >
> > > Let's address the issue by enabling the syscore flag for the attached CPU
> > > devices. This prevents genpd from trying to power off the corresponding PM
> > > domains in the suspend_noirq phase. Moreover, let's assign a specific
> > > ->enter_s2idle() callback for the corresponding domain idle state and let
> > > it invoke pm_genpd_syscore_poweroff|poweron(), rather than using runtime
> > > PM.
> > >
> >
> > The syscore_suspend is not executed for S2I and using syscore APIs here
> > is bit confusing IMO. If Rafael is fine, I have no objections.
>
> That's correct, the syscore phase doesn't exist in the S2I path.
>
> However, in some cases the same functions that are being called in the
> syscore phase, are also being called for S2I. For example, have a look
> at timekeeping_suspend(), which is being called from both paths.
>
> In the end, I think the confusing part is the name of the genpd functions.
>
> Maybe we should rename pm_genpd_syscore_poweroff|poweron() to
> pm_genpd_suspend|resume() - or something along those lines.
>

[...]

Rafael, I understand you have objections to the approach. Would
renaming the genpd APIs be a way forward? Another option is to add two
new genpd APIs along the side of the existing, not sure what would be
the best.

Kind regards
Uffe
