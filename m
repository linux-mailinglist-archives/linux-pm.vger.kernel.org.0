Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FBF3F9A02
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245435AbhH0NYi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245206AbhH0NYh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 09:24:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D28C0613D9
        for <linux-pm@vger.kernel.org>; Fri, 27 Aug 2021 06:23:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p38so14507672lfa.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Aug 2021 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVEdAtwasWkrT0f0vOq5zJOkTWOPwPdpExa1I7BhZtc=;
        b=lFI32R63zrucrYnkIqq6iE3qq5EeU910b9somn/1eHEmLa7lyPBVXEXSvUVfHZXljx
         TN6C7dFaRvGcV7OMzmM2Z702UqA21+p6LGiil3JBftn6N+xI5cU3ZZKXnuDMakUW+3aS
         2JJPsdBHzh/GUX+dBrwrAKurlt2KMRM3E29qSJusmZRW6Gkawk70f92avYnixl5DMoY0
         iRfhpFxvyjlDDWVaZC/SZpaBr+oTpnlorA3vhS0oFOUOseXOqeLPa/ulN1BaOmExMsz4
         lKUa8NlGjOIXU4SMK755TODSTf/PrplBh65Z7qev6Iz8YtvnlSlcHUfQ1X8DX7x1gssR
         KGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVEdAtwasWkrT0f0vOq5zJOkTWOPwPdpExa1I7BhZtc=;
        b=lxzS+x2+XA61SfdnlZLpLWAspephtpBPT9043E52M64vcYh2f302lDao3XNmq/33fH
         +W3zw2SEfLyi/fHdEr4Gil5/+wOiXw7oA6w0P+YUogqQppw8bgVuOxPORwFCsm+WPjV6
         CmT0caSS8sNyYzXFNReGHFqWUD5MeenpztRj42ldoQvgQ4LawflbecX01qJbn2rwtqoj
         TsJS7jo1p5rjGEkSSsyeZrH/dGOnXLGNQ240WrW7S8T9fkLHZiGRd6xwy9O4oUN/8kag
         8n6YKGC/zBJep5FXddjZK98zTx8aGohfoZrbUq60evuPIXVuSkszHDPG+QROFc8PB/BL
         K4KQ==
X-Gm-Message-State: AOAM530BTCqwbk9s2CbiVFjhyAdZYtqrS1yFaHZzf38v9uv9+OS8dU1w
        5vVD9c0GA9x7ARbwsdtxWqPMLXktmpjtqUKRkuibow==
X-Google-Smtp-Source: ABdhPJz8jK79D3e6Kay83LX5n+kuJqijB53HmFK7YA4ArgShByf4lqcNzK3GCZnShdgQPw2M6e8FYqwcpSmFFVEggjE=
X-Received: by 2002:a19:655e:: with SMTP id c30mr6648013lfj.142.1630070626804;
 Fri, 27 Aug 2021 06:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <4fb42fa1b76b38c6628f056cfd804bb5b4e74d99.1629818532.git.geert+renesas@glider.be>
In-Reply-To: <4fb42fa1b76b38c6628f056cfd804bb5b4e74d99.1629818532.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Aug 2021 15:23:10 +0200
Message-ID: <CAPDyKFrwxCH-AEDNnhwmoZ9aHZVzKw-=foo7F0mhMNLTCZxpYQ@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Fix domain attach for CONFIG_PM_OPP=n
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 24 Aug 2021 at 17:23, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> If CONFIG_PM_OPP=n, of_get_required_opp_performance_state() always
> returns -EOPNOTSUPP, and all drivers for devices that are part of a PM
> Domain fail to probe with:
>
>     failed to set required performance state for power-domain foo: -95
>     probe of bar failed with error -95
>
> Fix this by treating -EOPNOTSUPP the same as -ENODEV.
>
> Fixes: c016baf7dc58e77a ("PM: domains: Add support for 'required-opps' to set default perf state")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a10d740c4f2a1c28..7b197690e6442911 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2760,7 +2760,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>
>         /* Set the default performance state */
>         pstate = of_get_required_opp_performance_state(dev->of_node, index);
> -       if (pstate < 0 && pstate != -ENODEV) {
> +       if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
>                 ret = pstate;
>                 goto err;
>         } else if (pstate > 0) {
> --
> 2.25.1
>
