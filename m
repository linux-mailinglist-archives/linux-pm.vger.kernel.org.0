Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33838CB60
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 18:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbhEUQ4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 12:56:46 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39461 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbhEUQ4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 12:56:45 -0400
Received: by mail-oi1-f176.google.com with SMTP id y76so10973483oia.6;
        Fri, 21 May 2021 09:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9SSI16IgT844QgKB2vtqMouHSPUJ2Dc1yNF4CmWYpg=;
        b=aAyYUwJYHefEJY56aqncAwD3lj43ETAaoXEiUFxuEOW0sv7tVYXTMG6xbH8KyRAInG
         SOUd/3EXCMT2I9lJAu3uR1v3DUBkCtXYid4ZSNYfFDZdhA3RndTmNbtkKI2GoORhXnJe
         9D+qeKk5u+tBwBd9LW3Da9fkmP6n9tbTHcVQo9eZ11rkztDK/Iisq/9mbjuHOUJ3V5dp
         Ic64WA8+d7txlccpClv2fZIduI0v1MM8IXYJXm97WL1XAEamMroxav3IJAPgZBzMA4Zi
         IE171cYq8avC+ZgHc8bM6LurW5Dr4SdDwxzopeSUe1V5aHGCFMZOLdDZlXN07jjNEzVN
         +LEw==
X-Gm-Message-State: AOAM530StgJ6vz+NXXSKthcDMiLazi8hms5/6gqsYRMm4F584KJll7CC
        1FEWLtEQKifz5e4/BhEI8VwXvJK99bNiypJMTAF8koXo
X-Google-Smtp-Source: ABdhPJwUfIsaUjHtujOHCOEowjQnRdXCh45B9069KP7m4SaMkZpeEmg8sMKYuSwaODgZakQYBwVZW0b84Kq8+fYv4lc=
X-Received: by 2002:aca:4758:: with SMTP id u85mr2887427oia.71.1621616121877;
 Fri, 21 May 2021 09:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <3741541ed1162033394663894de2f8d8554334f1.1621485236.git.viresh.kumar@linaro.org>
In-Reply-To: <3741541ed1162033394663894de2f8d8554334f1.1621485236.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 18:55:11 +0200
Message-ID: <CAJZ5v0iiv6DjdcheiBZLjyrMjyhVJVfOvy_DUw8L+NrZuH33eA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: dt: Rename black/white-lists
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 20, 2021 at 6:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Rename them in accordance with the coding guidelines.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

FWIW

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 0bb10402f02c..bef7528aecd3 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -15,7 +15,7 @@
>   * Machines for which the cpufreq device is *always* created, mostly used for
>   * platforms using "operating-points" (V1) property.
>   */
> -static const struct of_device_id whitelist[] __initconst = {
> +static const struct of_device_id allowlist[] __initconst = {
>         { .compatible = "allwinner,sun4i-a10", },
>         { .compatible = "allwinner,sun5i-a10s", },
>         { .compatible = "allwinner,sun5i-a13", },
> @@ -100,7 +100,7 @@ static const struct of_device_id whitelist[] __initconst = {
>   * Machines for which the cpufreq device is *not* created, mostly used for
>   * platforms using "operating-points-v2" property.
>   */
> -static const struct of_device_id blacklist[] __initconst = {
> +static const struct of_device_id blocklist[] __initconst = {
>         { .compatible = "allwinner,sun50i-h6", },
>
>         { .compatible = "arm,vexpress", },
> @@ -179,13 +179,13 @@ static int __init cpufreq_dt_platdev_init(void)
>         if (!np)
>                 return -ENODEV;
>
> -       match = of_match_node(whitelist, np);
> +       match = of_match_node(allowlist, np);
>         if (match) {
>                 data = match->data;
>                 goto create_pdev;
>         }
>
> -       if (cpu0_node_has_opp_v2_prop() && !of_match_node(blacklist, np))
> +       if (cpu0_node_has_opp_v2_prop() && !of_match_node(blocklist, np))
>                 goto create_pdev;
>
>         of_node_put(np);
> --
> 2.31.1.272.g89b43f80a514
>
