Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86761D3567
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgENPmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 11:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENPmQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 11:42:16 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20E2C061A0C
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 08:42:15 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id k3so543809ual.8
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rIx/Wu7eMh93mXeZtHrHjtTiAAX0hql7/jejCyN09w=;
        b=a5GPjn8648UlAfmJaK2TJFrcyVrDkiNzYsJxuOz8jPR6ciYok3uavjFviHTuS4A7PV
         rfm+tyI01ZfEqTm62Fv9Gfqp+UiXYkdOzsev9G0DpivQRPUdAGGo6TVIlZGNxm6/NCFm
         34ml3WCEocIytXFsg515AmudQ2algOPI4NN9VFtX5EujELFvnyt2wL5xwF87SVCaVFdw
         qlyj9w66Vk2AepGL5kSKwdiH90SJBmhp3VkBWHHttVHddxXVYIjjbbJtgFSCTgQ9qLhp
         odwe5cyAk1sh0cxMu8Y1wiseiodka0q6pd0uQhrpEriyoL2MkTmMJRsLNZlizE//58Sg
         BOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rIx/Wu7eMh93mXeZtHrHjtTiAAX0hql7/jejCyN09w=;
        b=pHTod8+8AfQp2R0mi2jcBzBcspUpMWTk1ERrTeJ42wHdpkxpFyvthIyOUTHmpITmUE
         fhIBN4QCc9pgJbR01ffVb+l+y3mo9AbBFBEs1UXvXrO5YvZUXpg9S+TNsLxg748aeyU8
         D86nmg+gnZ+q0jbm8Pd4b4n/mwVMSLiNRblvYD/CjYWkS/Nl1j6lLdtIrcgNJE3uxDQ2
         Rvk+oTlsmsjPcOO0WMUzCM2BabBLMbHH3rooeOxyplClsTuTmGRAzIgpR/3SgJ11HMjQ
         Sd2PLj2LANJqfU2aEQXoVYTCPZ3AAHXeu9UtvyPFQsEh7VMwGbbE/30JWpnhNdV35HSr
         TsNw==
X-Gm-Message-State: AOAM5336y5XpWegoVgZhwEh/WsrhL5IM/wm9919qeQvs7b49lEIxl20U
        tagPivBaJL+40pCNshjJJE+0eBIY0uZahzOVzDp9nA==
X-Google-Smtp-Source: ABdhPJz/bMzouhi1RGPHhOCmF6Koyy+n5c60NKn1Em+Y4Tc7MHz1QcibV/c1az5d/ugLkeDWtYYAx0FsQwvovoaPWlk=
X-Received: by 2002:ab0:5ca:: with SMTP id e68mr4338167uae.19.1589470933422;
 Thu, 14 May 2020 08:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200511133346.21706-1-ulf.hansson@linaro.org> <20200514142015.GA23401@bogus>
In-Reply-To: <20200514142015.GA23401@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 May 2020 17:41:37 +0200
Message-ID: <CAPDyKFoVo8L7eiGdEVNYR2DY7cszDuLkmX8O_SfyUKh73pbpMQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fixup execution order when entering a
 domain idle state
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
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

On Thu, 14 May 2020 at 16:20, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 11, 2020 at 03:33:46PM +0200, Ulf Hansson wrote:
> > Moving forward, platforms are going to need to execute specific "last-man"
> > operations before a domain idle state can be entered.
>
> I need to dig the thread details, but I remember commenting on one of
> the similar discussion. It was something to do with voting which wasn't
> necessary at all. I am interested in the details here.
>
> > In one way or the other, these operations needs to be triggered while
> > walking the  hierarchical topology via runtime PM and genpd, as it's at that
> > point the last-man becomes known.
> >
> > Moreover, executing last-man operations needs to be done after the CPU PM
> > notifications are sent through cpu_pm_enter(), as otherwise it's likely
> > that some notifications would fail. Therefore, let's re-order the sequence
> > in psci_enter_domain_idle_state(), so cpu_pm_enter() gets called prior
> > pm_runtime_put_sync().
> >
>
> More details on why notifications fail ?

Well, at this moment this is more of a hypothetical issue as there is
no last-man notification sent/used yet.

However, typically we would call cpu_cluster_pm_enter() in the path as
when the psci_pd_power_off() is called (for psci PM domains), when a
valid domain state has been found.

This means, we would violate the cpu_cluster_pm_enter() API, as it's
clearly stated in its corresponding function header, that
cpu_pm_enter() needs to be called first (and that's also how others
are currently using it).

Note that, I am currently exploring whether we shall call
cpu_cluster_pm_enter|exit() at all, or whether we can use some other
new genpd mechanism to accomplish the similar thing.

>
> > Fixes: ce85aef570df ("cpuidle: psci: Manage runtime PM in the idle path")
> > Reported-by: Lina Iyer <ilina@codeaurora.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index bae9140a65a5..d0fb585073c6 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -58,6 +58,10 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> >       u32 state;
> >       int ret;
> >
> > +     ret = cpu_pm_enter();
> > +     if (ret)
> > +             return -1;
> > +
>
> This change is ignoring the retention case psci_enter_state handles and
> this may affect performance by doing unnecessary save/restore.

This was already the case before. CPU_PM_CPU_IDLE_ENTER_PARAM() ends
up always setting "is_retention" to 0, when __CPU_PM_CPU_IDLE_ENTER()
is called.

Kind regards
Uffe
