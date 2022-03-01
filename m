Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA034C899A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Mar 2022 11:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiCAKrj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Mar 2022 05:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiCAKrj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2022 05:47:39 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3748BE02
        for <linux-pm@vger.kernel.org>; Tue,  1 Mar 2022 02:46:58 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r20so21328949ljj.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2022 02:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnV9MOMDMud5b3YWUikIL0pv7sKgaX7Li/OdkySNYLY=;
        b=YOCWqG+oypVn1NlC909jw6wtQ2qG6OkdilA5XVKhUBAOJLT7xPgOYtOH6SiXgg+Yux
         CPSM4a/wxJhYh0W70txaMPstlAw4EiDCgYdTForvI9WbWtrY7ysAmJRl7Yg/4+Su7ZJD
         zRnNAWdhwLF+9xScW9apOyd1VpjdNHrPckvR+R7Q3viSf+RhB358+qr4uLu1H59XgFeq
         xSmSCyxRfbFfos5M3DUVShGRApUk+1KCCTLiu889yNsNzk/I0yotOF7nrazqDFYg8MxN
         PpCu+LMKfbLPWiShh3FNWtUqljfLphSgI6ro7m1vZyvmajlsK1RRfTZOB9PuTOZc0EB6
         jFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnV9MOMDMud5b3YWUikIL0pv7sKgaX7Li/OdkySNYLY=;
        b=d+q0GKL602b8xjr+yxyTB8xZE/zTDtW40uIpWKJA+EaU8vLNTFHtwAvOjyi5isURgG
         jvHb9j/SRhId2cv65X6JNbp1UEsmqhR7NTVFiDY+aNgGqan2wMLOizXicAKq9Ns+/3rD
         Kv5quHOc8/W+hzNcfJ79AdVB9LnEriypwdiCaj6R1STvzvoQGNs5V6U8/++SxWwGFQEd
         67Mhih6Yp+hozmKVrlW7cBdiygnvjHM+K4+SJtRk7t/nzBeD6IpPdIJOOENdI2/KnSqZ
         gBJ0hjkwECk+qjqh8U3iL2ki4UuNuQnCLucEj8ZFnINUIXUv1LWHMY5NLqmOB/QFYw27
         /qDg==
X-Gm-Message-State: AOAM532SeCajKFnuKsle5vXLlf7yZMcQCoWmxJllom1wOIpNMD8El7CU
        uderbH9wS+v2dloQbJ4/HTNW37rMkLcQQk3k5cPGGQ==
X-Google-Smtp-Source: ABdhPJxHZlthLuC9WaupbqdLgFrH9guhS4/CWc+S8E9l03fe+QxigB9DuYCSqzqBkCCuQleWnmu0k6jCIWyM2/YZI6E=
X-Received: by 2002:a2e:8603:0:b0:246:24c:b79c with SMTP id
 a3-20020a2e8603000000b00246024cb79cmr16849078lji.367.1646131616563; Tue, 01
 Mar 2022 02:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20220225082420.450620-1-shawn.guo@linaro.org>
In-Reply-To: <20220225082420.450620-1-shawn.guo@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Mar 2022 11:46:20 +0100
Message-ID: <CAPDyKFqSqzrbA9vCnw18cHmCua8Hb4mrBvQE7v6hLioJhmDcqw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Iterate backwards over list in psci_pd_remove()
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 25 Feb 2022 at 09:24, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> In case that psci_pd_init_topology() fails for some reason,
> psci_pd_remove() will be responsible for deleting provider and removing
> genpd from psci_pd_providers list.  There will be a failure when removing
> the cluster PD, because the cpu (child) PDs haven't been removed.
>
> [    0.050232] CPUidle PSCI: init PM domain cpu0
> [    0.050278] CPUidle PSCI: init PM domain cpu1
> [    0.050329] CPUidle PSCI: init PM domain cpu2
> [    0.050370] CPUidle PSCI: init PM domain cpu3
> [    0.050422] CPUidle PSCI: init PM domain cpu-cluster0
> [    0.050475] PM: genpd_remove: unable to remove cpu-cluster0
> [    0.051412] PM: genpd_remove: removed cpu3
> [    0.051449] PM: genpd_remove: removed cpu2
> [    0.051499] PM: genpd_remove: removed cpu1
> [    0.051546] PM: genpd_remove: removed cpu0
>
> Fix the problem by iterating the provider list in a reversely order, so
> that parent PD gets removed before child's PDs.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks for fixing this!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

I think we should add a fixes tag, like below and also tag this for
stable kernels.

Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")

Kind regards
Uffe

> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index ff2c3f8e4668..ce5c415fb04d 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -182,7 +182,8 @@ static void psci_pd_remove(void)
>         struct psci_pd_provider *pd_provider, *it;
>         struct generic_pm_domain *genpd;
>
> -       list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
> +       list_for_each_entry_safe_reverse(pd_provider, it,
> +                                        &psci_pd_providers, link) {
>                 of_genpd_del_provider(pd_provider->node);
>
>                 genpd = of_genpd_remove_last(pd_provider->node);
> --
> 2.25.1
>
