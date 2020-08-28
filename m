Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D332B2556B3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 10:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgH1Ioq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 04:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgH1Io1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 04:44:27 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19D0C061236
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 01:44:26 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v20so145502ual.4
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXt9Q9JzZETS81jIoUxLoqXvrTil078ywtA5O94Qp5M=;
        b=cZfQmQi9hWGwyYWZumY+UzKzIWhbwnbZ+WB0Mli8xkb71lhMQdCqMrDGQJVS8UPhgF
         kRw87kX+G6sHBiNxkMAUg+h57A+mdI2yeBNJvOiqr+BuHL+g4y7wjgulRsnswqQTK1eP
         Ryw1XedotPqnjH+mIoZ14gfz+U3ZhL6HAq1qZfrD997Zzv8dnTgUTQG+NH1O1Kuv9ECv
         lzrrRhXX4w7r2ck/Ci/TZLaQh7/5BTuWTX8Fe2OsV2Bg8Jt7ofsxiWCaPwLRmUPpROp2
         AUNJAjjwaD3Lw0PQwcFCtcZaiun5oJwGnQizJSkRduxHx5OIIKYPlNvF/7pOJBUc2VwZ
         k52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXt9Q9JzZETS81jIoUxLoqXvrTil078ywtA5O94Qp5M=;
        b=E9Mhvw7/Npv1zNJ7umYIhl3GxHHoKRKexujcaMtUQoMdpgCZFOfWZz6uVNuhyG5o3V
         PmVgOA5YtLScZ9C7DS2gYE36EGrmeuBsbw+INQCUDxo9ocoAh8j2BZkuFseqiI9tL753
         vIagZnVK+vlWB3Ldda+Ben+hY5Wd15BnajajrjVwwQ/7tpM+P2LmgqzJybBVLXHOOhcy
         XaKvWpTfIEfMjUpFJpxtixXRLq4HdqOMmhLLp1eFhIFEH7Ndm3rTjxfbZxFkdSWFIE6e
         sVG288dMDnuhj4rQH8JEdBl0gF73HEJ1xhk4has1x/lq7fc/vECqjpzYRtmpwH2ufEE9
         b8vg==
X-Gm-Message-State: AOAM530y7xCv7iACUwsBQI1pQuMy9K6pocl8UldUga7FhIS2X+fWjTOK
        fCo6802/RAHYE9z0zHbJ2bQkb7CJUQ5LOslnjNGNKA==
X-Google-Smtp-Source: ABdhPJwlsrZNGXcRdT6d1zKA0fBdobWfyrKc51R/SB46kVSG8V+qyZNKPtREddGXxPnciNO5n+yHrWSbHDynYCa9gNQ=
X-Received: by 2002:ab0:3114:: with SMTP id e20mr306035ual.104.1598604266122;
 Fri, 28 Aug 2020 01:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598594714.git.viresh.kumar@linaro.org> <1d7c97524b9e1fbc60271d9c246c5461ca8a106c.1598594714.git.viresh.kumar@linaro.org>
In-Reply-To: <1d7c97524b9e1fbc60271d9c246c5461ca8a106c.1598594714.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 10:43:50 +0200
Message-ID: <CAPDyKFpdZhzXQv3hpTzf3UkJDhFqBhgMXCqVfAfE6PejLCxvfg@mail.gmail.com>
Subject: Re: [PATCH V2 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 28 Aug 2020 at 08:08, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> find the OPP table with error -ENODEV (i.e. OPP table not present for
> the device). And we can call dev_pm_opp_of_remove_table()
> unconditionally here.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Replaced v1 with v2 on my next branch, thanks!

Just to be sure, this patch doesn't depend on any changes for the opp
core that are queued for v5.10?

Kind regards
Uffe



>
> ---
> V2:
> - Compare with -ENODEV only for failures.
> - Create new label to put clkname.
> ---
>  drivers/mmc/host/sdhci-msm.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5a33389037cd..f7beaec6412e 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -263,7 +263,6 @@ struct sdhci_msm_host {
>         unsigned long clk_rate;
>         struct mmc_host *mmc;
>         struct opp_table *opp_table;
> -       bool has_opp_table;
>         bool use_14lpp_dll_reset;
>         bool tuning_done;
>         bool calibration_done;
> @@ -2285,11 +2284,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>
>         /* OPP table is optional */
>         ret = dev_pm_opp_of_add_table(&pdev->dev);
> -       if (!ret) {
> -               msm_host->has_opp_table = true;
> -       } else if (ret != -ENODEV) {
> +       if (ret && ret != -ENODEV) {
>                 dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
> -               goto opp_cleanup;
> +               goto opp_put_clkname;
>         }
>
>         /* Vote for maximum clock rate for maximum performance */
> @@ -2453,8 +2450,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>                                    msm_host->bulk_clks);
>  opp_cleanup:
> -       if (msm_host->has_opp_table)
> -               dev_pm_opp_of_remove_table(&pdev->dev);
> +       dev_pm_opp_of_remove_table(&pdev->dev);
> +opp_put_clkname:
>         dev_pm_opp_put_clkname(msm_host->opp_table);
>  bus_clk_disable:
>         if (!IS_ERR(msm_host->bus_clk))
> @@ -2474,8 +2471,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>
>         sdhci_remove_host(host, dead);
>
> -       if (msm_host->has_opp_table)
> -               dev_pm_opp_of_remove_table(&pdev->dev);
> +       dev_pm_opp_of_remove_table(&pdev->dev);
>         dev_pm_opp_put_clkname(msm_host->opp_table);
>         pm_runtime_get_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> --
> 2.25.0.rc1.19.g042ed3e048af
>
