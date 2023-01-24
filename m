Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB0C679544
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 11:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjAXKeH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 05:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjAXKeE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 05:34:04 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479F4402E9
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 02:34:03 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b24-20020a17090a551800b0022beefa7a23so1321877pji.5
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 02:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5mQi313Cv+dJA11wKypNOswRAce9Ls2rcLx6HZ6CfVY=;
        b=g8KOWvONw7VprZCL7iMsDfE1MkerljIw1sSAcF7MgX2mp+udysuYBMx7G8nxH+DzmL
         7zPoUgzXCriw478dJzbbs2xIYUlg5VyL7lMvmQqt+SlKNXnPT2boGPTEv1UpHE6m17Vi
         XTE2eNG1NkDLidec7J5vSpm7teD0M59O1u2/NgSFsOq7BHkgxi/VDWtyuHTz+k581bkO
         YttE1o++Rwp8DV2EChV9+gkYnjw8xCgwzUFVOuor8IEhUkE5JGcxENcCzdcv8Qkx02+i
         7lGGQY0I9NaJo+nUMaoa2gPFTXTRV60ta8F2HgUk74c7+JSk88lVsbDFvfaiMkO9U5ST
         EolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mQi313Cv+dJA11wKypNOswRAce9Ls2rcLx6HZ6CfVY=;
        b=KvPE6LjJhGYjfW0kOkiagyaNkgjUfBkxWsRhrshfQ6YykVN/0Qt9tV+4ztZYF0Rk2V
         NbXHk7wyYQxnuUxq07AaRruJGrKd4P7WK9MAdbZYsXk0BSCeEOMumkVjysRmoSNbBYWl
         KuVxFUk7R9NioReXd0XjWxYiZis3wjdJzDYsoNN5qOuU7yHQJtAyh1APuVKel3u7H4Qv
         beiz9TtU3anye1F9yvRusiEbpDQ3SLoeCLcFnZmLFYDJiFuFO3YoeDqVuWSYF/mbGB2F
         gHnEUZsH/AJBrBvigiOgl89I0aCf39+qqViBYyIAVRee4ofDLbfdu0v/dJWtkm8/8TfD
         N9bA==
X-Gm-Message-State: AFqh2kruTpNycRLBAs0TA9wLxXKl8u/Bhm/2U9JEnb02xpqeuXcBXnYr
        1kwSb8dzLnHcDG4SuTIURWD8iEbCHjsKl7noV0RYNA==
X-Google-Smtp-Source: AMrXdXsi5yxQ/URPis/O2O09f9Fv5gptW86J4sz9BB11M7G8PHA/m5F2u1Mr9jJbA57pTppE/lZwxEQNgrfkROWikIo=
X-Received: by 2002:a17:90a:730a:b0:229:7d95:a476 with SMTP id
 m10-20020a17090a730a00b002297d95a476mr3673364pjk.84.1674556442813; Tue, 24
 Jan 2023 02:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20230119184228.683892-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119184228.683892-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Jan 2023 11:33:26 +0100
Message-ID: <CAPDyKFqwRw5=SK9vckt02eGoo_dtqEpV6D0Nr5YsijoJZQh0eQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Jan 2023 at 19:42, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The runtime Power Management of CPU topology is not compatible with
> PREEMPT_RT:
> 1. Core cpuidle path disables IRQs.
> 2. Core cpuidle calls cpuidle-psci.
> 3. cpuidle-psci in __psci_enter_domain_idle_state() calls
>    pm_runtime_put_sync_suspend() and pm_runtime_get_sync() which use
>    spinlocks (which are sleeping on PREEMPT_RT).
>
> Deep sleep modes are not a priority of Realtime kernels because the
> latencies might become unpredictable.  On the other hand the PSCI CPU
> idle power domain is a parent of other devices and power domain
> controllers, thus it cannot be simply skipped (e.g. on Qualcomm SM8250).
>
> Disable the runtime PM calls from cpuidle-psci, which effectively stops
> suspending the cpuidle PSCI domain.  This is a trade-off between making
> PREEMPT_RT working and still having a proper power domain hierarchy in
> the system.

I think this sounds like a reasonable compromise, at least at this point.

>
> Cc: Adrien Thierry <athierry@redhat.com>
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: linux-rt-users@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes since v1:
> 1. Re-work commit msg.
> 2. Add note to Kconfig.
>
> Several other patches were dropped, as this is the only one actually
> needed.  It effectively stops PSCI cpuidle power domains from suspending
> thus solving all other issues I experienced.

I like this approach better, thanks!

> ---
>  drivers/cpuidle/Kconfig.arm    | 3 +++
>  drivers/cpuidle/cpuidle-psci.c | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 747aa537389b..24429b5bfd1c 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -24,6 +24,9 @@ config ARM_PSCI_CPUIDLE
>           It provides an idle driver that is capable of detecting and
>           managing idle states through the PSCI firmware interface.
>
> +         The driver is not yet compatible with PREEMPT_RT: no idle states will
> +         be entered by CPUs on such kernel.

This isn't entirely correct. In principle your suggested change ends
up providing the below updated behaviour for PREEMPT_RT.

*) If the idle states are described with the non-hierarchical layout,
all idle states are still available.
**) If the idle states are described with the hierarchical layout,
only the idle states defined per CPU are available, but not the ones
being shared among a group of CPUs (aka cluster idle states).

Perhaps there is an easier way to summarize what I stated above?

> +
>  config ARM_PSCI_CPUIDLE_DOMAIN
>         bool "PSCI CPU idle Domain"
>         depends on ARM_PSCI_CPUIDLE
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 312a34ef28dc..c25592718984 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -66,7 +66,7 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
>         /* Do runtime PM to manage a hierarchical CPU toplogy. */
>         if (s2idle)
>                 dev_pm_genpd_suspend(pd_dev);
> -       else
> +       else if (!IS_ENABLED(CONFIG_PREEMPT_RT))

Rather than doing this (and the below) in
__psci_enter_domain_idle_state(), I suggest replacing this with a
bailout point in psci_dt_cpu_init_topology(). That would prevent the
__psci_enter_domain_idle_state() from being called altogether, which
is really what we need.

Moreover, I think it would make sense to set the GENPD_FLAG_ALWAYS_ON
for the corresponding genpd, when CONFIG_PREEMPT_RT is set. See
psci_pd_init().

>                 pm_runtime_put_sync_suspend(pd_dev);
>
>         state = psci_get_domain_state();
> @@ -77,7 +77,7 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
>
>         if (s2idle)
>                 dev_pm_genpd_resume(pd_dev);
> -       else
> +       else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>                 pm_runtime_get_sync(pd_dev);
>
>         cpu_pm_exit();
> --

Kind regards
Uffe
