Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB243CD0E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242655AbhJ0PJY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbhJ0PJX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 11:09:23 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93322C061348
        for <linux-pm@vger.kernel.org>; Wed, 27 Oct 2021 08:06:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l2so5212880lji.6
        for <linux-pm@vger.kernel.org>; Wed, 27 Oct 2021 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eEeOc3SRoTkeXEKVHoRlTI3OBL2wUysOvGNTyGSpDRc=;
        b=vBrX1hroP2zBuvD1iKJmnG7LMigUVOYCCUjI8nNnhrOkTN5QjBm3VWoeIohRkK94mM
         0iA0f/MUpH4lU1LpX3SUAg9Qb9ffQA0/D8+lP5Yzp3hO1Oc/dXHRmqswxRuT9K08TkOO
         JxqtHG9LNOmuEPBOqsrakS8A/PnsDc4pWHFk4nsd1CWrbhV3CP6XgVEYZVsOFiX/FjzB
         9hgAWNpXsxKJufJeQdlXOK36M6tMtnDPGse1nNhXhUmjKb5V5lpoDBCxHytpfbgd1la/
         VwvSyqBmg75weHCA9Vnyf+aKIJjXvgL/syNjDNOWymJZFrIy8+prLwST1MBBhfHGFO6k
         aaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEeOc3SRoTkeXEKVHoRlTI3OBL2wUysOvGNTyGSpDRc=;
        b=3h2lWDy24Il9phknblLBxGbmUnZMUq6s7l/SY/PuPl+Uv6gZo94OlEYXGTol3GqGkK
         5RUp5YaC/Xwt8Txf+suQSWc4ptMz8L0pua/BtqXETsbBJS75TvzSYUD/ClawD3oOsM54
         Ot/VHPUiNeIvF8eJhpBZF+uuxn3yfSEmygc0uzt/jQvLgTbgq0tB+2OU4V0BNdKOByP1
         GydvTSojncYRXH0Wg9WqCY67mhHHoFGrjw9mOFHQ4yLbI6iuHaCPgmPOfDHlALWNbmGP
         QF+yrTyinoSLScb65iYyvhcO380mybWXPyJiorGgjqaDYWFlGxLDQEOq8186GnA4GmvD
         YlsA==
X-Gm-Message-State: AOAM532fjSr2eNed2juGUu+U1L5q7YtbxYhQZL5I4vjRzZMjCDA0h8z0
        AHlvZRxncijxCIsDFVAVL8+c4XPbipTOsceKWDiCWQ==
X-Google-Smtp-Source: ABdhPJysjKT4Qj/n7/ftR0oVtnZjTh7iTetwxvNQGH0ktAIGHoCGiRAbJE5llFkaZZ7c+ePHtcATzAPymmbQqNT848A=
X-Received: by 2002:a05:651c:11c4:: with SMTP id z4mr33240531ljo.463.1635347215604;
 Wed, 27 Oct 2021 08:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211025224032.21012-1-digetx@gmail.com> <20211025224032.21012-2-digetx@gmail.com>
In-Reply-To: <20211025224032.21012-2-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Oct 2021 17:06:19 +0200
Message-ID: <CAPDyKFr7VY73cQugSA5n-p_oXf43o1M-7s3-M+fnk0656h25UA@mail.gmail.com>
Subject: Re: [PATCH v14 01/39] soc/tegra: Enable runtime PM during OPP state-syncing
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 26 Oct 2021 at 00:45, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> GENPD core now can set up domain's performance state properly while device
> is RPM-suspended. Runtime PM of a device must be enabled during setup
> because GENPD checks whether device is suspended and check doesn't work
> while RPM is disabled. Instead of replicating the boilerplate RPM-enable
> code around OPP helper for each driver, let's make OPP helper to take care
> of enabling it.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Just a minor nitpick, see below. Nevertheless feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/tegra/common.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index cd33e99249c3..d930a2b4facc 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -10,6 +10,7 @@
>  #include <linux/export.h>
>  #include <linux/of.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_runtime.h>
>
>  #include <soc/tegra/common.h>
>  #include <soc/tegra/fuse.h>
> @@ -43,6 +44,7 @@ static int tegra_core_dev_init_opp_state(struct device *dev)
>  {
>         unsigned long rate;
>         struct clk *clk;
> +       bool rpm_enabled;
>         int err;
>
>         clk = devm_clk_get(dev, NULL);
> @@ -57,8 +59,22 @@ static int tegra_core_dev_init_opp_state(struct device *dev)
>                 return -EINVAL;
>         }
>
> +       /*
> +        * Runtime PM of the device must be enabled in order to set up
> +        * GENPD's performance properly because GENPD core checks whether
> +        * device is suspended and this check doesn't work while RPM is
> +        * disabled.
> +        */
> +       rpm_enabled = pm_runtime_enabled(dev);
> +       if (!rpm_enabled)
> +               pm_runtime_enable(dev);

This makes sure the OPP vote below gets cached in genpd for the
device. Instead, the vote is done the next time the device gets
runtime resumed.

I don't have an issue doing it like this, but at the same time it does
remove some flexibility for the drivers/subsystem that calls
tegra_core_dev_init_opp_state().

Isn't it better to leave this to be flexible - or you prefer to have
it done like this for everybody?

> +
>         /* first dummy rate-setting initializes voltage vote */
>         err = dev_pm_opp_set_rate(dev, rate);
> +
> +       if (!rpm_enabled)
> +               pm_runtime_disable(dev);
> +
>         if (err) {
>                 dev_err(dev, "failed to initialize OPP clock: %d\n", err);
>                 return err;

Kind regards
Uffe
