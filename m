Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66852D363
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 15:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiESNBW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 09:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiESNBU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 09:01:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D6B5622E
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 06:01:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq30so9013977lfb.3
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gave4xKcqHaRWgWmo3tUVerd7RvnPPKk9OMCUATRApE=;
        b=WIiOL9ncTVgucapluhtRwCXqu6zlMC7IDp2go/yp0SiH20cVYUiE9cqkW54xoE6kRf
         6W4zspy/SuiNoDb4fZaBhs729Keb9gZxovTS70JP+p17bmYUK4RN12flYyC2hqgWPg0S
         +A8teBWcQ0VEMgnVxf/woHyLAsmwIji/ewoP/5aQ+SCv79oDlZ39OTv4y8Texjiq5ozC
         HB7v+UBqgAW3kFVIf5gavgPbtqkmfhuShHCACJYDMtEa0zTfgfmBIABh6KYiKvPX4On8
         ABStwUQX1/FNYriiKb1PFl6hFTaSOohJ94zw1mpunKQjwdd04pdLlGgFU5OmciF0rBGt
         JEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gave4xKcqHaRWgWmo3tUVerd7RvnPPKk9OMCUATRApE=;
        b=FgCavImVKLhd5Zk6Y8wa0ZG67ScUdXrUoqpp1r1G5XUNde/ppKRh5HDEBbuXaLLPD6
         9wVzPvRUvSBxa0kHSGB+X0HgwsYB8jcDrnq8mBrkPFtRJZzbbxL9BASd2KgytBmLwINB
         ExzINPNATTQ1Zn/bZyvutg7OeWObkkBlJ3s1s17C9UW1qDIO45HhxClbjztjGqmP24Qt
         N6rK8Au/oYOc//ekWPOPXTQSA6hhYRHPPc+7TWehLS32s5s8Hf1W1Na11foT42GUzyAy
         02xCVkTP6pTCYYyhSM23FrkM+sW/QMmVba5+WCh4B3Z3Mif7xvOm7o5kOOeJZ4xceO59
         wtPA==
X-Gm-Message-State: AOAM531IcsB9u0XueaQpwSgKr/b3yIxblcDU8CV1el6JAWg0V92LbouZ
        93mCQV3vjUeHO5YI4iqAra5upIGSa58BZKQTWBjUnA==
X-Google-Smtp-Source: ABdhPJyHkVwQjEUaawYpeTNZ9ptmLK/NzpeawngI0dtewKhU9y7Fzy3LJtpQj/ugmJxuTBDqYwQX0s+w7ai7V1u1Fgg=
X-Received: by 2002:a19:3852:0:b0:474:2459:26f4 with SMTP id
 d18-20020a193852000000b00474245926f4mr3304564lfj.233.1652965276049; Thu, 19
 May 2022 06:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220514152032.758738-1-ulf.hansson@linaro.org>
 <CAAhSdy3m3FzbkL-On5kPtrZgyO4x=6onr6mXi_=te5B=m_n8GQ@mail.gmail.com> <CAJZ5v0i+RR2nK8gew9tbnO_VVU3YUx2JgdRTBW07EPrB3UK87g@mail.gmail.com>
In-Reply-To: <CAJZ5v0i+RR2nK8gew9tbnO_VVU3YUx2JgdRTBW07EPrB3UK87g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 May 2022 15:00:39 +0200
Message-ID: <CAPDyKFrcWBL=7enQ3FJO7pFqv465-Nb3UWZm3faGYe5kG+Mjaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: psci: Fix regression leading to no genpd governor
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 18 May 2022 at 20:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, May 14, 2022 at 6:49 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Sat, May 14, 2022 at 8:50 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > While factoring out the PM domain related code from PSCI domain driver into
> > > a set of library functions, a regression when initializing the genpds got
> > > introduced. More precisely, we fail to assign a genpd governor, so let's
> > > fix this.
> > >
> > > Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from PSCI domain driver")
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Looks good to me.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> >
>
> Ulf, do you want me to take this lot or is it going to be handled elsewhere?

I appreciate it if you can pick both this and the second patch.

Kind regards
Uffe

>
> > > ---
> > >  drivers/cpuidle/cpuidle-psci-domain.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > index 755bbdfc5b82..3db4fca1172b 100644
> > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > @@ -52,7 +52,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
> > >         struct generic_pm_domain *pd;
> > >         struct psci_pd_provider *pd_provider;
> > >         struct dev_power_governor *pd_gov;
> > > -       int ret = -ENOMEM, state_count = 0;
> > > +       int ret = -ENOMEM;
> > >
> > >         pd = dt_idle_pd_alloc(np, psci_dt_parse_state_node);
> > >         if (!pd)
> > > @@ -71,7 +71,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
> > >                 pd->flags |= GENPD_FLAG_ALWAYS_ON;
> > >
> > >         /* Use governor for CPU PM domains if it has some states to manage. */
> > > -       pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
> > > +       pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
> > >
> > >         ret = pm_genpd_init(pd, pd_gov, false);
> > >         if (ret)
> > > --
> > > 2.25.1
> > >
