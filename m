Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF2278CB2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgIYP3g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 11:29:36 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39618 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbgIYP3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 11:29:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id c13so3170610oiy.6;
        Fri, 25 Sep 2020 08:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73cx2+6HpCMkyAb8T8v+SSARvZpxXhASmBPUda5hJXg=;
        b=EsBfJD3eef/tAi5k5iwJ2IB5EHMIDUZZ8I2isXHaIftce/kOT1BLq2fNKrUfk1VBwv
         uWLKXHK+IFzGrrJ1cYBuc5LGGEODmY0k6iiUaDDn4a7EiF8Uji74AAs/PVO2WzIVYmeB
         /fMO7CZHiMvftcetBGYaZeMfIjwMY6Hsk82nUpMUEr5LoaBbwO2k9rNlAj/sEt27IZVW
         2j67BQys81NEfh//MSZQVoOxsbtNKIk9OoKQgL3LpQ4cdcvSWsF1wBeC77pqbMH7WQKP
         OGFmSD5qrni0HbvTiE2hxv1SvNu5AdMDKTufNzXVtjaNj/hk+ExXq5hcLLhbjyyfE4z9
         7/uw==
X-Gm-Message-State: AOAM530V30ZOx1dQZq/V8Z1hQQcVRrCyyYvHuxVJz8bZLeGUQ8E5lVou
        oNqaw8n4xtkR9y/4709lc8ED8V165CL+k8uX5pliHJko
X-Google-Smtp-Source: ABdhPJyjV0wV5y5tNn603qIJpSbgJuXQvFizXmF4VfxZxFI4NLJ5EtXVycpdAvZUdSUh663PGn3AXuvFl7+uL28vVqA=
X-Received: by 2002:aca:df84:: with SMTP id w126mr583992oig.103.1601047774623;
 Fri, 25 Sep 2020 08:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200925024200.6429-1-ilina@codeaurora.org>
In-Reply-To: <20200925024200.6429-1-ilina@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 17:29:23 +0200
Message-ID: <CAJZ5v0gLL8KxeLxYtQ0pVeYket5uXeTktL9MB3Uf7MW-MiD5rg@mail.gmail.com>
Subject: Re: [PATCH RFC] PM / Domains: enable domain idle state accounting
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 25, 2020 at 4:42 AM Lina Iyer <ilina@codeaurora.org> wrote:
>
> To enable better debug of PM domains, let's keep a track of the success
> and failures in entering each domain idle state.
>
> This statistics is exported in debugfs when reading the idle_states
> node, associated with each PM domain.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>
> ---
> This patch depends-on: https://lkml.org/lkml/2020/9/24/465
> ---
>  drivers/base/power/domain.c | 7 +++++--
>  include/linux/pm_domain.h   | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index f001ac6326fb..ba3355f935da 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -564,6 +564,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>
>         genpd->status = GENPD_STATE_OFF;
>         genpd_update_accounting(genpd);
> +       genpd->states[genpd->state_idx].usage++;
>
>         list_for_each_entry(link, &genpd->child_links, child_node) {
>                 genpd_sd_counter_dec(link->parent);
> @@ -574,6 +575,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>
>         return 0;
>  busy:
> +       genpd->states[genpd->state_idx].failed++;

What about consistently calling these "rejected" instead of "failed"?

>         if (nr_calls)
>                 __raw_notifier_call_chain(&genpd->power_notifiers,
>                                           GENPD_STATE_ON, NULL,
> @@ -3053,7 +3055,7 @@ static int idle_states_show(struct seq_file *s, void *data)
>         if (ret)
>                 return -ERESTARTSYS;
>
> -       seq_puts(s, "State          Time Spent(ms)\n");
> +       seq_puts(s, "State          Time Spent(ms) Usage          Failed\n");
>
>         for (i = 0; i < genpd->state_count; i++) {
>                 ktime_t delta = 0;
> @@ -3065,7 +3067,8 @@ static int idle_states_show(struct seq_file *s, void *data)
>
>                 msecs = ktime_to_ms(
>                         ktime_add(genpd->states[i].idle_time, delta));
> -               seq_printf(s, "S%-13i %lld\n", i, msecs);
> +               seq_printf(s, "S%-13i %-14lld %-14llu %llu\n", i, msecs,
> +                             genpd->states[i].usage, genpd->states[i].failed);
>         }
>
>         genpd_unlock(genpd);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 3b2b561ce846..c30994ec0cec 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -82,6 +82,8 @@ struct genpd_power_state {
>         s64 power_off_latency_ns;
>         s64 power_on_latency_ns;
>         s64 residency_ns;
> +       u64 usage;
> +       u64 failed;
>         struct fwnode_handle *fwnode;
>         ktime_t idle_time;
>         void *data;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
