Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F8E28367D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJEN1b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 09:27:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36244 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJEN1b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 09:27:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id u17so2498676oie.3;
        Mon, 05 Oct 2020 06:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeaXDoT47BZ3UncfEVZZxIuYnf8ePZMtC3HPbwZ6CM4=;
        b=uCj/ooRyYxnUnRnSVOyOdAWq5agyayUSk2TK9R7YwVwae+eEb2qfsGbJilE+LsoohD
         hqHbqWTvyYK9d7z341uR6yf3Ola2pNLwL1CfqbKaki3PIL3Vxf9cz75zBlwMcjpuL9qV
         5Cp4er4gwqShKQvWVcp9Cn8+/xdkgZL3rvl/2TYDn1GWbyVIgS/qys51E0mzEyBsL4MP
         AjkZ9X0obsLhCVxkBF+BP4GYMh2sXVhgLlxs+qDNnXfNs/tuOB7MpqgGchPE0ujnhfe0
         kKNWPLzOMVmb4UVYQ5M/wA/NwtWy+l7JMmfllqfrJpqfIM7s12HcSLIlD1B8t2sL+ru+
         PoQg==
X-Gm-Message-State: AOAM532LE6rwKRSIHfHWgTABCivEUadOz3S1pIhCeoBP/tcofp4++ju1
        xo0TRaX262zS4GSrwxv8aGK+DeCj0dBZwFWxjKXZmdQ3DjE=
X-Google-Smtp-Source: ABdhPJxb/7R7IZk3zOfdLvathKwn+09vvDLq0J5lWNVegQSam6AYheVKa/Ta/c4qDoHuYXIMt22YrvVBDmEerTXLsmI=
X-Received: by 2002:aca:724a:: with SMTP id p71mr1256851oic.157.1601904450124;
 Mon, 05 Oct 2020 06:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201003155618.11997-1-ilina@codeaurora.org>
In-Reply-To: <20201003155618.11997-1-ilina@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Oct 2020 15:27:19 +0200
Message-ID: <CAJZ5v0jMzN5nHCpTnJuUoFbrqYhrciRp04quUTAnt0sSU4q+aw@mail.gmail.com>
Subject: Re: [PATCH v2] PM / Domains: enable domain idle state accounting
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 3, 2020 at 5:56 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> To enable better debug of PM domains, let's keep a track of the success
> and rejections in entering each domain idle state.
>
> This statistics is exported in debugfs when reading the idle_states
> node, associated with each PM domain.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v2:
>         - Renamed 'failed' to 'rejected'
>
> This patch depends-on: https://lkml.org/lkml/2020/9/24/465
> ---
>  drivers/base/power/domain.c | 7 +++++--
>  include/linux/pm_domain.h   | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index f001ac6326fb..dbe89454f594 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -564,6 +564,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>
>         genpd->status = GENPD_STATE_OFF;
>         genpd_update_accounting(genpd);
> +       genpd->states[genpd->state_idx].usage++;

Why not to do this in genpd_update_accounting()?

>
>         list_for_each_entry(link, &genpd->child_links, child_node) {
>                 genpd_sd_counter_dec(link->parent);
> @@ -574,6 +575,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>
>         return 0;
>  busy:
> +       genpd->states[genpd->state_idx].rejected++;
>         if (nr_calls)
>                 __raw_notifier_call_chain(&genpd->power_notifiers,
>                                           GENPD_STATE_ON, NULL,

This doesn't apply to the current code, please rebase.

> @@ -3053,7 +3055,7 @@ static int idle_states_show(struct seq_file *s, void *data)
>         if (ret)
>                 return -ERESTARTSYS;
>
> -       seq_puts(s, "State          Time Spent(ms)\n");
> +       seq_puts(s, "State          Time Spent(ms) Usage          Rejected\n");
>
>         for (i = 0; i < genpd->state_count; i++) {
>                 ktime_t delta = 0;
> @@ -3065,7 +3067,8 @@ static int idle_states_show(struct seq_file *s, void *data)
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
> index 3b2b561ce846..239647f2d27f 100644
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
