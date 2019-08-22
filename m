Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C01D4995F7
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfHVOKi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 10:10:38 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37063 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733186AbfHVOKi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 10:10:38 -0400
Received: by mail-vs1-f68.google.com with SMTP id q188so3932587vsa.4
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4qsaTLi2kYiuB1BsdFKQ6VHfpTMiAfISBukGRH2y18=;
        b=XYLV0EYiyYDc8s7d75ilZ8PjaHOndaLQTUE0E7ySTCaMwvG5dWLeTqVTqFcqHoJ0Qs
         ALlKvFqPNwpy8qCZijb7lDAn8DfCXm9O83FzPWLQ8gWKTk/HH5CroOe8VQ1SJFDlcN5O
         fvWr00oFdi5LUzSTZg3RtGE7PKRblpBcp5MuxRykoaA9RxAHjh+IvmKimqZI4Gk97tRX
         5LQ3AyDExqa9O+Oy36W4UWmmcGjFvMRnT5Kw3PNH5FbhKG/QDrRUUfN2Du8Wardq8ndH
         xYuvnqyLJP0vJ0VTPzYDDUyOOhJ1JfNVeF0UMAx4dJa6oqS/2eI/IirgWZH1G6kRuHtG
         lEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4qsaTLi2kYiuB1BsdFKQ6VHfpTMiAfISBukGRH2y18=;
        b=iPKx2/f7Yvsflv8acothWjNJrf/81cAvYS/ewWxtQAm1TZzQ3oDfFLhoB6L1b5f1A1
         Q9nL15coQiRX4ZYx0fHFqA0VyzwpXa0qRGyUp97P1LRP/4OXmP84WM3u1/urOf0xyNzm
         eJef6PIzXFrmGv3lNueUUwgtqW4LbgUp3YVFbRMZKMFjEou3ibuDJZWYFWAMzleRWckA
         aN54WpWAlpHxnisQqSzRNTvlHolRzLQtR4pmDV1SxLFCHPj8/683Jcn2j0f2gbjKuCN4
         tauzP9nfsBhjviCtDjFYM8d0wLrkyJAIve0y7J/hOT2KdcyPCXvciEjIfsgxgvJkz55U
         hosg==
X-Gm-Message-State: APjAAAUXwTadYR5RPwzUJemJHtApsGZSftKaOX08LG5Nk5YEzXR+lrBo
        OE9g4CsOARMN5/6o/XhntjZjDWROh3WQsSgV4NPpFA==
X-Google-Smtp-Source: APXvYqzWHLzJBoRyccWmyR+94+wWQB2KGb5t2+zjUNnXJGLYmtNfu/FkNMpdMoN5NRgOPYvF4jON5lAwZXA6GzPg3bw=
X-Received: by 2002:a67:e287:: with SMTP id g7mr24196946vsf.200.1566483037730;
 Thu, 22 Aug 2019 07:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190816124106.15383-1-geert+renesas@glider.be>
In-Reply-To: <20190816124106.15383-1-geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 16:10:01 +0200
Message-ID: <CAPDyKFpbEZLnBH-bQ=9zgWP7Xng1Ft+DRFu6zRov4tbm0yC0OA@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: rmobile-sysc: Set GENPD_FLAG_ALWAYS_ON for
 always-on domain
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 16 Aug 2019 at 14:41, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Currently the R-Mobile "always-on" PM Domain is implemented by returning
> -EBUSY from the generic_pm_domain.power_off() callback, and doing
> nothing in the generic_pm_domain.power_on() callback.  However, this
> means the PM Domain core code is not aware of the semantics of this
> special domain, leading to boot warnings like the following on
> SH/R-Mobile SoCs:
>
>     sh_cmt e6130000.timer: PM domain c5 will not be powered off
>
> Fix this by making the always-on nature of the domain explicit instead,
> by setting the GENPD_FLAG_ALWAYS_ON flag.  This removes the need for the
> domain to provide power control callbacks.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> To be queued in renesas-devel for v5.4.
>
>  drivers/soc/renesas/rmobile-sysc.c | 31 +++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmobile-sysc.c
> index 444c97f84ea5a76e..caecc24d5d68739c 100644
> --- a/drivers/soc/renesas/rmobile-sysc.c
> +++ b/drivers/soc/renesas/rmobile-sysc.c
> @@ -48,12 +48,8 @@ struct rmobile_pm_domain *to_rmobile_pd(struct generic_pm_domain *d)
>  static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
>  {
>         struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
> -       unsigned int mask;
> +       unsigned int mask = BIT(rmobile_pd->bit_shift);
>
> -       if (rmobile_pd->bit_shift == ~0)
> -               return -EBUSY;
> -
> -       mask = BIT(rmobile_pd->bit_shift);
>         if (rmobile_pd->suspend) {
>                 int ret = rmobile_pd->suspend();
>
> @@ -80,14 +76,10 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
>
>  static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd)
>  {
> -       unsigned int mask;
> +       unsigned int mask = BIT(rmobile_pd->bit_shift);
>         unsigned int retry_count;
>         int ret = 0;
>
> -       if (rmobile_pd->bit_shift == ~0)
> -               return 0;
> -
> -       mask = BIT(rmobile_pd->bit_shift);
>         if (__raw_readl(rmobile_pd->base + PSTR) & mask)
>                 return ret;
>
> @@ -122,11 +114,15 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
>         struct dev_power_governor *gov = rmobile_pd->gov;
>
>         genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
> -       genpd->power_off                = rmobile_pd_power_down;
> -       genpd->power_on                 = rmobile_pd_power_up;
> -       genpd->attach_dev               = cpg_mstp_attach_dev;
> -       genpd->detach_dev               = cpg_mstp_detach_dev;
> -       __rmobile_pd_power_up(rmobile_pd);
> +       genpd->attach_dev = cpg_mstp_attach_dev;
> +       genpd->detach_dev = cpg_mstp_detach_dev;
> +
> +       if (!(genpd->flags & GENPD_FLAG_ALWAYS_ON)) {
> +               genpd->power_off = rmobile_pd_power_down;
> +               genpd->power_on = rmobile_pd_power_up;
> +               __rmobile_pd_power_up(rmobile_pd);
> +       }
> +
>         pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
>  }
>
> @@ -270,6 +266,11 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
>                 break;
>
>         case PD_NORMAL:
> +               if (pd->bit_shift == ~0) {
> +                       /* Top-level always-on domain */
> +                       pr_debug("PM domain %s is always-on domain\n", name);
> +                       pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
> +               }
>                 break;
>         }
>
> --
> 2.17.1
>
