Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A582908FA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 17:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409063AbgJPPzy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 11:55:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42919 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410484AbgJPPzu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 11:55:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id 16so2924033oix.9;
        Fri, 16 Oct 2020 08:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6wHl916ulOPF6+J0BN3BXb1roDxF5lOuXP9shO1p6o=;
        b=JscggOXWYmqgK+ONiddjJJkY4mC+4z4062D+LDgex91iqtbMYY5+a6dLh44vL10mII
         9JU1QU9Iu/MpbILboFuwBP5veap1LzlI+X/ArxyMl6d3PHmYV7q4+9TmttdLk4jZktVh
         V17euQrgiDQ8KwjGeKokuqCDn3uLxYKpJZPHqbhi0sSpslpXnqVXlt+N1wnuX7Bms8Tf
         QOxn4w6sUjJbvzpjKz/9A3nNbWeQpjsfB2jjgz5NCeFLaYawQSaY8qdH+2QtLinOL3E3
         y4u+nRKinzaaKDK8yJ7LuAR8Q6CpCA8Sv2H1/xgrLU9frw7JbfhlRCTq0ujmajHEuoiR
         h71g==
X-Gm-Message-State: AOAM532V+FagnHoRiErN2LWncdXCLRluPoFHfTD0KVDb76wBHhgUdilK
        il0HIjgF8zN86npQ3UzffmCPGoWama/qMWBUyyE=
X-Google-Smtp-Source: ABdhPJzYUVGFnp6fh23adMJ8rT4QzdNgAk2AO+/nkLvkVD/kq0WcCG3+QdYXwqewomLFxo2XV0SDl0TtxkAC94gonro=
X-Received: by 2002:aca:5256:: with SMTP id g83mr2993351oib.71.1602863749798;
 Fri, 16 Oct 2020 08:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201015204722.18764-1-ilina@codeaurora.org>
In-Reply-To: <20201015204722.18764-1-ilina@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 17:55:38 +0200
Message-ID: <CAJZ5v0ifjHRomAxEKTW5z+VEZLGeM5MN-NcRxUUgrFQvtB0seQ@mail.gmail.com>
Subject: Re: [PATCH v3] PM / Domains: enable domain idle state accounting
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 15, 2020 at 10:47 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> To enable better debug of PM domains, let's keep a track of the success
> and rejections in entering each domain idle state.
>
> This statistics is exported in debugfs when reading the idle_states
> node, associated with each PM domain.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v3:
>         - Rebased on top of mainline

I still needed to rebase it to apply it to my tree, so please double
check the result in the bleeding-edge branch.

Thanks!

> ---
>  drivers/base/power/domain.c | 10 +++++++---
>  include/linux/pm_domain.h   |  2 ++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2cb5e04cf86c..20ecc1a7113c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -559,12 +559,15 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>                  * happen very often).
>                  */
>                 ret = _genpd_power_off(genpd, true);
> -               if (ret)
> +               if (ret) {
> +                       genpd->states[genpd->state_idx].rejected++;
>                         return ret;
> +               }
>         }
>
>         genpd->status = GPD_STATE_POWER_OFF;
>         genpd_update_accounting(genpd);
> +       genpd->states[genpd->state_idx].usage++;
>
>         list_for_each_entry(link, &genpd->child_links, child_node) {
>                 genpd_sd_counter_dec(link->parent);
> @@ -2932,7 +2935,7 @@ static int idle_states_show(struct seq_file *s, void *data)
>         if (ret)
>                 return -ERESTARTSYS;
>
> -       seq_puts(s, "State          Time Spent(ms)\n");
> +       seq_puts(s, "State          Time Spent(ms) Usage          Rejected\n");
>
>         for (i = 0; i < genpd->state_count; i++) {
>                 ktime_t delta = 0;
> @@ -2944,7 +2947,8 @@ static int idle_states_show(struct seq_file *s, void *data)
>
>                 msecs = ktime_to_ms(
>                         ktime_add(genpd->states[i].idle_time, delta));
> -               seq_printf(s, "S%-13i %lld\n", i, msecs);
> +               seq_printf(s, "S%-13i %-14lld %-14llu %llu\n", i, msecs,
> +                             genpd->states[i].usage, genpd->states[i].rejected);
>         }
>
>         genpd_unlock(genpd);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index ee11502a575b..1d9a8de6b7ac 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -82,6 +82,8 @@ struct genpd_power_state {
>         s64 power_off_latency_ns;
>         s64 power_on_latency_ns;
>         s64 residency_ns;
> +       u64 usage;
> +       u64 rejected;
>         struct fwnode_handle *fwnode;
>         ktime_t idle_time;
>         void *data;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
