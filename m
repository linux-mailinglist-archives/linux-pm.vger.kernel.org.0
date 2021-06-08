Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14F039F72D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhFHM72 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 08:59:28 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42744 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhFHM72 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 08:59:28 -0400
Received: by mail-ot1-f42.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so15780137oth.9;
        Tue, 08 Jun 2021 05:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X394gF0Q1rtuAaubxa1qPZX+2IqmrO2XOm9TEzBrts4=;
        b=qPdNaU+TE5B93w2pe1L98FxuR+h8h2xz0q37+3Zkly8fM/bU9K/xzl/cabFCbx5UD/
         uYOXPcQ0pxtfejkKOZe1Fb+R0BAHTwCp1FD5e2YllL/XEWz5Ebk6IuXfF+JBRo0Cqj5m
         W2+6sqlDtiwII4vxwln0FmPMrB2eFAcTz3zVMjBgst16P+GSqTXi/R2NNTUr12d/D/zc
         U4iq0OCss5KAmi1B2tTEwaeS6yHFIegFvxjxihZuy3Kl0RbtU0/WHfehfDxgK8VL/agX
         thMDZQA8s8uWo6TaUnNOP31/+UZ6NckF7J78ZM7wYokadRshWH0Plp2rEJ87YfPrvkl0
         CR1w==
X-Gm-Message-State: AOAM533j+2/x5sABemnafHXhQ0ViBFAWSbVfhn7XjMEg/6XADshNFZqO
        Zd9YCODk+v2SeHn6K2bJCtRKIhWFC2kZjMkFTjo=
X-Google-Smtp-Source: ABdhPJzOznHAUArviI2grA9DfW+FoGtpQ5ySY+XM03gLwyZvSfPewpegRPwKNdNJrf434CGStLybyeocgV7CJEBEwq0=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr14872568otq.321.1623157054952;
 Tue, 08 Jun 2021 05:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210512072515.3820032-1-yangyingliang@huawei.com>
In-Reply-To: <20210512072515.3820032-1-yangyingliang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jun 2021 14:57:23 +0200
Message-ID: <CAJZ5v0jvzRTypqYK0O+-ajMZdaHb+4uJJOdK5pEtxCsD4yDdLA@mail.gmail.com>
Subject: Re: [PATCH -next] PM: domains: fix some kernel-doc issues
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 12, 2021 at 9:22 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Fix the following make W=1 kernel build warnings:
>
>   drivers/base/power/domain_governor.c:259: warning: Function parameter or member 'now' not described in '_default_power_down_ok'
>   drivers/base/power/domain.c:581: warning: Function parameter or member 'depth' not described in 'genpd_power_off'
>   drivers/base/power/domain.c:2520: warning: Function parameter or member 'np' not described in 'of_genpd_remove_last'
>   drivers/base/power/domain.c:2520: warning: Excess function parameter 'provider' description in 'of_genpd_remove_last'
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/base/power/domain.c          | 3 ++-
>  drivers/base/power/domain_governor.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b6a782c31613..5695a641efd3 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -572,6 +572,7 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
>   * RPM status of the releated device is in an intermediate state, not yet turned
>   * into RPM_SUSPENDED. This means genpd_power_off() must allow one device to not
>   * be RPM_SUSPENDED, while it tries to power off the PM domain.
> + * @depth: nesting count for lockdep.
>   *
>   * If all of the @genpd's devices have been suspended and all of its subdomains
>   * have been powered down, remove power from @genpd.
> @@ -2505,7 +2506,7 @@ EXPORT_SYMBOL_GPL(of_genpd_remove_subdomain);
>
>  /**
>   * of_genpd_remove_last - Remove the last PM domain registered for a provider
> - * @provider: Pointer to device structure associated with provider
> + * @np: Pointer to device node associated with provider
>   *
>   * Find the last PM domain that was added by a particular provider and
>   * remove this PM domain from the list of PM domains. The provider is
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index c6c218758f0b..cd08c5885190 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -252,6 +252,7 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
>  /**
>   * _default_power_down_ok - Default generic PM domain power off governor routine.
>   * @pd: PM domain to check.
> + * @now: current ktime.
>   *
>   * This routine must be executed under the PM domain's lock.
>   */
> --

Applied as 5.14 material, thanks!
