Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70FD340D9D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 19:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhCRS5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 14:57:48 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41518 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhCRS50 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 14:57:26 -0400
Received: by mail-oi1-f179.google.com with SMTP id z15so2048420oic.8;
        Thu, 18 Mar 2021 11:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndTWQxWMaQ8uWEc77N/kRP4OQQx2E++l4s9Oim2oRcU=;
        b=RCAfxJD8I6uJ659FMEmGiLLlMgjBemPAymZUdNYUMlwFoFdkn4noS+M/H4+as5feDB
         fmhH1tmfZAIisk5K2TFaA3vbcuHQqVcWmGTW1NCPhGfAaxv4/MVIArUcBOZopso0Vb3s
         Zy2S/Di3qjgmp9aCLbRo9odjbCsA9ByIpVyVoyl0KO2FGwt9BnVc/jn+3R/iNnjkmtFl
         kgOiHpC5uYbGh7zKTKmC1lACGob9OK4fpuYNo5+Bsu1fMhtmuKkphCfwCciE4V+FRKL2
         yZJJm/oxrKXldGjDYYrGYO1CXltkCHQYobG4DBYWv9+7rP6a9r7dgrpGOoRH6cGKYmRA
         m1vA==
X-Gm-Message-State: AOAM531jT4m/HcszVbAhdHxc+nzpkw7elWHfJsMJWYhDc3EzTCXDCuFA
        uWgC4lGtC/0bDhYK5zj/4Lm0xe6hMb5vSzJOreMsfIhJ
X-Google-Smtp-Source: ABdhPJyBz0jBzMa2nMYKm228ff0yu8NZjN7i2Z/l2AHysD7tXUljAB4QtS/+5uM1uF86sVxSkb09YhJRlM7x1p6lOTo=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr3977844oib.69.1616093846293;
 Thu, 18 Mar 2021 11:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210207224648.8137-1-colin.king@canonical.com>
In-Reply-To: <20210207224648.8137-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Mar 2021 19:57:14 +0100
Message-ID: <CAJZ5v0ix3iOwe=9X0_RiJ=FT_Qo2dJG14j2LuptK20H1mGYpsw@mail.gmail.com>
Subject: Re: [PATCH] PM / Domains: Fix integer overflows on u32 bit multiplies
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Titinger <mtitinger+renesas@baylibre.com>,
        Lina Iyer <lina.iyer@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Feb 7, 2021 at 11:47 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are three occurrances of u32 variables being multiplied by
> 1000 using 32 bit multiplies and the result being assigned to a
> 64 bit signed integer.  These can potentially lead to a 32 bit
> overflows, so fix this by casting 1000 to a UL first to force
> a 64 bit multiply hence avoiding the overflow.
>
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: 30f604283e05 ("PM / Domains: Allow domain power states to be read from DT")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/base/power/domain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index aaf6c83b5cf6..ddeff69126ff 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2831,10 +2831,10 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
>
>         err = of_property_read_u32(state_node, "min-residency-us", &residency);
>         if (!err)
> -               genpd_state->residency_ns = 1000 * residency;
> +               genpd_state->residency_ns = 1000UL * residency;

Wouldn't it be better to use NSEC_PER_USEC here and below?

>
> -       genpd_state->power_on_latency_ns = 1000 * exit_latency;
> -       genpd_state->power_off_latency_ns = 1000 * entry_latency;
> +       genpd_state->power_on_latency_ns = 1000UL * exit_latency;
> +       genpd_state->power_off_latency_ns = 1000UL * entry_latency;
>         genpd_state->fwnode = &state_node->fwnode;
>
>         return 0;
> --
> 2.29.2
>
