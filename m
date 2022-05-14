Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A0C527323
	for <lists+linux-pm@lfdr.de>; Sat, 14 May 2022 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiENQs5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 May 2022 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiENQsy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 May 2022 12:48:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341833668F
        for <linux-pm@vger.kernel.org>; Sat, 14 May 2022 09:48:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e29so5463159wrc.11
        for <linux-pm@vger.kernel.org>; Sat, 14 May 2022 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9Ne+v1fWGSBcxhiyeEoVMQ4rFmfRWh1mmd5YIH/r7U=;
        b=meRQd62ep69g3tBqBYUeXf3me9m4oJ40AN+j1I4vlanRExPpzRRvwJGiZsLYWDyhUd
         INUHrkzVoQbMxwzgnNexlklgKVtXN71UobSDGxwNOupmGxiJLLVDLriwyM4gsuQYSAem
         FnSvIK6r1IjytddhDA39hO7kvmvRaLmR4FkQFhFkSBb/6XBSG0Hja8KDeT6hmGFjhdrO
         w3gKjf6NfulL/sCas5YgKZC5aHSNIbfBU1JjOHyAYFP140etjYNiMZ5zIUUw30xts2jh
         6mSYZXNzv11NKlDDULNg+MaipgsRINAnRucaHw+mp6UGZHPd8l9v8uGP9Vj7uuw6b6nS
         Whag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9Ne+v1fWGSBcxhiyeEoVMQ4rFmfRWh1mmd5YIH/r7U=;
        b=dBUOafQTlMwFW8DwZ6lOSV8BQUsZvSyiRlVgvwuyM0t9sn8jS9RWrO5fuvUN7IVdfW
         YGV6SPE6XbBjajW55D9qLTpsxd3GWbSmukLmTb8swlnFMlfRtuh3VgcHtzWifHbvcjee
         4iAAfC/yj/GC08lf92Rx721rMnuSwzSetL5ew7bx03FZV+R+Fub0A7tRt2WBG0D/7xvt
         nw8NwDkVXkxNQO/B5L3xr+asUmrIBd6RaMF9n5jyG9IpyxvHowdJg5bfmjtQsEkHnJVO
         ZsYCer00YaolzBAN2TeUBVc6vmO7U5XyygVlkpQGwSdhc7oshVIf5Wsr65a2VE+2YvA5
         8osQ==
X-Gm-Message-State: AOAM531Z+C3aDgmHnoTgg+rcZplrNPkqCLJCmhGIRAJx9cLFLDPPkbtW
        sWpEaC20lXanb+XPlEUdlkjGaDXIkId+H8PyIw/5+A==
X-Google-Smtp-Source: ABdhPJzDGeojNw7I+D9/Q7eW0grf3LDdqkTv+/FnRYaAGPuKeMRYFm+g8lQXX1H8/begn/XMC+R1eTY1NiPkP69InEU=
X-Received: by 2002:adf:f001:0:b0:20d:22b:183c with SMTP id
 j1-20020adff001000000b0020d022b183cmr1403508wro.313.1652546927571; Sat, 14
 May 2022 09:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220514152032.758738-1-ulf.hansson@linaro.org>
In-Reply-To: <20220514152032.758738-1-ulf.hansson@linaro.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 14 May 2022 22:18:35 +0530
Message-ID: <CAAhSdy3m3FzbkL-On5kPtrZgyO4x=6onr6mXi_=te5B=m_n8GQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: psci: Fix regression leading to no genpd governor
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 14, 2022 at 8:50 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> While factoring out the PM domain related code from PSCI domain driver into
> a set of library functions, a regression when initializing the genpds got
> introduced. More precisely, we fail to assign a genpd governor, so let's
> fix this.
>
> Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from PSCI domain driver")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index 755bbdfc5b82..3db4fca1172b 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -52,7 +52,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>         struct generic_pm_domain *pd;
>         struct psci_pd_provider *pd_provider;
>         struct dev_power_governor *pd_gov;
> -       int ret = -ENOMEM, state_count = 0;
> +       int ret = -ENOMEM;
>
>         pd = dt_idle_pd_alloc(np, psci_dt_parse_state_node);
>         if (!pd)
> @@ -71,7 +71,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>                 pd->flags |= GENPD_FLAG_ALWAYS_ON;
>
>         /* Use governor for CPU PM domains if it has some states to manage. */
> -       pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
> +       pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
>
>         ret = pm_genpd_init(pd, pd_gov, false);
>         if (ret)
> --
> 2.25.1
>
